
from itertools import groupby
from operator import itemgetter
import json


def filterRawMaterialsByRecipe(rows):
  grouped_results = []
  for row in rows:
    result_row = {
        'totalQuantityRawMaterialUsed' : row['quantityRecipesCreated'] * row['quantityRawMaterialUsed'],
        'name' : row['name'],
        'quantityWarehouse' : row['quantityWarehouse'],
        'quantityPackage' : row['quantityPackage'],
        'description' : row['description']
    }
    grouped_results.append(result_row)
  return json.dumps(grouped_results)
