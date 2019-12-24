BEGIN TRANSACTION;
UPDATE dbo.E_9_Type_cargo 
SET TransportCost1Ton -= 500
WHERE NameCargo = 'alcohol'
IF (@@error <> 0) -- Отменить транзакцию, если есть ошибки 
        ROLLBACK
SELECT 'Транзакция' AS "Состояние", 
          NameCargo AS "Наименование груза", 
         TransportCost1Ton AS "Стоимость транспортировки 1 тонны",
@@SPID AS "Процесс",
@@TRANCOUNT AS "Количество транзакций" 
FROM dbo.E_9_Type_cargo WHERE NameCargo='alcohol';

UPDATE dbo.E_9_Type_cargo
SET TransportCost1Ton += 500
WHERE NameCargo = 'acid';
    IF (@@error <> 0) -- Отменить транзакцию, если есть ошибки 
        ROLLBACK
COMMIT TRANSACTION; -- Завершение транзакции
SELECT 'После транзакции' AS "Состояние", 
         NameCargo AS "Наименование груза", 
         TransportCost1Ton AS "Стоимость транспортировки 1 тонны",
@@SPID AS "Процесс",
@@TRANCOUNT AS "Количество транзакций"
FROM dbo.E_9_Type_cargo WHERE NameCargo = 'acid';



