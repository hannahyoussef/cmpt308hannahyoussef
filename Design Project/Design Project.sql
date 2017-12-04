-- Hannah Youssef
-- Database Management
-- Alan Labouseur
-- Design Project
-- 4 December 2017

-- Lost and Found Database --

DROP VIEW IF EXISTS CurrentReporters;
DROP VIEW IF EXISTS OldUnverifiedUsers;
DROP VIEW IF EXISTS MostCommonLostLocation;

DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS anonymousUsers;
DROP TABLE IF EXISTS registeredUsers;
DROP TABLE IF EXISTS schools;
DROP TABLE IF EXISTS locationTypes;
DROP TABLE IF EXISTS locations;
DROP TABLE IF EXISTS itemTypes;
DROP TABLE IF EXISTS items;
DROP TABLE IF EXISTS reported;
DROP TABLE IF EXISTS recovered;

--TABLES
--users Table
CREATE TABLE users (
user_id SERIAL PRIMARY KEY, 
email varchar(320) NOT NULL, 
password varchar(512), 
token int, 
verified boolean default '0', 
join_date date NOT NULL DEFAULT CURRENT_DATE
);

--anonymousUsers Table
CREATE TABLE anonymousUsers (
user_id int REFERENCES users(user_id) PRIMARY KEY
);

--registeredUsers Table
CREATE TABLE registeredUsers (
user_id int REFERENCES users(user_id) PRIMARY KEY, 
first_name varchar(256) NOT NULL, 
last_name varchar(256) NOT NULL
);

--schools Table
CREATE TABLE schools (
school_id SERIAL PRIMARY KEY, 
name varchar(256) NOT NULL, 
email_domain varchar(253) NOT NULL, 
address varchar(512)
);

--locationTypes Table
CREATE TABLE locationTypes (
locationType_id SERIAL PRIMARY KEY, 
name varchar(256) NOT NULL
);

--locations Table
CREATE TABLE locations (
location_id SERIAL PRIMARY KEY, 
name varchar(256) NOT NULL, 
locationType_id int REFERENCES locationTypes(locationType_id), 
school_id int REFERENCES schools(school_id)
);

--itemTypes Table
CREATE TABLE itemTypes (
itemType_id int PRIMARY KEY, /*should be SERIAL, but causes bigger problems in the future*/
name varchar(256) NOT NULL
);

--items Table
CREATE TABLE items (
item_id int PRIMARY KEY, 
name varchar(256) NOT NULL, 
itemType_id int REFERENCES itemTypes(itemType_id), 
description varchar(1024)
);

--reported Table
CREATE TABLE reported ( 
user_id int REFERENCES users(user_id), 
item_id int REFERENCES items(item_id) UNIQUE, 
location_id int REFERENCES locations(location_id),
timeReported date NOT NULL DEFAULT CURRENT_DATE
);

--recovered Table
CREATE TABLE recovered ( 
registered_user_id int REFERENCES registeredUsers(user_id), 
item_id int REFERENCES items(item_id) UNIQUE, 
timeRecovered date NOT NULL DEFAULT CURRENT_DATE
);



--INSERTS
--Inserts into users
INSERT INTO users (user_id, email, password) VALUES 
(1, 	'Hannah.Youssef1@marist.edu', 			'5f4dcc3b5aa765d61d8327deb882cf99'), 
(2, 	'Alan.Labouseur@marist.edu', 			'5f4dcc3b5aa765d61d8327deb882cf99'), 
(3, 	'stevejobs@mit.edu', 					'5f4dcc3b5aa765d61d8327deb882cf99'), 
(4, 	'stevewozniak@harvard.edu', 			'5f4dcc3b5aa765d61d8327deb882cf99'), 
(5, 	'Zimri.Mayfield@stanford.edu', 			'5f4dcc3b5aa765d61d8327deb882cf99'),
(6, 	'beyonceknowles@bc.edu', 				'5f4dcc3b5aa765d61d8327deb882cf99'), 
(7, 	'jayz@bu.edu', 							'5f4dcc3b5aa765d61d8327deb882cf99'),
(8, 	'donaldtrump@yale.edu', 				'5f4dcc3b5aa765d61d8327deb882cf99'),
(9, 	'Justin.Bieber@nyu.edu', 				'5f4dcc3b5aa765d61d8327deb882cf99'), 
(10, 	'John.Smith@bc.edu', 					'5f4dcc3b5aa765d61d8327deb882cf99'), 
(11, 	'Frankie.Fox@marist.edu', 				'5f4dcc3b5aa765d61d8327deb882cf99'), 
(12, 	'billgates@harvard.edu', 				'5f4dcc3b5aa765d61d8327deb882cf99'), 

(13, 	'appleluvr33@gmail.com', 				'5f4dcc3b5aa765d61d8327deb882cf99'), 
(14, 	'test.post@please.ignore.com', 			'5f4dcc3b5aa765d61d8327deb882cf99'), 
(15, 	'admin111111111111@gmail.com', 			'5f4dcc3b5aa765d61d8327deb882cf99'),
(16, 	'AlanIsTheBestProfessorEver@lol.com', 	'5f4dcc3b5aa765d61d8327deb882cf99'), 
(17, 	'email@yahoo.com', 						'5f4dcc3b5aa765d61d8327deb882cf99'), 
(18, 	'hannah@aol.com', 						'5f4dcc3b5aa765d61d8327deb882cf99');

--Inserts into anonymousUsers
INSERT INTO anonymousUsers (user_id) VALUES
(7), 
(8), 
(9), 
(14), 
(15),
(2);
 
--Inserts into itemTypes
INSERT INTO itemTypes (itemType_id, name) VALUES 
(1, 'Phone'),
(2, 'Laptop'),
(3, 'MP3 Player'),
(4, 'Portable Video Game System'),
(5, 'Electronic Accessory'),
(6, 'Jewelry'),
(7, 'Book'),
(8, 'Notebook'),
(9, 'Credit/Debit Card'),
(10, 'ID'),
(11, 'Clothing'),
(12, 'Wallet/Purse'),
(13, 'Bag');
 
--Inserts into items

INSERT INTO items (item_id, name, itemType_id, description) VALUES 
(1,		'iPhone 5s', 						1, 	'White. Crack on front.'), 
(2, 	'Retina MacBook Pro', 				2, 	'Blue case. Login screen says John with red striped background'), 
(3, 	'iPod Shuffle', 					3, 	'Green iPod Shuffle.'), 
(4, 	'Nintendo 3DS', 					4, 	'Black. Broken hinge. Pokemon Rainbow is in it.'), 
(5, 	'Bose Headphones', 					5, 	'Black and silver.'), 
(6, 	'Earrings', 						6, 	'Hoop silver earrings'), 
(7, 	'Database Systems Book', 			7, 	'Faded cover.'), 
(8, 	'Database Systems Notebook', 		8, 	'Red cover. Wide ruled paper. Many doodles, few notes.'), 
(9, 	'VISA Card', 						9, 	'Name on card reads Alan Labouseur.'),
(10, 	'Marist ID', 						10, 'CWID 200-80-908 and name Hannah Youssef'), 
(11, 	'Plaid shirt', 						11, 'Long sleeves. Stain on back.'),
(12, 	'Brown leather wallet', 			12, 'Contains an ID and some one dollar bills.'),
(13, 	'Very Expensive Name Brand Bag', 	13, 'LV logo'), 
(14, 	'Philosophy Notebook', 				8, 	'Red pen was used throughout.'), 
(15, 	'T shirt', 							11, 'Long sleeves. Black with brown stripes.'),
(16, 	'Black leather wallet', 			12, 'Contains some one hundred dollar bills.'),
(17, 	'Coach Bag', 						13, 'Brown with black Coach logos');
 
--Inserts into locationTypes
INSERT INTO locationTypes (name) VALUES 
('Dining Hall/Area'),
('Academic Building'),
('Outdoors'),
('Taxi'),
('Bus'),
('Residence Hall'),
('Gym'),
('Library'),
('Bar / Club'),
('Party');

--Inserts into schools
INSERT INTO schools (name, email_domain, address) VALUES 
('Marist College', 		'marist.edu', 	'Poughkeepsie NY 12601'), 
('Boston College', 		'bc.edu', 		'Chesnut Hill, MA 02467'), 
('Boston University', 	'bu.edu', 		'Boston MA 02215'), 
('Stanford University', 'stanford.edu', 'Stanford CA 94305'), 
('MIT', 				'mit.edu', 		'Cambridge MA 02139'), 
('UCONN', 				'uconn.edu', 	'Storrs CT 06269'), 
('UPENN', 				'upenn.edu', 	'Philadelphia PA 19104'), 
('Harvard', 			'harvard.edu', 	'Cambridge MA 02138'), 
('Yale', 				'yale.edu', 	'New Haven CT 06520'), 
('NYU', 				'nyu.edu', 		'New York NY 10003');
  
--Inserts into locations
INSERT INTO locations (name, school_id, locationType_id) VALUES 
('Cabaret', 					1, 		1), 
('Dining Hall', 				1, 		1), 
('Donnelly Hall', 				1, 		2), 
('Engineering Building', 		6, 		8), 
('The Library', 				6, 		2), 
('BC Gym', 						2, 		7), 
('Upper Housing A', 			2, 		6), 
('Crazy party on 4th street', 	10, 	10), 
('Near campus entrance', 		10, 	3),
('BU Bus 4', 					3, 		5), 
('MIT Famous Bar', 				5, 		9);

--Inserts into registeredUsers
INSERT INTO registeredUsers (user_id, first_name, last_name) VALUES
(1, 	'Hannah', 	'Youssef'),
(2, 	'Alan', 	'Labouseur'),
(3, 	'Steve', 	'Jobs'),
(4, 	'Steve', 	'Wozniak'),
(5, 	'Zimri', 	'Mayfield'),
(6, 	'Beyonce', 	'Knowles'),
(7, 	'Jay', 		'Z'),
(8, 	'Donald', 	'Trump'),
(9, 	'Justin', 	'Bieber'), 
(10, 	'John', 	'Smith'), 
(11, 	'Frankie', 	'Fox'), 
(12, 	'Bill', 	'Gates');

--Inserts into reported
INSERT INTO reported (user_id, item_id, location_id) VALUES 
(1, 	1, 		3), 
(2, 	2, 		1),
(3, 	10, 	6), 
(4, 	8, 		6), 
(5, 	4, 		4), 
(6, 	5, 		5),
(7, 	12, 	11),
(8, 	3, 		5),
(9, 	6, 		8),
(10, 	7, 		9),
(11, 	9, 		10),
(12, 	13, 	2);

--Inserts into recovered
INSERT INTO recovered (registered_user_id, item_id, timeRecovered) VALUES 
(1, 	3, 	'2017-12-02'), 
(1, 	6, 	'2017-12-03'), 
(1, 	8, 	'2017-12-04'), 
(1, 	11, '2017-12-02'), 
(3, 	14, '2017-12-01'), 
(3, 	15, '2017-12-03'), 
(4, 	16, '2017-12-01'), 
(4, 	17, '2017-12-02'), 
(4, 	4, '2017-12-03'), 
(12, 	7, '2017-12-01');

--Stored Procedures
CREATE OR REPLACE FUNCTION anonymouslyReportedItemsForSchool(schoolName VARCHAR(256))
RETURNS TABLE(itemName varchar(256), itemType varchar(256), reportedLocationName varchar(256)) AS $$
BEGIN
	RETURN QUERY SELECT items.name, itemTypes.name, locations.name 
      FROM items, itemTypes, locations, reported,  anonymousUsers, schools
      WHERE itemTypes.itemType_id = items.itemType_id
      AND items.item_id = reported.item_id
      AND reported.location_id = locations.location_id
      AND reported.user_id = anonymousUsers.user_id
      AND locations.school_id = schools.school_id
      AND schools.name = schoolName;
END;
$$ LANGUAGE PLPGSQL;

CREATE OR REPLACE FUNCTION goodReputationUsers()
RETURNS TABLE(firstName VARCHAR(256),  lastName VARCHAR(256)) AS $$
BEGIN
	RETURN QUERY SELECT registeredUsers.first_name, registeredUsers.last_name
				FROM registeredUsers, (SELECT count(*), reported.user_id 
FROM reported, recovered
WHERE reported.item_id = recovered.item_id
AND reported.user_id IN (SELECT registeredUsers.user_id 
FROM registeredUsers) 
GROUP BY reported.user_id 
HAVING count(*) > 1
     ) AS goodUsers
WHERE goodUsers.user_id = registeredUsers.user_id;
END;			      
$$ LANGUAGE PLPGSQL;

CREATE OR REPLACE FUNCTION currentlyLostItems ()
RETURNS TABLE(id INT, name VARCHAR(256)) AS $$
BEGIN
RETURN QUERY SELECT items.item_id, items.name FROM items, 
(SELECT reported.item_id reported_item_id, recovered.item_id recovered_item_id 
FROM reported LEFT OUTER JOIN recovered 
ON recovered.item_id = reported.item_id 
WHERE recovered.item_id IS NULL) AS lostItems
WHERE lostItems.reported_item_id = items.item_id;
END;			      
$$ LANGUAGE PLPGSQL;

--Triggers
CREATE OR REPLACE FUNCTION delete_anonymous_user() RETURNS TRIGGER AS $_$
	BEGIN
		DELETE FROM users WHERE users.user_id = OLD.user_id;
		RETURN OLD;
	END; 
	$_$ LANGUAGE PLPGSQL;

CREATE TRIGGER remove_anonoymous_user AFTER DELETE ON anonymousUsers 
FOR EACH ROW EXECUTE PROCEDURE delete_anonymous_user();

--QUERIES
select *
from anonymousUsers;

select *
from itemTypes;

select *
from items;

select *
from locationTypes;

select *
from locations;

select *
from recovered;

select *
from registeredUsers;

select *
from reported;

select *
from schools;

select *
from users;

--VIEWS
CREATE VIEW CurrentReporters AS
	SELECT lostItems.name AS Item_Name, users.email 
	AS Reporter_Contact
	FROM currentlyLostItems() AS lostItems, users, reported
 	WHERE lostItems.id = reported.item_id
	AND reported.user_id = users.user_id;

CREATE VIEW OldUnverifiedUsers AS
	SELECT users.*
	FROM users
	WHERE users.verified = '0'
	AND users.join_date < now() - INTERVAL '1 month';

CREATE VIEW MostCommonLostLocation AS
	SELECT count(*), locations.name 
	FROM reported, locations 
	WHERE reported.location_id = locations.location_id
	GROUP BY locations.name
	ORDER BY count(*) DESC;
	

--SECURITY
--admin
CREATE ROLE admin;
GRANT SELECT, INSERT, UPDATE, DELETE
ON ALL TABLES IN SCHEMA PUBLIC
TO admin;

--viewer
CREATE ROLE viewer;
GRANT SELECT
ON ALL TABLES IN SCHEMA PUBLIC
TO viewer;


--Reports and their Queries
--Locations in Schools
SELECT schools.name, locations.name
FROM schools, locations
WHERE schools.school_id = locations.school_id;

--All Lost Items Current and Past
SELECT schools.name, items.name
FROM schools, items, locations, reported
WHERE reported.item_id = items.item_id
AND reported.location_id = locations.location_id
AND locations.school_id = schools.school_id;

--Most Common Lost Item Type
SELECT count(*), itemTypes.name 
FROM itemTypes, items, reported
WHERE reported.item_id = items.item_id
AND items.itemType_id = itemTypes.itemType_id
GROUP BY itemTypes.name
ORDER BY count(*) DESC;
