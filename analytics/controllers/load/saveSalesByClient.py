
from databases.databaseAnalytics import DatabaseAnalytics


def saveSalesByClient(json):
  try:
    db = DatabaseAnalytics()
    query = f"INSERT INTO Graphic (result, type, date) VALUES ('{json}', 'SalesByClient', GETDATE());"
    db.manipulate_data(query)
    db.commit()
  except Exception as e:
    print(f"Error - saveSalesByClient: {e}")
  finally:
    db.disconnect()

