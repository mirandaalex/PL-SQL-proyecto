SET SERVEROUTPUT ON
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
	IDDIRECTOR           CHAR(6) NULL ,
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
    CALLE                VARCHAR2(30) NOT NULL ,
	NUMERO               NUMBER(10) NOT NULL ,
	FECHAALTA            DATE NOT NULL ,
	CP                   NUMBER(5) NOT NULL ,
	ADEUDO               NUMBER(5) NULL ,
	FECHAVIGENCIA        DATE NOT NULL ,
	TIPO                 VARCHAR2(12) NULL ,
	CONSTRAINT  PKLECTOR PRIMARY KEY (IDLECTOR) ,
	CONSTRAINT FKLECTOR FOREIGN KEY (TIPO) 
	REFERENCES TIPOLECTOR (TIPO) ON DELETE SET NULL
);
--********************************PRESTAMO***********************************
CREATE TABLE PRESTAMO(
	IDLECTOR             CHAR(6) NOT NULL ,
	NOEJEMPLAR           NUMBER(6) NOT NULL ,
	IDMATERIAL           CHAR(6) NOT NULL ,
	FECHAPREST           DATE NOT NULL ,
	FECHAVENC            DATE NOT NULL ,
	DIASATRASO           NUMBER(2) NULL ,
	FECHAMULTA           DATE NULL ,
	MONTO                NUMBER(5) NULL ,
	NUMREFRENDO          NUMBER(5) NOT NULL ,
	CONSTRAINT  PKPRESTAMO PRIMARY KEY (NOEJEMPLAR,IDMATERIAL,IDLECTOR) ,
	CONSTRAINT FKPRESTAMO_LEC FOREIGN KEY (IDLECTOR) 
	REFERENCES LECTOR (IDLECTOR) ON DELETE CASCADE,
	CONSTRAINT FKPRESTAMO_EJE FOREIGN KEY (NOEJEMPLAR, IDMATERIAL) 
	REFERENCES EJEMPLAR (NOEJEMPLAR, IDMATERIAL) ON DELETE CASCADE
);
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
COMMIT;