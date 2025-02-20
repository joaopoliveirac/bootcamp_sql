1-- Crie uma CTE chamada us_customers para listar todos os clientes que são dos Estados Unidos (Country = 'USA'). Depois, use essa CTE para selecionar os nomes dos clientes e suas cidades.
--Desafio: Modifique a consulta para contar quantos clientes existem em cada cidade nos EUA.
with us_customers as (
select 
	customer_id,contact_name,city
from customers
where country = 'USA'
)
select count(customer_id), city from US_CUSTOMERS
group by city
2-- Crie uma CTE chamada recent_orders para selecionar todos os pedidos (orders) feitos após 1º de janeiro de 1997. Depois, exiba o orderid, customerid e orderdate.
--Desafio: Modifique a consulta para contar quantos pedidos foram feitos por cada cliente após essa data.
with recent_orders as (
select count(order_id),customer_id
from 
	orders
where required_date > '1997-01-01'
group by customer_id
)
select * from recent_orders

3--Crie uma CTE chamada avg_price que calcula o preço médio dos produtos. Depois, exiba os produtos (productname) cujo preço seja maior que a média.
--Desafio: Adicione uma coluna mostrando o percentual de diferença entre o preço do produto e a média.
WITH avg_price AS (
    SELECT AVG(unit_price) AS media_geral
    FROM products
)
SELECT product_name, unit_price,media_geral
FROM products, avg_price
WHERE unit_price > media_geral;


4--Crie uma CTE chamada customer_orders que conta o número de pedidos por cliente. Depois, exiba os top 5 clientes com mais pedidos.
--Modifique a consulta para exibir também o nome da empresa (companyname) da tabela customers.
with customer_orders as (
select customer_id, count(customer_id) as qtde_pedido from orders
group by customer_id
)
select 
	co.customer_id, co.qtde_pedido, c.company_name 
from customer_orders co
join customers c
on co.customer_id = c.customer_id
order by co.qtde_pedido desc
limit 5


5--Crie uma CTE chamada product_sales que calcula o número total de unidades vendidas para cada produto (productid). Depois, exiba os top 10 produtos mais vendidos.
--Desafio: Adicione uma coluna mostrando o total de receita gerado (unitprice * quantity).
with product_sales as (
select 
	product_id, sum(unit_price * quantity) as faturamento,sum(quantity) as qtde_vendida
from order_details 
group by product_id
)
select * from product_sales
order by qtde_vendida desc
limit 10

6--Crie uma CTE chamada monthly_sales que calcula o faturamento total de pedidos por mês (orderdate).
--Desafio: Modifique a consulta para exibir apenas os meses com faturamento acima de $50.000.
with monthly_sales as (
select 
	extract(year from o.order_date) as ano, extract(month from o.order_date) as mes,sum(od.unit_price * od.quantity) as faturamento
from orders o
join order_details od on od.order_id = o.order_id
group by ano, mes
)
select * from monthly_sales 
where faturamento > 50000
order by ano,mes

7--Crie uma CTE que exibe a média de valor dos pedidos por cliente, depois filtre apenas os clientes cujo valor médio do pedido seja superior a $500.
--Desafio: Adicione o país (country) do cliente e filtre apenas os clientes dos EUA.
WITH customer_avg_order_value AS (
    SELECT 
        o.customer_id,
        AVG(od.unit_price * od.quantity) AS avg_order_value
    FROM orders o
    JOIN order_details od ON od.order_id = o.order_id
    GROUP BY o.customer_id
)
SELECT 
    c.customer_id,
    c.company_name,
    c.country,
    cao.avg_order_value
FROM customer_avg_order_value cao
JOIN customers c ON cao.customer_id = c.customer_id
WHERE cao.avg_order_value > 500
  AND c.country = 'USA'
ORDER BY cao.avg_order_value DESC;



