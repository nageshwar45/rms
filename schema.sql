-- Oracle SQL for RMS Database - Drop existing objects first
DROP TABLE feedback CASCADE CONSTRAINTS;
DROP TABLE incomes CASCADE CONSTRAINTS;
DROP TABLE bookings CASCADE CONSTRAINTS;
DROP TABLE tables CASCADE CONSTRAINTS;
DROP TABLE menu CASCADE CONSTRAINTS;
DROP TABLE restaurants CASCADE CONSTRAINTS;
DROP TABLE users CASCADE CONSTRAINTS;

DROP SEQUENCE feedback_seq;
DROP SEQUENCE incomes_seq;
DROP SEQUENCE bookings_seq;
DROP SEQUENCE tables_seq;
DROP SEQUENCE menu_seq;
DROP SEQUENCE restaurants_seq;
DROP SEQUENCE users_seq;

-- Create sequences for auto-increment
CREATE SEQUENCE users_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE restaurants_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE menu_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE tables_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE bookings_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE incomes_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE feedback_seq START WITH 1 INCREMENT BY 1;

-- Create users table
CREATE TABLE users (
  id NUMBER PRIMARY KEY,
  username VARCHAR2(255) NOT NULL UNIQUE,
  password VARCHAR2(255) NOT NULL,
  role VARCHAR2(10) DEFAULT 'user' CHECK (role IN ('admin', 'user', 'restaurant')),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create restaurants table
CREATE TABLE restaurants (
  id NUMBER PRIMARY KEY,
  name VARCHAR2(255) NOT NULL,
  email VARCHAR2(255),
  logo VARCHAR2(500),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create menu table
CREATE TABLE menu (
  id VARCHAR2(50) PRIMARY KEY,
  restaurant_id NUMBER NOT NULL,
  name VARCHAR2(255) NOT NULL,
  price NUMBER(10,2) NOT NULL,
  img VARCHAR2(500),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (restaurant_id) REFERENCES restaurants(id) ON DELETE CASCADE
);

-- Create tables table
CREATE TABLE tables (
  id VARCHAR2(50) PRIMARY KEY,
  restaurant_id NUMBER NOT NULL,
  num NUMBER NOT NULL,
  status VARCHAR2(20) DEFAULT 'available',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (restaurant_id) REFERENCES restaurants(id) ON DELETE CASCADE
);

-- Create bookings table
CREATE TABLE bookings (
  id VARCHAR2(50) PRIMARY KEY,
  restaurant_id NUMBER NOT NULL,
  table_num NUMBER NOT NULL,
  start_time VARCHAR2(20),
  end_time VARCHAR2(20),
  user_name VARCHAR2(255),
  type VARCHAR2(50),
  items CLOB,
  total NUMBER(10,2),
  booking_date DATE,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (restaurant_id) REFERENCES restaurants(id) ON DELETE CASCADE
);

-- Create incomes table
CREATE TABLE incomes (
  id VARCHAR2(50) PRIMARY KEY,
  restaurant_id NUMBER NOT NULL,
  amount NUMBER(10,2) NOT NULL,
  income_date DATE,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (restaurant_id) REFERENCES restaurants(id) ON DELETE CASCADE
);

-- Create feedback table
CREATE TABLE feedback (
  id VARCHAR2(50) PRIMARY KEY,
  restaurant_id NUMBER NOT NULL,
  user_name VARCHAR2(255),
  text CLOB,
  feedback_date DATE,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (restaurant_id) REFERENCES restaurants(id) ON DELETE CASCADE
);

-- Insert sample data into users table
INSERT INTO users (id, username, password, role) VALUES (users_seq.NEXTVAL, 'admin', '$2b$10$examplehashedpassword', 'admin');
INSERT INTO users (id, username, password, role) VALUES (users_seq.NEXTVAL, 'john_doe', '$2b$10$examplehashedpassword', 'user');
INSERT INTO users (id, username, password, role) VALUES (users_seq.NEXTVAL, 'jane_smith', '$2b$10$examplehashedpassword', 'user');

-- Insert sample data into restaurants table
INSERT INTO restaurants (id, name, email, logo) VALUES (restaurants_seq.NEXTVAL, 'Pizza Palace', 'pizza@example.com', 'https://example.com/pizza-logo.jpg');
INSERT INTO restaurants (id, name, email, logo) VALUES (restaurants_seq.NEXTVAL, 'Burger Barn', 'burger@example.com', 'https://example.com/burger-logo.jpg');
INSERT INTO restaurants (id, name, email, logo) VALUES (restaurants_seq.NEXTVAL, 'Sushi Spot', 'sushi@example.com', 'https://example.com/sushi-logo.jpg');
