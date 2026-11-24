-- Run in Supabase SQL editor once. Create users in Authentication > Users.
create table public.tasks (id uuid primary key default gen_random_uuid(), stage int not null check(stage between 1 and 6), title text not null, description text default '', status text not null default 'Backlog' check(status in ('Backlog','Em andamento','Em Aprovação','Ajustes','Concluído')), created_at timestamptz default now());
create table public.comments (id uuid primary key default gen_random_uuid(), task_id uuid references public.tasks on delete cascade not null, author uuid references auth.users not null default auth.uid(), author_label text not null, body text not null, created_at timestamptz default now());
create table public.attachments (id uuid primary key default gen_random_uuid(), task_id uuid references public.tasks on delete cascade not null, name text not null, path text not null unique, created_at timestamptz default now());
alter table public.tasks enable row level security;
alter table public.comments enable row level security;
alter table public.attachments enable row level security;
create policy "Project members read tasks" on public.tasks for select to authenticated using (true);
create policy "Project members create tasks" on public.tasks for insert to authenticated with check (true);
create policy "Project members update tasks" on public.tasks for update to authenticated using (true) with check (true);
create policy "Project members read comments" on public.comments for select to authenticated using (true);
create policy "Project members comment" on public.comments for insert to authenticated with check (author=auth.uid() and author_label=coalesce(auth.jwt()->>'email','Usuário'));
create policy "Project members read attachments" on public.attachments for select to authenticated using (true);
create policy "Project members attach" on public.attachments for insert to authenticated with check (true);
insert into storage.buckets(id,name,public,file_size_limit) values ('project-files','project-files',false,20971520);
create policy "Members download" on storage.objects for select to authenticated using(bucket_id='project-files');
create policy "Members upload" on storage.objects for insert to authenticated with check(bucket_id='project-files');
create policy "Members cleanup own uploads" on storage.objects for delete to authenticated using(bucket_id='project-files' and owner_id=auth.uid()::text);
alter publication supabase_realtime add table public.tasks, public.comments, public.attachments;
insert into public.tasks(stage,title,description) values
(1,'Imersão na plataforma','Inventário de recursos, diferenciais, público e referências visuais.'),(1,'Mapear site e cadastro','Registrar páginas, conteúdos e jornada atual.'),(2,'Avaliar experiência digital','Home, Produto, Recursos, Preços e cadastro; desktop, tablet e mobile.'),(2,'Relatório e matriz de prioridades','Evidências, recomendações e impacto.'),(3,'Organizar identidade visual','Logotipo, cores, tipografia e elementos gráficos.'),(3,'Brandbook','Consolidar diretrizes e exemplos em PDF.'),(4,'Arquitetura e hierarquia','Organização das quatro áreas e estratégia de CTAs.'),(4,'Jornada de conversão e wireframes','Captura antecipada de contato, teste grátis e redução de fricção.'),(5,'Redesign Home','Alta fidelidade e responsividade.'),(5,'Redesign Produto','Alta fidelidade e responsividade.'),(5,'Redesign Recursos','Alta fidelidade e responsividade.'),(5,'Redesign Preços','Alta fidelidade e responsividade.'),(5,'Melhorias no cadastro','Propostas para etapas prioritárias.'),(5,'Componentes e responsividade','Padronização dos componentes utilizados.'),(6,'Refinamento e handoff','Consolidar feedbacks, arquivos e orientações finais.');
