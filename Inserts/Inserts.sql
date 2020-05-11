set serveroutput on
exec sp_alta_director('d1','fernando','flores','camacho','maestria');
exec sp_alta_autor('a1','mexicano','leonardo','carrillo','contreras');
exec sp_alta_material('m1','robotica estrategia didactica','edificio a','t001','tesis');
exec sp_alta_pertenece('a1','m1');
exec sp_alta_tesis('m1','d1','t1','fisica',to_date('01/02/2020','dd/mm/yyyy'));
exec sp_alta_ejemplar(1,'m1','disponible');
exec sp_alta_ejemplar(2,'m1','disponible');
exec sp_alta_ejemplar(3,'m1','no sale');

exec sp_alta_director('d2','hernan','larralde','ridaura','doctorado');
exec sp_alta_autor('a2','mexicano','luisana','claudio','pachecano');
exec sp_alta_material('m2','aglomeraciones de negocos','edificio a','t002','tesis');
exec sp_alta_pertenece('a2','m2');
exec sp_alta_tesis('m2','d2','t2','fisica',to_date('11/06/2020','dd/mm/yyyy'));
exec sp_alta_ejemplar(1,'m2','disponible');
exec sp_alta_ejemplar(2,'m2','disponible');
exec sp_alta_ejemplar(3,'m2','no sale');

exec sp_alta_director('d3','jessica','rosas','gutierrez','maestria');
exec sp_alta_autor('a3','mexicano','diego','castro','morales');
exec sp_alta_material('m3','plus ultra, terra firma','edificio a','t003','tesis');
exec sp_alta_pertenece('a3','m3');
exec sp_alta_tesis('m3','d3','t3','artes',to_date('13/05/2005','dd/mm/yyyy'));
exec sp_alta_ejemplar(1,'m3','disponible');
exec sp_alta_ejemplar(2,'m3','disponible');
exec sp_alta_ejemplar(3,'m3','no sale');

exec sp_alta_autor('a4','estados unidos','roland','edwin','larson');
exec sp_alta_material('m4','calculo','edificio a','b001','libro');
exec sp_alta_pertenece('a4','m4');
exec sp_alta_libro('m4',1,'9788436820','matematicas','decima edicion');
exec sp_alta_ejemplar(1,'m4','disponible');
exec sp_alta_ejemplar(2,'m4','disponible');
exec sp_alta_ejemplar(3,'m4','no sale');

exec sp_alta_autor('a5','reino unido','bhat','ramdas',null);
exec sp_alta_material('m5','modern probability theory','edificio a','b002','libro');
exec sp_alta_pertenece('a5','m5');
exec sp_alta_libro('m5',2,'9780852260','matematicas','segunda edicion');
exec sp_alta_ejemplar(1,'m5','disponible');
exec sp_alta_ejemplar(2,'m5','disponible');
exec sp_alta_ejemplar(3,'m5','no sale');

exec sp_alta_autor('a6','francia','antonie','saint-exupery',null);
exec sp_alta_material('m6','el principito','edificio a','b003','libro');
exec sp_alta_pertenece('a6','m6');
exec sp_alta_libro('m6',3,'9788498386','cuentos','primera edicion');
exec sp_alta_ejemplar(1,'m6','disponible');
exec sp_alta_ejemplar(2,'m6','disponible');
exec sp_alta_ejemplar(3,'m6','no sale');

exec sp_alta_tipo_lector('estudiante',3,8,1);
exec sp_alta_tipo_lector('profesor',5,15,2);
exec sp_alta_tipo_lector('investigador',10,30,3);

exec sp_alta_lector('l1','antonio','garcia','vasquez','miguel hidalgo','polanco','anatole france',327,11550,'estudiante');
exec sp_alta_lector('l2','rosa','pena','delgado','xochimilco','jardines del sur','sacatecas',74,16050,'estudiante');
exec sp_alta_lector('l3','irma','moreno','castillo','coyoacan','santo domingo','cerradas texalpa',35,04369,'profesor');
exec sp_alta_lector('l4','luis','castro','ramirez','coyoacan','copilco universidad','cerro sabino 3-17',29,04360,'profesor');
exec sp_alta_lector('l5','martin','ortega','santiago','coyoacan','copilco universidad','economia',17,04361,'investigador');

commit;
