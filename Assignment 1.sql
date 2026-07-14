# SQL Practice Questions
---------------------------------
Select * from sakila.customer;
Select * from sakila.film;
Select * from sakila.rental;

# Get all customers whose first name starts with 'J' and who are active.

Select first_name, active from sakila.customer where first_name like 'J%' and active = 1; 


# Find all films where the title contains the word 'ACTION' or the description contains 'WAR'.

select title from sakila.film where title like '%ACTION%' or description like '%WAR%';


# List all customers whose last name is not 'SMITH' and whose first name ends with 'a'.
Select customer_id, first_name, last_name from sakila.customer where last_name !='SMITH' and first_name like '%a';

# Get all films where the rental rate is greater than 3.0 and the replacement cost is not null.
Select film_id, title from sakila.film where rental_rate > 3 and replacement_cost > 0;


# Count how many customers exist in each store who have active status = 1.

Select COUNT(customer_id), store_id
from sakila.customer 
where active = 1
group by store_id;


# Show distinct film ratings available in the film table.

select distinct(rating) from sakila.film; 



# Find the number of films for each rental duration where the average length is more than 100 minutes.
select rental_duration, count(*) as number_films
from sakila.film
group by rental_duration
having AVG(length)>100; 


# List payment dates and total amount paid per date, but only include days where more than 100 payments were made.
Select * from sakila.payment;
Select 
    Date(payment_date) As payment_day,
    Count(*) As number_of_payments,
    Sum(amount) AS total_amount
From sakila.payment
Group By Date(payment_date)
Having Count(*) > 100;

# Find customers whose email address is null or ends with '.org'.

select customer_id , first_name, last_name from sakila.customer where email = NULL or email like '%.org';

# List all films with rating 'PG' or 'G', and order them by rental rate in descending order.

Select title,rating,rental_rate from sakila.film 
where rating = 'PG' or rating = 'G' 
order by rental_rate desc;

# Count how many films exist for each length where the film title starts with 'T' and the count is more than 5.
Select 
    length,
    Count(*) As number_of_films
From sakila.film
Where title like 'T%'
Group By length
Having Count(*) > 5;

# List all actors who have appeared in more than 10 films.

select * from sakila.film_actor;
select actor_id, Count(film_id) as number_films 
from sakila.film_actor
group by actor_id
Having Count(film_id) >10;


# Find the top 5 films with the highest rental rates and longest lengths combined, ordering by rental rate first and length second.
Select title, rental_rate, length
from sakila.film
order by rental_rate desc, length desc
Limit 5;

# Show all customers along with the total number of rentals they have made, ordered from most to least rentals.
Select 
    c.customer_id,
    c.first_name,
    c.last_name,
    Count(r.rental_id) As total_rentals
From sakila.customer c
Join sakila.rental r On c.customer_id = r.customer_id
Group By c.customer_id, c.first_name, c.last_name
Order By total_rentals desc;


# List the film titles that have never been rented.
select * from sakila.inventory;
Select title
From sakila.film
Where film_id Not In (
    Select film_id
    From sakila.inventory
    Where inventory_id In (
        Select inventory_id From sakila.rental
    )
);
