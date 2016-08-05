# qgis_midv_tolkn_plugin
a qgis plugin for hydrogeological interpretations, internal usage at Midvatten AB

  1. Skapa tolknings-databas med fördefinierad design, värdeförråd (datadomäner) och layout för lagren.
  2. Ladda lagren och värdeförråden; styles, labels m.m. fixas automatiskt
  3. Pga en ännu olöst bug får man själv ange ValueRelation för de fyra spatiella lagren. Dvs öppna layer properties, välj Field och ange "Value Relation" för fälten "typ" och gör kopplingar:
      "gvmag"."typ" till "zz_gvmag"."typ" osv 
  4. Värdeförråden kan utökas genom att lägga till fler rader i zz_tabellerna
