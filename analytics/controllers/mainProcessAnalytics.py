
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
def startProcessSalesByClient():
  result_get = getSalesByClient()
  result_filter = filterSalesByClient(result_get)
  saveSalesByClient(result_filter)


# Best supplier
def startProcessPurchasesBySupplier():
  result_get = getPurchasesBySupplier()
  result_filter = filterPurchasesBySupplier(result_get)
  savePurchasesBySupplier(result_filter)


# Best raw material
def startProcessRawMaterialsByRecipe():
  result_get = getRawMaterialByRecipe()
  result_filter = filterRawMaterialsByRecipe(result_get)
  saveRawMaterialsByRecipe(result_filter)


# Best recipe
def startProcessRecipeBySale():
  result_get = getRecipeBySale()
  result_filter = filterRecipeBySale(result_get)
  saveRecipeBySale(result_filter)


def mainProcessAnalytics():
  startProcessSalesByClient()
  startProcessPurchasesBySupplier()
  startProcessRawMaterialsByRecipe()
  startProcessRecipeBySale()