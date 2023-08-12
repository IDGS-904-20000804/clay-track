INSERT INTO CatImage (FileName, FileExtension, FileSizeInBytes, FilePath) VALUES ('azulejo', 'jpg', 57692, 'C:\\Users\\user\\Git_Workspace\\school\\clay-track\\database\\generator\\python\\downloaded_images\\azulejo.jpg');
INSERT INTO CatImage (FileName, FileExtension, FileSizeInBytes, FilePath) VALUES ('bide', 'jpg', 84157, 'C:\\Users\\user\\Git_Workspace\\school\\clay-track\\database\\generator\\python\\downloaded_images\\bide.jpg');
INSERT INTO CatImage (FileName, FileExtension, FileSizeInBytes, FilePath) VALUES ('cacerola', 'jpg', 10029, 'C:\\Users\\user\\Git_Workspace\\school\\clay-track\\database\\generator\\python\\downloaded_images\\cacerola.jpg');
INSERT INTO CatImage (FileName, FileExtension, FileSizeInBytes, FilePath) VALUES ('candelabro', 'jpg', 108705, 'C:\\Users\\user\\Git_Workspace\\school\\clay-track\\database\\generator\\python\\downloaded_images\\candelabro.jpg');
INSERT INTO CatImage (FileName, FileExtension, FileSizeInBytes, FilePath) VALUES ('cuenco', 'jpg', 3984, 'C:\\Users\\user\\Git_Workspace\\school\\clay-track\\database\\generator\\python\\downloaded_images\\cuenco.jpg');
INSERT INTO CatImage (FileName, FileExtension, FileSizeInBytes, FilePath) VALUES ('ensaladera', 'jpg', 42234, 'C:\\Users\\user\\Git_Workspace\\school\\clay-track\\database\\generator\\python\\downloaded_images\\ensaladera.jpg');
INSERT INTO CatImage (FileName, FileExtension, FileSizeInBytes, FilePath) VALUES ('florero', 'jpg', 25088, 'C:\\Users\\user\\Git_Workspace\\school\\clay-track\\database\\generator\\python\\downloaded_images\\florero.jpg');
INSERT INTO CatImage (FileName, FileExtension, FileSizeInBytes, FilePath) VALUES ('fregadero', 'jpg', 5358, 'C:\\Users\\user\\Git_Workspace\\school\\clay-track\\database\\generator\\python\\downloaded_images\\fregadero.jpg');
INSERT INTO CatImage (FileName, FileExtension, FileSizeInBytes, FilePath) VALUES ('inodoro', 'jpg', 10468, 'C:\\Users\\user\\Git_Workspace\\school\\clay-track\\database\\generator\\python\\downloaded_images\\inodoro.jpg');
INSERT INTO CatImage (FileName, FileExtension, FileSizeInBytes, FilePath) VALUES ('jarra', 'jpg', 58172, 'C:\\Users\\user\\Git_Workspace\\school\\clay-track\\database\\generator\\python\\downloaded_images\\jarra.jpg');
INSERT INTO CatImage (FileName, FileExtension, FileSizeInBytes, FilePath) VALUES ('jarron', 'jpg', 66794, 'C:\\Users\\user\\Git_Workspace\\school\\clay-track\\database\\generator\\python\\downloaded_images\\jarron.jpg');
INSERT INTO CatImage (FileName, FileExtension, FileSizeInBytes, FilePath) VALUES ('ladrillo', 'jpg', 38802, 'C:\\Users\\user\\Git_Workspace\\school\\clay-track\\database\\generator\\python\\downloaded_images\\ladrillo.jpg');
INSERT INTO CatImage (FileName, FileExtension, FileSizeInBytes, FilePath) VALUES ('lavabo', 'jpg', 30200, 'C:\\Users\\user\\Git_Workspace\\school\\clay-track\\database\\generator\\python\\downloaded_images\\lavabo.jpg');
INSERT INTO CatImage (FileName, FileExtension, FileSizeInBytes, FilePath) VALUES ('maceta', 'jpg', 34786, 'C:\\Users\\user\\Git_Workspace\\school\\clay-track\\database\\generator\\python\\downloaded_images\\maceta.jpg');
INSERT INTO CatImage (FileName, FileExtension, FileSizeInBytes, FilePath) VALUES ('mosaico', 'jpg', 58426, 'C:\\Users\\user\\Git_Workspace\\school\\clay-track\\database\\generator\\python\\downloaded_images\\mosaico.jpg');
INSERT INTO CatImage (FileName, FileExtension, FileSizeInBytes, FilePath) VALUES ('pimentero', 'jpg', 50308, 'C:\\Users\\user\\Git_Workspace\\school\\clay-track\\database\\generator\\python\\downloaded_images\\pimentero.jpg');
INSERT INTO CatImage (FileName, FileExtension, FileSizeInBytes, FilePath) VALUES ('platillo', 'jpg', 46505, 'C:\\Users\\user\\Git_Workspace\\school\\clay-track\\database\\generator\\python\\downloaded_images\\platillo.jpg');
INSERT INTO CatImage (FileName, FileExtension, FileSizeInBytes, FilePath) VALUES ('plato', 'jpg', 41898, 'C:\\Users\\user\\Git_Workspace\\school\\clay-track\\database\\generator\\python\\downloaded_images\\plato.jpg');
INSERT INTO CatImage (FileName, FileExtension, FileSizeInBytes, FilePath) VALUES ('salero', 'jpg', 5245, 'C:\\Users\\user\\Git_Workspace\\school\\clay-track\\database\\generator\\python\\downloaded_images\\salero.jpg');
INSERT INTO CatImage (FileName, FileExtension, FileSizeInBytes, FilePath) VALUES ('taza', 'jpg', 17902, 'C:\\Users\\user\\Git_Workspace\\school\\clay-track\\database\\generator\\python\\downloaded_images\\taza.jpg');
INSERT INTO CatImage (FileName, FileExtension, FileSizeInBytes, FilePath) VALUES ('tazon', 'jpg', 138988, 'C:\\Users\\user\\Git_Workspace\\school\\clay-track\\database\\generator\\python\\downloaded_images\\tazon.jpg');
INSERT INTO CatImage (FileName, FileExtension, FileSizeInBytes, FilePath) VALUES ('tetera', 'jpg', 18170, 'C:\\Users\\user\\Git_Workspace\\school\\clay-track\\database\\generator\\python\\downloaded_images\\tetera.jpg');
INSERT INTO CatImage (FileName, FileExtension, FileSizeInBytes, FilePath) VALUES ('vaso', 'jpg', 14924, 'C:\\Users\\user\\Git_Workspace\\school\\clay-track\\database\\generator\\python\\downloaded_images\\vaso.jpg');
GO

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

UPDATE CatSize SET creationDate = DATEADD(DAY, 1, '2023/05/10'), updateDate = DATEADD(DAY, 1, '2023/05/10');
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

UPDATE CatColor SET creationDate = DATEADD(DAY, 1, '2023/05/10'), updateDate = DATEADD(DAY, 1, '2023/05/10');
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

UPDATE CatUnitMeasure SET creationDate = DATEADD(DAY, 1, '2023/05/10'), updateDate = DATEADD(DAY, 1, '2023/05/10');
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
  @uuidRole NVARCHAR(255)
)
AS
BEGIN
  DECLARE @idCatPerson INT;
  DECLARE @uuidUserTable TABLE(Id NVARCHAR(256));
  DECLARE @uuidUser NVARCHAR(256);
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
  INSERT INTO AspNetUsers (
    Id,                   -- 1
    UserName,             -- 2
    NormalizedUserName,   -- 3
    Email,                -- 4
    NormalizedEmail,      -- 5
    EmailConfirmed,       -- 6
    PasswordHash,         -- 7
    SecurityStamp,        -- 8
    ConcurrencyStamp,     -- 9
    PhoneNumber,          -- 10
    PhoneNumberConfirmed, -- 11
    TwoFactorEnabled,     -- 12
    LockoutEnd,           -- 13
    LockoutEnabled,       -- 14
    AccessFailedCount     -- 15
  )
  OUTPUT inserted.Id INTO @uuidUserTable
  VALUES (
    NEWID(),                                          -- 1
    LOWER(LEFT(@email, CHARINDEX('@', @email) - 1)),  -- 2
    UPPER(LEFT(@email, CHARINDEX('@', @email) - 1)),  -- 3
    LOWER(@email),                                    -- 4
    UPPER(@email),                                    -- 5
    1,                                                -- 6
    @password,                                        -- 7
    NULL,                                  -- 8
    NULL,                               -- 9
    @phone,                                           -- 10
    0,                                                -- 11
    0,                                                -- 12
    NULL,                                             -- 13
    0,                                                -- 14
    0                                                 -- 15
  );
	SET @uuidUser = (SELECT TOP 1 Id FROM @uuidUserTable);

  INSERT INTO CatEmployee (fkCatPerson, fkRol, fkUser)
  VALUES (@idCatPerson, @uuidRole, @uuidUser);
END;
GO

UPDATE CatPerson SET creationDate = DATEADD(DAY, 1, '2023/05/10'), updateDate = DATEADD(DAY, 1, '2023/05/10')
WHERE idCatPerson IN (SELECT fkCatPerson FROM CatEmployee);
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
  DECLARE @uuidUserTable TABLE(Id NVARCHAR(256));
  DECLARE @uuidUser NVARCHAR(256);
  DECLARE @numberAleatoryDate INT;
  SET @numberAleatoryDate = CAST((FLOOR(RAND()*(25-10+1))+10) AS INT);
  INSERT INTO CatPerson (name, lastName, middleName, phone, postalCode, streetNumber, apartmentNumber, street, neighborhood, creationDate, updateDate)
  VALUES (@name, @lastName, @middleName, @phone, @postalCode, @streetNumber, @apartmentNumber, @street, @neighborhood, DATEADD(DAY, @numberAleatoryDate, '2023/05/10'), DATEADD(DAY, @numberAleatoryDate, '2023/05/10'));
  SET @idCatPerson = SCOPE_IDENTITY();

  INSERT INTO AspNetUsers (
    Id,                   -- 1
    UserName,             -- 2
    NormalizedUserName,   -- 3
    Email,                -- 4
    NormalizedEmail,      -- 5
    EmailConfirmed,       -- 6
    PasswordHash,         -- 7
    SecurityStamp,        -- 8
    ConcurrencyStamp,     -- 9
    PhoneNumber,          -- 10
    PhoneNumberConfirmed, -- 11
    TwoFactorEnabled,     -- 12
    LockoutEnd,           -- 13
    LockoutEnabled,       -- 14
    AccessFailedCount     -- 15
  )
  OUTPUT inserted.Id INTO @uuidUserTable
  VALUES (
    NEWID(),                                          -- 1
    LOWER(LEFT(@email, CHARINDEX('@', @email) - 1)),  -- 2
    UPPER(LEFT(@email, CHARINDEX('@', @email) - 1)),  -- 3
    LOWER(@email),                                    -- 4
    UPPER(@email),                                    -- 5
    1,                                                -- 6
    @password,                                        -- 7
    NULL,                                             -- 8
    NULL,                                             -- 9
    @phone,                                           -- 10
    0,                                                -- 11
    0,                                                -- 12
    NULL,                                             -- 13
    0,                                                -- 14
    0                                                 -- 15
  );
	SET @uuidUser = (SELECT TOP 1 Id FROM @uuidUserTable);
  INSERT INTO CatClient (fkCatPerson, fkRol, fkUser)
  VALUES (@idCatPerson, 'a71a55d6-99d7-4123-b4e0-1218ecb90e3e', @uuidUser);
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

UPDATE CatPerson SET creationDate = DATEADD(DAY, 1, '2023/05/10'), updateDate = DATEADD(DAY, 1, '2023/05/10')
WHERE idCatPerson IN (SELECT fkCatPerson FROM CatSupplier);
GO



EXEC procedureInsertEmployee 'Olatz','Puerto','Trujillo','+514778852126','37138','704',null,'Lucita','Gran Jardín',
'AMmAWUeqhXPmdD97QBTn5GmGnDrwAoaEym8sk5niig8SIoF/FTKQHn/EHYX3te0KwQ==', -- paswordshashes
'c309fa92-2123-47be-b397-adfdgdfg3344';
EXEC procedureInsertEmployee 'Raúl','Avila','Palacios','+514771181062','37353','821','B','Calle Efraín Calderón','Pedregal del Sol',
'ABwI89M9WSSdxmFZnY6bWwq4IaDERWRJVs8z7M0jj5EcKhjBFHFxvRaELfbFzzLjvA==', -- paswordshashes
'c309fa92-2123-47be-b397-adfdgdfg3344';
EXEC procedureInsertEmployee 'Neus','Villar','Villar','+514775395135','37548','548','B','Calle Sarmiento','Luz del Refugio',
'AB0qjBdQ2lNe1Lhp/5N//edUiqK7sATmo3Bv+9YqAPY+IY/XwHIcjSmQt8/5dijLDQ==', -- paswordshashes
'c309fa92-2123-47be-b397-adfdgdfg3344';
EXEC procedureInsertEmployee 'Rachid','Ubeda','Mosquera','+514771985903','37550','188','B','Lucita','Cumbres de la Pradera',
'AL+Me//qUmC3vdccx5gIlAoMJO3pJlvTI7bUK1Ztx/z75cOROFWwWAT+WzrE+NYy+w==', -- paswordshashes
'c309fa92-2123-47be-b397-adfdgdfg3344';
EXEC procedureInsertEmployee 'Claudio','Leon','Alcantara','+514778900172','37295','696',null,'Calle Bosque Del Carajonai','Jardines de San Juan',
'ALk6z9zy3ZJrPVeXQmLz+cu3nlNJS549gYnqcxS14v6Hjl6gh8KaJU11vFIcm+8/YA==', -- paswordshashes
'c309fa92-2123-47be-b397-adfdgdfg3344';
EXEC procedureInsertEmployee 'Manel','Cardona','Moyano','+514778148765','37530','243',null,'Calle Parque Guatemala','Residencial San Isidro',
'AM6MXii+5IVIX2RFQtnO6gJbRQaBxT6nQ4A2DEyP3ughjk7o2CSO2m8sPaRdYYw1Xw==', -- paswordshashes
'c309fa92-2123-47be-b397-adfdgdfg3344';
EXEC procedureInsertEmployee 'Catalina','Guevara','Quiroga','+514770482841','37210','200','A','Calle San Matías','Praderas de Santa Rosa',
'AFlCWIYpCz2EiJLcJvxBjh+K9nxZOY/qNJGR0sdbScHIEhkAfIfmMdhZjOo8z4rBIg==', -- paswordshashes
'c309fa92-2123-47be-b397-adfdgdfg3344';
EXEC procedureInsertEmployee 'Aurea','Lazaro','Miranda','+514773943080','37280','220','B','Calle Bosque Del Carajonai','Arboledas de San Pedro',
'AN+hXbArLloy4xzbdROIjQUq4+BNbCwGNieCdF93X78xYg2qdrsDwMSaeTxnkYcJDw==', -- paswordshashes
'c309fa92-2123-47be-b397-adfdgdfg3344';
EXEC procedureInsertEmployee 'Gumersindo','Moro','Peiro','+514778190823','37680','291',null,'Calle Campo Verde','Álvaro Obregón (Santa Ana del Conde)',
'AA9eMWHV7zHpwhXq7vcQHvnaDB/qyct0+Bvc8x0Fg+UufoG3IWJuuyD+30uSOhrIbw==', -- paswordshashes
'c309fa92-2123-47be-b397-adfdgdfg3344';
EXEC procedureInsertEmployee 'Josefa','Robledo','Robledo','+514773750303','37238','778','C','Calle Mar Jónico','Prado Hermoso',
'ABc53ZVxy/XqMTm5NKBP9URi4jN1VlR5hikrDc59l71CM8UP525KWWuS7Qk0SIzxxA==', -- paswordshashes
'c309fa92-2123-47be-b397-adfdgdfg3344';
EXEC procedureInsertEmployee 'Eladio','Peiro','Tirado','+514775263673','37357','272',null,'Andador De La Esponja','Centro Familiar Soledad',
'AJlGIzWVgYsa4G/rSxp5MUtBsf8Wc5FneCma8sGTigpIPcS1NQcEOviHqkZDgIrcqg==', -- paswordshashes
'c309fa92-2123-47be-b397-adfdgdfg3344';
EXEC procedureInsertEmployee 'Alain','Grande','Fernández','+514777837646','37207','230',null,'Calle Noria De Los Pedregales','El Consuelo',
'AGWtyK6neuTgLSOS4mlp3MIk64nztwwg1BE0bOpK2lkLXZWQQAzlx360I6l63Ndqhg==', -- paswordshashes 'c309fa92-2123-47be-b397-a1c77adb502c';
EXEC procedureInsertEmployee 'Marcial','García','Puerto','+514775653880','37538','916','B','Privada San Anselmo','Loma Hermosa',
'AJN0lP8bw/3lildKNNeL7hAsn94jWqGIypucdzJH8bUJ7RJ754UjeKands/mWjDLnQ==', -- paswordshashes
'c309fa92-2123-47be-b397-adfdgdfg3344';
EXEC procedureInsertEmployee 'Izaskun','Sanchez','Grande','+514775519653','37299','712','A','Privada Cervera','Soberna',
'ALk0N4KysLM7UYI+96wI3pNMSiUzcEJ7GvE09ZAZGoD4wWQEB3Qf3ol+mD71ob0atw==', -- paswordshashes
'c309fa92-2123-47be-b397-adfdgdfg3344';
EXEC procedureInsertEmployee 'Montse','Cantero','Herranz','+514777954784','37204','840',null,'Calle 18','Cibeles',
'AFhvWm5rSZjg26q3rWm+n/sLtWN0mXGUQkhPVMZrWM/Srgd6276xcNZ0xL2VPo2PdQ==', -- paswordshashes
'c309fa92-2123-47be-b397-adfdgdfg3344';
EXEC procedureInsertEmployee 'Sagrario','Moyano','Martin','+514777834299','37419','329',null,'Calle De La Col','Las Mandarinas',
'AEImwHapXb7Lv+3yTzQuz+GpfbNJ/U0s7A/Y7S6fZ9VkcXq4N+nc5LXJhiZCDlIkww==', -- paswordshashes
'c309fa92-2123-47be-b397-adfdgdfg3344';
EXEC procedureInsertEmployee 'Zaida','Cuadrado','Garrido','+514776424326','37669','134','B','León','Los Laureles',
'APH/afT0AT3OTrarF5GJgdFdio8qg9j0CbYsyl/kbYZXdfkXs761SyeUDGeezwMGeg==', -- paswordshashes
'c309fa92-2123-47be-b397-adfdgdfg3344';
EXEC procedureInsertEmployee 'Cayetano','Estrada','Sanchez','+514778884326','37287','610',null,'Lucita','Residencial San Ángel',
'AFRx494nOFzHt4RY3W2Q1dJVxD6GYcMZ3j/erYCI4+6FKs0VXCImrDWDF7ym1iGWqA==', -- paswordshashes
'c309fa92-2123-47be-b397-adfdgdfg3344';
EXEC procedureInsertEmployee 'Iris','Marin','Ubeda','+514771149094','37549','265',null,'San Carlos','Unión Obrera',
'ADMcD5v2Xf/XQtBrLy4h79GnK0UK9AGvAx/xSa2p7DPa/V1j4wowzyaJ+7+SO81ETQ==', -- paswordshashes
'c309fa92-2123-47be-b397-adfdgdfg3344';
GO



EXEC procedureInsertClient 'Francisco','Gaspar','Avila','+514777710708','37128','773',null,'Mayorazgo De Taboalapa','Misión La Cañada', 'FRANCISCO_la332@gmail.com',
'AFRp5PihLF+zbkFYSn2lCmkaSJlnGNHgIwQj70U5UsOQAlKmYx4IoB/jrYb1uISheQ=='; -- paswordshashes
EXEC procedureInsertClient 'Iryna','Fernández','Valero','+514775088347','37555','547','B','Boulevard Paseo De Los Insurgentes','San José de Cementos', 'IRYNA_ro349@gmail.com',
'AOuXcTvE4W3XUzHP8WsaxeB12vH4pihsWlrZa+s0/jHR2/Ky3H8l7Y1cBJc3Un/ZIg=='; -- paswordshashes
EXEC procedureInsertClient 'Noel','Mosquera','Estrada','+514772665826','37670','142','C','Calle Parque La Granada','La Laborcita', 'NOEL_da366@gmail.com',
'AK0vlKnYG7RNKFvdUDzCd8YXqPqOagCqnNRh4blq5iwtz7vRBdMgpZi49syKN6YowA=='; -- paswordshashes
EXEC procedureInsertClient 'Hilario','Alcantara','Moyano','+514773103141','37210','873',null,'Calle San Florencio','Residencial Villa Contemporánea', 'HILARIO_no383@gmail.com',
'AHGS02kkUtEVSQ4H7qX/l8ChLOWL4Uup++PknLQpUzHcLFuVH9CJ9O1EMK4m1iR8jQ=='; -- paswordshashes
EXEC procedureInsertClient 'Florin','Beltran','Rivera','+514772280363','37689','402',null,'Ramal A San Pedro Del Monte','Capellanía de San Sebastián', 'FLORIN_ra400@gmail.com',
'AH30onoKyaLQq6VowD/XbGQ9a0TxGI9oyipt7vbXoyYyGSWZx6RX4x6f2trXG+szOQ=='; -- paswordshashes
EXEC procedureInsertClient 'German','Rivera','Alcantara','+514777270751','37669','453','A','Boulevard Delta','Katania', 'GERMAN_ra417@gmail.com',
'AAdI08V8pYYaYV7XZlfMJpN73OCU6FSoVsQ2ZWZkQiqfqjN4vbwQZETbWdiOcbRDWA=='; -- paswordshashes
EXEC procedureInsertClient 'Unax','Verdu','Yañez','+514772750921','37355','784','C','Calle Mezquite De Jerez','Real 2000', 'UNAX_ez434@gmail.com',
'AHWcqK4XojxArAMOBGR35TeIj//S8Z3vj3C7AUquJ6SPMjWil39Jzc99EcbQ7i3KxA=='; -- paswordshashes
EXEC procedureInsertClient 'Unai','Hidalgo','Felipe','+514774175683','37278','839',null,'Calle Bosque Del Ocote','Popular Inca', 'UNAI_pe451@gmail.com',
'ADeasR6iUctuUigaDIH2cyV7RjnmzVCQou5iYqNp2lBIFfIGYuZVizM/rlsr2A7umg=='; -- paswordshashes
EXEC procedureInsertClient 'Fabian','Quiroga','Ubeda','+514771294823','37288','207','C','Calle Santa Crocce','Villa Verde', 'FABIAN_da468@gmail.com',
'AMZwzhLgcaVrH+dNCBGZZI8edfSM9CW0jZovkdxYbJ0GOAHIVjQHu2S25iID+1L0Dg=='; -- paswordshashes
EXEC procedureInsertClient 'Maria','Cabanillas','García','+514775152672','37259','751',null,'Calle Paseo De Los Verdines','San Manuel', 'MARIA_ia485@gmail.com',
'AGRNuWVkRjSCzMTfJ8P5qceS7qeLeC+vcPpGx3qN4nNadbhaKZnUb7/BfOEJjTJluA=='; -- paswordshashes
EXEC procedureInsertClient 'Narciso','Reyes','Verdu','+514775894018','37687','516','C','Chupicuaro','La Estancia de la Sandía', 'NARCISO_du502@gmail.com',
'ALkCjnsMLkV1ZHMONXaUuDK10TMC9H6y6zya0CJt5Xwincm/iWXGeiSe8Sci6Fj81g=='; -- paswordshashes
EXEC procedureInsertClient 'Anibal','Garrido','Valero','+514773509338','37125','452',null,'Calle Paraíso','Fracciones del Rosario', 'ANIBAL_ro519@gmail.com',
'AIL8ZQEXO7dDDDSi+N8ZxQqSFfP0oy9U0ILfWZNNVwnCVLKsVuxRRi/1BJyYdZxn/Q=='; -- paswordshashes
EXEC procedureInsertClient 'Jeronima','Tirado','Martorell','+514775794020','37118','357','A','Calle Del Narciso','Jardines del Valle', 'JERONIMA_ll536@gmail.com',
'ALzmsEtdqlnekV58XM6l0Ck2PeG0XHcMfmTioyoutom+QfqbEGIKNUS0IFXztC3C7Q=='; -- paswordshashes
EXEC procedureInsertClient 'Segundo','Martin','Gaspar','+514773680309','37555','126',null,'Calle Industrial Morelos','Praderas del Bosque', 'SEGUNDO_ar553@gmail.com',
'AKJdPFzt3K8+dBSEv3tk+bgO71/f1+zCkoUd7mCYHhtDA+rBSHatqkLwgxVxeA4HrA=='; -- paswordshashes
EXEC procedureInsertClient 'Julia','Yañez','Gaspar','+514779839014','37328','756',null,'Valeriana','Moderna', 'JULIA_ar570@gmail.com',
'APGBsDf8cG8jqpaTAzLSNZo5eEOfIFrS23dHaSs0CC5/Ajp7Ev1CyTt5VheijgZjxg=='; -- paswordshashes
EXEC procedureInsertClient 'Leire','Martorell','Fernández','+514777531816','37100','836',null,'Boulevard Antonio Martínez Aguayo','Privada Echeveste', 'LEIRE_ez587@gmail.com',
'ALZfSozQTvxBrrx95ScdN43fcJcn+sE/LbIfYI/hCwpjsm1mE89URU2gAwQVCUpsWQ=='; -- paswordshashes
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

UPDATE CatRawMaterial SET creationDate = DATEADD(DAY, 1, '2023/05/10'), updateDate = DATEADD(DAY, 1, '2023/05/10');
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
  @fkCatSize INT,
  @jsonColors NVARCHAR(MAX),
  @jsonRawMaterial NVARCHAR(MAX),
  @idCatImage INT
)
AS
BEGIN
  DECLARE @idCatRecipe INT;
  INSERT INTO CatRecipe (name, price, fkCatSize, fkCatImage) VALUES (@name, @price, @fkCatSize, @idCatImage);
  SET @idCatRecipe = SCOPE_IDENTITY();
  EXEC procedureInsertDetailColors @idCatRecipe, @jsonColors;
  EXEC procedureInsertDetailRawMaterial @idCatRecipe, @jsonRawMaterial;
END;
GO

UPDATE CatRecipe SET creationDate = DATEADD(DAY, 1, '2023/05/10'), updateDate = DATEADD(DAY, 1, '2023/05/10');
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
  @nameBase VARCHAR(255),
  @jsonIdRawMaterial NVARCHAR(MAX),
  @idCatImage INT
)
AS
BEGIN
  DECLARE @jsonDetailRawMaterial NVARCHAR(MAX);
  DECLARE @jsonData NVARCHAR(MAX);
  DECLARE @mergedJson NVARCHAR(MAX);
  DECLARE @name VARCHAR(255);

  SET @name = CONCAT(@nameBase, ' color solido');

  SET @jsonData = '[{"quantity":1,"fkCatRawMaterial":29},{"quantity":1,"fkCatRawMaterial":30}]';
  SET @mergedJson = dbo.mergeJsonWithIdsAndData(@jsonIdRawMaterial, @jsonData);
  EXEC procedureInsertRecipe @name, 0, 1, '[1]', @mergedJson, @idCatImage;
  SET @mergedJson = dbo.mergeJsonWithIdsAndData(@jsonIdRawMaterial, @jsonData);
  EXEC procedureInsertRecipe @name, 0, 2, '[1]', @mergedJson, @idCatImage;
  SET @mergedJson = dbo.mergeJsonWithIdsAndData(@jsonIdRawMaterial, @jsonData);
  EXEC procedureInsertRecipe @name, 0, 3, '[1]', @mergedJson, @idCatImage;

  SET @jsonData = '[{"quantity":1,"fkCatRawMaterial":31},{"quantity":1,"fkCatRawMaterial":29}]';
  SET @mergedJson = dbo.mergeJsonWithIdsAndData(@jsonIdRawMaterial, @jsonData);
  EXEC procedureInsertRecipe @name, 0, 1, '[2]', @mergedJson, @idCatImage;
  SET @mergedJson = dbo.mergeJsonWithIdsAndData(@jsonIdRawMaterial, @jsonData);
  EXEC procedureInsertRecipe @name, 0, 2, '[2]', @mergedJson, @idCatImage;
  SET @mergedJson = dbo.mergeJsonWithIdsAndData(@jsonIdRawMaterial, @jsonData);
  EXEC procedureInsertRecipe @name, 0, 3, '[2]', @mergedJson, @idCatImage;

  SET @jsonData = '[{"quantity":1,"fkCatRawMaterial":32},{"quantity":1,"fkCatRawMaterial":29}]';
  SET @mergedJson = dbo.mergeJsonWithIdsAndData(@jsonIdRawMaterial, @jsonData);
  EXEC procedureInsertRecipe @name, 0, 1, '[3]', @mergedJson, @idCatImage;
  SET @mergedJson = dbo.mergeJsonWithIdsAndData(@jsonIdRawMaterial, @jsonData);
  EXEC procedureInsertRecipe @name, 0, 2, '[3]', @mergedJson, @idCatImage;
  SET @mergedJson = dbo.mergeJsonWithIdsAndData(@jsonIdRawMaterial, @jsonData);
  EXEC procedureInsertRecipe @name, 0, 3, '[3]', @mergedJson, @idCatImage;

  SET @jsonData = '[{"quantity":1,"fkCatRawMaterial":33},{"quantity":1,"fkCatRawMaterial":32},{"quantity":1,"fkCatRawMaterial":29}]';
  SET @mergedJson = dbo.mergeJsonWithIdsAndData(@jsonIdRawMaterial, @jsonData);
  EXEC procedureInsertRecipe @name, 0, 1, '[4]', @mergedJson, @idCatImage;
  SET @mergedJson = dbo.mergeJsonWithIdsAndData(@jsonIdRawMaterial, @jsonData);
  EXEC procedureInsertRecipe @name, 0, 2, '[4]', @mergedJson, @idCatImage;
  SET @mergedJson = dbo.mergeJsonWithIdsAndData(@jsonIdRawMaterial, @jsonData);
  EXEC procedureInsertRecipe @name, 0, 3, '[4]', @mergedJson, @idCatImage;

  SET @jsonData = '[{"quantity":1,"fkCatRawMaterial":34},{"quantity":1,"fkCatRawMaterial":35},{"quantity":1,"fkCatRawMaterial":36}]';
  SET @mergedJson = dbo.mergeJsonWithIdsAndData(@jsonIdRawMaterial, @jsonData);
  EXEC procedureInsertRecipe @name, 0, 1, '[5]', @mergedJson, @idCatImage;
  SET @mergedJson = dbo.mergeJsonWithIdsAndData(@jsonIdRawMaterial, @jsonData);
  EXEC procedureInsertRecipe @name, 0, 2, '[5]', @mergedJson, @idCatImage;
  SET @mergedJson = dbo.mergeJsonWithIdsAndData(@jsonIdRawMaterial, @jsonData);
  EXEC procedureInsertRecipe @name, 0, 3, '[5]', @mergedJson, @idCatImage;

  SET @jsonData = '[{"quantity":1,"fkCatRawMaterial":37},{"quantity":1,"fkCatRawMaterial":36},{"quantity":1,"fkCatRawMaterial":29}]';
  SET @mergedJson = dbo.mergeJsonWithIdsAndData(@jsonIdRawMaterial, @jsonData);
  EXEC procedureInsertRecipe @name, 0, 1, '[6]', @mergedJson, @idCatImage;
  SET @mergedJson = dbo.mergeJsonWithIdsAndData(@jsonIdRawMaterial, @jsonData);
  EXEC procedureInsertRecipe @name, 0, 2, '[6]', @mergedJson, @idCatImage;
  SET @mergedJson = dbo.mergeJsonWithIdsAndData(@jsonIdRawMaterial, @jsonData);
  EXEC procedureInsertRecipe @name, 0, 3, '[6]', @mergedJson, @idCatImage;

  SET @jsonData = '[{"quantity":1,"fkCatRawMaterial":33},{"quantity":1,"fkCatRawMaterial":29}]';
  SET @mergedJson = dbo.mergeJsonWithIdsAndData(@jsonIdRawMaterial, @jsonData);
  EXEC procedureInsertRecipe @name, 0, 1, '[7]', @mergedJson, @idCatImage;
  SET @mergedJson = dbo.mergeJsonWithIdsAndData(@jsonIdRawMaterial, @jsonData);
  EXEC procedureInsertRecipe @name, 0, 2, '[7]', @mergedJson, @idCatImage;
  SET @mergedJson = dbo.mergeJsonWithIdsAndData(@jsonIdRawMaterial, @jsonData);
  EXEC procedureInsertRecipe @name, 0, 3, '[7]', @mergedJson, @idCatImage;

  SET @jsonData = '[{"quantity":1,"fkCatRawMaterial":36},{"quantity":1,"fkCatRawMaterial":32}]';
  SET @mergedJson = dbo.mergeJsonWithIdsAndData(@jsonIdRawMaterial, @jsonData);
  EXEC procedureInsertRecipe @name, 0, 1, '[8]', @mergedJson, @idCatImage;
  SET @mergedJson = dbo.mergeJsonWithIdsAndData(@jsonIdRawMaterial, @jsonData);
  EXEC procedureInsertRecipe @name, 0, 2, '[8]', @mergedJson, @idCatImage;
  SET @mergedJson = dbo.mergeJsonWithIdsAndData(@jsonIdRawMaterial, @jsonData);
  EXEC procedureInsertRecipe @name, 0, 3, '[8]', @mergedJson, @idCatImage;

  SET @jsonData = '[{"quantity":1,"fkCatRawMaterial":38},{"quantity":1,"fkCatRawMaterial":39}]';
  SET @mergedJson = dbo.mergeJsonWithIdsAndData(@jsonIdRawMaterial, @jsonData);
  EXEC procedureInsertRecipe @name, 0, 1, '[9]', @mergedJson, @idCatImage;
  SET @mergedJson = dbo.mergeJsonWithIdsAndData(@jsonIdRawMaterial, @jsonData);
  EXEC procedureInsertRecipe @name, 0, 2, '[9]', @mergedJson, @idCatImage;
  SET @mergedJson = dbo.mergeJsonWithIdsAndData(@jsonIdRawMaterial, @jsonData);
  EXEC procedureInsertRecipe @name, 0, 3, '[9]', @mergedJson, @idCatImage;

  SET @jsonData = '[{"quantity":1,"fkCatRawMaterial":33},{"quantity":1,"fkCatRawMaterial":38}]';
  SET @mergedJson = dbo.mergeJsonWithIdsAndData(@jsonIdRawMaterial, @jsonData);
  EXEC procedureInsertRecipe @name, 0, 1, '[10]', @mergedJson, @idCatImage;
  SET @mergedJson = dbo.mergeJsonWithIdsAndData(@jsonIdRawMaterial, @jsonData);
  EXEC procedureInsertRecipe @name, 0, 2, '[10]', @mergedJson, @idCatImage;
  SET @mergedJson = dbo.mergeJsonWithIdsAndData(@jsonIdRawMaterial, @jsonData);
  EXEC procedureInsertRecipe @name, 0, 3, '[10]', @mergedJson, @idCatImage;

  SET @name = CONCAT(@nameBase, ' colores');

  SET @jsonData = '[{"quantity":3,"fkCatRawMaterial":29},{"quantity":1,"fkCatRawMaterial":31},{"quantity":1,"fkCatRawMaterial":32},{"quantity":1,"fkCatRawMaterial":33},{"quantity":1,"fkCatRawMaterial":38}]';
  SET @mergedJson = dbo.mergeJsonWithIdsAndData(@jsonIdRawMaterial, @jsonData);
  EXEC procedureInsertRecipe @name, 0, 1, '[2,4,9]', @mergedJson, @idCatImage;
  SET @mergedJson = dbo.mergeJsonWithIdsAndData(@jsonIdRawMaterial, @jsonData);
  EXEC procedureInsertRecipe @name, 0, 2, '[2,4,9]', @mergedJson, @idCatImage;
  SET @mergedJson = dbo.mergeJsonWithIdsAndData(@jsonIdRawMaterial, @jsonData);
  EXEC procedureInsertRecipe @name, 0, 3, '[2,4,9]', @mergedJson, @idCatImage;

  SET @jsonData = '[{"quantity":2,"fkCatRawMaterial":29},{"quantity":1,"fkCatRawMaterial":30},{"quantity":2,"fkCatRawMaterial":32},{"quantity":1,"fkCatRawMaterial":36}]';
  SET @mergedJson = dbo.mergeJsonWithIdsAndData(@jsonIdRawMaterial, @jsonData);
  EXEC procedureInsertRecipe @name, 0, 1, '[1,3,8]', @mergedJson, @idCatImage;
  SET @mergedJson = dbo.mergeJsonWithIdsAndData(@jsonIdRawMaterial, @jsonData);
  EXEC procedureInsertRecipe @name, 0, 2, '[1,3,8]', @mergedJson, @idCatImage;
  SET @mergedJson = dbo.mergeJsonWithIdsAndData(@jsonIdRawMaterial, @jsonData);
  EXEC procedureInsertRecipe @name, 0, 3, '[1,3,8]', @mergedJson, @idCatImage;

  SET @jsonData = '[{"quantity":2,"fkCatRawMaterial":29},{"quantity":1,"fkCatRawMaterial":30},{"quantity":1,"fkCatRawMaterial":34},{"quantity":1,"fkCatRawMaterial":35},{"quantity":2,"fkCatRawMaterial":36},{"quantity":1,"fkCatRawMaterial":37}]';
  SET @mergedJson = dbo.mergeJsonWithIdsAndData(@jsonIdRawMaterial, @jsonData);
  EXEC procedureInsertRecipe @name, 0, 1, '[5,6,1]', @mergedJson, @idCatImage;
  SET @mergedJson = dbo.mergeJsonWithIdsAndData(@jsonIdRawMaterial, @jsonData);
  EXEC procedureInsertRecipe @name, 0, 2, '[5,6,1]', @mergedJson, @idCatImage;
  SET @mergedJson = dbo.mergeJsonWithIdsAndData(@jsonIdRawMaterial, @jsonData);
  EXEC procedureInsertRecipe @name, 0, 3, '[5,6,1]', @mergedJson, @idCatImage;

  SET @jsonData = '[{"quantity":2,"fkCatRawMaterial":29},{"quantity":1,"fkCatRawMaterial":32},{"quantity":2,"fkCatRawMaterial":33},{"quantity":2,"fkCatRawMaterial":38}]';
  SET @mergedJson = dbo.mergeJsonWithIdsAndData(@jsonIdRawMaterial, @jsonData);
  EXEC procedureInsertRecipe @name, 0, 1, '[10,4,9]', @mergedJson, @idCatImage;
  SET @mergedJson = dbo.mergeJsonWithIdsAndData(@jsonIdRawMaterial, @jsonData);
  EXEC procedureInsertRecipe @name, 0, 2, '[10,4,9]', @mergedJson, @idCatImage;
  SET @mergedJson = dbo.mergeJsonWithIdsAndData(@jsonIdRawMaterial, @jsonData);
  EXEC procedureInsertRecipe @name, 0, 3, '[10,4,9]', @mergedJson, @idCatImage;

  END;
GO


CREATE PROCEDURE procedureInsertAllFillingInsertRecipe
AS
BEGIN
  DECLARE @idCatImage INT;
  SELECT TOP 1 @idCatImage = IdCatImage FROM CatImage WHERE FileName = 'azulejo';
  EXEC procedureFillingInsertRecipe 'Azulejo', '[6,13,16,19,44]', @idCatImage;
  SELECT TOP 1 @idCatImage = IdCatImage FROM CatImage WHERE FileName = 'bide';
  EXEC procedureFillingInsertRecipe 'Bidé', '[8,14,17,20,44]', @idCatImage;
  SELECT TOP 1 @idCatImage = IdCatImage FROM CatImage WHERE FileName = 'cacerola';
  EXEC procedureFillingInsertRecipe 'Cacerola', '[9,15,18,22,45]', @idCatImage;
  SELECT TOP 1 @idCatImage = IdCatImage FROM CatImage WHERE FileName = 'candelabro';
  EXEC procedureFillingInsertRecipe 'Candelabro', '[7,15,18]', @idCatImage;
  SELECT TOP 1 @idCatImage = IdCatImage FROM CatImage WHERE FileName = 'cuenco';
  EXEC procedureFillingInsertRecipe 'Cuenco', '[6,13,18]', @idCatImage;
  SELECT TOP 1 @idCatImage = IdCatImage FROM CatImage WHERE FileName = 'ensaladera';
  EXEC procedureFillingInsertRecipe 'Ensaladera', '[8,13,18]', @idCatImage;
  SELECT TOP 1 @idCatImage = IdCatImage FROM CatImage WHERE FileName = 'florero';
  EXEC procedureFillingInsertRecipe 'Florero', '[6,13,18]', @idCatImage;
  SELECT TOP 1 @idCatImage = IdCatImage FROM CatImage WHERE FileName = 'fregadero';
  EXEC procedureFillingInsertRecipe 'Fregadero', '[9,15,18,19,45]', @idCatImage;
  SELECT TOP 1 @idCatImage = IdCatImage FROM CatImage WHERE FileName = 'inodoro';
  EXEC procedureFillingInsertRecipe 'Inodoro', '[8,14,16,20,44]', @idCatImage;
  SELECT TOP 1 @idCatImage = IdCatImage FROM CatImage WHERE FileName = 'jarra';
  EXEC procedureFillingInsertRecipe 'Jarra', '[7,15,18]', @idCatImage;
  SELECT TOP 1 @idCatImage = IdCatImage FROM CatImage WHERE FileName = 'jarron';
  EXEC procedureFillingInsertRecipe 'Jarrón', '[6,13,18]', @idCatImage;
  SELECT TOP 1 @idCatImage = IdCatImage FROM CatImage WHERE FileName = 'ladrillo';
  EXEC procedureFillingInsertRecipe 'Ladrillo', '[9,18,22]', @idCatImage;
  SELECT TOP 1 @idCatImage = IdCatImage FROM CatImage WHERE FileName = 'lavabo';
  EXEC procedureFillingInsertRecipe 'Lavabo', '[8,14,16,20,44]', @idCatImage;
  SELECT TOP 1 @idCatImage = IdCatImage FROM CatImage WHERE FileName = 'maceta';
  EXEC procedureFillingInsertRecipe 'Maceta', '[6,13,18]', @idCatImage;
  SELECT TOP 1 @idCatImage = IdCatImage FROM CatImage WHERE FileName = 'mosaico';
  EXEC procedureFillingInsertRecipe 'Mosaico', '[7,15,18]', @idCatImage;
  SELECT TOP 1 @idCatImage = IdCatImage FROM CatImage WHERE FileName = 'pimentero';
  EXEC procedureFillingInsertRecipe 'Pimentero', '[6,13,18]', @idCatImage;
  SELECT TOP 1 @idCatImage = IdCatImage FROM CatImage WHERE FileName = 'platillo';
  EXEC procedureFillingInsertRecipe 'Platillo', '[8,13,18]', @idCatImage;
  SELECT TOP 1 @idCatImage = IdCatImage FROM CatImage WHERE FileName = 'plato';
  EXEC procedureFillingInsertRecipe 'Plato', '[7,15,18]', @idCatImage;
  SELECT TOP 1 @idCatImage = IdCatImage FROM CatImage WHERE FileName = 'salero';
  EXEC procedureFillingInsertRecipe 'Salero', '[6,13,16,19,44]', @idCatImage;
  SELECT TOP 1 @idCatImage = IdCatImage FROM CatImage WHERE FileName = 'taza';
  EXEC procedureFillingInsertRecipe 'Taza', '[8,14,16,20,44]', @idCatImage;
  SELECT TOP 1 @idCatImage = IdCatImage FROM CatImage WHERE FileName = 'tazon';
  EXEC procedureFillingInsertRecipe 'Tazón', '[6,13,18]', @idCatImage;
  SELECT TOP 1 @idCatImage = IdCatImage FROM CatImage WHERE FileName = 'tetera';
  EXEC procedureFillingInsertRecipe 'Tetera', '[8,13,18]', @idCatImage;
  SELECT TOP 1 @idCatImage = IdCatImage FROM CatImage WHERE FileName = 'vaso';
  EXEC procedureFillingInsertRecipe 'Vaso', '[7,15,18]', @idCatImage;

END;
GO


EXEC procedureInsertAllFillingInsertRecipe;
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

INSERT INTO CatPurchase (total, fkCatSupplier, fkCatEmployee, creationDate, updateDate) VALUES (1, 1, (SELECT TOP 1 CatEmployee.idCatEmployee FROM CatEmployee WHERE CatEmployee.fkRol = (SELECT TOP 1 Id FROM AspNetRoles WHERE AspNetRoles.Name = 'Employee') ORDER BY NEWID()), DATEADD(DAY, 8, '2023/05/10'), DATEADD(DAY, 8, '2023/05/10'));
INSERT INTO CatPurchase (total, fkCatSupplier, fkCatEmployee, creationDate, updateDate) VALUES (1, 2, (SELECT TOP 1 CatEmployee.idCatEmployee FROM CatEmployee WHERE CatEmployee.fkRol = (SELECT TOP 1 Id FROM AspNetRoles WHERE AspNetRoles.Name = 'Employee') ORDER BY NEWID()), DATEADD(DAY, 8, '2023/05/10'), DATEADD(DAY, 8, '2023/05/10'));
INSERT INTO CatPurchase (total, fkCatSupplier, fkCatEmployee, creationDate, updateDate) VALUES (1, 3, (SELECT TOP 1 CatEmployee.idCatEmployee FROM CatEmployee WHERE CatEmployee.fkRol = (SELECT TOP 1 Id FROM AspNetRoles WHERE AspNetRoles.Name = 'Employee') ORDER BY NEWID()), DATEADD(DAY, 8, '2023/05/10'), DATEADD(DAY, 8, '2023/05/10'));
INSERT INTO CatPurchase (total, fkCatSupplier, fkCatEmployee, creationDate, updateDate) VALUES (1, 4, (SELECT TOP 1 CatEmployee.idCatEmployee FROM CatEmployee WHERE CatEmployee.fkRol = (SELECT TOP 1 Id FROM AspNetRoles WHERE AspNetRoles.Name = 'Employee') ORDER BY NEWID()), DATEADD(DAY, 8, '2023/05/10'), DATEADD(DAY, 8, '2023/05/10'));
INSERT INTO CatPurchase (total, fkCatSupplier, fkCatEmployee, creationDate, updateDate) VALUES (1, 5, (SELECT TOP 1 CatEmployee.idCatEmployee FROM CatEmployee WHERE CatEmployee.fkRol = (SELECT TOP 1 Id FROM AspNetRoles WHERE AspNetRoles.Name = 'Employee') ORDER BY NEWID()), DATEADD(DAY, 8, '2023/05/10'), DATEADD(DAY, 8, '2023/05/10'));
INSERT INTO CatPurchase (total, fkCatSupplier, fkCatEmployee, creationDate, updateDate) VALUES (1, 6, (SELECT TOP 1 CatEmployee.idCatEmployee FROM CatEmployee WHERE CatEmployee.fkRol = (SELECT TOP 1 Id FROM AspNetRoles WHERE AspNetRoles.Name = 'Employee') ORDER BY NEWID()), DATEADD(DAY, 8, '2023/05/10'), DATEADD(DAY, 8, '2023/05/10'));
INSERT INTO CatPurchase (total, fkCatSupplier, fkCatEmployee, creationDate, updateDate) VALUES (1, 6, (SELECT TOP 1 CatEmployee.idCatEmployee FROM CatEmployee WHERE CatEmployee.fkRol = (SELECT TOP 1 Id FROM AspNetRoles WHERE AspNetRoles.Name = 'Employee') ORDER BY NEWID()), DATEADD(DAY, 8, '2023/05/10'), DATEADD(DAY, 8, '2023/05/10'));
INSERT INTO CatPurchase (total, fkCatSupplier, fkCatEmployee, creationDate, updateDate) VALUES (1, 6, (SELECT TOP 1 CatEmployee.idCatEmployee FROM CatEmployee WHERE CatEmployee.fkRol = (SELECT TOP 1 Id FROM AspNetRoles WHERE AspNetRoles.Name = 'Employee') ORDER BY NEWID()), DATEADD(DAY, 8, '2023/05/10'), DATEADD(DAY, 8, '2023/05/10'));
INSERT INTO CatPurchase (total, fkCatSupplier, fkCatEmployee, creationDate, updateDate) VALUES (1, 7, (SELECT TOP 1 CatEmployee.idCatEmployee FROM CatEmployee WHERE CatEmployee.fkRol = (SELECT TOP 1 Id FROM AspNetRoles WHERE AspNetRoles.Name = 'Employee') ORDER BY NEWID()), DATEADD(DAY, 8, '2023/05/10'), DATEADD(DAY, 8, '2023/05/10'));
INSERT INTO CatPurchase (total, fkCatSupplier, fkCatEmployee, creationDate, updateDate) VALUES (1, 8, (SELECT TOP 1 CatEmployee.idCatEmployee FROM CatEmployee WHERE CatEmployee.fkRol = (SELECT TOP 1 Id FROM AspNetRoles WHERE AspNetRoles.Name = 'Employee') ORDER BY NEWID()), DATEADD(DAY, 8, '2023/05/10'), DATEADD(DAY, 8, '2023/05/10'));
INSERT INTO DetailPurchase (quantity, price, fkCatRawMaterial, fkCatPurchase) VALUES (25000, 1250, 6, 1); -- Arcilla     ---- 1
INSERT INTO DetailPurchase (quantity, price, fkCatRawMaterial, fkCatPurchase) VALUES (19000, 950, 7, 1); -- Arcilla     ---- 1
INSERT INTO DetailPurchase (quantity, price, fkCatRawMaterial, fkCatPurchase) VALUES (25000, 2000, 13, 2); -- Feldespato -----2
INSERT INTO DetailPurchase (quantity, price, fkCatRawMaterial, fkCatPurchase) VALUES (100000, 8000, 14, 2); -- Feldespato -----2
INSERT INTO DetailPurchase (quantity, price, fkCatRawMaterial, fkCatPurchase) VALUES (25000, 1500, 16, 3); -- Sílice ------- 3
INSERT INTO DetailPurchase (quantity, price, fkCatRawMaterial, fkCatPurchase) VALUES (100000, 6000, 17, 3); -- Sílice ------- 3
INSERT INTO DetailPurchase (quantity, price, fkCatRawMaterial, fkCatPurchase) VALUES (50000, 2000, 19, 4); -- Almidón -------4
INSERT INTO DetailPurchase (quantity, price, fkCatRawMaterial, fkCatPurchase) VALUES (200000, 8000, 29, 5); -- Caolín  -------5
INSERT INTO DetailPurchase (quantity, price, fkCatRawMaterial, fkCatPurchase) VALUES (25000, 2000, 30, 6); -- Óxido 1 ------ 6
INSERT INTO DetailPurchase (quantity, price, fkCatRawMaterial, fkCatPurchase) VALUES (100000, 8000, 32, 6); -- Óxido 1 ------ 6
INSERT INTO DetailPurchase (quantity, price, fkCatRawMaterial, fkCatPurchase) VALUES (25000, 2000, 30, 7); -- Óxido 2 ------ 6
INSERT INTO DetailPurchase (quantity, price, fkCatRawMaterial, fkCatPurchase) VALUES (100000, 8000, 33, 7); -- Óxido 2 ------ 6
INSERT INTO DetailPurchase (quantity, price, fkCatRawMaterial, fkCatPurchase) VALUES (25000, 2000, 30, 8); -- Óxido 3 ------ 6
INSERT INTO DetailPurchase (quantity, price, fkCatRawMaterial, fkCatPurchase) VALUES (25000, 2000, 30, 8); -- Óxido 4 ------ 6
INSERT INTO DetailPurchase (quantity, price, fkCatRawMaterial, fkCatPurchase) VALUES (25000, 2000, 30, 8); -- Óxido 5 ------ 6
INSERT INTO DetailPurchase (quantity, price, fkCatRawMaterial, fkCatPurchase) VALUES (100000, 8000, 35, 9); -- Carbonato ---- 7
INSERT INTO DetailPurchase (quantity, price, fkCatRawMaterial, fkCatPurchase) VALUES (150000, 12000, 44, 10); -- Esmalte ----- 8

INSERT INTO CatPurchase (total, fkCatSupplier, fkCatEmployee, creationDate, updateDate) VALUES (1, 1, (SELECT TOP 1 CatEmployee.idCatEmployee FROM CatEmployee WHERE CatEmployee.fkRol = (SELECT TOP 1 Id FROM AspNetRoles WHERE AspNetRoles.Name = 'Employee') ORDER BY NEWID()), DATEADD(DAY, 29, '2023/05/10'), DATEADD(DAY, 29, '2023/05/10'));
INSERT INTO CatPurchase (total, fkCatSupplier, fkCatEmployee, creationDate, updateDate) VALUES (1, 2, (SELECT TOP 1 CatEmployee.idCatEmployee FROM CatEmployee WHERE CatEmployee.fkRol = (SELECT TOP 1 Id FROM AspNetRoles WHERE AspNetRoles.Name = 'Employee') ORDER BY NEWID()), DATEADD(DAY, 29, '2023/05/10'), DATEADD(DAY, 29, '2023/05/10'));
INSERT INTO CatPurchase (total, fkCatSupplier, fkCatEmployee, creationDate, updateDate) VALUES (1, 3, (SELECT TOP 1 CatEmployee.idCatEmployee FROM CatEmployee WHERE CatEmployee.fkRol = (SELECT TOP 1 Id FROM AspNetRoles WHERE AspNetRoles.Name = 'Employee') ORDER BY NEWID()), DATEADD(DAY, 29, '2023/05/10'), DATEADD(DAY, 29, '2023/05/10'));
INSERT INTO CatPurchase (total, fkCatSupplier, fkCatEmployee, creationDate, updateDate) VALUES (1, 4, (SELECT TOP 1 CatEmployee.idCatEmployee FROM CatEmployee WHERE CatEmployee.fkRol = (SELECT TOP 1 Id FROM AspNetRoles WHERE AspNetRoles.Name = 'Employee') ORDER BY NEWID()), DATEADD(DAY, 29, '2023/05/10'), DATEADD(DAY, 29, '2023/05/10'));
INSERT INTO CatPurchase (total, fkCatSupplier, fkCatEmployee, creationDate, updateDate) VALUES (1, 5, (SELECT TOP 1 CatEmployee.idCatEmployee FROM CatEmployee WHERE CatEmployee.fkRol = (SELECT TOP 1 Id FROM AspNetRoles WHERE AspNetRoles.Name = 'Employee') ORDER BY NEWID()), DATEADD(DAY, 29, '2023/05/10'), DATEADD(DAY, 29, '2023/05/10'));
INSERT INTO CatPurchase (total, fkCatSupplier, fkCatEmployee, creationDate, updateDate) VALUES (1, 6, (SELECT TOP 1 CatEmployee.idCatEmployee FROM CatEmployee WHERE CatEmployee.fkRol = (SELECT TOP 1 Id FROM AspNetRoles WHERE AspNetRoles.Name = 'Employee') ORDER BY NEWID()), DATEADD(DAY, 29, '2023/05/10'), DATEADD(DAY, 29, '2023/05/10'));
INSERT INTO CatPurchase (total, fkCatSupplier, fkCatEmployee, creationDate, updateDate) VALUES (1, 7, (SELECT TOP 1 CatEmployee.idCatEmployee FROM CatEmployee WHERE CatEmployee.fkRol = (SELECT TOP 1 Id FROM AspNetRoles WHERE AspNetRoles.Name = 'Employee') ORDER BY NEWID()), DATEADD(DAY, 29, '2023/05/10'), DATEADD(DAY, 29, '2023/05/10'));
INSERT INTO CatPurchase (total, fkCatSupplier, fkCatEmployee, creationDate, updateDate) VALUES (1, 8, (SELECT TOP 1 CatEmployee.idCatEmployee FROM CatEmployee WHERE CatEmployee.fkRol = (SELECT TOP 1 Id FROM AspNetRoles WHERE AspNetRoles.Name = 'Employee') ORDER BY NEWID()), DATEADD(DAY, 29, '2023/05/10'), DATEADD(DAY, 29, '2023/05/10'));
INSERT INTO DetailPurchase (quantity, price, fkCatRawMaterial, fkCatPurchase) VALUES (50000, 2500, 8, 11); -- Arcilla     ---- 1
INSERT INTO DetailPurchase (quantity, price, fkCatRawMaterial, fkCatPurchase) VALUES (30000, 1500, 9, 11); -- Arcilla     ---- 1
INSERT INTO DetailPurchase (quantity, price, fkCatRawMaterial, fkCatPurchase) VALUES (30000, 2400, 15, 12); -- Feldespato -----2
INSERT INTO DetailPurchase (quantity, price, fkCatRawMaterial, fkCatPurchase) VALUES (25000, 2000, 13, 12); -- Feldespato -----2
INSERT INTO DetailPurchase (quantity, price, fkCatRawMaterial, fkCatPurchase) VALUES (100000, 6000, 18, 13); -- Sílice ------- 3
INSERT INTO DetailPurchase (quantity, price, fkCatRawMaterial, fkCatPurchase) VALUES (25000, 1500, 16, 13); -- Sílice ------- 3
INSERT INTO DetailPurchase (quantity, price, fkCatRawMaterial, fkCatPurchase) VALUES (100000, 4000, 20, 14); -- Almidón -------4
INSERT INTO DetailPurchase (quantity, price, fkCatRawMaterial, fkCatPurchase) VALUES (200000, 8000, 29, 15); -- Caolín  -------5
INSERT INTO DetailPurchase (quantity, price, fkCatRawMaterial, fkCatPurchase) VALUES (30000, 2400, 31, 16); -- Óxido 1 ------ 6
INSERT INTO DetailPurchase (quantity, price, fkCatRawMaterial, fkCatPurchase) VALUES (100000, 8000, 33, 16); -- Óxido 1 ------ 6
INSERT INTO DetailPurchase (quantity, price, fkCatRawMaterial, fkCatPurchase) VALUES (100000, 8000, 32, 16); -- Óxido 2 ------ 6
INSERT INTO DetailPurchase (quantity, price, fkCatRawMaterial, fkCatPurchase) VALUES (100000, 8000, 34, 16); -- Óxido 2 ------ 6
INSERT INTO DetailPurchase (quantity, price, fkCatRawMaterial, fkCatPurchase) VALUES (100000, 8000, 32, 16); -- Óxido 3 ------ 6
INSERT INTO DetailPurchase (quantity, price, fkCatRawMaterial, fkCatPurchase) VALUES (50000, 4000, 38, 16); -- Óxido 4 ------ 6
INSERT INTO DetailPurchase (quantity, price, fkCatRawMaterial, fkCatPurchase) VALUES (100000, 8000, 35, 17); -- Carbonato ---- 7
INSERT INTO DetailPurchase (quantity, price, fkCatRawMaterial, fkCatPurchase) VALUES (25000, 2000, 45, 18); -- Esmalte ----- 8

INSERT INTO CatPurchase (total, fkCatSupplier, fkCatEmployee, creationDate, updateDate) VALUES (1, 1, (SELECT TOP 1 CatEmployee.idCatEmployee FROM CatEmployee WHERE CatEmployee.fkRol = (SELECT TOP 1 Id FROM AspNetRoles WHERE AspNetRoles.Name = 'Employee') ORDER BY NEWID()), DATEADD(DAY, 50, '2023/05/10'), DATEADD(DAY, 50, '2023/05/10'));
INSERT INTO CatPurchase (total, fkCatSupplier, fkCatEmployee, creationDate, updateDate) VALUES (1, 2, (SELECT TOP 1 CatEmployee.idCatEmployee FROM CatEmployee WHERE CatEmployee.fkRol = (SELECT TOP 1 Id FROM AspNetRoles WHERE AspNetRoles.Name = 'Employee') ORDER BY NEWID()), DATEADD(DAY, 50, '2023/05/10'), DATEADD(DAY, 50, '2023/05/10'));
INSERT INTO CatPurchase (total, fkCatSupplier, fkCatEmployee, creationDate, updateDate) VALUES (1, 3, (SELECT TOP 1 CatEmployee.idCatEmployee FROM CatEmployee WHERE CatEmployee.fkRol = (SELECT TOP 1 Id FROM AspNetRoles WHERE AspNetRoles.Name = 'Employee') ORDER BY NEWID()), DATEADD(DAY, 50, '2023/05/10'), DATEADD(DAY, 50, '2023/05/10'));
INSERT INTO CatPurchase (total, fkCatSupplier, fkCatEmployee, creationDate, updateDate) VALUES (1, 4, (SELECT TOP 1 CatEmployee.idCatEmployee FROM CatEmployee WHERE CatEmployee.fkRol = (SELECT TOP 1 Id FROM AspNetRoles WHERE AspNetRoles.Name = 'Employee') ORDER BY NEWID()), DATEADD(DAY, 50, '2023/05/10'), DATEADD(DAY, 50, '2023/05/10'));
INSERT INTO CatPurchase (total, fkCatSupplier, fkCatEmployee, creationDate, updateDate) VALUES (1, 5, (SELECT TOP 1 CatEmployee.idCatEmployee FROM CatEmployee WHERE CatEmployee.fkRol = (SELECT TOP 1 Id FROM AspNetRoles WHERE AspNetRoles.Name = 'Employee') ORDER BY NEWID()), DATEADD(DAY, 50, '2023/05/10'), DATEADD(DAY, 50, '2023/05/10'));
INSERT INTO CatPurchase (total, fkCatSupplier, fkCatEmployee, creationDate, updateDate) VALUES (1, 6, (SELECT TOP 1 CatEmployee.idCatEmployee FROM CatEmployee WHERE CatEmployee.fkRol = (SELECT TOP 1 Id FROM AspNetRoles WHERE AspNetRoles.Name = 'Employee') ORDER BY NEWID()), DATEADD(DAY, 50, '2023/05/10'), DATEADD(DAY, 50, '2023/05/10'));
INSERT INTO CatPurchase (total, fkCatSupplier, fkCatEmployee, creationDate, updateDate) VALUES (1, 8, (SELECT TOP 1 CatEmployee.idCatEmployee FROM CatEmployee WHERE CatEmployee.fkRol = (SELECT TOP 1 Id FROM AspNetRoles WHERE AspNetRoles.Name = 'Employee') ORDER BY NEWID()), DATEADD(DAY, 50, '2023/05/10'), DATEADD(DAY, 50, '2023/05/10'));
INSERT INTO DetailPurchase (quantity, price, fkCatRawMaterial, fkCatPurchase) VALUES (17000, 850, 6, 19); -- Arcilla     ---- 1
INSERT INTO DetailPurchase (quantity, price, fkCatRawMaterial, fkCatPurchase) VALUES (50000, 2500, 8, 19); -- Arcilla     ---- 1
INSERT INTO DetailPurchase (quantity, price, fkCatRawMaterial, fkCatPurchase) VALUES (100000, 8000, 14, 20); -- Feldespato -----2
INSERT INTO DetailPurchase (quantity, price, fkCatRawMaterial, fkCatPurchase) VALUES (30000, 2400, 15, 20); -- Feldespato -----2
INSERT INTO DetailPurchase (quantity, price, fkCatRawMaterial, fkCatPurchase) VALUES (100000, 6000, 17, 21); -- Sílice ------- 3
INSERT INTO DetailPurchase (quantity, price, fkCatRawMaterial, fkCatPurchase) VALUES (100000, 6000, 18, 21); -- Sílice ------- 3
INSERT INTO DetailPurchase (quantity, price, fkCatRawMaterial, fkCatPurchase) VALUES (20000, 800, 22, 22); -- Almidón -------4
INSERT INTO DetailPurchase (quantity, price, fkCatRawMaterial, fkCatPurchase) VALUES (200000, 8000, 29, 23); -- Caolín  -------5
INSERT INTO DetailPurchase (quantity, price, fkCatRawMaterial, fkCatPurchase) VALUES (100000, 8000, 34, 24); -- Óxido 1 ------ 6
INSERT INTO DetailPurchase (quantity, price, fkCatRawMaterial, fkCatPurchase) VALUES (200000, 16000, 36, 24); -- Óxido 1 ------ 6
INSERT INTO DetailPurchase (quantity, price, fkCatRawMaterial, fkCatPurchase) VALUES (200000, 16000, 36, 24); -- Óxido 2 ------ 6
INSERT INTO DetailPurchase (quantity, price, fkCatRawMaterial, fkCatPurchase) VALUES (50000, 4000, 37, 24); -- Óxido 2 ------ 6
INSERT INTO DetailPurchase (quantity, price, fkCatRawMaterial, fkCatPurchase) VALUES (50000, 4000, 37, 24); -- Óxido 3 ------ 6
INSERT INTO DetailPurchase (quantity, price, fkCatRawMaterial, fkCatPurchase) VALUES (150000, 12000, 44, 25); -- Esmalte ----- 8

INSERT INTO CatPurchase (total, fkCatSupplier, fkCatEmployee, creationDate, updateDate) VALUES (1, 1, (SELECT TOP 1 CatEmployee.idCatEmployee FROM CatEmployee WHERE CatEmployee.fkRol = (SELECT TOP 1 Id FROM AspNetRoles WHERE AspNetRoles.Name = 'Employee') ORDER BY NEWID()), DATEADD(DAY, 71, '2023/05/10'), DATEADD(DAY, 71, '2023/05/10'));
INSERT INTO CatPurchase (total, fkCatSupplier, fkCatEmployee, creationDate, updateDate) VALUES (1, 2, (SELECT TOP 1 CatEmployee.idCatEmployee FROM CatEmployee WHERE CatEmployee.fkRol = (SELECT TOP 1 Id FROM AspNetRoles WHERE AspNetRoles.Name = 'Employee') ORDER BY NEWID()), DATEADD(DAY, 71, '2023/05/10'), DATEADD(DAY, 71, '2023/05/10'));
INSERT INTO CatPurchase (total, fkCatSupplier, fkCatEmployee, creationDate, updateDate) VALUES (1, 3, (SELECT TOP 1 CatEmployee.idCatEmployee FROM CatEmployee WHERE CatEmployee.fkRol = (SELECT TOP 1 Id FROM AspNetRoles WHERE AspNetRoles.Name = 'Employee') ORDER BY NEWID()), DATEADD(DAY, 71, '2023/05/10'), DATEADD(DAY, 71, '2023/05/10'));
INSERT INTO CatPurchase (total, fkCatSupplier, fkCatEmployee, creationDate, updateDate) VALUES (1, 4, (SELECT TOP 1 CatEmployee.idCatEmployee FROM CatEmployee WHERE CatEmployee.fkRol = (SELECT TOP 1 Id FROM AspNetRoles WHERE AspNetRoles.Name = 'Employee') ORDER BY NEWID()), DATEADD(DAY, 71, '2023/05/10'), DATEADD(DAY, 71, '2023/05/10'));
INSERT INTO CatPurchase (total, fkCatSupplier, fkCatEmployee, creationDate, updateDate) VALUES (1, 5, (SELECT TOP 1 CatEmployee.idCatEmployee FROM CatEmployee WHERE CatEmployee.fkRol = (SELECT TOP 1 Id FROM AspNetRoles WHERE AspNetRoles.Name = 'Employee') ORDER BY NEWID()), DATEADD(DAY, 71, '2023/05/10'), DATEADD(DAY, 71, '2023/05/10'));
INSERT INTO CatPurchase (total, fkCatSupplier, fkCatEmployee, creationDate, updateDate) VALUES (1, 6, (SELECT TOP 1 CatEmployee.idCatEmployee FROM CatEmployee WHERE CatEmployee.fkRol = (SELECT TOP 1 Id FROM AspNetRoles WHERE AspNetRoles.Name = 'Employee') ORDER BY NEWID()), DATEADD(DAY, 71, '2023/05/10'), DATEADD(DAY, 71, '2023/05/10'));
INSERT INTO CatPurchase (total, fkCatSupplier, fkCatEmployee, creationDate, updateDate) VALUES (1, 8, (SELECT TOP 1 CatEmployee.idCatEmployee FROM CatEmployee WHERE CatEmployee.fkRol = (SELECT TOP 1 Id FROM AspNetRoles WHERE AspNetRoles.Name = 'Employee') ORDER BY NEWID()), DATEADD(DAY, 71, '2023/05/10'), DATEADD(DAY, 71, '2023/05/10'));
INSERT INTO DetailPurchase (quantity, price, fkCatRawMaterial, fkCatPurchase) VALUES (30000, 1500, 9, 26); -- Arcilla     ---- 1
INSERT INTO DetailPurchase (quantity, price, fkCatRawMaterial, fkCatPurchase) VALUES (50000, 2500, 8, 26); -- Arcilla     ---- 1
INSERT INTO DetailPurchase (quantity, price, fkCatRawMaterial, fkCatPurchase) VALUES (25000, 2000, 13, 27); -- Feldespato -----2
INSERT INTO DetailPurchase (quantity, price, fkCatRawMaterial, fkCatPurchase) VALUES (100000, 8000, 14, 27); -- Feldespato -----2
INSERT INTO DetailPurchase (quantity, price, fkCatRawMaterial, fkCatPurchase) VALUES (25000, 1500, 16, 28); -- Sílice ------- 3
INSERT INTO DetailPurchase (quantity, price, fkCatRawMaterial, fkCatPurchase) VALUES (100000, 4000, 20, 29); -- Almidón -------4
INSERT INTO DetailPurchase (quantity, price, fkCatRawMaterial, fkCatPurchase) VALUES (200000, 8000, 29, 30); -- Caolín  -------5
INSERT INTO DetailPurchase (quantity, price, fkCatRawMaterial, fkCatPurchase) VALUES (50000, 4000, 37, 31); -- Óxido 1 ------ 6
INSERT INTO DetailPurchase (quantity, price, fkCatRawMaterial, fkCatPurchase) VALUES (25000, 2000, 39, 31); -- Óxido 1 ------ 6
INSERT INTO DetailPurchase (quantity, price, fkCatRawMaterial, fkCatPurchase) VALUES (50000, 4000, 38, 31); -- Óxido 2 ------ 6
INSERT INTO DetailPurchase (quantity, price, fkCatRawMaterial, fkCatPurchase) VALUES (50000, 4000, 38, 31); -- Óxido 3 ------ 6
INSERT INTO DetailPurchase (quantity, price, fkCatRawMaterial, fkCatPurchase) VALUES (150000, 12000, 44, 32); -- Esmalte ----- 8

INSERT INTO CatPurchase (total, fkCatSupplier, fkCatEmployee, creationDate, updateDate) VALUES (1, 1, (SELECT TOP 1 CatEmployee.idCatEmployee FROM CatEmployee WHERE CatEmployee.fkRol = (SELECT TOP 1 Id FROM AspNetRoles WHERE AspNetRoles.Name = 'Employee') ORDER BY NEWID()), DATEADD(DAY, 92, '2023/05/10'), DATEADD(DAY, 92, '2023/05/10'));
INSERT INTO CatPurchase (total, fkCatSupplier, fkCatEmployee, creationDate, updateDate) VALUES (1, 2, (SELECT TOP 1 CatEmployee.idCatEmployee FROM CatEmployee WHERE CatEmployee.fkRol = (SELECT TOP 1 Id FROM AspNetRoles WHERE AspNetRoles.Name = 'Employee') ORDER BY NEWID()), DATEADD(DAY, 92, '2023/05/10'), DATEADD(DAY, 92, '2023/05/10'));
INSERT INTO CatPurchase (total, fkCatSupplier, fkCatEmployee, creationDate, updateDate) VALUES (1, 3, (SELECT TOP 1 CatEmployee.idCatEmployee FROM CatEmployee WHERE CatEmployee.fkRol = (SELECT TOP 1 Id FROM AspNetRoles WHERE AspNetRoles.Name = 'Employee') ORDER BY NEWID()), DATEADD(DAY, 92, '2023/05/10'), DATEADD(DAY, 92, '2023/05/10'));
INSERT INTO CatPurchase (total, fkCatSupplier, fkCatEmployee, creationDate, updateDate) VALUES (1, 4, (SELECT TOP 1 CatEmployee.idCatEmployee FROM CatEmployee WHERE CatEmployee.fkRol = (SELECT TOP 1 Id FROM AspNetRoles WHERE AspNetRoles.Name = 'Employee') ORDER BY NEWID()), DATEADD(DAY, 92, '2023/05/10'), DATEADD(DAY, 92, '2023/05/10'));
INSERT INTO CatPurchase (total, fkCatSupplier, fkCatEmployee, creationDate, updateDate) VALUES (1, 6, (SELECT TOP 1 CatEmployee.idCatEmployee FROM CatEmployee WHERE CatEmployee.fkRol = (SELECT TOP 1 Id FROM AspNetRoles WHERE AspNetRoles.Name = 'Employee') ORDER BY NEWID()), DATEADD(DAY, 92, '2023/05/10'), DATEADD(DAY, 92, '2023/05/10'));
INSERT INTO CatPurchase (total, fkCatSupplier, fkCatEmployee, creationDate, updateDate) VALUES (1, 8, (SELECT TOP 1 CatEmployee.idCatEmployee FROM CatEmployee WHERE CatEmployee.fkRol = (SELECT TOP 1 Id FROM AspNetRoles WHERE AspNetRoles.Name = 'Employee') ORDER BY NEWID()), DATEADD(DAY, 92, '2023/05/10'), DATEADD(DAY, 92, '2023/05/10'));
INSERT INTO DetailPurchase (quantity, price, fkCatRawMaterial, fkCatPurchase) VALUES (50000, 2500, 8, 33); -- Arcilla     ---- 1
INSERT INTO DetailPurchase (quantity, price, fkCatRawMaterial, fkCatPurchase) VALUES (50000, 2500, 8, 33); -- Arcilla     ---- 1
INSERT INTO DetailPurchase (quantity, price, fkCatRawMaterial, fkCatPurchase) VALUES (30000, 2400, 15, 34); -- Feldespato -----2
INSERT INTO DetailPurchase (quantity, price, fkCatRawMaterial, fkCatPurchase) VALUES (25000, 1500, 16, 35); -- Sílice ------- 3
INSERT INTO DetailPurchase (quantity, price, fkCatRawMaterial, fkCatPurchase) VALUES (100000, 4000, 20, 36); -- Almidón -------4
INSERT INTO DetailPurchase (quantity, price, fkCatRawMaterial, fkCatPurchase) VALUES (50000, 4000, 38, 37); -- Óxido 1 ------ 6
INSERT INTO DetailPurchase (quantity, price, fkCatRawMaterial, fkCatPurchase) VALUES (25000, 2000, 45, 38); -- Esmalte ----- 8
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


CREATE FUNCTION dbo.checkRawMaterialsByRecipe (
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
  DECLARE @numberAleatoryDate INT;
  SET @isEnough = dbo.checkRawMaterialsByRecipe(@idCatRecipe, @totalRecipes);
  IF @isEnough = 1
  BEGIN
    SET @numberAleatoryDate = CAST((FLOOR(RAND()*(85-5+1))+5) AS INT);
    INSERT INTO HelperDateToRecipe (quantity, fkCatRecipe, creationDate) VALUES (@totalRecipes, @idCatRecipe, DATEADD(DAY, @numberAleatoryDate, '2023/05/10'));
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

CREATE PROCEDURE procedureInsertAllStock
AS
BEGIN
  DECLARE @Counter INT = 1;
  DECLARE @totalRecipe INT;
  DECLARE @idCatRecipe INT;
  WHILE @Counter <= 100
    BEGIN
      SET @idCatRecipe = (SELECT TOP 1 idCatRecipe FROM CatRecipe ORDER BY NEWID())
      SET @totalRecipe = FLOOR(RAND()*(100-20+1))+20;
      EXEC procedureInsertStock @idCatRecipe, @totalRecipe;
      SET @Counter = @Counter + 1;
    END
END;
GO


EXEC procedureInsertAllStock;
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


CREATE PROCEDURE procedureFillingInsertSales (
  @total INT,
  @fkCatClient INT,
  @totalSales INT
)
AS
  BEGIN
    DECLARE @subtractValue INT;
    DECLARE @tempTotalRecipes INT;
    DECLARE @idCatSale INT;
    DECLARE @idCatRecipe INT;
    DECLARE @priceRecipe FLOAT;
    DECLARE @counter INT = 1;
    DECLARE @numberAleatoryDate INT;
    WHILE @counter <= @totalSales
    BEGIN
      SET @tempTotalRecipes = 1 + CAST(RAND() * 100 AS INT);
      SET @idCatRecipe = (SELECT TOP 1 idCatRecipe FROM CatRecipe WHERE quantityStock >= @tempTotalRecipes ORDER BY NEWID())
      IF @idCatRecipe > 0
        BEGIN
          SET @numberAleatoryDate = CAST((FLOOR(RAND()*(82-15+1))+15) AS INT);
          INSERT INTO CatSale (total, fkCatClient, creationDate, updateDate) VALUES (@total, @fkCatClient, DATEADD(DAY, @numberAleatoryDate, '2023/05/10'), DATEADD(DAY, @numberAleatoryDate, '2023/05/10'));
          SET @idCatSale = SCOPE_IDENTITY();
          SET @priceRecipe = (SELECT price FROM CatRecipe WHERE idCatRecipe = @idCatRecipe);
          INSERT INTO DetailSale (quantity, price, fkCatRecipe, fkCatSale) VALUES (@tempTotalRecipes, (@priceRecipe * @tempTotalRecipes), @idCatRecipe, @idCatSale);
          UPDATE CatRecipe SET quantityStock = (quantityStock - @tempTotalRecipes) WHERE idCatRecipe = @idCatRecipe;
          INSERT INTO CatShipment (delivered, fkCatSale, fkCatEmployee, creationDate, updateDate) VALUES ((ABS(CHECKSUM(NEWID())) % 2), @idCatSale, 8,  DATEADD(DAY, @numberAleatoryDate, '2023/05/10'), DATEADD(DAY, (@numberAleatoryDate + 3), '2023/05/10'));
        END
      SET @counter = @counter + 1;
    END
  END;
GO


EXEC procedureFillingInsertSales 1, 1, 10;
EXEC procedureFillingInsertSales 1, 2, 29;
EXEC procedureFillingInsertSales 1, 3, 37;
EXEC procedureFillingInsertSales 1, 4, 41;
EXEC procedureFillingInsertSales 1, 5, 31;
EXEC procedureFillingInsertSales 1, 6, 34;
EXEC procedureFillingInsertSales 1, 7, 35;
EXEC procedureFillingInsertSales 1, 8, 39;
EXEC procedureFillingInsertSales 1, 9, 40;
EXEC procedureFillingInsertSales 1, 10, 43;
EXEC procedureFillingInsertSales 1, 11, 46;
EXEC procedureFillingInsertSales 1, 12, 71;
EXEC procedureFillingInsertSales 1, 13, 78;
EXEC procedureFillingInsertSales 1, 14, 82;
EXEC procedureFillingInsertSales 1, 15, 83;
EXEC procedureFillingInsertSales 1, 16, 94;
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


WITH RankedResults AS (
    SELECT
        dp.fkCatRawMaterial,
        cp.updateDate,
        ROW_NUMBER() OVER(PARTITION BY dp.fkCatRawMaterial ORDER BY cp.updateDate DESC) AS RowNum
    FROM
        DetailPurchase dp
    INNER JOIN
        CatPurchase cp ON cp.idCatPurchase = dp.fkCatPurchase
)
UPDATE crm
SET crm.updateDate = rr.updateDate
FROM CatRawMaterial crm
INNER JOIN RankedResults rr ON crm.idCatRawMaterial = rr.fkCatRawMaterial
WHERE rr.RowNum = 1;


WITH RankedResults AS (
    SELECT
        ds.fkCatRecipe,
        cs.updateDate,
        ROW_NUMBER() OVER(PARTITION BY ds.fkCatRecipe ORDER BY cs.updateDate DESC) AS RowNum
    FROM
        DetailSale ds
    INNER JOIN
        CatSale cs ON cs.idCatSale = ds.fkCatSale
)
UPDATE crm
SET crm.updateDate = rr.updateDate
FROM CatRecipe crm
INNER JOIN RankedResults rr ON crm.idCatRecipe = rr.fkCatRecipe
WHERE rr.RowNum = 1;
