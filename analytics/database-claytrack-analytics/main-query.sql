
USE master;
GO
IF EXISTS (SELECT name FROM sys.databases WHERE name = N'ClayTrackAnalytics')
BEGIN
    ALTER DATABASE [ClayTrackAnalytics]
    SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE ClayTrackAnalytics
END;
GO
CREATE DATABASE ClayTrackAnalytics;
GO
USE ClayTrackAnalytics;
GO


CREATE TABLE Graphic(
  id INT NOT NULL PRIMARY KEY IDENTITY(1,1),
  result VARCHAR(MAX) NOT NULL,
  date DATETIME NOT NULL,
  type VARCHAR(MAX) NOT NULL
);

