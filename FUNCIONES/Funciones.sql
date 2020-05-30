set serveroutput on
--*******************************funciones**********************************
--funcion que calcula la fecha de devolucion a partir de la fecha actual
create or replace function ft_fechadev (idlect char)
return date
is
vdiasprest tipolector.diasprest%type;
vdatedev date;
begin
    select diasprest
    into vdiasprest
    from lector  
    natural join tipolector 
    where idlector=idlect;
    vdatedev:=sysdate+vdiasprest;
    return (vdatedev);
end ft_fechadev;
/
--funcion para obtener los refrendos
create or replace function ft_obtiene_refrendo(idlect char)
return number
is
    vrefrendo number(5);
    vtipo lector.tipo%TYPE;
begin
    select tipo 
    into vtipo
    from lector
    where idlector = idlect; 
    if vtipo = 'estudiante' OR vtipo = 'profesor' OR vtipo = 'investigador' then
        select refrendos 
        into vrefrendo
        from tipolector
        where tipo=vtipo;
    end if;
    
    return (vrefrendo);
end ft_obtiene_refrendo;
/
--funcion que devuelve el numero de refrendos restantes
create or replace function ft_actualiza_refrendo(vidlect char,vnoejemplar number,vidmaterial char)
return number
is
    vrefrendosrestantes number(5);
begin
    select numrefrendo 
    into vrefrendosrestantes
    from prestamo
    where idlector = vidlect 
    and noejemplar = vnoejemplar
    and idmaterial = vidmaterial;
    vrefrendosrestantes:=vrefrendosrestantes - 1;
    return (vrefrendosrestantes);
end ft_actualiza_refrendo;
/
--funcion que calcula el numero de materiales que puede sacar
create or replace function ft_materialrestante(vidlec in char)
return number
is
vcantidad number;
vmax number;
vaux number;
begin
    select count(*)  
    into vcantidad
    from prestamo
    where idlector=vidlec;
    select limitemat
    into vmax
    from tipolector
    where tipo=(select tipo
                from lector
                where idlector=vidlec);
    if (vcantidad=0) then
        return(vmax);
    else
        vaux:=vmax-vcantidad;
        return(vaux);
    end if;
end ft_materialrestante;
/
--funcion que verifica si hay multas existentes del lector
create or replace function ft_verficamulta(vidlec in char)
return number
is
vadeudo number(5);
vnmultas number(1);
begin
    select adeudo
    into vadeudo
    from lector
    where idlector=vidlec;
    vnmultas:=0;
    if (vadeudo<>0) then
        vnmultas:=1;
    end if;
    return (vnmultas);
end;
/
drop function ft_multa;
drop function ft_fechadev;
drop function ft_obtiene_refrendo;
drop function ft_actualiza_refrendo;
drop function ft_materialrestante;
