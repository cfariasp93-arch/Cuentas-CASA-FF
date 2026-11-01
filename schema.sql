-- Ejecutar en Supabase → SQL Editor solo si las tablas no existen.
-- Es idempotente: se puede correr más de una vez.

create table if not exists public.people (
  id int primary key default 1 check (id = 1),
  a  text not null,
  b  text not null
);

create table if not exists public.expenses (
  id         uuid primary key default gen_random_uuid(),
  type       text not null check (type in ('split','onlyA','onlyB','debtAB','debtBA','settle')),
  payer      text check (payer in ('a','b')),
  amount     numeric(14,2) not null check (amount > 0),
  descr      text not null default '',
  spent_on   date not null default current_date,
  created_at timestamptz not null default now()
);

-- Solo usuarios con sesión iniciada pueden leer y escribir.
alter table public.people   enable row level security;
alter table public.expenses enable row level security;

drop policy if exists "autenticados" on public.people;
create policy "autenticados" on public.people
  for all to authenticated using (true) with check (true);

drop policy if exists "autenticados" on public.expenses;
create policy "autenticados" on public.expenses
  for all to authenticated using (true) with check (true);

-- Tiempo real.
do $$ begin
  alter publication supabase_realtime add table public.people;
exception when duplicate_object then null; end $$;
do $$ begin
  alter publication supabase_realtime add table public.expenses;
exception when duplicate_object then null; end $$;

-- Que la API vea las tablas nuevas de inmediato.
notify pgrst, 'reload schema';
