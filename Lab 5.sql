--Hannah Youssef
--Lab 5 exercises (10/09/17)

/* #1: Show the cities of agents booking an order for a customer whose id is 'c006'. 
Use joins this timel no subqueries. */
	SELECT a.city
	FROM Orders o
	INNER JOIN Agents a
	ON o.aid = a.aid
	WHERE o.cid = 'c006';

/* #2: Show the ids of products ordered through any agent who makes at least one 
order for a customer in Beijing, sorted by pid from highest to lowest. Use joins; 
no subqueries. */
	SELECT DISTINCT o2.pid
		FROM Orders o
	INNER JOIN Customers c
		ON o.cid = c.cid 
		AND c.city = 'Beijing'
	INNER JOIN Orders o2
		ON o2.aid = o.aid
	ORDER BY pid DESC;

/* #3: Show the names of customers who have never placed an order. Use a subquery. */
	SELECT name
	FROM Customers
	WHERE cid NOT IN (SELECT cid
			   FROM Orders
			  );

/* #4: Show the names of customers who have never placed an order. Use an outer join. */
	SELECT c.name
		FROM Customers c
	FULL JOIN Orders o
		ON o.cid = c.cid
	WHERE o.ordno IS NULL;

/* #5: Show the names of customers who placed at least one order through an agent in 
their own city, along with those agent(s') names. */
	SELECT DISTINCT c.name, a.name
		FROM Orders o
	INNER JOIN Customers c
		ON o.cid = c.cid
	INNER JOIN Agents a
		ON o.aid = a.aid
	WHERE (o.cid, o.aid) in (SELECT c1.cid, a1.aid
				  FROM Customers c1
				  INNER JOIN Agents a1
					ON c1.city = a1.city
				 );

/* #6: Show the names of customers and agents living in the same city, along with the 
name of the shared city, regardless of whether or not the customer has ever placed 
an order with that agent. */
	SELECT c.name, a.name, c.city
		FROM Customers c
	INNER JOIN Agents a
		ON c.city = a.city;

/* #7: Show the name and city of customers who live in the city that makes the fewest 
different kinds of products. (Hint: Use count and group by on the Products table.) */
	SELECT name, city
		FROM Customers
	WHERE city in (SELECT city
			FROM Products
			GROUP BY city
			ORDER BY count(*) ASC
			LIMIT 1
		       );