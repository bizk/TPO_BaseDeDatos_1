--Regla sigla
ALTER TABLE Planes
	add constraint regla_Planes_sigla CHECK(Sigla NOT like '%[0-9]%')
--Regla dni
ALTER TABLE Pacientes
	add constraint regla_Pacientes_dni CHECK(DNI LIKE '%[0-9]%')

--Regla Categoria
ALTER TABLE ObraSocial
    ADD CONSTRAINT regla_ObraSocial_categoria CHECK (Categoria IN ('os', 'pp'));
--Regla sexo
ALTER TABLE Pacientes
    ADD CONSTRAINT regla_Pacientes_sexo CHECK (Sexo IN ('f','m'));
ALTER TABLE Medicos
    ADD CONSTRAINT regla_Medicos_sexo CHECK (Sexo IN ('f','m'));

--Regla fecha de estudio // En posterior no seria un mes despues?
ALTER TABLE Registros
	add constraint regla_Registros_fechaEstudio CHECK (abs(datediff(wk,Fecha,getdate()))<4)

--Regla fecha de nacimiento(es el unico que no se si esta bien)
ALTER TABLE Pacientes 
 ADD CONSTRAINT regla_Pacientes_Nacimiento CHECK( 21<datediff(yy,nacimiento, getdate()) AND datediff(yy,nacimiento, getdate())<80);                                                              
ALTER TABLE Medicos
 ADD CONSTRAINT regla_Medicos_Nacimiento CHECK( 21<datediff(yy,Nacimiento, getdate()) AND datediff(yy,Nacimiento, getdate())<80);                                                              

--Regla NroPlan
ALTER TABLE Planes
    ADD CONSTRAINT check_Plan_NroPlan CHECK (NroPlan <= 12 AND NroPlan >= 0);
ALTER TABLE Afiliados
    ADD CONSTRAINT check_Afiliados_NroPlan CHECK (NroPlan <= 12 AND NroPlan >= 0);
ALTER TABLE Coberturas
    ADD CONSTRAINT check_Coberturas_NroPlan CHECK (NroPlan <= 12 AND NroPlan >= 0);
     
--Regla Precio
ALTER TABLE Precios
    ADD CONSTRAINT check_Precios_Precio CHECK (Precio >= $0 AND Precio <= $8000);

--Regla CObertura
ALTER TABLE Coberturas  
	ADD CONSTRAINT  check_Coberturas_porcentaje CHECK(0<=cobertura  AND cobertura<=100);                                                              
                                                              
--Regla estado
ALTER TABLE Medicos
    ADD CONSTRAINT check_Medicos_Activo CHECK (Activo <= 1 AND Activo >= 0);
GO