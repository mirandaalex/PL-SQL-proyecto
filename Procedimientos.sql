--****************************PROCEDIMIENTOS DE ALTA********************************
--ALTA DE LECTOR
CREATE OR REPLACE PROCEDURE SP_ALTA_LECTOR(VIDLECTOR CHAR,VNOMBREL VARCHAR2, 
VAPELLIDOPL VARCHAR2, VAPELLIDOML VARCHAR2, VDELEGACION VARCHAR2,VCOLONIA VARCHAR2,
VNUMERO NUMBER,VCP NUMBER,VTIPO VARCHAR2)
AS
BEGIN
    INSERT INTO LECTOR (IDLECTOR,NOMBREL,APELLIDOPL,APELLIDOML,DELEGACION,COLONIA,NUMERO,FECHAALTA,CP,TIPO) 
    VALUES(VIDLECTOR,VNOMBREL,VAPELLIDOPL,VAPELLIDOML,VDELEGACION,VCOLONIA,VNUMERO,SYSDATE,VCP,VTIPO);
    DBMS_OUTPUT.PUT_LINE('USUARIO DADO DE ALTA EXITOSAMENTE');
END;
/
--ALTA DE TIPO DE LECTOR
CREATE OR REPLACE PROCEDURE SP_ALTA_TIPO_LECTOR(VTIPO VARCHAR2,VLIMITEMAT NUMBER,VDIASPREST NUMBER,VREFRENDOS NUMBER)
AS
BEGIN
	INSERT INTO TIPOLECTOR VALUES(VTIPO,VLIMITEMAT,VDIASPREST,VREFRENDOS);
	DBMS_OUTPUT.PUT_LINE('TIPO USUARIO CREADO EXITOSAMENTE');
END;
/
--ALTA AUTOR
CREATE OR REPLACE PROCEDURE SP_ALTA_AUTOR(VIDAUTOR CHAR,VNACIONALIDAD VARCHAR2,
VNOMBREA VARCHAR2,VAPELLIDOPA VARCHAR2,VAPELLIDOMA VARCHAR2)
AS
BEGIN
	INSERT INTO AUTOR VALUES(VIDAUTOR,VNACIONALIDAD,VNOMBREA,VAPELLIDOPA,VAPELLIDOMA);
	DBMS_OUTPUT.PUT_LINE('AUTOR DADO DE ALTA EXITOSAMENTE');
END;
/
--ALTA DIRECTOR DE TESIS
CREATE OR REPLACE PROCEDURE SP_ALTA_DIRECTOR(VIDDIRECTOR CHAR,VNOMBRED VARCHAR2,
VAPELLIDOPD VARCHAR2,VAPELLIDOMD VARCHAR2,VGRADO VARCHAR2)
AS
BEGIN
	INSERT INTO DIRECTOR VALUES(VIDDIRECTOR,VNOMBRED,VAPELLIDOPD,VAPELLIDOMD,VGRADO);
	DBMS_OUTPUT.PUT_LINE('DIRECTOR DE TESIS DADO DE ALTA EXITOSAMENTE');
END;
/
--ALTA MATERIAL
CREATE OR REPLACE PROCEDURE SP_ALTA_MATERIAL(VIDMATERIAL CHAR,VTITULO VARCHAR2,
VUBICACION CHAR,VCOLOCACION CHAR,VTIPOMATERIAL VARCHAR2)
AS
BEGIN
	INSERT INTO MATERIAL VALUES(VIDMATERIAL,VTITULO,VUBICACION,VCOLOCACION,VTIPOMATERIAL);
	DBMS_OUTPUT.PUT_LINE('MATERIAL DADO DE ALTA EXITOSAMENTE');
END;
/
--ALTA TESIS
CREATE OR REPLACE PROCEDURE SP_ALTA_TESIS(VIDMATERIAL CHAR,VIDDIRECTOR CHAR,
VIDTESIS CHAR,VCARRERA VARCHAR2,VANOPUB DATE)
AS
BEGIN
	INSERT INTO TESIS VALUES(VIDMATERIAL,VIDDIRECTOR,VIDTESIS,VCARRERA,VANOPUB);
	DBMS_OUTPUT.PUT_LINE('TESIS DADA DE ALTA EXITOSAMENTE');
END;
/
--ALTA LIBRO
CREATE OR REPLACE PROCEDURE SP_ALTA_LIBRO(VIDMATERIAL CHAR,VNOADQUISICION NUMBER,
VISBN CHAR,VTEMA VARCHAR2,EDICION VARCHAR2)
AS
BEGIN
	INSERT INTO LIBRO VALUES(VIDMATERIAL,VNOADQUISICION,VISBN,VTEMA,EDICION);
	DBMS_OUTPUT.PUT_LINE('LIBRO DADO DE ALTA EXITOSAMENTE');
END;
/
--ALTA EJEMPLAR
CREATE OR REPLACE PROCEDURE SP_ALTA_EJEMPLAR(VNOEJEMPLAR NUMBER,VIDMATERIAL CHAR,
VESTATUS VARCHAR2)
AS
BEGIN
	INSERT INTO EJEMPLAR VALUES(VNOEJEMPLAR,VIDMATERIAL,VESTATUS);
	DBMS_OUTPUT.PUT_LINE('EJEMPLAR DADO DE ALTA EXITOSAMENTE');
END;
/
--****************************PROCEDIMIENTOS DE BAJA********************************
--BAJA DE LECTOR
CREATE OR REPLACE PROCEDURE SP_BAJA_LECTOR(VIDLECTOR CHAR)
AS
BEGIN
    DELETE FROM LECTOR WHERE IDLECTOR=VIDLECTOR;
END;
/
--BAJA DE TIPO DE LECTOR
CREATE OR REPLACE PROCEDURE SP_BAJA_TIPO_LECTOR(VTIPO VARCHAR2)
AS
BEGIN
	DELETE FROM TIPOLECTOR WHERE TIPO=VTIPO;
	DBMS_OUTPUT.PUT_LINE('TIPO USUARIO ELIMINADO EXITOSAMENTE');
END;
/
--BAJA AUTOR
CREATE OR REPLACE PROCEDURE SP_BAJA_AUTOR(VIDAUTOR CHAR)
AS
BEGIN
	DELETE FROM AUTOR WHERE IDAUTOR=VIDAUTOR;
	DBMS_OUTPUT.PUT_LINE('AUTOR DADO DE BAJA EXITOSAMENTE');
END;
/
--BAJA DIRECTOR DE TESIS
CREATE OR REPLACE PROCEDURE SP_BAJA_DIRECTOR(VIDDIRECTOR CHAR)
AS
BEGIN
	DELETE FROM DIRECTOR WHERE IDDIRECTOR=VIDDIRECTOR;
	DBMS_OUTPUT.PUT_LINE('DIRECTOR DE TESIS DADO DE ALTA EXITOSAMENTE');
END;
/
--BAJA MATERIAL
CREATE OR REPLACE PROCEDURE SP_BAJA_MATERIAL(VIDMATERIAL CHAR)
AS
BEGIN
	DELETE FROM MATERIAL WHERE IDMATERIAL=VIDMATERIAL;
	DBMS_OUTPUT.PUT_LINE('MATERIAL DADO DE BAJA EXITOSAMENTE');
END;
/
/*
SEGUN YO ESTOS NO SON NECESARIOS PORQUE LE PUSIMOS EN MATERIAL QUE SI BORRAMOS SE BORRA EN CASCADA
PERO POR SI ALGO AHI ESTAN :V
BAJA TESIS
CREATE OR REPLACE PROCEDURE SP_BAJA_TESIS(VIDMATERIAL CHAR,VIDDIRECTOR CHAR,
VIDTESIS CHAR,VCARRERA VARCHAR2,VANOPUB DATE)
AS
BEGIN
	INSERT INTO TESIS VALUES(VIDMATERIAL,VIDDIRECTOR,VIDTESIS,VCARRERA,VANOPUB);
	DBMS_OUTPUT.PUT_LINE('TESIS DADA DE BAJA EXITOSAMENTE');
END;
/
BAJA LIBRO
CREATE OR REPLACE PROCEDURE SP_BAJA_LIBRO(VIDMATERIAL CHAR,VNOADQUISICION NUMBER,
VISBN CHAR,VTEMA VARCHAR2,EDICION VARCHAR2)
AS
BEGIN
	INSERT INTO LIBRO VALUES(VIDMATERIAL,VNOADQUISICION,VISBN,VTEMA,EDICION);
	DBMS_OUTPUT.PUT_LINE('LIBRO DADO DE BAJA EXITOSAMENTE');
END;
/
--BAJA EJEMPLAR
CREATE OR REPLACE PROCEDURE SP_BAJA_EJEMPLAR(VNOEJEMPLAR NUMBER,VIDMATERIAL CHAR,
VESTATUS VARCHAR2)
AS
BEGIN
	INSERT INTO EJEMPLAR VALUES(VNOEJEMPLAR,VIDMATERIAL,VESTATUS);
	DBMS_OUTPUT.PUT_LINE('EJEMPLAR DADO DE BAJA EXITOSAMENTE');
END;
*/
--****************************PROCEDIMIENTOS DE PRESTAMO********************************
CREATE OR REPLACE PROCEDURE SP_ALTA_PRESTAMO(VIDLECTOR CHAR,VNOEJEMPLAR NUMBER,VIDMATERIAL CHAR)
AS
VFECHAVENC DATE;
VNUMREFRENDO NUMBER(5);
BEGIN
    VFECHAVENC:=SYSDATE+7;--AQUI VA LA FUNCION QUE CALCULA LA FECHA
    VNUMREFRENDO:=3;--AQUI VA LA FUNCION QUE OBTIENE EL NUMERO DE REFERENDO QUE LE QUEDAN
    INSERT INTO PRESTAMO (IDLECTOR,NOEJEMPLAR,IDMATERIAL,FECHAPREST,FECHAVENC,NUMREFRENDO) 
    VALUES(VIDLECTOR,VNOEJEMPLAR,VIDMATERIAL,SYSDATE,VFECHAVENC,VNUMREFRENDO);
END;
/
CREATE OR REPLACE PROCEDURE SP_REFRENDO_PRESTAMO(VIDLECTOR CHAR,VNOEJEMPLAR NUMBER,VIDMATERIAL CHAR)
AS
VFECHAVENC DATE;
VNUMREFRENDO NUMBER(5);
BEGIN
    VFECHAVENC:=SYSDATE+7;--AQUI VA LA FUNCION QUE CALCULA LA FECHA
    VNUMREFRENDO:=3-1;--AQUI VA LA FUNCION QUE OBTIENE EL NUMERO DE REFERENDO QUE LE QUEDAN Y SE LE RESTA 1
    UPDATE PRESTAMO SET FECHAPREST= SYSDATE, FECHAVENC= VFECHAVENC, NUMREFRENDO=VNUMREFRENDO
    WHERE IDLECTOR=VIDLECTOR AND NOEJEMPLAR=VNOEJEMPLAR AND IDMATERIAL=VIDMATERIAL; 
END;
/
CREATE OR REPLACE PROCEDURE SP_BAJA_PRESTAMO(VIDLECTOR CHAR,VNOEJEMPLAR NUMBER,VIDMATERIAL CHAR)
AS
BEGIN
    DELETE FROM PRESTAMO WHERE IDLECTOR=VIDLECTOR AND NOEJEMPLAR=VNOEJEMPLAR AND IDMATERIAL=VIDMATERIAL; 
END;
/
DROP PROCEDURE SP_ALTA_LECTOR;
DROP PROCEDURE SP_ALTA_TIPO_LECTOR;
DROP PROCEDURE SP_ALTA_AUTOR;
DROP PROCEDURE SP_ALTA_DIRECTOR;
DROP PROCEDURE SP_ALTA_MATERIAL;
DROP PROCEDURE SP_ALTA_TESIS;
DROP PROCEDURE SP_ALTA_LIBRO;
DROP PROCEDURE SP_ALTA_EJEMPLAR;
DROP PROCEDURE SP_REFRENDO_PRESTAMO;
COMMIT;