// Retire the Flutter worker previously registered at /remix/. Without this
// update, returning visitors can keep seeing the cached catalog at the docs URL.
self.addEventListener('install', () => self.skipWaiting());
self.addEventListener('activate', event => {
  event.waitUntil((async () => {
    await self.registration.unregister();
    const clients = await self.clients.matchAll({ type: 'window' });
    await Promise.all(clients.map(client => client.navigate(client.url)));
  })());
});
