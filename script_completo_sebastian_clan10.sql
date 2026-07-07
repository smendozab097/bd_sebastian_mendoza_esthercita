/* --- DDL --- */

CREATE DATABASE bd_sebastian_mendoza_esthercita;
USE bd_sebastian_mendoza_esthercita;


CREATE TABLE eco_cities (
    id INT AUTO_INCREMENT PRIMARY KEY,
    eco_city_name VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE eco_clients (
    id INT AUTO_INCREMENT PRIMARY KEY,
    eco_client_name VARCHAR(100) NOT NULL
);


CREATE TABLE eco_distribution_centers (
    id INT AUTO_INCREMENT PRIMARY KEY,
    eco_distribution_center_name VARCHAR(200) NOT NULL
);


CREATE TABLE eco_categories (
    id INT AUTO_INCREMENT PRIMARY KEY,
    eco_category VARCHAR(100) NOT NULL UNIQUE
);


CREATE TABLE eco_products (
    id INT AUTO_INCREMENT PRIMARY KEY,
    eco_product_name VARCHAR(150) NOT NULL,
    eco_category_id INT,
    eco_unit_price DECIMAL(10,2) NOT NULL,
    foreign key(eco_category_id)
	references eco_categories(id)
    on delete set null
    on update cascade
);


CREATE TABLE eco_orders (
    id VARCHAR(20) PRIMARY KEY,
    eco_order_date DATE NOT NULL,
    eco_client_id INT,
    eco_product_id INT,
    eco_city_id INT,
    eco_distribution_center_id INT,
    eco_quantity INT NOT NULL,
	eco_stock INT NOT NULL,
    foreign key(eco_client_id)
	references eco_clients(id)
    on delete set null
    on update cascade,
    foreign key(eco_product_id)
	references eco_products(id)
    on delete set null
    on update cascade,
    foreign key(eco_city_id)
	references eco_cities(id)
    on delete set null
    on update cascade,
    foreign key(eco_distribution_center_id)
	references eco_distribution_centers(id)
    on delete set null
    on update cascade
);

/* --- DML --- */

INSERT INTO eco_cities (eco_city_name) VALUES 
('Barranquilla'), ('Bogotá'), ('Bucaramanga'), 
('Cali'), ('Cartagena'), ('Cúcuta'), 
('Manizales'), ('Medellin'), ('Pereira');

INSERT INTO eco_clients (eco_client_name) VALUES 
('Eco Store'), ('Food Plus'), ('Fresh Mart'), 
('Green Buy'), ('MarketOne'), ('MiniShop'), 
('QuickFood'), ('Retail Co'), ('SuperMax');

INSERT INTO eco_distribution_centers (eco_distribution_center_name) VALUES 
('Coast DC'), ('Coffee DC'), ('East Hub'), 
('North Center'), ('South Hub'), ('West Center');

INSERT INTO eco_categories (eco_category) VALUES 
('Dairy'), ('Fruits'), ('Grains'), 
('Meats'), ('Oils'), ('Vegetables');



UPDATE eco_clients SET eco_client_name="FoodPlus" WHERE id=2;

DELETE FROM eco_products
WHERE NOT EXISTS (
    SELECT 1 
    FROM eco_orders 
    WHERE eco_orders.eco_product_id = eco_products.id
);

/* --- Consultas --- */
/* 1 */
SELECT 
    eco_products.eco_product_name AS Product, 
    SUM(eco_orders.eco_stock) AS Available_Inventory
FROM 
    eco_products
JOIN 
    eco_orders ON eco_products.id = eco_orders.eco_product_id
GROUP BY 
    eco_products.id, eco_products.eco_product_name
ORDER BY 
    Available_Inventory DESC;


/* 2 */
SELECT 
    eco_cities.eco_city_name AS City, 
    COUNT(eco_orders.id) AS Total_Orders,
    SUM(eco_orders.eco_quantity) AS Product_Volume
FROM 
    eco_cities
JOIN 
    eco_orders ON eco_cities.id = eco_orders.eco_city_id
GROUP BY 
    eco_cities.id, eco_cities.eco_city_name
ORDER BY 
    Total_Orders DESC;


/* 3 */
SELECT 
    eco_categories.eco_category AS Category, 
    SUM(eco_orders.eco_quantity * eco_products.eco_unit_price) AS Total_Revenue
FROM 
    eco_categories
JOIN 
    eco_products ON eco_categories.id = eco_products.eco_category_id
JOIN 
    eco_orders ON eco_products.id = eco_orders.eco_product_id
GROUP BY 
    eco_categories.id, eco_categories.eco_category
ORDER BY 
    Total_Revenue DESC;


/* 4 */
SELECT 
    eco_products.eco_product_name AS Product, 
    SUM(eco_orders.eco_stock) AS Current_Inventory
FROM 
    eco_products
JOIN 
    eco_orders ON eco_products.id = eco_orders.eco_product_id
GROUP BY 
    eco_products.id, eco_products.eco_product_name
ORDER BY 
    Current_Inventory ASC
LIMIT 10;


/* 5 */
SELECT 
    eco_clients.eco_client_name AS Client, 
    COUNT(eco_orders.id) AS Number_Of_Orders,
    SUM(eco_orders.eco_quantity) AS Total_Products_Purchased
FROM 
    eco_clients
JOIN 
    eco_orders ON eco_clients.id = eco_orders.eco_client_id
GROUP BY 
    eco_clients.id, eco_clients.eco_client_name
ORDER BY 
    Number_Of_Orders DESC;


/* 6 */
SELECT 
    eco_distribution_centers.eco_distribution_center_name AS Distribution_Center, 
    SUM(eco_orders.eco_stock * eco_products.eco_unit_price) AS Total_Inventory_Value
FROM 
    eco_distribution_centers
JOIN 
    eco_orders ON eco_distribution_centers.id = eco_orders.eco_distribution_center_id
JOIN 
    eco_products ON eco_orders.eco_product_id = eco_products.id
GROUP BY 
    eco_distribution_centers.id, eco_distribution_centers.eco_distribution_center_name
ORDER BY 
    Total_Inventory_Value DESC;
