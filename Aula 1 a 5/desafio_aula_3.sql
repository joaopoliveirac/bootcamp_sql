-- 1. Cria um relatório para todos os pedidos de 1996 e seus clientes (152 linhas)

select contact_name as nome,ship_name as pedido, order_date as data_pedido
from orders o
left join customers c on o.customer_id = c.customer_id
where extract(year from o.order_date) = 1996

-- 2. Cria um relatório que mostra o número de funcionários e clientes de cada cidade que tem funcionários (5 linhas)
select e.city as cidade, count (distinct e.employee_id) as qtde_funcionario, count (c.customer_id) as qtde_cliente
from employees e
left join customers c
on e.city = c.city
group by e.city

-- 3. Cria um relatório que mostra o número de funcionários e clientes de cada cidade que tem clientes (69 linhas)
select c.city as cidade, count (e.employee_id) as qtde_funcionario, count (c.customer_id) as qtde_cliente
from customers c
left join employees e
on e.city = c.city
group by c.city
order by c.city

-- 4.Cria um relatório que mostra o número de funcionários e clientes de cada cidade (71 linhas)
select coalesce(e.city,c.city) as cidade, count(e.employee_id) as qtde_funcionarios, count(c.customer_id) as qtde_cliente
from customers c
full join employees e
on e.city = c.city
group by cidade
order by cidade

-- 5. Cria um relatório que mostra a quantidade total de produtos encomendados.
-- Mostra apenas registros para produtos para os quais a quantidade encomendada é menor que 200 (5 linhas)
select p.product_name as nome_produto, sum(o.quantity) as quantidade from
products p left join order_details o on p.product_id = o.product_id
group by p.product_name
having sum(o.quantity) < 200

-- 6. Cria um relatório que mostra o total de pedidos por cliente desde 31 de dezembro de 1996.
-- O relatório deve retornar apenas linhas para as quais o total de pedidos é maior que 15 (5 linhas)
select customer_id as cliente, count(customer_id) as qtde_pedido
from orders where order_date > '1996-12-31'
group by customer_id
having count(customer_id) > 15
order by qtde_pedido






