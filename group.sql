--1
SELECT
    category,
    COUNT(product_id) AS products_count
FROM Products
GROUP BY category;
--2
SELECT
    SUM(quantity * price_per_unit) AS total_revenue
FROM Order_Items;
--3
SELECT
    c.full_name,
    COUNT(o.order_id) AS orders_count
FROM Customers c
LEFT JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.full_name;
--4
SELECT
    AVG(order_total) AS average_check
FROM (
    SELECT
        o.order_id,
        SUM(oi.quantity * oi.price_per_unit) AS order_total
    FROM Orders o
    JOIN Order_Items oi ON o.order_id = oi.order_id
    GROUP BY o.order_id
) AS order_totals;
--5
SELECT
    status,
    COUNT(order_id) AS orders_count
FROM Orders
WHERE status IN ('Доставлен', 'В обработке', 'Отправлен')
GROUP BY status;
--6
SELECT
    category,
    COUNT(product_id) AS products_count
FROM Products
GROUP BY category
HAVING COUNT(product_id) > 1;
--7
SELECT
    c.full_name
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.full_name
HAVING COUNT(o.order_id) > 1;
--8
SELECT
    p.product_name,
    SUM(oi.quantity) AS total_sold
FROM Products p
JOIN Order_Items oi ON p.product_id = oi.product_id
GROUP BY p.product_id, p.product_name
ORDER BY total_sold DESC
LIMIT 1;