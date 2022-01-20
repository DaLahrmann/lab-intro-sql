-- Question 1.1
use sakila;

-- Question 1.2
select * 
from actor;
select * 
from film;
select * 
from customer;

-- Question 1.3
select title 
from film;

-- Question 1.4
select name 
as language 
from language;

-- Question 1.5
select count(*) 
from store;

select count(*) 
from staff;

select first_name 
from staff;

-- LAB 2

-- Question 2.1

select *
from sakila.actor
where first_name = 'Scarlett';

-- Question 2.2
select count(*) 
from sakila.inventory;

select count(*) 
from sakila.rental;

-- Question 2.3
select max(length) as 'max_duration',
       min(length) as 'min_duration'
from sakila.film;

-- Question 2.4
select concat(floor(avg(length)/60),'h', round(avg(length)%60),'m') as avg_length
from sakila.film;

-- Question 2.5
select count(distinct last_name)
from sakila.actor;

-- Question 2.6
select datediff(CURRENT_TIMESTAMP,min(rental_date)) 
from sakila.rental;

-- Question 2.7
select rental_date, 
       month(rental_date) as 'month', 
       weekday(rental_date) as 'weekday'
from sakila.rental
limit 20;

-- Question 2.8 
select rental_date, 
       month(rental_date) as 'month', 
       weekday(rental_date) as 'weekday',
       case
       when weekday(rental_date)>4 then 'weekend' 
       else 'workday'
       end as 'day_type'	
from sakila.rental
limit 20;

-- Question 2.9
select release_year
from sakila.film;

-- Question 2.10 
select *
from sakila.film
where title like '%ARMAGEDDON%';

-- Question 2.11
select *
from sakila.film
where title like '%APOLLO';

-- Question 2.12
select *
from sakila.film
order by length desc
limit 10;

-- Question 2.13
select count(*)
from sakila.film
where special_features like '%Behind the Scenes%';

-- LAB 3

-- Question 3.1
select *
from sakila.actor
group by last_name
having count(*)=1;

-- Question 3.2
select count(*),last_name
from sakila.actor
group by last_name
having count(*)>1;

-- Question 3.3
select staff_id, count(*)
from sakila.rental
group by staff_id;

-- Question 3.4
select release_year, count(*)
from sakila.film
group by release_year
order by release_year asc;

-- Question 3.5
select rating, count(*)
from sakila.film
group by rating
order by rating asc;

-- Question 3.6
select rating, round(avg(length),2) as avg_length
from sakila.film
group by rating
order by rating asc;

-- Question 3.7
select rating, round(avg(length),2) as avg_length
from sakila.film
group by rating
having avg_length > 120
order by rating asc;

-- Question 3.8
select title, length,
       rank() over (
              order by length desc) as 'rank'
from sakila.film
where not (length is null) and
      (length > 0)
order by length desc;
      
-- LAB 4

-- Question 4.1
select c.name as 'name',
       count(f.film_id) as 'number_of_films' 
from sakila.category c
join sakila.film_category f
using(category_id)
group by c.name;

-- Question 4.2
select s.first_name,s.last_name, 
       count(*) as 'number_of_rung_up'
from sakila.rental r
join sakila.staff s
using(staff_id)
where (year(r.return_date) = 2005) and
	  (month(r.return_date) = 8);

-- Question 4.3
select a.first_name,a.last_name,count(f.film_id)
from sakila.film_actor f
join sakila.actor a
using(actor_id)
group by f.actor_id
order by count(f.film_id) desc
limit 1;

-- Question 4.4
select c.first_name, c.last_name, count(r.rental_id)
from sakila.rental r 
join sakila.customer c
using(customer_id)
group by r.customer_id
order by count(r.rental_id) desc
limit 1;

-- Question 4.5
select s.first_name, s.last_name,a.address
from sakila.staff s
join sakila.address a
using(address_id);

-- Question 4.6
select f.title as 'film_title',
       count(actor_id) as 'number_of_actors'
from sakila.film_actor a
join sakila.film f
using(film_id)
group by film_id;

-- Question 4.7
select c.last_name, c.first_name,
       sum(p.amount) as 'total_paid'
from sakila.payment p
join sakila.customer c
using(customer_id)
group by c.customer_id
order by last_name, first_name asc;

-- Question 4.8
-- see Question 4.1

-- LAB 5

-- Question 5.1
select s.store_id, ci.city, co.country
from sakila.store s
join sakila.address a
using (address_id)
join sakila.city ci
using (city_id)
join sakila.country co
using (country_id);

-- Question 5.2 
select i.store_id, 
       sum(f.replacement_cost) as 'total film replacement cost'
from sakila.inventory i
join sakila.film f
using (film_id)
group by i.store_id;

-- Question 5.3 (using mean duration)
select c.name , avg(f.length)
from sakila.film_category fc
join sakila.film f
using (film_id)
join sakila.category c
using (category_id)
group by c.category_id
order by avg(f.length) desc
limit 1;

-- Question 5.4
select f.title, count(rental_id)
from sakila.rental r
join sakila.inventory i
using (inventory_id)
right join sakila.film f -- <- also incluede unrented films
using (film_id)
group by f.film_id
order by count(rental_id) desc;

-- Question 5.5
select c.name,
       sum(p.amount) as 'gross revenue'
from sakila.payment p
join sakila.rental r
using (rental_id)
join sakila.inventory i
using (inventory_id)
join sakila.film_category f
using (film_id)
join sakila.category c 
using (category_id)
group by c.category_id
order by sum(p.amount) desc;

-- Question 5.6
-- first query counts the total amount copies in store 1
select count(*)
from sakila.inventory i
join sakila.film f
using (film_id)
where i.store_id = 1 
and f.title = 'Academy Dinosaur';

-- first query counts the amount of still rentaled copies in store 1
select count(*)
from sakila.inventory i
join sakila.film f
using (film_id)
join sakila.rental r
using (inventory_id)
where i.store_id = 1 
and f.title = 'Academy Dinosaur'
and r.return_date is null;
-- Store 1 has 4 copies  and they are all in the store

-- Question 5.7
select a1.actor_id, a1.first_name, a1.last_name, 
	   a2.actor_id, a2.first_name, a2.last_name
from sakila.film_actor f1
join sakila.actor a1
using (actor_id)
join sakila.film_actor f2
on f1.film_id = f2.film_id and 
   f1.actor_id < f2.actor_id -- <- to remain doubles
join sakila.actor a2
on  a2.actor_id = f2.actor_id
group by f1.actor_id,f2.actor_id;

-- Question 5.8
select c1.first_name, c1.last_name,
       c2.first_name, c2.last_name,
       count(i1.film_id)
from sakila.inventory i1
join sakila.rental r1
using(inventory_id)
join sakila.customer c1
using (customer_id)
join sakila.inventory i2
on i1.film_id = i2.film_id
join sakila.rental r2
on r2.inventory_id = i2.inventory_id
join sakila.customer c2
on c2.customer_id=r2.customer_id
where c1.customer_id<c2.customer_id
group by c1.customer_id,c2.customer_id
having count(i1.film_id)>3;

-- Question 5.9
select *
from  sakila.film_actor fa
join sakila.actor a
using (actor_id)
join sakila.film f
using (film_id);