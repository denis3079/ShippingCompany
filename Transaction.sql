BEGIN TRANSACTION;
UPDATE dbo.E_9_Type_cargo 
SET TransportCost1Ton -= 500
WHERE NameCargo = 'alcohol'
IF (@@error <> 0) -- �������� ����������, ���� ���� ������ 
        ROLLBACK
SELECT '����������' AS "���������", 
          NameCargo AS "������������ �����", 
         TransportCost1Ton AS "��������� ��������������� 1 �����",
@@SPID AS "�������",
@@TRANCOUNT AS "���������� ����������" 
FROM dbo.E_9_Type_cargo WHERE NameCargo='alcohol';

UPDATE dbo.E_9_Type_cargo
SET TransportCost1Ton += 500
WHERE NameCargo = 'acid';
    IF (@@error <> 0) -- �������� ����������, ���� ���� ������ 
        ROLLBACK
COMMIT TRANSACTION; -- ���������� ����������
SELECT '����� ����������' AS "���������", 
         NameCargo AS "������������ �����", 
         TransportCost1Ton AS "��������� ��������������� 1 �����",
@@SPID AS "�������",
@@TRANCOUNT AS "���������� ����������"
FROM dbo.E_9_Type_cargo WHERE NameCargo = 'acid';



