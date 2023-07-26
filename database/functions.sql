
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
EXEC procedureInsertUnitMeasure 'Litro';
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

CREATE PROCEDURE procedureInsertDetailColors (
  @type VARCHAR(255),
  @idCatalog INT,
  @jsonRoles NVARCHAR(MAX)
)
AS
BEGIN
  DECLARE @jsonTable TABLE (
    idJson INT
  )
  INSERT INTO @jsonTable (idJson)
    SELECT Value
    FROM OPENJSON(@jsonRoles)
  DECLARE @idJson INT
  DECLARE jsonCursor CURSOR FOR
  SELECT idJson FROM @jsonTable
  OPEN jsonCursor
  FETCH NEXT FROM jsonCursor INTO @idJson
  IF @type = 'DetailRawMaterial'
    BEGIN
      WHILE @@FETCH_STATUS = 0
        BEGIN
          INSERT INTO DetailRawMaterialColor (fkCatRawMaterial, fkCatColor)
          VALUES (@idCatalog, @idJson);
          FETCH NEXT FROM jsonCursor INTO @idJson
        END
    END
  IF @type = 'DetailRecipe'
    BEGIN
      WHILE @@FETCH_STATUS = 0
        BEGIN
          INSERT INTO DetailRecipeColor (fkCatRecipe, fkCatColor)
          VALUES (@idCatalog, @idJson);
          FETCH NEXT FROM jsonCursor INTO @idJson
        END
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
  @jsonRoles NVARCHAR(MAX)
)
AS
BEGIN
  DECLARE @idCatRecipe INT;
  INSERT INTO CatRecipe (name, price, imagePath, fkCatSize) VALUES (@name, @price, @imagePath, @fkCatSize);
  SET @idCatRecipe = SCOPE_IDENTITY();
  EXEC procedureInsertDetailColors 'DetailRecipe', @idCatRecipe, @jsonRoles;
END;
GO

EXEC procedureInsertRecipe 'algo', 0, 1, '[1,2,3]';
