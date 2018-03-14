INSERT INTO links (customer_id, url, expiration)
VALUES (
    $1, 
    $2, 
    (
        SELECT (CURRENT_DATE + INTERVAL '1 day') + ('00:00:00' + INTERVAL '10 hour')
    )
);