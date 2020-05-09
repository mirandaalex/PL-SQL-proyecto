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