-- Baby Cure v1.5.0 Clinical Profiles / 3-hour NICU Care / Growth
begin;
create table if not exists public.outpatient_patients (
 id uuid primary key default gen_random_uuid(), patient_code text unique,
 child_name_ar text not null, primary_phone text not null, date_of_birth date,
 sex text check (sex in ('male','female')), current_weight_kg numeric(7,2),
 drug_allergies text, medical_history text, created_by uuid references auth.users(id),
 created_at timestamptz not null default now(), updated_at timestamptz not null default now()
);
create sequence if not exists public.outpatient_patient_code_seq start 1001;
create or replace function public.set_outpatient_patient_code() returns trigger language plpgsql security definer set search_path=public as $$begin if new.patient_code is null then new.patient_code:='OP-'||lpad(nextval('public.outpatient_patient_code_seq')::text,6,'0'); end if; return new; end$$;
drop trigger if exists trg_outpatient_patient_code on public.outpatient_patients;
create trigger trg_outpatient_patient_code before insert on public.outpatient_patients for each row execute function public.set_outpatient_patient_code();
alter table public.outpatient_visits add column if not exists outpatient_patient_id uuid references public.outpatient_patients(id) on delete cascade;
alter table public.outpatient_visits add column if not exists history text;
alter table public.outpatient_visits add column if not exists weight_kg numeric(7,2);
alter table public.outpatient_visits add column if not exists length_cm numeric(6,2);
alter table public.outpatient_visits add column if not exists head_circumference_cm numeric(6,2);
create table if not exists public.growth_measurements (
 id uuid primary key default gen_random_uuid(), patient_id uuid references public.patients(id) on delete cascade,
 outpatient_patient_id uuid references public.outpatient_patients(id) on delete cascade, measured_at timestamptz not null default now(),
 weight_g numeric(8,2), length_cm numeric(6,2), head_circumference_cm numeric(6,2), recorded_by uuid references auth.users(id), created_at timestamptz not null default now(),
 check (patient_id is not null or outpatient_patient_id is not null)
);
create table if not exists public.nicu_cares (
 id uuid primary key default gen_random_uuid(), admission_id uuid not null references public.admissions(id) on delete cascade,
 care_at timestamptz not null, weight_g numeric(8,2), temperature_c numeric(4,1), heart_rate int, respiratory_rate int, spo2 numeric(5,2),
 glucose_mg_dl numeric(7,2), feeds text, respiratory_support text, intake_ml numeric(10,2) default 0, urine_ml numeric(10,2) default 0, notes text,
 created_by uuid references auth.users(id), created_at timestamptz not null default now()
);
create index if not exists idx_op_patient_search_name on public.outpatient_patients(lower(child_name_ar));
create index if not exists idx_op_patient_phone on public.outpatient_patients(primary_phone);
create index if not exists idx_growth_patient_at on public.growth_measurements(patient_id,measured_at);
create index if not exists idx_cares_admission_at on public.nicu_cares(admission_id,care_at);
alter table public.outpatient_patients enable row level security; alter table public.growth_measurements enable row level security; alter table public.nicu_cares enable row level security;
drop policy if exists "admin outpatient patients" on public.outpatient_patients; create policy "admin outpatient patients" on public.outpatient_patients for all to authenticated using(public.is_admin()) with check(public.is_admin());
drop policy if exists "clinical growth read" on public.growth_measurements; create policy "clinical growth read" on public.growth_measurements for select to authenticated using(true);
drop policy if exists "clinical growth insert" on public.growth_measurements; create policy "clinical growth insert" on public.growth_measurements for insert to authenticated with check(exists (select 1 from public.profiles p where p.id=auth.uid() and p.is_active=true and p.role in ('admin','doctor','nurse')));
drop policy if exists "clinical cares read" on public.nicu_cares; create policy "clinical cares read" on public.nicu_cares for select to authenticated using(true);
drop policy if exists "clinical cares insert" on public.nicu_cares; create policy "clinical cares insert" on public.nicu_cares for insert to authenticated with check(exists (select 1 from public.profiles p where p.id=auth.uid() and p.is_active=true and p.role in ('admin','doctor','nurse')));
-- Lock the legacy outpatient visit table to admins only for this module.
drop policy if exists "operational read outpatient" on public.outpatient_visits; drop policy if exists "doctor admin reception create outpatient" on public.outpatient_visits; drop policy if exists "doctor admin update outpatient" on public.outpatient_visits;
drop policy if exists "admin outpatient visits all" on public.outpatient_visits; create policy "admin outpatient visits all" on public.outpatient_visits for all to authenticated using(public.is_admin()) with check(public.is_admin());
commit;
