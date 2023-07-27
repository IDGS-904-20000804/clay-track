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




