
from databases.databaseMain import DatabaseMain


def getRawMaterialByRecipe(month):
  try:
    db = DatabaseMain()
    query = f"""
    SELECT
      hdtre.quantity AS quantityRecipesCreated,
      drrml.quantity AS quantityRawMaterialUsed,
      crml.name,
      crml.quantityWarehouse,
      crml.quantityPackage,
      crml.description
      FROM (
        SELECT
          subcrml.idCatRawMaterial,
          subcrml.name,
          subcrml.quantityWarehouse,
          subcrml.quantityPackage,
          cume.description
        FROM CatRawMaterial subcrml
        INNER JOIN CatUnitMeasure cume
          ON subcrml.fkCatUnitMeasure = cume.idCatUnitMeasure
      ) crml
      INNER JOIN DetailRecipeRawMaterial drrml
        ON drrml.fkCatRawMaterial = crml.idCatRawMaterial
      INNER JOIN CatRecipe cre
        ON drrml.fkCatRecipe = cre.idCatRecipe
      INNER JOIN HelperDateToRecipe hdtre
        ON hdtre.fkCatRecipe = cre.idCatRecipe
      WHERE MONTH(hdtre.creationDate) = {month}
    """
    results = db.execute_query(query)
    result_list = []
    for row in results:
      row_dict = {
        'quantityRecipesCreated' : row[0],
        'quantityRawMaterialUsed' : row[1],
        'name' : row[2],
        'quantityWarehouse' : row[3],
        'quantityPackage' : row[4],
        'description' : row[5]
      }
      result_list.append(row_dict)
    db.commit()
    return result_list
  except Exception as e:
    print(f"Error - getRawMaterialByRecipe: {e}")
  finally:
    db.disconnect()
