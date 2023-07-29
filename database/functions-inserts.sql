
CREATE PROCEDURE procedureInsertSize (@description VARCHAR(255), @abbreviation VARCHAR(255))
AS
BEGIN
  INSERT INTO CatSize (description, abbreviation) VALUES (@description, @abbreviation);
END;
GO


EXEC procedureInsertSize 'Chico', 'C';
EXEC procedureInsertSize 'Mediano', 'M';
EXEC procedureInsertSize 'Grande', 'G';
GO


CREATE PROCEDURE procedureInsertColor (@description VARCHAR(255), @hexadecimal VARCHAR(255))
AS
BEGIN
  INSERT INTO CatColor (description, hexadecimal)
    VALUES (@description, @hexadecimal);
END;
GO


EXEC procedureInsertColor 'Blanco', '#FFFFFF';
EXEC procedureInsertColor 'Beige', '#F5F5DC';
EXEC procedureInsertColor 'Gris', '#808080';
EXEC procedureInsertColor 'Marrón', '#A52A2A';
EXEC procedureInsertColor 'Azul', '#0000FF';
EXEC procedureInsertColor 'Verde', '#008000';
EXEC procedureInsertColor 'Red', '#FF0000';
EXEC procedureInsertColor 'Negro', '#000000';
EXEC procedureInsertColor 'Crema', '#FFFDD0';
EXEC procedureInsertColor 'Terracota', '#E2725B';
GO


CREATE PROCEDURE procedureInsertRoles (@name VARCHAR(255))
AS
BEGIN
  INSERT INTO CatRole (name) VALUES (@name);
END;
GO


EXEC procedureInsertRoles 'Cliente';
EXEC procedureInsertRoles 'Empleado';
EXEC procedureInsertRoles 'Atención al cliente';
EXEC procedureInsertRoles 'Director';
EXEC procedureInsertRoles 'Jefe de almacén';
EXEC procedureInsertRoles 'Representante de ventas';
EXEC procedureInsertRoles 'Agente de compras';
EXEC procedureInsertRoles 'Supervisor de producción';
EXEC procedureInsertRoles 'Expedición';
EXEC procedureInsertRoles 'Coordinador de envíos';
EXEC procedureInsertRoles 'Director financiero';
EXEC procedureInsertRoles 'Especialista en marketing';
EXEC procedureInsertRoles 'Inspector de control de calidad';
EXEC procedureInsertRoles 'Administrador';
GO


CREATE PROCEDURE procedureInsertUnitMeasure (@description VARCHAR(255))
AS
BEGIN
  INSERT INTO CatUnitMeasure (description) VALUES (@description);
END;
GO


EXEC procedureInsertUnitMeasure 'Metro';
EXEC procedureInsertUnitMeasure 'Metro cuadrado';
EXEC procedureInsertUnitMeasure 'Gramo';
EXEC procedureInsertUnitMeasure 'Pedazo';
EXEC procedureInsertUnitMeasure 'Mililitro';
EXEC procedureInsertUnitMeasure 'Onza';
EXEC procedureInsertUnitMeasure 'Libra';
EXEC procedureInsertUnitMeasure 'Pulgada';
EXEC procedureInsertUnitMeasure 'Cuarto de galón';
EXEC procedureInsertUnitMeasure 'Galón';
EXEC procedureInsertUnitMeasure 'Docena';
EXEC procedureInsertUnitMeasure 'Colocar';
EXEC procedureInsertUnitMeasure 'Caja';
EXEC procedureInsertUnitMeasure 'Embalar';
EXEC procedureInsertUnitMeasure 'Hoja';
EXEC procedureInsertUnitMeasure 'Rollo';
EXEC procedureInsertUnitMeasure 'Bolsa';
EXEC procedureInsertUnitMeasure 'Envase';
EXEC procedureInsertUnitMeasure 'Caja';
GO


CREATE PROCEDURE procedureInsertDetailRoles (
  @idCatUser INT,
  @jsonRoles NVARCHAR(MAX)
)
AS
BEGIN
  DECLARE @rolesTable TABLE (
    idRole INT
  )
  INSERT INTO @rolesTable (idRole)
    SELECT Value
    FROM OPENJSON(@jsonRoles)
  DECLARE @idRole INT
  DECLARE roleCursor CURSOR FOR
  SELECT idRole FROM @rolesTable
  OPEN roleCursor
  FETCH NEXT FROM roleCursor INTO @idRole
  WHILE @@FETCH_STATUS = 0
  BEGIN
    INSERT INTO DetailRoleUser (fkCatUser, fkCatRole)
    VALUES (@idCatUser, @idRole);
    FETCH NEXT FROM roleCursor INTO @idRole
  END
  CLOSE roleCursor
  DEALLOCATE roleCursor
END;
GO


CREATE PROCEDURE procedureInsertEmployee (
  @name VARCHAR(255),
  @lastName VARCHAR(255),
  @middleName VARCHAR(255),
  @phone VARCHAR(255),
  @postalCode INT,
  @streetNumber VARCHAR(255),
  @apartmentNumber VARCHAR(255),
  @street VARCHAR(255),
  @neighborhood VARCHAR(255),
  @password VARCHAR(255),
  @jsonRoles NVARCHAR(MAX)
)
AS
BEGIN
  DECLARE @idCatPerson INT;
  DECLARE @idCatUser INT;
  DECLARE @email VARCHAR(255);
  INSERT INTO CatPerson (name, lastName, middleName, phone, postalCode, streetNumber, apartmentNumber, street, neighborhood)
  VALUES (@name, @lastName, @middleName, @phone, @postalCode, @streetNumber, @apartmentNumber, @street, @neighborhood);
  SET @idCatPerson = SCOPE_IDENTITY();
  SET @email = (
    SELECT CONCAT(
      UPPER(TRIM(@name)),
      '_',
      RIGHT(TRIM(@lastName), 2),
      CAST(FLOOR(RAND() * 1000) AS NVARCHAR(10)),
      '@gmail.com'
    )
  );
  INSERT INTO CatUser (email, password)
  VALUES (@email, @password);
  SET @idCatUser = SCOPE_IDENTITY();
  INSERT INTO CatEmployee (fkCatPerson, fkCatUser)
  VALUES (@idCatPerson, @idCatUser);
  EXEC procedureInsertDetailRoles @idCatUser, @jsonRoles;
END;
GO


CREATE PROCEDURE procedureInsertClient (
  @name VARCHAR(255),
  @lastName VARCHAR(255),
  @middleName VARCHAR(255),
  @phone VARCHAR(255),
  @postalCode INT,
  @streetNumber VARCHAR(255),
  @apartmentNumber VARCHAR(255),
  @street VARCHAR(255),
  @neighborhood VARCHAR(255),
  @email VARCHAR(255),
  @password VARCHAR(255)
)
AS
BEGIN
  DECLARE @idCatPerson INT;
  DECLARE @idRole INT;
  DECLARE @idCatUser INT;
  INSERT INTO CatPerson (name, lastName, middleName, phone, postalCode, streetNumber, apartmentNumber, street, neighborhood)
  VALUES (@name, @lastName, @middleName, @phone, @postalCode, @streetNumber, @apartmentNumber, @street, @neighborhood);
  SET @idCatPerson = SCOPE_IDENTITY();
  INSERT INTO CatUser (email, password)
  VALUES (@email, @password);
  SET @idCatUser = SCOPE_IDENTITY();
  INSERT INTO CatClient (fkCatPerson, fkCatUser)
  VALUES (@idCatPerson, @idCatUser);
  SET @idRole = (SELECT TOP 1 idCatRole FROM CatRole WHERE name = 'Cliente');
  INSERT INTO DetailRoleUser (fkCatUser, fkCatRole)
    VALUES (@idCatUser, @idRole);
END;
GO


CREATE PROCEDURE procedureInsertSupplier (
  @name VARCHAR(255),
  @lastName VARCHAR(255),
  @middleName VARCHAR(255),
  @phone VARCHAR(255),
  @postalCode INT,
  @streetNumber VARCHAR(255),
  @apartmentNumber VARCHAR(255),
  @street VARCHAR(255),
  @neighborhood VARCHAR(255),
  @email VARCHAR(255)
)
AS
BEGIN
  DECLARE @idCatPerson INT;
  INSERT INTO CatPerson (name, lastName, middleName, phone, postalCode, streetNumber, apartmentNumber, street, neighborhood)
  VALUES (@name, @lastName, @middleName, @phone, @postalCode, @streetNumber, @apartmentNumber, @street, @neighborhood);
  SET @idCatPerson = SCOPE_IDENTITY();
  INSERT INTO CatSupplier (email, fkCatPerson) VALUES (@email, @idCatPerson);
END;
GO


EXEC procedureInsertEmployee 'Olatz','Puerto','Trujillo','+514778852126','37138','704',null,'Lucita','Gran Jardín', 'eL3eB5cB', '[3]';
EXEC procedureInsertEmployee 'Raúl','Avila','Palacios','+514771181062','37353','821','B','Calle Efraín Calderón','Pedregal del Sol', 'nC1hQ3bR', '[4]';
EXEC procedureInsertEmployee 'Neus','Villar','Villar','+514775395135','37548','548','B','Calle Sarmiento','Luz del Refugio', 'eO1fN1mC', '[5]';
EXEC procedureInsertEmployee 'Rachid','Ubeda','Mosquera','+514771985903','37550','188','B','Lucita','Cumbres de la Pradera', 'tH4pB1cE', '[6]';
EXEC procedureInsertEmployee 'Claudio','Leon','Alcantara','+514778900172','37295','696',null,'Calle Bosque Del Carajonai','Jardines de San Juan', 'zC7cU1iE', '[7]';
EXEC procedureInsertEmployee 'Manel','Cardona','Moyano','+514778148765','37530','243',null,'Calle Parque Guatemala','Residencial San Isidro', 'iB1hB4jL', '[8]';
EXEC procedureInsertEmployee 'Catalina','Guevara','Quiroga','+514770482841','37210','200','A','Calle San Matías','Praderas de Santa Rosa', 'qB3kF5cH', '[9]';
EXEC procedureInsertEmployee 'Aurea','Lazaro','Miranda','+514773943080','37280','220','B','Calle Bosque Del Carajonai','Arboledas de San Pedro', 'cS2bD6dI', '[10]';
EXEC procedureInsertEmployee 'Gumersindo','Moro','Peiro','+514778190823','37680','291',null,'Calle Campo Verde','Álvaro Obregón (Santa Ana del Conde)', 'pJ2hJ3rD', '[11]';
EXEC procedureInsertEmployee 'Josefa','Robledo','Robledo','+514773750303','37238','778','C','Calle Mar Jónico','Prado Hermoso', 'bB4bB5rM', '[12]';
EXEC procedureInsertEmployee 'Eladio','Peiro','Tirado','+514775263673','37357','272',null,'Andador De La Esponja','Centro Familiar Soledad', 'cB8eC4bL', '[13]';
EXEC procedureInsertEmployee 'Alain','Grande','Fernández','+514777837646','37207','230',null,'Calle Noria De Los Pedregales','El Consuelo', 'cH1dI2dS', '[14]';
EXEC procedureInsertEmployee 'Marcial','García','Puerto','+514775653880','37538','916','B','Privada San Anselmo','Loma Hermosa', 'cD5hP1kN', '[2]';
EXEC procedureInsertEmployee 'Izaskun','Sanchez','Grande','+514775519653','37299','712','A','Privada Cervera','Soberna', 'vB2wC2oL', '[2]';
EXEC procedureInsertEmployee 'Montse','Cantero','Herranz','+514777954784','37204','840',null,'Calle 18','Cibeles', 'cE2eL2lR', '[2]';
EXEC procedureInsertEmployee 'Sagrario','Moyano','Martin','+514777834299','37419','329',null,'Calle De La Col','Las Mandarinas', 'cE7eM2cG', '[2]';
EXEC procedureInsertEmployee 'Zaida','Cuadrado','Garrido','+514776424326','37669','134','B','León','Los Laureles', 'kE2pF3iI', '[2]';
EXEC procedureInsertEmployee 'Cayetano','Estrada','Sanchez','+514778884326','37287','610',null,'Lucita','Residencial San Ángel', 'iC5hB1q2', '[2]';
EXEC procedureInsertEmployee 'Iris','Marin','Ubeda','+514771149094','37549','265',null,'San Carlos','Unión Obrera', 'gE5iJ1mN', '[2]';
GO

EXEC procedureInsertClient 'Francisco','Gaspar','Avila','+514777710708','37128','773',null,'Mayorazgo De Taboalapa','Misión La Cañada', 'FRANCISCO_la332@gmail.com', 'eC1dC1xE';
EXEC procedureInsertClient 'Iryna','Fernández','Valero','+514775088347','37555','547','B','Boulevard Paseo De Los Insurgentes','San José de Cementos', 'IRYNA_ro349@gmail.com', 'dV2eF4bJ';
EXEC procedureInsertClient 'Noel','Mosquera','Estrada','+514772665826','37670','142','C','Calle Parque La Granada','La Laborcita', 'NOEL_da366@gmail.com', 'b1mB4eP1';
EXEC procedureInsertClient 'Hilario','Alcantara','Moyano','+514773103141','37210','873',null,'Calle San Florencio','Residencial Villa Contemporánea', 'HILARIO_no383@gmail.com', 'gM3bB2lQ';
EXEC procedureInsertClient 'Florin','Beltran','Rivera','+514772280363','37689','402',null,'Ramal A San Pedro Del Monte','Capellanía de San Sebastián', 'FLORIN_ra400@gmail.com', 'iM1jB1qO';
EXEC procedureInsertClient 'German','Rivera','Alcantara','+514777270751','37669','453','A','Boulevard Delta','Katania', 'GERMAN_ra417@gmail.com', 'nI1bL2bP';
EXEC procedureInsertClient 'Unax','Verdu','Yañez','+514772750921','37355','784','C','Calle Mezquite De Jerez','Real 2000', 'UNAX_ez434@gmail.com', 'dO2dM2gB';
EXEC procedureInsertClient 'Unai','Hidalgo','Felipe','+514774175683','37278','839',null,'Calle Bosque Del Ocote','Popular Inca', 'UNAI_pe451@gmail.com', 'cI1jG5cE';
EXEC procedureInsertClient 'Fabian','Quiroga','Ubeda','+514771294823','37288','207','C','Calle Santa Crocce','Villa Verde', 'FABIAN_da468@gmail.com', 'eP3mD1G1';
EXEC procedureInsertClient 'Maria','Cabanillas','García','+514775152672','37259','751',null,'Calle Paseo De Los Verdines','San Manuel', 'MARIA_ia485@gmail.com', 'eI2bB5hB';
EXEC procedureInsertClient 'Narciso','Reyes','Verdu','+514775894018','37687','516','C','Chupicuaro','La Estancia de la Sandía', 'NARCISO_du502@gmail.com', 'lQ1nR1cL';
EXEC procedureInsertClient 'Anibal','Garrido','Valero','+514773509338','37125','452',null,'Calle Paraíso','Fracciones del Rosario', 'ANIBAL_ro519@gmail.com', 'mU1dD3cL';
EXEC procedureInsertClient 'Jeronima','Tirado','Martorell','+514775794020','37118','357','A','Calle Del Narciso','Jardines del Valle', 'JERONIMA_ll536@gmail.com', 'hJ5hD7vF';
EXEC procedureInsertClient 'Segundo','Martin','Gaspar','+514773680309','37555','126',null,'Calle Industrial Morelos','Praderas del Bosque', 'SEGUNDO_ar553@gmail.com', 'bL2hB6bI';
EXEC procedureInsertClient 'Julia','Yañez','Gaspar','+514779839014','37328','756',null,'Valeriana','Moderna', 'JULIA_ar570@gmail.com', 'uN4bH4bE';
EXEC procedureInsertClient 'Leire','Martorell','Fernández','+514777531816','37100','836',null,'Boulevard Antonio Martínez Aguayo','Privada Echeveste', 'LEIRE_ez587@gmail.com', 'eW4lF4hB';
GO

EXEC procedureInsertSupplier 'Estibaliz','Iglesias','Guevara','+514779590896','37438','675',null,'Calle Mayorazgo Del Moral','Industrial Pamplona', 'ESTIBALIZ_ra604@gmail.com';
EXEC procedureInsertSupplier 'Rachida','Ojeda','Moyano','+514776530629','37204','685',null,'Privada Monte Catredal','San Jerónimo I', 'RACHIDA_no621@gmail.com';
EXEC procedureInsertSupplier 'Alexandra','Felipe','Cardona','+514771351404','37278','851',null,'Calle Campo Verde','Popular Inca', 'ALEXANDRA_na638@gmail.com';
EXEC procedureInsertSupplier 'Angelica','Palacios','Garrido','+514775834999','37440','642',null,'Calle Comensalismo','La Piscina', 'ANGELICA_do655@gmail.com';
EXEC procedureInsertSupplier 'Markel','Maroto','San-Juan','+514774803876','37538','140',null,'Circuito Jardín Río Ganges','Valle Delta', 'MARKEL_an672@gmail.com';
EXEC procedureInsertSupplier 'Marcelina','Megias','Verdu','+514772948144','37123','929','C','Calle Nueva Betania','Bosques del Refugio', 'MARCELINA_du689@gmail.com';
EXEC procedureInsertSupplier 'Alberto','Marques','Maroto','+514777942094','37353','634',null,'San José Del Oriente','Chalet La Cumbre', 'ALBERTO_to706@gmail.com';
EXEC procedureInsertSupplier 'Roger','Barrientos','Cardona','+514777707697','37358','919',null,'Chupa Rosa','Country del Lago', 'ROGER_na723@gmail.com';
EXEC procedureInsertSupplier 'Alina','Trujillo','Trujillo','+514777746510','37270','591',null,'Privada Arroyo Marino','Rincón de Bugambilias', 'ALINA_lo740@gmail.com';
EXEC procedureInsertSupplier 'Ismail','Valero','Barrientos','+514770562905','37209','340',null,'Valle De Las Torres','San Gabriel', 'ISMAIL_os757@gmail.com';
EXEC procedureInsertSupplier 'Ioan','Cardona','Megias','+514770090036','37427','224','C','Calle Bosque Del Ocote','Miguel de Cervantes Saavedra', 'IOAN_as774@gmail.com';
EXEC procedureInsertSupplier 'Enzo','San-Juan','Hidalgo','+514770766647','37148','836','B','Calle Fray Bartolomé Laurel','San Jerónimo II', 'ENZO_go791@gmail.com';
EXEC procedureInsertSupplier 'Gertrudis','Miranda','Herranz','+514772207314','37547','852',null,'Circuito Virgen Loreto','Marbella II', 'GERTRUDIS_nz808@gmail.com';
EXEC procedureInsertSupplier 'Nelson','Herranz','Moyano','+514776066123','37438','464',null,'Calle Los Cimientos','Industrial San Jorge', 'NELSON_no825@gmail.com';
GO


CREATE PROCEDURE procedureInsertRawMaterial (
  @name VARCHAR(255),
  @quantityPackage FLOAT,
  @fkCatUnitMeasure INT
)
AS
BEGIN
  INSERT INTO CatRawMaterial (name, quantityPackage, fkCatUnitMeasure) VALUES (@name, @quantityPackage, @fkCatUnitMeasure);
END;
GO


EXEC procedureInsertRawMaterial 'Talco', 20, 3;
EXEC procedureInsertRawMaterial 'Alúmina', 10, 3;
EXEC procedureInsertRawMaterial 'Circonia', 5, 3;
EXEC procedureInsertRawMaterial 'Frita', 50, 3;
EXEC procedureInsertRawMaterial 'Celulosa', 5, 3;
EXEC procedureInsertRawMaterial 'Arcilla de loza', 350, 3;
EXEC procedureInsertRawMaterial 'Arcilla de gres', 350, 3;
EXEC procedureInsertRawMaterial 'Arcilla de porcelana', 350, 3;
EXEC procedureInsertRawMaterial 'Arcilla refractaria', 350, 3;
EXEC procedureInsertRawMaterial 'Arcilla de papel', 350, 3;
EXEC procedureInsertRawMaterial 'Arcilla chamotada', 350, 3;
EXEC procedureInsertRawMaterial 'Arcilla de modelado', 350, 3;
EXEC procedureInsertRawMaterial 'Feldespato potásico (ortoclasa o microclina)', 100, 3;
EXEC procedureInsertRawMaterial 'Feldespato sódico (albita o oligoclasa)', 100, 3;
EXEC procedureInsertRawMaterial 'Feldespato cálcico (anortita)', 100, 3;
EXEC procedureInsertRawMaterial 'Sílice de cuarzo (cristalino)', 50, 3;
EXEC procedureInsertRawMaterial 'Sílice amorfa', 50, 3;
EXEC procedureInsertRawMaterial 'Sílice coloidal', 50, 3;
EXEC procedureInsertRawMaterial 'Almidón de maíz (almidón de maíz ceroso)', 10, 3;
EXEC procedureInsertRawMaterial 'Almidón de papa', 10, 3;
EXEC procedureInsertRawMaterial 'Almidón de trigo', 10, 3;
EXEC procedureInsertRawMaterial 'Almidón de tapioca', 10, 3;
EXEC procedureInsertRawMaterial 'Almidón de arroz', 10, 3;
EXEC procedureInsertRawMaterial 'Almidón de patata dulce', 10, 3;
EXEC procedureInsertRawMaterial 'Almidón de yuca', 10, 3;
EXEC procedureInsertRawMaterial 'Almidón de plátano', 10, 3;
EXEC procedureInsertRawMaterial 'Almidón de mandioca', 10, 3;
EXEC procedureInsertRawMaterial 'Almidón de sorgo', 10, 3;
EXEC procedureInsertRawMaterial 'Caolín', 50, 3;
EXEC procedureInsertRawMaterial 'Óxido de estaño', 10, 3;
EXEC procedureInsertRawMaterial 'Óxido de hierro amarillo', 10, 3;
EXEC procedureInsertRawMaterial 'Óxido de manganeso', 10, 3;
EXEC procedureInsertRawMaterial 'Óxido de hierro rojo', 10, 3;
EXEC procedureInsertRawMaterial 'Óxido de cobalto', 10, 3;
EXEC procedureInsertRawMaterial 'Carbonato de cobalto', 10, 3;
EXEC procedureInsertRawMaterial 'Óxido de hierro negro', 10, 3;
EXEC procedureInsertRawMaterial 'Óxido de cobre', 10, 3;
EXEC procedureInsertRawMaterial 'Óxido de titanio', 10, 3;
EXEC procedureInsertRawMaterial 'Óxido de cromo', 10, 3;
EXEC procedureInsertRawMaterial 'Ocre', 5, 3;
EXEC procedureInsertRawMaterial 'Dióxido de titanio (Rutilo)', 5, 3;
EXEC procedureInsertRawMaterial 'Carbonato de cobre', 10, 3;
EXEC procedureInsertRawMaterial 'Óxido de níquel', 10, 3;
EXEC procedureInsertRawMaterial 'Esmalte transparentes', 100, 5;
EXEC procedureInsertRawMaterial 'Esmalte opacos', 100, 5;
EXEC procedureInsertRawMaterial 'Esmalte satinados o mates', 100, 5;
EXEC procedureInsertRawMaterial 'Esmalte craquelados', 100, 5;
EXEC procedureInsertRawMaterial 'Esmalte cristalinos', 100, 5;
EXEC procedureInsertRawMaterial 'Esmalte de alta temperatura', 100, 5;
EXEC procedureInsertRawMaterial 'Esmalte de baja temperatura', 100, 5;
EXEC procedureInsertRawMaterial 'Esmalte de raku', 100, 5;
EXEC procedureInsertRawMaterial 'Esmalte de engobe', 100, 5;
EXEC procedureInsertRawMaterial 'Tierra de Siena', 5, 3;
GO


CREATE PROCEDURE procedureInsertDetailRawMaterial (
  @idCatalog INT,
  @json NVARCHAR(MAX)
)
AS
BEGIN
  DECLARE @jsonTable TABLE (
    quantity INT,
    fkCatRawMaterial INT
  )
  INSERT INTO @jsonTable (quantity, fkCatRawMaterial)
    SELECT 
        JSON_VALUE(Value, '$.quantity') as quantity,
        JSON_VALUE(Value, '$.fkCatRawMaterial') as fkCatRawMaterial
    FROM OPENJSON(@json)
  DECLARE @quantity INT
  DECLARE @fkCatRawMaterial INT
  DECLARE jsonCursor CURSOR FOR
    SELECT quantity, fkCatRawMaterial FROM @jsonTable
  OPEN jsonCursor
  FETCH NEXT FROM jsonCursor INTO @quantity, @fkCatRawMaterial
  WHILE @@FETCH_STATUS = 0
    BEGIN
      INSERT INTO DetailRecipeRawMaterial (fkCatRecipe, quantity, fkCatRawMaterial)
      VALUES (@idCatalog, @quantity, @fkCatRawMaterial);
      FETCH NEXT FROM jsonCursor INTO @quantity, @fkCatRawMaterial
    END
  CLOSE jsonCursor
  DEALLOCATE jsonCursor
END;
GO


CREATE PROCEDURE procedureInsertDetailColors (
  @idCatalog INT,
  @jsonColors NVARCHAR(MAX)
)
AS
BEGIN
  DECLARE @jsonTable TABLE (
    idColor INT
  )
  INSERT INTO @jsonTable (idColor)
    SELECT Value
    FROM OPENJSON(@jsonColors)
  DECLARE @idColor INT
  DECLARE jsonCursor CURSOR FOR
  SELECT idColor FROM @jsonTable
  OPEN jsonCursor
  FETCH NEXT FROM jsonCursor INTO @idColor
  WHILE @@FETCH_STATUS = 0
    BEGIN
      INSERT INTO DetailRecipeColor (fkCatRecipe, fkCatColor)
      VALUES (@idCatalog, @idColor);
      FETCH NEXT FROM jsonCursor INTO @idColor
    END
  CLOSE jsonCursor
  DEALLOCATE jsonCursor
END;
GO


CREATE PROCEDURE procedureInsertRecipe (
  @name VARCHAR(255),
  @price FLOAT,
  @imagePath VARCHAR(255),
  @fkCatSize INT,
  @jsonColors NVARCHAR(MAX),
  @jsonRawMaterial NVARCHAR(MAX)
)
AS
BEGIN
  DECLARE @idCatRecipe INT;
  INSERT INTO CatRecipe (name, price, imagePath, fkCatSize) VALUES (@name, @price, @imagePath, @fkCatSize);
  SET @idCatRecipe = SCOPE_IDENTITY();
  EXEC procedureInsertDetailColors @idCatRecipe, @jsonColors;
  EXEC procedureInsertDetailRawMaterial @idCatRecipe, @jsonRawMaterial;
END;
GO


CREATE FUNCTION dbo.mergeJsonWithIdsAndData (
  @jsonIdRawMaterial NVARCHAR(MAX),
  @jsonData NVARCHAR(MAX)
)
RETURNS NVARCHAR(MAX)
AS
BEGIN
  DECLARE @jsonIdRawMaterialTable TABLE (fkCatRawMaterial INT);
  INSERT INTO @jsonIdRawMaterialTable (fkCatRawMaterial)
  SELECT value FROM OPENJSON(@jsonIdRawMaterial);
  DECLARE @mergedJson NVARCHAR(MAX);
  SELECT @mergedJson = (
    SELECT CONCAT(
      '[',
      STRING_AGG(
        CONCAT('{"quantity":1,"fkCatRawMaterial":', fkCatRawMaterial, '}'),
        ','
      ),
      ',',
      REPLACE(REPLACE(@jsonData, ']', ''), '[', ''),
      ']'
    )
    FROM @jsonIdRawMaterialTable
  );
  RETURN @mergedJson;
END;
GO


CREATE PROCEDURE procedureFillingInsertRecipe (
  @nameProduct VARCHAR(255),
  @jsonIdRawMaterial NVARCHAR(MAX)
)
AS
BEGIN
  DECLARE @name VARCHAR(255);
  DECLARE @jsonDetailRawMaterial NVARCHAR(MAX);
  DECLARE @jsonData NVARCHAR(MAX);
  DECLARE @mergedJson NVARCHAR(MAX);

  SET @name = CONCAT(@nameProduct, ' color sólido');
  SET @jsonData = '[{"quantity":1,"fkCatRawMaterial":29},{"quantity":1,"fkCatRawMaterial":30}]';
  SET @mergedJson = dbo.mergeJsonWithIdsAndData(@jsonIdRawMaterial, @jsonData);
  EXEC procedureInsertRecipe @name, 0, null, 1, '[1]', @mergedJson;
  SET @mergedJson = dbo.mergeJsonWithIdsAndData(@jsonIdRawMaterial, @jsonData);
  EXEC procedureInsertRecipe @name, 0, null, 2, '[1]', @mergedJson;
  SET @mergedJson = dbo.mergeJsonWithIdsAndData(@jsonIdRawMaterial, @jsonData);
  EXEC procedureInsertRecipe @name, 0, null, 3, '[1]', @mergedJson;

  SET @jsonData = '[{"quantity":1,"fkCatRawMaterial":31},{"quantity":1,"fkCatRawMaterial":29}]';
  SET @mergedJson = dbo.mergeJsonWithIdsAndData(@jsonIdRawMaterial, @jsonData);
  EXEC procedureInsertRecipe @name, 0, null, 1, '[2]', @mergedJson;
  SET @mergedJson = dbo.mergeJsonWithIdsAndData(@jsonIdRawMaterial, @jsonData);
  EXEC procedureInsertRecipe @name, 0, null, 2, '[2]', @mergedJson;
  SET @mergedJson = dbo.mergeJsonWithIdsAndData(@jsonIdRawMaterial, @jsonData);
  EXEC procedureInsertRecipe @name, 0, null, 3, '[2]', @mergedJson;

  SET @jsonData = '[{"quantity":1,"fkCatRawMaterial":32},{"quantity":1,"fkCatRawMaterial":29}]';
  SET @mergedJson = dbo.mergeJsonWithIdsAndData(@jsonIdRawMaterial, @jsonData);
  EXEC procedureInsertRecipe @name, 0, null, 1, '[3]', @mergedJson;
  SET @mergedJson = dbo.mergeJsonWithIdsAndData(@jsonIdRawMaterial, @jsonData);
  EXEC procedureInsertRecipe @name, 0, null, 2, '[3]', @mergedJson;
  SET @mergedJson = dbo.mergeJsonWithIdsAndData(@jsonIdRawMaterial, @jsonData);
  EXEC procedureInsertRecipe @name, 0, null, 3, '[3]', @mergedJson;

  SET @jsonData = '[{"quantity":1,"fkCatRawMaterial":33},{"quantity":1,"fkCatRawMaterial":32},{"quantity":1,"fkCatRawMaterial":29}]';
  SET @mergedJson = dbo.mergeJsonWithIdsAndData(@jsonIdRawMaterial, @jsonData);
  EXEC procedureInsertRecipe @name, 0, null, 1, '[4]', @mergedJson;
  SET @mergedJson = dbo.mergeJsonWithIdsAndData(@jsonIdRawMaterial, @jsonData);
  EXEC procedureInsertRecipe @name, 0, null, 2, '[4]', @mergedJson;
  SET @mergedJson = dbo.mergeJsonWithIdsAndData(@jsonIdRawMaterial, @jsonData);
  EXEC procedureInsertRecipe @name, 0, null, 3, '[4]', @mergedJson;

  SET @jsonData = '[{"quantity":1,"fkCatRawMaterial":34},{"quantity":1,"fkCatRawMaterial":35},{"quantity":1,"fkCatRawMaterial":36}]';
  SET @mergedJson = dbo.mergeJsonWithIdsAndData(@jsonIdRawMaterial, @jsonData);
  EXEC procedureInsertRecipe @name, 0, null, 1, '[5]', @mergedJson;
  SET @mergedJson = dbo.mergeJsonWithIdsAndData(@jsonIdRawMaterial, @jsonData);
  EXEC procedureInsertRecipe @name, 0, null, 2, '[5]', @mergedJson;
  SET @mergedJson = dbo.mergeJsonWithIdsAndData(@jsonIdRawMaterial, @jsonData);
  EXEC procedureInsertRecipe @name, 0, null, 3, '[5]', @mergedJson;

  SET @jsonData = '[{"quantity":1,"fkCatRawMaterial":37},{"quantity":1,"fkCatRawMaterial":36},{"quantity":1,"fkCatRawMaterial":29}]';
  SET @mergedJson = dbo.mergeJsonWithIdsAndData(@jsonIdRawMaterial, @jsonData);
  EXEC procedureInsertRecipe @name, 0, null, 1, '[6]', @mergedJson;
  SET @mergedJson = dbo.mergeJsonWithIdsAndData(@jsonIdRawMaterial, @jsonData);
  EXEC procedureInsertRecipe @name, 0, null, 2, '[6]', @mergedJson;
  SET @mergedJson = dbo.mergeJsonWithIdsAndData(@jsonIdRawMaterial, @jsonData);
  EXEC procedureInsertRecipe @name, 0, null, 3, '[6]', @mergedJson;

  SET @jsonData = '[{"quantity":1,"fkCatRawMaterial":33},{"quantity":1,"fkCatRawMaterial":29}]';
  SET @mergedJson = dbo.mergeJsonWithIdsAndData(@jsonIdRawMaterial, @jsonData);
  EXEC procedureInsertRecipe @name, 0, null, 1, '[7]', @mergedJson;
  SET @mergedJson = dbo.mergeJsonWithIdsAndData(@jsonIdRawMaterial, @jsonData);
  EXEC procedureInsertRecipe @name, 0, null, 2, '[7]', @mergedJson;
  SET @mergedJson = dbo.mergeJsonWithIdsAndData(@jsonIdRawMaterial, @jsonData);
  EXEC procedureInsertRecipe @name, 0, null, 3, '[7]', @mergedJson;

  SET @jsonData = '[{"quantity":1,"fkCatRawMaterial":36},{"quantity":1,"fkCatRawMaterial":32}]';
  SET @mergedJson = dbo.mergeJsonWithIdsAndData(@jsonIdRawMaterial, @jsonData);
  EXEC procedureInsertRecipe @name, 0, null, 1, '[8]', @mergedJson;
  SET @mergedJson = dbo.mergeJsonWithIdsAndData(@jsonIdRawMaterial, @jsonData);
  EXEC procedureInsertRecipe @name, 0, null, 2, '[8]', @mergedJson;
  SET @mergedJson = dbo.mergeJsonWithIdsAndData(@jsonIdRawMaterial, @jsonData);
  EXEC procedureInsertRecipe @name, 0, null, 3, '[8]', @mergedJson;

  SET @jsonData = '[{"quantity":1,"fkCatRawMaterial":38},{"quantity":1,"fkCatRawMaterial":39}]';
  SET @mergedJson = dbo.mergeJsonWithIdsAndData(@jsonIdRawMaterial, @jsonData);
  EXEC procedureInsertRecipe @name, 0, null, 1, '[9]', @mergedJson;
  SET @mergedJson = dbo.mergeJsonWithIdsAndData(@jsonIdRawMaterial, @jsonData);
  EXEC procedureInsertRecipe @name, 0, null, 2, '[9]', @mergedJson;
  SET @mergedJson = dbo.mergeJsonWithIdsAndData(@jsonIdRawMaterial, @jsonData);
  EXEC procedureInsertRecipe @name, 0, null, 3, '[9]', @mergedJson;

  SET @jsonData = '[{"quantity":1,"fkCatRawMaterial":33},{"quantity":1,"fkCatRawMaterial":38}]';
  SET @mergedJson = dbo.mergeJsonWithIdsAndData(@jsonIdRawMaterial, @jsonData);
  EXEC procedureInsertRecipe @name, 0, null, 1, '[10]', @mergedJson;
  SET @mergedJson = dbo.mergeJsonWithIdsAndData(@jsonIdRawMaterial, @jsonData);
  EXEC procedureInsertRecipe @name, 0, null, 2, '[10]', @mergedJson;
  SET @mergedJson = dbo.mergeJsonWithIdsAndData(@jsonIdRawMaterial, @jsonData);
  EXEC procedureInsertRecipe @name, 0, null, 3, '[10]', @mergedJson;

  SET @name = CONCAT(@nameProduct, ' colores');
  SET @jsonData = '[{"quantity":3,"fkCatRawMaterial":29},{"quantity":1,"fkCatRawMaterial":31},{"quantity":1,"fkCatRawMaterial":32},{"quantity":1,"fkCatRawMaterial":33},{"quantity":1,"fkCatRawMaterial":38}]';
  SET @mergedJson = dbo.mergeJsonWithIdsAndData(@jsonIdRawMaterial, @jsonData);
  EXEC procedureInsertRecipe @name, 0, null, 1, '[2,4,9]', @mergedJson;
  SET @mergedJson = dbo.mergeJsonWithIdsAndData(@jsonIdRawMaterial, @jsonData);
  EXEC procedureInsertRecipe @name, 0, null, 2, '[2,4,9]', @mergedJson;
  SET @mergedJson = dbo.mergeJsonWithIdsAndData(@jsonIdRawMaterial, @jsonData);
  EXEC procedureInsertRecipe @name, 0, null, 3, '[2,4,9]', @mergedJson;

  SET @jsonData = '[{"quantity":2,"fkCatRawMaterial":29},{"quantity":1,"fkCatRawMaterial":30},{"quantity":2,"fkCatRawMaterial":32},{"quantity":1,"fkCatRawMaterial":36}]';
  SET @mergedJson = dbo.mergeJsonWithIdsAndData(@jsonIdRawMaterial, @jsonData);
  EXEC procedureInsertRecipe @name, 0, null, 1, '[1,3,8]', @mergedJson;
  SET @mergedJson = dbo.mergeJsonWithIdsAndData(@jsonIdRawMaterial, @jsonData);
  EXEC procedureInsertRecipe @name, 0, null, 2, '[1,3,8]', @mergedJson;
  SET @mergedJson = dbo.mergeJsonWithIdsAndData(@jsonIdRawMaterial, @jsonData);
  EXEC procedureInsertRecipe @name, 0, null, 3, '[1,3,8]', @mergedJson;

  SET @jsonData = '[{"quantity":2,"fkCatRawMaterial":29},{"quantity":1,"fkCatRawMaterial":30},{"quantity":1,"fkCatRawMaterial":34},{"quantity":1,"fkCatRawMaterial":35},{"quantity":2,"fkCatRawMaterial":36},{"quantity":1,"fkCatRawMaterial":37}]';
  SET @mergedJson = dbo.mergeJsonWithIdsAndData(@jsonIdRawMaterial, @jsonData);
  EXEC procedureInsertRecipe @name, 0, null, 1, '[5,6,1]', @mergedJson;
  SET @mergedJson = dbo.mergeJsonWithIdsAndData(@jsonIdRawMaterial, @jsonData);
  EXEC procedureInsertRecipe @name, 0, null, 2, '[5,6,1]', @mergedJson;
  SET @mergedJson = dbo.mergeJsonWithIdsAndData(@jsonIdRawMaterial, @jsonData);
  EXEC procedureInsertRecipe @name, 0, null, 3, '[5,6,1]', @mergedJson;

  SET @jsonData = '[{"quantity":2,"fkCatRawMaterial":29},{"quantity":1,"fkCatRawMaterial":32},{"quantity":2,"fkCatRawMaterial":33},{"quantity":2,"fkCatRawMaterial":38}]';
  SET @mergedJson = dbo.mergeJsonWithIdsAndData(@jsonIdRawMaterial, @jsonData);
  EXEC procedureInsertRecipe @name, 0, null, 1, '[10,4,9]', @mergedJson;
  SET @mergedJson = dbo.mergeJsonWithIdsAndData(@jsonIdRawMaterial, @jsonData);
  EXEC procedureInsertRecipe @name, 0, null, 2, '[10,4,9]', @mergedJson;
  SET @mergedJson = dbo.mergeJsonWithIdsAndData(@jsonIdRawMaterial, @jsonData);
  EXEC procedureInsertRecipe @name, 0, null, 3, '[10,4,9]', @mergedJson;
  END;
GO


EXEC procedureFillingInsertRecipe 'Azulejo', '[6,13,16,19,44]';
EXEC procedureFillingInsertRecipe 'Bidé', '[8,14,17,20,44]';
EXEC procedureFillingInsertRecipe 'Cacerola', '[9,15,18,22,45]';
EXEC procedureFillingInsertRecipe 'Candelabro', '[7,15,18]';
EXEC procedureFillingInsertRecipe 'Cuenco', '[6,13,18]';
EXEC procedureFillingInsertRecipe 'Ensaladera', '[8,13,18]';
EXEC procedureFillingInsertRecipe 'Florero', '[6,13,18]';
EXEC procedureFillingInsertRecipe 'Fregadero', '[9,15,18,19,45]';
EXEC procedureFillingInsertRecipe 'Inodoro', '[8,14,16,20,44]';
EXEC procedureFillingInsertRecipe 'Jarra', '[7,15,18]';
EXEC procedureFillingInsertRecipe 'Jarrón', '[6,13,18]';
EXEC procedureFillingInsertRecipe 'Ladrillo', '[9,18,22]';
EXEC procedureFillingInsertRecipe 'Lavabo', '[8,14,16,20,44]';
EXEC procedureFillingInsertRecipe 'Maceta', '[6,13,18]';
EXEC procedureFillingInsertRecipe 'Mosaico', '[7,15,18]';
EXEC procedureFillingInsertRecipe 'Pimentero', '[6,13,18]';
EXEC procedureFillingInsertRecipe 'Platillo', '[8,13,18]';
EXEC procedureFillingInsertRecipe 'Plato', '[7,15,18]';
EXEC procedureFillingInsertRecipe 'Salero', '[6,13,16,19,44]';
EXEC procedureFillingInsertRecipe 'Taza', '[8,14,16,20,44]';
EXEC procedureFillingInsertRecipe 'Tazón', '[6,13,18]';
EXEC procedureFillingInsertRecipe 'Tetera', '[8,13,18]';
EXEC procedureFillingInsertRecipe 'Vaso', '[7,15,18]';
GO


UPDATE DetailRecipeRawMaterial SET quantity = quantity*2 WHERE fkCatRecipe IN (SELECT idCatRecipe FROM CatRecipe WHERE name LIKE '%Azulejo%');
UPDATE DetailRecipeRawMaterial SET quantity = quantity*100 WHERE fkCatRecipe IN (SELECT idCatRecipe FROM CatRecipe WHERE name LIKE '%Bidé%')
UPDATE DetailRecipeRawMaterial SET quantity = quantity*6 WHERE fkCatRecipe IN (SELECT idCatRecipe FROM CatRecipe WHERE name LIKE '%Cacerola%')
UPDATE DetailRecipeRawMaterial SET quantity = quantity*6 WHERE fkCatRecipe IN (SELECT idCatRecipe FROM CatRecipe WHERE name LIKE '%Candelabro%')
UPDATE DetailRecipeRawMaterial SET quantity = quantity*2 WHERE fkCatRecipe IN (SELECT idCatRecipe FROM CatRecipe WHERE name LIKE '%Cuenco%')
UPDATE DetailRecipeRawMaterial SET quantity = quantity*4 WHERE fkCatRecipe IN (SELECT idCatRecipe FROM CatRecipe WHERE name LIKE '%Ensaladera%')
UPDATE DetailRecipeRawMaterial SET quantity = quantity*6 WHERE fkCatRecipe IN (SELECT idCatRecipe FROM CatRecipe WHERE name LIKE '%Florero%')
UPDATE DetailRecipeRawMaterial SET quantity = quantity*40 WHERE fkCatRecipe IN (SELECT idCatRecipe FROM CatRecipe WHERE name LIKE '%Fregadero%')
UPDATE DetailRecipeRawMaterial SET quantity = quantity*100 WHERE fkCatRecipe IN (SELECT idCatRecipe FROM CatRecipe WHERE name LIKE '%Inodoro%')
UPDATE DetailRecipeRawMaterial SET quantity = quantity*4 WHERE fkCatRecipe IN (SELECT idCatRecipe FROM CatRecipe WHERE name LIKE '%Jarra%')
UPDATE DetailRecipeRawMaterial SET quantity = quantity*6 WHERE fkCatRecipe IN (SELECT idCatRecipe FROM CatRecipe WHERE name LIKE '%Jarrón%')
UPDATE DetailRecipeRawMaterial SET quantity = quantity*6 WHERE fkCatRecipe IN (SELECT idCatRecipe FROM CatRecipe WHERE name LIKE '%Ladrillo%')
UPDATE DetailRecipeRawMaterial SET quantity = quantity*40 WHERE fkCatRecipe IN (SELECT idCatRecipe FROM CatRecipe WHERE name LIKE '%Lavabo%')
UPDATE DetailRecipeRawMaterial SET quantity = quantity*10 WHERE fkCatRecipe IN (SELECT idCatRecipe FROM CatRecipe WHERE name LIKE '%Maceta%')
UPDATE DetailRecipeRawMaterial SET quantity = quantity*1 WHERE fkCatRecipe IN (SELECT idCatRecipe FROM CatRecipe WHERE name LIKE '%Mosaico%')
UPDATE DetailRecipeRawMaterial SET quantity = quantity*1 WHERE fkCatRecipe IN (SELECT idCatRecipe FROM CatRecipe WHERE name LIKE '%Pimentero%')
UPDATE DetailRecipeRawMaterial SET quantity = quantity*1 WHERE fkCatRecipe IN (SELECT idCatRecipe FROM CatRecipe WHERE name LIKE '%Platillo%')
UPDATE DetailRecipeRawMaterial SET quantity = quantity*2 WHERE fkCatRecipe IN (SELECT idCatRecipe FROM CatRecipe WHERE name LIKE '%Plato%')
UPDATE DetailRecipeRawMaterial SET quantity = quantity*1 WHERE fkCatRecipe IN (SELECT idCatRecipe FROM CatRecipe WHERE name LIKE '%Salero%')
UPDATE DetailRecipeRawMaterial SET quantity = quantity*1 WHERE fkCatRecipe IN (SELECT idCatRecipe FROM CatRecipe WHERE name LIKE '%Taza%')
UPDATE DetailRecipeRawMaterial SET quantity = quantity*2 WHERE fkCatRecipe IN (SELECT idCatRecipe FROM CatRecipe WHERE name LIKE '%Tazón%')
UPDATE DetailRecipeRawMaterial SET quantity = quantity*4 WHERE fkCatRecipe IN (SELECT idCatRecipe FROM CatRecipe WHERE name LIKE '%Tetera%')
UPDATE DetailRecipeRawMaterial SET quantity = quantity*1 WHERE fkCatRecipe IN (SELECT idCatRecipe FROM CatRecipe WHERE name LIKE '%Vaso%')
GO


UPDATE DetailRecipeRawMaterial SET quantity = quantity*1 WHERE fkCatRecipe IN (SELECT idCatRecipe FROM CatRecipe WHERE fkCatSize = 1);
UPDATE DetailRecipeRawMaterial SET quantity = quantity*2 WHERE fkCatRecipe IN (SELECT idCatRecipe FROM CatRecipe WHERE fkCatSize = 2);
UPDATE DetailRecipeRawMaterial SET quantity = quantity*3 WHERE fkCatRecipe IN (SELECT idCatRecipe FROM CatRecipe WHERE fkCatSize = 3);
GO


INSERT INTO CatPurchase (total, fkCatSupplier, fkCatEmployee) VALUES (1, 1, 5);
INSERT INTO CatPurchase (total, fkCatSupplier, fkCatEmployee) VALUES (1, 1, 5);
INSERT INTO CatPurchase (total, fkCatSupplier, fkCatEmployee) VALUES (1, 1, 5);
INSERT INTO CatPurchase (total, fkCatSupplier, fkCatEmployee) VALUES (1, 1, 5);
INSERT INTO CatPurchase (total, fkCatSupplier, fkCatEmployee) VALUES (1, 1, 5);
INSERT INTO CatPurchase (total, fkCatSupplier, fkCatEmployee) VALUES (1, 2, 5);
INSERT INTO CatPurchase (total, fkCatSupplier, fkCatEmployee) VALUES (1, 2, 5);
INSERT INTO CatPurchase (total, fkCatSupplier, fkCatEmployee) VALUES (1, 2, 5);
INSERT INTO CatPurchase (total, fkCatSupplier, fkCatEmployee) VALUES (1, 3, 5);
INSERT INTO CatPurchase (total, fkCatSupplier, fkCatEmployee) VALUES (1, 3, 5);
INSERT INTO CatPurchase (total, fkCatSupplier, fkCatEmployee) VALUES (1, 3, 5);
INSERT INTO CatPurchase (total, fkCatSupplier, fkCatEmployee) VALUES (1, 4, 5);
INSERT INTO CatPurchase (total, fkCatSupplier, fkCatEmployee) VALUES (1, 4, 5);
INSERT INTO CatPurchase (total, fkCatSupplier, fkCatEmployee) VALUES (1, 4, 5);
INSERT INTO CatPurchase (total, fkCatSupplier, fkCatEmployee) VALUES (1, 5, 5);
INSERT INTO CatPurchase (total, fkCatSupplier, fkCatEmployee) VALUES (1, 5, 5);
INSERT INTO CatPurchase (total, fkCatSupplier, fkCatEmployee) VALUES (1, 5, 5);
INSERT INTO CatPurchase (total, fkCatSupplier, fkCatEmployee) VALUES (1, 5, 5);
INSERT INTO CatPurchase (total, fkCatSupplier, fkCatEmployee) VALUES (1, 6, 5);
INSERT INTO CatPurchase (total, fkCatSupplier, fkCatEmployee) VALUES (1, 6, 5);
INSERT INTO CatPurchase (total, fkCatSupplier, fkCatEmployee) VALUES (1, 6, 5);
INSERT INTO CatPurchase (total, fkCatSupplier, fkCatEmployee) VALUES (1, 6, 5);
INSERT INTO CatPurchase (total, fkCatSupplier, fkCatEmployee) VALUES (1, 6, 5);
INSERT INTO CatPurchase (total, fkCatSupplier, fkCatEmployee) VALUES (1, 7, 5);
INSERT INTO CatPurchase (total, fkCatSupplier, fkCatEmployee) VALUES (1, 7, 5);
INSERT INTO CatPurchase (total, fkCatSupplier, fkCatEmployee) VALUES (1, 8, 5);
INSERT INTO CatPurchase (total, fkCatSupplier, fkCatEmployee) VALUES (1, 8, 5);
INSERT INTO CatPurchase (total, fkCatSupplier, fkCatEmployee) VALUES (1, 8, 5);

-- Arcilla
INSERT INTO DetailPurchase (quantity, price, fkCatRawMaterial, fkCatPurchase) VALUES (25000, 1250, 6, 1);
INSERT INTO DetailPurchase (quantity, price, fkCatRawMaterial, fkCatPurchase) VALUES (19000, 950, 7, 1);
INSERT INTO DetailPurchase (quantity, price, fkCatRawMaterial, fkCatPurchase) VALUES (50000, 2500, 8, 1);
INSERT INTO DetailPurchase (quantity, price, fkCatRawMaterial, fkCatPurchase) VALUES (30000, 1500, 9, 1);
INSERT INTO DetailPurchase (quantity, price, fkCatRawMaterial, fkCatPurchase) VALUES (17000, 850, 6, 2);
INSERT INTO DetailPurchase (quantity, price, fkCatRawMaterial, fkCatPurchase) VALUES (50000, 2500, 8, 2);
INSERT INTO DetailPurchase (quantity, price, fkCatRawMaterial, fkCatPurchase) VALUES (30000, 1500, 9, 2);
INSERT INTO DetailPurchase (quantity, price, fkCatRawMaterial, fkCatPurchase) VALUES (50000, 2500, 8, 3);
INSERT INTO DetailPurchase (quantity, price, fkCatRawMaterial, fkCatPurchase) VALUES (50000, 2500, 8, 4);
INSERT INTO DetailPurchase (quantity, price, fkCatRawMaterial, fkCatPurchase) VALUES (50000, 2500, 8, 5);
-- Feldespato
INSERT INTO DetailPurchase (quantity, price, fkCatRawMaterial, fkCatPurchase) VALUES (25000, 2000, 13, 6);
INSERT INTO DetailPurchase (quantity, price, fkCatRawMaterial, fkCatPurchase) VALUES (100000, 8000, 14, 6);
INSERT INTO DetailPurchase (quantity, price, fkCatRawMaterial, fkCatPurchase) VALUES (30000, 2400, 15, 6);
INSERT INTO DetailPurchase (quantity, price, fkCatRawMaterial, fkCatPurchase) VALUES (25000, 2000, 13, 7);
INSERT INTO DetailPurchase (quantity, price, fkCatRawMaterial, fkCatPurchase) VALUES (100000, 8000, 14, 7);
INSERT INTO DetailPurchase (quantity, price, fkCatRawMaterial, fkCatPurchase) VALUES (30000, 2400, 15, 7);
INSERT INTO DetailPurchase (quantity, price, fkCatRawMaterial, fkCatPurchase) VALUES (25000, 2000, 13, 8);
INSERT INTO DetailPurchase (quantity, price, fkCatRawMaterial, fkCatPurchase) VALUES (100000, 8000, 14, 8);
INSERT INTO DetailPurchase (quantity, price, fkCatRawMaterial, fkCatPurchase) VALUES (30000, 2400, 15, 8);
-- Sílice
INSERT INTO DetailPurchase (quantity, price, fkCatRawMaterial, fkCatPurchase) VALUES (25000, 1500, 16, 9);
INSERT INTO DetailPurchase (quantity, price, fkCatRawMaterial, fkCatPurchase) VALUES (100000, 6000, 17, 9);
INSERT INTO DetailPurchase (quantity, price, fkCatRawMaterial, fkCatPurchase) VALUES (100000, 6000, 18, 9);
INSERT INTO DetailPurchase (quantity, price, fkCatRawMaterial, fkCatPurchase) VALUES (25000, 1500, 16, 10);
INSERT INTO DetailPurchase (quantity, price, fkCatRawMaterial, fkCatPurchase) VALUES (100000, 6000, 17, 10);
INSERT INTO DetailPurchase (quantity, price, fkCatRawMaterial, fkCatPurchase) VALUES (100000, 6000, 18, 10);
INSERT INTO DetailPurchase (quantity, price, fkCatRawMaterial, fkCatPurchase) VALUES (25000, 1500, 16, 11);
INSERT INTO DetailPurchase (quantity, price, fkCatRawMaterial, fkCatPurchase) VALUES (25000, 1500, 16, 11);
-- Almidón
INSERT INTO DetailPurchase (quantity, price, fkCatRawMaterial, fkCatPurchase) VALUES (50000, 2000, 19, 12);
INSERT INTO DetailPurchase (quantity, price, fkCatRawMaterial, fkCatPurchase) VALUES (100000, 4000, 20, 12);
INSERT INTO DetailPurchase (quantity, price, fkCatRawMaterial, fkCatPurchase) VALUES (20000, 800, 22, 12);
INSERT INTO DetailPurchase (quantity, price, fkCatRawMaterial, fkCatPurchase) VALUES (100000, 4000, 20, 13);
INSERT INTO DetailPurchase (quantity, price, fkCatRawMaterial, fkCatPurchase) VALUES (100000, 4000, 20, 14);
-- Caolín
INSERT INTO DetailPurchase (quantity, price, fkCatRawMaterial, fkCatPurchase) VALUES (200000, 8000, 29, 15);
INSERT INTO DetailPurchase (quantity, price, fkCatRawMaterial, fkCatPurchase) VALUES (200000, 8000, 29, 16);
INSERT INTO DetailPurchase (quantity, price, fkCatRawMaterial, fkCatPurchase) VALUES (200000, 8000, 29, 17);
INSERT INTO DetailPurchase (quantity, price, fkCatRawMaterial, fkCatPurchase) VALUES (200000, 8000, 29, 18);
-- Óxido
INSERT INTO DetailPurchase (quantity, price, fkCatRawMaterial, fkCatPurchase) VALUES (25000, 2000, 30, 19);
INSERT INTO DetailPurchase (quantity, price, fkCatRawMaterial, fkCatPurchase) VALUES (30000, 2400, 31, 19);
INSERT INTO DetailPurchase (quantity, price, fkCatRawMaterial, fkCatPurchase) VALUES (100000, 8000, 32, 19);
INSERT INTO DetailPurchase (quantity, price, fkCatRawMaterial, fkCatPurchase) VALUES (100000, 8000, 33, 19);
INSERT INTO DetailPurchase (quantity, price, fkCatRawMaterial, fkCatPurchase) VALUES (100000, 8000, 34, 19);
INSERT INTO DetailPurchase (quantity, price, fkCatRawMaterial, fkCatPurchase) VALUES (200000, 16000, 36, 19);
INSERT INTO DetailPurchase (quantity, price, fkCatRawMaterial, fkCatPurchase) VALUES (50000, 4000, 37, 19);
INSERT INTO DetailPurchase (quantity, price, fkCatRawMaterial, fkCatPurchase) VALUES (50000, 4000, 38, 19);
INSERT INTO DetailPurchase (quantity, price, fkCatRawMaterial, fkCatPurchase) VALUES (25000, 2000, 39, 19);

INSERT INTO DetailPurchase (quantity, price, fkCatRawMaterial, fkCatPurchase) VALUES (25000, 2000, 30, 20);
INSERT INTO DetailPurchase (quantity, price, fkCatRawMaterial, fkCatPurchase) VALUES (100000, 8000, 32, 20);
INSERT INTO DetailPurchase (quantity, price, fkCatRawMaterial, fkCatPurchase) VALUES (100000, 8000, 33, 20);
INSERT INTO DetailPurchase (quantity, price, fkCatRawMaterial, fkCatPurchase) VALUES (100000, 8000, 34, 20);
INSERT INTO DetailPurchase (quantity, price, fkCatRawMaterial, fkCatPurchase) VALUES (200000, 16000, 36, 20);
INSERT INTO DetailPurchase (quantity, price, fkCatRawMaterial, fkCatPurchase) VALUES (50000, 4000, 37, 20);
INSERT INTO DetailPurchase (quantity, price, fkCatRawMaterial, fkCatPurchase) VALUES (50000, 4000, 38, 20);

INSERT INTO DetailPurchase (quantity, price, fkCatRawMaterial, fkCatPurchase) VALUES (25000, 2000, 30, 21);
INSERT INTO DetailPurchase (quantity, price, fkCatRawMaterial, fkCatPurchase) VALUES (100000, 8000, 32, 21);
INSERT INTO DetailPurchase (quantity, price, fkCatRawMaterial, fkCatPurchase) VALUES (50000, 4000, 37, 21);
INSERT INTO DetailPurchase (quantity, price, fkCatRawMaterial, fkCatPurchase) VALUES (50000, 4000, 38, 21);

INSERT INTO DetailPurchase (quantity, price, fkCatRawMaterial, fkCatPurchase) VALUES (25000, 2000, 30, 22);
INSERT INTO DetailPurchase (quantity, price, fkCatRawMaterial, fkCatPurchase) VALUES (50000, 4000, 38, 22);

INSERT INTO DetailPurchase (quantity, price, fkCatRawMaterial, fkCatPurchase) VALUES (25000, 2000, 30, 23);
-- Carbonato
INSERT INTO DetailPurchase (quantity, price, fkCatRawMaterial, fkCatPurchase) VALUES (100000, 8000, 35, 24);
INSERT INTO DetailPurchase (quantity, price, fkCatRawMaterial, fkCatPurchase) VALUES (100000, 8000, 35, 25);
-- Esmalte
INSERT INTO DetailPurchase (quantity, price, fkCatRawMaterial, fkCatPurchase) VALUES (150000, 12000, 44, 26);
INSERT INTO DetailPurchase (quantity, price, fkCatRawMaterial, fkCatPurchase) VALUES (25000, 2000, 45, 26);
INSERT INTO DetailPurchase (quantity, price, fkCatRawMaterial, fkCatPurchase) VALUES (150000, 12000, 44, 27);
INSERT INTO DetailPurchase (quantity, price, fkCatRawMaterial, fkCatPurchase) VALUES (25000, 2000, 45, 27);
INSERT INTO DetailPurchase (quantity, price, fkCatRawMaterial, fkCatPurchase) VALUES (150000, 12000, 44, 28);
GO

UPDATE CatPurchase
SET total = subquery.sum_quantity
FROM (
    SELECT fkCatPurchase, SUM(price) AS sum_quantity
    FROM DetailPurchase
    GROUP BY fkCatPurchase
) AS subquery
WHERE CatPurchase.idCatPurchase = subquery.fkCatPurchase;

UPDATE CatRawMaterial
SET quantityWarehouse = subquery.sum_quantity
FROM (
    SELECT fkCatRawMaterial, SUM(quantity) AS sum_quantity
    FROM DetailPurchase
    GROUP BY fkCatRawMaterial
) AS subquery
WHERE CatRawMaterial.idCatRawMaterial = subquery.fkCatRawMaterial;
GO


CREATE FUNCTION dbo.getMaxRecipesForRawMaterials (
  @idCatRecipe INT
)
RETURNS INT
AS
BEGIN
  DECLARE @maxRecipes INT
  SELECT @maxRecipes = MIN(crm.quantityWarehouse / drrm.quantity)
  FROM DetailRecipeRawMaterial drrm
  INNER JOIN CatRawMaterial crm
    ON drrm.fkCatRawMaterial = crm.idCatRawMaterial
  WHERE drrm.fkCatRecipe = @idCatRecipe
    AND crm.status = 1;
  RETURN @maxRecipes;
END;
GO


CREATE FUNCTION dbo.checkRawMaterialByRecipe (
  @idCatRecipe INT,
  @totalRecipes INT
)
RETURNS BIT
AS
BEGIN
  DECLARE @availability BIT
  SELECT @availability = 
    CASE
      WHEN EXISTS (
        SELECT 1
        FROM DetailRecipeRawMaterial drrm
        INNER JOIN CatRawMaterial crm
          ON drrm.fkCatRawMaterial = crm.idCatRawMaterial
        INNER JOIN CatRecipe cr
          ON drrm.fkCatRecipe = cr.idCatRecipe
        INNER JOIN CatSize cs
          ON cr.fkCatSize = cs.idCatSize
        WHERE cr.idCatRecipe = @idCatRecipe
          AND cr.status = 1
          AND crm.status = 1
          AND cs.status = 1
        GROUP BY crm.idCatRawMaterial, crm.quantityWarehouse
        HAVING SUM(drrm.quantity * @totalRecipes) > crm.quantityWarehouse
      )
      THEN 0
      ELSE 1
    END;
  RETURN @availability;
END;
GO


CREATE PROCEDURE procedureInsertStock (
  @idCatRecipe INT,
  @totalRecipes INT
)
AS
BEGIN
  DECLARE @isEnough BIT
  SET @isEnough = dbo.checkRawMaterialByRecipe(@idCatRecipe, @totalRecipes);
  IF @isEnough = 1
  BEGIN
    UPDATE crm
    SET quantityWarehouse = quantityWarehouse - (drrm.quantity * @totalRecipes)
    FROM CatRawMaterial crm
    INNER JOIN DetailRecipeRawMaterial drrm
      ON crm.idCatRawMaterial = drrm.fkCatRawMaterial
    WHERE drrm.fkCatRecipe = @idCatRecipe;
    UPDATE CatRecipe SET quantityStock = quantityStock + @totalRecipes WHERE idCatRecipe = @idCatRecipe;
  END
END;
GO


EXEC procedureInsertStock 27, 160;
EXEC procedureInsertStock 29, 135;
EXEC procedureInsertStock 31, 225;
EXEC procedureInsertStock 35, 145;
EXEC procedureInsertStock 56, 115;
EXEC procedureInsertStock 91, 135;
EXEC procedureInsertStock 99, 460;
EXEC procedureInsertStock 126, 175;
EXEC procedureInsertStock 164, 370;
EXEC procedureInsertStock 182, 265;
EXEC procedureInsertStock 188, 345;
EXEC procedureInsertStock 192, 380;
EXEC procedureInsertStock 202, 405;
EXEC procedureInsertStock 209, 225;
EXEC procedureInsertStock 258, 465;
EXEC procedureInsertStock 269, 155;
EXEC procedureInsertStock 288, 295;
EXEC procedureInsertStock 292, 415;
EXEC procedureInsertStock 312, 425;
EXEC procedureInsertStock 358, 415;
EXEC procedureInsertStock 368, 350;
EXEC procedureInsertStock 454, 315;
EXEC procedureInsertStock 467, 440;
EXEC procedureInsertStock 484, 395;
EXEC procedureInsertStock 515, 215;
EXEC procedureInsertStock 532, 325;
EXEC procedureInsertStock 584, 245;
EXEC procedureInsertStock 587, 395;
EXEC procedureInsertStock 593, 445;
EXEC procedureInsertStock 620, 245;
EXEC procedureInsertStock 622, 275;
EXEC procedureInsertStock 682, 450;
EXEC procedureInsertStock 697, 310;
EXEC procedureInsertStock 736, 255;
EXEC procedureInsertStock 759, 445;
EXEC procedureInsertStock 768, 390;
EXEC procedureInsertStock 795, 195;
EXEC procedureInsertStock 800, 305;
EXEC procedureInsertStock 806, 170;
EXEC procedureInsertStock 815, 325;
EXEC procedureInsertStock 820, 235;
EXEC procedureInsertStock 830, 410;
EXEC procedureInsertStock 849, 160;
EXEC procedureInsertStock 853, 360;
EXEC procedureInsertStock 912, 415;
EXEC procedureInsertStock 922, 130;
EXEC procedureInsertStock 933, 500;
EXEC procedureInsertStock 990, 225;
EXEC procedureInsertStock 1008, 435;
EXEC procedureInsertStock 1021, 170;
EXEC procedureInsertStock 1045, 475;
EXEC procedureInsertStock 1046, 385;
EXEC procedureInsertStock 1061, 405;
EXEC procedureInsertStock 1138, 140;
EXEC procedureInsertStock 1140, 105;
EXEC procedureInsertStock 1144, 270;
EXEC procedureInsertStock 1145, 400;
EXEC procedureInsertStock 1150, 330;
EXEC procedureInsertStock 1163, 195;
EXEC procedureInsertStock 1172, 355;
EXEC procedureInsertStock 1210, 430;
EXEC procedureInsertStock 1211, 110;
EXEC procedureInsertStock 1213, 100;
EXEC procedureInsertStock 1237, 355;
EXEC procedureInsertStock 1294, 430;
EXEC procedureInsertStock 1305, 460;
EXEC procedureInsertStock 1309, 240;
EXEC procedureInsertStock 1351, 130;
EXEC procedureInsertStock 1368, 285;
EXEC procedureInsertStock 1402, 255;
EXEC procedureInsertStock 1417, 105;
EXEC procedureInsertStock 1448, 365;
EXEC procedureInsertStock 1449, 200;
EXEC procedureInsertStock 1466, 340;
EXEC procedureInsertStock 1472, 185;
EXEC procedureInsertStock 1515, 290;
EXEC procedureInsertStock 1516, 380;
EXEC procedureInsertStock 1581, 265;
EXEC procedureInsertStock 1586, 165;
EXEC procedureInsertStock 1589, 275;
EXEC procedureInsertStock 1593, 330;
EXEC procedureInsertStock 1607, 150;
EXEC procedureInsertStock 1635, 195;
EXEC procedureInsertStock 1650, 195;
EXEC procedureInsertStock 1691, 490;
EXEC procedureInsertStock 1699, 225;
EXEC procedureInsertStock 1708, 170;
EXEC procedureInsertStock 1737, 390;
EXEC procedureInsertStock 1756, 120;
EXEC procedureInsertStock 1774, 375;
EXEC procedureInsertStock 1788, 420;
EXEC procedureInsertStock 1789, 285;
EXEC procedureInsertStock 1793, 240;
EXEC procedureInsertStock 1798, 420;
EXEC procedureInsertStock 1827, 410;
EXEC procedureInsertStock 1849, 385;
EXEC procedureInsertStock 1873, 495;
EXEC procedureInsertStock 1904, 170;
EXEC procedureInsertStock 1925, 115;
EXEC procedureInsertStock 1929, 350;
GO


WITH RecipePrices AS (
  SELECT 
    drrm.fkCatRecipe,
    (CEILING(SUM(drrm.quantity * 
      CASE
        WHEN drrm.fkCatRawMaterial IN (6, 7, 8, 9) THEN 0.05
        WHEN drrm.fkCatRawMaterial IN (13, 14, 15) THEN 0.08
        WHEN drrm.fkCatRawMaterial = 16 THEN 0.06
        WHEN drrm.fkCatRawMaterial IN (19, 20, 22, 29) THEN 0.04
        WHEN drrm.fkCatRawMaterial IN (30, 31, 32, 33, 34, 36, 37, 38, 39, 35, 44, 45) THEN 0.08
        ELSE 0.00
      END
    ) / 10.0) * 10) AS price
  FROM DetailRecipeRawMaterial drrm
  GROUP BY fkCatRecipe
)
UPDATE r
SET r.price = rp.price
FROM CatRecipe r
INNER JOIN RecipePrices rp
  ON r.idCatRecipe = rp.fkCatRecipe;
GO
UPDATE cr
SET cr.price = (cr.price * cr.fkCatSize)
FROM CatRecipe cr;
GO


DROP PROCEDURE IF EXISTS procedureFillingInsertSales;
GO
CREATE PROCEDURE procedureFillingInsertSales (
  @fkCatClient INT,
  @totalSales INT
)
AS
  BEGIN
    DECLARE @totalDetailRecipes INT;
    DECLARE @totalRecipes INT;
    DECLARE @idCatSale INT;
    DECLARE @idCatRecipe INT;
    DECLARE @priceRecipe FLOAT;
    DECLARE @counterSales INT = 1;
    DECLARE @counterRecipes INT = 1;
    WHILE @counterSales <= @totalSales
      BEGIN
        INSERT INTO CatSale (total, fkCatClient) VALUES (1, @fkCatClient);
        SET @idCatSale = SCOPE_IDENTITY();
        SET @totalDetailRecipes = FLOOR(RAND() * 5) + 1;
        WHILE @counterRecipes <= @totalDetailRecipes
          BEGIN
            SET @totalRecipes = FLOOR(RAND() * 3) + 1;
            SET @idCatRecipe = (SELECT TOP 1 idCatRecipe FROM CatRecipe WHERE quantityStock >= @totalRecipes AND quantityStock > 0 ORDER BY NEWID());
            IF @idCatRecipe > 0
              BEGIN
                SET @priceRecipe = (SELECT price FROM CatRecipe WHERE idCatRecipe = @idCatRecipe);
                IF (SELECT COUNT(*) FROM DetailSale WHERE fkCatRecipe = @idCatRecipe AND fkCatSale = @idCatSale) > 0
                  BEGIN
                    UPDATE DetailSale
                      SET quantity = quantity + @totalRecipes,
                          price = price + (@priceRecipe * @totalRecipes)
                      WHERE fkCatRecipe = @idCatRecipe AND fkCatSale = @idCatSale;
                  END
                ELSE
                  BEGIN
                    INSERT INTO DetailSale (quantity, price, fkCatRecipe, fkCatSale) VALUES (@totalRecipes, (@priceRecipe * @totalRecipes), @idCatRecipe, @idCatSale);
                  END
                UPDATE CatRecipe SET quantityStock = (quantityStock - @totalRecipes) WHERE idCatRecipe = @idCatRecipe;
                INSERT INTO CatShipment (delivered, fkCatSale, fkCatEmployee) VALUES ((ABS(CHECKSUM(NEWID())) % 2), @idCatSale, 8);
              END
            SET @counterRecipes = @counterRecipes + 1;
          END
        IF (SELECT COUNT(*) FROM DetailSale WHERE fkCatSale = @idCatSale) = 0
          BEGIN
            DELETE FROM CatSale WHERE idCatSale = @idCatSale;
          END
        SET @counterRecipes = 1;
        SET @counterSales = @counterSales + 1;
      END
  END;
GO


EXEC procedureFillingInsertSales 1, 10;
EXEC procedureFillingInsertSales 2, 29;
EXEC procedureFillingInsertSales 3, 37;
EXEC procedureFillingInsertSales 4, 41;
EXEC procedureFillingInsertSales 5, 31;
EXEC procedureFillingInsertSales 6, 34;
EXEC procedureFillingInsertSales 7, 35;
EXEC procedureFillingInsertSales 8, 39;
EXEC procedureFillingInsertSales 9, 40;
EXEC procedureFillingInsertSales 10, 43;
EXEC procedureFillingInsertSales 11, 46;
EXEC procedureFillingInsertSales 12, 71;
EXEC procedureFillingInsertSales 13, 78;
EXEC procedureFillingInsertSales 14, 82;
EXEC procedureFillingInsertSales 15, 83;
EXEC procedureFillingInsertSales 16, 94;
GO


UPDATE CatSale
SET total = subquery.sum_quantity
FROM (
    SELECT fkCatSale, SUM(price) AS sum_quantity
    FROM DetailSale
    GROUP BY fkCatSale
) AS subquery
WHERE CatSale.idCatSale = subquery.fkCatSale;
GO

