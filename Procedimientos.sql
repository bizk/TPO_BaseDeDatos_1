/*3.1 
Tenemos que con el nombre buscar lo ID y chequear si coexisten ambos y ver si actualizamos 
o no
*/
CREATE PROCEDURE Procedimiento_3_1 
    @nombreEstudioProc VARCHAR(100),
    @nombreInstitutoProc VARCHAR(100),
    @precio MONEY
AS 
    DECLARE @idEstudioProc INT, @idInstitutoProc INT;
    --Buscamos si existe el estudio, si no loc creamos
    SELECT @idEstudioProc = idEstudio FROM Estudios
        WHERE descripcion = @nombreEstudioProc;
    IF (@idEstudioProc IS NULL)
        BEGIN
            INSERT Estudios (descripcion) VALUES (@nombreEstudioProc)
            SET @idEstudioProc = (SELECT MAX(idEstudio) FROM Estudios) 
        END
            --COmo es identity agarramos el ultimo.
    --Buscamos si existe el instituto, si no lo creamos
    SELECT @idInstitutoProc = IdInstituto FROM Institutos
        WHERE RazonSocial = @nombreInstitutoProc;
    IF (@idInstitutoProc IS NULL)
        BEGIN
            INSERT Institutos (RazonSocial) VALUES (@nombreInstitutoProc)
            SET @idInstitutoProc = (SELECT MAX(IdInstituto) FROM Institutos);
        END
    --Chequeamos si existe la tupla con dichos parametros
    IF EXISTS (SELECT * FROM Precios WHERE (idEstudio = @idEstudioProc AND IdInstituto = @idInstitutoProc))
        UPDATE Precios SET Precio = @precio WHERE (IdEstudio = @idEstudioProc AND IdInstituto = @idInstitutoProc);
    ELSE 
        INSERT Precios (IdEstudio, IdInstituto, Precio) VALUES(@idEstudioProc,@idInstitutoProc,@precio)
GO

/*EXEC Procedimiento_3_1 N'Consulta',N'Hospital Italiano',N'650';
GO*/
--3.2
CREATE PROCEDURE procedimiento_3_2
    @dniInput INT,
    @siglaInput CHAR(2),
    @nroPlanInput SMALLINT,
    @idAfiliadoInput INT
AS 
    IF EXISTS(SELECT * FROM Afiliados WHERE (@idAfiliadoInput = IdAfiliado AND @dniInput = DNI))
        UPDATE Afiliados SET Sigla = @siglaInput, NroPlan = @nroPlanInput 
        WHERE (IdAfiliado = @idAfiliadoInput AND DNI = @dniInput);
    ELSE
        INSERT Afiliados (DNI, Sigla, NroPlan) VALUES (@dniInput, @siglaInput,@nroPlanInput)
GO
/*EXEC procedimiento_3_2 11114444, N'GA', N'2', N'176'
GO */
--3.3
--Muestra  

CREATE PROCEDURE procedimiento_3_3
    @mesInput INT,
    @yearInput INT
AS
    SELECT Registros.IdRegistro, REgistros.Fecha, vw_pacientes.*, Estudios.Descripcion 
    FROM ((Registros LEFT JOIN vw_pacientes ON Registros.DNI = vw_pacientes.DNI)
    JOIN Estudios ON EStudios.IdEstudio = Registros.IdEstudio
    )WHERE (@mesInput = MONTH(Fecha) AND @yearInput = YEAR(Fecha));
GO
/*EXEC procedimiento_3_3 N'6',N'2019';
EXEC procedimiento_3_3 N'5',N'2019';
EXEC procedimiento_3_3 N'7',N'2019';
GO*/
--3.4
--Muestra los medicos de un determinadad epecialidad y sexo
CREATE PROCEDURE procedimiento_3_4 
    @especialidad SMALLINT,
    @sexo CHAR(1) NULL
AS
    IF (@sexo IS NULL)
        BEGIN
            SELECT * FROM (Medicos JOIN EspeMedi ON Medicos.Matricula = EspeMedi.Matricula)
            WHERE @especialidad = EspeMedi.IdEspecialidad;
        END
    ELSE IF (@sexo = 'm')
        BEGIN
            SELECT * FROM (Medicos JOIN EspeMedi ON Medicos.Matricula = EspeMedi.Matricula)
            WHERE (@especialidad = EspeMedi.IdEspecialidad AND Medicos.Sexo = 'm');    
        END
    ELSE
        BEGIN
            SELECT * FROM (Medicos JOIN EspeMedi ON Medicos.Matricula = EspeMedi.Matricula)
            WHERE (@especialidad = EspeMedi.IdEspecialidad AND Medicos.Sexo = 'F');    
        END
GO

/*EXEC procedimiento_3_4 N'1',NULL
EXEC procedimiento_3_4 N'1', 'm'
EXEC procedimiento_3_4 N'1', 'f'
GO*/

--3.5
/*Estudios que estan cubiertos por una obra social, con su cobertura */
CREATE PROCEDURE procedimiento_3_5
    @obraSocial VARCHAR(50),
    @nombrePlan VARCHAR(50) NULL
AS --Buscamos las variables para filtrar luego
    DECLARE @siglaObraSocial CHAR(2), @idPlan SMALLINT;
   SELECT @siglaObraSocial = Sigla FROM ObraSocial 
        WHERE nombre = @obraSocial;
    SELECT @idPlan = NroPlan FROM Planes
        WHERE NombrePLan = @nombrePlan;
    IF (@idPlan IS NOT NULL) --SI el plan existe/se encontro/No es nuo filramos por plan
        BEGIN
            SELECT Estudios.Descripcion, Estudios.IdEstudio, Coberturas.Cobertura, Coberturas.NroPlan FROM (
                 Coberturas JOIN Estudios ON Coberturas.IdEstudio = Estudios.IdEstudio
                ) WHERE (Coberturas.Sigla = @siglaObraSocial AND Coberturas.NroPlan = @idPlan);
        END
    ELSE --Si es nulo imprimimos todos, o si no la encuentra
        BEGIN
            SELECT Estudios.Descripcion, Estudios.IdEstudio, Coberturas.Cobertura, Coberturas.NroPlan FROM (
                Coberturas JOIN Estudios ON Coberturas.IdEstudio = Estudios.IdEstudio
                ) WHERE (Coberturas.Sigla = @siglaObraSocial);
        END
GO

/*EXEC procedimiento_3_5 N'Galeno',NULL
EXEC procedimiento_3_5 N'Galeno',N'Bronce'
GO*/

--3.6
/**/

CREATE PROCEDURE procedimiento_3_6
    @obraSocial VARCHAR(50) NULL,
    @nombrePlan VARCHAR(50) NULL,
    @matricula INT NULL
AS
    DECLARE @siglaObraSocial CHAR(2), @idPlan SMALLINT;
    SELECT @siglaObraSocial = Sigla FROM ObraSocial 
        WHERE nombre = @obraSocial;
    SELECT @idPlan = NroPlan FROM Planes
        WHERE NombrePLan = @nombrePlan;
    SELECT ObraSocial.Nombre, Planes.NombrePLan, Registros.Matricula,COUNT(*) AS cantidad
        FROM ((Registros JOIN Estudios ON Registros.IdEstudio = Estudios.IdEstudio) JOIN
        (ObraSocial JOIN Planes ON Planes.Sigla = ObraSocial.Sigla) ON ObraSocial.Sigla = Registros.Sigla)
        WHERE (@siglaObraSocial IS NULL OR @siglaObraSocial = Registros.Sigla)
            AND (@idPlan IS NULL OR @idPlan = Planes.NroPlan)
            AND (@matricula IS NULL OR @matricula = Registros.Matricula)
        GROUP BY ObraSocial.Nombre, Planes.NombrePLan, Registros.Matricula
GO

/*EXEC procedimiento_3_6 N'OSDE',NULL,NULL
EXEC procedimiento_3_6 NULL,NULL,NULL
EXEC procedimiento_3_6 NULL,NULL,N'781'
EXEC procedimiento_3_6 NULL,NULL,N'44025'
EXEC procedimiento_3_6 N'Galeno',NULL,NULL
EXEC procedimiento_3_6 N'Galeno',NULL,N'44025'
EXEC procedimiento_3_6 N'Galeno',N'Oro',N'44025'
GO*/

--3;7
/* Crear procedimiento que proyecte dni, FDNACIM, Nombre y Apellido de los pacientes
que corresponda a los n pacientes ams viejos cuyo apelido cumpla con un determinado valor
de caraceteres 
*/
CREATE PROCEDURE procedimiento_3_7
    @n INT,
    @patron VARCHAR(100) NULL
AS
    SELECT TOP (@n) *, DATEDIFF(YEAR, Nacimiento,GETDATE()) AS Edad FROM Pacientes
    WHERE (@patron IS NULL OR Apellido LIKE '%'+@patron+'%')
    ORDER BY Edad DESC --Este nos deberia limitar
GO

/*EXEC procedimiento_3_7 5,NULL;
EXEC procedimiento_3_7 5,'li';
EXEC procedimiento_3_7 2,'ma';
GO*/

--3.8
/*Este procedimiento devuelve el total a liaquidar  aun institutio
*/
CREATE PROCEDURE procedimiento_3_8
    @instituto VARCHAR(100),
    @inicioPeriodo DATE,
    @finPeriodo DATE
AS
    SELECT Institutos.RazonSocial, Institutos.IdInstituto, SUM(Precios.Precio) as Total FROM ((
        Registros JOIN Institutos ON Registros.IdInstituto = Institutos.IdInstituto) JOIN
        Precios ON (Precios.IdEstudio = Registros.IdEstudio AND Precios.IdInstituto = Institutos.IdInstituto)
    ) 
    WHERE (@instituto IS NULL OR Institutos.RazonSocial = @instituto) AND (
        (DATEDIFF(DD,@inicioPeriodo,Registros.Fecha)>=0 AND DATEDIFF(DD,Registros.Fecha,@finPeriodo)>=0)
    ) GROUP BY Institutos.IdInstituto, Institutos.RazonSocial

GO

/*exec procedimiento_3_8 'Hospital Aleman','05/20/2019','05/31/2019'
exec procedimiento_3_8 'Hospital Aleman','06/02/2019','06/03/2019'
exec procedimiento_3_8 'Hospital Aleman','05/20/2019','06/03/2019'
exec procedimiento_3_8 null,'05/20/2019','06/21/2019'
GO*/

--3.9
/*

reveeeeeeeeeeeeeeer

Nota = En un lado habla de punitorio diario y en el otro a nivel mensal.
*/
CREATE PROCEDURE procedimiento_3_9
    @dni INT,
    @estudio VARCHAR(100) NULL,
    @fecha DATE,
    @punitorio MONEY
AS
    IF DATEDIFF(MM, @fecha,GETDATE()) >= 1
        BEGIN
            DECLARE @idEstudio INT;
            SELECT @idEstudio = IdEstudio FROM Estudios WHERE Descripcion = @estudio; 
            SELECT Registros.DNI,Estudios.Descripcion,EStudios.IdEstudio, 
                SUM(Precios.Precio) + COUNT(*)*DATEDIFF(DD, @fecha,GETDATE())/31.0*@punitorio AS Total, Fecha
                FROM (
                (Precios JOIN Estudios ON Estudios.IdEstudio = Precios.IdEstudio) JOIN
                    Registros ON Estudios.IdEstudio = Registros.IdEstudio AND Precios.IdInstituto = Registros.IdINstituto
            )
            WHERE @dni = Registros.DNI AND (@fecha IS NULL OR @fecha = Registros.Fecha) 
                AND (@estudio IS NULL OR @idEstudio = Estudios.IdEstudio)
            GROUP BY Registros.DNI, Estudios.IdEstudio, Estudios.Descripcion, Precios.Precio, Fecha
        END
    ELSE
        PRINT 'El paciente no se encuentra en situacion punitoria para dicha fecha'
GO
/*EXEC procedimiento_3_9 11114444,'Antropometria.','05/29/2019',50
GO*/
--3.10
CREATE PROCEDURE procedimiento_3_10
    @mes SMALLINT,
    @ano INT
AS
    SELECT COUNT(DNI) as CantPacientes, COUNT(Matricula) as CantMedicos FROM Registros
    WHERE MONTH(Fecha) = @mes AND YEAR(Fecha) = @ano
    GROUP BY DNI, Matricula
GO
/*EXEC procedimiento_3_10 5,2019
EXEC procedimiento_3_10 6,2019
EXEC procedimiento_3_10 7,2019
EXEC procedimiento_3_10 5,2018
EXEC procedimiento_3_10 5,2020
EXEC procedimiento_3_10 5,0
EXEC procedimiento_3_10 5,29999999999999
GO*/



