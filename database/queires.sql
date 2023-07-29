SELECT
  cr.idCatRecipe,
  cr.name,
  STUFF(
    (SELECT ', ' + cc.description + ' (' + cc.hexadecimal + ')'
      FROM CatColor cc
      INNER JOIN DetailRecipeColor drc
        ON drc.fkCatColor = cc.idCatColor
      WHERE drc.fkCatRecipe = cr.idCatRecipe
      FOR XML PATH('')), 1, 2, ''
  ) AS Colors
FROM CatRecipe cr
WHERE cr.quantityStock > 0
  AND cr.status = 1
GROUP BY cr.idCatRecipe, cr.name
ORDER BY cr.idCatRecipe;
