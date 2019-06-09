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
