-- =============================================
-- FASTFOOD SYSTEM - Execute no SQL Editor do Supabase
-- =============================================

-- Categorias
create table if not exists categorias (
  id serial primary key,
  nome text not null unique
);

-- Produtos
create table if not exists produtos (
  id serial primary key,
  nome text not null,
  descricao text,
  preco numeric(10,2) not null,
  categoria_id int references categorias(id),
  ativo boolean default true,
  criado_em timestamptz default now()
);

-- Adicionais
create table if not exists adicionais (
  id serial primary key,
  nome text not null,
  preco numeric(10,2) not null,
  categoria_id int references categorias(id)
);

-- Mesas
create table if not exists mesas (
  id serial primary key,
  numero int not null unique,
  status text default 'livre' check (status in ('livre','ocupada'))
);

-- Pedidos
create table if not exists pedidos (
  id serial primary key,
  mesa_id int references mesas(id),
  status text default 'novo' check (status in ('novo','preparando','pronto','entregue')),
  total numeric(10,2) default 0,
  criado_em timestamptz default now()
);

-- Itens do pedido
create table if not exists itens_pedido (
  id serial primary key,
  pedido_id int references pedidos(id) on delete cascade,
  produto_id int references produtos(id),
  quantidade int not null default 1,
  preco_unit numeric(10,2) not null,
  observacao text
);

-- Adicionais escolhidos por item
create table if not exists itens_adicionais (
  id serial primary key,
  item_id int references itens_pedido(id) on delete cascade,
  adicional_id int references adicionais(id),
  preco_unit numeric(10,2) not null
);

-- =============================================
-- Dados iniciais
-- =============================================
insert into mesas (numero) values (1),(2),(3),(4),(5),(6),(7),(8)
  on conflict (numero) do nothing;

insert into categorias (nome) values
  ('Lanches'),('Bebidas'),('Acompanhamentos'),('Sobremesas')
  on conflict (nome) do nothing;

-- Produtos de exemplo
insert into produtos (nome, descricao, preco, categoria_id) values
  ('X-Burguer','Pão, hambúrguer 150g, queijo, alface, tomate', 22.90, 1),
  ('X-Bacon','Pão, hambúrguer, bacon crocante, cheddar', 27.90, 1),
  ('Frango Crispy','Frango empanado, maionese especial', 24.90, 1),
  ('Veggie Burger','Hambúrguer de grão-de-bico, molho verde', 23.90, 1),
  ('Coca-Cola','Lata 350ml', 7.90, 2),
  ('Suco Natural','Laranja, limão ou maracujá', 9.90, 2),
  ('Água Mineral','500ml gelada', 4.90, 2),
  ('Batata Frita','Porção com sal e catchup', 13.90, 3),
  ('Onion Rings','Cebola empanada crocante', 14.90, 3),
  ('Milk Shake','Chocolate, morango ou baunilha', 16.90, 4),
  ('Sundae','Sorvete com calda de chocolate', 11.90, 4)
  on conflict do nothing;

-- Adicionais de exemplo
insert into adicionais (nome, preco, categoria_id) values
  ('Bacon extra', 4.00, 1),
  ('Queijo duplo', 3.00, 1),
  ('Ovo frito', 2.50, 1),
  ('Cheddar', 3.50, 1),
  ('Molho especial', 1.50, 1)
  on conflict do nothing;

-- Habilitar realtime nas tabelas de pedidos
alter publication supabase_realtime add table pedidos;
alter publication supabase_realtime add table itens_pedido;
