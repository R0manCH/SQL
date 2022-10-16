-- 1(1)
SELECT model, speed, hd
FROM PC
WHERE price < 500

-- 2(1)
SELECT DISTINCT maker
FROM Product
WHERE type = 'Printer'

--3(1)
SELECT model, ram, screen
FROM Laptop
WHERE price > 1000

--4(1)
SELECT *
FROM Printer
WHERE color = 'y'

--5(1)
SELECT model, speed, hd
FROM PC
WHERE cd IN ('12x', '24x') AND price < 600

--6(2)
SELECT DISTINCT maker, speed
FROM Product p
LEFT JOIN Laptop l ON l.model = p.model
WHERE hd >= 10

--7(2)
SELECT DISTINCT model, price
FROM PC
WHERE MODEL IN 
(SELECT model
FROM Product
WHERE maker = 'B')
UNION 
SELECT DISTINCT model, price
FROM Printer
WHERE MODEL IN 
(SELECT model
FROM Product
WHERE maker = 'B')
UNION 
SELECT DISTINCT model, price
FROM Laptop
WHERE MODEL IN 
(SELECT model
FROM Product
WHERE maker = 'B')

--8(2)
SELECT DISTINCT maker
FROM Product
WHERE type = 'PC' AND maker NOT IN (
SELECT maker
FROM Product
WHERE type = 'Laptop')

--9(1)
SELECT DISTINCT maker
FROM Product
WHERE model IN (SELECT model
FROM PC
WHERE speed >= 450)

--10(1)
SELECT model, price
FROM Printer
WHERE price IN (SELECT MAX(price) FROM Printer)

--11(1)
SELECT AVG(speed) 
FROM PC

--12(1)
SELECT AVG(speed)
FROM Laptop
WHERE price > 1000

--13(1)
SELECT AVG(speed)
FROM PC
WHERE model IN (SELECT model FROM Product
                WHERE maker = 'A')

--14(2)
SELECT s.class, name, country
FROM Ships s
JOIN Classes c ON c.class = s.class
WHERE numGuns >= 10

--15(2)
SELECT hd
FROM PC
GROUP BY hd
HAVING COUNT(code) >= 2

--16(2)
SELECT DISTINCT p1.model, p2.model, p1.speed, p1.ram
FROM PC p1
CROSS JOIN PC p2
WHERE p1.model > p2.model AND p1.speed = p2.speed AND p1.ram = p2.ram

--17(2)
SELECT DISTINCT type, l.model, speed
FROM Laptop l 
JOIN Product p ON p.model = l.model
WHERE speed < ALL (SELECT speed FROM PC)

--18(2)
SELECT DISTINCT maker, price
FROM Printer p
JOIN Product prod ON prod.model = p.model
WHERE color = 'y' AND price IN (
SELECT MIN(price)
FROM Printer
WHERE color = 'y')

--19(1)
SELECT maker, AVG(screen)
FROM Laptop l
JOIN Product p ON l.model = p.model
GROUP BY maker

--20(2)
SELECT maker, COUNT(DISTINCT model)
FROM Product
WHERE type = 'PC'
GROUP BY maker
HAVING COUNT(DISTINCT model) >= 3

--21(1)
SELECT maker, MAX(price)
FROM Product prod
JOIN PC ON pc.model = prod.model
GROUP BY maker

--22(1)
SELECT speed, AVG(price)
FROM PC
WHERE speed > 600
GROUP BY speed

--23(2)
SELECT DISTINCT maker
FROM Product prod
JOIN PC ON pc.model = prod.model
WHERE speed >= 750
INTERSECT
SELECT DISTINCT maker
FROM Product prod
JOIN Laptop l ON l.model = prod.model
WHERE speed >= 750

--24(2)
WITH be_all AS(
SELECT model, price
FROM PC
UNION
SELECT model, price
FROM Laptop
UNION
SELECT model, price
FROM Printer
)
SELECT model
FROM be_all
WHERE price IN (SELECT MAX(price) FROM be_all)


--25(2)
SELECT DISTINCT maker
FROM Product
WHERE type = 'Printer'
INTERSECT
SELECT DISTINCT maker
FROM Product 
WHERE model IN 
(SELECT model FROM PC
WHERE ram IN (SELECT MIN(ram) FROM PC)
AND speed IN (SELECT MAX(speed) FROM PC
WHERE ram IN (SELECT MIN(ram) FROM PC)))

--26(2)
WITH Aprice AS (
SELECT price
FROM Laptop l
JOIN Product prod ON l.model = prod.model
WHERE maker = 'A'
UNION ALL
SELECT price
FROM PC
JOIN Product prod ON pc.model = prod.model
WHERE maker = 'A'
)

SELECT AVG(price)
FROM Aprice

--27(2)
SELECT maker, AVG(hd)
FROM PC
JOIN Product prod ON prod.model = pc.model
WHERE maker IN (SELECT DISTINCT maker FROM Product WHERE type = 'Printer')
GROUP BY maker

--28(2)
SELECT COUNT(maker)
FROM Product
WHERE maker IN (
SELECT maker 
FROM Product
GROUP BY maker
HAVING COUNT(model) = 1)

--29(2)
SELECT io.point, io.date, inc, out
FROM Income_o io
LEFT JOIN Outcome_o oo ON io.point = oo.point 
AND io.date = oo.date
UNION 
SELECT oo.point, oo.date, inc, out
FROM Income_o io
RIGHT JOIN Outcome_o oo ON io.point = oo.point 
AND io.date = oo.date


--30(2)
WITH outinc AS (
SELECT point, date, SUM(out) AS Outcome, NULL AS Income
FROM Outcome 
GROUP BY point, date
UNION
SELECT point, date, NULL AS Outcome,  SUM(inc) AS Income
FROM Income 
GROUP BY point, date)
SELECT point, date, SUM(Outcome) AS Outcome, SUM(Income) AS Income
FROM outinc
GROUP BY point, date

--31(1)
SELECT class, country
FROM Classes
WHERE bore >= 16

--32(3)
SELECT country, CAST(AVG(POWER(bore,3)/2) AS dec(6,2)) AS weight
FROM 
(
SELECT name, country, bore, c.class
FROM Classes c
JOIN Ships s ON c.class = s.class
UNION ALL
SELECT DISTINCT ship, country, bore, c.class
FROM Classes c
JOIN Outcomes o ON c.class = o.ship
WHERE ship NOT IN (SELECT name FROM Ships)
) A
GROUP BY country

--33(1)
SELECT ship
FROM Outcomes 
WHERE result = 'sunk' AND battle = 'North Atlantic'

--34(2)
SELECT name
FROM Ships
WHERE launched >= '1922' AND
class IN (
SELECT class FROM Classes
WHERE displacement > 35000 AND type = 'bb')

--35(2)
SELECT model, type
FROM Product
WHERE model NOT LIKE '%[^A-Z]%' OR model NOT LIKE '%[^0-9]%'

--36(2)
SELECT name
FROM Ships
WHERE name IN 
(SELECT class FROM Classes)
UNION
SELECT ship
FROM Outcomes
WHERE ship IN 
(SELECT class FROM Classes)

--37(2)
WITH allship AS (
SELECT name, class
FROM Ships
UNION 
SELECT o.ship AS name, c.class AS class
FROM Outcomes o
JOIN Classes c ON o.ship = c.class)
SELECT class
FROM allship
GROUP BY class
HAVING COUNT(name) = 1

--38(1)
SELECT country
FROM Classes
WHERE type = 'bb'
INTERSECT
SELECT country
FROM Classes
WHERE type = 'bc'

--39(2)
WITH sbdr AS(
SELECT o.ship, o.battle, b.date, o.result
FROM Outcomes o
JOIN Battles b ON o.battle = b.name)
SELECT DISTINCT a.ship
FROM sbdr a
WHERE a.ship IN (
SELECT b.ship
FROM sbdr b
WHERE b.result = 'damaged' AND b.date < a.date)

--40(2)
SELECT DISTINCT maker, type
FROM Product
WHERE maker IN (
SELECT maker
FROM Product
GROUP BY maker
HAVING COUNT(DISTINCT type) = 1)
GROUP BY maker, type
HAVING COUNT(model) > 1

--41(2)
WITH Allprice AS
(
SELECT model, price
FROM Laptop
UNION
SELECT model, price
FROM PC
UNION
SELECT model, price
FROM Printer
)
SELECT DISTINCT maker,
CASE WHEN MAX(CASE WHEN ap.price IS NULL THEN 1 ELSE 0 END) = 0 THEN
MAX(ap.price) 
END AS max_price
FROM Allprice ap
LEFT JOIN Product prod ON prod.model = ap.model
GROUP BY maker

--42(1)
SELECT ship, battle
FROM Outcomes
WHERE result = 'sunk'

--43(2)
SELECT name
FROM Battles
WHERE year(date) NOT IN (
SELECT launched
FROM Ships
WHERE launched IS NOT NULL)

--44(1)
SELECT name
FROM Ships
WHERE name LIKE 'R%'
UNION
SELECT ship
FROM Outcomes c
WHERE ship LIKE 'R%'

--45(1)
SELECT name
FROM Ships
WHERE name LIKE '% % %'
UNION
SELECT ship
FROM Outcomes c
WHERE ship LIKE '% % %'

--46(2)
WITH ciss AS
(
SELECT s.name AS ship, displacement, numGuns
FROM Ships s
LEFT JOIN Classes c ON s.class = c.class
UNION
SELECT class AS ship, displacement, numGuns
FROM Classes
)
SELECT o.ship, displacement, numGuns
FROM Outcomes o
LEFT JOIN ciss cs ON o.ship = cs.ship
WHERE battle = 'Guadalcanal'

--47(3)
WITH T1 AS 
( 
SELECT country, COUNT(name) AS co
FROM
(
SELECT name, country 
FROM Classes c
JOIN Ships s ON s.class = c.class
UNION
SELECT ship, country 
FROM Classes c
JOIN Outcomes o ON o.ship = c.class
) FR1
GROUP BY country
),

T2 AS 
( 
SELECT country, COUNT(name) AS co 
FROM 
( 
SELECT name, country 
FROM Classes c
JOIN Ships s ON s.class = c.class
WHERE name IN 
(
SELECT DISTINCT ship 
FROM Outcomes 
WHERE result = 'sunk'
)
UNION
SELECT ship, country 
FROM Classes c
JOIN Outcomes o ON o.ship = c.class
WHERE ship IN 
(
SELECT DISTINCT ship 
FROM Outcomes
WHERE result = 'sunk'
)
) FR2 
GROUP BY country 
)

SELECT T1.country 
FROM T1
JOIN T2 ON T1.co = t2.co and t1.country = t2.country

--48(2)
WITH ciss AS
(
SELECT name, class 
FROM Ships
UNION
SELECT class AS name, class
FROM Classes
)
SELECT DISTINCT class
FROM ciss
WHERE name IN
(
SELECT ship
FROM Outcomes
WHERE result = 'sunk'
)

--49(1)
SELECT name
FROM Ships
WHERE class IN
(SELECT class
FROM Classes
WHERE bore = 16)
UNION
SELECT ship
FROM Outcomes
WHERE ship IN
(SELECT class
FROM Classes
WHERE bore = 16)


--50(1)
SELECT DISTINCT battle
FROM Outcomes
WHERE ship IN
(SELECT name
FROM Ships
WHERE class = 'Kongo')