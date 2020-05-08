--********************************AUTOR***********************************
CREATE TABLE AUTOR(
	IDAUTOR              CHAR(6) NOT NULL ,
	NACIONALIDAD         VARCHAR2(30) NOT NULL ,
	NOMBREA              VARCHAR2(30) NOT NULL ,
	APELLIDOPA           VARCHAR2(30) NOT NULL ,
	APELLIDOMA           VARCHAR2(30) ,
	CONSTRAINT PKAUTOR PRIMARY KEY (IDAUTOR)
);
--********************************DIRECTOR***********************************
CREATE TABLE DIRECTOR(
	IDDIRECTOR           CHAR(6) NOT NULL ,
	NOMBRED              VARCHAR2(30) NOT NULL ,
	APELLIDOPD           VARCHAR2(30) NOT NULL ,
	APELLIDOMD           VARCHAR2(30) ,
	GRADO                VARCHAR2(20) NOT NULL ,
	CONSTRAINT PKDIRECTOR PRIMARY KEY (IDDIRECTOR) 
);
--********************************MATERIAL***********************************
CREATE TABLE MATERIAL(
	IDMATERIAL           CHAR(6) NOT NULL ,
	TITULO               VARCHAR2(30) NOT NULL ,
	UBICACION            CHAR(20) NOT NULL ,
	COLOCACION           CHAR(20) NOT NULL ,
	TIPOMATERIAL         VARCHAR2(10) NOT NULL ,
	CONSTRAINT PKMATERIAL PRIMARY KEY (IDMATERIAL) ,
	CONSTRAINT CHECKMATERIAL CHECK (TIPOMATERIAL IN ('TESIS','LIBRO')) 
);
--********************************PERTENECE***********************************
CREATE TABLE PERTENECE(
	IDAUTOR              CHAR(6) NOT NULL ,
	IDMATERIAL           CHAR(6) NOT NULL ,
	CONSTRAINT PKPERTENECE PRIMARY KEY (IDAUTOR,IDMATERIAL) ,
	CONSTRAINT FKPERTENECE_AUT FOREIGN KEY (IDAUTOR) 
	REFERENCES AUTOR (IDAUTOR) ON DELETE CASCADE ,
	CONSTRAINT FKPERTENECE_MAT FOREIGN KEY (IDMATERIAL) 
	REFERENCES MATERIAL (IDMATERIAL) ON DELETE CASCADE
);
--********************************TESIS***********************************
CREATE TABLE TESIS(
	IDMATERIAL           CHAR(6) NOT NULL ,
	IDDIRECTOR           CHAR(6) NOT NULL ,
	IDTESIS              CHAR(6) NOT NULL ,
	CARRERA              VARCHAR2(20) NOT NULL ,
    ANOPUB               DATE NOT NULL ,
	CONSTRAINT PKTESIS PRIMARY KEY (IDMATERIAL) ,
	CONSTRAINT FKTESIS_DIR FOREIGN KEY (IDDIRECTOR) 
	REFERENCES DIRECTOR (IDDIRECTOR) ON DELETE SET NULL ,
	CONSTRAINT FKTESIS_MAT FOREIGN KEY (IDMATERIAL) 
	REFERENCES MATERIAL (IDMATERIAL) ON DELETE CASCADE ,
	CONSTRAINT UNIQUETESIS UNIQUE (IDTESIS)
);
--********************************LIBRO***********************************
CREATE TABLE LIBRO(
	IDMATERIAL           CHAR(6) NOT NULL ,
	NOADQUISICION        NUMBER(5) NOT NULL ,
	ISBN                 CHAR(10) NOT NULL ,
	TEMA                 VARCHAR2(30) NOT NULL ,
	EDICION              VARCHAR2(30) NOT NULL ,
	CONSTRAINT PKLIBRO PRIMARY KEY (IDMATERIAL) ,
	CONSTRAINT FKLIBRO FOREIGN KEY (IDMATERIAL) 
	REFERENCES MATERIAL (IDMATERIAL) ON DELETE CASCADE ,
	CONSTRAINT UNIQUENOADQUISICION UNIQUE (NOADQUISICION) ,
	CONSTRAINT UNIQUELIBRO UNIQUE (ISBN)
);
--********************************EJEMPLAR***********************************
CREATE TABLE EJEMPLAR(
	NOEJEMPLAR           NUMBER(6) NOT NULL ,
	IDMATERIAL           CHAR(6) NOT NULL ,
	ESTATUS              VARCHAR2(20) NOT NULL ,
	CONSTRAINT PKEJEMPLAR PRIMARY KEY (NOEJEMPLAR,IDMATERIAL) ,
	CONSTRAINT FKEJEMPLAR FOREIGN KEY (IDMATERIAL) 
	REFERENCES MATERIAL (IDMATERIAL) ON DELETE CASCADE ,
	CONSTRAINT CHECKESTATUS CHECK (ESTATUS IN ('DISPONIBLE','PRESTAMO','NO SALE','MANTENIMIENTO'))
);
--********************************TIPOLECTOR***********************************
CREATE TABLE TIPOLECTOR(
	TIPO                 VARCHAR2(12) NOT NULL ,
	LIMITEMAT            NUMBER(2) NOT NULL ,
	DIASPREST            NUMBER(2) NOT NULL ,
	REFRENDOS            NUMBER(2) NOT NULL ,
	CONSTRAINT PKTIPOLECTOR PRIMARY KEY (TIPO) ,
	CONSTRAINT CHECKTIPO CHECK (TIPO IN ('ESTUDIANTE','PROFESOR','INVESTIGADOR'))
);
--********************************LECTOR***********************************
CREATE TABLE LECTOR(
	IDLECTOR             CHAR(6) NOT NULL ,
	NOMBREL              VARCHAR2(30) NOT NULL ,
	APELLIDOPL           VARCHAR2(30) NOT NULL ,
	APELLIDOML           VARCHAR2(30) ,
	DELEGACION           VARCHAR2(20) NOT NULL ,
	COLONIA              VARCHAR2(20) NOT NULL ,
	NUMERO               NUMBER(10) NOT NULL ,
	FECHAALTA            DATE NOT NULL ,
	CP                   NUMBER(5) NOT NULL ,
	ADEUDO               NUMBER(5) NULL ,
	FECHAVIGENCIA        DATE NOT NULL ,
	TIPO                 VARCHAR2(12) NOT NULL ,
	CONSTRAINT  PKLECTOR PRIMARY KEY (IDLECTOR) ,
	CONSTRAINT FKLECTOR FOREIGN KEY (TIPO) 
	REFERENCES TIPOLECTOR (TIPO) ON DELETE SET NULL ,
	CONSTRAINT UNIQUECP UNIQUE (CP)
);
--********************************PRESTAMO***********************************
CREATE TABLE PRESTAMO(
	IDPRESTAMO           CHAR(6) NOT NULL ,
	IDLECTOR             CHAR(6) NOT NULL ,
	NOEJEMPLAR           NUMBER(6) NOT NULL ,
	IDMATERIAL           CHAR(6) NOT NULL ,
	FECHAPREST           DATE NOT NULL ,
	FECHAVENC            DATE NOT NULL ,
	DIASATRASO           NUMBER(2) NULL ,
	FECHAMULTA           DATE NULL ,
	MONTO                NUMBER(5) NULL ,
	FECHADEV             DATE NOT NULL ,
	NUMREFRENDO          NUMBER(5) NOT NULL ,
	FECHAREFERENDO       DATE NOT NULL ,
	CONSTRAINT  PKPRESTAMO PRIMARY KEY (NOEJEMPLAR,IDMATERIAL,IDLECTOR) ,
	CONSTRAINT FKPRESTAMO_LEC FOREIGN KEY (IDLECTOR) 
	REFERENCES LECTOR (IDLECTOR) ON DELETE CASCADE,
	CONSTRAINT FKPRESTAMO_EJE FOREIGN KEY (NOEJEMPLAR, IDMATERIAL) 
	REFERENCES EJEMPLAR (NOEJEMPLAR, IDMATERIAL) ON DELETE CASCADE
);
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
	FROM LECTOR

--VIEW DE LIBROS
CREATE OR REPLACE VIEW VW_LIBRO AS
	SELECT IDMATERIAL,NOADQUISICION,ISBN,TEMA,EDICION
	FROM LIBRO

--VIEW DE MATERIALES
CREATE OR REPLACE VIEW VW_MATERIAL AS
	SELECT IDMATERIAL,TITULO,UBICACION,COLOCACION,TIPOMATERIAL 
	FROM MATERIAL

--VIEW DE PERTENECE
CREATE OR REPLACE VIEW VW_PERTENECE AS
	SELECT IDAUTOR,IDMATERIAL
    FROM PERTENECE

--VIEW DE PRESTAMOS
CREATE OR REPLACE VIEW VW_PRESTAMO AS
	SELECT IDPRESTAMO,IDLECTOR,NOEJEMPLAR,IDMATERIAL,FECHAPREST,
	FECHAVENC,DIASATRASO,FECHAMULTA,MONTO,FECHADEV,NUMREFRENDO
	,FECHAREFERENDO
    FROM PRESTAMO

--VIEW DE TESIS
CREATE OR REPLACE VIEW VW_TESIS AS
	SELECT IDMATERIAL,IDDIRECTOR,IDTESIS,CARRERA,ANOPUB
    FROM TESIS

--VIEW DE TIPOLECTOR
CREATE OR REPLACE VIEW VW_TIPOLECTOR AS
	SELECT TIPO,LIMITEMAT,DIASPREST,REFRENDOS
    FROM TIPOLECTOR
--*******************************FUNCIONES**********************************
--FUNCION PARA OBTENER SI UN LECTOR TIENE MULTA (1=TIENE, 0=NO TIENE)
CREATE OR REPLACE FUNCTION FT_MULTA (V_IDLECTOR CHAR)
RETURN NUMBER
IS
V_ADEUDO LECTOR.ADEUDO%TYPE;
V_MULTA NUMBER;
BEGIN
    SELECT ADEUDO
    INTO V_ADEUDO
    FROM LECTOR
    WHERE IDLECTOR = V_IDLECTOR; 
    IF (V_ADEUDO <> 0 OR V_ADEUDO <> NULL)
        THEN V_MULTA:=1;
    ELSE
        V_MULTA:=0;
    END IF;
    RETURN(V_MULTA);
END;
/

--FUNCION PARA OBTENER DISPONIBILIDAD DE MATERIAL POR SU ESTATUS
CREATE OR REPLACE FUNCTION FT_PRESTAMODISP (V_IDMATERIAL CHAR)
RETURN NUMBER
IS
V_ESTATUS EJEMPLAR.ESTATUS%TYPE;
V_RESULTADO NUMBER;
BEGIN
    SELECT ESTATUS
    INTO V_ESTATUS
    FROM EJEMPLAR
    WHERE IDMATERIAL = V_IDMATERIAL; 
    IF (V_ESTATUS = 'PRESTAMO' OR V_ESTATUS = 'NO SALE' OR V_ESTATUS = 'MANTENIMIENTO')
        THEN V_RESULTADO:=1;
    ELSE
        V_RESULTADO:=0;
    END IF;
    RETURN(V_RESULTADO);
END;
/
--********************************TRIGGERS**********************************


--********************************BORRADO***********************************
DROP TABLE AUTOR CASCADE CONSTRAINTS;
DROP TABLE DIRECTOR CASCADE CONSTRAINTS;
DROP TABLE MATERIAL CASCADE CONSTRAINTS;
DROP TABLE PERTENECE CASCADE CONSTRAINTS;
DROP TABLE TESIS CASCADE CONSTRAINTS;
DROP TABLE LIBRO CASCADE CONSTRAINTS;
DROP TABLE EJEMPLAR CASCADE CONSTRAINTS;
DROP TABLE TIPOLECTOR CASCADE CONSTRAINTS;
DROP TABLE LECTOR CASCADE CONSTRAINTS;
DROP TABLE PRESTAMO CASCADE CONSTRAINTS;