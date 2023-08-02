Schema 3
1. Insert purchase

Schema 4
1. Insert stock
2. Insert sales


1. Se agregó el siguiente campo a la tabla CatRawMaterial:
quantityWarehouse INT NOT NULL DEFAULT 0

2. Se cambió el nombre del siguinte atributo en la tabla DetailPurchase:
fkCatWarehouse INT NOT NULL
por
fkCatRawMaterial INT NOT NULL

3. Se eliminó la tabla CatWarehouse



4. Creó la tabla CatSize

5. Se agregó el campo fkCatSize a CatRecipe

6. Se agregó la tabla CatColor

7. Se agregó la tabla DetailRawMaterialColor

8. Se agregó la tabla DetailRecipeColor

9. CatRecipe imagePath puede ser nulo

10. Se eliminó DetailRawMaterialColor

11. Se agregó este campo
quantityPackage INT NOT NULL
a la tabla
CatRawMaterial

12. Se actualizó el campo de la tabla DetailPurchase
de
  quantity FLOAT NOT NULL
a
  quantity INT NOT NULL

13. Se actualizó el campo de la tabla DetailRecipeRawMaterial
de
  quantity FLOAT NOT NULL
a
  quantity INT NOT NULL

14. Se actualizó el campo de la tabla DetailSale
de
  quantity FLOAT NOT NULL
a
  quantity INT NOT NULL

15. Se eliminó price de CatRecipe

16. Se removio el siguiente campo a CatStock
  price FLOAT NOT NULL,
y se agregó a 

Cambios para ivan
Cambiar los roles a los que tiene pau
Eliminar estas tablas:
	CatRole
	CatUser
	DetailRoleUser
Eliminar fk:
	DetailRoleUser (fkCatRole) REFERENCES CatRole (idCatRole)
	DetailRoleUser (fkCatUser) REFERENCES CatUser (idCatUser)
Crear estas tablas:
	__EFMigrationsHistory
	AspNetRoleClaims
	AspNetRoles
	AspNetUserClaims
	AspNetUserLogins
	AspNetUserRoles
	AspNetUsers
	AspNetUserTokens
Agregar estas fk:
	AspNetRoleClaims (RoleId) REFERENCES AspNetRoles (Id)
	AspNetUserClaims (UserId) REFERENCES AspNetUsers (Id)
	AspNetUserLogins (UserId) REFERENCES AspNetUsers (Id)
	AspNetUserRoles (RoleId) REFERENCES AspNetRoles (Id)
	AspNetUserRoles (UserId) REFERENCES AspNetUsers (Id)
	AspNetUserTokens (UserId) REFERENCES AspNetUsers (Id)
Cambiar estas fk:
	fkUser nvarchar(450) COLLATE Modern_Spanish_CI_AS NOT NULL
		CatClient (fkCatUser) REFERENCES CatUser (idCatUser) - I
		CatClient (fkUser) REFERENCES AspNetUsers (Id) - P

		CatEmployee (fkCatUser) REFERENCES CatUser (idCatUser) - I
		CatEmployee (fkUser) REFERENCES AspNetUsers (Id) - P
Agregar estas fk y campo
	fkRol nvarchar(450) COLLATE Modern_Spanish_CI_AS NOT NULL
		CatClient (fkRol) REFERENCES AspNetRoles (Id) - P
		CatEmployee (fkRol) REFERENCES AspNetRoles (Id) - P
