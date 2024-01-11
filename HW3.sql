-- 1. Количество исполнителей в каждом жанре.

    SELECT g_1."name" "Жанр",
           count(artist_id) "Количество исполнителей"
      FROM artists_genres AS ag
      JOIN genre AS g_1
        ON g_1.id = genre_id
  GROUP BY g_1."name"  
  ORDER BY count(artist_id) DESC ;
 

 -- 2. Количество треков, вошедших в альбомы 2019-2020 годов.
 
    SELECT a_1.release_year "Год выпуска альбомов",
           count(t_1.id) "Количество треков в альбомах"
      FROM album AS a_1
      JOIN track AS t_1
        ON t_1.album_id = a_1.id
     WHERE a_1.release_year BETWEEN 2019 AND 2020        
  GROUP BY a_1.release_year ;

 
 -- 3. Средняя продолжительность треков по каждому альбому.
 
    SELECT a_1.title "Альбом",
           concat(((sum(t_1.length)/count(t_1.id))/60)::TEXT,':',((sum(t_1.length)/count(t_1.id)) - ((sum(t_1.length)/count(t_1.id))/60)*60)::TEXT) "Средняя продолжительность трека"
      FROM track AS t_1
      JOIN album AS a_1
        ON a_1.id = t_1.album_id 
  GROUP BY a_1.title 
  ORDER BY a_1.title;
 
 
 -- 4. Все исполнители, которые не выпустили альбомы в 2020 году

SELECT DISTINCT a.first_name FROM artist a 
  WHERE a.first_name NOT IN (
    SELECT DISTINCT a.first_name FROM artist a 
    LEFT JOIN albums_artists aa ON a.id = aa.artist_id
    LEFT JOIN collection c ON c.id = aa.album_id 
    WHERE c.release_year = 2020
    )
  ORDER BY a.first_name;
 

 -- 5. Названия сборников, в которых присутствует конкретный исполнитель
 --    Пусть это будет "НА-НА"
    
    UPDATE track -- Надо добавить принадлежность к альбомам для некоторых треков
       SET album_id = 5
     WHERE id BETWEEN 38 AND 42;
    
    SELECT c_1.title "Название сборника"
      FROM collection AS c_1
      JOIN collections_tracks AS c_t 
        ON c_t.collection_id = c_1.id 
     WHERE c_t.track_id IN 
     		(SELECT t_1.id 
     		   FROM track AS t_1
     		   JOIN albums_artists AS a_a
     		     ON a_a.album_id = t_1.album_id
     		   JOIN artist AS a_1
     		     ON a_1.id = a_a.artist_id
     		  WHERE a_1.alias = 'НА-НА')
  GROUP BY c_1.title ;
 
