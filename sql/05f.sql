/* 
 * Finding movies with similar categories still gives you too many options.
 *
 * Write a SQL query that lists all movies that share 2 categories with AMERICAN CIRCUS and 1 actor.
 *
 * HINT:
 * It's possible to complete this problem both with and without set operations,
 * but I find the version using set operations much more intuitive.
 */

SELECT f.title
FROM film f
JOIN film_category fc ON fc.film_id = f.film_id
JOIN film_category fc2 ON fc2.category_id = fc.category_id
JOIN film f2 ON f2.film_id = fc2.film_id
WHERE f2.title = 'AMERICAN CIRCUS'
GROUP BY f.title
HAVING count(*) >= 2
INTERSECT
SELECT f.title
FROM film f
JOIN film_actor fa ON fa.film_id = f.film_id
JOIN film_actor fa2 ON fa2.actor_id = fa.actor_id
JOIN film f2 ON f2.film_id = fa2.film_id
WHERE f2.title = 'AMERICAN CIRCUS'
ORDER BY 1;
