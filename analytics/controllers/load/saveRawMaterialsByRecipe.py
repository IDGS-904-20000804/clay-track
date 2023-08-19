
from databases.databaseAnalytics import DatabaseAnalytics


def saveRawMaterialsByRecipe(json, allTime):
  try:
    db = DatabaseAnalytics()
    storedProc = "EXEC procedureGraphic @json = ?, @type = ?, @allTime = ?"
    params = (json, 'RawMaterialsByRecipe', allTime)
    db.executeProcedure(storedProc, params)
    db.commit()
    print('Saved RawMaterialsByRecipe ' + ('by all time' if allTime else 'by month'))
  except Exception as e:
    print(f"Error - saveRawMaterialsByRecipe: {e}")
  finally:
    db.disconnect()

