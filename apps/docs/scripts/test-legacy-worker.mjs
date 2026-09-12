import assert from 'node:assert/strict';
import { readFile } from 'node:fs/promises';
import { runInNewContext } from 'node:vm';
import test from 'node:test';

test('old catalog worker retires and refreshes its controlled clients', async () => {
  const events = new Map();
  const calls = [];
  const url = 'https://conceptadev.github.io/remix/#/?path=components/button';
  const self = {
    addEventListener: (type, handler) => events.set(type, handler),
    skipWaiting: () => calls.push('skipWaiting'),
    registration: { unregister: async () => calls.push('unregister') },
    clients: { matchAll: async options => {
      assert.equal(options.type, 'window');
      assert.equal(options.includeUncontrolled, undefined);
      return [{ url, navigate: async next => calls.push(next) }];
    } },
  };
  runInNewContext(await readFile(new URL('../public/flutter_service_worker.js', import.meta.url), 'utf8'), { self });
  events.get('install')();
  let activated;
  events.get('activate')({ waitUntil: promise => activated = promise });
  await activated;
  assert.deepEqual(calls, ['skipWaiting', 'unregister', url]);
  assert.equal(events.has('fetch'), false);
});
