DROP TABLE screenings;
DROP TABLE tickets;
DROP TABLE customers;
DROP TABLE films;

CREATE TABLE customers (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255),
    funds INT
);

CREATE TABLE films (
    id SERIAL PRIMARY KEY,
    title VARCHAR(255),
    price INT
);

CREATE TABLE tickets (
    id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES customers(id) ON DELETE SET NULL,
    film_id INT REFERENCES films(id) ON DELETE SET NULL
);

CREATE TABLE screenings (
    id SERIAL PRIMARY KEY,
    time VARCHAR(255),
    film_id INT REFERENCES films(id) ON DELETE CASCADE,
    tickets INT
);