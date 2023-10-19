-- Создаем таблицу Sales
CREATE TABLE IF NOT EXISTS sales (
    category String,
    order_date Date,
    revenue Float64,
    cumulative_revenue Float64,
    cumulative_orders UInt32,
    average_check Float64,
    max_avg_check_date Date,
    max_avg_check_value Float64
) ENGINE = MergeTree()
ORDER BY (category, order_date);

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
    cumulative_revenue / cumulative_orders AS average_check
FROM
    (SELECT
        category,
        order_date,
        sum(revenue) OVER (PARTITION BY category ORDER BY order_date) as cumulative_revenue,
        sum(orders) OVER (PARTITION BY category ORDER BY order_date) as cumulative_orders
    FROM
        sales
    ORDER BY
        category, order_date) as subquery
ORDER BY
    category, order_date;



--Определение даты максимального среднего чека:
--Найдите дату, на которой был достигнут максимальный средний чек для каждой категории товаров, а также значение этого максимального среднего чека.
SELECT 
    category, 
    order_date as max_avg_check_date, 
    average_check as max_avg_check_value
FROM 
    (SELECT 
        category, 
        order_date, 
        cumulative_revenue / cumulative_orders as average_check, 
        RANK() OVER (PARTITION BY category ORDER BY cumulative_revenue / cumulative_orders DESC) as rnk
    FROM 
        (SELECT 
            category, 
            order_date, 
            sum(revenue) OVER (PARTITION BY category ORDER BY order_date) as cumulative_revenue, 
            sum(orders) OVER (PARTITION BY category ORDER BY order_date) as cumulative_orders 
        FROM 
            sales
        ORDER BY 
            category, order_date) as subquery
    ORDER BY 
        category, order_date) as subquery2
WHERE 
    rnk = 1
ORDER BY 
    category;
