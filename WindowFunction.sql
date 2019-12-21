DECLARE 
 @DayVoyage INT
 -- ¬водим переменную продолжительность рейса
SELECT @DayVoyage=DATEDIFF(day, E_4_Voyage.DepartureDate, E_4_Voyage.ArrivalDate)
FROM dbo.E_4_Voyage
-- оредел€ем продолжительность рейса дл€ каждого карабл€ (суток)
SELECT Voyage_number, 
            DATEDIFF(day, DepartureDate, ArrivalDate) AS DayVoyage,
			AVG(@DayVoyage) OVER (ORDER BY Voyage_number) AS AVG
FROM dbo.E_4_Voyage 
-- при помощи оконной функции получаем среднюю продолжительность всех рейсов 