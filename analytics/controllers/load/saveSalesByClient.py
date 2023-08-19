
from databases.databaseAnalytics import DatabaseAnalytics


def saveSalesByClient(json, allTime):
  try:
    db = DatabaseAnalytics()
    storedProc = "EXEC procedureGraphic @json = ?, @type = ?, @allTime = ?"
    params = (json, 'SalesByClient', allTime)
    db.executeProcedure(storedProc, params)
    db.commit()
    print('Saved SalesByClient ' + ('by all time' if allTime else 'by month'))
  except Exception as e:
    print(f"Error - saveSalesByClient: {e}")
  finally:
    db.disconnect()

