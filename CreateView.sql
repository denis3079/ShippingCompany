CREATE VIEW Voyage  
AS   
SELECT Client.Customers_internal_account, Client.PatronimicName, Client.FirstName,  MIN(Voyage.DepartureDate) AS FirstVoyage, 
MAX(Voyage.DepartureDate) AS LastVoyage, MAX(Ticket.TicketPrice) AS ExpensiveVoyage, 
COUNT(Voyage.Voyage_number) AS TotalVoyage
FROM E_5_Client AS Client 
JOIN E_6_Ticket AS Ticket ON (Ticket.Customers_internal_account = Client.Customers_internal_account)    
JOIN E_4_Voyage AS Voyage ON (Voyage.Voyage_number = Ticket.Voyage_number) 
GROUP BY Client.Customers_internal_account, Client.PatronimicName, Client.FirstName