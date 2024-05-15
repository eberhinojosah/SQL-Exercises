-- 1) Obtener el ID de persona y el nombre de todas las personas que son jefes.

SELECT p.BusinessEntityID, p.FirstName, p.LastName
FROM HumanResources.Employee e
JOIN Person.Person p ON e.BusinessEntityID = p.BusinessEntityID
WHERE e.JobTitle LIKE 'Chief%'

-- 2) Obtener el ID de persona, el nombre de la persona y el mail de cada uno de ellos.
SELECT p.BusinessEntityID, p.FirstName, p.LastName, e.EmailAddress
FROM Person.EmailAddress e
JOIN Person.Person p ON e.BusinessEntityID= p.BusinessEntityID

-- 3) Obtener el ID de persona, el nombre de persona y el teléfono de cada persona que su apellido comience con ‘A’
SELECT p.BusinessEntityID, p.FirstName, p.LastName, pp.PhoneNumber
FROM Person.Person p
JOIN Person.PersonPhone pp ON p.BusinessEntityID= pp.BusinessEntityID
WHERE p.LastName LIKE 'A%'

-- 4) Obtener el ID de producto, el nombre del producto y la descripción de la subcategoría de cada producto de color ROJO, AZUL o NEGRO solamente de los
--productos que TIENEN SUBCATEGORIA.

SELECT p.ProductID, p.Name, ps.Name
FROM Production.Product p
JOIN Production.ProductSubcategory ps ON p.ProductSubcategoryID =
ps.ProductSubcategoryID
WHERE p.Color IN ('RED', 'BLUE', 'BLACK')

-- 5) Obtener el ID de producto, el nombre del producto y la descripción de la subcategoría de TODOS LOS PRODUCTOS.

SELECT p.ProductID, p.Name, ps.Name
FROM Production.Product p
LEFT JOIN Production.ProductSubcategory ps ON p.ProductSubcategoryID =
ps.ProductSubcategoryID

-- 6) Obtener un listado que muestre el ID de cliente, el ID del store y el nombre del mismo (concatenado en un mismo campo) de todos los clientes.

SELECT concat(c.CustomerID,', ',c.StoreID,', ', s.Name)
FROM Sales.Customer c
JOIN Sales.Store s ON c.StoreID=s.BusinessEntityID

--7) Obtener todos los empleados cuyo apellido comience con la letra “S”

SELECT p.LastName 
FROM HumanResources.Employee e 
JOIN Person.Person p 
ON e.BusinessEntityID = p.BusinessEntityID
AND p.LastName like 'S%'

--8) Obtener el nombre del producto menos vendido y la cantidad de veces que se vendio

SELECT TOP 1  pp.Name, COUNT(ss.ProductID) AS cantidad_vendida
FROM Production.Product pp
JOIN Sales.SalesOrderDetail ss
ON pp.ProductID = ss.ProductID
GROUP BY pp.Name
ORDER BY COUNT(ss.ProductID) 

--9) Obtener un listado con el nombre del producto y la cantidad vendida ordenando de mayor a menor

SELECT pp.Name, COUNT(ss.ProductID) AS cantidad_vendida
from Production.Product pp
JOIN Sales.SalesOrderDetail ss
ON pp.ProductID = ss.ProductID
GROUP BY pp.Name
ORDER BY COUNT(ss.ProductID) DESC

--10) Obtener el monto de las ventas totales por territorio y ordenar por total vendido de mayor a menor  

SELECT st.Name, SUM(so.TotalDue) AS total_vendido
FROM Sales.SalesOrderHeader so
JOIN Sales.SalesTerritory st
ON so.TerritoryID = st.TerritoryID
GROUP BY st.Name
ORDER BY total_vendido DESC



--11) Crear una consulta que muestre el nombre del empleado, sus horas de vacaciones y un incremento de horas de vacaciones de un 15% para los que tienen menos de 50 hs. de vacaciones, 
--un 10% para los que tienen entre 50 y 70 hs. de vacaciones y un 5 % para el resto.

SELECT FirstName, vacationhours,
CASE
WHEN vacationhours < 50 THEN vacationhours * 1.15
WHEN vacationhours >= 50 AND vacationhours <70 THEN vacationhours *
1.1
ELSE vacationhours*1.05
END AS 'Licencia Bonificada'
FROM
HumanResources.Employee e join Person.Person p on e.BusinessEntityID =
p.BusinessEntityID
Order By vacationhours

--12) Informar la cantidad de Empleados masculinos y femeninos (en una sola fila).
  
SELECT
Count(CASE WHEN Gender = 'M' THEN 1 END) AS Hombres,
Count(CASE WHEN Gender = 'F' THEN 1 END) AS Mujeres
FROM HumanResources.Employee

--13) Del Departamento de Recursos Humanos se quiere saber los empleados que cobran mensual (PayFrequency 1) o por Quincena (PayFrequency 2), generar un reporte con
--Nombre, Apellido, Cargo y una nueva columna que especifique lo antes mencionado (“Mensual” o “Quincena”).
  
SELECT p.FirstName, p.LastName, e.JobTitle,
'Pago' = CASE eph.PayFrequency
WHEN 1 THEN 'Mensual'
WHEN 2 THEN 'Por Quincena'
ELSE 'N/A'
END
FROM Person.Person p
join HumanResources.Employee e on p.BusinessEntityID = e.BusinessEntityID
join HumanResources.EmployeePayHistory eph on e.BusinessEntityID =
eph.BusinessEntityID

