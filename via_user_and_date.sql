SET @i := 0;
SET @d := '2020-04-09 00:00:00';
SET @user_id := 1;
SELECT CONCAT(IF ((@i := @i + 1) = 1, '', 'UNION '), 'SELECT ''SELECT * FROM `', t.TABLE_NAME, '` WHERE ', t.BY_EXPRESSION, '`', t.COLUMN_NAME, '` >= "', @d, '"; '' as "#table_name" FROM `', t.TABLE_NAME, '` WHERE ', t.BY_EXPRESSION, '`', t.COLUMN_NAME, '` >= "', @d, '"') as 'use benefits_develop;' 
FROM (
  SELECT c.TABLE_NAME, MAX(c.COLUMN_NAME) as COLUMN_NAME, (
    SELECT IFNULL(CONCAT('`', MAX(cc.COLUMN_NAME), '` = ', @user_id, ' AND '), '')
    FROM information_schema.`COLUMNS` cc
	 WHERE cc.TABLE_NAME = c.TABLE_NAME AND cc.COLUMN_NAME IN ('created_by', 'updated_by')
  ) as BY_EXPRESSION
  FROM information_schema.`COLUMNS` c
  WHERE c.TABLE_SCHEMA = 'benefits_develop' and c.COLUMN_NAME IN ('created_at', 'updated_at')
  GROUP BY c.TABLE_NAME
  ORDER BY c.TABLE_NAME, COLUMN_NAME ASC
) t;
