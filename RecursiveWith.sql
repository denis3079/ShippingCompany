WITH Rec AS 
-- ancor member expression
(SELECT 1 AS num, * FROM dbo.E_3_Port WHERE Parent_port IS NULL
UNION ALL
-- recursive member expression
SELECT Rec.num + 1 AS num, b2.*
FROM dbo.E_3_Port AS b2, Rec WHERE b2.Parent_port = Rec.Port_name)
SELECT * FROM Rec