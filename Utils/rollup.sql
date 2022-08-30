SELECT 
    warehouse, SUM(quantity)
FROM
    inventory
GROUP BY ROLLUP (warehouse);
