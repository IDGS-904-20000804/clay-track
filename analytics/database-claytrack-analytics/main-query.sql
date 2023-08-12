
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
  date DATETIME,
  type VARCHAR(MAX) NOT NULL
);
GO


DROP PROCEDURE IF EXISTS procedureGraphic;
GO


CREATE PROCEDURE procedureGraphic (
  @json VARCHAR(MAX),
  @type VARCHAR(255),
  @allTime BIT
)
AS
BEGIN
  DECLARE @repeatedTotal INT;
  DECLARE @idGraphic INT;
  IF @allTime = 1
    BEGIN
      SET @repeatedTotal = (
        SELECT COUNT(*) FROM Graphic g
          WHERE g.date IS NULL
          AND g.type = @type
      );
      IF @repeatedTotal = 0
        BEGIN
          INSERT INTO Graphic (result, type) VALUES (@json, @type);
        END
      IF @repeatedTotal > 0
        BEGIN
          SET @idGraphic = (
            SELECT TOP 1 id FROM Graphic g
              WHERE g.date IS NULL
              AND g.type = @type
          );
          UPDATE Graphic
            SET result = @json,
              type = @type
          WHERE id = @idGraphic;
        END
    END
	ELSE
    BEGIN
      SET @repeatedTotal = (
        SELECT COUNT(*) FROM Graphic g
          WHERE YEAR(g.date) = YEAR(GETDATE())
          AND MONTH(g.date) = MONTH(GETDATE())
          AND g.type = @type
      );
      IF @repeatedTotal = 0
        BEGIN
          INSERT INTO Graphic (result, type, date) VALUES (@json, @type, GETDATE());
        END
      IF @repeatedTotal > 0
        BEGIN
          SET @idGraphic = (
            SELECT TOP 1 id FROM Graphic g
            WHERE YEAR(g.date) = YEAR(GETDATE())
            AND MONTH(g.date) = MONTH(GETDATE())
            AND g.type = @type
          );
          UPDATE Graphic
            SET result = @json,
              type = @type,
              date = GETDATE()
          WHERE id = @idGraphic;
        END
    END
END;
GO


-- SELECT
--   result
-- FROM Graphic
-- WHERE type = 'SalesByClient'
-- AND YEAR(date) = YEAR('2023-08-08')
-- AND MONTH(date) = MONTH('2023-08-08');


-- SELECT
--   result
-- FROM Graphic
-- WHERE type = 'SalesByClient'
-- AND date >= DATEADD(DAY, -30, GETDATE());

-- PurchasesBySupplier
-- RawMaterialsByRecipe
-- RecipesBySale
-- SalesByClient