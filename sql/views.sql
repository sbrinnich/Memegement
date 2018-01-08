Use Memegement;
GO

-- Fun-Objekte eines Users (Art, nach Datum/Bewertung sortiert, von bis)
CREATE VIEW vi_funObjectsOfUser
AS
  SELECT p.FirstName, p.LastName, e.HireDate
  FROM HumanResources.Employee AS e JOIN Person.Person AS  p
      ON e.BusinessEntityID = p.BusinessEntityID ;