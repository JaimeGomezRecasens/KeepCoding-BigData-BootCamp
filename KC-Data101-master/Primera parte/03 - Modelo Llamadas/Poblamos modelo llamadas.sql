/* Tabla:
	- ODS_HC_CLIENTES

Ya poblada en modelo clientes */

-- TABLA ODS_DM_DEPARTAMENTOS_CC

INSERT INTO ODS_DM_DEPARTAMENTOS_CC (DE_DEPARTAMENTO_CC, FC_INSERT, FC_MODIFICACION)
SELECT DISTINCT UPPER(TRIM(SERVICE)) DE_DEPARTAMENTO_CC, NOW(), NOW()
FROM STAGE.STG_CONTACTOS_IVR
WHERE TRIM(SERVICE);

INSERT INTO ODS_DM_DEPARTAMENTOS_CC VALUES (99, 'DESCONOCIDO', NOW(), NOW());
INSERT INTO ODS_DM_DEPARTAMENTOS_CC VALUES (98, 'NO APLICA', NOW(), NOW());

-- TABLA ODS_DM_AGENTES_CC
INSERT INTO ODS_DM_DEPARTAMENTOS_CC (DE_AGENTE_CC, FC_INSERT, FC_MODIFICACION)
SELECT DISTINCT UPPER(TRIM(AGENT)) DE_AGENTE_CC, NOW(), NOW()
FROM STAGE.STG_CONTACTOS_IVR
WHERE TRIM(AGENT);

INSERT INTO ODS_DM_DEPARTAMENTOS_CC (9998, 'NO APLICA', NOW(), NOW());
INSERT INTO ODS_DM_DEPARTAMENTOS_CC (9999, 'DESCONOCIDO', NOW(), NOW());

-- TABLA ODS_HC_LLAMADAS

INSERT INTO ODS_HC_LLAMADAS
SELECT ID 
, CASE WHEN TRIM(A.PHONE_NUMBER)<>'' THEN TRIM(A.PHONE_NUMBER) ELSE 9999999999 END TELEFONO_LLAMADA
, CASE WHEN TRIM(B.CUSTOMER_ID)<>'' THEN TRIM(B.CUSTOMER_ID) ELSE 999999999 END  ID_CLIENTE
, CASE WHEN TRIM(A.START_DATETIME)<>'' THEN STR_TO_DATE(A.START_DATETIME, '%Y-%m-%d %H:%i:%s') ELSE STR_TO_DATE('9999-12-31','%Y-%m-%d %H:%i:%s') END FC_INICIO_LLAMADA
, CASE WHEN TRIM(A.END_DATETIME)<>'' THEN STR_TO_DATE(A.END_DATETIME, '%Y-%m-%d %H:%i:%s') ELSE STR_TO_DATE('9999-12-31','%Y-%m-%d %H:%i:%s') END FC_FIN_LLAMADA
, D.ID_DEPARTAMENTO_CC
, CASE 
	WHEN A.FLG_TRANSFER = 'True' THEN 0
    WHEN A.FLG_TRANSFER = 'False' THEN 1
    ELSE 'UNDEF'
END  FLG_TRANSFERIDO
, E.ID_AGENTE_CC ID_AGENTE_CC
FROM STAGE.STG_CONTACTOS_IVR A 
INNER JOIN STG_CLIENTES_CRM B
	ON A.PHONE_NUMBER=B.PHONE
INNER JOIN ODS_DM_DEPARTAMENTOS_CC D
	ON A.SERVICE = D.DE_DEPARTAMENTO_CC 
INNER JOIN ODS_DM_AGENTES_CC E
	ON CASE WHEN TRIM(A.AGENT)<>'' THEN TRIM(A.AGENT) ELSE 9999 END=E.DE_AGENTE_CC;

INSERT INTO ODS_DM_DEPARTAMENTOS_CC (9999999999, 'DESCONOCIDO', NOW(), NOW());