CREATE OR REPLACE VIEW base AS
SELECT 
COALESCE(cat_name, 'No cat') AS cat, COALESCE(email, 'No email') AS email, COALESCE(owner_name, 'No owner') AS owner, 
COALESCE(house_name, 'No house') AS house, COALESCE(food_name, 'No food') AS food, 
date_buy AS date_of_purchase, 
--COALESCE(date_buy::varchar, 'No purchase') AS date_of_purchase, 
COALESCE(amount, 0) AS amount, COALESCE(price, 0) AS price, COALESCE(price * amount, 0) AS cost
FROM cats
RIGHT JOIN owners USING(owner_id)
JOIN houses USING(house_id)
LEFT JOIN cart USING(cat_id)
LEFT JOIN food USING(food_id)
ORDER BY cost DESC;

CREATE OR REPLACE VIEW limited AS
SELECT * 
FROM base
WHERE cost >= 100
WITH LOCAL CHECK OPTION;
