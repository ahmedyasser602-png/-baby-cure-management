Baby Cure v1.7.0

IMPORTANT ORDER:
1) Supabase > SQL Editor: run Baby-Cure-v1.7.0-Migration.sql once.
2) Deploy Baby-Cure-v1.7.0-OPD-Queue-Billing-PDF.html as index.html.
3) Test with Admin and Nurse accounts.

Included changes:
- Nursing OPD queue: child name, age, new/follow-up, clinic/NICU source, automatic queue number. No money shown in nursing UI.
- Admin OPD: same queue + "entered consultation" checkpoint + fees + date-range accounting report.
- Existing outpatient_accounts history is preserved and backfilled with queue order/status.
- Admin can adjust NICU final bill with a required reason; calculated bill remains visible.
- Nurse/doctor can open investigation attachments through signed URLs.
- NICU print/PDF waits for investigation images and includes image attachments in the printed PDF.

Note: PDF attachments that are themselves PDF files are listed by filename; uploaded image files are embedded visually.
