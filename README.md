# Carto and SQL
Create a free account in CARTO:
https://carto.com/get-started/


######  Load on Carto

Points  World Populated places 
(http://www.naturalearthdata.com/downloads/50m-cultural-vectors/50m-populated-places/)


Polygons 	Drought in the US 
(http://droughtmonitor.unl.edu/Data/GISData.aspx)


###### Perform the following SQL query
```sql
SELECT 
  p.the_geom_webmercator,
  CASE WHEN ST_Intersects(d.the_geom, p.the_geom) THEN 'Intersects' ELSE 'Doesn''t' END As classification,
  p.cartodb_id, 
  p.name
FROM 
  ne_50m_populated_places_simple As p
LEFT JOIN
  usdm_20180213 As d
ON 
  ST_Intersects(d.the_geom, p.the_geom)
```
----------------------------------------------------------------------------------------------------------
And create a map based on the new attribute classification 
----------------------------------------------------------------------------------------------------------

######  Perform the following SQL query
```sql
SELECT
  d.dm::int As severity,
  count(*) As num_intersecting,
  d.the_geom_webmercator,
  d.cartodb_id
FROM 
  usdm_20180213  As d
JOIN 
  ne_50m_populated_places_simple As p
ON 
  ST_Intersects(d.the_geom, p.the_geom)
GROUP BY 
  d.the_geom, d.the_geom_webmercator, d.dm, d.cartodb_id

```
