INSERT INTO customers (first_name, last_name, phone, zip, date_created)
SELECT $1, $2, $3, $4, NOW()
WHERE 
    NOT EXISTS 
        ( SELECT * FROM customers WHERE phone = $3 )
RETURNING *;