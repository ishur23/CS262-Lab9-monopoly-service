--
-- This SQL script builds a monopoly database, deleting any pre-existing version.
--
-- @author Isaac Hur
-- @version Fall, 2025
--
--Monopoly Database Schema
--
--  Game(ID, time)
--  Player(ID, emailAddress, name)
--  PlayerGame(gameID, playerID, score, cash, positon)
--  Property(ID, name, color, price, rent)
--  PlayerProperty(playerID, gameID, propertyID, houses, hotels)
--
-- Drop previous versions of the tables if they they exist, in reverse order of foreign keys.

DROP TABLE IF EXISTS PlayerProperty;
DROP TABLE IF EXISTS PlayerGame;
DROP TABLE IF EXISTS Game;
DROP TABLE IF EXISTS Player;
DROP TABLE IF EXISTS Property;

-- Create the schema.
CREATE TABLE Game (
	ID integer PRIMARY KEY,
	time timestamp
	);

CREATE TABLE Player (
	ID integer PRIMARY KEY, 
	emailAddress varchar(50) NOT NULL,
	name varchar(50)
	);

CREATE TABLE Property (
    ID integer PRIMARY KEY,
    name varchar(50) NOT NULL,
    color varchar(20),
    price integer,
    rent integer
    );

CREATE TABLE PlayerGame (
	gameID integer REFERENCES Game(ID), 
	playerID integer REFERENCES Player(ID),
	score integer,
    cash integer,
    position integer REFERENCES Property(ID),
    PRIMARY KEY (gameID, playerID)
	);

CREATE TABLE PlayerProperty (
    gameID integer REFERENCES Game(ID),
    playerID integer REFERENCES Player(ID),
    propertyID integer REFERENCES Property(ID),
    houses integer,
    hotels integer,
    PRIMARY KEY (playerID, gameID, propertyID)
    );

-- Allow users to select data from the tables.
GRANT SELECT ON Game TO PUBLIC;
GRANT SELECT ON Player TO PUBLIC;
GRANT SELECT ON PlayerGame TO PUBLIC;
GRANT SELECT ON Property TO PUBLIC;
GRANT SELECT ON PlayerProperty TO PUBLIC;

-- Add sample records.
INSERT INTO Game VALUES (1, '2006-06-27 08:00:00');
INSERT INTO Game VALUES (2, '2006-06-28 13:20:00');
INSERT INTO Game VALUES (3, '2006-06-29 18:41:00');

INSERT INTO Player(ID, emailAddress) VALUES (1, 'me@calvin.edu');
INSERT INTO Player VALUES (2, 'king@gmail.edu', 'The King');
INSERT INTO Player VALUES (3, 'dog@gmail.edu', 'Dogbreath');

INSERT INTO Property VALUES (0, 'Go', 'None', 0, 0);
INSERT INTO Property VALUES (1, 'Mediterranean Avenue', 'Brown', 60, 2);
INSERT INTO Property VALUES (2, 'Baltic Avenue', 'Brown', 60, 4);   

INSERT INTO PlayerGame VALUES (1, 1, 0.00, 1500.00, 0);
INSERT INTO PlayerGame VALUES (1, 2, 600.00, 1500.00, 1);
INSERT INTO PlayerGame VALUES (1, 3, 2350.00, 1500.00, 2);
INSERT INTO PlayerGame VALUES (2, 1, 1000.00, 2000.00, 1);
INSERT INTO PlayerGame VALUES (2, 2, 300.00, 2000.00, 1);
INSERT INTO PlayerGame VALUES (2, 3, 500.00, 2500.00, 0);
INSERT INTO PlayerGame VALUES (3, 2, 900.00, 3000.00, 2);
INSERT INTO PlayerGame VALUES (3, 3, 5500.00, 3500.00, 2);

INSERT INTO PlayerProperty VALUES (1, 1, 1, 0, 1);
INSERT INTO PlayerProperty VALUES (1, 2, 2, 2, 0);
INSERT INTO PlayerProperty VALUES (2, 1, 1, 0, 0);
INSERT INTO PlayerProperty VALUES (2, 3, 2, 1, 0);
INSERT INTO PlayerProperty VALUES (3, 2, 2, 0, 1);

