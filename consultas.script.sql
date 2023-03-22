USE LemonMusic
GO
---Listar las pistas (tabla Track) con precio mayor o igual a 1€
SELECT T.TrackId, T.Name, T.UnitPrice
FROM Track T
WHERE T.UnitPrice > 0.99;
---Listar las pistas de más de 4 minutos de duración
SELECT T.TrackId, T.Name, T.Milliseconds
FROM Track T
WHERE T.Milliseconds > 240000;
---Listar las pistas que tengan entre 2 y 3 minutos de duración
SELECT T.TrackId, T.Name, T.Milliseconds
FROM Track T
WHERE T.Milliseconds BETWEEN 120000 AND 180000;
---Listar las pistas que uno de sus compositores (columna Composer) sea Mercury
SELECT T.TrackId, T.Name, T.Composer
FROM Track T
WHERE T.Composer LIKE '%Mercury%';
---Calcular la media de duración de las pistas (Track) de la plataforma
SELECT AVG(T.Milliseconds) as MediaDuracion
FROM Track T;
---Listar los clientes (tabla Customer) de USA, Canada y Brazil
SELECT C.CustomerId, C.FirstName, C.LastName, C.Country
FROM Customer C
WHERE C.Country IN ('USA', 'Canada', 'Brazil');
---Listar todas las pistas del artista 'Queen' (Artist.Name = 'Queen')
SELECT T.TrackId, T.Name, T.Composer
FROM Track T
INNER JOIN Artist A
	ON T.Composer = A.Name
WHERE A.Name = 'Queen';
---Listar las pistas del artista 'Queen' en las que haya participado como compositor David Bowie
SELECT T.TrackId, T.Name, T.Composer
FROM Track T
WHERE T.Composer LIKE '%Queen%David Bowie%';
---Listar las pistas de la playlist 'Heavy Metal Classic'
SELECT T.TrackId, T.Name 
FROM Track T
INNER JOIN PlaylistTrack PT
	ON T.TrackId = PT.TrackId
INNER JOIN Playlist P
	ON PT.PlaylistId = p.PlaylistId
WHERE P.Name = 'Heavy Metal Classic';
---Listar las playlist junto con el número de pistas que contienen
SELECT P.Name, COUNT(*) AS N_Pistas
FROM Playlist P
INNER JOIN PlaylistTrack PT
	ON P.PlaylistId = PT.PlaylistId
GROUP BY P.PlaylistId, P.Name
---Listar las playlist (sin repetir ninguna) que tienen alguna canción de AC/DC
SELECT DISTINCT P.Name
FROM Playlist P
INNER JOIN PlaylistTrack PT
	ON P.PlaylistId = PT.PlaylistId
INNER JOIN Track T
	ON PT.TrackId = T.TrackId
WHERE T.Composer = 'AC/DC'
---Listar las playlist que tienen alguna canción del artista Queen, junto con la cantidad que tienen
SELECT P.Name, COUNT(*) AS N_Pistas
FROM Playlist P
INNER JOIN PlaylistTrack PT
	ON P.PlaylistId = PT.PlaylistId
	INNER JOIN Track T
	ON PT.TrackId = T.TrackId
WHERE T.Composer LIKE '%Queen%'
GROUP BY P.PlaylistId, P.Name
---Listar las pistas que no están en ninguna playlist
SELECT T.Name
FROM Track T
RIGHT JOIN PlaylistTrack PT
	On T.TrackId = PT.TrackId
WHERE PT.PlaylistId IS NULL
---Listar los artistas que no tienen album
SELECT AR.Name
FROM Artist AR
FULL JOIN Album AL
	ON AR.ArtistId = AL.ArtistId
WHERE AL.AlbumId IS NULL
---Listar los artistas con el número de albums que tienen
SELECT DISTINCT AR.Name, COUNT(AL.AlbumId) AS N_Albums
FROM Artist AR
FULL JOIN Album AL
	ON AR.ArtistId = AL.ArtistId
GROUP BY AR.Name