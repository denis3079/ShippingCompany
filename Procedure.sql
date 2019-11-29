GO
CREATE PROCEDURE ProcTicketHA1548

AS
BEGIN 
-- Enter variables (total number cabins, tickets sold, tickets not purchased) 
 
 DECLARE 
 @TotalNumberCabins INT,
 @TicketsSold INT,
 @TicketsNotPurchased INT

    -- Determine the total number of cabins on the ship
    SELECT @TotalNumberCabins = SUM (TotalNumberCabins) FROM E_12_Cabin_ship
    WHERE NameShip = 'Denver'
	-- Determine the number of tickets sold for the voyage
	SELECT @TicketsSold = COUNT(*) FROM E_6_Ticket
    WHERE NameShip = 'Denver' AND Voyage_number = 'HA 1548'
	-- Determine the number of tickets not purchased
	SET @TicketsNotPurchased = @TotalNumberCabins - @TicketsSold
	-- If there are not purchased voyage tickets, then we will sell them to new customers
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
