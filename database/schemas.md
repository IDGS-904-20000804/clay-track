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



4. Creó la tabla CatSize

5. Se agregó el campo fkCatSize a CatRecipe

6. Se agregó la tabla CatColor

7. Se agregó la tabla DetailRawMaterialColor

8. Se agregó la tabla DetailRecipeColor

9. CatRecipe imagePath puede ser nulo

10. Se eliminó DetailRawMaterialColor

11. Se agregó este campo
quantityPackage INT NOT NULL
a la tabla
CatRawMaterial

12. Se actualizó el campo de la tabla DetailPurchase
de
  quantity FLOAT NOT NULL
a
  quantity INT NOT NULL

13. Se actualizó el campo de la tabla DetailRecipeRawMaterial
de
  quantity FLOAT NOT NULL
a
  quantity INT NOT NULL

14. Se actualizó el campo de la tabla DetailSale
de
  quantity FLOAT NOT NULL
a
  quantity INT NOT NULL

15. Se eliminó price de CatRecipe

16. Se removio el siguiente campo a CatStock
  price FLOAT NOT NULL,
y se agregó a 