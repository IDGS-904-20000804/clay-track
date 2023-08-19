
from databases.databaseAnalytics import DatabaseAnalytics


def saveRawMaterialsByRecipe(json, month):
  try:
    db = DatabaseAnalytics()
    storedProc = "EXEC procedureGraphicFilling @json = ?, @type = ?, @month = ?"
    params = (json, 'RawMaterialsByRecipe', month)
    db.executeProcedure(storedProc, params)
    db.commit()
    print('Saved RawMaterialsByRecipe')
  except Exception as e:
    print(f"Error - saveRawMaterialsByRecipe: {e}")
  finally:
    db.disconnect()

