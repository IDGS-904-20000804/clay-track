USE master;
GO
IF EXISTS (SELECT * FROM sys.databases WHERE name = N'ClayTrack') DROP DATABASE ClayTrack;
GO
CREATE DATABASE ClayTrack;
GO
USE ClayTrack;
GO
CREATE TABLE CatUnitMeasure (
  idCatUnitMeasure INT IDENTITY(1,1) PRIMARY KEY,
  description VARCHAR(255) NOT NULL,
  status BIT DEFAULT 1 NOT NULL,
  creationDate DATETIME NOT NULL DEFAULT GETDATE(),
  updateDate DATETIME NOT NULL DEFAULT GETDATE()
);
GO
CREATE TABLE CatRawMaterial (
  idCatRawMaterial INT IDENTITY(1,1) PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  quantityWarehouse INT NOT NULL,
  status BIT DEFAULT 1 NOT NULL,
  creationDate DATETIME NOT NULL DEFAULT GETDATE(),
  updateDate DATETIME NOT NULL DEFAULT GETDATE(),
  fkCatUnitMeasure INT NOT NULL
);
GO
CREATE TABLE CatRole (
  idCatRole INT IDENTITY(1,1) PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  status BIT DEFAULT 1 NOT NULL,
  creationDate DATETIME NOT NULL DEFAULT GETDATE(),
  updateDate DATETIME NOT NULL DEFAULT GETDATE()
);
GO
CREATE TABLE CatUser (
  idCatUser INT IDENTITY(1,1) PRIMARY KEY,
  email VARCHAR(255) NOT NULL,
  password VARCHAR(255) NOT NULL,
  status BIT DEFAULT 1 NOT NULL,
  creationDate DATETIME NOT NULL DEFAULT GETDATE(),
  updateDate DATETIME NOT NULL DEFAULT GETDATE()
);
GO
CREATE TABLE DetailRoleUser (
  idDetailRoleUser INT IDENTITY(1,1) PRIMARY KEY,
  fkCatUser INT NOT NULL,
  fkCatRole INT NOT NULL
);
GO
CREATE TABLE CatPerson (
  idCatPerson INT IDENTITY(1,1) PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  lastName VARCHAR(255) NOT NULL,
  middleName VARCHAR(255),
  phone VARCHAR(255) NOT NULL,
  postalCode INT NOT NULL,
  streetNumber VARCHAR(255) NOT NULL,
  apartmentNumber VARCHAR(255),
  street VARCHAR(255) NOT NULL,
  neighborhood VARCHAR(255) NOT NULL,
  status BIT DEFAULT 1 NOT NULL,
  creationDate DATETIME NOT NULL DEFAULT GETDATE(),
  updateDate DATETIME NOT NULL DEFAULT GETDATE()
);
GO
CREATE TABLE CatClient (
  idCatClient INT IDENTITY(1,1) PRIMARY KEY,
  fkCatPerson INT NOT NULL,
  fkCatUser INT NOT NULL
);
GO
CREATE TABLE CatSupplier (
  idCatSupplier INT IDENTITY(1,1) PRIMARY KEY,
  email VARCHAR(255) NOT NULL,
  fkCatPerson INT NOT NULL
);
GO
CREATE TABLE CatEmployee (
  idCatEmployee INT IDENTITY(1,1) PRIMARY KEY,
  fkCatPerson INT NOT NULL,
  fkCatUser INT NOT NULL
);
GO
CREATE TABLE CatPurchase (
  idCatPurchase INT IDENTITY(1,1) PRIMARY KEY,
  total FLOAT NOT NULL,
  creationDate DATETIME NOT NULL DEFAULT GETDATE(),
  updateDate DATETIME NOT NULL DEFAULT GETDATE(),
  fkCatSupplier INT NOT NULL,
  fkCatEmployee INT NOT NULL
);
GO
CREATE TABLE DetailPurchase (
  idDetailPurchase INT IDENTITY(1,1) PRIMARY KEY,
  quantity FLOAT NOT NULL,
  price FLOAT NOT NULL,
  fkCatRawMaterial INT NOT NULL,
  fkCatPurchase INT NOT NULL
);
GO
CREATE TABLE CatRecipe (
  idCatRecipe INT IDENTITY(1,1) PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  price FLOAT NOT NULL,
  imagePath VARCHAR(255) NOT NULL,
  status BIT DEFAULT 1 NOT NULL,
  creationDate DATETIME NOT NULL DEFAULT GETDATE(),
  updateDate DATETIME NOT NULL DEFAULT GETDATE()
);
GO
CREATE TABLE DetailRecipeRawMaterial (
  idDetailRecipeRawMaterial INT IDENTITY(1,1) PRIMARY KEY,
  fkCatRecipe INT NOT NULL,
  quantity FLOAT NOT NULL,
  fkCatRawMaterial INT NOT NULL
);
GO
CREATE TABLE CatStock (
  idCatStock INT IDENTITY(1,1) PRIMARY KEY,
  quantity INT NOT NULL,
  price FLOAT NOT NULL,
  status BIT DEFAULT 1 NOT NULL,
  creationDate DATETIME NOT NULL DEFAULT GETDATE(),
  updateDate DATETIME NOT NULL DEFAULT GETDATE(),
  fkCatRecipe INT NOT NULL
);
GO
CREATE TABLE CatSale (
  idCatSale INT IDENTITY(1,1) PRIMARY KEY,
  total FLOAT NOT NULL,
  creationDate DATETIME NOT NULL DEFAULT GETDATE(),
  updateDate DATETIME NOT NULL DEFAULT GETDATE(),
  fkCatClient INT NOT NULL
);
GO
CREATE TABLE DetailSale (
  idDetailSale INT IDENTITY(1,1) PRIMARY KEY,
  quantity FLOAT NOT NULL,
  price FLOAT NOT NULL,
  fkCatStock INT NOT NULL,
  fkCatSale INT NOT NULL
);
GO
CREATE TABLE CatShipment (
  idCatShipment INT IDENTITY(1,1) PRIMARY KEY,
  delivered BIT NOT NULL DEFAULT 0,
  creationDate DATETIME NOT NULL DEFAULT GETDATE(),
  updateDate DATETIME NOT NULL DEFAULT GETDATE(),
  fkCatSale INT NOT NULL,
  fkCatEmployee INT
);
GO

ALTER TABLE CatRawMaterial ADD CONSTRAINT FK_CatRawMaterial_CatUnitMeasure FOREIGN KEY (fkCatUnitMeasure) REFERENCES CatUnitMeasure(idCatUnitMeasure);
ALTER TABLE DetailRoleUser ADD CONSTRAINT FK_DetailRoleUser_CatUser FOREIGN KEY (fkCatUser) REFERENCES CatUser(idCatUser);
ALTER TABLE DetailRoleUser ADD CONSTRAINT FK_DetailRoleUser_CatRole FOREIGN KEY (fkCatRole) REFERENCES CatRole(idCatRole);
ALTER TABLE CatClient ADD CONSTRAINT FK_CatClient_CatPerson FOREIGN KEY (fkCatPerson) REFERENCES CatPerson(idCatPerson);
ALTER TABLE CatClient ADD CONSTRAINT FK_CatClient_CatUser FOREIGN KEY (fkCatUser) REFERENCES CatUser(idCatUser);
ALTER TABLE CatSupplier ADD CONSTRAINT FK_CatSupplier_CatPerson FOREIGN KEY (fkCatPerson) REFERENCES CatPerson(idCatPerson);
ALTER TABLE CatEmployee ADD CONSTRAINT FK_CatEmployee_CatPerson FOREIGN KEY (fkCatPerson) REFERENCES CatPerson(idCatPerson);
ALTER TABLE CatEmployee ADD CONSTRAINT FK_CatEmployee_CatUser FOREIGN KEY (fkCatUser) REFERENCES CatUser(idCatUser);
ALTER TABLE CatPurchase ADD CONSTRAINT FK_CatPurchase_CatSupplier FOREIGN KEY (fkCatSupplier) REFERENCES CatSupplier(idCatSupplier);
ALTER TABLE CatPurchase ADD CONSTRAINT FK_CatPurchase_CatEmployee FOREIGN KEY (fkCatEmployee) REFERENCES CatEmployee(idCatEmployee);
ALTER TABLE DetailPurchase ADD CONSTRAINT FK_DetailPurchase_CatRawMaterial FOREIGN KEY (fkCatRawMaterial) REFERENCES CatRawMaterial(idCatRawMaterial);
ALTER TABLE DetailPurchase ADD CONSTRAINT FK_DetailPurchase_CatPurchase FOREIGN KEY (fkCatPurchase) REFERENCES CatPurchase(idCatPurchase);
ALTER TABLE DetailRecipeRawMaterial ADD CONSTRAINT FK_DetailRecipeRawMaterial_CatRecipe FOREIGN KEY (fkCatRecipe) REFERENCES CatRecipe(idCatRecipe);
ALTER TABLE DetailRecipeRawMaterial ADD CONSTRAINT FK_DetailRecipeRawMaterial_CatRawMaterial FOREIGN KEY (fkCatRawMaterial) REFERENCES CatRawMaterial(idCatRawMaterial);
ALTER TABLE CatStock ADD CONSTRAINT FK_CatStock_CatRecipe FOREIGN KEY (fkCatRecipe) REFERENCES CatRecipe(idCatRecipe);
ALTER TABLE DetailSale ADD CONSTRAINT FK_DetailSale_CatStock FOREIGN KEY (fkCatStock) REFERENCES CatStock(idCatStock);
ALTER TABLE DetailSale ADD CONSTRAINT FK_DetailSale_CatSale FOREIGN KEY (fkCatSale) REFERENCES CatSale(idCatSale);
ALTER TABLE CatSale ADD CONSTRAINT FK_CatSale_CatClient FOREIGN KEY (fkCatClient) REFERENCES CatClient(idCatClient);
ALTER TABLE CatShipment ADD CONSTRAINT FK_CatShipment_CatSale FOREIGN KEY (fkCatSale) REFERENCES CatSale(idCatSale);
ALTER TABLE CatShipment ADD CONSTRAINT FK_CatShipment_CatEmployee FOREIGN KEY (fkCatEmployee) REFERENCES CatEmployee(idCatEmployee);

INSERT INTO CatPerson(name, lastName, middleName, phone, postalCode, streetNumber, apartmentNumber, street, neighborhood) VALUES ('Olatz','Puerto','Trujillo','+514778852126','37138','704','','Lucita','Gran Jardín');
INSERT INTO CatPerson(name, lastName, middleName, phone, postalCode, streetNumber, apartmentNumber, street, neighborhood) VALUES ('Raúl','Avila','Palacios','+514771181062','37353','821','B','Calle Efraín Calderón','Pedregal del Sol');
INSERT INTO CatPerson(name, lastName, middleName, phone, postalCode, streetNumber, apartmentNumber, street, neighborhood) VALUES ('Neus','Villar','Villar','+514775395135','37548','548','B','Calle Sarmiento','Luz del Refugio');
INSERT INTO CatPerson(name, lastName, middleName, phone, postalCode, streetNumber, apartmentNumber, street, neighborhood) VALUES ('Rachid','Ubeda','Mosquera','+514771985903','37550','188','B','Lucita','Cumbres de la Pradera');
INSERT INTO CatPerson(name, lastName, middleName, phone, postalCode, streetNumber, apartmentNumber, street, neighborhood) VALUES ('Claudio','Leon','Alcantara','+514778900172','37295','696','','Calle Bosque Del Carajonai','Jardines de San Juan');
INSERT INTO CatPerson(name, lastName, middleName, phone, postalCode, streetNumber, apartmentNumber, street, neighborhood) VALUES ('Manel','Cardona','Moyano','+514778148765','37530','243','','Calle Parque Guatemala','Residencial San Isidro');
INSERT INTO CatPerson(name, lastName, middleName, phone, postalCode, streetNumber, apartmentNumber, street, neighborhood) VALUES ('Catalina','Guevara','Quiroga','+514770482841','37210','200','A','Calle San Matías','Praderas de Santa Rosa');
INSERT INTO CatPerson(name, lastName, middleName, phone, postalCode, streetNumber, apartmentNumber, street, neighborhood) VALUES ('Aurea','Lazaro','Miranda','+514773943080','37280','220','B','Calle Bosque Del Carajonai','Arboledas de San Pedro');
INSERT INTO CatPerson(name, lastName, middleName, phone, postalCode, streetNumber, apartmentNumber, street, neighborhood) VALUES ('Gumersindo','Moro','Peiro','+514778190823','37680','291','','Calle Campo Verde','Álvaro Obregón (Santa Ana del Conde)');
INSERT INTO CatPerson(name, lastName, middleName, phone, postalCode, streetNumber, apartmentNumber, street, neighborhood) VALUES ('Josefa','Robledo','Robledo','+514773750303','37238','778','C','Calle Mar Jónico','Prado Hermoso');
INSERT INTO CatPerson(name, lastName, middleName, phone, postalCode, streetNumber, apartmentNumber, street, neighborhood) VALUES ('Eladio','Peiro','Tirado','+514775263673','37357','272','','Andador De La Esponja','Centro Familiar Soledad');
INSERT INTO CatPerson(name, lastName, middleName, phone, postalCode, streetNumber, apartmentNumber, street, neighborhood) VALUES ('Alain','Grande','Fernández','+514777837646','37207','230','','Calle Noria De Los Pedregales','El Consuelo');
INSERT INTO CatPerson(name, lastName, middleName, phone, postalCode, streetNumber, apartmentNumber, street, neighborhood) VALUES ('Marcial','García','Puerto','+514775653880','37538','916','B','Privada San Anselmo','Loma Hermosa');
INSERT INTO CatPerson(name, lastName, middleName, phone, postalCode, streetNumber, apartmentNumber, street, neighborhood) VALUES ('Izaskun','Sanchez','Grande','+514775519653','37299','712','A','Privada Cervera','Soberna');
INSERT INTO CatPerson(name, lastName, middleName, phone, postalCode, streetNumber, apartmentNumber, street, neighborhood) VALUES ('Montse','Cantero','Herranz','+514777954784','37204','840','','Calle 18','Cibeles');
INSERT INTO CatPerson(name, lastName, middleName, phone, postalCode, streetNumber, apartmentNumber, street, neighborhood) VALUES ('Sagrario','Moyano','Martin','+514777834299','37419','329','','Calle De La Col','Las Mandarinas');
INSERT INTO CatPerson(name, lastName, middleName, phone, postalCode, streetNumber, apartmentNumber, street, neighborhood) VALUES ('Zaida','Cuadrado','Garrido','+514776424326','37669','134','B','León','Los Laureles');
INSERT INTO CatPerson(name, lastName, middleName, phone, postalCode, streetNumber, apartmentNumber, street, neighborhood) VALUES ('Cayetano','Estrada','Sanchez','+514778884326','37287','610','','Lucita','Residencial San Ángel');
INSERT INTO CatPerson(name, lastName, middleName, phone, postalCode, streetNumber, apartmentNumber, street, neighborhood) VALUES ('Iris','Marin','Ubeda','+514771149094','37549','265','','San Carlos','Unión Obrera');
INSERT INTO CatPerson(name, lastName, middleName, phone, postalCode, streetNumber, apartmentNumber, street, neighborhood) VALUES ('Francisco-Javier','Gaspar','Avila','+514777710708','37128','773','','Mayorazgo De Taboalapa','Misión La Cañada');
INSERT INTO CatPerson(name, lastName, middleName, phone, postalCode, streetNumber, apartmentNumber, street, neighborhood) VALUES ('Iryna','Fernández','Valero','+514775088347','37555','547','B','Boulevard Paseo De Los Insurgentes','San José de Cementos');
INSERT INTO CatPerson(name, lastName, middleName, phone, postalCode, streetNumber, apartmentNumber, street, neighborhood) VALUES ('Noel','Mosquera','Estrada','+514772665826','37670','142','C','Calle Parque La Granada','La Laborcita');
INSERT INTO CatPerson(name, lastName, middleName, phone, postalCode, streetNumber, apartmentNumber, street, neighborhood) VALUES ('Hilario','Alcantara','Moyano','+514773103141','37210','873','','Calle San Florencio','Residencial Villa Contemporánea');
INSERT INTO CatPerson(name, lastName, middleName, phone, postalCode, streetNumber, apartmentNumber, street, neighborhood) VALUES ('Florin','Beltran','Rivera','+514772280363','37689','402','','Ramal A San Pedro Del Monte','Capellanía de San Sebastián');
INSERT INTO CatPerson(name, lastName, middleName, phone, postalCode, streetNumber, apartmentNumber, street, neighborhood) VALUES ('German','Rivera','Alcantara','+514777270751','37669','453','A','Boulevard Delta','Katania');
INSERT INTO CatPerson(name, lastName, middleName, phone, postalCode, streetNumber, apartmentNumber, street, neighborhood) VALUES ('Unax','Verdu','Yañez','+514772750921','37355','784','C','Calle Mezquite De Jerez','Real 2000');
INSERT INTO CatPerson(name, lastName, middleName, phone, postalCode, streetNumber, apartmentNumber, street, neighborhood) VALUES ('Unai','Hidalgo','Felipe','+514774175683','37278','839','','Calle Bosque Del Ocote','Popular Inca');
INSERT INTO CatPerson(name, lastName, middleName, phone, postalCode, streetNumber, apartmentNumber, street, neighborhood) VALUES ('Fabian','Quiroga','Ubeda','+514771294823','37288','207','C','Calle Santa Crocce','Villa Verde');
INSERT INTO CatPerson(name, lastName, middleName, phone, postalCode, streetNumber, apartmentNumber, street, neighborhood) VALUES ('Maria-Francisca','Cabanillas','García','+514775152672','37259','751','','Calle Paseo De Los Verdines','San Manuel');
INSERT INTO CatPerson(name, lastName, middleName, phone, postalCode, streetNumber, apartmentNumber, street, neighborhood) VALUES ('Narciso','Reyes','Verdu','+514775894018','37687','516','C','Chupicuaro','La Estancia de la Sandía');
INSERT INTO CatPerson(name, lastName, middleName, phone, postalCode, streetNumber, apartmentNumber, street, neighborhood) VALUES ('Anibal','Garrido','Valero','+514773509338','37125','452','','Calle Paraíso','Fracciones del Rosario');
INSERT INTO CatPerson(name, lastName, middleName, phone, postalCode, streetNumber, apartmentNumber, street, neighborhood) VALUES ('Jeronima','Tirado','Martorell','+514775794020','37118','357','A','Calle Del Narciso','Jardines del Valle');
INSERT INTO CatPerson(name, lastName, middleName, phone, postalCode, streetNumber, apartmentNumber, street, neighborhood) VALUES ('Segundo','Martin','Gaspar','+514773680309','37555','126','','Calle Industrial Morelos','Praderas del Bosque');
INSERT INTO CatPerson(name, lastName, middleName, phone, postalCode, streetNumber, apartmentNumber, street, neighborhood) VALUES ('Julia','Yañez','Gaspar','+514779839014','37328','756','','Valeriana','Moderna');
INSERT INTO CatPerson(name, lastName, middleName, phone, postalCode, streetNumber, apartmentNumber, street, neighborhood) VALUES ('Leire','Martorell','Fernández','+514777531816','37100','836','','Boulevard Antonio Martínez Aguayo','Privada Echeveste');
INSERT INTO CatPerson(name, lastName, middleName, phone, postalCode, streetNumber, apartmentNumber, street, neighborhood) VALUES ('Estibaliz','Iglesias','Guevara','+514779590896','37438','675','','Calle Mayorazgo Del Moral','Industrial Pamplona');
INSERT INTO CatPerson(name, lastName, middleName, phone, postalCode, streetNumber, apartmentNumber, street, neighborhood) VALUES ('Rachida','Ojeda','Moyano','+514776530629','37204','685','','Privada Monte Catredal','San Jerónimo I');
INSERT INTO CatPerson(name, lastName, middleName, phone, postalCode, streetNumber, apartmentNumber, street, neighborhood) VALUES ('Alexandra','Felipe','Cardona','+514771351404','37278','851','','Calle Campo Verde','Popular Inca');
INSERT INTO CatPerson(name, lastName, middleName, phone, postalCode, streetNumber, apartmentNumber, street, neighborhood) VALUES ('Angelica','Palacios','Garrido','+514775834999','37440','642','','Calle Comensalismo','La Piscina');
INSERT INTO CatPerson(name, lastName, middleName, phone, postalCode, streetNumber, apartmentNumber, street, neighborhood) VALUES ('Markel','Maroto','San-Juan','+514774803876','37538','140','','Circuito Jardín Río Ganges','Valle Delta');
INSERT INTO CatPerson(name, lastName, middleName, phone, postalCode, streetNumber, apartmentNumber, street, neighborhood) VALUES ('Marcelina','Megias','Verdu','+514772948144','37123','929','C','Calle Nueva Betania','Bosques del Refugio');
INSERT INTO CatPerson(name, lastName, middleName, phone, postalCode, streetNumber, apartmentNumber, street, neighborhood) VALUES ('Alberto','Marques','Maroto','+514777942094','37353','634','','San José Del Oriente','Chalet La Cumbre');
INSERT INTO CatPerson(name, lastName, middleName, phone, postalCode, streetNumber, apartmentNumber, street, neighborhood) VALUES ('Roger','Barrientos','Cardona','+514777707697','37358','919','','Chupa Rosa','Country del Lago');
INSERT INTO CatPerson(name, lastName, middleName, phone, postalCode, streetNumber, apartmentNumber, street, neighborhood) VALUES ('Alina','Trujillo','Trujillo','+514777746510','37270','591','','Privada Arroyo Marino','Rincón de Bugambilias');
INSERT INTO CatPerson(name, lastName, middleName, phone, postalCode, streetNumber, apartmentNumber, street, neighborhood) VALUES ('Ismail','Valero','Barrientos','+514770562905','37209','340','','Valle De Las Torres','San Gabriel');
INSERT INTO CatPerson(name, lastName, middleName, phone, postalCode, streetNumber, apartmentNumber, street, neighborhood) VALUES ('Ioan','Cardona','Megias','+514770090036','37427','224','C','Calle Bosque Del Ocote','Miguel de Cervantes Saavedra');
INSERT INTO CatPerson(name, lastName, middleName, phone, postalCode, streetNumber, apartmentNumber, street, neighborhood) VALUES ('Enzo','San-Juan','Hidalgo','+514770766647','37148','836','B','Calle Fray Bartolomé Laurel','San Jerónimo II');
INSERT INTO CatPerson(name, lastName, middleName, phone, postalCode, streetNumber, apartmentNumber, street, neighborhood) VALUES ('Gertrudis','Miranda','Herranz','+514772207314','37547','852','','Circuito Virgen Loreto','Marbella II');
INSERT INTO CatPerson(name, lastName, middleName, phone, postalCode, streetNumber, apartmentNumber, street, neighborhood) VALUES ('Nelson','Herranz','Moyano','+514776066123','37438','464','','Calle Los Cimientos','Industrial San Jorge');

