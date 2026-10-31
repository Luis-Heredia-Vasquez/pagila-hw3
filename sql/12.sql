/* 
 * A new James Bond movie will be released soon, and management wants to send promotional material to "action fanatics".
 * They've decided that an action fanatic is any customer where at least 4 of their 5 most recently rented movies are action movies.
 *
 * Write a SQL query that finds all action fanatics.
 */

SELECT c.customer_id, c.first_name, c.last_name
FROM customer c
CROSS JOIN LATERAL (
    SELECT r.rental_id, i.film_id
    FROM rental r
    JOIN inventory i ON i.inventory_id = r.inventory_id
    WHERE r.customer_id = c.customer_id
    ORDER BY r.rental_date DESC
    LIMIT 5
) x
JOIN film_category fc ON fc.film_id = x.film_id
JOIN category cat ON cat.category_id = fc.category_id
GROUP BY c.customer_id, c.first_name, c.last_name
HAVING count(*) FILTER (WHERE cat.name = 'Action') >= 4
ORDER BY c.customer_id;
