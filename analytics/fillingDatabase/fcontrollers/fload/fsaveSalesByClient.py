
from databases.databaseAnalytics import DatabaseAnalytics


def saveSalesByClient(json, month):
  try:
    db = DatabaseAnalytics()
    storedProc = "EXEC procedureGraphicFilling @json = ?, @type = ?, @month = ?"
    params = (json, 'SalesByClient', month)
    db.executeProcedure(storedProc, params)
    db.commit()
    print('Saved SalesByClient')
  except Exception as e:
    print(f"Error - saveSalesByClient: {e}")
  finally:
    db.disconnect()

