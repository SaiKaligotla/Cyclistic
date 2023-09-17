SELECT TOP(50) *

FROM
	Cyclistic..Divvy_Trips_2020_Q1

----Create a new table and move lat and long columns.

--SELECT	
--	start_lat,
--	start_lng,
--	end_lat,
--	end_lng

--INTO
--	Trip_lat_long
--FROM
--	Cyclistic..Divvy_Trips_2020_Q1

---- ENDS HERE

SELECT *
FROM
	Cyclistic..Trip_lat_long

---- Drop the created columns from the original table
--ALTER TABLE 
--	Cyclistic..Divvy_Trips_2020_Q1
--	DROP COLUMN
--		start_lat, start_lng, end_lng, end_lat
----Ends here

--Update the Trip_lat_long table with ride_id as a primary key

ALTER TABLE
	Cyclistic..Trip_lat_long
ADD
	Trip_id varchar(255)

--Add value to the Tri_id column

--UPDATE
--	Cyclistic..Trip_lat_long
--SET
--	Trip_id = Divvy_Trips_2020_Q1. ride_id
--		FROM
--			Cyclistic..Divvy_Trips_2020_Q1

-- Ends here

--Find Average ride time BY minutes

SELECT 
	trip_start_time,
	trip_end_time,
	AVG(
        (DATEPART(HOUR, Trip_end_time)*60 + DATEPART(MINUTE, Trip_end_time)) +
        (DATEPART(HOUR, Trip_start_time)*60 + DATEPART(MINUTE, Trip_start_time)))
     AS avg_ride_length
FROM Cyclistic..Divvy_Trips_2020_Q1
GROUP BY 
	trip_start_time, trip_end_time
ORDER BY
	avg_ride_length desc

-- Ends Here

--Find the Max ride length in minutes

SELECT
	trip_start_time,
    trip_end_time,
	MAX(
		(DATEPART(HOUR, Trip_end_time)*60 + DATEPART(MINUTE, Trip_end_time)) -
        (DATEPART(HOUR, Trip_start_time)*60 + DATEPART(MINUTE, Trip_start_time))) AS MAX_ride_length
	FROM 
    Cyclistic..Divvy_Trips_2020_Q1
GROUP BY 
    trip_start_time, trip_end_time
ORDER BY
	MAX_ride_length desc

	--Ends Here

-- MIN Ride time in minutes

SELECT
	trip_start_date,
	trip_end_date,
	trip_start_time,
	trip_end_time,
	MIN(ABS(
		(DATEPART(HOUR, Trip_start_time)*60 + DATEPART(MINUTE, Trip_start_time))-
		(DATEPART(HOUR, Trip_end_time)*60 + DATEPART(MINUTE, Trip_end_time)))) AS MIN_ride_length
FROM
	Cyclistic.. Divvy_Trips_2020_Q1

GROUP BY
	trip_start_date,
	trip_end_date,
	trip_start_time,
	trip_end_time
HAVING
	MIN(ABS(
		(DATEPART(HOUR, Trip_start_time)*60 + DATEPART(MINUTE, Trip_start_time))-
		(DATEPART(HOUR, Trip_end_time)*60 + DATEPART(MINUTE, Trip_end_time)))) <> 0
ORDER BY
	MIN_ride_length

--Ends Here

--Find most days used by count

SELECT DISTINCT
	Day_of_week,
	COUNT(Day_of_week) AS day_count

FROM
	Cyclistic..Divvy_Trips_2020_Q1

group by
	dAY_OF_WEEK

ORDER BY
	day_count DESC

--Ends here

--Average to and fro station

SELECT DISTINCT
	start_station_name,
	end_station_name,
	start_station_id,
	end_station_id,
	COUNT (start_station_id) AS count_start_id,
	COUNT (end_station_id) AS count_end_id

FROM
	Cyclistic..Divvy_Trips_2020_Q1

GROUP BY
	start_station_name,
	end_station_name,
	start_station_id,
	end_station_id

ORDER BY
	COUNT_START_ID DESC

--Ends here

--create new table to save station usage details

CREATE TABLE 
	Station_Usage
	(
		start_station_name varchar(255),
		end_station_name varchar(255),
		start_station_id varchar(255),
		end_station_id varchar(255),
	)

DROP TABLE
	Station_Usage
--Ends here

SELECT *

FROM
	Cyclistic..Station_Usage

--Update table

UPDATE Cyclistic..Station_Usage
	SET
		start_station_name = D.start_station_name ,
		end_station_name = D.end_station_name ,
		start_station_id = D.start_station_id ,
		end_station_id = D.end_station_id

FROM
	Cyclistic..Divvy_Trips_2020_Q1 AS D