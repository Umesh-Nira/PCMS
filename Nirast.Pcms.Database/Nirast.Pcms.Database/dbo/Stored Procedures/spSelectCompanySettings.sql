
CREATE PROC [dbo].[spSelectCompanySettings](@CompanyId INT = 0)AS
BEGIN
	IF @CompanyId = 0 
		BEGIN
			SELECT CompanyId
					,CompanyName
				   ,TagLine
				   ,AddressLine
				   ,CP.CityId
				   ,ct.CityName AS City
				   ,st.StateId
				   ,st.StateName AS State
				   ,cy.CountryId
				   ,cy.CountryName AS Country
				   ,ZipCode
				   ,PhoneNo1
				   ,PhoneNo2
				   ,EmailAddress
				   ,Website
				   ,Logo
				   ,Description1
				   ,Description2
				   ,Description3 FROM Settings_CompanyProfile CP 
				   LEFT JOIN Settings_City ct on ct.CityId = CP.CityId
				   LEFT JOIN Settings_State st on st.StateId = ct.StateId
				   LEFT JOIN Settings_Country cy on cy.CountryId = st.CountryId
		END
	ELSE
		BEGIN
			SELECT * FROM Settings_CompanyProfile WHERE CompanyId = @CompanyId			
		END
END