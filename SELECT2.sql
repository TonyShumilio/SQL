--Количество треков, вошедших в альбомы 2019-2020 годов.

SELECT count(*) AS track_count
FROM track
JOIN album ON track.album_id = album.id
WHERE album.release_year BETWEEN 2019 AND 2020;


--Все исполнители, которые не выпустили альбомы в 2020 году.

SELECT first_name
FROM artist
WHERE id NOT IN (
SELECT id
FROM albums_artists
JOIN album ON albums_artists.album_id = album.id
WHERE release_year = 2020 )
ORDER BY artist.first_name;


--Выборка треков, названия которых содержат слово "мой" или "my".

SELECT name
FROM track
WHERE name ~* '\y(мой|my)\y';