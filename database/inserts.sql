
INSERT INTO CatPurchase (total, fkCatSupplier, fkCatEmployee) VALUES ();
INSERT INTO DetailPurchase (quantity, price, fkCatRawMaterial, fkCatPurchase) VALUES ();

INSERT INTO CatStock (quantity, price, fkCatRecipe) VALUES ();
INSERT INTO CatSale (total, fkCatClient) VALUES ();
INSERT INTO DetailSale (quantity, price, fkCatStock, fkCatSale) VALUES ();

INSERT INTO CatShipment (fkCatSale, fkCatEmployee) VALUES ();
