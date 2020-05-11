set serveroutput on
--*************************************************** PRUEBAS ******************************************************************
--probando alta y baja de prestamo
EXEC SP_ALTA_PRESTAMO ('l1',1,'m1'); --estudiante
SELECT * FROM VW_PRESTAMO;
EXEC SP_BAJA_PRESTAMO ('l1',1,'m1');
SELECT * FROM VW_PRESTAMO;
EXEC SP_ALTA_PRESTAMO ('l5',2,'m3'); --investigador
SELECT * FROM VW_PRESTAMO;
EXEC SP_BAJA_PRESTAMO ('l5',2,'m3');
SELECT * FROM VW_PRESTAMO;
EXEC SP_LIQUIDA_MULTA('l1',1,'m1');
SELECT * FROM VW_PRESTAMO;
--------------------------------------------------------------------------------------------------------------------------------
-- Probando limite de refrendos
EXEC SP_ALTA_PRESTAMO ('l3',2,'m6'); --profesor
SELECT * FROM VW_PRESTAMO;
EXEC SP_REFRENDO_PRESTAMO ('l3',2,'m6'); --profesor
SELECT * FROM VW_PRESTAMO;
EXEC SP_REFRENDO_PRESTAMO ('l3',2,'m6'); --profesor
SELECT * FROM VW_PRESTAMO;
EXEC SP_REFRENDO_PRESTAMO ('l3',2,'m6'); --profesor
SELECT * FROM VW_PRESTAMO;
EXEC SP_REFRENDO_PRESTAMO ('l3',2,'m6'); --profesor
SELECT * FROM VW_PRESTAMO;
EXEC SP_BAJA_PRESTAMO ('l3',2,'m6');
SELECT * FROM VW_PRESTAMO;
--------------------------------------------------------------------------------------------------------------------------------
-- Probando limite de materiales en prestamo
EXEC SP_ALTA_PRESTAMO ('l3',1,'m1'); --profesor
SELECT * FROM VW_PRESTAMO;
EXEC SP_ALTA_PRESTAMO ('l1',1,'m2'); --estudiante
SELECT * FROM VW_PRESTAMO;
EXEC SP_ALTA_PRESTAMO ('l1',1,'m3');
SELECT * FROM VW_PRESTAMO;
EXEC SP_ALTA_PRESTAMO ('l1',1,'m4');
SELECT * FROM VW_PRESTAMO;
EXEC SP_ALTA_PRESTAMO ('l1',1,'m5');
SELECT * FROM VW_PRESTAMO;
--------------------------------------------------------------------------------------------------------------------------------
-- Probando que no se puede prestar el mismo ejemplar del mismmo material
EXEC SP_ALTA_PRESTAMO ('l2',1,'m1'); --estudiante
EXEC SP_ALTA_PRESTAMO ('l3',1,'m1'); --profesor
SELECT * FROM VW_PRESTAMO;
--------------------------------------------------------------------------------------------------------------------------------
-- Bajando los prestamos del l1
EXEC SP_BAJA_PRESTAMO ('l1',1,'m2');
EXEC SP_LIQUIDA_MULTA('l1',1,'m2');
SELECT * FROM VW_PRESTAMO;
EXEC SP_BAJA_PRESTAMO ('l1',1,'m3');
EXEC SP_LIQUIDA_MULTA('l1',1,'m3');
SELECT * FROM VW_PRESTAMO;
EXEC SP_BAJA_PRESTAMO ('l1',1,'m4');
EXEC SP_LIQUIDA_MULTA('l1',1,'m4');
SELECT * FROM VW_PRESTAMO;
SELECT * FROM VW_EJEMPLAR;
--------------------------------------------------------------------------------------------------------------------------------
-- Mostrando que no se puede prestar un ejemplar que no puede salir
EXEC SP_ALTA_PRESTAMO ('l3',2,'m3'); --profesor
SELECT * FROM VW_PRESTAMO;
SELECT * FROM VW_EJEMPLAR;
--------------------------------------------------------------------------------------------------------------------------------
--Mostrando que no deja bajar a un lector con prestamos
exec sp_baja_lector('l3');
exec sp_baja_lector('l4');
SELECT * FROM VW_PRESTAMO;
--------------------------------------------------------------------------------------------------------------------------------
-- Mostrando que no permite dar de baja a un material si esta en prestamo
exec sp_baja_material('m6');
exec sp_baja_material('m2');
-- Mostrando que no permite dar de baja a un ejemplar si esta en prestamo
exec sp_baja_ejemplar('2','m3');
--------------------------------------------------------------------------------------------------------------------------------
--Mostrando que no se puede prestar libro a alguien con multa
EXEC SP_ALTA_PRESTAMO('l1',2,'m1');
SELECT * FROM VW_PRESTAMO;
EXEC SP_BAJA_PRESTAMO('l1',2,'m1');
SELECT * FROM VW_PRESTAMO;
EXEC SP_ALTA_PRESTAMO('l1',2,'m3');
EXEC SP_LIQUIDA_MULTA('l1',2,'m1');
commit;