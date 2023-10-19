-- Расчет кумулятивной выручки:
--Для каждой категории товаров (category) вычислите кумулятивную выручку на каждый день. Это означает, что для каждой даты вам нужно будет посчитать сумму выручки для данной категории товаров на эту дату и для всех предыдущих дат.
SELECT
    category,
    order_date,
    sum(revenue) OVER (PARTITION BY category ORDER BY order_date) as cumulative_revenue
FROM sales
ORDER BY category, order_date;

--Расчет среднего чека:
--Для каждой категории товаров на каждый день вычислите средний чек, который равен кумулятивной выручке на этот день, поделенной на кумулятивное количество заказов на этот день.
SELECT 
    category,
    order_date,
    cumulative_revenue / cumulative_orders as average_check
FROM 
    (SELECT
        category,
        order_date,
        sum(revenue) as cumulative_revenue,
        sum(1) as cumulative_orders
    FROM sales
    GROUP BY category, order_date
    ORDER BY category, order_date)
ORDER BY category, order_date;


--Определение даты максимального среднего чека:
--Найдите дату, на которой был достигнут максимальный средний чек для каждой категории товаров, а также значение этого максимального среднего чека.
SELECT 
    category, 
    max_avg_check_date, 
    max(average_check) AS max_average_check
FROM 
    (SELECT 
        category, 
        order_date, 
        order_date AS max_avg_check_date, 
        cumulative_revenue / cumulative_orders AS average_check 
    FROM 
        (SELECT 
            category, 
            order_date, 
            sum(revenue) AS cumulative_revenue, 
            sum(1) AS cumulative_orders 
        FROM sales 
        GROUP BY category, order_date 
        ORDER BY category, order_date)
    )
GROUP BY category;
