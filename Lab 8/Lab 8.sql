-- Hannah Youssef
-- Database Management
-- Alan Labouseur
-- Lab #8
-- 13 November 2017

-- EON Database Creation Script - Movie Data

-- People Table
-- pid --> firstName, lastName
CREATE TABLE People (
  pid SERIAL NOT NULL,
  firstName TEXT NOT NULL,
  lastName TEXT NOT NULL,

  PRIMARY KEY(pid)
);

-- MarriedTo Table
CREATE TABLE MarriedTo(
  pid1 INTEGER NOT NULL REFERENCES People(pid),
  pid2 INTEGER NOT NULL REFERENCES People(pid),

  PRIMARY KEY(pid1, pid2)
);

-- List of constant state codes
CREATE TABLE StateCodes(
  code varchar(2) NOT NULL,

  PRIMARY KEY(code)
);

-- AddressablePeople Table
-- pid --> address, address2, city, state, zipCode
CREATE TABLE AddressablePeople (
  pid INTEGER NOT NULL REFERENCES People(pid),
  address TEXT NOT NULL,
  address2 TEXT NOT NULL,
  city TEXT NOT NULL,
  state VARCHAR(2) NOT NULL REFERENCES StateCodes(code),
  zipCode VARCHAR(6) NOT NULL, -- 6 digit zip code

  PRIMARY KEY(pid)
);

-- Colors Table (eye, hair, other colors)
-- color -->
CREATE TABLE Colors(
  color TEXT NOT NULL PRIMARY KEY
);

-- HairColors
-- color -->
CREATE TABLE HairColors(
  color TEXT NOT NULL PRIMARY KEY REFERENCES Colors(color)
);

-- EyeColors
-- color -->
CREATE TABLE EyeColors(
  color TEXT NOT NULL PRIMARY KEY REFERENCES Colors(color)
);

-- ScreenActorsGuildAnniversaries
-- anniversary -->
CREATE TABLE ScreenActorsGuildAnniversaries(
  anniversary DATE NOT NULL PRIMARY KEY
);

-- Actors (misc info)
-- pid --> hairColor, favoriteColor, eyeColor, weightUSPounds, heightInches, guildAnniversary
CREATE TABLE Actors(
  pid INTEGER NOT NULL REFERENCES AddressablePeople(pid), -- actors have addresses
  hairColor TEXT REFERENCES HairColors(color), -- alternative to check constraint
  favoriteColor TEXT REFERENCES Colors(color), -- alternative to check constraint
  eyeColor TEXT REFERENCES EyeColors(color),   -- alternative to check constraint
  weightUSPounds INTEGER,
  heightInches INTEGER,
  guildAnniversary DATE REFERENCES ScreenActorsGuildAnniversaries(anniversary),
  
  PRIMARY KEY(pid)
);

-- Movies
-- mid --> yearReleased, MPAANumber, domesticBOSalesUSD, foreignBOSalesUSD, DVDSalesUSD, bluRaySalesUSD
CREATE TABLE Movies(
  mid SERIAL NOT NULL,
  yearReleased INTEGER NOT NULL,
  MPAANumber INTEGER NOT NULL UNIQUE,
  domesticBOSalesUSD MONEY,
  foreignBOSalesUSD MONEY,
  DVDSalesUSD MONEY,
  bluRaySalesUSD MONEY,

  PRIMARY KEY(mid)
);

-- ActedIn
-- (actorId, mId) -->
CREATE TABLE ActedIn(
  actorId INTEGER NOT NULL REFERENCES Actors(pid),
  mId INTEGER NOT NULL REFERENCES Movies(mid),

  PRIMARY KEY(actorId, mId)
);

-- LensMakers
-- lmId --> name
CREATE TABLE LensMakers(
  lmId SERIAL NOT NULL,
  name TEXT NOT NULL,

  PRIMARY KEY(lmId)
);

-- DirectorsGuildAnniversaries
-- anniversary -->
CREATE TABLE DirectorsGuildAnniversaries(
  anniversary DATE NOT NULL PRIMARY KEY
);

-- Directors
-- pid --> favoriteLensMaker, guildAnniversary
CREATE TABLE Directors(
  pid INTEGER REFERENCES AddressablePeople(pid),
  favoriteLensMaker INTEGER REFERENCES LensMakers(lmId),
  guildAnniversary DATE REFERENCES DirectorsGuildAnniversaries(anniversary),

  PRIMARY KEY(pid)
);

-- Film Schools
-- fsId --> name
CREATE TABLE FilmSchools(
  fsId SERIAL NOT NULL,
  name TEXT NOT NULL,

  PRIMARY KEY(fsID)
);

-- DirectorFilmSchools
-- directorId, fsId --> [relates directors who attended film schools]
CREATE TABLE DirectorFilmSchools(
  directorId INTEGER NOT NULL REFERENCES Directors(pid),
  fsId INTEGER NOT NULL REFERENCES FilmSchools(fsId),

  PRIMARY KEY(directorId, fsId)
);

-- MovieDirectors
-- mId, directorId
CREATE TABLE MovieDirectors(
  mId INTEGER NOT NULL REFERENCES Movies(mId),
  directorId INTEGER NOT NULL REFERENCES Directors(pid),

  PRIMARY KEY(mId, directorId)
);


--- Write a query to show all the directors wtih whom actor "Roger Moore" has worked.


SELECT md.directorId, p.firstName, p.lastName
FROM MovieDirectors md
INNER JOIN People p
ON md.directorId = p.pid
WHERE mId in (
  SELECT mId
  FROM ActedIn
  WHERE actorId in (
    -- Select Roger Moore
    SELECT a.pid
    FROM People p
    INNER JOIN Actors a
    ON p.pid = a.pid
    WHERE p.firstName = 'Roger' AND p.lastName = 'Moore'
  )
);
