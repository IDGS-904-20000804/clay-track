
from fillingDatabase.fcontrollers.fextract.fgetSalesByClient import getSalesByClient
from fillingDatabase.fcontrollers.fextract.fgetPurchasesBySupplier import getPurchasesBySupplier
from fillingDatabase.fcontrollers.fextract.fgetRawMaterialByRecipe import getRawMaterialByRecipe
from fillingDatabase.fcontrollers.fextract.fgetRecipeBySale import getRecipeBySale

from fillingDatabase.fcontrollers.ftransform.ffilterSalesByClient import filterSalesByClient
from fillingDatabase.fcontrollers.ftransform.ffilterPurchasesBySupplier import filterPurchasesBySupplier
from fillingDatabase.fcontrollers.ftransform.ffilterRawMaterialsByRecipe import filterRawMaterialsByRecipe
from fillingDatabase.fcontrollers.ftransform.ffilterRecipeBySale import filterRecipeBySale

from fillingDatabase.fcontrollers.fload.fsaveSalesByClient import saveSalesByClient
from fillingDatabase.fcontrollers.fload.fsavePurchasesBySupplier import savePurchasesBySupplier
from fillingDatabase.fcontrollers.fload.fsaveRawMaterialsByRecipe import saveRawMaterialsByRecipe
from fillingDatabase.fcontrollers.fload.fsaveRecipeBySale import saveRecipeBySale


# Best client
def startProcessSalesByClient(month):
  result_get = getSalesByClient(month)
  result_filter = filterSalesByClient(result_get)
  saveSalesByClient(result_filter, month)


# Best supplier
def startProcessPurchasesBySupplier(month):
  result_get = getPurchasesBySupplier(month)
  result_filter = filterPurchasesBySupplier(result_get)
  savePurchasesBySupplier(result_filter, month)


# Best raw material
def startProcessRawMaterialsByRecipe(month):
  result_get = getRawMaterialByRecipe(month)
  result_filter = filterRawMaterialsByRecipe(result_get)
  saveRawMaterialsByRecipe(result_filter, month)


# Best recipe
def startProcessRecipeBySale(month):
  result_get = getRecipeBySale(month)
  result_filter = filterRecipeBySale(result_get)
  saveRecipeBySale(result_filter, month)


def mainProcessAnalytics(month):
  startProcessSalesByClient(month)
  startProcessPurchasesBySupplier(month)
  startProcessRawMaterialsByRecipe(month)
  startProcessRecipeBySale(month)