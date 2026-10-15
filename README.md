# Baby Cure v8 — Supabase Bridge

This build replaces the demo admin/demo123 login with Supabase Auth and connects core Patients/Admissions/Charges/Payments reads plus new NICU admission creation to the Supabase schema.

## First launch
1. Open the app.
2. Tap إعداد Supabase.
3. Paste Project URL and the Publishable/anon key (never service_role).
4. Sign in with the Auth user created in Supabase.

Use fictional/test data until RLS and workflows are validated.


Supabase project URL and browser-safe publishable key are preconfigured in this build. Never add a secret/service_role key to the frontend.
