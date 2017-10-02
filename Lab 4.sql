--Hannah Youssef
--Lab 4 exercises (09/25/17-10/02/17)

/* #1: Get the cities of agents booking an order for a 
customer whose cid is 'c006'.*/
select distinct city
from Agents
where aid in (select aid 
		from Orders
		where cid = 'c006');

/* #2: Get the distinct ids of products ordered through any 
agent who takes at least one order from a customer in 
Beijing, sorted by pid from highest to lowest. */
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

/* #3: Get the ids and names of customers who did not place an 
order through agent a03. */
select distinct cid, name
from Customers
where cid not in (select distinct cid
		from Orders
		where aid = 'a03');

/* #4: Get the ids of customers who ordered both product p01 
and p07. */
select distinct cid
from Customers
where cid in (select cid
		from Orders
		where pid = 'p01' or pid = 'p07'
		);

/* #5: Get the ids of products not ordered by any customers 
who placed any order through agents a02 or a03, in pid order 
from highest to lowest. */
select distinct pid
from Orders
where cid in (select cid
		from Orders
		where aid = 'a02' or aid = 'a03'
		)
order by pid desc;

/* #6: Get the name, discount, and city for all customers who 
place orders through agents in Tokyo or New York. */
select name, discountPct, city
from Customers
where cid in (select cid
		from Orders
		where aid in (select aid
				from Agents
				where city = 'Tokyo' or city = 'New York'
				)
		);

/* #7: Get all customers who have the same discount as that of 
any customers in Duluth or London */
select *
from Customers
where not city = 'Duluth' and 
	not city = 'London' and 
	discountPct in (select discount
			from Customers
			where city = 'Duluth' or 
				city = 'Kyoto');
                
/* #8: Tell me about check constraints: What are they? What 
are they good for? What’s the advantage of putting that sort 
of thing inside the database? Make up some examples of good 
uses of check constraints and some examples of bad uses of 
check constraints. Explain the differences in your examples 
and argue your case. */

/* 
 A check constraint is used to limit the range of values that 
can be entered for a column. The check constraint enables a 
condition to check the value being entered into a record. If 
the condition evaluated to false, the record violates the 
constraint and isn’t entered the table.

 The advantage of putting a CHECK constraint in a database is 
that it will help regulate the data and make sure that no data 
that violate the rules are inserted into the database.

 One example of a good database that uses CHECK restraints is 
one where the database designer is looking to gather the data 
just on people 18 and older. The SQL line of code they would 
create for the check restraint would be: “CHECK (Age>=18)”, 
ensuring that data entered into the table would only be 
visible if the age is greater than or equal to 18.

 An example of a bad use of CHECK restraint would be if 
someone is trying to gather data on letters of the alphabet, 
and sets a CHECK restraint as all of the letters of the 
alphabet (A-Z). In this case, there would be no point of 
setting a CHECK restraint at all, since any letter entered 
would be shown on the table, regardless of the constraint 
being present or not.

 In the first example, the CHECK constraint would be 
appropriate if the database creator would like to display only 
ages 18 and up, as opposed to the last example, where the 
letters of the alphabet would be displayed despite the 
restraint being written.
*/
