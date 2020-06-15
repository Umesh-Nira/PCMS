CREATE PROCEDURE [dbo].[SpClientSearch]
	(@ClientName nvarchar(50),
	@Location nvarchar(50))
AS
    Set NoCount ON

	SELECT	CL.*,
					CA.AddressId,
					CA.BuildingName AS Address1,
					CA.Phone1 AS PhoneNo1,
					CA.CityId,
					C.CityName AS City1, 
					S.StateName AS State1,
					CN.CountryName AS Country1
			FROM [dbo].[Client_Master] CL			
			INNER JOIN 
			(
				SELECT MT.AddressId, MT.BuildingName, mt.CityId, mt.ClientId, mt.Phone1 FROM (select * from [Client_AddressDetails] where ClientId IN
					(select ClientId from [Client_AddressDetails] a where a.BuildingName LIKE  '%'+ ISNULL(@Location,a.BuildingName)+ '%')) mt
				INNER JOIN
								(
									SELECT A.ClientId, MIN(A.AddressId) MinAdd
									FROM [Client_AddressDetails] A
									GROUP BY A.ClientId
								) t ON mt.ClientId = t.ClientId AND mt.AddressId = T.MinAdd
			) CA ON CA.ClientId = CL.ClientId
			LEFT JOIN [dbo].[Settings_City] C ON CA.CityId = C.CityId 
			LEFT JOIN [dbo].[Settings_State] S ON S.StateId = C.StateId
			LEFT JOIN [dbo].[Settings_Country] CN ON CN.CountryId = S.CountryId
			WHERE CL.ClientName LIKE  '%'+ ISNULL(@ClientName,CL.ClientName)+ '%' 
