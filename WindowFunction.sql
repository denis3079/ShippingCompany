DECLARE 
 @DayVoyage INT
 -- ������ ���������� ����������������� �����
SELECT @DayVoyage=DATEDIFF(day, E_4_Voyage.DepartureDate, E_4_Voyage.ArrivalDate)
FROM dbo.E_4_Voyage
-- ��������� ����������������� ����� ��� ������� ������� (�����)
SELECT Voyage_number, 
            DATEDIFF(day, DepartureDate, ArrivalDate) AS DayVoyage,
			AVG(@DayVoyage) OVER (ORDER BY Voyage_number) AS AVG
FROM dbo.E_4_Voyage 
-- ��� ������ ������� ������� �������� ������� ����������������� ���� ������ 