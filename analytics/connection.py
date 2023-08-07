import pyodbc

def getConnection:
  server = 'DESKTOP-003C2SH'
  database = 'ClayTrack'
  conn = pyodbc.connect(
    f'DRIVER=SQL Server;'
    f'SERVER={server};'
    f'DATABASE={database};'
    f'Trusted_Connection=yes;'
  )
  return conn
