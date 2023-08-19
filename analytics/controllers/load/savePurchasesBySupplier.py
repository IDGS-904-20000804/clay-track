
from databases.databaseAnalytics import DatabaseAnalytics


def savePurchasesBySupplier(json, allTime):
  try:
    db = DatabaseAnalytics()
    storedProc = "EXEC procedureGraphic @json = ?, @type = ?, @allTime = ?"
    params = (json, 'PurchasesBySupplier', allTime)
    db.executeProcedure(storedProc, params)
    db.commit()
    print('Saved PurchasesBySupplier ' + ('by all time' if allTime else 'by month'))
  except Exception as e:
    print(f"Error - savePurchasesBySupplier: {e}")
  finally:
    db.disconnect()

