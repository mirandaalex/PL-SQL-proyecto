set serveroutput on
--*********************************views************************************
--view de autores
create or replace view vw_autor as
  select idautor,nacionalidad,nombrea,apellidopa,apellidoma
  from autor;
--view de directores
create or replace view vw_director as
  select iddirector,nombred,apellidopd,apellidomd,grado 
    from director;
--view de ejemplares
create or replace view vw_ejemplar as
  select noejemplar,idmaterial,estatus
  from ejemplar;
--view de lectores
create or replace view vw_lector as
  select idlector,nombrel,apellidopl,apellidoml,delegacion,
  colonia,numero,fechaalta,cp,adeudo,fechavigencia,tipo
  from lector;
--view de libros
create or replace view vw_libro as
  select idmaterial,noadquisicion,isbn,tema,edicion
  from libro;
--view de materiales
create or replace view vw_material as
  select idmaterial,titulo,ubicacion,colocacion,tipomaterial 
  from material;
--view de pertenece
create or replace view vw_pertenece as
  select idautor,idmaterial
  from pertenece;
--view de prestamos
create or replace view vw_prestamo as
  select idlector,noejemplar,idmaterial,fechaprest,
  fechavenc,diasatraso,fechamulta,monto,fechadev,numrefrendo
  from prestamo;
--view de tesis
create or replace view vw_tesis as
  select idmaterial,iddirector,idtesis,carrera,anopub
  from tesis;
--view de tipolector
create or replace view vw_tipolector as
  select tipo,limitemat,diasprest,refrendos
  from tipolector;
--view que muestra tipo lector de los lectores
create or replace view vw_lector_tipo as
  select idlector, nombrel,apellidopl,apellidoml
  ,tipo,limitemat,diasprest,refrendos
  from tipolector
  natural join lector;
--view que muestra las caracteristicas de un ejemplar
create or replace view vw_ejemplar_material as
  select noejemplar,tipomaterial,
  idmaterial,titulo,ubicacion,
  colocacion,estatus
  from material
  natural join ejemplar;
--view que muestra todos los ejemplares que son libros
create or replace view vw_ejemplar_libros as
  select noejemplar,idmaterial,estatus,
  noadquisicion,isbn,tema,edicion
  from ejemplar
  natural join libro;
--view que muestra todos los ejemplares que son tesis
create or replace view vw_ejemplar_tesis as
  select noejemplar,idmaterial,estatus,
  iddirector,idtesis,carrera,anopub
  from ejemplar
  natural join tesis;
drop view vw_autor;
drop view vw_director;
drop view vw_material;
drop view vw_pertenece;
drop view vw_tesis;
drop view vw_libro;
drop view vw_ejemplar;
drop view vw_tipolector;
drop view vw_lector;
drop view vw_prestamo;
drop view vw_lector_tipo;
drop view vw_ejemplar_material;
drop view vw_ejemplar_libros;
drop view vw_ejemplar_tesis;
commit;
