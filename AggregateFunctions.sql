SELECT E_2_Ship.NameShip,
        MONTH(E_4_Voyage.DepartureDate) as Month,
		YEAR (E_4_Voyage.DepartureDate) as Year,
		COUNT(*) as Ticket
		FROM E_2_Ship, E_4_Voyage, E_6_Ticket
	    WHERE E_2_Ship.NameShip = E_6_Ticket.NameShip 
		GROUP BY E_2_Ship.NameShip, MONTH(E_4_Voyage.DepartureDate), YEAR (E_4_Voyage.DepartureDate)