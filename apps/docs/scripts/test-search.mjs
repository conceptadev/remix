import assert from 'node:assert/strict';
import { readFile } from 'node:fs/promises';
import test from 'node:test';

const origin = process.env.DOCS_TEST_URL ?? 'http://localhost:3000';
const { sidebar } = JSON.parse(await readFile(new URL('../../../docs.json', import.meta.url), 'utf8'));
async function search(query, limit) {
  const url = new URL('/api/search', origin);
  url.searchParams.set('query', query);
  if (limit !== undefined) url.searchParams.set('limit', limit);
  const response = await fetch(url);
  assert.equal(response.status, 200);
  return response.json();
}

for (const page of sidebar.flatMap(group => group.pages).filter(page => page.href.startsWith('/components/'))) {
  test(`component name finds ${page.title} first`, async () => {
    const results = await search(page.title);
    assert.equal(results[0]?.url, page.href);
    assert.equal(new Set(results.map(result => result.url)).size, results.length);
  });
}

test('keywords find the TextField page', async () => {
  assert.equal((await search('text field'))[0]?.url, '/components/textfield');
});
test('body queries retain guide section links', async () => {
  assert.ok((await search('dry-run')).some(result => result.url.startsWith('/open-code#')));
});
test('empty and unknown queries have no results', async () => {
  for (const query of ['', '   ', 'zzznosuchcomponent']) assert.deepEqual(await search(query), []);
});
test('limits bound both page and section results', async () => {
  assert.equal((await search('button', 1)).length, 1);
  assert.deepEqual(await search('button', 0), []);
  assert.deepEqual(await search('button', -1), []);
});
