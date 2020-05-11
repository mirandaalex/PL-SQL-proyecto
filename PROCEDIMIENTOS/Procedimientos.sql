set serveroutput on;
--****************************procedimientos de alta********************************
--alta de lector
create or replace procedure sp_alta_lector(vidlector char,vnombrel varchar2, 
vapellidopl varchar2, vapellidoml varchar2, vdelegacion varchar2,vcolonia varchar2,vcalle varchar2,
vnumero number,vcp number,vtipo varchar2)
as
begin
    insert into lector (idlector,nombrel,apellidopl,apellidoml,delegacion,colonia,calle,numero,fechaalta,cp,adeudo,fechavigencia,tipo) 
    values(vidlector,vnombrel,vapellidopl,vapellidoml,vdelegacion,vcolonia,vcalle,vnumero,sysdate,vcp,0,add_months(sysdate,12),vtipo);
    dbms_output.put_line('usuario dado de alta exitosamente');
end;
/
--alta de tipo de lector
create or replace procedure sp_alta_tipo_lector(vtipo varchar2,vlimitemat number,vdiasprest number,vrefrendos number)
as
begin
    insert into tipolector values(vtipo,vlimitemat,vdiasprest,vrefrendos);
    dbms_output.put_line('tipo usuario creado exitosamente');
end;
/
--alta autor
create or replace procedure sp_alta_autor(vidautor char,vnacionalidad varchar2,
vnombrea varchar2,vapellidopa varchar2,vapellidoma varchar2)
as
begin
    insert into autor values(vidautor,vnacionalidad,vnombrea,vapellidopa,vapellidoma);
    dbms_output.put_line('autor dado de alta exitosamente');
end;
/
--alta director de tesis
create or replace procedure sp_alta_director(viddirector char,vnombred varchar2,
vapellidopd varchar2,vapellidomd varchar2,vgrado varchar2)
as
begin
    insert into director values(viddirector,vnombred,vapellidopd,vapellidomd,vgrado);
    dbms_output.put_line('director de tesis dado de alta exitosamente');
end;
/
--alta material
create or replace procedure sp_alta_material(vidmaterial char,vtitulo varchar2,
vubicacion char,vcolocacion char,vtipomaterial varchar2)
as
begin
    insert into material values(vidmaterial,vtitulo,vubicacion,vcolocacion,vtipomaterial);
    dbms_output.put_line('material dado de alta exitosamente');
end;
/
--alta tesis
create or replace procedure sp_alta_tesis(vidmaterial char,viddirector char,
vidtesis char,vcarrera varchar2,vanopub date)
as
begin
    insert into tesis values(vidmaterial,viddirector,vidtesis,vcarrera,vanopub);
    dbms_output.put_line('tesis dada de alta exitosamente');
end;
/
--alta libro
create or replace procedure sp_alta_libro(vidmaterial char,vnoadquisicion number,
visbn char,vtema varchar2,edicion varchar2)
as
begin
    insert into libro values(vidmaterial,vnoadquisicion,visbn,vtema,edicion);
    dbms_output.put_line('libro dado de alta exitosamente');
end;
/
--alta ejemplar
create or replace procedure sp_alta_ejemplar(vnoejemplar number,vidmaterial char,
vestatus varchar2)
as
begin
    insert into ejemplar values(vnoejemplar,vidmaterial,vestatus);
    dbms_output.put_line('ejemplar dado de alta exitosamente');
end;
/
--alta pertenece
create or replace procedure sp_alta_pertenece(vidautor char,vidmaterial char)
as
begin
    insert into pertenece values(vidautor,vidmaterial);
end;
/
--****************************procedimientos de baja********************************
--baja de autor
create or replace procedure sp_baja_autor(vidautor char)
as
begin
    delete from autor where idautor=vidautor;
    dbms_output.put_line('lector eliminado exitosamente');
end;
/
--baja de tipo de lector
create or replace procedure sp_baja_tipo_lector(vtipo varchar2)
as
begin
    delete from tipolector where tipo=vtipo;
    dbms_output.put_line('tipo de lector eliminado exitosamente');
    
end;
/
--baja lector
create or replace procedure sp_baja_lector(vidlector char)
as
vbaja number:=0;
begin
    select count(*) into vbaja
    from prestamo where idlector=vidlector;
    if vbaja=0 then
        delete from lector where idlector=vidlector;
        dbms_output.put_line('lector dado de baja exitosamente');
    else
        dbms_output.put_line('no se puede dar de baja tiene prestamos o multas');
    end if;
end;
/
--baja director de tesis
create or replace procedure sp_baja_director(viddirector char)
as
begin
    delete from director where iddirector=viddirector;
    dbms_output.put_line('director de tesis dado de alta exitosamente');
end;
/
--baja material
create or replace procedure sp_baja_material(vidmaterial char)
as
vbaja number;
begin
    select count(*) into vbaja
    from prestamo where idmaterial=vidmaterial;
    if vbaja=0 then
        delete from material where idmaterial=vidmaterial;
        dbms_output.put_line('material dado de baja exitosamente');
    else
        dbms_output.put_line('el material no se pudo dar de baja hay '||vbaja ||' en prestamo');
    end if;
end;
/
--****************************procedimientos de prestamo********************************
--alta prestamo
create or replace procedure sp_alta_prestamo(vidlector char,vnoejemplar number,vidmaterial char)
as
vfechavenc date;
vnumrefrendo number(5);
vrestantes number;
vdisp varchar(30);
vtotal number(9);
vtotal1 number(9);
begin    
    vrestantes:= ft_materialrestante(vidlector);
    vtotal:= ft_verficamulta(vidlector);
    if vrestantes>0 and vtotal=0 then 
        vfechavenc:=ft_fechadev(vidlector);
        vnumrefrendo:=ft_obtiene_refrendo(vidlector);
        insert into prestamo(idlector,noejemplar,idmaterial,fechaprest,fechavenc,numrefrendo) 
        values(vidlector,vnoejemplar,vidmaterial,sysdate,vfechavenc,vnumrefrendo);
        dbms_output.put_line('prestamo realizado correctamente');
    elsif (vtotal <> 0) then
        raise_application_error (-20602,'el lector tiene multas, no puede sacar material');
    else
        raise_application_error (-20603,'no se pudo realizar el prestamo, debido a que se exedio el limite de material permitido');
    end if;
end;
/
--refrendo de prestamo
create or replace procedure sp_refrendo_prestamo(vidlector char,vnoejemplar number,vidmaterial char)
as
vfechavenc date;
vfechadev date;
vnueva_fechavenc date;
vnumrefrendo number(5);
vaux number(1);
begin
    select fechavenc
    into vfechavenc
    from prestamo
    where idlector=vidlector and noejemplar=vnoejemplar and idmaterial=vidmaterial;
    vfechadev:=sysdate;
    vaux:=trunc(vfechadev)-trunc(vfechavenc);
    if (vaux=0) then
        vnumrefrendo:=ft_actualiza_refrendo(vidlector,vnoejemplar,vidmaterial);
        if (vnumrefrendo>=0) then
            vnueva_fechavenc:=ft_fechadev(vidlector);
            update prestamo set fechaprest= sysdate, fechavenc= vnueva_fechavenc, numrefrendo=vnumrefrendo
            where idlector=vidlector and noejemplar=vnoejemplar and idmaterial=vidmaterial;
            dbms_output.put_line('refrendo realizado, prestamo actualizado');
        else
            raise_application_error (-20604,'los refrendos de este lector para este libro se han agotado');
        end if;
    else
        raise_application_error (-20605,'solo se permiten refrendos en las fechas de vencimiento del prestamo');
    end if;
end;
/
--procedimiento para calcular multa
create or replace procedure sp_multa(vidlector char,vnoejemplar number,vidmaterial char)
as
vfechavenc date;
vfechadev date;
vaux number(3);
vmonto number(5);
begin
    select fechavenc
    into vfechavenc
    from prestamo
    where idlector=vidlector and noejemplar=vnoejemplar and idmaterial=vidmaterial;
    vfechadev:=sysdate+15;
    vaux:=trunc(vfechadev)-trunc(vfechavenc);
    vmonto:=vaux*10;
    update prestamo set fechamulta=sysdate, diasatraso=vaux,monto=vmonto
    where idlector=vidlector and noejemplar=vnoejemplar and idmaterial=vidmaterial;
    sp_adeudo(vidlector,vnoejemplar,vidmaterial);
end;
/
--procedimiento para calcular adeudo
create or replace procedure sp_adeudo(vidlector char,vnoejemplar number,vidmaterial char)
as
vmonto number(15);
vadeudo number(15);
vnewadeudo number(15);
begin
    select monto
    into vmonto
    from prestamo
    where idlector=vidlector and noejemplar=vnoejemplar and idmaterial=vidmaterial;
    select adeudo
    into vadeudo
    from lector
    where idlector=vidlector;
    if(vadeudo=0)then
        vnewadeudo:=vmonto;
        update lector set adeudo=vnewadeudo
        where idlector=vidlector;
        dbms_output.put_line('se ha registrado una multa exitosamente');
    else
        vnewadeudo:=vmonto+vadeudo;
        update lector set adeudo=vnewadeudo
        where idlector=vidlector;
        dbms_output.put_line('se ha registrado una multa exitosamente');
    end if;
end;
/
--procedimiento para borrar multa y prestamo respectivo
create or replace procedure sp_liquida_multa(vidlector char,vnoejemplar number,vidmaterial char)
as
vmonto number(5);
vadeudo number(5);
vnewadeudo number(5);
begin
    select adeudo
    into vadeudo
    from lector
    where idlector=vidlector;
    select monto
    into vmonto
    from prestamo
    where idlector=vidlector and noejemplar=vnoejemplar and idmaterial=vidmaterial;
    vnewadeudo:=vadeudo-vmonto;
    update prestamo set fechamulta=null, diasatraso=null,monto=null
    where idlector=vidlector and noejemplar=vnoejemplar and idmaterial=vidmaterial;
    update lector set adeudo=vnewadeudo where idlector=vidlector;
    delete from prestamo 
    where idlector=vidlector and noejemplar=vnoejemplar and idmaterial=vidmaterial;
    dbms_output.put_line('se elimino la multa exitosamente');
end;
/
--baja de prestamo
create or replace procedure sp_baja_prestamo(vidlector char,vnoejemplar number,vidmaterial char)
as
vfechavenc date;
vfechadev date;
vaux number(3);
begin
    select fechavenc
    into vfechavenc
    from prestamo
    where idlector=vidlector and noejemplar=vnoejemplar and idmaterial=vidmaterial;
    vfechadev:=sysdate+15;
    vaux:=trunc(vfechadev)-trunc(vfechavenc);
    if (vaux<=0) then
        delete from prestamo where idlector=vidlector and noejemplar=vnoejemplar and idmaterial=vidmaterial;
        dbms_output.put_line('el prestamo se borro correctamente');
    else
        sp_multa(vidlector,vnoejemplar,vidmaterial);
    end if;
end;
/
drop procedure sp_alta_lector;
drop procedure sp_alta_tipo_lector;
drop procedure sp_alta_autor;
drop procedure sp_alta_director;
drop procedure sp_alta_material;
drop procedure sp_alta_tesis;
drop procedure sp_alta_libro;
drop procedure sp_alta_ejemplar;
drop procedure sp_alta_pertenece;
drop procedure sp_baja_autor;
drop procedure sp_baja_tipo_lector;
drop procedure sp_baja_lector;
drop procedure sp_baja_director;
drop procedure sp_baja_material;
drop procedure sp_alta_prestamo;
drop procedure sp_refrendo_prestamo;
drop procedure sp_multa;
drop procedure sp_adeudo;
drop procedure sp_liquida_multa;
drop procedure sp_baja_prestamo;
commit;
