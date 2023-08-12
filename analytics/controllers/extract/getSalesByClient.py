
from databases.databaseMain import DatabaseMain

def getSalesByClient(allTime):
  try:
    db = DatabaseMain()
    query = f"""
    SELECT 
      cse.idCatSale,
      cse.total,
      cse.creationDate AS creationDateCatSale,
      cse.updateDate AS updateDateCatSale,
      csr.idCatClient,
      aspnetu.Id,
      aspnetu.UserName,
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
    FROM CatSale cse
    INNER JOIN CatClient csr
      ON cse.fkCatClient = csr.idCatClient
    INNER JOIN CatPerson cpn
      ON csr.fkCatPerson = cpn.idCatPerson
    INNER JOIN AspNetUsers aspnetu
      ON aspnetu.Id = csr.fkUser 
    {'' if allTime
      else 'WHERE cse.creationDate >= DATEADD(DAY, -30, GETDATE());'
    }
    """
    results = db.execute_query(query)
    result_list = []
    for row in results:
      row_dict = {
        'idCatSale' : row[0],
        'total' : row[1],
        'creationDateCatSale' : row[2],
        'updateDateCatSale' : row[3],
        'idCatClient' : row[4],
        'Id' : row[5],
        'UserName' : row[6],
        'idCatPerson' : row[7],
        'name' : row[8],
        'lastName' : row[9],
        'middleName' : row[10],
        'phone' : row[11],
        'postalCode' : row[12],
        'streetNumber' : row[13],
        'apartmentNumber' : row[14],
        'street' : row[15],
        'neighborhood' : row[16],
        'creationDateCatPerson' : row[17],
        'updateDateCatPerson' : row[18]
      }
      result_list.append(row_dict)
    db.commit()
    return result_list
  except Exception as e:
    print(f"Error - getSalesByClient: {e}")
  finally:
    db.disconnect()
