
from databases.databaseAnalytics import DatabaseAnalytics


def savePurchasesBySupplier(json, month):
  try:
    db = DatabaseAnalytics()
    storedProc = "EXEC procedureGraphicFilling @json = ?, @type = ?, @month = ?"
    params = (json, 'PurchasesBySupplier', month)
    db.executeProcedure(storedProc, params)
    db.commit()
    print('Saved PurchasesBySupplier')
  except Exception as e:
    print(f"Error - savePurchasesBySupplier: {e}")
  finally:
    db.disconnect()

