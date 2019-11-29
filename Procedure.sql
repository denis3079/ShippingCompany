GO
CREATE PROCEDURE ProcTicketHA1548

AS
BEGIN 
-- ¬водим переменные (общее количество кают, проданные билеты на рейс, не проданные билеты на рейс) 
 
 DECLARE 
 @TotalNumberCabins INT,
 @TicketsSold INT,
 @TicketsNotPurchased INT

    -- ќпредел€ем общее количество кают на корабле
    SELECT @TotalNumberCabins = SUM (TotalNumberCabins) FROM E_12_Cabin_ship
    WHERE NameShip = 'Denver'
	-- ќпредел€ем количество проданных билетов на рейс
	SELECT @TicketsSold = COUNT(*) FROM E_6_Ticket
    WHERE NameShip = 'Denver' AND Voyage_number = 'HA 1548'
	-- ќпредел€ем количество не купленных билетов на рейс
	SET @TicketsNotPurchased = @TotalNumberCabins - @TicketsSold
	-- ≈сли имеютс€ не купленные билеты на рейс, тогда реализуем их новым клиентам
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