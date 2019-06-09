--3.1
WITH proyeccion_pacientes_max (DNI, Nombre,Apellido,CantEstudios_proy) AS (
    SELECT DNI,Nombre, Apellido, COUNT(DNI) AS CantEstudios
    FROM vw_registros_de_estudios
    GROUP BY Apellido, DNI,Nombre
) SELECT * FROM proyeccion_pacientes_max
WHERE CantEstudios_proy = (SELECT MAX(CantEstudios_proy) FROM proyeccion_pacientes_max)
GROUP BY DNI,Nombre, Apellido, CantEstudios_proy;
GO
--3.2
WITH proyeccion_estudios_max (NroEstudio, NombreEStudio,CantEstudios) AS (
    SELECT IdEstudio, DescEStudio,COUNT(IdEstudio) FROM vw_registros_de_estudios
    GROUP BY IdEstudio, DescEstudio
) SELECT * FROM proyeccion_estudios_max
WHERE CantEstudios = (SELECT MAX(CantEstudios) FROM proyeccion_estudios_max)
GO
--3.3
WITH proyeccion_obras_sociales (nombre_Obra_social, cantidad_usos) AS(
    SELECT ObraSocial, COUNT(ObraSocial) AS total FROM vw_registros_de_estudios
    GROUP BY ObraSocial
) SELECT * FROM proyeccion_obras_sociales 
WHERE cantidad_usos = (SELECT MAX(cantidad_usos) FROM proyeccion_obras_sociales)
GO
--3.4 (PREGUNTAR)
/*WITH proyeccion_precios_estudio (estudio,ObraSocial,total) AS (
        SELECT Descripcion,NombObraSocial, SUM(PrecioEstudio) AS totalEstudio FROM vw_tabla_de_precios
        GROUP BY Descripcion, NombObraSocial
) SELECT estudio, total FROM proyeccion_precios_estudio
WHERE total = (SELECT MAX(total) AS maxtotal FROM proyeccion_precios_estudio
WHERE Descripcion 
) 
GO


SELECT Descripcion,NombObraSocial, SUM(PrecioEstudio) AS totalEstudio FROM vw_tabla_de_precios
GROUP BY Descripcion, NombObraSocial
WHERE totalEstudio > 7070
GO
*/
-- 3.5
WITH proyeccion_institutos_sin_Estudios_ultMes (Instituto, fecha) AS (
    SELECT RazonSocial,FechaRealizado FROM (Institutos 
    LEFT JOIN (
        SELECT Instituto, FechaRealizado FROM vw_registros_de_estudios 
        WHERE (DATEDIFF(dd, GETDATE(),FechaRealizado) <= 0 AND DATEDIFF(m, GETDATE(),FechaRealizado) >= -1)
    ) AS ultimoMes ON Institutos.RazonSocial = ultimoMes.Instituto)
    GROUP BY RazonSocial, FechaRealizado
) 
SELECT Instituto FROM proyeccion_institutos_sin_Estudios_ultMes
WHERE fecha IS NULL
GO

-- 3.6 cantidad de pacientes mas viejos que no tuvieron estudios en el ultimo ano
/*Explicacion:
    Lo que hacemos es seleccionar todos los registros que tuvieron en el ultimo ano hasta la feha
    algun tipo de estudio, luego los unimos con TODOS los pacientes a travez del DNI, y filtramos
    aquellos en cual el DNI de las consultas sea NULL, debido a que estos no entran en el rango de las
    personas que se realizaron algun tipo de consulta en el ultimo ano.
*/
WITH proyeccion_pacientes_mas_viejos (DNI, NOMBRE, APELLIDO,SEXO,NACIM,TEL) AS (
    Select Pacientes.DNI, Apellido, Nombre,Sexo,Nacimiento,Telefono FROM (Pacientes LEFT JOIN (
        SELECT DNI FROM vw_registros_de_estudios /*Los que tuvieron algun tipo de analisis en el ultimo ano*/
        WHERE DATEDIFF(YEAR,GETDATE(),FechaRealizado) >= -1 AND DATEDIFF(DAY, GETDATE(),FechaRealizado) <= 0
        GROUP BY DNI
        ) AS T1 ON Pacientes.DNI = T1.DNI
    ) WHERE T1.DNI IS NULL
) SELECT * FROM proyeccion_pacientes_mas_viejos
GO

--3.7
/*Descripcion: Lo que hacemos es juntar los datos de las especialidades con aquellas que tienen 
medicos especializados asignados, pero no usamos la info de los medicos pq no nos importa, solo
contamos las matriculas de espeMedi. Dado a que usamos righ join en espemedi sobre especialidad
aquellas especialidades que no tengan medicos estaran como nullas y cuando contemos las matriculas nos dara 0
Por ende luego con el ID, NOMBRE DE ESPECIALIDAD, Y CANTIDAD DE MEDICOS ASIGNADOS, SOLOTENEMOS QUE 
FILTRAR LAS MAS PEQUENAS*/
WITH proyeccion_especialidad_con_menor_medicos (ID, Nombre, Cantidad) AS (
    SELECT Especialidades.IdEspecialidad, Especialidades.Descripcion, COUNT(EspeMedi.Matricula) AS CantMedicos FROM (
        EspeMedi RIGHT JOIN Especialidades ON Espemedi.IdEspecialidad = Especialidades.IdEspecialidad
    ) GROUP BY Especialidades.IdEspecialidad, Especialidades.Descripcion
) SELECT * FROM proyeccion_especialidad_con_menor_medicos
WHERE Cantidad = (SELECT MIN(Cantidad) FROM proyeccion_especialidad_con_menor_medicos)

--3.8
