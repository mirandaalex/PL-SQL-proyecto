SET SERVEROUTPUT ON
EXEC SP_ALTA_DIRECTOR('D1','FERNANDO','FLORES','CAMACHO','MAESTRIA');
EXEC SP_ALTA_AUTOR('A1','MEXICANO','LEONARDO','CARRILLO','CONTRERAS');
EXEC SP_ALTA_MATERIAL('M1','ROBOTICA ESTRATEGIA DIDACTICA','EDIFICIO A','T001','TESIS');
EXEC SP_ALTA_PERTENECE('A1','M1');
EXEC SP_ALTA_TESIS('M1','D1','T1','FISICA',TO_DATE('01/02/2020','dd/mm/yyyy'));
EXEC SP_ALTA_EJEMPLAR(1,'M1','DISPONIBLE');
EXEC SP_ALTA_EJEMPLAR(2,'M1','DISPONIBLE');
EXEC SP_ALTA_EJEMPLAR(3,'M1','NO SALE');

EXEC SP_ALTA_DIRECTOR('D2','HERNAN','LARRALDE','RIDAURA','DOCTORADO');
EXEC SP_ALTA_AUTOR('A2','MEXICANO','LUISANA','CLAUDIO','PACHECANO');
EXEC SP_ALTA_MATERIAL('M2','AGLOMERACIONES DE NEGOCOS','EDIFICIO A','T002','TESIS');
EXEC SP_ALTA_PERTENECE('A2','M2');
EXEC SP_ALTA_TESIS('M2','D2','T2','FISICA',TO_DATE('11/06/2020','dd/mm/yyyy'));
EXEC SP_ALTA_EJEMPLAR(1,'M2','DISPONIBLE');
EXEC SP_ALTA_EJEMPLAR(2,'M2','DISPONIBLE');
EXEC SP_ALTA_EJEMPLAR(3,'M2','NO SALE');

EXEC SP_ALTA_DIRECTOR('D3','JESSICA','ROSAS','GUTIERREZ','MAESTRIA');
EXEC SP_ALTA_AUTOR('A3','MEXICANO','DIEGO','CASTRO','MORALES');
EXEC SP_ALTA_MATERIAL('M3','PLUS ULTRA, TERRA FIRMA','EDIFICIO A','T003','TESIS');
EXEC SP_ALTA_PERTENECE('A3','M3');
EXEC SP_ALTA_TESIS('M3','D3','T3','ARTES',TO_DATE('13/05/2005','dd/mm/yyyy'));
EXEC SP_ALTA_EJEMPLAR(1,'M3','DISPONIBLE');
EXEC SP_ALTA_EJEMPLAR(2,'M3','DISPONIBLE');
EXEC SP_ALTA_EJEMPLAR(3,'M3','NO SALE');

EXEC SP_ALTA_AUTOR('A4','ESTADOS UNIDOS','ROLAND','EDWIN','LARSON');
EXEC SP_ALTA_MATERIAL('M4','CALCULO','EDIFICIO A','B001','LIBRO');
EXEC SP_ALTA_PERTENECE('A4','M4');
EXEC SP_ALTA_LIBRO('M4',1,'9788436820','MATEMATICAS','DECIMA EDICION');
EXEC SP_ALTA_EJEMPLAR(1,'M4','DISPONIBLE');
EXEC SP_ALTA_EJEMPLAR(2,'M4','DISPONIBLE');
EXEC SP_ALTA_EJEMPLAR(3,'M4','NO SALE');

EXEC SP_ALTA_AUTOR('A5','REINO UNIDO','BHAT','RAMDAS',NULL);
EXEC SP_ALTA_MATERIAL('M5','MODERN PROBABILITY THEORY','EDIFICIO A','B002','LIBRO');
EXEC SP_ALTA_PERTENECE('A5','M5');
EXEC SP_ALTA_LIBRO('M5',2,'9780852260','MATEMATICAS','SEGUNDA EDICION');
EXEC SP_ALTA_EJEMPLAR(1,'M5','DISPONIBLE');
EXEC SP_ALTA_EJEMPLAR(2,'M5','DISPONIBLE');
EXEC SP_ALTA_EJEMPLAR(3,'M5','NO SALE');

EXEC SP_ALTA_AUTOR('A6','FRANCIA','ANTONIE','SAINT-EXUPERY',NULL);
EXEC SP_ALTA_MATERIAL('M6','EL PRINCIPITO','EDIFICIO A','B003','LIBRO');
EXEC SP_ALTA_PERTENECE('A6','M6');
EXEC SP_ALTA_LIBRO('M6',3,'9788498386','CUENTOS','PRIMERA EDICION');
EXEC SP_ALTA_EJEMPLAR(1,'M6','DISPONIBLE');
EXEC SP_ALTA_EJEMPLAR(2,'M6','DISPONIBLE');
EXEC SP_ALTA_EJEMPLAR(3,'M6','NO SALE');

EXEC SP_ALTA_TIPO_LECTOR('ESTUDIANTE',3,0,1);
EXEC SP_ALTA_TIPO_LECTOR('PROFESOR',5,15,2);
EXEC SP_ALTA_TIPO_LECTOR('INVESTIGADOR',10,30,3);
--select * FROM tipolector;

EXEC SP_ALTA_LECTOR('L1','ANTONIO','GARCIA','VASQUEZ','MIGUEL HIDALGO','POLANCO','ANATOLE FRANCE',327,11550,'ESTUDIANTE');
EXEC SP_ALTA_LECTOR('L2','ROSA','PENA','DELGADO','XOCHIMILCO','JARDINES DEL SUR','SACATECAS',74,16050,'ESTUDIANTE');
EXEC SP_ALTA_LECTOR('L3','IRMA','MORENO','CASTILLO','COYOACAN','SANTO DOMINGO','CERRADAS TEXALPA',35,04369,'PROFESOR');
EXEC SP_ALTA_LECTOR('L4','LUIS','CASTRO','RAMIREZ','COYOACAN','COPILCO UNIVERSIDAD','CERRO SABINO 3-17',29,04360,'PROFESOR');
EXEC SP_ALTA_LECTOR('L5','MARTIN','ORTEGA','SANTIAGO','COYOACAN','COPILCO UNIVERSIDAD','ECONOMIA',17,04361,'INVESTIGADOR');
/*
DELETE FROM TIPOLECTOR;
DELETE FROM LECTOR;
DELETE FROM MATERIAL;
DELETE FROM DIRECTOR;
DELETE FROM AUTOR;
--select * from lector;
*/
/*
SELECT * FROM LECTOR;
SELECT * FROM TIPOLECTOR;
EXEC SP_BAJA_TIPO_LECTOR('ESTUDIANTE');
SELECT * FROM LECTOR;
SELECT * FROM TIPOLECTOR;
SELECT * FROM PRESTAMO;
EXEC SP_BAJA_LECTOR('L2');
SELECT * FROM AUTOR;
EXEC SP_BAJA_AUTOR('A1');
SELECT * FROM AUTOR;
SELECT * FROM DIRECTOR;
EXEC SP_BAJA_DIRECTOR('D1');
SELECT * FROM DIRECTOR;
SELECT * FROM MATERIAL;
SELECT * FROM PERTENECE;
SELECT * FROM TESIS;
EXEC SP_BAJA_MATERIAL('M1');
SELECT * FROM MATERIAL;
SELECT * FROM PERTENECE;
SELECT * FROM TESIS;
SELECT * FROM EJEMPLAR;
DELETE FROM PRESTAMO;
EXEC SP_ALTA_PRESTAMO('L1',1,'M1');
EXEC SP_ALTA_PRESTAMO('L2',2,'M2');
SELECT * FROM PRESTAMO;
EXEC SP_REFRENDO_PRESTAMO('L1',1,'M1');
EXEC SP_BAJA_PRESTAMO('L2',2,'M2');
SELECT * FROM PRESTAMO;
*/
COMMIT;

--CHECAR EL ESTADO DE LAS TABLAS CON LOS TRIGGERS
SELECT * FROM AUTOR;
SELECT * FROM DIRECTOR;
SELECT * FROM PERTENECE;
SELECT * FROM TESIS;
SELECT * FROM LIBRO;
SELECT * FROM EJEMPLAR;
SELECT * FROM TIPOLECTOR;
SELECT * FROM LECTOR;
SELECT * FROM PRESTAMO;
SELECT * FROM EJEMPLAR;
EXEC SP_ALTA_PRESTAMO('L1',1,'M1');
EXEC SP_ALTA_PRESTAMO('L2',2,'M2');
SELECT * FROM PRESTAMO;
SELECT * FROM EJEMPLAR;
EXEC SP_BAJA_PRESTAMO('L1',1,'M1');
EXEC SP_BAJA_PRESTAMO('L2',2,'M2');
SELECT * FROM PRESTAMO;
SELECT * FROM EJEMPLAR;








