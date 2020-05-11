set serveroutput on
--********************************triggers**********************************
--trigger para cambiar el estatus del ejemplar al insertar o eliminar en la tabla prestamo
create or replace trigger tr_estatus_prestamo
before insert or delete on prestamo
for each row
declare
vestatus varchar2(20);
begin  
    if inserting then
        select estatus
        into vestatus
        from ejemplar
        where idmaterial=:new.idmaterial and noejemplar=:new.noejemplar;
        if (vestatus='disponible') then
            update ejemplar set estatus='prestamo' 
            where idmaterial=:new.idmaterial 
            and noejemplar=:new.noejemplar;
        else
            if (vestatus='no sale' or vestatus='mantenimiento') then
                raise_application_error (-20600,' el material tiene el estatus: '||vestatus||' y no esta autorizado para su prestamo');
            end if;
        end if;
    end if;
    if deleting then
        select estatus
        into vestatus
        from ejemplar
        where idmaterial=:old.idmaterial and noejemplar=:old.noejemplar;
        if (vestatus='prestamo') then
            update ejemplar set estatus='disponible' 
            where idmaterial=:old.idmaterial 
            and noejemplar=:old.noejemplar;
        end if;
    end if;
end;
/
drop trigger tr_estatus_prestamo;
commit;
