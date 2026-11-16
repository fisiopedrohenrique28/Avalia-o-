-- Tabela usada pelo index.html. Rode uma vez no SQL Editor do Supabase.
create table if not exists public.registros (
  user_id uuid not null default auth.uid() references auth.users(id) on delete cascade,
  id text not null,
  dados jsonb not null,
  atualizado_em timestamptz not null default now(),
  primary key (user_id, id)
);

alter table public.registros enable row level security;

create policy "dono le" on public.registros for select to authenticated
  using ((select auth.uid()) = user_id);
create policy "dono insere" on public.registros for insert to authenticated
  with check ((select auth.uid()) = user_id);
create policy "dono altera" on public.registros for update to authenticated
  using ((select auth.uid()) = user_id) with check ((select auth.uid()) = user_id);
create policy "dono apaga" on public.registros for delete to authenticated
  using ((select auth.uid()) = user_id);

-- Mantém atualizado_em em dia a cada alteração.
create or replace function public.tocar_atualizado_em()
returns trigger language plpgsql as $$
begin
  new.atualizado_em := now();
  return new;
end $$;

drop trigger if exists registros_atualizado_em on public.registros;
create trigger registros_atualizado_em
  before update on public.registros
  for each row execute function public.tocar_atualizado_em();
