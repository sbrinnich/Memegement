USE Memegement;
GO


-- Cursor der alle Text-Spalten der Datenbank durchgeht und Strings durch andere ersetzt,
-- total nutzlos eigentlich, aber vll kann man ja den ein oder anderen Troll damit zensieren


SET NOCOUNT ON 

DECLARE @alterString VARCHAR(100)
DECLARE @neuerString VARCHAR(100)
DECLARE @schema sysname 
DECLARE @tabelle sysname
DECLARE @count INT
DECLARE @sqlCommand VARCHAR(8000)
DECLARE @where VARCHAR(8000) 
DECLARE @spaltenName sysname
DECLARE @objektId INT
                     
SET @alterString = 'Böser Text hier einfügen'
SET @neuerString = 'Text wurde zensiert'
                        
DECLARE TAB_CURSOR CURSOR  FOR 
SELECT   B.NAME AS SCHEMANAME,
         A.NAME AS TABLENAME,
         A.OBJECT_ID 
FROM     sys.objects A 
         INNER JOIN sys.schemas B 
           ON A.SCHEMA_ID = B.SCHEMA_ID 
WHERE    TYPE = 'U' 
ORDER BY 1 
          
OPEN TAB_CURSOR 

FETCH NEXT FROM TAB_CURSOR 
INTO @schema, 
     @tabelle,
     @objektId
      
WHILE @@FETCH_STATUS = 0 
  BEGIN 
    DECLARE COL_CURSOR CURSOR FOR 
    SELECT A.NAME 
    FROM   sys.columns A 
           INNER JOIN sys.types B 
             ON A.SYSTEM_TYPE_ID = B.SYSTEM_TYPE_ID 
    WHERE  OBJECT_ID = @objektId
           AND IS_COMPUTED = 0 
           AND B.NAME IN ('char','nchar','nvarchar','varchar','text','ntext') 

    OPEN COL_CURSOR 
     
    FETCH NEXT FROM COL_CURSOR 
    INTO @spaltenName
     
    WHILE @@FETCH_STATUS = 0 
      BEGIN 
        SET @sqlCommand = 'UPDATE ' + @schema + '.' + @tabelle + ' SET [' + @spaltenName
                           + '] = REPLACE(convert(nvarchar(max),[' + @spaltenName + ']),'''
                           + @alterString + ''',''' + @neuerString + ''')'
         
        SET @where = ' WHERE [' + @spaltenName + '] LIKE ''%' + @alterString + '%'''
         
        EXEC( @sqlCommand + @where)
         
        SET @count = @@ROWCOUNT 
         
        IF @count > 0 
          BEGIN 
            PRINT @sqlCommand + @where
            PRINT 'Geändert: ' + CONVERT(VARCHAR(10),@count)
            PRINT '----------------------------------------------------' 
          END 
         
        FETCH NEXT FROM COL_CURSOR 
        INTO @spaltenName
      END 
     
    CLOSE COL_CURSOR 
    DEALLOCATE COL_CURSOR 
     
    FETCH NEXT FROM TAB_CURSOR 
    INTO @schema, 
         @tabelle,
         @objektId
  END 
   
CLOSE TAB_CURSOR 
DEALLOCATE TAB_CURSOR

GO


--Cursor der die Indizes der Datenbank neu baut, könnte auch mit nem Maintenance plan gemacht werden Brute Force is aber immer lustiger
USE Memegement;
GO

DECLARE @tabelle VARCHAR(255)
DECLARE @cmd VARCHAR(500)
DECLARE @fillfactor INT

-- create table cursor
SET @fillfactor = 90
DECLARE TableCursor CURSOR FOR
  SELECT '[' + table_catalog + '].[' + table_schema + '].[' + table_name + ']' as tableName FROM [Memegement].[INFORMATION_SCHEMA].[TABLES]
  WHERE table_type = 'BASE TABLE'


OPEN TableCursor

FETCH NEXT FROM TableCursor INTO @tabelle
WHILE @@FETCH_STATUS = 0
  BEGIN
    SET @cmd = 'ALTER INDEX ALL ON ' + @tabelle + ' REBUILD WITH (FILLFACTOR = ' + CONVERT(VARCHAR(3),@fillfactor) + ')'
    EXEC (@cmd)
    FETCH NEXT FROM TableCursor INTO @tabelle
  END
CLOSE TableCursor
DEALLOCATE TableCursor
