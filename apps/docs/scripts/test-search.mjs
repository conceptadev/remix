import assert from 'node:assert/strict';
import { readFile } from 'node:fs/promises';
import { registerHooks } from 'node:module';
import test from 'node:test';

// Run the actual TypeScript browser client against the exported JSON, without a server.
registerHooks({ resolve(specifier, context, nextResolve) {
  if (specifier === './paths' && context.parentURL?.endsWith('/lib/search-client.ts')) specifier += '.ts';
  return nextResolve(specifier, context);
} });
const base = process.env.NEXT_PUBLIC_BASE_PATH ?? '/remix';
globalThis.fetch = async input => {
  const route = String(input);
  assert.ok(route.startsWith(base + '/api/'), `Search fetched outside the Pages mount: ${route}`);
  const data = await readFile(new URL('../out' + route.slice(base.length), import.meta.url), 'utf8');
  return new Response(data, { headers: { 'Content-Type': 'application/json' } });
};
const { searchClient } = await import('../lib/search-client.ts');
const { sidebar } = JSON.parse(await readFile(new URL('../../../docs.json', import.meta.url), 'utf8'));
for (const page of sidebar.flatMap(group => group.pages).filter(page => page.href.startsWith('/components/'))) {
  test(`component name finds ${page.title} first`, async () => {
    const results = await searchClient.search(page.title);
    assert.equal(results[0]?.url, page.href);
    assert.equal(new Set(results.map(result => result.url)).size, results.length);
    assert.ok(results.length <= 20);
  });
}
test('keywords find TextField', async () => assert.equal((await searchClient.search('text field'))[0]?.url, '/components/textfield'));
test('body queries retain guide section links', async () => assert.ok((await searchClient.search('dry-run')).some(result => result.url.startsWith('/open-code#'))));
test('empty and unknown queries return no results', async () => {
  for (const query of ['', '   ', 'zzznosuchcomponent']) assert.deepEqual(await searchClient.search(query), []);
});
test('an unavailable exported index reports a load failure', async () => {
  const { staticClient } = await import('fumadocs-core/search/client/orama-static');
  const fetchExport = globalThis.fetch;
  globalThis.fetch = async () => new Response('Not found', { status: 404 });
  try {
    await assert.rejects(staticClient({ from: '/missing-search.json' }).search('button'), /failed to fetch exported search indexes/);
  } finally {
    globalThis.fetch = fetchExport;
  }
});
