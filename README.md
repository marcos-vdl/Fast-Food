# FastFood System 🍔

Sistema de pedidos completo para fast food — Next.js + Supabase.

## Estrutura

```
app/
  pedido/     → Tela de pedidos (garçom/caixa)
  cozinha/    → Painel da cozinha (tempo real)
  admin/      → Gerenciar produtos, adicionais, histórico
utils/supabase/ → Clientes Supabase (browser + server)
lib/types.ts    → Tipos TypeScript
```

## Passo a passo para colocar no ar

### 1. Banco de dados (Supabase)

1. Acesse https://supabase.com e crie um projeto
2. No menu lateral, vá em **SQL Editor**
3. Cole o conteúdo de `supabase_setup.sql` e clique em **Run**
4. Vá em **Project Settings → API** e copie a URL e a anon key

### 2. Rodar localmente

```bash
# Instalar dependências
npm install

# Rodar em desenvolvimento
npm run dev
```

Acesse http://localhost:3000

### 3. Deploy na Vercel (gratuito)

1. Crie conta em https://vercel.com
2. Instale a CLI: `npm i -g vercel`
3. Na pasta do projeto: `vercel`
4. Siga as instruções e adicione as variáveis de ambiente:
   - `NEXT_PUBLIC_SUPABASE_URL`
   - `NEXT_PUBLIC_SUPABASE_PUBLISHABLE_DEFAULT_KEY`

Ou faça via GitHub:
1. Suba o projeto para um repositório no GitHub
2. Na Vercel, clique em "Import Project" → selecione o repo
3. Adicione as variáveis de ambiente e clique em Deploy

## Telas

| Tela | URL | Uso |
|------|-----|-----|
| Pedidos | /pedido | Garçom registra pedido por mesa |
| Cozinha | /cozinha | Cozinheiro vê e avança pedidos |
| Admin | /admin | Gerenciar produtos e ver histórico |

## Funcionalidades

- ✅ Seleção de mesa
- ✅ Cardápio por categoria
- ✅ Adicionais por produto
- ✅ Observações por item
- ✅ Carrinho com múltiplos itens
- ✅ Pedidos salvos no Supabase
- ✅ Cozinha em tempo real (Supabase Realtime)
- ✅ Kanban: Novo → Preparando → Pronto → Entregue
- ✅ Mesa libera automaticamente após entrega
- ✅ Admin: cadastro de produtos e adicionais
- ✅ Histórico de pedidos
