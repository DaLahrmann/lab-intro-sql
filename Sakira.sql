-- Question 1
use sakila;

-- Question 2
select * 
from actor;
select * 
from film;
select * 
from customer;

-- Question 3
select title 
from film;

-- Question 4
select name 
as language 
from language;

-- Question 5
select count(*) 
from store;

select count(*) 
from staff;

select first_name 
from staff;

-- LAB 2

-- Question 1

select *
from sakila.actor
where first_name = 'Scarlett';

-- Question 2
select count(*) 
from sakila.inventory;

select count(*) 
from sakila.rental;

-- Question 3
select max(length) as 'max_duration',
       min(length) as 'min_duration'
from sakila.film;

-- Question 4
select concat(floor(avg(length)/60),'h', round(avg(length)%60),'m') as avg_length
from sakila.film;

-- Question 5
select count(distinct last_name)
from sakila.actor;

-- Question 6
select datediff(CURRENT_TIMESTAMP,min(rental_date)) 
from sakila.rental;

-- Question 7
select rental_date, 
       month(rental_date) as 'month', 
       weekday(rental_date) as 'weekday'
from sakila.rental
limit 20;

-- Question 8 
select rental_date, 
       month(rental_date) as 'month', 
       weekday(rental_date) as 'weekday',
       case
       when weekday(rental_date)>4 then 'weekend' 
       else 'workday'
       end as 'day_type'	
from sakila.rental
limit 20;

-- Question 9
select release_year
from sakila.film;

-- Question 10 
select *
from sakila.film
where title like '%ARMAGEDDON%';

-- Question 11
select *
from sakila.film
where title like '%APOLLO';

-- Question 12
select *
from sakila.film
order by length desc
limit 10;

-- Question 13
select count(*)
from sakila.film
where special_features like '%Behind the Scenes%';

-- LAB 3

-- Question 1
select *
from sakila.actor
group by last_name
having count(*)=1;

-- Question 2
select count(*),last_name
from sakila.actor
group by last_name
having count(*)>1;

-- Question 3
select staff_id, count(*)
from sakila.rental
group by staff_id;

-- Question 4
select release_year, count(*)
from sakila.film
group by release_year
order by release_year asc;

-- Question 5
select rating, count(*)
from sakila.film
group by rating
order by rating asc;

-- Question 6
select rating, round(avg(length),2) as avg_length
from sakila.film
group by rating
order by rating asc;

-- Question 7
select rating, round(avg(length),2) as avg_length
from sakila.film
group by rating
having avg_length > 120
order by rating asc;

-- Question 8
select title, length,
       rank() over (
              order by length desc) as 'rank'
from sakila.film
where not (length is null) and
      (length > 0)
order by length desc;
      
