-- Расчет кумулятивной выручки:
--Для каждой категории товаров (category) вычислите кумулятивную выручку на каждый день. Это означает, что для каждой даты вам нужно будет посчитать сумму выручки для данной категории товаров на эту дату и для всех предыдущих дат.
SELECT
    category,
    order_date,
    revenue,
    SUM(revenue) OVER (PARTITION BY category ORDER BY order_date) AS cumulative_revenue
FROM sales

--Расчет среднего чека:
--Для каждой категории товаров на каждый день вычислите средний чек, который равен кумулятивной выручке на этот день, поделенной на кумулятивное количество заказов на этот день.
SELECT
    category,
    order_date,
    revenue,
    COUNT(*) OVER (PARTITION BY category ORDER BY order_date) AS cumulative_orders,
    SUM(revenue) OVER (PARTITION BY category ORDER BY order_date) / COUNT(*) OVER (PARTITION BY category ORDER BY order_date) AS average_check
FROM sales;

--Определение даты максимального среднего чека:
--Найдите дату, на которой был достигнут максимальный средний чек для каждой категории товаров, а также значение этого максимального среднего чека.
SELECT
    category,
    order_date AS max_avg_check_date,
    MAX(average_check) AS max_avg_check_value
FROM (
   SELECT
        category,
        order_date,
        revenue,
        cumulative_revenue,
        SUM(1) OVER (PARTITION BY category ORDER BY order_date) AS cumulative_orders
    FROM sales
) AS subquery
GROUP BY category
