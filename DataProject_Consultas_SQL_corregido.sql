--1. Crea el esquema de la BBDD.
/*Seleccionamos la BBDD , botón derecho y la establecemos por defecto
 * expandimos la carpeta "Esquemas"
 * pinchamos con el derecho en "Public" y después en "ver Esquema"
 * Se abren dos pestañas, hacemos clic en "Diagrama" */

-- 2. Muestra los nombres de todas las películas con una clasificación por edades de ‘R’.
select "title" as "Título", "rating" as "Clasificación"
from "film"
where "rating" = 'R'
; -- Tenemos 195 películas con Rating 'R'

--3. Encuentra los nombres de los actores que tengan un “actor_id” entre 30 y 40.
select "actor_id", Concat("first_name", ' ', "last_name") as "Nombre Completo"
from "actor"
where "actor_id" between 30 and 40
;

--4. Obtén las películas cuyo idioma coincide con el idioma original.
select "title" as "Título", "language_id" "Idioma"
from "film"
where "original_language_id" is null or "original_language_id" = "language_id" 
; -- Traemos todos los títulos que tenga vacío el campo "original_language_id" o bien, que, para los que no esté vacío, sea igual al "language_id"

--5. Ordena las películas por duración de forma ascendente.
select "title" as "Título", "length" as "Duración"
from "film"
order by "length" asc
;---listamos las 1.000 peliciulas y vemos que la más corta dura 46 minutos, mientras que la más llega a las 3h 05m

--6. Encuentra el nombre y apellido de los actores que tengan ‘Allen’ en su apellido.
select "actor_id", Concat("first_name", ' ', "last_name") as "Nombre Completo", "last_name" as "Apellido"
from "actor"
where "last_name" = 'ALLEN'
order by "Nombre Completo"
; -- Tenemos 3 actores que se apellidan 'ALLEN'. Importante en este caso, la distinción entre mayúsculas y minúsculas!

--7. Encuentra la cantidad total de películas en cada clasificación de la tabla “film” y muestra la clasificación junto con el recuento.
select "rating" as "Clasificación", count("rating") as "Número de películas"
from "film"
group by "rating"
order by "Número de películas" desc
; --Tenemos 5 categorías diferentes de 'rating' siendo PG-13 la que más títulos acumula

--8. Encuentra el título de todas las películas que son ‘PG-13’ o tienen una duración mayor a 3 horas en la tabla film.
select "title" as "Título", "rating" as "Clasificación", "length" as "Duración" 
from "film"
where "rating" = 'PG-13' or "length" > 180
order by "Clasificación" , "Duración" desc
; --hay un total de 253 películas que cumplen una u otra condición

--9. Encuentra la variabilidad de lo que costaría reemplazar las películas.
select round(variance("replacement_cost"), 2) as "Varianza coste de reposición", 
	   round(avg("replacement_cost"),2) as "Media coste de reposición"
from "film" f
;

--10. Encuentra la mayor y menor duración de una película de nuestra BBDD.
select max("length") as "Máxima Duración", min("length") as "Minima Duración"
from "film"
;-- La película(s) más larga dura 3h05m, mientras que la más corta solo dura 46 minutos

--11. Encuentra lo que costó el antepenúltimo alquiler ordenado por día.
select *
from "payment" 
order by "payment_date" desc, "rental_id" desc -- al haber muchos registros con la misma fecha y hora, ordenamos después por "rental_id"
offset 2 --eliminamos las dos primeras filas	
limit 1 --restringimos el resultado a una sola fila que nos devuelte el conto del antepenúltimo alquiler, 
; --2.99

--12. Encuentra el título de las películas en la tabla “film” que no sean ni ‘NC-17’ ni ‘G’ en cuanto a su clasificación.
Select "title" as "Título", "rating" as "Clasificación"
from "film"
where "rating" not in('NC-17', 'G')
order by "rating"
; -- Son 612 películas en total de las 1.000 existentes

/*13. Encuentra el promedio de duración de las películas para cada clasificación de la tabla film 
  y muestra la clasificación junto con el promedio de duración.*/
select "rating" as "Clasificación", Round(AVG("length"),1) as "Duración Media"
from "film"
group by "rating"
;

--14. Encuentra el título de todas las películas que tengan una duración mayor a 180 minutos.
select "title" as "Título", "length" as "Duración"
from "film"
where "length" > 180
order by "Duración" desc
;--Hay 39 películas con una duración mayor de 3 horas (no incluimos las que duran justo 3H)

--15. ¿Cuánto dinero ha generado en total la empresa?
select sum("amount") as "Total ingresos" 
from "payment" 
;--Sumamos el importe total de la columna "amount" de la tabla "payment"

--16. Muestra los 10 clientes con mayor valor de id.
select "customer_id", Concat("first_name", ' ',"last_name") as "Nombre Cliente"
from "customer"
order by "customer_id" desc -- ordenamos por ID 
limit 10 --limitamos el resultados a los 10 primeros registros
;

--17. Encuentra el nombre y apellido de los actores que aparecen en la película con título ‘Egg Igby’.
select Concat("first_name", ' ',"last_name") as "Nombre actor", "title" as "Título" --Construimos el nombre completo  y añadimos el título de la película buscada
from "actor" a --desde la tabla "actor"
join "film_actor" as fa --la relacionamos con la tabla "film_actor"
	on fa."actor_id" = a."actor_id" --a través del campo "actor_id"
join "film" as f -- y a su vez, son la tabla "film"
	on fa.film_id = f.film_id  --a traves del campo "film_id" para obtener el título quye buscamos
where f."title"  in ('EGG IGBY', 'Egg Igby') --filtramos por el nombre de la película propuesta. 
;--Importante de nuevo diferenciar May y Mín, ya que el título tal cual está en el anunciado, no devuelve resultados

--18. Selecciona todos los nombres de las películas únicos.
select distinct("title") as "Título"--utilizamos "distinct" aunque sin él también funciona
from "film"
order by "title" asc --ordenamos por titulo para verificar visualmente que no se repiten
;

--19. Encuentra el título de las películas que son comedias y tienen una duración mayor a 180 minutos en la tabla “film”.
select "title" as "Título", c."name" as "Categoría", "length" as "Duración"
from "film" f
join "film_category" fc --vinculamos las tablas Film y "film_category" 
	on f."film_id" = fc."film_id" --a través de la llave "film_id" 
join "category" c --vinculamos las tablas "category" y "film_category" 
	on fc."category_id" = c."category_id" --a través de la llave "category_id" 
where c."name" = 'Comedy' and "length" > 180 --Filtramos los títulos que cumplen las dos condiciones propuestas, 
; --solo son 3 películas

--20. Encuentra las categorías de películas que tienen un promedio de duración superior a 110 minutos y muestra el nombre de la categoría junto con el promedio de duración.
select c."name" as "Categoría", round(avg("length"),1) as "Duración Media" --Seleccionamos las columnas que nos darán la categoría y la duración media 
from film f --de la tabla "film"
join "film_category" fc --vinculamos las tablas "film" y "film_category" 
	on f."film_id" = fc."film_id" --a través de la llave "film_id" 
join "category" c --vinculamos las tablas "category" y "film_category" 
	on fc."category_id" = c."category_id" --a través de la llave "category_id" 
group by "name"
having round(avg("length")) > 110 --Establecemos el filtro de duración en 110 minutos de duración media
order by "Duración Media" desc;
;--Solo hay dos categorías cuya duración media es menor a la fijada de 110

--21. ¿Cuál es la media de duración del alquiler de las películas?
select AVG("return_date" - "rental_date") as "Duración Media Alquiler" --Restamos las fechas de devolución de las fechas de entrega y calculamos el promedio
from "rental"
where return_date is not null
;

--22. Crea una columna con el nombre y apellidos de todos los actores y actrices.
select "actor_id" as "ID", concat("first_name",' ',"last_name") as "Nombre Completo"
from actor a 
order by "Nombre Completo"
;

--23. Números de alquiler por día, ordenados por cantidad de alquiler de forma descendente.
select "rental_date"::date as "Fecha", count("rental_id") as "Número de alquileres" --Necesitamos extraer solo la fecha, sin hora
from "rental"
group by "rental_date"::date
order by "Número de alquileres" desc
;

--24. Encuentra las películas con una duración superior al promedio.
select "title" as "Título", "length" as "Duración"
from "film"
where "length" > ( -- utilizamos una subconsulta en el where para calcular el promedio general
	select AVG("length") --(115m)
	from "film")
order by "Duración"
;

--25. Averigua el número de alquileres registrados por mes.
select to_char(date_trunc('month', "rental_date"), 'YYYY-MM') as "Año-Mes", count("rental_id") as "Total Alquileres"
from "rental"
group by  date_trunc('month', "rental_date")
order by date_trunc('month', "rental_date")
; -- En este caso he necesitado buscar información fuera del curso para obtener el "Año-"Mes"

--26. Encuentra el promedio, la desviación estándar y varianza del total pagado.
select round(avg("amount"),2) as "Promedio", 
	   round(stddev("amount"),2) as "Desviación Estándar", 
	   round(variance("amount"),2) as "Varianza"
from "payment"
;

--27. ¿Qué películas se alquilan por encima del precio medio?
select "title" as "Título", round(avg("amount"),2) as "Precio medio"
from "payment" p 
join "rental" r -- unimos "rental" para poder llegar al título de las películas
	on r."rental_id" = p."rental_id"
join "inventory" i -- a través de la tabla "inventory"
	on i."inventory_id" = r."inventory_id" 
join "film" f
	on i."film_id" = f."film_id"
group by f."title"  -- promediamos los precios por título
having avg("amount") > (select avg("amount") from "payment") -- filtramos aquelos que están por encima de la media (4,20)
order by "Precio medio" desc -- y ordenamos por importe
;

--28. Muestra el id de los actores que hayan participado en más de 40 películas.
select a."actor_id", 
		concat(a."first_name",' ', a."last_name") as "Nombre del actor", --utilizamos los nombres de los actores y sus IDs
		count(distinct("film_id")) as "Número de películas" --contamos el nº de peliculas en las que ha participado cada uno
from film_actor fa
join actor a on fa."actor_id" = a."actor_id"
group by a."actor_id"
having count(distinct("film_id")) > 40 --filtramos los que acumulan más de 40 
; -- Solo hay dos que hayan participado en tantas películas

--29. Obtener todas las películas y, si están disponibles en el inventario, mostrar la cantidad disponible.
/*select f.film_id, "title" as "Película", count(i.inventory_id ) as "unidades disponibles"
from inventory i 
inner join film f on i.film_id = f.film_id 
group by f.film_id 
order by "unidades disponibles"  asc*/

select f.film_id, "title" as "Película", count(i.inventory_id) as "unidades disponibles"
from film f
left join inventory i on f.film_id = i.film_id
group by f.film_id
order by "unidades disponibles" asc


; --hay 958 películas disponibles, es decir, hay 42 que tenemos en la BBDD de películas pero sin disponibilidad en inventario

--30. Obtener los actores y el número de películas en las que ha actuado.
select a."actor_id", 
		concat(a."first_name",' ', a."last_name") as "Nombre del actor", 
		count(distinct("film_id")) as "Número de películas"
from film_actor fa
join actor a on fa."actor_id" = a."actor_id"
group by a."actor_id" --igual que el ejercicio 28 pero sin filtrar por >40 ¿?

--31. Obtener todas las películas y mostrar los actores que han actuado en ellas, incluso si algunas películas no tienen actores asociados.
select f."title" as "Título", count(fa.actor_id ) as "número de actores"
from film f
left join film_actor fa --en este caso usamos "LEFT JOIN" para que nos devuelva las películas aunque no tengan actores asociados
	on f.film_id = fa.film_id 
group by f.title 
order by "número de actores" asc -- Hay 3 peliculas sin actores asignados

--32. Obtener todos los actores y mostrar las películas en las que han actuado, incluso si algunos actores no han actuado en ninguna película.
select concat(first_name , ' ', last_name ) as "Actor", "title" as "Película"
from "actor" a
left join film_actor fa on a.actor_id = fa.actor_id
left join film f on fa.film_id = f.film_id
order by "Película" asc
; --Todos los actores han participado en alguna película

--33. Obtener todas las películas que tenemos y todos los registros de alquiler.
select "title" as "Título", "rental_id"
from film
left join inventory i 
	on film.film_id = i.film_id
left join rental r 
	on i.inventory_id = r.inventory_id --en este join no usamos "left" para omitir las copias de algunas películas que nunca se han alquilado
order by "Título" ,r.rental_id 
; --en total ha habido 16.044 alquileres

--34. Encuentra los 5 clientes que más dinero se hayan gastado con nosotros.
select c."customer_id", concat(c."first_name" ,' ', c."last_name") "Cliente", sum("amount") as "Gasto"
from customer c
join "payment" p 
	on c.customer_id = p.customer_id 
group by c.customer_id 
order by "Gasto" desc
limit 5
;

--35. Selecciona todos los actores cuyo primer nombre es 'Johnny'.
select concat("first_name",' ', "last_name") as "JOHNNYs"
from actor a 
where a.first_name = 'JOHNNY' 
;

--36. Renombra la columna “first_name” como Nombre y “last_name” como Apellido.
select "first_name" as "Nombre", "last_name" as "Apellido"
from actor a 
;

--37. Encuentra el ID del actor más bajo y más alto en la tabla actor.
select min(a.actor_id ) as "Primer ID", max(a.actor_id ) as "Último ID" 
from actor a 
; -- Los IDs van del 1 al 200

--38. Cuenta cuántos actores hay en la tabla “actor”.
select count(distinct("actor_id")) "Número de actores"
from actor a 
; --Hay 200 actores

--39. Selecciona todos los actores y ordénalos por apellido en orden ascendente.
select "first_name" as "Nombre", "last_name" as "Apellido"
from actor a
order by "Apellido" asc
;

--40. Selecciona las primeras 5 películas de la tabla “film”.
select "film_id", "title" as "Título"
from "film"
order by "film_id" asc
limit 5
; --Entendiendo que por "primeras" se refiere a los 5 IDs más bajos ¿?

--41. Agrupa los actores por su nombre y cuenta cuántos actores tienen el mismo nombre. ¿Cuál es el nombre más repetido?
select "first_name" as "Nombre", count(actor_id) as "Número de actores"
from actor
group by actor.first_name 
order by "Número de actores" desc
;--Los nombres más repetidos son Kenneth, Penelope y Julia, 4 veces cada uno

--42. Encuentra todos los alquileres y los nombres de los clientes que los realizaron.
select r.rental_id , "first_name" as "Nombre", "last_name" as "Apellido"
from rental r 
join customer c
	on r.customer_id = c.customer_id 
; --listado con los 16.044 alquileres y su correspondiente cliente

--43. Muestra todos los clientes y sus alquileres si existen, incluyendo aquellos que no tienen alquileres.
select Concat("first_name",' ', "last_name") as "Cliente", count("rental_id") as "Número de alquileres"
from "customer" c 
left join "rental" r
	on c.customer_id = r.customer_id
group by c.customer_id 
order by "Número de alquileres" 
; -- Hay 599 clientes y todos hecho han alquilado alguna película

--44. Realiza un CROSS JOIN entre las tablas film y category. ¿Aporta valor esta consulta? ¿Por qué? Deja después de la consulta la contestación.
select *
from film f 
cross join category c 
; /* En este caso no aporta valor, de hecho confunde, ya que, en principio, cada película pertenece a una sola "Categoría"
y esta consulta nos devuelve un listado de 16.000 registros (1.000 películas * 16 categorías) que no obedece a ningún criterio*/

--45. Encuentra los actores que han participado en películas de la categoría 'Action'.
select concat(first_name , ' ', last_name ) as "Nombre", "name" as "Categoría"
from actor a
join film_actor fa
	on a.actor_id = fa.actor_id
--join film f
	--on fa.film_id = f."film_id" VEMOS QUE NO HACE FALTA PASAR POR LA TABLA FILM
join film_category fc 
	on fa.film_id = fc.film_id
join category c
	on fc.category_id = c.category_id	
where c."name" = 'Action'
; -- Hay 363 actores que han participado en alguna película de acción

--46. Encuentra todos los actores que no han participado en películas.
select a.actor_id, count(fa.film_id) as "Número Películas"
from actor a 
left join film_actor fa 
	on a.actor_id = fa.actor_id 
group by a.actor_id 
having count(fa.film_id) = 0
order by "Número Películas" asc
; -- No hay ningún actor que no haya participado en ninguna película


--47. Selecciona el nombre de los actores y la cantidad de películas en las que han participado.
select first_name as "Nombre", "last_name" as "Apellido", count(fa.film_id) "Nº de películas"
from actor a 
join film_actor fa 
	on a.actor_id = fa.actor_id
group by a.actor_id 
;

--48. Crea una vista llamada “actor_num_peliculas” que muestre los nombres de los actores y el número de películas en las que han participado.
create view actor_num_peliculas as (
select "first_name" as "Nombre", 
	   "last_name" as "Apellido", 
	   count(fa.film_id) "Nº de películas"
from actor a 
left join film_actor fa 
	on a.actor_id = fa.actor_id
group by a.actor_id )
; -- Ejecutamos y verificamos que en el Diagrama aparaece una nueva tabla con el nombre que le hemos dado y los 3 campos que hemos definido

--49. Calcula el número total de alquileres realizados por cada cliente.
select c.customer_id, concat(c.first_name ,' ',c.last_name ) as "Cliente", count(r.rental_id ) "Número de alquileres"
from customer c 
join rental r
	on c.customer_id = r.customer_id 
group by c.customer_id 
order by c.customer_id 
;

--50. Calcula la duración total de las películas en la categoría 'Action'.
select "name" as "Categoría", sum(length) as "Duración total"
from category c
join film_category fc on c.category_id = fc.category_id
join film f on f.film_id = fc.film_id
where "name" = 'Action'
group by "name" 
; --en total hay 7.143 minutos de películas de acción

--51. Crea una tabla temporal llamada “cliente_rentas_temporal” para almacenar el total de alquileres por cliente.
with cliente_rentas_temporal as(
	select r.customer_id as "Cliente", count(rental_id) as "Número Alquileres" 
	from customer c 
	join rental r 
		on c.customer_id = r.customer_id
	group by r.customer_id 
)
select "Cliente", "Número Alquileres"
from cliente_rentas_temporal 
;
 
--52. Crea una tabla temporal llamada “peliculas_alquiladas” que almacene las películas que han sido alquiladas al menos 10 veces.
with peliculas_alquiladas as( --Creamos la CTE
	select title as "Película", count(r.rental_id ) as "Número de Alquileres" 
	from film f 
	join inventory i 
		on f.film_id = i.film_id 
	join rental r
		on i.inventory_id = r.inventory_id 
	group by f."film_id"
	having count(r.rental_id ) > 10	
)
select "Película", "Número de Alquileres" --Ahora seleccionamos los campos
from peliculas_alquiladas --de la CTE anterior
; -- Hay un total de 754 títulos que se han alquilado en más de 10 ocasiones

/*53. Encuentra el título de las películas que han sido alquiladas por el cliente con el nombre ‘Tammy Sanders’ 
      y que aún no se han devuelto. Ordena los resultados alfabéticamente por título de película.*/
select concat(first_name , ' ', last_name ) "Cliente", f.title as "Película", r.return_date as "Fecha devolución"
from customer c
join rental r -- unimos la tabla rental que contiene las fechas de devolución
	on c.customer_id = r.customer_id 
join inventory i -- unimos la "inventory" para llegar a la tabla "film"
	on r.inventory_id = i.inventory_id 
join film f -- unimos la tabla "film" que nos da el nombre de las películas
	on i.film_id = f.film_id
where return_date is NULL  and concat(first_name , ' ', last_name ) = 'TAMMY SANDERS' -- definimos las condiciones
order by "Película" 
; --Tammy ha alquilado 41 películas pero tiene 3 pendientes de devolución

/*54. Encuentra los nombres de los actores que han actuado en al menos una
      película que pertenece a la categoría ‘Sci-Fi’. Ordena los resultados alfabéticamente por apellido.*/
select distinct(a.actor_id), a.first_name as "Nombre", a.last_name as "Apellido" 
from actor a
join film_actor fa 
	on a.actor_id = fa.actor_id 
join film_category fc  
	on fa.film_id =fc.film_id 
join category c 
	on fc.category_id = c.category_id
where c."name" = 'Sci-Fi'
order by "Apellido"
; -- 167 actores han participado en películas de la categoría "Sci-Fi"

/*55. Encuentra el nombre y apellido de los actores que han actuado en películas que se alquilaron después de que la película ‘Spartacus
Cheaper’ se alquilara por primera vez. Ordena los resultados alfabéticamente por apellido.*/
with listado_peliculas as( --Creamos una tabla que nos da el listado de peliculas alquiladas después de 'Spartacus Cheaper'
	select r.rental_id, inventory_id
	from rental r 
	where rental_date > ( --En esta subconsulta filtramos por la 1ª fecha de alquiler de este título
		select min(rental_date)
		from rental r 
		join inventory i 
			on r.inventory_id = i.inventory_id 
		join film f 
			on i.film_id = f.film_id 
		where "title" = 'SPARTACUS CHEAPER')
)
select a.first_name, a.last_name
from listado_peliculas -- obtenemos ahora el nombre y apellido de los actores uniendo la CTE
join inventory i -- a la tabla "inventory"
	on listado_peliculas.inventory_id = i.inventory_id
join film f --después a la tabla "film"
	on i.film_id = f.film_id 
join film_actor fa --para llegar a la tabla "actores"
	on f.film_id = fa.film_id 
join actor a 
	on fa.actor_id = a.actor_id 
group by a.actor_id --agrupamos por actores para que no sé dupliquen los nombres
order by a.last_name -- y ordenamos por apellidos
; --


--56. Encuentra el nombre y apellido de los actores que no han actuado en ninguna película de la categoría ‘Music’.
with actores_musicales as( --creamos una CTE con los IDs de los actores que SI han participado en musicales
	select distinct actor_id
	from film_actor fa 
	join film_category fc 
		on fa.film_id = fc.film_id 
	join category c 
		on fc.category_id = c.category_id
	where "name" = 'Music' 
)-- nos devuelve 144 de los 200 totales
select a.first_name as "Nombre", a.last_name as "Apellido" -- buscamos el nombre y apellido
from actor a -- de los actores
where not exists ( -- que NO aparecen en la CTE anterior
	select a.actor_id 
	from actores_musicales 
	where a.actor_id = actores_musicales.actor_id)
; -- nos da los 56 nombres restantes

--57. Encuentra el título de todas las películas que fueron alquiladas por más de 8 días.
select distinct f.film_id, "title" as "Título"
from film f 
join inventory i
	on f.film_ID = i.film_id 
join rental r
	on i.inventory_id = r.inventory_id 
where r.return_date is not null and (r.return_date - r.rental_date) > interval '8 days'
;--Hay 876 películas que en alguna ocasión se han alquilado por más de 8 días. He tenido que buscar por fuera ese "interval" porque en el curso no lo he visto ¿? 

--58. Encuentra el título de todas las películas que son de la misma categoría que ‘Animation’.
select "title" as "Título", c."name" as "Categoría"
from film f 
join film_category fc 
	on f.film_id = fc.film_id 
join category c 
	on fc.category_id = c.category_id 
where c."name" = 'Animation'
; --Hay 66 títulos en esta categoría

/*59. Encuentra los nombres de las películas que tienen la misma duración que la película con 
el título ‘Dancing Fever’. Ordena los resultados alfabéticamente por título de película. */
select f."title" as "Título", f."length" "Duración" -- seleccionamos título y duración
from film f -- de las películas
where f.length = ( -- cuya duración
			select f.length -- es igual a la de la película 'Dancing Fever' 
			from film f 
			where f.title = 'DANCING FEVER')
order by "Título" 
; -- Nos devuelve 7 películas, además de la propiamente buscada

--60. Encuentra los nombres de los clientes que han alquilado al menos 7 películas distintas. Ordena los resultados alfabéticamente por apellido.
with numero_alquileres as( -- Creamos una CTE que nos liste los clientes con el número de alquileres de películas distintas
						select customer_id, count(distinct(i.film_id)) as "Cantidad Alquileres"
						from rental r
						join inventory i -- para ello conectamos las tablas "rental" e "inventory"
							on r.inventory_id = i.inventory_id 
						group by customer_id ) -- y agrupamos por cliente
select first_name as "Nombre", last_name as "Apellido", "Cantidad Alquileres"
from customer c 
join numero_alquileres on c.customer_id = numero_alquileres.customer_id
where "Cantidad Alquileres" >= 7
order by "Apellido"  
; -- Nos devuelve 599 resultados, es decir, todos los clientes han alquilado más de 7 películas distintas

--61. Encuentra la cantidad total de películas alquiladas por categoría y muestra el nombre de la categoría junto con el recuento de alquileres.
with categorias_con_id as ( -- CTE en el que renombramos la columna "name" por "Categoría" y le añadimos el ID
		select c.name as "Categoría", fc.film_id 
		from category c
		join film_category fc on c.category_id = fc.category_id 
		)
select "Categoría", count("rental_id") as "Número alquileres"
from categorias_con_id 
join inventory i  
 	on categorias_con_id.film_id = i.film_id 
join rental r
	on i.inventory_id = r.inventory_id
group by "Categoría" 
order by "Número alquileres" desc
; -- Solo uso la CTE por aplicar conocimientos, pero se podría sustituir simplemente por un JOIN 

--62. Encuentra el número de películas por categoría estrenadas en 2006.
select c."name" as "Categoría", count(f.film_id) as "número de Películas" 
from film f 
join film_category fc on f.film_id = fc.film_id
join category c on fc.category_id = c.category_id
where release_year = 2006
group by "name" 
; -- Todas las películas se lanzaron en 2006 ¿?

--63. Obtén todas las combinaciones posibles de trabajadores con las tiendas que tenemos.
select *
from staff s 
cross join store s2 
; -- hay dos tiendas y cada una con un empleado, así que el resultado es 4 combinaciones (2x2)

/*64. Encuentra la cantidad total de películas alquiladas por cada cliente y 
muestra el ID del cliente, su nombre y apellido junto con la cantidad de películas alquiladas.*/
select c.customer_id, c.first_name as "Nombre", c.last_name as "Apellido", count(rental_id) as "número de alquileres"
from customer c 
join rental r on c.customer_id = r.customer_id 
group by c.customer_id 
;

--Resumen Datos Principales
with resumen_datos as(
select
(select count(store_id) from "store") as nt, -- número de tiendas
(select count (distinct(customer_id)) from customer) as nc, --número de clientes
(select	sum("amount") from payment) as ft, -- facturación total
(select count(inventory_id)from inventory) as nco, --número de copias
(select count(distinct(film_id)) from film) as np, -- número de películas
(select count(rental_id) from rental) as nr, -- "Número Alquileres"
(select count(distinct(actor_id)) from actor) as na, -- número actores
(select round(avg(amount),2) from payment) as pma, -- precio medio del alquiler
(select avg(return_date - rental_date) from rental) as dm -- duración media de los alquileres
)
select 
	nt as "Número de tiendas",
	nc as "Número de Clientes", 
	ft as "Facturación Total",
	nco as "Número de copias",
	na as "Número de actores", 
	np as "Número de películas",
	nr as "Número de Alquileres",
	pma as "Precio Medio Alquiler",
	round(ft/nc,2) as "Gasto medio por cliente",
	round(nr/nc,2) as "Promedio Alquileres por cliente",
	dm as "Duración Media Alquiler"
	from resumen_datos



