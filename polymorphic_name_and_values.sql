# polymorphic name and values
SET @ITEM_TYPE := 'Client';
SET @VALUES := '162';
SET @database_name := '^develop$';
SET @i := 0;
SELECT CONCAT(IF((@i := @i + 1) = 1, '', 'UNION '),
              'SELECT "SELECT * FROM `', c.TABLE_NAME, '`',
              '  WHERE `', c.COLUMN_NAME, '` = ''', @ITEM_TYPE, ''' AND `', t.COLUMN_WITH_ID, '` IN (', @VALUES, ');" as "#sql"',
              '  FROM `', c.TABLE_NAME, '` WHERE `', c.COLUMN_NAME, '` = ''', @ITEM_TYPE, ''' AND `', t.COLUMN_WITH_ID, '` IN (', @VALUES, ')') AS '#sql'
FROM information_schema.COLUMNS c
JOIN (
  SELECT TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME AS COLUMN_WITH_ID, CONCAT(REPLACE(COLUMN_NAME, '_id', ''), '_%') AS COLUMN_WITHOUT_ID
  FROM information_schema.COLUMNS
  WHERE (@database_name IS NULL OR TABLE_SCHEMA RLIKE @database_name)
  AND COLUMN_NAME LIKE '%_id'
) t ON t.TABLE_SCHEMA = c.TABLE_SCHEMA AND t.TABLE_NAME = c.TABLE_NAME AND c.COLUMN_NAME LIKE t.COLUMN_WITHOUT_ID
AND c.COLUMN_NAME LIKE '%_type';
