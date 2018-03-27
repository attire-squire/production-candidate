SELECT * FROM customers
WHERE id = (
    SELECT customer_id FROM links WHERE url = $1 AND expiration > NOW()
);