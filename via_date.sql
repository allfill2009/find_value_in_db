SET @i := 0;
SET @d := '2020-04-09 00:00:00';
SELECT CONCAT(IF ((@i := @i + 1) = 1, '', 'UNION '), 'SELECT ''SELECT * FROM `', t.TABLE_NAME, '` WHERE `', t.COLUMN_NAME, '` >= "', @d, '"; '' as "#table_name" FROM `', t.TABLE_NAME, '` WHERE `', t.COLUMN_NAME, '` >= "', @d, '"') AS '#table_name;' 
FROM (
  SELECT c.TABLE_NAME, MAX(c.COLUMN_NAME) as COLUMN_NAME
  FROM information_schema.`COLUMNS` c
  WHERE c.TABLE_SCHEMA = 'benefits_develop' and c.COLUMN_NAME IN ('created_at', 'updated_at')
  GROUP BY c.TABLE_NAME
  ORDER BY c.TABLE_NAME, COLUMN_NAME ASC
  ) t;
