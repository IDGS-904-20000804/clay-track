
from databases.databaseMain import DatabaseMain

def getPurchases():
  try:
    db = DatabaseMain()
    query = """
    SELECT 
      cpe.idCatPurchase,
      cpe.total,
      cpe.creationDate AS creationDateCatPurchase,
      cpe.updateDate AS updateDateCatPurchase,
      csr.idCatSupplier,
      csr.email,
      cpn.idCatPerson,
      cpn.name,
      cpn.lastName,
      cpn.middleName,
      cpn.phone,
      cpn.postalCode,
      cpn.streetNumber,
      cpn.apartmentNumber,
      cpn.street,
      cpn.neighborhood,
      cpn.creationDate AS creationDateCatPerson,
      cpn.updateDate AS updateDateCatPerson
    FROM CatPurchase cpe
    INNER JOIN CatSupplier csr
      ON cpe.fkCatSupplier = csr.idCatSupplier
    INNER JOIN CatPerson cpn
      ON csr.fkCatPerson = cpn.idCatPerson
    WHERE DATEADD(MONTH, DATEDIFF(MONTH, 0, cpe.creationDate), 0) = DATEADD(MONTH, DATEDIFF(MONTH, 0, getdate()), 0);
    """
    results = db.execute_query(query)
    result_list = []
    for row in results:
      row_dict = {
        'idCatPurchase' : row[0],
        'total' : row[1],
        'creationDateCatPurchase' : row[2],
        'updateDateCatPurchase' : row[3],
        'idCatSupplier' : row[4],
        'email' : row[5],
        'idCatPerson' : row[6],
        'name' : row[7],
        'lastName' : row[8],
        'middleName' : row[9],
        'phone' : row[10],
        'postalCode' : row[11],
        'streetNumber' : row[12],
        'apartmentNumber' : row[13],
        'street' : row[14],
        'neighborhood' : row[15],
        'creationDateCatPerson' : row[16],
        'updateDateCatPerson' : row[17]
      }
      result_list.append(row_dict)
    db.commit()
    return result_list
  except Exception as e:
    print(f"Error: {e}")
  finally:
    db.disconnect()
