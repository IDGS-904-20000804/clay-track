
SELECT
  crml.idCatRawMaterial,
  crml.name,
  crml.quantityWarehouse,
  crml.quantityPackage,
  crml.status,
  crml.creationDate AS creationDateCatRawMaterial,
  crml.updateDate AS updateDateCatRawMaterial,
  cume.idCatUnitMeasure,
  cume.description,
  cume.status,
  cume.creationDate AS creationDateCatUnitMeasure,
  cume.updateDate AS updateDateCatUnitMeasure
FROM CatRawMaterial crml
INNER JOIN CatUnitMeasure cume
  ON cume.idCatUnitMeasure = crml.fkCatUnitMeasure;

SELECT
FROM 

SELECT
  cre.idCatRecipe,
  cre.name,
  cre.price,
  cre.quantityStock,
  cre.imagePath,
  cre.status,
  cre.creationDate AS creationDateCatRecipe,
  cre.updateDate AS updateDateCatRecipe,
  cse.idCatSize,
  cse.description,
  cse.abbreviation,
  cse.status,
  cse.creationDate AS creationDateCatSize,
  cse.updateDate AS updateDateCatSize
FROM CatRecipe cre
INNER JOIN CatSize cse
  ON cse;

SELECT
FROM 

SELECT
  idCatColor,
  description,
  hexadecimal,
  status,
  creationDate AS creationDateCatColor,
  updateDate AS updateDateCatColor
FROM CatColor;

