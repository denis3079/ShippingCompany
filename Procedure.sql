GO
CREATE PROCEDURE ProcTicketHA1548

AS
BEGIN 
-- ������ ���������� (����� ���������� ����, ��������� ������ �� ����, �� ��������� ������ �� ����) 
 
 DECLARE 
 @TotalNumberCabins INT,
 @TicketsSold INT,
 @TicketsNotPurchased INT

    -- ���������� ����� ���������� ���� �� �������
    SELECT @TotalNumberCabins = SUM (TotalNumberCabins) FROM E_12_Cabin_ship
    WHERE NameShip = 'Denver'
	-- ���������� ���������� ��������� ������� �� ����
	SELECT @TicketsSold = COUNT(*) FROM E_6_Ticket
    WHERE NameShip = 'Denver' AND Voyage_number = 'HA 1548'
	-- ���������� ���������� �� ��������� ������� �� ����
	SET @TicketsNotPurchased = @TotalNumberCabins - @TicketsSold
	-- ���� ������� �� ��������� ������ �� ����, ����� ��������� �� ����� ��������
	if @TicketsNotPurchased > 0
	BEGIN
	UPDATE dbo.E_6_Ticket set @TicketsNotPurchased = @TicketsNotPurchased
	(SELECT TOP (@TicketsNotPurchased)
	Number_of_ticket, Voyage_number = 'HA 1548', E_5_Client.Customers_internal_account, NameShip = 'Denver', Class, Port_departure, Port_arrival, TicketPrice
    FROM E_6_Ticket
    LEFT OUTER JOIN E_5_Client ON E_5_Client.Customers_internal_account = E_6_Ticket.Number_of_ticket
    ) ORDER BY Customers_internal_account ASC
	END 
END