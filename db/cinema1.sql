DROP TABLE screenings;
DROP TABLE tickets;
DROP TABLE customers;
DROP TABLE films;


CREATE TABLE customers (
  id SERIAL8 PRIMARY KEY,
  name VARCHAR(255),
  funds INT2
);

CREATE TABLE films (
  id SERIAL8 PRIMARY KEY,
  title VARCHAR(255),
  price INT2
);

CREATE TABLE tickets (
  id SERIAL4 PRIMARY KEY,
  customer_id INT8 REFERENCES customers(id) ON DELETE CASCADE,
  film_id INT8 REFERENCES films(id) ON DELETE CASCADE

);

CREATE TABLE screenings (
  id SERIAL8 PRIMARY KEY,
  film_id VARCHAR(255),
  start_time VARCHAR(255),
  empty_seats INT2
);
