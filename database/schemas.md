Schema 1
1. Insert persons (49 rows)
2. Insert suppliers (14 rows)
3. Insert clients (16 rows)
4. Insert employees (19 rows)
5. Insert roles (14 rows)
6. Insert users (25 rows)

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



4. Creó la tabla CatSize

5. Se agregó el campo fkCatSize a CatRecipe

6. Se agregó la tabla CatColor

7. Se agregó la tabla DetailRawMaterialColor

8. Se agregó la tabla DetailRecipeColor

9. CatRecipe imagePath puede ser nulo


Arcilla: La arcilla es la materia prima principal de la mayoría de los productos cerámicos. Se utilizan distintos tipos de arcilla, como el caolín, la arcilla de bola y la arcilla refractaria, en función de su plasticidad, temperatura de cocción y color.
Feldespato: El feldespato es un agente fundente que se utiliza para reducir la temperatura de fusión de la arcilla, facilitando su modelado y aumentando la resistencia de la cerámica tras la cocción.
Sílice: La sílice, normalmente en forma de cuarzo o sílex, proporciona dureza y resistencia al cuerpo cerámico y también actúa como fundente en algunas formulaciones cerámicas.
Talco: El talco se añade a la cerámica para mejorar su resistencia al choque térmico y aumentar su temperatura de cocción.
Alúmina: La alúmina se utiliza para aumentar la resistencia mecánica y química de la cerámica.
Circonia: La circonia se añade a la cerámica para mejorar las propiedades mecánicas y aumentar la resistencia al desgaste y la corrosión.
Colorantes: Varios óxidos metálicos y otros compuestos se utilizan como colorantes para añadir diferentes matices a los productos cerámicos.
Pigmentos: Los pigmentos se añaden para crear motivos y diseños decorativos en la superficie de la cerámica.
Materiales de glaseado: Los materiales de glaseado se aplican a la superficie de los productos cerámicos para proporcionar un revestimiento protector y decorativo. Los materiales de glaseado suelen incluir feldespato, sílice, arcilla y diversos óxidos metálicos.
Ligantes: Los aglutinantes, como la celulosa o el almidón, pueden utilizarse en los procesos de modelado para mantener unidas las partículas cerámicas antes de la cocción.
Fritas: Las fritas son partículas de vidrio prefundidas que se añaden a los esmaltes para mejorar su durabilidad y aspecto.
