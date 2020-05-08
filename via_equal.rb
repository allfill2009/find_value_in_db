# EQUAL
SET @data_type := 'char';
SET @value := 'america';
SET @database_name := '^develop$';
SET @i := 0;
SET @batch := 3000;
SELECT CONCAT(IF((@i := @i + 1) % @batch = 1, IF(@i = 1, '', ';'), 'UNION '),
              'SELECT ''SELECT * FROM `', TABLE_NAME, '`',
              '  WHERE `', COLUMN_NAME, '` = "', @value, '";'' as ''#sql''',
              '  FROM `', TABLE_NAME, '` WHERE `', COLUMN_NAME, '` = ''', @value, '''') as '#tables'
FROM information_schema.COLUMNS 
WHERE (@database_name IS NULL OR TABLE_SCHEMA RLIKE @database_name) and DATA_TYPE rlike @data_type;
