
from databases.databaseAnalytics import DatabaseAnalytics


def saveRawMaterialsByRecipe(json):
  try:
    db = DatabaseAnalytics()
    query = f"INSERT INTO Graphic (result, type, date) VALUES ('{json}', 'RawMaterialsByRecipe', GETDATE());"
    db.manipulate_data(query)
    db.commit()
  except Exception as e:
    print(f"Error - saveRawMaterialsByRecipe: {e}")
  finally:
    db.disconnect()

