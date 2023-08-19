
from databases.databaseAnalytics import DatabaseAnalytics


def saveRecipeBySale(json, allTime):
  try:
    db = DatabaseAnalytics()
    storedProc = "EXEC procedureGraphic @json = ?, @type = ?, @allTime = ?"
    params = (json, 'RecipesBySale', allTime)
    db.executeProcedure(storedProc, params)
    db.commit()
    print('Saved RecipesBySale ' + ('by all time' if allTime else 'by month'))
  except Exception as e:
    print(f"Error - saveRecipeBySale: {e}")
  finally:
    db.disconnect()

