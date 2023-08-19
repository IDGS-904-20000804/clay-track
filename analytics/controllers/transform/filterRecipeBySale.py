
from itertools import groupby
from operator import itemgetter
import json


def filterRecipeBySale(rows):
  grouped_results = []
  for row in rows:
    result_row = {
        'descriptionRecipe' : f"{row['nameRecipe']} ({row['abbreviation']}) - {row['ColorList']}",
        'totalRecipes' : row['totalRecipes'],
        'totalProfit' : row['totalProfit'],
        'idCatRecipe' : row['idCatRecipe'],
        'FileName' : row['FileName'],
        'FileExtension' : row['FileExtension'],
        'FileSizeInBytes' : row['FileSizeInBytes'],
        'FilePath' : row['FilePath'] 
    }
    grouped_results.append(result_row)
  return json.dumps(grouped_results)


