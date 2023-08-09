
from databases.databaseAnalytics import DatabaseAnalytics


def saveRecipeBySale(json):
  try:
    db = DatabaseAnalytics()
    query = f"INSERT INTO Graphic (result, type, date) VALUES ('{json}', 'RecipesBySale', GETDATE());"
    db.manipulate_data(query)
    db.commit()
  except Exception as e:
    print(f"Error - saveRecipeBySale: {e}")
  finally:
    db.disconnect()

