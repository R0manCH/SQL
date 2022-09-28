SELECT cat, SUM(cost) AS cost
FROM base
GROUP BY cat
ORDER BY cost DESC;

SELECT house, SUM(cost) AS cost
FROM base
GROUP BY house
ORDER BY cost DESC;

SELECT cat, food, price, date_of_purchase 
FROM base
WHERE date_of_purchase BETWEEN '2022-09-20' AND 'today'
ORDER BY date_of_purchase;

SELECT food, SUM(cost) AS cost
FROM base
WHERE date_of_purchase BETWEEN '2022-09-20' AND '2022-09-25'
GROUP BY food
HAVING food LIKE 'M%'
ORDER BY cost;

SELECT owner_name
FROM owners
JOIN cats USING(owner_id)
WHERE cat_id IN (SELECT DISTINCT cat_id
                 FROM cart
                 WHERE food_id = 2);

SELECT food_name
FROM food
WHERE food_id IN (SELECT food_id
                 FROM cart
                 GROUP BY food_id
                 HAVING SUM(amount) > (SELECT (SUM(amount)/COUNT(DISTINCT food_id))
                                       FROM cart));

SELECT DISTINCT food_name
FROM food
WHERE EXISTS(SELECT food_id FROM cart
             WHERE food_id = food.food_id
             AND date_buy BETWEEN '2022-09-20' AND '2022-09-25');

SELECT DISTINCT owner_name
FROM owners
JOIN cats USING(owner_id)
WHERE cat_id = ANY(SELECT cat_id FROM cart
                   WHERE amount = 8);