Baby Cure v1.4.1 PWA Fix

Base: exact working Baby Cure Production v1.3 index.html.
Only PWA metadata + service-worker registration were added. Existing app logic was not rewritten.

Upload ALL files in this folder to the same site root:
- index.html
- manifest.webmanifest
- service-worker.js
- apple-touch-icon.png
- icon-192.png
- icon-512.png

After deployment:
1. Open https://babycure.site in Safari and confirm login works first.
2. Delete the previous Home Screen shortcut/app if present.
3. Safari > Share > Add to Home Screen.

The service worker intentionally does not cache patient/application data.
