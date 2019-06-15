--1 :)
CREATE VIEW vw_coberturas as
SELECT ObraSocial.Sigla, ObraSocial.Nombre, Planes.NroPlan, Planes.NombrePlan, Estudios.IdEstudio, Estudios.Descripcion, Coberturas.Cobertura
FROM (((ObraSocial JOIN Planes ON ObraSocial.Sigla=Planes.Sigla) 
JOIN Coberturas ON Planes.Sigla=Coberturas.Sigla AND Planes.NroPlan=Coberturas.NroPlan) 
JOIN Estudios ON Estudios.IdEstudio=Coberturas.IdEstudio)
GO
--2 :)
CREATE VIEW vw_medicos_activos AS
SELECT Medicos.Matricula, Medicos.Nombre, Medicos.Apellido, Medicos.Sexo 
FROM Medicos WHERE Medicos.Activo=1
GO
--3 :) Estara bien? dos pacientes pueden tener la 
--Muesra a aquellos que no tienne nro de afiliado
CREATE VIEW vw_pacientes AS 
SELECT Pacientes.DNI, Pacientes.Nombre AS nombrePaciente, Pacientes.Apellido,
     Pacientes.Sexo, Pacientes.Nacimiento, ObraSocial.Nombre AS nombreObraSocial,
    Afiliados.NroPlan,Planes.NombrePLan,Afiliados.IdAfiliado
FROM (((Pacientes LEFT JOIN Afiliados ON Pacientes.DNI=Afiliados.DNI)
     LEFT JOIN ObraSocial ON ObraSocial.Sigla=Afiliados.Sigla)
     LEFT JOIN Planes ON (Afiliados.NroPlan = Planes.NroPlan AND Afiliados.Sigla = Planes.Sigla))
ORDER BY Pacientes.DNI
GO
SELECT * FROM Pacientes
--4 :)
CREATE VIEW vw_pacientes_sin_cobertura AS
SELECT Pacientes.DNI, Pacientes.Nombre, Pacientes.Apellido, Pacientes.Sexo, Pacientes.Nacimiento
FROM Pacientes LEFT OUTER JOIN Afiliados ON Pacientes.DNI = Afiliados.DNI
WHERE Afiliados.IdAfiliado IS NULL
GROUP BY Pacientes.DNI, Pacientes.Nombre, Pacientes.Apellido, Pacientes.Sexo,Pacientes.Nacimiento
GO

--5 :)
CREATE VIEW vw_total_medicos_sin_especialidades (Sexo, Cantidad) AS
SELECT Medicos.Sexo, Count(Medicos.Matricula)
FROM Medicos LEFT JOIN EspeMedi ON Medicos.Matricula=EspeMedi.Matricula
WHERE IdEspecialidad IS NULL
GROUP BY Medicos.Sexo
GO

--6 >:D
CREATE VIEW vw_afiliados_con_una_cobertura AS
SELECT Pacientes.DNI, Pacientes.Nombre, Pacientes.Apellido FROM Pacientes INNER JOIN Afiliados ON Pacientes.DNI=Afiliados.DNI
GROUP BY Pacientes.DNI, Pacientes.Nombre, Pacientes.Apellido
HAVING COUNT(Afiliados.DNI) = 1
GO

--7 :)
CREATE VIEW vw_cantidad_estudios_por_medico AS
SELECT Medicos.Matricula, Medicos.Nombre, Medicos.Apellido, Count (Registros.Matricula) AS CantEstudios
FROM Medicos JOIN Registros ON Medicos.Matricula = Registros.Matricula
GROUP BY Medicos.Matricula, Medicos.Nombre, Medicos.Apellido
GO

--8 Recontra chequear :)
CREATE VIEW vw_registros_de_estudios AS
SELECT Pacientes.DNI, Pacientes.Nombre, Pacientes.Apellido, Registros.IdEstudio, Estudios.Descripcion AS DescEstudio, Institutos.RazonSocial AS Instituto, Medicos.Matricula AS MatriculaSolicitante, Medicos.Apellido AS ApellidoSolicitante, Registros.Fecha AS FechaRealizado, ObraSocial.Nombre AS ObraSocial
FROM (((((Pacientes JOIN Registros ON Pacientes.DNI = Registros.DNI) 
JOIN Medicos ON Registros.Matricula=Medicos.Matricula) 
JOIN Institutos ON Institutos.IdInstituto = Registros.IdInstituto) 
JOIN Estudios ON Registros.IdEstudio=Estudios.IdEstudio) 
JOIN ObraSocial ON Registros.Sigla=ObraSocial.Sigla)
GO

--9 :)
CREATE VIEW vw_estudios_sin_cobertura AS
Select Estudios.IdEstudio, Estudios.Descripcion
FROM Estudios LEFT JOIN Coberturas ON Estudios.IdEstudio = Coberturas.IdEstudio
WHERE Coberturas.IdEstudio IS NULL
GO

--10 :)
CREATE VIEW  vw_planes_sin_cobertura AS
SELECT Planes.Sigla, Planes.NombrePLan AS Nombre_plan, Planes.NroPlan, ObraSocial.Nombre AS Obra_social
FROM (Planes LEFT OUTER JOIN Coberturas ON Planes.NroPlan = Coberturas.NroPlan AND Planes.Sigla = Coberturas.Sigla) JOIN ObraSocial ON Planes.Sigla = ObraSocial.Sigla 
WHERE Coberturas.Sigla IS NULL;
GO

--11 Chequear cálculo de monto cubierto según cómo se almacene la Cobertura
-- También verificar si el número de plan modifica algo (Creo que no)
CREATE VIEW vw_tabla_de_precios AS
SELECT Estudios.Descripcion, ObraSocial.Nombre AS NombObraSocial, 
Planes.NombrePlan, Institutos.RazonSocial AS Instituto, Precios.Precio AS PrecioEstudio, 
Coberturas.Cobertura AS PorcentajeCubierto,  (Coberturas.Cobertura*100)/Precios.Precio AS MontoCubierto
FROM (((((Estudios JOIN Coberturas ON Estudios.IdEstudio = Coberturas.IdEstudio) 
JOIN ObraSocial ON Coberturas.Sigla=ObraSocial.Sigla)
JOIN Planes ON Planes.NroPlan = Coberturas.NroPlan)
JOIN Precios ON Precios.IdEstudio = Estudios.IdEstudio)
JOIN Institutos ON Precios.IdInstituto = Institutos.IdInstituto)
GO

--12 :)
CREATE VIEW vw_estudios_a_prepagas AS 
SELECT Registros.IdEstudio, Estudios.Descripcion AS NombreEstudio,
     ObraSocial.Nombre AS Prepaga, Registros.Fecha
FROM ((Registros JOIN Estudios ON Registros.IdEstudio = Estudios.IdEstudio)
JOIN ObraSocial ON Registros.Sigla=ObraSocial.Sigla)
WHERE ObraSocial.Categoria = 'pp' AND abs(DateDiff(dd, Registros.Fecha,getDate())) <=45
GO

--13 Chequear :)
CREATE VIEW vw_estudios_por_mes AS
SELECT Estudios.Descripcion AS Estudio, Pacientes.Sexo, Count(Estudios.IdEstudio) AS CantRealizados, DATENAME(m, Registros.Fecha) AS Mes
FROM ((Pacientes JOIN Registros ON Pacientes.DNI = Registros.DNI) 
JOIN Estudios ON Estudios.IdEstudio = Registros.IdEstudio)
GROUP BY Pacientes.Sexo, Estudios.Descripcion, DATENAME(m, Registros.Fecha)
HAVING COUNT(Estudios.Descripcion) >= 1
GO
--14 :)
CREATE VIEW  vw_estudios_por_instituto AS
SELECT Registros.IdInstituto, Institutos.RazonSocial AS Instituto, Count(Registros.IdInstituto) AS CantEstudios
FROM Registros JOIN Institutos ON Registros.IdInstituto = Institutos.IdInstituto
WHERE DateDiff(dd,Registros.Fecha, getDate())<15
GROUP BY datepart(wk, registros.Fecha), Registros.IdINstituto, Institutos.RazonSocial
GO
