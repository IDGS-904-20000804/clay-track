
def main():
  try:
    cursor = conn.cursor()
    query = "SELECT * FROM CatSale"
    cursor.execute(query)
    results = cursor.fetchall()
    for row in results:
      print(row)
    conn.commit()
    cursor.close()
  except Exception as e:
    print(f"Error: {e}")
  finally:
    conn.close()


if __name__ == "__main__":
  main()
