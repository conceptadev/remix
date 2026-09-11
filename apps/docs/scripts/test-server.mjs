import assert from 'node:assert/strict';
import { spawn } from 'node:child_process';
import { once } from 'node:events';
import { cp, mkdtemp, rm } from 'node:fs/promises';
import { tmpdir } from 'node:os';
import { join } from 'node:path';
import { setTimeout as delay } from 'node:timers/promises';

const port = process.env.DOCS_TEST_PORT ?? '3430';
const origin = `http://127.0.0.1:${port}`;
// Run outside the checkout so missing traced dependencies cannot fall back
// to the app's development node_modules.
const isolated = await mkdtemp(join(tmpdir(), 'remix-docs-server-'));
await cp(new URL('../.next/standalone/', import.meta.url), isolated, { recursive: true, verbatimSymlinks: true });
const server = spawn(process.execPath, ['server.js'], {
  cwd: isolated,
  env: { ...process.env, HOSTNAME: '127.0.0.1', PORT: port },
  stdio: 'inherit',
});
const closed = once(server, 'exit');
let startupError;
server.on('error', error => { startupError = error; });
try {
  let ready = false;
  for (let attempt = 0; attempt < 60; attempt++) {
    if (startupError) throw startupError;
    if (server.exitCode !== null) throw new Error('Deployment server exited during startup');
    try { ready = (await fetch(origin)).ok; } catch {}
    if (ready) break;
    await delay(500);
  }
  assert.ok(ready, 'Deployment server did not become ready');
  for (const path of ['/components/button', '/fortal/catalog', '/previews/', '/previews/flutter_bootstrap.js', '/assets/favicon.png']) {
    assert.equal((await fetch(origin + path)).status, 200, path);
  }
  assert.equal((await fetch(origin + '/missing-page')).status, 404);
  const tests = spawn(process.execPath, ['--test', 'scripts/test-search.mjs'], {
    cwd: new URL('../', import.meta.url),
    env: { ...process.env, DOCS_TEST_URL: origin },
    stdio: 'inherit',
  });
  const [code] = await once(tests, 'exit');
  assert.equal(code, 0, 'Search regression checks failed against deployment');
} finally {
  server.kill('SIGTERM');
  await closed;
  await rm(isolated, { recursive: true, force: true });
}
