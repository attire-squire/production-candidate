DROP TABLE IF EXISTS customers;
CREATE TABLE IF NOT EXISTS customers (
    id SERIAL UNIQUE,
    first_name VARCHAR(30) NOT NULL,
    last_name VARCHAR(30) NOT NULL,
    phone VARCHAR(20) NOT NULL,
    street_1 VARCHAR(40),
    street_2 VARCHAR(40),
    city VARCHAR(40),
    state_name VARCHAR(15),
    zip INT,
    date_created TIMESTAMP
);

DROP TABLE IF EXISTS products;
CREATE TABLE IF NOT EXISTS products (
    id SERIAL UNIQUE,
    product_name VARCHAR(50),
    price INT
);

DROP TABLE IF EXISTS templates;
CREATE TABLE IF NOT EXISTS templates (
    id SERIAL UNIQUE,
    message_head TEXT,
    message_body TEXT
);

DROP TABLE IF EXISTS squires;
CREATE TABLE IF NOT EXISTS squires (
    id SERIAL UNIQUE,
    email VARCHAR(50),
    password VARCHAR(255),
    user_type INT
);

DROP TABLE IF EXISTS routes;
CREATE TABLE IF NOT EXISTS routes (
    id SERIAL UNIQUE,
    squire_id INT REFERENCES squires(id),
    date_created TIMESTAMP,
    status_id INT
);

DROP TABLE IF EXISTS orders;
CREATE TABLE IF NOT EXISTS orders (
    id SERIAL UNIQUE,
    customer_id INT REFERENCES customers(id),
    route_id INT REFERENCES routes(id),
    date_placed TIMESTAMP,
    total_price INT,
    product_id INT REFERENCES products(id),
    product_qty INT,
    charge_status INT,
    status_id INT,
    status_update TIMESTAMP
);

DROP TABLE IF EXISTS logins;
CREATE TABLE IF NOT EXISTS logins (
    id SERIAL UNIQUE,
    customer_id INT REFERENCES customers(id),
    phone VARCHAR(20),
    code INT,
    date_sent TIMESTAMP,
    expiration TIMESTAMP
);

DROP TABLE IF EXISTS available;
CREATE TABLE IF NOT EXISTS available (
    zip INT,
    city VARCHAR(40),
    state_name VARCHAR(15)
);

DROP TABLE IF EXISTS potential;
CREATE TABLE IF NOT EXISTS potential (
    zip INT,
    city VARCHAR(40),
    state_name VARCHAR(15),
    date_entered TIMESTAMP
);