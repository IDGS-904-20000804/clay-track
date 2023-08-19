
import pyodbc


class DatabaseMain:
  def __init__(self):
    self.server = 'DESKTOP-003C2SH'
    self.database = 'ClayTrack'
    self.conn = None


  def connect(self):
    if not self.conn:
      self.conn = pyodbc.connect(
        f'DRIVER=SQL Server;'
        f'SERVER={self.server};'
        f'DATABASE={self.database};'
        f'Trusted_Connection=yes;'
      )
    return self.conn


  def disconnect(self):
    if self.conn:
      self.conn.close()
      self.conn = None


  def execute_query(self, query):
    conn = self.connect()
    cursor = conn.cursor()
    cursor.execute(query)
    results = cursor.fetchall()
    cursor.close()
    return results


  def commit(self):
    conn = self.connect()
    conn.commit()
