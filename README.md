# bd_sebastian_mendoza_esthercita - EcoMarketRiwi Database

## Project Description
A relational database for **EcoMarketRiwi** to support business intelligence, inventory tracking, and sales analysis.

## Technologies & Engine
- **Technologies:** Excel (Normalization), dbdiagram.io (ERD Design), MySQL (Database).
- **Database Engine:** MySQL (`bd_sebastian_mendoza_esthercita`).

## Normalization & Schema
- **Normalization:** Raw data was normalized up to the Third Normal Form (3NF) to eliminate redundancy.
- **Schema Tables:** `eco_cities`, `eco_clients`, `eco_distribution_centers`, `eco_categories`, `eco_products`, `eco_orders`.

## Entity Relationship Diagram
![ERD](./MER-SMB.png)

## Setup Instructions
1. **Create Database:** Run the SQL script to create the schema:

script_completo_sebastian_clan10.sql

2. **Load Data:** Import the provided `.csv` files into their respective tables or use the SQL script to import the data into the database, respecting foreign key dependencies (catalogs first, then `eco_products`, finally `eco_orders`).

## SQL Queries
Includes 6 business intelligence queries for decision-making:
1. Available inventory per product.
2. Order history per city.
3. Total revenue by category.
4. Products with the lowest inventory.
5. Top clients by order volume.
6. Inventory value per distribution center.

## Developer Information
- **Developer:** Sebastian Mendoza Brieva
- **Contact:** [(https://github.com/smendozab097/bd_sebastian_mendoza_esthercita)]
