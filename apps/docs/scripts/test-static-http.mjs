import assert from 'node:assert/strict';
import { once } from 'node:events';
import { after, test } from 'node:test';
import { servePages } from './serve-pages.mjs';
const server = servePages().listen(0, '127.0.0.1');
await once(server, 'listening');
after(() => server.close());
const origin = `http://127.0.0.1:${server.address().port}`;
for (const path of ['/remix/', '/remix/components/button/', '/remix/tutorials/settings-screen/', '/remix/catalog/', '/remix/dashboard/']) {
  test(`direct request and refresh: ${path}`, async () => {
    for (let attempt = 0; attempt < 2; attempt++) {
      const response = await fetch(origin + path);
      assert.equal(response.status, 200);
      assert.match(response.headers.get('content-type'), /text\/html/);
      assert.ok((await response.text()).length > 500);
    }
  });
}
test('missing pages return the documentation 404', async () => {
  const response = await fetch(origin + '/remix/no-such-page/');
  assert.equal(response.status, 404);
  assert.match(await response.text(), /Page not found/);
});
test('mount redirects and static JSON/assets have usable content types', async () => {
  const response = await fetch(origin + '/remix?test=1', { redirect: 'manual' });
  assert.equal(response.status, 301);
  assert.equal(response.headers.get('location'), '/remix/?test=1');
  for (const [path, type] of [['api/search.json','application/json'], ['api/search-pages.json','application/json'], ['flutter_service_worker.js','text/javascript'], ['catalog/main.dart.js','text/javascript']]) {
    const asset = await fetch(origin + '/remix/' + path);
    assert.equal(asset.status, 200);
    assert.equal(asset.headers.get('content-type'), type);
    await asset.arrayBuffer();
  }
});
