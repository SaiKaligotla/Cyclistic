
SELECT 
	CONVERT(date, started_at) AS Trip_Start_Date,
	CONVERT(time, started_at) AS Trip_Start_Time
FROM
	Cyclistic..Divvy_Trips_2020_Q1


ALTER TABLE Cyclistic..Divvy_Trips_2020_Q1
	ADD
		Trip_Start_Date date
ALTER TABLE Cyclistic..Divvy_Trips_2020_Q1
	ADD
		Trip_Start_time time


UPDATE Cyclistic..Divvy_Trips_2020_Q1
SET Trip_Start_Date = CONVERT(date, started_at),
    Trip_Start_Time = CONVERT(time, started_at);

--ALTER TABLE Cyclistic..Divvy_Trips_2020_Q1
--	DROP COLUMN Trip_Start_Date, Trip_Start_Time



SELECT *
FROM
	Cyclistic..Divvy_Trips_2020_Q1

--DELETE 
--FROM
--	Cyclistic..Divvy_Trips_2020_Q1
--WHERE
--	end_station_name IS NULL