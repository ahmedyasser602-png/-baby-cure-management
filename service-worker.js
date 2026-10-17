// Baby Cure PWA service worker.
// Intentionally no Cache Storage: patient/application data is always requested from the network.
self.addEventListener('install', () => self.skipWaiting());
self.addEventListener('activate', event => event.waitUntil(self.clients.claim()));
self.addEventListener('fetch', () => {});
