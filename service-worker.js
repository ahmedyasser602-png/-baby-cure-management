const CACHE='baby-cure-shell-v1';
const SHELL=['/manifest.webmanifest','/icon-192.png','/icon-512.png','/apple-touch-icon.png'];
self.addEventListener('install',event=>{event.waitUntil(caches.open(CACHE).then(c=>c.addAll(SHELL)));self.skipWaiting();});
self.addEventListener('activate',event=>{event.waitUntil(caches.keys().then(keys=>Promise.all(keys.filter(k=>k!==CACHE).map(k=>caches.delete(k)))));self.clients.claim();});
self.addEventListener('fetch',event=>{
  const req=event.request;
  if(req.method!=='GET') return;
  const url=new URL(req.url);
  if(url.origin!==self.location.origin) return; // never cache Supabase or other remote data
  if(req.mode==='navigate') { event.respondWith(fetch(req)); return; } // app HTML always network-first
  if(SHELL.includes(url.pathname)) event.respondWith(caches.match(req).then(r=>r||fetch(req)));
});
