
SELECT qyeryRecipe.*, queryDetailRecipeRawMaterial.*, queryRawMaterial.* FROM (
  SELECT
    crml.idCatRawMaterial,
    crml.name,
    crml.quantityWarehouse,
    crml.quantityPackage,
    crml.creationDate AS creationDateCatRawMaterial,
    crml.updateDate AS updateDateCatRawMaterial,
    cume.idCatUnitMeasure,
    cume.description,
    cume.creationDate AS creationDateCatUnitMeasure,
    cume.updateDate AS updateDateCatUnitMeasure
  FROM CatRawMaterial crml
  INNER JOIN CatUnitMeasure cume
    ON cume.idCatUnitMeasure = crml.fkCatUnitMeasure
  WHERE crml.status = 1 AND cume.status = 1
  ) AS queryRawMaterial INNER JOIN
  (
    SELECT
      drrm.fkCatRecipe,
      drrm.quantity,
      drrm.fkCatRawMaterial
    FROM DetailRecipeRawMaterial drrm
  ) AS queryDetailRecipeRawMaterial
    ON queryDetailRecipeRawMaterial.fkCatRawMaterial = queryRawMaterial.idCatRawMaterial
  INNER JOIN
  (
    SELECT
      cre.idCatRecipe,
      cre.name,
      cre.price,
      cre.quantityStock,
      cre.creationDate AS creationDateCatRecipe,
      cre.updateDate AS updateDateCatRecipe,
      cse.idCatSize,
      cse.description,
      cse.abbreviation,
      cse.creationDate AS creationDateCatSize,
      cse.updateDate AS updateDateCatSize,
      cia.IdCatImage,
      cia.FileName,
      cia.FileExtension,
      cia.FileSizeInBytes,
      cia.FilePath,
      STUFF((
        SELECT ', ' + ccr.description + ' (' + ccr.hexadecimal + ')'
        FROM DetailRecipeColor drcr
        INNER JOIN CatColor ccr
          ON ccr.idCatColor = drcr.fkCatColor
        WHERE drcr.fkCatRecipe = cre.idCatRecipe AND ccr.status = 1
        FOR XML PATH(''), TYPE).value('.', 'NVARCHAR(MAX)'), 1, 2, '') AS ColorList
    FROM CatRecipe cre
    INNER JOIN CatSize cse
      ON cse.idCatSize = cre.fkCatSize
    LEFT JOIN CatImage cia
      ON cia.IdCatImage = cre.fkCatImage
    WHERE cre.status = 1 AND cse.status = 1
  ) AS qyeryRecipe
    ON queryDetailRecipeRawMaterial.fkCatRecipe = qyeryRecipe.idCatRecipe;



SELECT
  queryTotals.totalRecipes,
  queryTotals.totalProfit,
  queryRecipe.idCatRecipe,
  CONCAT(queryRecipe.subdescriptionRecipe, ' - ', queryRecipe.ColorList) AS descriptionRecipe,
  queryRecipe.FileName,
  queryRecipe.FileExtension,
  queryRecipe.FileSizeInBytes,
  queryRecipe.FilePath
FROM (
  SELECT SUM(dse.quantity) AS totalRecipes, SUM(dse.quantity) AS totalProfit, dse.fkCatRecipe
    FROM DetailSale dse
  INNER JOIN CatSale cse
    ON dse.fkCatSale = cse.idCatSale
  WHERE cse.creationDate >= DATEADD(DAY, -30, GETDATE())
  GROUP BY dse.fkCatRecipe
) AS queryTotals
INNER JOIN (
  SELECT
    subQueryRecipe.idCatRecipe,
    CONCAT(subQueryRecipe.name, ' (', cse.abbreviation, ')') AS subdescriptionRecipe,
    subQueryRecipe.price,
    cia.FileName,
    cia.FileExtension,
    cia.FileSizeInBytes,
    cia.FilePath,
    STUFF((
      SELECT ', ' + ccr.description + ' (' + ccr.hexadecimal + ')'
      FROM DetailRecipeColor drcr
      INNER JOIN CatColor ccr
        ON ccr.idCatColor = drcr.fkCatColor
      WHERE drcr.fkCatRecipe = subQueryRecipe.idCatRecipe AND ccr.status = 1
      FOR XML PATH(''), TYPE).value('.', 'NVARCHAR(MAX)'), 1, 2, '') AS ColorList
  FROM CatRecipe AS subQueryRecipe
  INNER JOIN CatSize cse
    ON cse.idCatSize = subQueryRecipe.fkCatSize
  LEFT JOIN CatImage cia
    ON cia.IdCatImage = subQueryRecipe.fkCatImage
) AS queryRecipe
  ON queryTotals.fkCatRecipe = queryRecipe.idCatRecipe;


SELECT DATEADD(DAY, 1, '2023/04/30') AS DateAdd;


