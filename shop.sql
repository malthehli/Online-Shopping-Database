CREATE TABLE category (
    ca_id       NUMBER(10) NOT NULL,
    name        VARCHAR2(50) NOT NULL,
    description VARCHAR2(50) NOT NULL
);

ALTER TABLE category ADD CONSTRAINT category_pk PRIMARY KEY ( ca_id );

CREATE TABLE customer (
    c_id    NUMBER(10) NOT NULL,
    name    VARCHAR2(50) NOT NULL,
    email   VARCHAR2(50) NOT NULL,
    phone   VARCHAR2(50) NOT NULL,
    address VARCHAR2(50) NOT NULL
);

ALTER TABLE customer ADD CONSTRAINT customer_pk PRIMARY KEY ( c_id );

CREATE TABLE "ORDER" (
    o_id          NUMBER(10) NOT NULL,
    "date"        DATE NOT NULL,
    order_status  VARCHAR2(50) NOT NULL,
    customer_c_id NUMBER(10) NOT NULL
);

ALTER TABLE "ORDER" ADD CONSTRAINT order_pk PRIMARY KEY ( o_id );

CREATE TABLE "ORDER ITEM" (
    o_i_id       NUMBER(10) NOT NULL,
    quantity     NUMBER(20) NOT NULL,
    order_o_id   NUMBER(10) NOT NULL,
    product_p_id NUMBER(10) NOT NULL
);

ALTER TABLE "ORDER ITEM" ADD CONSTRAINT "ORDER ITEM_PK" PRIMARY KEY ( o_i_id );

CREATE TABLE payment (
    pa_id          NUMBER(10) NOT NULL,
    amount         NUMBER(20) NOT NULL,
    payment_method VARCHAR2(50) NOT NULL,
    order_o_id     NUMBER(10) NOT NULL
);

ALTER TABLE payment ADD CONSTRAINT payment_pk PRIMARY KEY ( pa_id );

CREATE TABLE product (
    p_id           NUMBER(10) NOT NULL,
    name           VARCHAR2(50) NOT NULL,
    description    VARCHAR2(50) NOT NULL,
    price          NUMBER(20) NOT NULL,
    category_ca_id NUMBER(10) NOT NULL
);

ALTER TABLE product ADD CONSTRAINT product_pk PRIMARY KEY ( p_id );

CREATE TABLE "SHIPPING ADDRESS" (
    a_id           NUMBER(10) NOT NULL,
    address_line_1 VARCHAR2(50) NOT NULL,
    address_line_2 VARCHAR2(50),
    city           VARCHAR2(50) NOT NULL,
    state          VARCHAR2(50) NOT NULL,
    zip_code       NUMBER(20),
    customer_c_id  NUMBER(10) NOT NULL,
    order_o_id     NUMBER(10) NOT NULL
);

ALTER TABLE "SHIPPING ADDRESS" ADD CONSTRAINT "SHIPPING ADDRESS_PK" PRIMARY KEY ( a_id );

ALTER TABLE "ORDER"
    ADD CONSTRAINT order_customer_fk FOREIGN KEY ( customer_c_id )
        REFERENCES customer ( c_id );

ALTER TABLE "ORDER ITEM"
    ADD CONSTRAINT "ORDER ITEM_ORDER_FK" FOREIGN KEY ( order_o_id )
        REFERENCES "ORDER" ( o_id );

ALTER TABLE "ORDER ITEM"
    ADD CONSTRAINT "ORDER ITEM_PRODUCT_FK" FOREIGN KEY ( product_p_id )
        REFERENCES product ( p_id );

ALTER TABLE payment
    ADD CONSTRAINT payment_order_fk FOREIGN KEY ( order_o_id )
        REFERENCES "ORDER" ( o_id )
            ON DELETE CASCADE;

ALTER TABLE product
    ADD CONSTRAINT product_category_fk FOREIGN KEY ( category_ca_id )
        REFERENCES category ( ca_id );

ALTER TABLE "SHIPPING ADDRESS"
    ADD CONSTRAINT "SHIPPING ADDRESS_CUSTOMER_FK" FOREIGN KEY ( customer_c_id )
        REFERENCES customer ( c_id );

ALTER TABLE "SHIPPING ADDRESS"
    ADD CONSTRAINT "SHIPPING ADDRESS_ORDER_FK" FOREIGN KEY ( order_o_id )
        REFERENCES "ORDER" ( o_id );

CREATE SEQUENCE customer_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE orders_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE order_item_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE shipping_address_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE payment_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE product_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE category_seq START WITH 1 INCREMENT BY 1;

INSERT INTO category (ca_id, name, description) VALUES (category_seq.NEXTVAL, 'Electronics', 'Electronic devices and accessories');
INSERT INTO category (ca_id, name, description) VALUES (category_seq.NEXTVAL, 'Clothing', 'Fashion and apparel');
INSERT INTO category (ca_id, name, description) VALUES (category_seq.NEXTVAL, 'Books', 'Literature and academic books');
INSERT INTO category (ca_id, name, description) VALUES (category_seq.NEXTVAL, 'Home', 'Home decor and furniture');
INSERT INTO category (ca_id, name, description) VALUES (category_seq.NEXTVAL, 'Beauty', 'Cosmetics and skincare');

INSERT INTO customer (c_id, name, email, phone, address) VALUES (customer_seq.NEXTVAL, 'Zayed', 'zayed@example.com', '555-1234', '111 baniyas');
INSERT INTO customer (c_id, name, email, phone, address) VALUES (customer_seq.NEXTVAL, 'Mohammed', 'mohammed@example.com', '555-5678', '123 abudhabi');
INSERT INTO customer (c_id, name, email, phone, address) VALUES (customer_seq.NEXTVAL, 'Ali', 'ali@example.com', '555-9012', '189 home');
INSERT INTO customer (c_id, name, email, phone, address) VALUES (customer_seq.NEXTVAL, 'Ahmed', 'ahmed@example.com', '555-3456', '321 gg St');
INSERT INTO customer (c_id, name, email, phone, address) VALUES (customer_seq.NEXTVAL, 'Abdullah', 'abdullah@example.com', '555-7890', '654 wp St');

INSERT INTO product (p_id, name, description, price, category_ca_id) VALUES (product_seq.NEXTVAL, 'iPhone 13', 'Latest Apple smartphone', 999, 1);
INSERT INTO product (p_id, name, description, price, category_ca_id) VALUES (product_seq.NEXTVAL, 'Samsung Galaxy S21', 'Latest Samsung smartphone', 899, 1);
INSERT INTO product (p_id, name, description, price, category_ca_id) VALUES (product_seq.NEXTVAL, 'Nike', 'Running shoes', 150, 2);
INSERT INTO product (p_id, name, description, price, category_ca_id) VALUES (product_seq.NEXTVAL, 'the wimpkid-diary', 'the writer fav book', 10, 3);
INSERT INTO product (p_id, name, description, price, category_ca_id) VALUES (product_seq.NEXTVAL, 'Philips Hue', 'Smart lighting system', 99, 4);
INSERT INTO product (p_id, name, description, price, category_ca_id) VALUES (product_seq.NEXTVAL, 'filler', 'cosmo surjery', 40, 5);

INSERT INTO "ORDER" (o_id, "date", order_status, customer_c_id)
VALUES (orders_seq.nextval, TO_DATE('2022-03-15', 'YYYY-MM-DD'), 'Pending', 1);
INSERT INTO "ORDER" (o_id, "date", order_status, customer_c_id)
VALUES (orders_seq.nextval, TO_DATE('2022-04-01', 'YYYY-MM-DD'), 'Shipped', 2);
INSERT INTO "ORDER" (o_id, "date", order_status, customer_c_id)
VALUES (orders_seq.nextval, TO_DATE('2022-04-15', 'YYYY-MM-DD'), 'Delivered', 3);
INSERT INTO "ORDER" (o_id, "date", order_status, customer_c_id)
VALUES (orders_seq.nextval, TO_DATE('2022-05-01', 'YYYY-MM-DD'), 'Pending', 4);
INSERT INTO "ORDER" (o_id, "date", order_status, customer_c_id)
VALUES (orders_seq.nextval, TO_DATE('2022-05-15', 'YYYY-MM-DD'), 'Shipped', 5);

INSERT INTO "ORDER ITEM" (o_i_id, quantity, order_o_id, product_p_id) VALUES (order_item_seq.NEXTVAL, 2, 1, 1);
INSERT INTO "ORDER ITEM" (o_i_id, quantity, order_o_id, product_p_id) VALUES (order_item_seq.NEXTVAL, 1, 1, 2);
INSERT INTO "ORDER ITEM" (o_i_id, quantity, order_o_id, product_p_id) VALUES (order_item_seq.NEXTVAL, 3, 2, 3);
INSERT INTO "ORDER ITEM" (o_i_id, quantity, order_o_id, product_p_id) VALUES (order_item_seq.NEXTVAL, 2, 2, 4);
INSERT INTO "ORDER ITEM" (o_i_id, quantity, order_o_id, product_p_id) VALUES (order_item_seq.NEXTVAL, 1, 3, 5);
INSERT INTO "ORDER ITEM" (o_i_id, quantity, order_o_id, product_p_id) VALUES (order_item_seq.NEXTVAL, 4, 4, 6);
INSERT INTO "ORDER ITEM" (o_i_id, quantity, order_o_id, product_p_id) VALUES (order_item_seq.NEXTVAL, 2, 4, 3);
INSERT INTO "ORDER ITEM" (o_i_id, quantity, order_o_id, product_p_id) VALUES (order_item_seq.NEXTVAL, 3, 4, 1);
INSERT INTO "ORDER ITEM" (o_i_id, quantity, order_o_id, product_p_id) VALUES (order_item_seq.NEXTVAL, 1, 5, 4);
INSERT INTO "ORDER ITEM" (o_i_id, quantity, order_o_id, product_p_id) VALUES (order_item_seq.NEXTVAL, 2, 5, 6);

INSERT INTO payment (pa_id, amount, payment_method, order_o_id) VALUES (payment_seq.NEXTVAL, 50.00, 'Credit Card', 1);
INSERT INTO payment (pa_id, amount, payment_method, order_o_id) VALUES (payment_seq.NEXTVAL, 75.00, 'PayPal', 2);
INSERT INTO payment (pa_id, amount, payment_method, order_o_id) VALUES (payment_seq.NEXTVAL, 30.00, 'Debit Card', 3);
INSERT INTO payment (pa_id, amount, payment_method, order_o_id) VALUES (payment_seq.NEXTVAL, 100.00, 'Cash on Delivery', 4);
INSERT INTO payment (pa_id, amount, payment_method, order_o_id) VALUES (payment_seq.NEXTVAL, 40.00, 'Google Pay', 5);
INSERT INTO payment (pa_id, amount, payment_method, order_o_id) VALUES (payment_seq.NEXTVAL, 90.00, 'Venmo', 4);

INSERT INTO "SHIPPING ADDRESS" (a_id, address_line_1, address_line_2, city, state, zip_code, customer_c_id, order_o_id)
VALUES (shipping_address_seq.nextval, '123 Main St', NULL, 'Los Angeles', 'CA', 90001, 1, 1);

INSERT INTO "SHIPPING ADDRESS" (a_id, address_line_1, address_line_2, city, state, zip_code, customer_c_id, order_o_id)
VALUES (shipping_address_seq.nextval, '456 Elm St', 'Apt 2B', 'New York', 'NY', 10001, 2, 2);

INSERT INTO "SHIPPING ADDRESS" (a_id, address_line_1, address_line_2, city, state, zip_code, customer_c_id, order_o_id)
VALUES (shipping_address_seq.nextval, '789 Oak Ave', NULL, 'Chicago', 'IL', 60601, 3, 3);

INSERT INTO "SHIPPING ADDRESS" (a_id, address_line_1, address_line_2, city, state, zip_code, customer_c_id, order_o_id)
VALUES (shipping_address_seq.nextval, '111 Pine St', 'Suite 500', 'San Francisco', 'CA', 94105, 1, 4);

INSERT INTO "SHIPPING ADDRESS" (a_id, address_line_1, address_line_2, city, state, zip_code, customer_c_id, order_o_id)
VALUES (shipping_address_seq.nextval, '222 Maple Dr', NULL, 'Houston', 'TX', 77002, 4, 5);

-- Query 1 : What is the total amount of sales made by each customer?
SELECT c.name as customer_name, SUM(p.amount) as total_sales
FROM customer c
JOIN "ORDER" o ON c.c_id = o.customer_c_id
JOIN payment p ON o.o_id = p.order_o_id
GROUP BY c.name
ORDER BY total_sales DESC;

-- Query 2 : Which products have been ordered the most and how many times have they been ordered?
SELECT p.name as product_name, COUNT(*) as total_orders
FROM product p
JOIN "ORDER ITEM" oi ON p.p_id = oi.product_p_id
GROUP BY p.name
ORDER BY total_orders DESC;

-- Query 3:What is the average price of products in each category?
SELECT c.name as category_name, AVG(p.price) as average_price
FROM category c
JOIN product p ON c.ca_id = p.category_ca_id
GROUP BY c.name
ORDER BY average_price DESC;

-- Query4: Get the total amount paid by each payment method.
SELECT payment_method, SUM(amount) AS total_amount
FROM payment
GROUP BY payment_method
ORDER BY total_amount DESC;


-- Query5: What are the top 5 categories by total sales?
SELECT c.name as category_name, SUM(p.amount) as total_sales
FROM category c
JOIN product pr ON c.ca_id = pr.category_ca_id
JOIN "ORDER ITEM" oi ON pr.p_id = oi.product_p_id
JOIN payment p ON oi.o_i_id = p.order_o_id
GROUP BY c.name
ORDER BY total_sales DESC
FETCH FIRST 5 ROWS ONLY;

-- Query6: Get the number of orders placed by each customer.
SELECT c.name, COUNT(o.o_id) AS total_orders
FROM customer c
LEFT JOIN "ORDER" o ON c.c_id = o.customer_c_id
GROUP BY c.name
ORDER BY total_orders DESC;

-- Query7: Get the top 5 products by total sales.
SELECT p.name, SUM(oi.quantity) AS total_sales
FROM product p
INNER JOIN "ORDER ITEM" oi ON p.p_id = oi.product_p_id
GROUP BY p.name
ORDER BY total_sales DESC
FETCH FIRST 5 ROWS ONLY;

