
from databases.databaseAnalytics import DatabaseAnalytics


def saveRecipeBySale(json, month):
  try:
    db = DatabaseAnalytics()
    storedProc = "EXEC procedureGraphicFilling @json = ?, @type = ?, @month = ?"
    params = (json, 'RecipesBySale', month)
    db.executeProcedure(storedProc, params)
    db.commit()
    print('Saved RecipesBySale')
  except Exception as e:
    print(f"Error - saveRecipeBySale: {e}")
  finally:
    db.disconnect()

