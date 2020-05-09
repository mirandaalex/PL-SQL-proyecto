--********************************TRIGGERS**********************************
--TRIGGER PARA CAMBIAR EL ESTATUS AL INSERTAR EN PRESTAMO
CREATE OR REPLACE TRIGGER TR_ESTATUS_PRESTAMO
BEFORE INSERT ON PRESTAMO
FOR EACH ROW
DECLARE
V_ESTATUS VARCHAR2(20);
BEGIN    
    V_ESTATUS := FT_PRESTAMODISP(:NEW.IDMATERIAL);
    IF(V_ESTATUS='DISPONIBLE') THEN
    	UPDATE EJEMPLAR SET ESTATUS='PRESTAMO'
    	WHERE IDMATERIAL = :NEW.IDMATERIAL;
    ELSE
    	IF (V_ESTATUS='NO SALE') THEN
    		DBMS_OUTPUT.PUT_LINE('EL MATERIAL NO PUEDE SALIR DE LA BIBLIOTECA');
    	ELSE
    		IF (V_ESTATUS='MANTENIMIENTO') THEN
    			DBMS_OUTPUT.PUT_LINE('EL MATERIAL SE ENCUENTRA EN MANTENIMIENTO');
    		ELSE
    			IF (V_ESTATUS='PRESTAMO') THEN
    				DBMS_OUTPUT.PUT_LINE('EL MATERIAL YA ENCUENTRA EN PRESTAMO');
    			END IF;
    		END IF;
    	END IF;
    END IF;
END;
/
--TRIGGER PARA IMPEDIR ELIMINAR UN PRESTAMO SI TIENE ADEUDOS
CREATE OR REPLACE TRIGGER TR_ADEUDOS
AFTER DELETE ON PRESTAMO
FOR EACH ROW
BEGIN
	IF (:OLD.FECHAMULTA <> NULL) THEN
		DBMS_OUTPUT.PUT_LINE('EL PRESTAMO TIENE UNA MULTA NO SE PUEDE ELIMINAR HASTA LIQUIDAR');
    END IF;
END;
/
--TRIGUER PARA IMPEDIR ELIMINAR UN LECTOR SI TIENE PRESTAMOS
CREATE OR REPLACE TRIGGER TR_ELIMINA_LECTOR_ADEUDO
AFTER DELETE ON LECTOR
FOR EACH ROW
DECLARE
VIDLECTOR LECTOR.IDLECTOR%TYPE;
BEGIN
	SELECT IDLECTOR
	INTO VIDLECTOR
	FROM LECTOR
	WHERE :OLD.IDLECTOR=ANY(SELECT IDLECTOR
						FROM PRESTAMO);
	IF (VIDLECTOR <> NULL) THEN
		DBMS_OUTPUT.PUT_LINE('EL LECTOR TIENE UNA MULTA NO SE PUEDE ELIMINAR HASTA LIQUIDAR');
    END IF;
END;
/
--TRIGGER PARA IMPEDIR ELIMINAR UN MATERIAL SI ALGUN EJEMPLAR SE ENCUENTRA PRESTADO
CREATE OR REPLACE TRIGGER TR_ELIMINA_MATERIAL
AFTER DELETE ON MATERIAL
FOR EACH ROW
DECLARE
VIDMATERIAL MATERIAL.IDMATERIAL%TYPE;
BEGIN
	SELECT IDMATERIAL
	INTO VIDMATERIAL
	FROM MATERIAL
	WHERE :OLD.IDMATERIAL=ANY(SELECT IDMATERIAL
							FROM EJEMPLAR
							WHERE ESTATUS='PRESTAMO');
	IF (VIDMATERIAL <> NULL) THEN
		DBMS_OUTPUT.PUT_LINE('EL MATERIAL TIENE AL MENOS UN EJEMPLAR EN PRESTAMO POR LO CUAL NO SE PUEDE ELIMINAR');
    END IF;
END;
/
--TRIGGER PARA IMPEDIR REALIZAR MAS PRESTAMOS SI EL LECTOR TIENE ADEUDOS
CREATE OR REPLACE TRIGGER TR_IMPIDE_PRESTAMO_LECTOR
AFTER INSERT ON PRESTAMO
FOR EACH ROW
DECLARE
VIDLECTOR LECTOR.IDLECTOR%TYPE;
BEGIN
	SELECT IDLECTOR
	INTO VIDLECTOR
	FROM LECTOR
	WHERE :NEW.IDLECTOR=ANY(SELECT IDLECTOR
							FROM PRESTAMO
							WHERE FECHAMULTA <> NULL);
	IF (VIDLECTOR <> NULL) THEN
		DBMS_OUTPUT.PUT_LINE('EL LECTOR TIENE AL MENOS UNA MULTA POR LO CUAL NO SE PUEDEN DAR MAS PRESTAMOS');
    END IF;
END;
/
DROP TRIGGER TR_ESTATUS_PRESTAMO;
DROP TRIGGER TR_ADEUDOS;
DROP TRIGGER TR_ELIMINA_LECTOR_ADEUDO;
DROP TRIGGER TR_ELIMINA_MATERIAL;
DROP TRIGGER TR_IMPIDE_PRESTAMO_LECTOR;
COMMIT;