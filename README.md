# Proyecto_Consultas_SQL
PROYECTO: DataProject: Lógica
Consultas SQL
1.	DESCRIPCIÓN
A partir del fichero “BBDD_Proyecto_shakila_sinuser.sql” que contiene los datos de un negocio de alquiler de películas, desarrollar un total de 62 consultas para aplicar los conocimientos adquiridos en el curso 
2.	ESTRUCTURA
El proyecto consta de 3 ficheros:
a)	DataProject_Consultas_SQL.sql: Script con las todas consultas propuestas 
--Cada ejercicio está encabezado con su número y enunciado como comentario y a continuación el desarrollo. Se incluyen algunos comentarios y resultados también comentados
b)	DataProject_Esquema.png: Imagen del diseño del esquema de la BBDD
c)	EnunciadoDataProject_SQL.Lógica.pdf: Fichero original descargado con todos los enunciados

3.	INSTALACIÓN Y REQUISITOS
El proyecto se ha realizado utilizando las aplicaciones:
-POSTGRES para cargar la base de datos
-DBEAVER para resolver las consultas
-GITHUB para publicar el proyecto

4.	RESULTADOS Y CONCLUSIONES
Se trata de un negocio con dos puntos de venta, uno en Australia y otro en Canada, y un total de dos empleados: Jon y Mike 
 
Acumula 599 clientes repartidos por 108 países.
Cuenta con un inventario de 4.581 copias de 1.000 títulos distintos. 
En total acumula un total 16.044 alquileres, lo que ha generado una facturación de 67.416,51$, es decir, una medía 4,2$ por operación y un gasto medio por cliente de 112,55$.
En cuanto a las películas, los 1.000 títulos están en inglés y se reparten en 16 categorías. Han intervenido un total de 200 actores.
El TOP5 lo conforman estas películas:
 

En lo académico, donde más dificultad he encontrado es en el uso de EXISTS / NOT EXISTS y, por otra parte, no sé si abuso de los JOIN, me gustaría profundar en la eficiencia de cada solución.

5.	PRÓXIMOS PASOS
•	Dado que las nacionalidades que más abundan entre los clientes son la India y China, valorar la posibilidad de ampliar el catálogo con títulos de esos orígenes 
para fidelizar a estos clientes
•	Revisar si es correcto el dato “año de lanzamiento” ya que todas las películas son de 2006. Y en caso de ser correcto, ampliar el catálogo con algo más de variedad!

6.	AUTOR
Sergio Molinero Canal
sergiomolinerocanal@gmail.com

