
/*
	Data Repository Data Integrity Check - Duplicate Records in the dbo.Field table
*/
SELECT 
	rp.ItemFullName as ReportingPoint, 
	gf.ReportingPointId, 
	gf.Name as [FieldName], 
	gf.[Count], 
	'Duplicate field: "' + gf.Name +'" in dbo.Field table (' + rp.ItemFullName + ')' as [Message],
	'SELECT * FROM dbo.Field WHERE ReportingPointId = ' + cast(rp.ReportingPointId as varchar(10)) as [SQL]
FROM 
	(
	SELECT 
		f.ReportingPointId, 
		f.Name, 
		COUNT(f.FieldId) as [Count]
	FROM 
		dbo.Field f
	GROUP BY 
		f.ReportingPointId, f.Name
	) gf 
INNER JOIN 
	ReportingPoint rp 
		on rp.ReportingPointId = gf.ReportingPointId
WHERE 
	gf.[Count]  > 1