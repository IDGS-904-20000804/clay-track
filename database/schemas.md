Schema 1
1. Insert persons (50 rows)
2. Insert suppliers (14 rows)
5. Insert roles (5 rows)
6. Insert users (16 rows)
3. Insert clients (28 rows)
4. Insert employees (8 rows)

Consider the follow notes:
The persons rows is the same of suppliers + clients + employees
The users rows is the same of clients + employees
Put special attention for the foreing keys

Schema 2
1. Insert units of measure
2. Insert raw materials
3. Insert recipes

Schema 3
1. Insert purchase

Schema 4
1. Insert stock
2. Insert sales


1. Se agregó el siguiente campo a la tabla CatRawMaterial:
quantityWarehouse INT NOT NULL DEFAULT 0

2. Se cambió el nombre del siguinte atributo en la tabla DetailPurchase:
fkCatWarehouse INT NOT NULL
por
fkCatRawMaterial INT NOT NULL

3. Se eliminó la tabla CatWarehouse