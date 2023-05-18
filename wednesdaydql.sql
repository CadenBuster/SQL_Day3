-- 1. List all customers who live in Texas (use JOINs)
SELECT customer.first_name, customer.last_name, address.district
FROM customer
INNER JOIN address
ON customer.address_id = address.address_id
WHERE address.district = 'Texas';

-- 2. Get all payments above $6.99 with the Customer's Full Name
SELECT payment.amount, customer.first_name, customer.last_name
FROM payment
INNER JOIN customer
ON payment.customer_id = customer.customer_id
WHERE payment.amount > 6.99;

-- 3. Show all customers names who have made payments over $175(use subqueries)
SELECT first_name, last_name, customer_id
FROM customer
WHERE customer_id IN (
    SELECT customer_id
    FROM payment
    GROUP BY customer_id
    HAVING SUM(amount) > 175
);

-- 4. List all customers that live in Nepal (use the city table)
SELECT customer.first_name, customer.last_name, country
FROM customer
INNER JOIN address
ON customer.address_id = address.address_id
INNER JOIN city
ON address.city_id = city.city_id
INNER JOIN country
ON city.country_id = country.country_id
WHERE country = 'Nepal';

-- 5. Which staff member had the most transactions?
SELECT staff.staff_id, count(amount), staff.first_name, staff.last_name
FROM payment
INNER JOIN staff
ON payment.staff_id = staff.staff_id
GROUP BY staff.staff_id
ORDER BY count(amount) DESC;
-- Answer: Jon Stephens

-- 6. How many movies of each rating are there?
SELECT rating, count(film_id)
FROM film
GROUP BY rating
ORDER BY count(film_id);
-- Answer: 178 G, 194 PG, 196 R, 209 NC-17, 223 PG-13

-- 7.Show all customers who have made a single payment above $6.99 (Use Subqueries)
SELECT customer.first_name, customer.last_name, customer.customer_id
FROM customer
WHERE customer_id IN (
    SELECT customer_id
    FROM payment
    GROUP BY customer_id
    HAVING count(amount > 6.99) = 1
);

-- 8. How many free rentals did our stores give away?
SELECT rental.inventory_id, amount
FROM rental
INNER JOIN payment
ON rental.rental_id = payment.rental_id
WHERE amount = 0;
-- Answer: Zero
