
from controllers.extract.getSalesByClient import getSalesByClient
from controllers.extract.getPurchasesBySupplier import getPurchasesBySupplier
from controllers.extract.getRawMaterialByRecipe import getRawMaterialByRecipe
from controllers.extract.getRecipeBySale import getRecipeBySale

from controllers.transform.filterSalesByClient import filterSalesByClient
from controllers.transform.filterPurchasesBySupplier import filterPurchasesBySupplier
from controllers.transform.filterRawMaterialsByRecipe import filterRawMaterialsByRecipe
from controllers.transform.filterRecipeBySale import filterRecipeBySale

from controllers.load.saveSalesByClient import saveSalesByClient
from controllers.load.savePurchasesBySupplier import savePurchasesBySupplier
from controllers.load.saveRawMaterialsByRecipe import saveRawMaterialsByRecipe
from controllers.load.saveRecipeBySale import saveRecipeBySale


# Best client
def startProcessSalesByClient(allTime = False):
  result_get = getSalesByClient(allTime)
  result_filter = filterSalesByClient(result_get)
  saveSalesByClient(result_filter, allTime)


# Best supplier
def startProcessPurchasesBySupplier(allTime = False):
  result_get = getPurchasesBySupplier(allTime)
  result_filter = filterPurchasesBySupplier(result_get)
  savePurchasesBySupplier(result_filter, allTime)


# Best raw material
def startProcessRawMaterialsByRecipe(allTime = False):
  result_get = getRawMaterialByRecipe(allTime)
  result_filter = filterRawMaterialsByRecipe(result_get)
  saveRawMaterialsByRecipe(result_filter, allTime)


# Best recipe
def startProcessRecipeBySale(allTime = False):
  result_get = getRecipeBySale(allTime)
  result_filter = filterRecipeBySale(result_get)
  saveRecipeBySale(result_filter, allTime)


def mainProcessAnalytics():
  startProcessSalesByClient()
  startProcessPurchasesBySupplier()
  startProcessRawMaterialsByRecipe()
  startProcessRecipeBySale()
  
  startProcessSalesByClient(True)
  startProcessPurchasesBySupplier(True)
  startProcessRawMaterialsByRecipe(True)
  startProcessRecipeBySale(True)