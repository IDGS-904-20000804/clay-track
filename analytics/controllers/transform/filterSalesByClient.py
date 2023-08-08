
from itertools import groupby
from operator import itemgetter
import json


# idCatSale
# total
# creationDateCatSale
# updateDateCatSale
# idCatClient
# name lastName middleName (UserName)
def filterSalesByClient(rows):
  grouped_results = []
  for key, group in groupby(rows, key=itemgetter('idCatClient')):
    group_list = list(group)
    total_sales = sum(row['total'] for row in group_list)
    purchase_count = len(group_list)
    first_row = group_list[0]
    result_row = {
      'purchaseCount': purchase_count,
      'totalSales': total_sales,
      'UserName': first_row['UserName'],
      'name': first_row['name'],
      'lastName': first_row['lastName'],
      'middleName': first_row['middleName']
    }
    grouped_results.append(result_row)
  return json.dumps(grouped_results)


