--Hannah Youssef
--Lab 6 exercises (10/16/17)

/* #1: Display the name and city of customers who live in any city that makes the most 
different kinds of products. (There are two cities that make the most different products. 
Return the name and city of customers from either one of those.) */
	SELECT name, city
	FROM customers
	WHERE city in(SELECT city
			from products
			GROUP BY city
			ORDER BY count(pid) DESC
			LIMIT 1
		      );
		      

/* #2: Display the names of products whose priceUSD is at or above the average priceUSD, 
in reverse-alphabetical order. */
	SELECT NAME
	FROM products
	WHERE priceUSD >= (SELECT avg(priceUSD)
				FROM products
			  )
	ORDER BY name DESC;


/* #3: Display the customer name, pid ordered, and the total for all orders, sorted by 
total from low to high. */
	SELECT customers.name, orders.pid, orders.totalUSD
	FROM customers, orders
	WHERE orders.cid = customers.cid
	ORDER by orders.totalUSD ASC;


/* #4: Display all customer names (in reverse alphabetical order) and their total ordered, 
and nothing more. Use coalesce to avoid showing NULLs. */

	SELECT c.name, COALESCE(sum(o.totalUSD), 0)
	FROM Orders o
	RIGHT OUTER JOIN Customers c
	ON o.cid = c.cid
	GROUP BY c.cid
	ORDER BY c.name DESC;
	

/* #5: Display the names of all customers who bought products from agents based in Newark 
along with the names of the products they ordered, and the names of the agents who sold 
it to them. */

	SELECT customers.name, products.name, agents.name
	FROM customers, agents, products, orders
	WHERE orders.pid = products.pid
	  AND orders.cid = customers.cid
	  AND orders.aid = agents.aid
	  AND agents.city = 'Newark';


/* #6: Write a query to check the accuracy of the totalUSD column in the Orders table. 
This means calculating Orders.totalUSD from data in other tables and comparing those 
values to the values in Orders.totalUSD. Display all rows in Orders where Orders.totalUSD 
is incorrect, if any. */

	SELECT o.quantity, p.priceUSD, o.totalUSD, (o.quantity * p.priceUSD) 
	as "Checked Total USD", ((o.quantity * p.priceUSD) = o.totalUSD) 
	as "Stored total = checked total"
	FROM Orders o
	INNER JOIN Products p
	ON o.pid = p.pid
	WHERE ((o.quantity * p.priceUSD) != o.totalUSD);


/* #7: What’s the difference between a LEFT OUTER JOIN and a RIGHT OUTER JOIN? Give example 
queries in SQL to demonstrate.(Feel free to use the CAP database to make your points here.)*/

	-- A LEFT OUTER JOIN is a join operation that allows you take the rows from the 
	-- left table and join them with the rows of the right table.
	-- Example of a left outer join from the CAP database:
	SELECT products.pid
	FROM products
	LEFT OUTER JOIN orders ON orders.pid = products.pid
	

	-- A RIGHT OUTER JOIN is also a join operation but allows you to take the rows from the 
	-- right table and join them with the rows of the left table.
	-- Example of a right outer join from the CAP database:
	SELECT products.pid
	FROM orders
	RIGHT OUTER JOIN products ON products.pid = orders.pid