Baby Cure v1.4.2 — Permissions Fix

1) Run Baby-Cure-v1.4.2-Permissions-Fix.sql once in Supabase SQL Editor.
2) Upload all files in this folder to the same deployment, replacing index.html and keeping the PWA files.
3) Sign in as Admin, open Users & Permissions, edit a Doctor/Nurse permissions, and save.

This build keeps the v1.4.1 PWA behavior and changes permission saving to an Admin-only Supabase RPC instead of direct UPDATE on profiles.
