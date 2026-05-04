-- Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.
USE sakila;
SELECT 
title,
COUNT(title) as num_copias
FROM film f
JOIN inventory i
	ON f.film_id = i.film_id
WHERE title = 'Hunchback Impossible'
  AND EXISTS (
        SELECT 1
        FROM inventory i
        WHERE i.film_id = f.film_id
  );
  
-- List all films whose length is longer than the average length of all the films in the Sakila database.
SELECT title, length
FROM film
WHERE length > (SELECT AVG(length) FROM film);

-- Use a subquery to display all actors who appear in the film "Alone Trip".
SELECT
first_name,
last_name
FROM actor a
WHERE actor_id IN (
    SELECT actor_id
    FROM film_actor fa
    JOIN film as f
		ON fa.film_id = f.film_id
    WHERE title = 'ALONE TRIP'
);

-- Sales have been lagging among young families, and you want to target family movies for a promotion. 
-- Identify all movies categorized as family films.
SELECT 
f.title
FROM film f
WHERE f.film_id IN (
	SELECT film_id
	FROM film_category fc
	JOIN category c
		ON fc.category_id = c.category_id
		WHERE c.name = 'Family');

-- Retrieve the name and email of customers from Canada using both subqueries and joins. 
-- To use joins, you will need to identify the relevant tables and their primary and foreign keys.
SELECT 
cu.first_name,
cu.email 
FROM customer cu

JOIN address ad 
    ON cu.address_id = ad.address_id
	WHERE ad.city_id in (
		SELECT city_id 
		FROM city ci
    JOIN country co 
        ON ci.country_id = co.country_id
    WHERE co.country = 'Canada'
);

-- Determine which films were starred by the most prolific actor in the Sakila database.
--  A prolific actor is defined as the actor who has acted in the most number of films.
-- First, you will need to find the most prolific actor and then use that actor_id 
-- to find the different films that he or she starred in.
SELECT 
	a.first_name,
	f.title
FROM film f
JOIN film_actor fa 
	ON f.film_id = fa.film_id
JOIN actor a
	ON fa.actor_id = a.actor_id

WHERE fa.actor_id = (
	SELECT 	actor_id
	FROM film_actor
	GROUP BY actor_id
	ORDER BY COUNT(film_id) DESC
	LIMIT 1
);


-- Find the films rented by the most profitable customer in the Sakila database. 
-- You can use the customer and payment tables to find the most profitable customer, i.e.,
--  the customer who has made the largest sum of payments.




-- Retrieve the client_id and the total_amount_spent of those clients 
-- who spent more than the average of the total_amount spent by each client.
-- You can use subqueries to accomplish this.