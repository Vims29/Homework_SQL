
USE sakila;

-- 1a.
SELECT first_name, last_name FROM actor;

-- 1b.
SELECT CONCAT (UPPER(first_name)," ", UPPER(last_name)) AS `Actor Name` FROM actor;

-- 2a.
SELECT actor_id, first_name, last_name FROM actor
WHERE first_name = 'Joe';

-- 2b.
SELECT actor_id, first_name, last_name FROM actor
WHERE last_name LIKE '%GEN%';

-- 2c.
SELECT actor_id, last_name, first_name FROM actor
WHERE last_name LIKE '%LI%'
ORDER BY last_name ASC, first_name ASC;

-- 2d. 
SELECT country_id, country
FROM country          
WHERE country IN ('Afghanistan', 'Bangladesh', 'China');

-- 3a.
ALTER TABLE actor
add description blob;

-- 3b.
ALTER TABLE actor
 drop description; 

-- 4a. 
SELECT last_name, COUNT(*) AS 'Number of Actors'
FROM actor GROUP BY last_name; 

-- 4b. 
SELECT last_name, COUNT(*) AS 'Number of Actors'
FROM actor GROUP BY last_name HAVING count(*) >=2;

-- 4c.
UPDATE actor
SET first_name = 'HARPO'
WHERE first_name = 'GROUCHO' AND last_name ='WILLIAMS';

-- 4d. 
UPDATE actor
 SET first_name = 'GROUCHO'
 WHERE first_name = 'HARPO' AND last_name = 'WILLIAMS';

-- 5a. 
SHOW CREATE TABLE address;

-- 6a. 
SELECT first_name, last_name, address
FROM staff s
JOIN address a
ON s.address_id = a.address_id;

-- 6b.
SELECT s.first_name, s.last_name, sum(p.amount) as "Total_Amount_Rung_Up"
FROM payment p
JOIN staff s
ON p.staff_id = s.staff_id 
WHERE payment_date LIKE '2005-08%'
GROUP BY first_name, last_name;

-- 6c. 
SELECT title, COUNT(actor_ID) AS actor_count
FROM film f
INNER JOIN film_actor a ON a.film_id = f.film_id
GROUP BY title;

-- 6d.
SELECT f.film_id, f.title, count(f.film_id) as"Number_of_Copy"
FROM film f
JOIN inventory i
ON f.film_id = i.film_id
WHERE f.title = "HUNCHBACK IMPOSSIBLE"
GROUP BY f.film_id;

-- 6e.
SELECT c.first_name, c.last_name, sum(p.amount) as "Total Amount Paid"
FROM payment p
JOIN customer c
ON p.customer_id = c.customer_id
Group BY c.customer_id
ORDER BY c.last_name ASC;

-- 7a. 
-- SELECT * FROM language;
SELECT title FROM film
WHERE (title LIKE "Q%" OR title LIKE "K%")
AND language_id IN 
( 
  SELECT language_id
	FROM language
	WHERE name IN ('ENGLISH')
    );
    
-- 7b. 
SELECT first_name, last_name
FROM actor
WHERE actor_id IN 
(
	SELECT actor_id
    FROM film_actor
    WHERE film_id IN
    (
    SELECT film_id
    FROM film
    WHERE title = "Alone Trip"
    )
);

-- 7c. 
SELECT c.first_name, c.last_name, c.email -- , country
FROM customer c 
INNER JOIN address a 
ON c.address_id = a.address_id
INNER JOIN city ct
ON a.city_id = ct.city_id
INNER JOIN country cy
ON ct.country_id = cy.country_id
WHERE country = "CANADA";

-- 7d. 
SELECT f.title as "Film Title", c.name as "Movie Type"
FROM film f 
JOIN film_category fc 
ON f.film_id = fc.film_id
JOIN category c 
ON fc.category_id = c.category_id
WHERE c.name = "Family";

-- 7e. 
SELECT f.title, COUNT(f.title) AS Rent_Count
FROM rental AS r
INNER JOIN inventory AS i
    ON r.inventory_id = i.inventory_id
INNER JOIN film AS f
    ON i.film_id = f.film_id
GROUP BY f.title
ORDER BY Rent_Count DESC;


-- 7f. 
SELECT  s.store_id,SUM(amount) AS Business_in_dollars
FROM store s
INNER JOIN staff st 
ON s.store_id = st.store_id
INNER JOIN payment p
ON p.staff_id = st.staff_id 
GROUP BY s.store_id
ORDER BY Business_in_dollars ASC;


-- 7g.
SELECT store_id, city, country
FROM store s
JOIN address a
ON (s.address_id=a.address_id)
JOIN city c 
ON (a.city_id=c.city_id)
JOIN country ct
ON (c.country_id=ct.country_id);

-- 7h.
SELECT c.name as "Movie Genres", sum(p.amount) as "Gross Revenue"
FROM category c 
JOIN film_category fc 
ON c.category_id = fc.category_id
JOIN inventory i 
ON fc.film_id = i.film_id 
JOIN rental r 
On i.inventory_id = r.inventory_id
JOIN payment p 
ON r.rental_id = p.rental_id
GROUP BY c.category_id
ORDER BY sum(p.amount) DESC
LIMIT 5;

-- 8a.
CREATE VIEW top_five_genres
AS SELECT c.name AS "Movie Genres", sum(p.amount) as "Gross Revenue"
FROM category c
JOIN film_category fc
ON c.category_id = fc.category_id
JOIN inventory i
ON fc.film_id = i.film_id
JOIN rental r
ON i.inventory_id = r.inventory_id
JOIN payment p
ON r.rental_id = p.rental_id
GROUP BY c.category_id
ORDER BY sum(p.amount) DESC
LIMIT 5;

--  8b. 
SELECT * FROM `top_five_genres`;

--  8c.
DROP VIEW top_five_genres;






