BABY CURE v1.0 — PRODUCTION CANDIDATE
=====================================
Included in this consolidated build:
- Supabase Authentication and role-based navigation.
- Admin / Doctor / Nurse / Accountant / Reception workspaces.
- Doctor/Nurse land on Patients rather than Dashboard.
- Real user creation, activation/deactivation/delete controls.
- Logged-in staff attribution and name lookup.
- Patient Profile + Daily NICU + Medications/MAR + Investigations/files + Orders + Handover.
- Private Supabase Storage for investigation images/PDFs.
- Charges/payments and existing billing/report screens.
- Agreed billable-day SQL helper (24h / 4h / 12h).
- Audit triggers for core clinical and financial tables.
- Admin Audit Log viewer.
- Admin JSON backup export.
- Baby Cure transparent logo embedded in index.html.

INSTALL
1. Run Baby-Cure-v1.0-Production-Migration.sql once in Supabase SQL Editor.
2. Replace GitHub root index.html.
3. Do NOT use real patient data until the live acceptance test below passes.

LIVE ACCEPTANCE TEST (cannot be proven by static code inspection)
- Reception: create a fictional admission.
- Nurse: Daily Sheet, MAR, Investigation + image, Handover.
- Doctor: Order/Progress/respiratory change/discharge.
- Accountant: payment and billing visibility; no clinical edit access.
- Admin: audit log, reports, user disable/reactivate.
- Test logout/login and a second phone/browser.
- Verify private file access and that forbidden pages/actions fail for wrong roles.

NOTE
This is a production candidate, not a claim of regulatory/compliance certification.
Backups exported by the browser are convenience exports; Supabase project-level backups should also be configured separately.
