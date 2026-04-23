-- CONSULTAR EL NUMERO Y TIPO DE ESTADO 
-- DE TODOS LOS OBJETOS EN LA BD 

SELECT OBJECT_TYPE, COUNT(*) FROM DBA_OBJECTS
WHERE STATUS = 'INVALID' GROUP BY OBJECT_TYPE 

-- 5 JERARQUIA DE DEPENDENCIAS

SELECT * FROM DBA_DEPENDENCIES dd 
WHERE dd.REFERENCED_NAME = 'LOCALIDADES';



select
 lpad (' ', 2 * (level - 1)) || to_char (level, '999') as "NIVEL",
 owner || '.' || name || ' (' || type || ')' as "OBJETO",
 referenced_owner || '.' || referenced_name || ' (' || referenced_type || ')' as "OBJETO
REFERENCIADO"
from
 dba_dependencies
start with
 owner = 'HR'
and
 name = 'NUM_JAPON'
connect by prior
 referenced_owner = owner 
and prior
 referenced_name = name
and prior
 referenced_type = TYPE
;


-- REF CURSOR







