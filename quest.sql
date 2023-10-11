-- Расчет кумулятивной выручки:
--Для каждой категории товаров (category) вычислите кумулятивную выручку на каждый день. Это означает, что для каждой даты вам нужно будет посчитать сумму выручки для данной категории товаров на эту дату и для всех предыдущих дат.
SELECT
    category,
    order_date,
    revenue,
    SUM(revenue) OVER (PARTITION BY category ORDER BY order_date) AS cumulative_revenue
FROM sales
--В этом запросе мы используем оконную функцию SUM, чтобы вычислить кумулятивную выручку для каждой категории товаров на каждый день. 

--Расчет среднего чека:
--Для каждой категории товаров на каждый день вычислите средний чек, который равен кумулятивной выручке на этот день, поделенной на кумулятивное количество заказов на этот день.
SELECT
    category,
    order_date,
    revenue,
    cumulative_revenue / cumulative_orders AS average_check
FROM (
    SELECT
        category,
        order_date,
        revenue,
        cumulative_revenue,
        SUM(1) OVER (PARTITION BY category ORDER BY order_date) AS cumulative_orders
    FROM sales
) AS subquery
--Здесь мы сначала создаем подзапрос, который вычисляет кумулятивное количество заказов для каждой категории товаров на каждый день с использованием оконной функции SUM.
--Затем мы делаем деление кумулятивной выручки на кумулятивное количество заказов, чтобы получить средний чек.

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
--В этом запросе мы сначала выполняем предыдущий запрос для расчета среднего чека и затем используем GROUP BY для нахождения даты максимального среднего чека и его значения для каждой категории товаров.