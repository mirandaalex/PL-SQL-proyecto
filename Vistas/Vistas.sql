SET SERVEROUTPUT ON
--*********************************VIEWS************************************
--VIEW DE AUTORES
CREATE OR REPLACE VIEW VW_AUTOR AS
	SELECT IDAUTOR,NACIONALIDAD,NOMBREA,APELLIDOPA,APELLIDOMA
	FROM AUTOR;

--VIEW DE DIRECTORES
CREATE OR REPLACE VIEW VW_DIRECTOR AS
	SELECT IDDIRECTOR,NOMBRED,APELLIDOPD,APELLIDOMD,GRADO 
    FROM DIRECTOR;

--VIEW DE EJEMPLARES
CREATE OR REPLACE VIEW VW_EJEMPLAR AS
	SELECT NOEJEMPLAR,IDMATERIAL,ESTATUS
	FROM EJEMPLAR;

--VIEW DE LECTORES
CREATE OR REPLACE VIEW VW_LECTOR AS
	SELECT IDLECTOR,NOMBREL,APELLIDOPL,APELLIDOML,DELEGACION,
	COLONIA,NUMERO,FECHAALTA,CP,ADEUDO,FECHAVIGENCIA,TIPO
	FROM LECTOR;

--VIEW DE LIBROS
CREATE OR REPLACE VIEW VW_LIBRO AS
	SELECT IDMATERIAL,NOADQUISICION,ISBN,TEMA,EDICION
	FROM LIBRO;

--VIEW DE MATERIALES
CREATE OR REPLACE VIEW VW_MATERIAL AS
	SELECT IDMATERIAL,TITULO,UBICACION,COLOCACION,TIPOMATERIAL 
	FROM MATERIAL;

--VIEW DE PERTENECE
CREATE OR REPLACE VIEW VW_PERTENECE AS
	SELECT IDAUTOR,IDMATERIAL
    FROM PERTENECE;

--VIEW DE PRESTAMOS
CREATE OR REPLACE VIEW VW_PRESTAMO AS
	SELECT IDLECTOR,NOEJEMPLAR,IDMATERIAL,FECHAPREST,
	FECHAVENC,DIASATRASO,FECHAMULTA,MONTO,FECHADEV,NUMREFRENDO
    FROM PRESTAMO;

--VIEW DE TESIS
CREATE OR REPLACE VIEW VW_TESIS AS
	SELECT IDMATERIAL,IDDIRECTOR,IDTESIS,CARRERA,ANOPUB
    FROM TESIS;

CREATE OR REPLACE VIEW VW_TIPOLECTOR AS
 	SELECT TIPO,LIMITEMAT,DIASPREST,REFRENDOS
     FROM TIPOLECTOR;

 --VIEW QUE MUESTRA TIPO LECTOR DE LOS LECTORES
 CREATE OR REPLACE VIEW VW_LECTOR_TIPO AS
 	SELECT IDLECTOR, NOMBREL,APELLIDOPL,APELLIDOML
 	,TIPO,LIMITEMAT,DIASPREST,REFRENDOS
 	FROM TIPOLECTOR
 	NATURAL JOIN LECTOR;

 --SELECT * FROM VW_LECTOR_TIPO;

 --VIEW QUE MUESTRA LAS CARACTERISTICAS DE UN EJEMPLAR
 CREATE OR REPLACE VIEW VW_EJEMPLAR_MATERIAL AS
 	SELECT NOEJEMPLAR,TIPOMATERIAL,
 	IDMATERIAL,TITULO,UBICACION,
 	COLOCACION,ESTATUS
 	FROM MATERIAL
 	NATURAL JOIN EJEMPLAR;

 --SELECT * FROM VW_EJEMPLAR_MATERIAL;

 --VIEW QUE MUESTRA TODOS LOS EJEMPLARES QUE SON LIBROS
 CREATE OR REPLACE VIEW VW_EJEMPLAR_LIBROS AS
 	SELECT IDMATERIAL,NOEJEMPLAR,ESTATUS,
 	NOADQUISICION,ISBN,TEMA,EDICION
 	FROM EJEMPLAR
 	NATURAL JOIN LIBRO;

 --SELECT * FROM VW_EJEMPLAR_LIBROS;

 --VIEW QUE MUESTRA TODOS LOS EJEMPLARES QUE SON TESIS
 CREATE OR REPLACE VIEW VW_EJEMPLAR_TESIS
     SELECT IDMATERIAL,NOEJEMPLAR,ESTATUS,
     IDDIRECTOR,IDTESIS,CARRERA,ANOPUB
     FROM EJEMPLAR
     NATURAL JOIN TESIS;

 --SELECT * FROM VW_EJEMPLAR_TESIS;
commit;
DROP VIEW VW_AUTOR;
DROP VIEW VW_DIRECTOR;
DROP VIEW VW_MATERIAL;
DROP VIEW VW_PERTENECE;
DROP VIEW VW_TESIS;
DROP VIEW VW_LIBRO;
DROP VIEW VW_EJEMPLAR;
DROP VIEW VW_TIPOLECTOR;
DROP VIEW VW_LECTOR;
DROP VIEW VW_PRESTAMO;
DROP VIEW VW_LECTOR_TIPO;
DROP VIEW VW_EJEMPLAR_MATERIAL;
DROP VIEW VW_EJEMPLAR_LIBROS;
DROP VIEW VW_EJEMPLAR_TESIS;
COMMIT;
