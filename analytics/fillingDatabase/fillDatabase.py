
from fillingDatabase.fcontrollers.fmainProcessAnalytics import mainProcessAnalytics
from databases.databaseAnalytics import DatabaseAnalytics


def fillDatabase():
  db = DatabaseAnalytics()
  query = "DELETE FROM Graphic;"
  db.manipulate_data(query)
  db.commit()
  print('Database restarted')

  moths = [5, 6, 7]
  for month in moths:
    mainProcessAnalytics(month)
  print('End of filling process')
