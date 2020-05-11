set serveroutput on
--********************************autor***********************************
create table autor(
	idautor              char(6) not null ,
	nacionalidad         varchar2(30) not null ,
	nombrea              varchar2(30) not null ,
	apellidopa           varchar2(30) not null ,
	apellidoma           varchar2(30) ,
	constraint pkautor primary key (idautor)
);
--********************************director***********************************
create table director(
	iddirector           char(6) not null ,
	nombred              varchar2(30) not null ,
	apellidopd           varchar2(30) not null ,
	apellidomd           varchar2(30) ,
	grado                varchar2(20) not null ,
	constraint pkdirector primary key (iddirector) 
);
--********************************material***********************************
create table material(
	idmaterial           char(6) not null ,
	titulo               varchar2(30) not null ,
	ubicacion            char(20) not null ,
	colocacion           char(20) not null ,
	tipomaterial         varchar2(10) not null ,
	constraint pkmaterial primary key (idmaterial) ,
	constraint checkmaterial check (tipomaterial in ('tesis','libro')) 
);
--********************************pertenece***********************************
create table pertenece(
	idautor              char(6) not null ,
	idmaterial           char(6) not null ,
	constraint pkpertenece primary key (idautor,idmaterial) ,
	constraint fkpertenece_aut foreign key (idautor) 
	references autor (idautor) on delete cascade ,
	constraint fkpertenece_mat foreign key (idmaterial) 
	references material (idmaterial) on delete cascade
);
--********************************tesis***********************************
create table tesis(
	idmaterial           char(6) not null ,
	iddirector           char(6) null ,
	idtesis              char(6) not null ,
	carrera              varchar2(20) not null ,
    anopub               date not null ,
	constraint pktesis primary key (idmaterial) ,
	constraint fktesis_dir foreign key (iddirector) 
	references director (iddirector) on delete set null ,
	constraint fktesis_mat foreign key (idmaterial) 
	references material (idmaterial) on delete cascade ,
	constraint uniquetesis unique (idtesis)
);
--********************************libro***********************************
create table libro(
	idmaterial           char(6) not null ,
	noadquisicion        number(5) not null ,
	isbn                 char(10) not null ,
	tema                 varchar2(30) not null ,
	edicion              varchar2(30) not null ,
	constraint pklibro primary key (idmaterial) ,
	constraint fklibro foreign key (idmaterial) 
	references material (idmaterial) on delete cascade ,
	constraint uniquenoadquisicion unique (noadquisicion) ,
	constraint uniquelibro unique (isbn)
);
--********************************ejemplar***********************************
create table ejemplar(
	noejemplar           number(6) not null ,
	idmaterial           char(6) not null ,
	estatus              varchar2(20) not null ,
	constraint pkejemplar primary key (noejemplar,idmaterial) ,
	constraint fkejemplar foreign key (idmaterial) 
	references material (idmaterial) on delete cascade ,
	constraint checkestatus check (estatus in ('disponible','prestamo','no sale','mantenimiento'))
);
--********************************tipolector***********************************
create table tipolector(
	tipo                 varchar2(12) not null ,
	limitemat            number(2) not null ,
	diasprest            number(2) not null ,
	refrendos            number(2) not null ,
	constraint pktipolector primary key (tipo) ,
	constraint checktipo check (tipo in ('estudiante','profesor','investigador'))
);
--********************************lector***********************************
create table lector(
	idlector             char(6) not null ,
	nombrel              varchar2(30) not null ,
	apellidopl           varchar2(30) not null ,
	apellidoml           varchar2(30) ,
	delegacion           varchar2(20) not null ,
	colonia              varchar2(20) not null ,
    calle                varchar2(30) not null ,
	numero               number(10) not null ,
	fechaalta            date not null ,
	cp                   number(5) not null ,
	adeudo               number(5) null ,
	fechavigencia        date not null ,
	tipo                 varchar2(12) null ,
	constraint  pklector primary key (idlector) ,
	constraint fklector foreign key (tipo) 
	references tipolector (tipo) on delete set null
);
--********************************prestamo***********************************
create table prestamo(
	idlector             char(6) not null ,
	noejemplar           number(6) not null ,
	idmaterial           char(6) not null ,
	fechaprest           date not null ,
	fechavenc            date not null ,
	diasatraso           number(2) null ,
	fechamulta           date null ,
	monto                number(5) null ,
	numrefrendo          number(5) not null ,
	constraint  pkprestamo primary key (noejemplar,idmaterial,idlector) ,
	constraint fkprestamo_lec foreign key (idlector) 
	references lector (idlector) on delete cascade,
	constraint fkprestamo_eje foreign key (noejemplar, idmaterial) 
	references ejemplar (noejemplar, idmaterial) on delete cascade
);
--********************************borrado***********************************
drop table autor cascade constraints;
drop table director cascade constraints;
drop table material cascade constraints;
drop table pertenece cascade constraints;
drop table tesis cascade constraints;
drop table libro cascade constraints;
drop table ejemplar cascade constraints;
drop table tipolector cascade constraints;
drop table lector cascade constraints;
drop table prestamo cascade constraints;
commit;
