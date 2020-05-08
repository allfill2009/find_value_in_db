# name & values
SET @COLUMN_NAME := 'client_id';
SET @VALUES := '162';
SET @database_name := '^develop$';
SET @i := 0;
SELECT CONCAT(IF((@i := @i + 1) = 1, '', 'UNION '), 
              'SELECT "SELECT * FROM`', TABLE_NAME, '`',
              '  WHERE `', COLUMN_NAME, '` IN (', @VALUES, ');" as "#sql"',
              '  FROM `', TABLE_NAME, '`',
              '  WHERE `', COLUMN_NAME, '` IN (', @VALUES, ')') AS '#sql' 
FROM information_schema.`COLUMNS` 
WHERE (@database_name IS NULL OR TABLE_SCHEMA RLIKE @database_name) AND COLUMN_NAME = @COLUMN_NAME;
