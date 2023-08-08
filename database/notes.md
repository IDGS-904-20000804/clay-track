HMAC-SHA1

**table aspnetusers**

Id                    : '3e65a643-54b7-4237-b652-f6250a6334df'
UserName              : 'Admin'
NormalizedUserName    : 'ADMIN'
Email                 : 'admin@example.com'
NormalizedEmail       : 'ADMIN@EXAMPLE.COM'
EmailConfirmed        : '0'
PasswordHash          : 'AQAAAAIAAYagAAAAECTkOKFj/oyEhJ0mWkpCk8h/EMZsjwLOU5z/ndDHb+sxZepMqNTQJWENBT6uULqidg=='
SecurityStamp         : 'U7MO4NSTASXY73GLGGZ2HPF5HJK7MMO3'
ConcurrencyStamp      : '870c888e-7d0a-42fc-b99f-c7bb1fcff8aa'
PhoneNumber           : 'null'
PhoneNumberConfirmed  : '0'
TwoFactorEnabled      : '0'
LockoutEnd            : 'null'
LockoutEnabled        : '1'
AccessFailedCount     : '0'

**days**
Domingo	Lunes	Martes	Miercoles	Jueves	Viernes	Sabado
	1	2	3	4	5	6
7	8	9	10	11	12	13
14	15	16	17	18	19	20
21	22	23	24	25	26	27
28	29	30	31	32	33	34
35	36	37	38	39	40	41
42	43	44	45	46	47	48
49	50	51	52	53	54	55
56	57	58	59	60	61	62
63	64	65	66	67	68	69
70	71	72	73	74	75	76
77	78	79	80	81	82	83
84	85	86	87	88	89	90
91	92					



  SET @numbearAleatoryDate = CAST((FLOOR(RAND()*(25-10+1))+10) AS INT);
  creationDate, updateDate
  DATEADD(DAY, @numbearAleatoryDate, '2023/04/30')



CREATE PROCEDURE procedureFillingInsertRecipe (
  @name VARCHAR(255),
  @jsonIdRawMaterial NVARCHAR(MAX)
)
AS
BEGIN
  DECLARE @jsonDetailRawMaterial NVARCHAR(MAX);
  DECLARE @jsonData NVARCHAR(MAX);
  DECLARE @mergedJson NVARCHAR(MAX);
  END;
GO



INSERT INTO CatPurchase (total, fkCatSupplier, fkCatEmployee, creationDate, updateDate) VALUES (1, 1, 5, DATEADD(DAY, 1, '2023/04/30'), DATEADD(DAY, 1, '2023/04/30'));
