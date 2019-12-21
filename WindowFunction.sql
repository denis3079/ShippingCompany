DECLARE 
 @DayVoyage INT
 -- Enter a variable voyage duration
SELECT @DayVoyage=DATEDIFF(day, E_4_Voyage.DepartureDate, E_4_Voyage.ArrivalDate)
FROM dbo.E_4_Voyage
-- determine the duration of the voyage for each ship (days)
SELECT Voyage_number, 
            DATEDIFF(day, DepartureDate, ArrivalDate) AS DayVoyage,
			AVG(@DayVoyage) OVER (ORDER BY Voyage_number) AS AVG
FROM dbo.E_4_Voyage 
-- using the window function we get the average duration of all voyage
