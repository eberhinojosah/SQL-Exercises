--Creación de una base de Datos
Create Database Lista
on Primary
( Name=ListaData, filename='C:\data\ListaData.mdf'
,size=50MB         --el Mínimo es 512Kb, el predeterminado es 1MB,
,Filegrowth=25%      --default es 10%, minimo es 64KB
)
log on
( Name=ListaLog, filename='C:\data\ListaLog.ldf'
,size=25MB          --el Mínimo es 512Kb, el predeterminado es 1MB,
, Filegrowth=25%
)
Use Lista
go
/* opciones de bd -- son propiedades que tiene toda base de datos
auto_close, auto_create_statistics, auto_shrink
auto_update_statistics --cursores-- Cursor_close_on_commit
*/
--OPCION DE LA BD QUE CIERRA CUALQUIER CURSOR AUTOMATICAMENTE
Alter database Ejemplo
SET Cursor_close_on_commit ON
GO 
--PARA REVISAR ESTADO DE LAS OPCIONES
SELECT DATABASEPROPERTYEX('VENTAS','ISAUTOSHRINK')
--CONSULTAR INFORMACION DE GRUPOS
SP_HELPFILEGROUP GRUPOVENTAS
SP_HELPFILE VENTASDATA
USE MASTER
go
SP_HELP EJEMPLO
--CREACION DE GRUPOS 3 GRUPOS
ALTER DATABASE Lista
ADD FILEGROUP PARTICION1
GO
ALTER DATABASE Lista
ADD FILEGROUP PARTICION2
GO
ALTER DATABASE Lista
ADD FILEGROUP PARTICION3
GO
--CREACIÓN DE 3 ARCHIVOS PARA LOS FILEGROUP
ALTER DATABASE Lista
ADD FILE ( NAME = 'Parte1',
FILENAME = 'c:\Data\Particion1.ndf',SIZE = 5MB)
TO FILEGROUP PARTICION1
GO

ALTER DATABASE Lista
ADD FILE ( NAME = 'Parte2',
FILENAME = 'c:\Data\Particion2.ndf',SIZE = 5MB)
TO FILEGROUP PARTICION2
GO

ALTER DATABASE Lista
ADD FILE ( NAME = 'Parte3',
FILENAME = 'c:\Data\Particion3.ndf',SIZE = 5MB)
TO FILEGROUP PARTICION3
GO

--modificar el grupo primario
USE master
GO
ALTER DATABASE MyDatabase
MODIFY FILEGROUP [PRIMARY] DEFAULT
GO

--modificar un archivo
USE master
GO
ALTER DATABASE Ejemplo
MODIFY FILE    (NAME = 'Parte3',    SIZE = 20MB)
GO
