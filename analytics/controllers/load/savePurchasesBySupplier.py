
from databases.databaseAnalytics import DatabaseAnalytics


def savePurchasesBySupplier(json):
  try:
    db = DatabaseAnalytics()
    query = f"INSERT INTO Graphic (result, type, date) VALUES ('{json}', 'PurchasesBySupplier', GETDATE());"
    db.manipulate_data(query)
    db.commit()
  except Exception as e:
    print(f"Error: {e}")
  finally:
    db.disconnect()

