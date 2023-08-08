
from controllers.extract.getSales import getSales
from controllers.extract.getPurchases import getPurchases

from controllers.transform.filterSalesByClient import filterSalesByClient
from controllers.transform.filterPurchasesBySupplier import filterPurchasesBySupplier

from controllers.load.saveSalesByClient import saveSalesByClient
from controllers.load.savePurchasesBySupplier import savePurchasesBySupplier


# Best client
def startProcessSalesByClient():
  result_get = getSales()
  result_filter = filterSalesByClient(result_get)
  saveSalesByClient(result_filter)


# Best supplier
def startProcessPurchasesBySupplier():
  result_get = getPurchases()
  result_filter = filterPurchasesBySupplier(result_get)
  savePurchasesBySupplier(result_filter)


# Best raw material
def startProcessRawMaterialByRecipe():
  result_sales = getSales()


# Best recipe
def startProcessRecipeBySale():
  result_sales = getSales()


def mainProcessAnalytics():
  # startProcessSalesByClient()
  # startProcessPurchasesBySupplier()
  startProcessRawMaterialByRecipe()
  # startProcessRecipeBySale()