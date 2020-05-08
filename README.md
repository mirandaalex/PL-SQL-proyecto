# PL-SQL-proyecto
Proyecto de una biblioteca en Oracle PL/SQL

# Especificaciones
## Proyecto Final:

En una biblioteca se necesita llevar el control del préstamo de su material a sus lectores.
Todo material cuenta con un identificador, titulo, colocación, ubicación dentro de la biblioteca y autor; los autores están registrados con una clave de autor, nombre completo y nacionalidad. Se tienen dos tipos de materiales: libros y tesis; de los libros se tiene número de adquisición que es único, ISBN, tema y edición; las tesis están registradas con un identificador de tesis, carrera del tema de tesis, año de publicación, así como el director de tesis. Del director de tesis se tiene un identificador único, nombre completo y grado académico. De cada material se tiene por lo menos un ejemplar, para cada ejemplar se tiene número de ejemplar y estatus que indica si está disponible, en préstamo, no sale de la biblioteca o si esta en mantenimiento.
Los lectores están registrados por un identificador, tipo de lector (alumno, profesor, investigador), nombre completo, dirección, teléfono, adeudo, fecha en la cual se dio de alta en la biblioteca y fecha de vigencia (un año a partir de la fecha de alta en la biblioteca), dependiendo del tipo de lector es el límite de materiales que puede solicitar en préstamo, días permitidos, así como número de refrendos autorizados.

LECTOR| LIMITE MATERIALES| DIAS PREST| REFRENDOS
------------ | -- | -- | -
Estudiante | 3 | 8 | 1 
Profesor | 5 | 15 | 2 
Investigador | 10 | 30 | 3 

Al realizarse un préstamo es indispensable almacenar información sobre la fecha en la que se realiza, así como la fecha de vencimiento en base al tipo de lector. Al realizarse una devolución es importante considerar que la fecha de devolución no exceda de la fecha de vencimiento o de lo contrario se registrará una multa (10 pesos por día de atraso) en la cual se debe de considerar el lector que lo solicito, el material en préstamo, la fecha de la multa, número de días de retraso y el monto al que se hizo acreedor, en el caso de resello se debe de considerar el número de refrendos permitidos de acuerdo al tipo de lector. Los refrendos se realizan únicamente en la fecha de vencimiento.

## Consideraciones:
- Si un lector tiene una multa, no se le podrán prestar materiales hasta que la haya liquidado.

- Al realizarse el préstamo de un ejemplar, se deberá de modificar el estatus de éste automáticamente.

- El resello de un material se realiza únicamente en la fecha de vencimiento del préstamo en función del tipo de lector.

- Al realizarse una devolución en tiempo, se eliminará el préstamo

- Al resellar el préstamo de un material, la fecha del préstamo cambiará a la fecha en la que se resella, la fecha de vencimiento se volverá a calcular dependiendo del tipo de lector y se actualizará el número de refrendo
automáticamente.

## El proyecto deberá contener:
- Enunciado del problema
- Diseño Conceptual (modelo ER)
- Diseño Lógico (modelo Relacional, diccionario de datos, normalización)
- Diseño Físico (DDL, DML, pl/sql: procedimientos almacenados, funciones,disparadores y vistas)


# Notas

Especificaciones [aquí](https://drive.google.com/open?id=1bRfVkDmlLKG1r-Jt8g6RCQMaF705RViU)
