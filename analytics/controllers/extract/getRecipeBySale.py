
from databases.databaseMain import DatabaseMain


def getRecipeBySale():
  try:
    db = DatabaseMain()
    query = """
    SELECT
      queryTotals.totalRecipes,
      queryTotals.totalProfit,
      queryRecipe.idCatRecipe,
      queryRecipe.nameRecipe,
      queryRecipe.abbreviation,
      queryRecipe.ColorList,
      queryRecipe.FileName,
      queryRecipe.FileExtension,
      queryRecipe.FileSizeInBytes,
      queryRecipe.FilePath
    FROM (
      SELECT
        SUM(dse.quantity) AS totalRecipes,
        SUM(dse.quantity) AS totalProfit,
        dse.fkCatRecipe
      FROM DetailSale dse
      INNER JOIN CatSale cse
        ON dse.fkCatSale = cse.idCatSale
      WHERE cse.creationDate >= DATEADD(DAY, -30, GETDATE())
      GROUP BY dse.fkCatRecipe
    ) AS queryTotals
    INNER JOIN (
      SELECT
        subQueryRecipe.idCatRecipe,
        subQueryRecipe.name AS nameRecipe,
        cse.abbreviation,
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
    """
    results = db.execute_query(query)
    result_list = []
    for row in results:
      row_dict = {
        'totalRecipes' : row[0],
        'totalProfit' : row[1],
        'idCatRecipe' : row[2],
        'nameRecipe' : row[3],
        'abbreviation' : row[4],
        'ColorList' : row[5],
        'FileName' : row[6],
        'FileExtension' : row[7],
        'FileSizeInBytes' : row[8],
        'FilePath' : row[9]
      }
      result_list.append(row_dict)
    db.commit()
    return result_list
  except Exception as e:
    print(f"Error - getRecipeBySale: {e}")
  finally:
    db.disconnect()

