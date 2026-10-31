/*
 * Management wants to create a "best sellers" list for each actor.
 *
 * Write a SQL query that:
 * For each actor, reports the three films that the actor starred in that have brought in the most revenue for the company.
 * (The revenue is the sum of all payments associated with that film.)
 *
 * HINT:
 * For correct output, you will have to rank the films for each actor.
 * My solution uses the `rank` window function.
 */

SELECT actor_id, first_name, last_name, film_id, title, rank, revenue
FROM (
    SELECT a.actor_id, a.first_name, a.last_name, f.film_id, f.title,
        rank() OVER (PARTITION BY a.actor_id ORDER BY sum(p.amount) DESC, f.film_id) AS rank,
        sum(p.amount) AS revenue
    FROM actor a
    JOIN film_actor fa ON fa.actor_id = a.actor_id
    JOIN film f ON f.film_id = fa.film_id
    JOIN inventory i ON i.film_id = f.film_id
    JOIN rental r ON r.inventory_id = i.inventory_id
    JOIN payment p ON p.rental_id = r.rental_id
    GROUP BY a.actor_id, a.first_name, a.last_name, f.film_id, f.title
) t
WHERE rank <= 3
ORDER BY actor_id, rank;
