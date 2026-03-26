SELECT  
      transaction_id,
      transaction_date,
      transaction_time,
      transaction_qty,
      store_id,
      store_location,
      product_id,
      unit_price,
      product_category,
      product_type,
      product_detail,

---Adding columns to enhance the table for better insights
Dayname(transaction_date) AS Day_name,
Monthname(transaction_date) AS Month_name,
Dayofmonth(transaction_date) AS Date_of_month,
CASE
    WHEN Dayname(transaction_date) IN ('sunday', 'satarday') THEN 'weekend'
    ELSE 'weekday'
    END AS Day_classification,

    ---New Column
CASE
    WHEN date_format(transaction_time, 'HH:MM:SS') BETWEEN '05:00:00' AND '08:59:59' THEN '01.Rush_hour'
    WHEN date_format(transaction_time, 'HH:MM:SS') BETWEEN '09:00:00' AND '11:59:59' THEN '02.Mid_day'
    WHEN date_format(transaction_time, 'HH:MM:SS') BETWEEN '12:00:00' AND '015:59:58' THEN '03.Afternoon'
    WHEN date_format(transaction_time, 'HH:MM:SS') BETWEEN '15:00:00' AND '18:59:58' THEN '05.Evening'
    ELSE '05.night'
    END AS Time_classification,

    ---Spend bucket


CASE
    WHEN (transaction_qty*unit_price) <=50 THEN '1.low_spend'
    WHEN (transaction_qty*unit_price) BETWEEN 51 AND 200  THEN '2.medium spend'
    WHEN (transaction_qty*unit_price) BETWEEN 201 AND 300 THEN '3.mureki'
    ELSE '4.Blesser'
    END AS spend_bucket,

    ---Revenue 07---

    transaction_qty*unit_price

FROM `workspace`.`default`.`bright_coffee_shop_sales_data`;
