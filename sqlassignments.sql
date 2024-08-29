-- 1. Display snum, sname, city and comm of all salespeople.
SELECT snum, sname, city, comm
FROM salespeople;

-- 2. Display all snum without duplicates from all orders.
SELECT DISTINCT snum
FROM orders;

-- 3. Display names and commissions of all salespeople in London.
SELECT sname, comm
FROM salespeople
WHERE city = 'London';

-- 4. All customers with a rating of 100.
SELECT *
FROM customers
WHERE rating = 100;

-- 5. Produce order_no, amount, and date from all rows in the order table.
SELECT order_no, amount, order_date
FROM orders;

-- 6. All customers in San Jose, who have a rating more than 200.
SELECT *
FROM customers
WHERE city = 'San Jose' AND rating > 200;

-- 7. All customers who were either located in San Jose or had a rating above 200.
SELECT *
FROM customers
WHERE city = 'San Jose' OR rating > 200;

-- 8. All orders for more than $1000.
SELECT *
FROM orders
WHERE amount > 1000;

-- 9. Names and cities of all salespeople in London with commission above 0.10.
SELECT sname, city
FROM salespeople
WHERE city = 'London' AND comm > 0.10;

-- 10. All customers excluding those with rating <= 100 unless they are located in Rome.
SELECT *
FROM customers
WHERE (rating > 100) OR (city = 'Rome' AND rating <= 100);

-- 11. All salespeople either in Barcelona or in London.
SELECT *
FROM salespeople
WHERE city = 'Barcelona' OR city = 'London';

-- 12. All salespeople with commission between 0.10 and 0.12. (Boundary values should be excluded).
SELECT *
FROM salespeople
WHERE comm > 0.10 AND comm < 0.12;

-- 13. All customers with NULL values in the city column.
SELECT *
FROM customers
WHERE city IS NULL;

-- 14. All orders taken on Oct 3rd and Oct 4th 1994.
SELECT *
FROM orders
WHERE order_date IN ('1994-10-03', '1994-10-04');

-- 15. All customers serviced by Peel or Motika.
SELECT *
FROM customers
WHERE snum = (SELECT snum FROM salespeople WHERE sname = 'Peel')
   OR snum = (SELECT snum FROM salespeople WHERE sname = 'Motika');

-- 16. All customers whose names begin with a letter from A to B.
SELECT *
FROM customers
WHERE cname LIKE 'A%' OR cname LIKE 'B%';

-- 17. All orders except those with 0 or NULL value in the amount field.
SELECT *
FROM orders
WHERE amount > 0 AND amount IS NOT NULL;

-- 18. Count the number of salespeople currently listing orders in the orders table.
SELECT COUNT(DISTINCT snum)
FROM orders;

-- 19. Largest order taken by each salesperson, datewise.
SELECT snum, MAX(amount) AS largest_order, order_date
FROM orders
GROUP BY snum, order_date;

-- 20. Largest order taken by each salesperson with order value more than $3000.
SELECT snum, MAX(amount) AS largest_order
FROM orders
WHERE amount > 3000
GROUP BY snum;

-- 21. Which day had the highest total amount ordered.
SELECT order_date, SUM(amount) AS total_amount
FROM orders
GROUP BY order_date
ORDER BY total_amount DESC
LIMIT 1;

-- 22. Count all orders for Oct 3rd.
SELECT COUNT(*)
FROM orders
WHERE order_date = '1994-10-03';

-- 23. Count the number of different non-NULL city values in the customers table.
SELECT COUNT(DISTINCT city)
FROM customers
WHERE city IS NOT NULL;

-- 24. Select each customer’s smallest order.
SELECT cname, MIN(amount) AS smallest_order
FROM customers
JOIN orders ON customers.cnum = orders.cnum
GROUP BY cname;

-- 25. First customer in alphabetical order whose name begins with G.
SELECT *
FROM customers
WHERE cname LIKE 'G%'
ORDER BY cname ASC
LIMIT 1;

-- 26. Get the output like "For dd/mm/yy there are _ orders."
SELECT CONCAT('For ', DATE_FORMAT(order_date, '%d/%m/%y'), ' there are ', COUNT(*), ' orders.')
FROM orders
GROUP BY order_date;

-- 27. Assume that each salesperson has a 12% commission. Produce order_no, salesperson no., and amount of salesperson’s commission for that order.
SELECT order_no, snum, amount * 0.12 AS commission
FROM orders;

-- 28. Find the highest rating in each city. Put the output in this form: "For the city (city), the highest rating is: (rating)."
SELECT CONCAT('For the city ', city, ', the highest rating is: ', MAX(rating), '.') AS output
FROM customers
GROUP BY city;

-- 29. Display the totals of orders for each day and place the results in descending order.
SELECT order_date, SUM(amount) AS total_amount
FROM orders
GROUP BY order_date
ORDER BY total_amount DESC;

-- 30. All combinations of salespeople and customers who shared a city (i.e., same city).
SELECT s.sname, c.cname
FROM salespeople s
JOIN customers c ON s.city = c.city;

-- 31. Name of all customers matched with the salespeople serving them.
SELECT c.cname, s.sname
FROM customers c
JOIN salespeople s ON c.snum = s.snum;

-- 32. List each order number followed by the name of the customer who made the order.
SELECT o.order_no, c.cname
FROM orders o
JOIN customers c ON o.cnum = c.cnum;

-- 33. Names of salesperson and customer for each order after the order number.
SELECT o.order_no, s.sname, c.cname
FROM orders o
JOIN salespeople s ON o.snum = s.snum
JOIN customers c ON o.cnum = c.cnum;

-- 34. Produce all customers serviced by salespeople with a commission above 12%.
SELECT c.*
FROM customers c
JOIN salespeople s ON c.snum = s.snum
WHERE s.comm > 0.12;

-- 35. Calculate the amount of the salesperson’s commission on each order with a rating above 100.
SELECT o.order_no, s.snum, o.amount * s.comm AS commission
FROM orders o
JOIN customers c ON o.cnum = c.cnum
JOIN salespeople s ON c.snum = s.snum
WHERE c.rating > 100;

-- 36. Find all pairs of customers having the same rating.
SELECT c1.cname AS customer1, c2.cname AS customer2
FROM customers c1
JOIN customers c2 ON c1.rating = c2.rating
WHERE c1.cnum < c2.cnum;

-- 37. Policy is to assign three salespersons to each customer. Display all such combinations.
SELECT c.cname, s.sname
FROM customers c
CROSS JOIN salespeople s
WHERE (SELECT COUNT(*) FROM customers WHERE snum = s.snum) = 3;

-- 38. Display all customers located in cities where salesperson Serres has customers.
SELECT *
FROM customers
WHERE city IN (SELECT city FROM customers WHERE snum = (SELECT snum FROM salespeople WHERE sname = 'Serres'));

-- 39. Find all pairs of customers served by a single salesperson.
SELECT c1.cname AS customer1, c2.cname AS customer2
FROM customers c1
JOIN customers c2 ON c1.snum = c2.snum
WHERE c1.cnum < c2.cnum;

-- 40. Produce all pairs of salespeople who are living in the same city. Exclude combinations of salespeople with themselves as well as duplicates with the order reversed.
SELECT s1.sname AS salesperson1, s2.sname AS salesperson2
FROM salespeople s1
JOIN salespeople s2 ON s1.city = s2.city
WHERE s1.snum < s2.snum;

-- 41. Produce names and cities of all customers with the same rating as Hoffman.
SELECT cname, city
FROM customers
WHERE rating = (SELECT rating FROM customers WHERE cname = 'Hoffman');

-- 42. Extract all the orders of Motika.
SELECT o.*
FROM orders o
JOIN salespeople s ON o.snum = s.snum
WHERE s.sname = 'Motika';

-- 43. All orders credited to the same salesperson who services Hoffman.
SELECT o.*
FROM orders o
JOIN customers c ON o.cnum = c.cnum
WHERE c.snum = (SELECT snum FROM customers WHERE cname = 'Hoffman');

-- 44. All orders that are greater than the average for Oct 4.
SELECT *
FROM orders
WHERE order_date = '1994-10-04' AND amount > (SELECT AVG(amount) FROM orders WHERE order_date = '1994-10-04');

-- 45. Find average commission of salespeople in London.
SELECT AVG(comm) AS avg_commission
FROM salespeople
WHERE city = 'London';

-- 46. Find all orders attributed to salespeople servicing customers in London.
SELECT o.*
FROM orders o
JOIN customers c ON o.cnum = c.cnum
WHERE c.city = 'London';

-- 47. Extract commissions of all salespeople servicing customers in London.
SELECT DISTINCT s.comm
FROM salespeople s
JOIN customers c ON s.snum = c.snum
WHERE c.city = 'London';

-- 48. Find all customers whose cnum is 1000 above the snum of Serres.
SELECT *
FROM customers
WHERE cnum = (SELECT snum FROM salespeople WHERE sname = 'Serres') + 1000;

-- 49. Count the customers with rating above San Jose’s average.
SELECT COUNT(*)
FROM customers
WHERE rating > (SELECT AVG(rating) FROM customers WHERE city = 'San Jose'):

