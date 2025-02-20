--1. Total de pedidos por cliente
--Liste o nome dos clientes, o número total de pedidos realizados por cada um e o valor total desses pedidos.
--Tabelas: customers, orders, order_details.

select c.customer_id as id_cliente, c.contact_name as nome_cliente,count(distinct o.order_id) as numero_de_pedidos, sum(od.unit_price * od.quantity) as preco
from customers c
left join orders o on c.customer_id = o.customer_id
left join order_details od on o.order_id = od.order_id
group by c.customer_id
order by numero_de_pedidos desc

--2. Produtos mais vendidos por categoria
--Encontre os produtos mais vendidos em cada categoria (baseado na quantidade total pedida).
--Tabelas: categories, products, order_details.

select p.product_id as id_produto, p.product_name as nome_produto, c.category_name as categoria, sum(od.quantity) as quantidade
from products p
left join categories c on p.category_id = c.category_id
left join order_details od on p.product_id = od.product_id
group by p.product_id, c.category_name
order by categoria, quantidade desc

--3. Faturamento por fornecedor
--Calcule o faturamento total gerado por cada fornecedor.
--Tabelas: suppliers, products, order_details.

select s.supplier_id as id_fornecedor, s.contact_name as nome_fornecedor, sum(od.quantity * p.unit_price) faturamento
from suppliers s
left join products p on s.supplier_id = p.supplier_id
left join order_details od on od.product_id = p.product_id
group by s.supplier_id, s.contact_name

--4. Pedidos por funcionário
--Liste os funcionários com o número total de pedidos processados e a média do valor total dos pedidos que eles gerenciaram.
--Tabelas: employees, orders, order_details.

select e.employee_id as id_funcionario, e.first_name as nome, count(distinct o.order_id) as numero_de_pedido, sum(od.quantity * od.unit_price) 
from employees e
left join orders o on e.employee_id = o.employee_id
left join order_details od on o.order_id = od.order_id
group by e.employee_id, e.first_name
order by numero_de_pedido desc

--5. Faturamento mensal por ano
--Mostre o faturamento total para cada mês e ano.
--Tabelas: orders, order_details.
select * from orders
select * from order_details

select extract(year from o.order_date) as ano, extract(month from o.order_date) as mes, sum(od.quantity * od.unit_price) as faturamento,
from orders o
left join order_details od on o.order_id = od.order_id
group by ano, mes
order by ano, mes

--6. Clientes que mais compraram
--Liste os 5 clientes que gastaram mais dinheiro em pedidos.
--Tabelas: customers, orders, order_details.

select c.customer_id as id_cliente, sum(od.quantity * od.unit_price) as total
from customers c
left join orders o on c.customer_id = o.customer_id
left join order_details od on o.order_id = od.order_id
group by id_cliente
having sum(od.quantity * od.unit_price) > 0
order by total desc
limit 5

--7. Categorias mais lucrativas
--Descubra quais categorias geraram mais receita total.
--Tabelas: categories, products, order_details.

select c.category_id, c.category_name as nome_categoria, sum(od.quantity * od.unit_price) as receita_total
from categories c
left join products p on p.category_id = c.category_id
left join order_details od on p.product_id = od.product_id
group by c.category_id, nome_categoria
order by receita_total desc

--8. Pedidos atrasados
--Liste os pedidos que foram entregues com atraso e o tempo médio de atraso (em dias) por funcionário.
--Tabelas: orders, employees.


--9. Clientes que compraram mais de X vezes
--Liste os clientes que realizaram mais de 5 pedidos.
--Tabelas: customers, orders.

select c.customer_id as id_cliente, count(o.order_id) as qtde_pedido
from customers c
inner join orders o on c.customer_id = o.customer_id
group by id_cliente
having count(o.customer_id) > 5
order by qtde_pedido desc

--10. Produtos nunca vendidos
--Encontre os produtos que nunca foram vendidos.
--Tabelas: products, order_details.

SELECT p.product_id, p.product_name
FROM products p
LEFT JOIN order_details od ON p.product_id = od.product_id
WHERE od.product_id IS NULL;








