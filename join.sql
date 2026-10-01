-- Задание 1
SELECT
    c.full_name,
    o.order_date
FROM Customers c
INNER JOIN Orders o ON c.customer_id = o.customer_id;


-- Задание 2
SELECT
    c.full_name
FROM Customers c
LEFT JOIN Orders o ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;


-- Задание 3
SELECT
    p.product_name,
    oi.quantity,
    oi.price_per_unit
FROM Orders o
JOIN Order_Items oi ON o.order_id = oi.order_id
JOIN Products p ON oi.product_id = p.product_id
WHERE o.order_id = 1;


-- Задание 4
SELECT full_name
FROM Customers
WHERE customer_id IN (
    SELECT o.customer_id
    FROM Orders o
    WHERE o.order_id IN (
        SELECT oi.order_id
        FROM Order_Items oi
        WHERE oi.product_id IN (
            SELECT p.product_id
            FROM Products p
            WHERE p.product_name = 'Смартфон'
        )
    )
);


-- Задание 5
SELECT
    product_name,
    price
FROM Products
WHERE price > (
    SELECT AVG(price)
    FROM Products
);


-- Задание 6
SELECT
    o.order_id,
    o.order_date
FROM Orders o
WHERE EXISTS (
    SELECT 1
    FROM Order_Items oi
    JOIN Products p ON oi.product_id = p.product_id
    WHERE oi.order_id = o.order_id
      AND p.price > 100000
);


-- Задание 7.1
SELECT
    c.full_name
FROM Customers c
LEFT JOIN Orders o ON c.customer_id = o.customer_id
LEFT JOIN Order_Items oi ON o.order_id = oi.order_id
LEFT JOIN Products p ON oi.product_id = p.product_id
   AND p.product_name = 'Ноутбук'
GROUP BY c.customer_id, c.full_name
HAVING COUNT(p.product_id) = 0;


-- Задание 7.2
SELECT full_name
FROM Customers
WHERE customer_id NOT IN (
    SELECT o.customer_id
    FROM Orders o
    WHERE o.order_id IN (
        SELECT oi.order_id
        FROM Order_Items oi
        WHERE oi.product_id IN (
            SELECT p.product_id
            FROM Products p
            WHERE p.product_name = 'Ноутбук'
        )
    )
);


-- Задание 8
SELECT
    p.product_name
FROM Order_Items oi
RIGHT JOIN Products p ON oi.product_id = p.product_id
WHERE oi.product_id IS NULL;


-- Задание 9
SELECT
    c.full_name,
    p.product_name,
    oi.quantity
FROM Customers c
FULL OUTER JOIN Orders o ON c.customer_id = o.customer_id
FULL OUTER JOIN Order_Items oi ON o.order_id = oi.order_id
FULL OUTER JOIN Products p ON oi.product_id = p.product_id;


-- Задание 10.1
SELECT DISTINCT
    c.full_name
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
JOIN Order_Items oi ON o.order_id = oi.order_id
JOIN Products p ON oi.product_id = p.product_id
JOIN (
    SELECT MAX(price) AS max_price
    FROM Products
) max_product
    ON p.price = max_product.max_price;


-- Задание 10.2
SELECT full_name
FROM Customers
WHERE customer_id IN (
    SELECT customer_id
    FROM Orders
    WHERE order_id IN (
        SELECT order_id
        FROM Order_Items
        WHERE product_id IN (
            SELECT product_id
            FROM Products
            WHERE price = (
                SELECT MAX(price)
                FROM Products
            )
        )
    )
);


-- Задание 11
SELECT
    c.full_name,
    categories.category
FROM Customers c
CROSS JOIN (
    SELECT DISTINCT category
    FROM Products
) categories;


-- Задание 12
SELECT
    customer.full_name AS new_customer,
    recommender.full_name AS recommended_by
FROM Customers customer
JOIN Customers recommender ON customer.recommended_by = recommender.customer_id;

