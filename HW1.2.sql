
CREATE TABLE IF NOT EXISTS album (
	id serial PRIMARY KEY,
	title varchar(60) NOT NULL,
	release_year int);

CREATE TABLE IF NOT EXISTS genre (
	id serial PRIMARY KEY,
	name varchar(60) NOT NULL);

CREATE TABLE IF NOT EXISTS artist (
	id serial PRIMARY KEY,
	first_name varchar(40) NOT NULL,
	second_name varchar(40) NOT NULL,
	alias varchar(40));

CREATE TABLE IF NOT EXISTS collection (
	id serial PRIMARY KEY,
	title varchar(60) NOT NULL,
	release_year int);

CREATE TABLE IF NOT EXISTS track (
	id serial PRIMARY KEY,
	name varchar(60) NOT NULL,
	length integer NOT NULL,
	album_id int REFERENCES album(id));

CREATE TABLE IF NOT EXISTS collections_tracks (
	track_id int NOT NULL REFERENCES track(id),
	collection_id int NOT NULL REFERENCES collection(id),
	CONSTRAINT pk_collections_tracks PRIMARY KEY (collection_id, track_id)
);

CREATE TABLE IF NOT EXISTS albums_artists (
	album_id int NOT NULL REFERENCES album(id),
	artist_id int NOT NULL REFERENCES artist(id),
	CONSTRAINT pk_albums_artists PRIMARY KEY (album_id, artist_id)
);

CREATE TABLE IF NOT EXISTS artists_genres (
	genre_id int NOT NULL REFERENCES genre(id),
	artist_id int NOT NULL REFERENCES artist(id),
	CONSTRAINT pk_artists_genres PRIMARY KEY (artist_id, genre_id)
);
