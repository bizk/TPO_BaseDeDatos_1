--Consultas

--3.1
WITH pacientes_max_estudios(DNI, Apellido, Nombre, Cantidad) AS (
SELECT
DNI, Apellido, Nombre,
count (1) AS 'Cantidad'
FROM vw_registros_de_estudios
GROUP BY
DNI, Apellido, Nombre
)
SELECT
*
FROM
pacientes_max_estudios
WHERE pacientes_max_estudios = (SELECT MAX (Cantidad)) FROM pacientes_max_estudios)
GO


--3.2. Proyectar los estudios que se realizaron la mayor cantidad de veces.
SELECT
    Estudio,
    count(1) AS 'Cantidad' 
FROM 
    vw_registros_de_estudios 
GROUP BY 
    Estudio
HAVING 
    count(1) = (
      SELECT 
        MAX(p.Cantidad) 
      FROM (
        SELECT   
          count(1) AS 'Cantidad'
        FROM
          vw_registros_de_estudios 
        GROUP BY 
          Estudio
        ) AS p 
      )
GO


--3.3. Proyectar la o las obras sociales más utilizadas.
SELECT
    [Obra Social],
    count(1) AS 'Veces Utilizada' 
FROM 
    vw_registros_de_estudios 
GROUP BY 
    [Obra Social]
HAVING 
    count(1) = (
      SELECT 
        MAX(p.Cantidad) 
      FROM (
        SELECT   
          count(1) AS 'Cantidad'
        FROM
          vw_registros_de_estudios 
        GROUP BY 
          [Obra Social]
        ) AS p 
      )
GO


--3.4. Proyectar el estudio de mayor precio, tener en cuenta el precio promedio del estudio por instituto.
SELECT 
  Estudio, 
  CONVERT(NUMERIC(6,2), AVG(Precio)) AS 'Precio Promedio'
FROM 
  vw_tabla_de_precios tp
GROUP BY 
  Estudio
HAVING 
  CONVERT(NUMERIC(6,2), AVG(Precio))  = (
    SELECT 
      MAX(p.pp) 
    FROM (
      SELECT   
        CONVERT(NUMERIC(6,2), AVG(Precio)) AS 'pp'
      FROM
        vw_tabla_de_precios
      GROUP BY 
        Estudio
      ) AS p 
    )
GO


--3.5. Proyectar el o los institutos que no realizó estudios en el último mes.
SELECT 
  RazonSocial As 'Instituto',
  Activo
FROM 
  Institutos
WHERE
 IdInstituto NOT IN (
    SELECT DISTINCT 
      IdInstituto 
    FROM
      Registros
    WHERE
      Fecha >= cast(DATEADD(Month, -1, GETDATE()) as date)
  )
GO


--3.6. Proyectar la cantidad de los pacientes más viejos que no realizaron estudios en el último año.
WITH p(DNI, Apellido, Nombre, Sexo, Nacimiento, Telefono) 
AS (
  SELECT 
    DNI,
    Apellido,
    Nombre,
    Sexo,
    Nacimiento,
    Telefono
  FROM 
    Pacientes
  WHERE 
    DNI NOT IN 
    (
      SELECT DISTINCT 
        DNI 
      FROM 
        Registros
      WHERE
        Fecha >= cast(DATEADD(Year, -1, GETDATE()) as date)
    )
  )
SELECT 
  DNI,
  Apellido,
  Nombre,
  Sexo,
  Nacimiento,
  Telefono 
FROM 
  p 
WHERE 
  p.Nacimiento = (SELECT MIN(p.Nacimiento) FROM p)
GO
