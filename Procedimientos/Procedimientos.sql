SET SERVEROUTPUT ON;
--****************************PROCEDIMIENTOS DE ALTA********************************
--ALTA DE LECTOR
CREATE OR REPLACE PROCEDURE SP_ALTA_LECTOR(VIDLECTOR CHAR,VNOMBREL VARCHAR2, 
VAPELLIDOPL VARCHAR2, VAPELLIDOML VARCHAR2, VDELEGACION VARCHAR2,VCOLONIA VARCHAR2,VCALLE VARCHAR2,
VNUMERO NUMBER,VCP NUMBER,VTIPO VARCHAR2)
AS
BEGIN
    INSERT INTO LECTOR (IDLECTOR,NOMBREL,APELLIDOPL,APELLIDOML,DELEGACION,COLONIA,CALLE,NUMERO,FECHAALTA,CP,ADEUDO,FECHAVIGENCIA,TIPO) 
    VALUES(VIDLECTOR,VNOMBREL,VAPELLIDOPL,VAPELLIDOML,VDELEGACION,VCOLONIA,VCALLE,VNUMERO,SYSDATE,VCP,0,ADD_MONTHS(SYSDATE,12),VTIPO);
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
--ALTA PERTENECE
CREATE OR REPLACE PROCEDURE SP_ALTA_PERTENECE(VIDAUTOR CHAR,VIDMATERIAL CHAR)
AS
BEGIN
    INSERT INTO PERTENECE VALUES(VIDAUTOR,VIDMATERIAL);
END;
/
--****************************PROCEDIMIENTOS DE BAJA********************************
--BAJA DE LECTOR
CREATE OR REPLACE PROCEDURE SP_BAJA_LECTOR(VIDLECTOR CHAR)
AS
BEGIN
    DELETE FROM LECTOR WHERE IDLECTOR=VIDLECTOR;
    DBMS_OUTPUT.PUT_LINE('LECTOR ELIMINADO EXITOSAMENTE');
END;
/
--BAJA DE TIPO DE LECTOR
CREATE OR REPLACE PROCEDURE SP_BAJA_TIPO_LECTOR(VTIPO VARCHAR2)
AS
BEGIN
	DELETE FROM TIPOLECTOR WHERE TIPO=VTIPO;
	DBMS_OUTPUT.PUT_LINE('TIPO DE LECTOR ELIMINADO EXITOSAMENTE');
	
END;
/
--BAJA AUTOR
CREATE OR REPLACE PROCEDURE SP_BAJA_AUTOR(VIDAUTOR CHAR)
AS
vBaja NUMBER;
BEGIN
	SELECT count(*) INTO vBaja
	FROM AUTOR WHERE IDAUTOR=VIDAUTOR;
	IF vBaja=0 THEN
		DELETE FROM AUTOR WHERE IDAUTOR=VIDAUTOR;
		DBMS_OUTPUT.PUT_LINE('AUTOR DADO DE BAJA EXITOSAMENTE');
	ELSE
		DBMS_OUTPUT.PUT_LINE('NO SE PUEDE DAR DE BAJA TIENE PRESTAMOS O MULTAS');
	END IF;
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
vBaja NUMBER;
BEGIN
	SELECT count(*) INTO vBaja
	FROM PRESTAMO WHERE IDMATERIAL=VIDMATERIAL;
	IF vBaja=0 THEN
		DELETE FROM MATERIAL WHERE IDMATERIAL=VIDMATERIAL;
		DBMS_OUTPUT.PUT_LINE('MATERIAL DADO DE BAJA EXITOSAMENTE');
	ELSE
		DBMS_OUTPUT.PUT_LINE('EL MATERIAL NO SE PUDO DAR DE BAJA HAY '||vBaja ||' EN PRESTAMO');
	END IF;
END;
/
--****************************PROCEDIMIENTOS DE PRESTAMO********************************
CREATE OR REPLACE PROCEDURE SP_ALTA_PRESTAMO(VIDLECTOR CHAR,VNOEJEMPLAR NUMBER,VIDMATERIAL CHAR)
AS
VFECHAVENC DATE;
VNUMREFRENDO NUMBER(5);
vRESTANTES NUMBER;
vDISP VARCHAR(30);
vTotal NUMBER(9);
vTotal1 NUMBER(9);
BEGIN    
    vRESTANTES:= ft_materialrestante(vIDLECTOR);--revisa el numero de material que puede sacar
    vTotal:= ft_VERFICAMULTA(vIDLECTOR); --revisa cuantas multas tiene el lector
    IF vRESTANTES>0 and vTotal=0 THEN 
        VFECHAVENC:=FT_FECHADEV(VIDLECTOR);
        VNUMREFRENDO:=FT_OBTIENE_REFRENDO(VIDLECTOR);
        INSERT INTO PRESTAMO(IDLECTOR,NOEJEMPLAR,IDMATERIAL,FECHAPREST,FECHAVENC,NUMREFRENDO) 
        VALUES(VIDLECTOR,VNOEJEMPLAR,VIDMATERIAL,SYSDATE,VFECHAVENC,VNUMREFRENDO);
        DBMS_OUTPUT.PUT_LINE('PRESTAMO REALIZADO CORRECTAMENTE');
    ELSIF (vTotal <> 0) THEN
        RAISE_APPLICATION_ERROR (-20605,'EL LECTOR TIENE MULTAS, NO PUEDE SACAR MATERIAL');
    ELSE
        RAISE_APPLICATION_ERROR (-20604,'NO SE PUDO REALIZAR EL PRESTAMO, DEBIDO A QUE SE EXEDIO EL LIMITE DE MATERIAL PERMITIDO');
    END IF;
END;
/
CREATE OR REPLACE PROCEDURE SP_REFRENDO_PRESTAMO(VIDLECTOR CHAR,VNOEJEMPLAR NUMBER,VIDMATERIAL CHAR)
AS
VFECHAVENC DATE;
VFECHADEV DATE;
VNUEVA_FECHAVENC DATE;
VNUMREFRENDO NUMBER(5);
VAUX NUMBER(1);
BEGIN
    SELECT FECHAVENC
    INTO VFECHAVENC
    FROM PRESTAMO
    WHERE IDLECTOR=VIDLECTOR AND NOEJEMPLAR=VNOEJEMPLAR AND IDMATERIAL=VIDMATERIAL;
    VFECHADEV:=SYSDATE;
    VAUX:=TRUNC(VFECHADEV)-TRUNC(VFECHAVENC);
    IF (VAUX=0) THEN
        VNUMREFRENDO:=FT_ACTUALIZA_REFRENDO(VIDLECTOR,VNOEJEMPLAR,VIDMATERIAL);
        IF (VNUMREFRENDO>=0) THEN
            VNUEVA_FECHAVENC:=FT_FECHADEV(VIDLECTOR);
            UPDATE PRESTAMO SET FECHAPREST= SYSDATE, FECHAVENC= VNUEVA_FECHAVENC, NUMREFRENDO=VNUMREFRENDO
            WHERE IDLECTOR=VIDLECTOR AND NOEJEMPLAR=VNOEJEMPLAR AND IDMATERIAL=VIDMATERIAL;
            DBMS_OUTPUT.PUT_LINE('REFRENDO REALIZADO, PRESTAMO ACTUALIZADO');
        ELSE
            RAISE_APPLICATION_ERROR (-20606,'LOS REFRENDOS DE ESTE LECTOR PARA ESTE LIBRO SE HAN AGOTADO');
        END IF;
    ELSE
        RAISE_APPLICATION_ERROR (-20607,'SOLO SE PERMITEN REFRENDOS EN LAS FECHAS DE VENCIMIENTO DEL PRESTAMO');
    END IF;
END;
/

CREATE OR REPLACE PROCEDURE SP_MULTA(VIDLECTOR CHAR,VNOEJEMPLAR NUMBER,VIDMATERIAL CHAR)
AS
VFECHAVENC DATE;
VFECHADEV DATE;
VAUX NUMBER(3);
VMONTO NUMBER(5);
BEGIN
	SELECT FECHAVENC
    INTO VFECHAVENC
    FROM PRESTAMO
    WHERE IDLECTOR=VIDLECTOR AND NOEJEMPLAR=VNOEJEMPLAR AND IDMATERIAL=VIDMATERIAL;
    VFECHADEV:=SYSDATE+15;
    VAUX:=TRUNC(VFECHADEV)-TRUNC(VFECHAVENC);
    VMONTO:=VAUX*10;
    UPDATE PRESTAMO SET FECHAMULTA=SYSDATE, DIASATRASO=VAUX,MONTO=VMONTO
    WHERE IDLECTOR=VIDLECTOR AND NOEJEMPLAR=VNOEJEMPLAR AND IDMATERIAL=VIDMATERIAL;
    SP_ADEUDO(VIDLECTOR,VNOEJEMPLAR,VIDMATERIAL);
END;
/
CREATE OR REPLACE PROCEDURE SP_ADEUDO(VIDLECTOR CHAR,VNOEJEMPLAR NUMBER,VIDMATERIAL CHAR)
AS
VMONTO NUMBER(15);
VADEUDO NUMBER(15);
VNEWADEUDO NUMBER(15);
BEGIN
    SELECT MONTO
    INTO VMONTO
    FROM PRESTAMO
    WHERE IDLECTOR=VIDLECTOR AND NOEJEMPLAR=VNOEJEMPLAR AND IDMATERIAL=VIDMATERIAL;
    SELECT ADEUDO
    INTO VADEUDO
    FROM LECTOR
    WHERE IDLECTOR=VIDLECTOR;
    IF(VADEUDO=0)THEN
        VNEWADEUDO:=VMONTO;
        UPDATE LECTOR SET ADEUDO=VNEWADEUDO
        WHERE IDLECTOR=VIDLECTOR;
        DBMS_OUTPUT.PUT_LINE('SE HA REGISTRADO UNA MULTA EXITOSAMENTE');
    ELSE
        VNEWADEUDO:=VMONTO+VADEUDO;
        UPDATE LECTOR SET ADEUDO=VNEWADEUDO
        WHERE IDLECTOR=VIDLECTOR;
        DBMS_OUTPUT.PUT_LINE('SE HA REGISTRADO UNA MULTA EXITOSAMENTE');
    END IF;
END;
/
CREATE OR REPLACE PROCEDURE SP_LIQUIDA_MULTA(VIDLECTOR CHAR,VNOEJEMPLAR NUMBER,VIDMATERIAL CHAR)
AS
VMONTO NUMBER(5);
VADEUDO NUMBER(5);
VNEWADEUDO NUMBER(5);
BEGIN
    SELECT ADEUDO
    INTO VADEUDO
    FROM LECTOR
    WHERE IDLECTOR=VIDLECTOR;
    SELECT MONTO
    INTO VMONTO
    FROM PRESTAMO
    WHERE IDLECTOR=VIDLECTOR AND NOEJEMPLAR=VNOEJEMPLAR AND IDMATERIAL=VIDMATERIAL;
    VNEWADEUDO:=VADEUDO-VMONTO;
    UPDATE PRESTAMO SET FECHAMULTA=NULL, DIASATRASO=NULL,MONTO=NULL
    WHERE IDLECTOR=VIDLECTOR AND NOEJEMPLAR=VNOEJEMPLAR AND IDMATERIAL=VIDMATERIAL;
    UPDATE LECTOR SET ADEUDO=VNEWADEUDO WHERE IDLECTOR=VIDLECTOR;
    DELETE FROM PRESTAMO 
    WHERE IDLECTOR=VIDLECTOR AND NOEJEMPLAR=VNOEJEMPLAR AND IDMATERIAL=VIDMATERIAL;
    DBMS_OUTPUT.PUT_LINE('SE ELIMINO LA MULTA EXITOSAMENTE');
END;
/

CREATE OR REPLACE PROCEDURE SP_BAJA_PRESTAMO(VIDLECTOR CHAR,VNOEJEMPLAR NUMBER,VIDMATERIAL CHAR)
AS
VFECHAVENC DATE;
VFECHADEV DATE;
VAUX NUMBER(3);
BEGIN
    SELECT FECHAVENC
    INTO VFECHAVENC
    FROM PRESTAMO
    WHERE IDLECTOR=VIDLECTOR AND NOEJEMPLAR=VNOEJEMPLAR AND IDMATERIAL=VIDMATERIAL;
    VFECHADEV:=SYSDATE+15;
    VAUX:=TRUNC(VFECHADEV)-TRUNC(VFECHAVENC);
    IF (VAUX<=0) THEN
        DELETE FROM PRESTAMO WHERE IDLECTOR=VIDLECTOR AND NOEJEMPLAR=VNOEJEMPLAR AND IDMATERIAL=VIDMATERIAL;
        DBMS_OUTPUT.PUT_LINE('EL PRESTAMO SE BORRO CORRECTAMENTE');
    ELSE
    	SP_MULTA(VIDLECTOR,VNOEJEMPLAR,VIDMATERIAL);
    END IF;
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