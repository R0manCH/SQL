
--DROP

DROP TABLE IF EXISTS houses CASCADE;
DROP TABLE IF EXISTS owners CASCADE;
DROP TABLE IF EXISTS food CASCADE;
DROP TABLE IF EXISTS cats CASCADE;
DROP TABLE IF EXISTS cart;

-- CREATE

CREATE TABLE houses
(
    house_id int GENERATED ALWAYS AS IDENTITY,
    house_name varchar(64) UNIQUE NOT NULL,
    address varchar(64) UNIQUE NOT NULL,
    
    CONSTRAINT PK_cats_house_id PRIMARY KEY(house_id)
);

CREATE TABLE owners
(
    owner_id int GENERATED ALWAYS AS IDENTITY,
    owner_name varchar(64) UNIQUE NOT NULL,
    house_id int,
    
    CONSTRAINT PK_cats_owner_id PRIMARY KEY(owner_id),
    CONSTRAINT FK_cats_owners_houses FOREIGN KEY(house_id) REFERENCES houses(house_id)
);

CREATE TABLE cats
(
    cat_id int GENERATED ALWAYS AS IDENTITY,
    cat_name varchar(64) UNIQUE NOT NULL,
    email varchar(64),
    owner_id int,
    
    CONSTRAINT PK_cats_cat_id PRIMARY KEY(cat_id),
    CONSTRAINT FK_cats_cats_owners FOREIGN KEY(owner_id) REFERENCES owners(owner_id)
);

CREATE TABLE food
(
    food_id int GENERATED ALWAYS AS IDENTITY,
    food_name varchar(64) UNIQUE NOT NULL,
    price numeric NOT NULL,
    
    CONSTRAINT PK_cats_food_id PRIMARY KEY(food_id),
    CONSTRAINT CHK_cats_food_price CHECK (price >= 0)
);

CREATE TABLE cart
(
    cart_id int GENERATED ALWAYS AS IDENTITY,
    cat_id int NOT NULL,
    food_id int NOT NULL,
    amount int NOT NULL,
    date_buy date DEFAULT 'today' NOT NULL,
    
    CONSTRAINT PK_cats_curt_id PRIMARY KEY(cart_id),
    CONSTRAINT FK_cats_curt_cats_id FOREIGN KEY(cat_id) REFERENCES cats(cat_id),
    CONSTRAINT FK_cats_curt_food_id FOREIGN KEY(food_id) REFERENCES food(food_id),
    CONSTRAINT CHK_cats_cart_amount CHECK (amount >= 0)
);

-- INSERT

INSERT INTO houses (house_name, address)
VALUES 
('My house', 'Prospect Kosmonaftov, 67'),
('Parent''s house', 'Lomonosova, 63'),
('Grandma''s house', 'Lomonosova, 3');

INSERT INTO owners (owner_name, house_id)
VALUES 
('Roman', 1),
('Ekaterina', 1),
('Father', 2),
('Grandmother', 3);

INSERT INTO cats (cat_name, email, owner_id)
VALUES 
('Cleopatra', 'best_kitty@gmail.com', 2),
('Veniamin', 'brodyaga@mail.ru', 1),
('Alexandr', 'sasha.white@mail.ru', 3),
('Kuzya', 'crazy_cat@yandex.ru', 3);

INSERT INTO food (food_name, price)
VALUES 
('Dreamies', 59),
('Kitecat', 20),
('Meat', 29),
('Mouse', 47),
('Milk', 25);

INSERT INTO cart (cat_id, food_id, amount, date_buy) 
VALUES 
(1, 1, 9, 'yesterday'),
(2, 2, 8, 'yesterday'),
(1, 1, 3, 'today'),
(3, 2, 8, '2022-09-18'),
(3, 1, 4, '2022-09-17'),
(3, 3, 5, '2022-09-21'),
(4, 4, 7, '2022-09-21'),
(4, 5, 5, '2022-09-17');
INSERT INTO cart (cat_id, food_id, amount) 
VALUES 
(1, 5, 5),
(4, 5, 5),
(2, 5, 6),
(2, 3, 6);