CREATE TRIGGER triggerInsertShipDbVoyage
ON dbo.E_4_Voyage
AFTER INSERT, UPDATE
AS IF UPDATE (Flotilla)
BEGIN
    IF (SELECT NameShip
                FROM dbo.E_2_Ship, inserted
                WHERE E_2_Ship.NameShip = inserted.Flotilla AND E_2_Ship.Ship_decommissioning_act = 0) IS NULL
	BEGIN 
          ROLLBACK TRANSACTION
	      PRINT 'This ship has been decommissioned. Cannot be added to voyage'
	END
	ELSE 
          PRINT 'This ship has been successfully added to the voyage'
END 