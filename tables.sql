-- Deleting tables
DROP TABLE IF EXISTS albums CASCADE;
DROP TABLE IF EXISTS tracks CASCADE;
DROP TABLE IF EXISTS albums_tracks;

-- Building the music database with tables
CREATE TABLE albums (
    album_id serial PRIMARY KEY,
    album_title text NOT NULL,
    album_artist text NOT NULL,
    created_at timestamp(0) with time zone NOT NULL DEFAULT NOW()
);

CREATE TABLE tracks(
    track_id serial PRIMARY KEY,
    track_title text NOT NULL,
    length time NOT NULL,
    created_at timestamp(0) with time zone NOT NULL DEFAULT NOW()
);

CREATE TABLE albums_tracks(
    album_track_id serial PRIMARY KEY,
    album_id integer REFERENCES albums(album_id),
    track_id integer REFERENCES tracks(track_id),
    created_at timestamp(0) with time zone NOT NULL DEFAULT NOW()
);

-- Adding data to the tables
INSERT INTO albums(album_title, album_artist)
VALUES('Anti', 'Rihanna'),
      ('Views', 'Drake'),
      ('Rare', 'Selena Gomez'),
      ('Happier Than Ever', 'Billie Eilish'),
      ('Revival', 'Selena Gomez'),
      ('Esquemas', 'Becky G'),
      ('V', 'Maroon 5'),
      ('Solar Power', 'Lorde'),
      ('Laundry Service', 'Shakira'),
      ('Chromatica', 'Lady Gaga'),
      ('Sweetner', 'Ariana Grande');

INSERT INTO tracks(track_title, length)
VALUES('Work', '00:03:39'),
      ('A Sweeter Place', '00:04:23'),
      ('Crowed Room', '00:03:06'),
      ('Good for You', '00:03:14'),
      ('Hands to Yourself', '00:03:14'),
      ('Male Fantasy', '00:03:16'),
      ('Flashback', '00:03:26'),
      ('My Heart Is Open', '00:03:57'),
      ('Sugar', '00:03:55'),
      ('Maps', '00:03:10'),
      ('Big Star', '00:02:47'),
      ('Whenever, Wherever', '00:03:16'),
      ('Fool', '00:03:50'),
      ('Rain on Me', '00:03:02'),
      ('Fun Tonight', '00:02:53');

INSERT INTO albums_tracks(album_id, track_id)
VALUES(1, 1),
      (2, 1),
      (3, 2),
      (3, 3),
      (4, 6),
      (5, 4),
      (5, 5),
      (6, 7),
      (7, 8),
      (7, 9),
      (7, 10),
      (8, 11),
      (9, 12),
      (9, 13),
      (10, 14),
      (10, 15),
      (11, 14);

-- Queries

-- The albums and the tracks that they belong to
/*
SELECT A.album_title AS "Name of Album", T.track_title AS "Name of Track"
FROM albums AS A 
INNER JOIN albums_tracks AS ASTS 
ON A.album_id = ASTS.album_id
INNER JOIN tracks AS T
ON ASTS.track_id = T.track_id
ORDER BY A.album_title ASC;
*/

-- The albums or albums that each track belongs to 
/*
SELECT T.track_title AS "Name of Tracks", A.album_title AS "Name of Album"
FROM tracks AS T 
INNER JOIN albums_tracks AS ASTS
ON T.track_id = ASTS.track_id
INNER JOIN albums AS A
ON ASTS.album_id = A.album_id
ORDER BY T.track_title ASC;
*/

-- The number of songs an album has 
/*
SELECT A.album_title AS "Name of Album", COUNT (ASTS.track_id) AS "Number of Tracks"
FROM albums AS A 
INNER JOIN albums_tracks AS ASTS
ON A.album_id = ASTS.album_id
GROUP BY A.album_title;
*/

-- The number of albums a particular track is in
SELECT T.track_title AS "Name of Track", COUNT(ASTS.album_id) AS "Name of Album"
FROM tracks AS T 
INNER JOIN albums_tracks AS ASTS
ON T.track_id = ASTS.track_id
GROUP BY T.track_title;
