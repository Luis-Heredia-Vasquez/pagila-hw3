/*
 * You love the acting in the movie 'AMERICAN CIRCUS' and want to watch other movies with the same actors.
 *
 * Write a SQL query that lists the title of all movies that share at least 1 actor with 'AMERICAN CIRCUS'.
 *
 * HINT:
 * This can be solved with a self join on the film_actor table.
 */

SELECT f.title
FROM film f
JOIN film_actor fa ON fa.film_id = f.film_id
JOIN film_actor fa2 ON fa2.actor_id = fa.actor_id
JOIN film f2 ON f2.film_id = fa2.film_id
WHERE f2.title = 'AMERICAN CIRCUS'
ORDER BY f.title;
