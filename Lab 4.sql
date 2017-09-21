--Hannah Youssef
--Lab 4 exercises (09/25/17)

--#1: Get the cities of agents booking an order for a customer whose cid is 'c006'.
select distinct city
from Agents
where aid in (select aid 
		from Orders
		where cid = 'c006');

--#2: Get the distinct ids of products ordered through any agent who takes at least one order from a customer in Beijing, sorted by pid from highest to lowest.
select distinct pid
from Orders
where aid in (select aid
		from Orders
		where cid in (select cid
				from Customers
				where city = 'Beijing'
				)
		)
order by pid desc;

--#3: Get the ids and names of customers who did not place an order through agent a03.
select distinct cid, name
from Customers
where cid not in (select distinct cid
		from Orders
		where aid = 'a03');

--#4: Get the ids of customers who ordered both product p01 and p07.
select distinct cid
from Customers
where cid in (select cid
		from Orders
		where pid = 'p01' or pid = 'p07'
		);

--#5: Get the ids of products not ordered by any customers who placed any order through agents a02 or a03, in pid order from highest to lowest.
select distinct pid
from Orders
where cid in (select cid
		from Orders
		where aid = 'a02' or aid = 'a03'
		)
order by pid desc;

--#6: Get the name, discount, and city for all customers who place orders through agents in Tokyo or New York.
select name, discountPct, city
from Customers
where cid in (select cid
		from Orders
		where aid in (select aid
				from Agents
				where city = 'Tokyo' or city = 'New York'
				)
		);

--#7: Get all customers who have the same discount as that of any customers in Duluth or London
select *
from Customers
where not city = 'Duluth' and 
	not city = 'London' and 
	discountPct in (select discount
			from Customers
			where city = 'Duluth' or 
				city = 'Kyoto');