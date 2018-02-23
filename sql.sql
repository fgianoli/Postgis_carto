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


--



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
