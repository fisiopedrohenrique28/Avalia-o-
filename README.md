# Avaliação Funcional de MMII

Ficha de avaliação funcional de membros inferiores, painel de resultados e prontuário, em um único arquivo (`index.html`). Os dados ficam no Supabase, e cada fisioterapeuta logado vê só os próprios registros.

## Configuração

1. No Supabase, abra **SQL Editor** e rode `supabase.sql`. Se a tabela `registros` já existir, rode só a parte do trigger e, se quiser, recrie as policies.
2. Em **Authentication › Providers**, deixe **Email** ativado. Se não quiser confirmar o e-mail no cadastro, desligue *Confirm email*.
3. Abra o `index.html` (ou publique no GitHub Pages) e, no card **Conta na nuvem**, informe:
   - **Project URL**: `https://<projeto>.supabase.co`
   - **Chave anon / publishable**, em *Project Settings › API*. Nunca use a `service_role`.

   Para não digitar isso em cada aparelho, preencha `SUPABASE_URL` e `SUPABASE_ANON_KEY` no fim do `index.html`. A chave anon é pública por design, e quem protege os dados é o RLS.
4. Crie a conta (e-mail e senha) e entre.

## Como os dados são guardados

Cada avaliação ou evolução vira uma linha em `public.registros`: `id` é o id do registro e `dados` guarda o objeto JSON completo. Sem login, o app continua funcionando só no navegador (localStorage). Depois de entrar, o botão **Enviar N registro(s) deste navegador para a nuvem** migra o que já estava salvo localmente.

O backup em `.json` (exportar/importar) continua disponível.
