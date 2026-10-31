/*
 * List all actors with Bacall Number 2;
 * That is, list all actors that have appeared in a film with an actor that has appeared in a film with 'RUSSELL BACALL',
 * but do not include actors that have Bacall Number < 2.
 */

WITH bacall0 AS (
    SELECT actor_id
    FROM actor
    WHERE first_name = 'RUSSELL' AND last_name = 'BACALL'
),
bacall1 AS (
    SELECT DISTINCT a.actor_id
    FROM actor a
    JOIN film_actor fa ON fa.actor_id = a.actor_id
    JOIN film_actor fa2 ON fa2.film_id = fa.film_id
    JOIN actor a2 ON a2.actor_id = fa2.actor_id
    WHERE a2.actor_id IN (SELECT actor_id FROM bacall0)
    AND a.actor_id NOT IN (SELECT actor_id FROM bacall0)
)
SELECT DISTINCT a.first_name || ' ' || a.last_name AS "Actor Name"
FROM actor a
JOIN film_actor fa ON fa.actor_id = a.actor_id
JOIN film_actor fa2 ON fa2.film_id = fa.film_id
JOIN actor a2 ON a2.actor_id = fa2.actor_id
WHERE a2.actor_id IN (SELECT actor_id FROM bacall1)
AND a.actor_id NOT IN (SELECT actor_id FROM bacall1)
AND a.actor_id NOT IN (SELECT actor_id FROM bacall0)
ORDER BY "Actor Name";
