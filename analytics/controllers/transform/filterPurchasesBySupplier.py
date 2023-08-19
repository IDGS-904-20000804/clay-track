
from itertools import groupby
from operator import itemgetter
import json


def filterPurchasesBySupplier(rows):
  grouped_results = []
  for key, group in groupby(rows, key=itemgetter('idCatSupplier')):
    group_list = list(group)
    total_Purchases = sum(row['total'] for row in group_list)
    purchase_count = len(group_list)
    first_row = group_list[0]
    result_row = {
      'purchaseCount': purchase_count,
      'totalPurchases': total_Purchases,
      'name': first_row['name'],
      'lastName': first_row['lastName'],
      'middleName': first_row['middleName']
    }
    grouped_results.append(result_row)
  return json.dumps(grouped_results)
