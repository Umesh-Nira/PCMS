CREATE PROC GetClientFromClientId
(@Id INT)
AS
BEGIN
	SELECT ClientId
	FROM Client_Master
	WHERE UserId = @Id
END