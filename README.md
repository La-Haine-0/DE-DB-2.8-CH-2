# DE-DB-2.8-CH-2
### Задание:Расчет кумулятивной выручки и среднего чека по категориям товаров с использованием оконных функций
Вам нужно будет создать или использовать следующие поля в таблице:
- ategory (категория товара): Это поле будет содержать информацию о категории товара, по которой вы будете группировать данные.
- order_date (дата заказа): Это поле будет содержать дату каждого заказа.
- revenue (выручка): Это поле будет содержать сумму выручки для каждой продажи.
- cumulative_revenue (кумулятивная выручка): Это поле будет содержать результаты расчета кумулятивной выручки с использованием оконных функций.
- cumulative_orders (кумулятивное количество заказов): Это поле будет содержать кумулятивное количество заказов для каждой категории товаров.
- average_check (средний чек): Это поле будет содержать результаты расчета среднего чека с использованием оконных функций.
- max_avg_check_date (дата максимального среднего чека): Это поле будет содержать дату, на которой был достигнут максимальный средний чек.
- max_avg_check_value (значение максимального среднего чека): Это поле будет содержать значение максимального среднего чека для каждой категории товаров.
### Описание:
У вас есть таблица sales с данными о продажах товаров. Ваша задача — рассчитать кумулятивную выручку и средний чек для каждой категории товаров с использованием оконных функций ClickHouse. Это задание включает в себя следующие шаги:
- Расчет кумулятивной выручки:
Для каждой категории товаров (category) вычислите кумулятивную выручку на каждый день. Это означает, что для каждой даты вам нужно будет посчитать сумму выручки для данной категории товаров на эту дату и для всех предыдущих дат.
- Расчет среднего чека:
Для каждой категории товаров на каждый день вычислите средний чек, который равен кумулятивной выручке на этот день, поделенной на кумулятивное количество заказов на этот день.
- Определение даты максимального среднего чека:
Найдите дату, на которой был достигнут максимальный средний чек для каждой категории товаров, а также значение этого максимального среднего чека.
### Логика решения:
Файл sql-запросов предоставлен (<code>[./quest.sql](https://github.com/La-Haine-0/DE-DB-2.8-CH-2/blob/main/quest.sql)</code>)

 