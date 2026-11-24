# Clinnie — Portal do projeto
1. Crie um projeto Supabase exclusivo para este portal.
2. Execute schema.sql no SQL Editor de um projeto novo (uma vez).
3. Em Authentication > Providers / configurações de autenticação, desabilite novos cadastros públicos. Crie contas manualmente em Authentication > Users, com e-mail confirmado.
4. Em config.js, preencha URL do projeto e chave anon/publicável. Nunca utilize service_role ou chave secreta no navegador.
5. Publique os arquivos HTML, CSS e JS em hospedagem estática HTTPS. Não publique schema.sql se não desejar expor o esquema. Para teste local, execute `python -m http.server 8000` na pasta e acesse localhost:8000.
6. Coloque o logotipo oficial como logo.svg na pasta. O fallback é uma marca tipográfica provisória. Ajuste as cores no CSS conforme tokens oficiais.

Todos os usuários autenticados neste Supabase dedicado têm acesso compartilhado às tarefas, comentários e anexos; não há papéis diferenciados. Arquivos ficam em bucket privado, limite 20 MB. O progresso usa tarefas concluídas / total, sem ponderação. O roadmap representa semanas relativas, não datas de calendário. Arraste cartões no desktop; em telas touch, abra o cartão e altere o status. Não há cadastro público na interface.

Validação: sintaxe JS verificada localmente; autenticação, persistência, realtime e políticas precisam de teste em um Supabase configurado antes de uso com o cliente. A biblioteca Supabase é carregada via CDN e requer internet. Não há ambiente de produção conectado neste pacote.
