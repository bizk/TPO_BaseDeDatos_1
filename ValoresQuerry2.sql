INSERT INTO Especialidades (Descripcion) VALUES ('Oncologia');
INSERT INTO Especialidades (Descripcion) VALUES ('Nutricion');
INSERT INTO Especialidades (Descripcion) VALUES ('Psiquiatria');
INSERT INTO Especialidades (Descripcion) VALUES ('Oftalmologia');
INSERT INTO Especialidades (Descripcion) VALUES ('Cirugia');
INSERT INTO Especialidades (Descripcion) VALUES ('Terapia intensiva');

INSERT INTO Medicos (Matricula, Apellido, Nombre, Sexo, Nacimiento, Activo) VALUES (000011,'Lopez','Anibal','m','1/3/1980',1);
INSERT INTO Medicos (Matricula, Apellido, Nombre, Sexo, Nacimiento, Activo) VALUES (044025,'Castillo','Daniela','f','7/6/1979',1);
INSERT INTO Medicos (Matricula, Apellido, Nombre, Sexo, Nacimiento, Activo) VALUES (485920,'Pepe','Santiago','m','1/2/1929',0);
INSERT INTO Medicos (Matricula, Apellido, Nombre, Sexo, Nacimiento, Activo) VALUES (075001,'Kilmer','Paulina','f','8/22/1989',1);
INSERT INTO Medicos (Matricula, Apellido, Nombre, Sexo, Nacimiento, Activo) VALUES (000781,'Ramirez','Julia','f','1/2/1942',0);

INSERT INTO Estudios (Descripcion) VALUES ('EcoDoppler cardiaco.');
INSERT INTO Estudios (Descripcion) VALUES ('Ergometria.');
INSERT INTO Estudios (Descripcion) VALUES ('Antropometria.');
INSERT INTO Estudios (Descripcion) VALUES ('Tomografia craneal');
INSERT INTO Estudios (Descripcion) VALUES ('Ecografia abdominal');
INSERT INTO Estudios (Descripcion) VALUES ('Analisis de Sangre completo');
INSERT INTO Estudios (Descripcion) VALUES ('Transfusion de plaquetas.');
INSERT INTO Estudios (Descripcion) VALUES ('Consulta.');

INSERT INTO Institutos (RazonSocial, Vigente) VALUES ('Clinica Moguillansky',1);
INSERT INTO Institutos (RazonSocial, Vigente) VALUES ('Hospital Aleman',1);
INSERT INTO Institutos (RazonSocial, Vigente) VALUES ('Clinica Santa Catalina',0);
INSERT INTO Institutos (RazonSocial, Vigente) VALUES ('Hospital Britanico',1);
INSERT INTO Institutos (RazonSocial, Vigente) VALUES ('Sanatorio Rio Cuarto',0);
INSERT INTO Institutos (RazonSocial, Vigente) VALUES ('Hospital Italiano',1);

INSERT INTO ObraSocial (Sigla, Nombre, Categoria) VALUES ('OC','OSECAC','os');
INSERT INTO ObraSocial (Sigla, Nombre, Categoria) VALUES ('IN','Instituto','os');
INSERT INTO ObraSocial (Sigla, Nombre, Categoria) VALUES ('GA','Galeno','pp');
INSERT INTO ObraSocial (Sigla, Nombre, Categoria) VALUES ('OM','Omint','pp');
INSERT INTO ObraSocial (Sigla, Nombre, Categoria) VALUES ('SW','Swiss Medical','pp');
INSERT INTO ObraSocial (Sigla, Nombre, Categoria) VALUES ('UB','Obra Social de la UBA','os');
INSERT INTO ObraSocial (Sigla, Nombre, Categoria) VALUES ('OS','OSDE','os');

INSERT INTO Pacientes (DNI, Apellido, Nombre, Sexo, Nacimiento, Telefono) VALUES (15151515,'Lopez','Agustin', 'm','1/2/1989','+54355406879');
INSERT INTO Pacientes (DNI, Apellido, Nombre, Sexo, Nacimiento, Telefono) VALUES (12347778,'Augusto','Ailen', 'f','1/7/1997','+54528606829');
INSERT INTO Pacientes (DNI, Apellido, Nombre, Sexo, Nacimiento, Telefono) VALUES (40415868,'Pavloski','Boris', 'm','1/9/1979','+54354406879');
INSERT INTO Pacientes (DNI, Apellido, Nombre, Sexo, Nacimiento, Telefono) VALUES (12878798,'Carolio','Carolina', 'f','12/7/1949','+54344875379');
INSERT INTO Pacientes (DNI, Apellido, Nombre, Sexo, Nacimiento, Telefono) VALUES (12751498,'Maggi','Sulivan', 'm','12/2/1987','+5435498879');
INSERT INTO Pacientes (DNI, Apellido, Nombre, Sexo, Nacimiento, Telefono) VALUES (75345698,'Grande','Ariana', 'f','1/8/1979','+5435806639');
--54
INSERT INTO Pacientes (DNI, Apellido, Nombre, Sexo, Nacimiento, Telefono) VALUES (11111111,'Stark','Antonio', 'm','1/10/1990','1241234214');
INSERT INTO Pacientes (DNI, Apellido, Nombre, Sexo, Nacimiento, Telefono) VALUES (11112222,'Parque','Pedro', 'm','3/17/1985','+557457547');
INSERT INTO Pacientes (DNI, Apellido, Nombre, Sexo, Nacimiento, Telefono) VALUES (11113333,'Magno','Alejandro', 'm','9/9/1983','+543543464');
INSERT INTO Pacientes (DNI, Apellido, Nombre, Sexo, Nacimiento, Telefono) VALUES (11114444,'Otter','Julia', 'f','3/7/1994','+54345754');
INSERT INTO Pacientes (DNI, Apellido, Nombre, Sexo, Nacimiento, Telefono) VALUES (11115555,'Marquez','Carla', 'f','12/4/1947','+5435457547');
INSERT INTO Pacientes (DNI, Apellido, Nombre, Sexo, Nacimiento, Telefono) VALUES (11119999,'Li','Zu', 'f','7/1/1979','+5434356346');

INSERT INTO EspeMedi (IdEspecialidad, Matricula) VALUES (6,000011)
INSERT INTO EspeMedi (IdEspecialidad, Matricula) VALUES (1,044025)
INSERT INTO EspeMedi (IdEspecialidad, Matricula) VALUES (2,485920)
INSERT INTO EspeMedi (IdEspecialidad, Matricula) VALUES (3,075001)
INSERT INTO EspeMedi (IdEspecialidad, Matricula) VALUES (4,000781)
INSERT INTO EspeMedi (IdEspecialidad, Matricula) VALUES (5,000781)

INSERT INTO EstuEspe (IdEstudio, IdEspecialidad) VALUES (1,1)
INSERT INTO EstuEspe (IdEstudio, IdEspecialidad) VALUES (1,2)
INSERT INTO EstuEspe (IdEstudio, IdEspecialidad) VALUES (2,1)
INSERT INTO EstuEspe (IdEstudio, IdEspecialidad) VALUES (3,1)
INSERT INTO EstuEspe (IdEstudio, IdEspecialidad) VALUES (4,4)
INSERT INTO EstuEspe (IdEstudio, IdEspecialidad) VALUES (5,3)
INSERT INTO EstuEspe (IdEstudio, IdEspecialidad) VALUES (5,5)
INSERT INTO EstuEspe (IdEstudio, IdEspecialidad) VALUES (5,6)
INSERT INTO EstuEspe (IdEstudio, IdEspecialidad) VALUES (6,3)
INSERT INTO EstuEspe (IdEstudio, IdEspecialidad) VALUES (6,4)
INSERT INTO EstuEspe (IdEstudio, IdEspecialidad) VALUES (7,2)
INSERT INTO EstuEspe (IdEstudio, IdEspecialidad) VALUES (7,2)
INSERT INTO EstuEspe (IdEstudio, IdEspecialidad) VALUES (7,3)
INSERT INTO EstuEspe (IdEstudio, IdEspecialidad) VALUES (7,4)
INSERT INTO EstuEspe (IdEstudio, IdEspecialidad) VALUES (7,4)
INSERT INTO EstuEspe (IdEstudio, IdEspecialidad) VALUES (7,5)
INSERT INTO EstuEspe (IdEstudio, IdEspecialidad) VALUES (8,1)
INSERT INTO EstuEspe (IdEstudio, IdEspecialidad) VALUES (8,1)
INSERT INTO EstuEspe (IdEstudio, IdEspecialidad) VALUES (8,2)
INSERT INTO EstuEspe (IdEstudio, IdEspecialidad) VALUES (8,6)
INSERT INTO EstuEspe (IdEstudio, IdEspecialidad) VALUES (8,3)
INSERT INTO EstuEspe (IdEstudio, IdEspecialidad) VALUES (2,3)
INSERT INTO EstuEspe (IdEstudio, IdEspecialidad) VALUES (3,4)
INSERT INTO EstuEspe (IdEstudio, IdEspecialidad) VALUES (3,5)
INSERT INTO EstuEspe (IdEstudio, IdEspecialidad) VALUES (2,6)

INSERT INTO Planes (Sigla,NroPlan,NombrePlan) VALUES ('OS',1, '310') 
INSERT INTO Planes (Sigla,NroPlan,NombrePlan) VALUES ('OS',2, '210')
INSERT INTO Planes (Sigla,NroPlan,NombrePlan) VALUES ('OS',3, '410')
INSERT INTO Planes (Sigla,NroPlan,NombrePlan) VALUES ('OC',1, 'Empleados') 
INSERT INTO Planes (Sigla,NroPlan,NombrePlan) VALUES ('OC',2, 'Gerenciales') 
INSERT INTO Planes (Sigla,NroPlan,NombrePlan) VALUES ('IN',1, 'Basico') 
INSERT INTO Planes (Sigla,NroPlan,NombrePlan) VALUES ('IN',2, 'Jerarquicos') 
INSERT INTO Planes (Sigla,NroPlan,NombrePlan) VALUES ('GA',1, 'Bronce') 
INSERT INTO Planes (Sigla,NroPlan,NombrePlan) VALUES ('GA',2, 'Plata') 
INSERT INTO Planes (Sigla,NroPlan,NombrePlan) VALUES ('GA',3, 'Oro') 
INSERT INTO Planes (Sigla,NroPlan,NombrePlan) VALUES ('OM',1, 'Vos') 
INSERT INTO Planes (Sigla,NroPlan,NombrePlan) VALUES ('OM',2, 'AltoPlan') 
INSERT INTO Planes (Sigla,NroPlan,NombrePlan) VALUES ('SW',1, 'Suizo')  
INSERT INTO Planes (Sigla,NroPlan,NombrePlan) VALUES ('SW',2, 'Suizo Premium') 
INSERT INTO Planes (Sigla,NroPlan,NombrePlan) VALUES ('SW',3, 'Suizo VIP') 
INSERT INTO Planes (Sigla,NroPlan,NombrePlan) VALUES ('UB',1, 'Academicos') 
INSERT INTO Planes (Sigla,NroPlan,NombrePlan) VALUES ('UB',2, 'Decanato') 
INSERT INTO Planes (Sigla,NroPlan,NombrePlan) VALUES ('UB',3, 'Anexos') 

INSERT INTO Precios (IdEstudio,IdInstituto,Precio) VALUES (1,2,50)
INSERT INTO Precios (IdEstudio,IdInstituto,Precio) VALUES (1,4,70)
INSERT INTO Precios (IdEstudio,IdInstituto,Precio) VALUES (2,3,90)
INSERT INTO Precios (IdEstudio,IdInstituto,Precio) VALUES (3,1,80)
INSERT INTO Precios (IdEstudio,IdInstituto,Precio) VALUES (4,1,800)
INSERT INTO Precios (IdEstudio,IdInstituto,Precio) VALUES (7,1,250)
INSERT INTO Precios (IdEstudio,IdInstituto,Precio) VALUES (6,1,150)
INSERT INTO Precios (IdEstudio,IdInstituto,Precio) VALUES (8,1,450)
INSERT INTO Precios (IdEstudio,IdInstituto,Precio) VALUES (8,2,200)
INSERT INTO Precios (IdEstudio,IdInstituto,Precio) VALUES (1,3,450)
INSERT INTO Precios (IdEstudio,IdInstituto,Precio) VALUES (3,3,100)
INSERT INTO Precios (IdEstudio,IdInstituto,Precio) VALUES (8,4,500)
INSERT INTO Precios (IdEstudio,IdInstituto,Precio) VALUES (2,4,920)
INSERT INTO Precios (IdEstudio,IdInstituto,Precio) VALUES (3,4,820)
INSERT INTO Precios (IdEstudio,IdInstituto,Precio) VALUES (4,5,800)
INSERT INTO Precios (IdEstudio,IdInstituto,Precio) VALUES (5,5,250)
INSERT INTO Precios (IdEstudio,IdInstituto,Precio) VALUES (6,5,150)
INSERT INTO Precios (IdEstudio,IdInstituto,Precio) VALUES (7,6,200)
INSERT INTO Precios (IdEstudio,IdInstituto,Precio) VALUES (8,6,250)
INSERT INTO Precios (IdEstudio,IdInstituto,Precio) VALUES (7,5,200)
INSERT INTO Precios (IdEstudio,IdInstituto,Precio) VALUES (8,5,250)

--En la tabla coberturas falta el campo "coberturas", lo cuento como un INTEGER con valores del 0 al 100, representando porcentaje
INSERT INTO Coberturas(IdEstudio,Sigla,NroPlan,Cobertura) VALUES (7,'GA',1,80)
INSERT INTO Coberturas(IdEstudio,Sigla,NroPlan,Cobertura) VALUES (3,'GA',2,100)
INSERT INTO Coberturas(IdEstudio,Sigla,NroPlan,Cobertura) VALUES (1,'GA',3,40)
INSERT INTO Coberturas(IdEstudio,Sigla,NroPlan,Cobertura) VALUES (2,'OC',1,75)
INSERT INTO Coberturas(IdEstudio,Sigla,NroPlan,Cobertura) VALUES (4,'OM',2,35)
INSERT INTO Coberturas(IdEstudio,Sigla,NroPlan,Cobertura) VALUES (3,'OC',1,10)

--Voy a dejar esto por un momento porque no sé si los planes tienen un número único en toda la tabla o sólo en los planes de la obra social.
--Pasa lo mismo con la tabla AFILIADOS
INSERT INTO Afiliados(DNI,Sigla,NroPlan) VALUES(12347778,'IN',1)
INSERT INTO Afiliados(DNI,Sigla,NroPlan) VALUES(12347778,'SW',3)
INSERT INTO Afiliados(DNI,Sigla,NroPlan) VALUES(12751498,'OM',1)
INSERT INTO Afiliados(DNI,Sigla,NroPlan) VALUES(40415868,'OS',2)
INSERT INTO Afiliados(DNI,Sigla,NroPlan) VALUES(75345698,'SW',1)


--Tabla Registros-- 
--Tambien la voy a dejar comentada, porque después hay que verificar que los pacientes sean socios de esas obras sociales.--
--Habría que hacer un registro para cada paciente para que sea logica su presencia en el sistema, pero no es fundamental
INSERT INTO Registros (Fecha, DNI, IdEstudio,IdInstituto, Matricula, Sigla) VALUES ('05/21/2019', 15151515,8,1,000011,'OS')
INSERT INTO Registros (Fecha, DNI, IdEstudio,IdInstituto, Matricula, Sigla) VALUES ('05/20/2019', 12347778,8,2,044025,'OC')
INSERT INTO Registros (Fecha, DNI, IdEstudio,IdInstituto, Matricula, Sigla) VALUES ('10/05/2019', 40415868,1,2,781,'GA')
INSERT INTO Registros (Fecha, DNI, IdEstudio,IdInstituto, Matricula, Sigla) VALUES ('01/03/2005', 15151515,3,3,000011,'OS')
INSERT INTO Registros (Fecha, DNI, IdEstudio,IdInstituto, Matricula, Sigla) VALUES ('06/01/2019', 11119999,4,1,000011,'OS')
INSERT INTO Registros (Fecha, DNI, IdEstudio,IdInstituto, Matricula, Sigla) VALUES ('06/02/2019', 11112222,1,2,044025,'OC')
INSERT INTO Registros (Fecha, DNI, IdEstudio,IdInstituto, Matricula, Sigla) VALUES ('06/01/2019', 40415868,2,4,781,'GA')
INSERT INTO Registros (Fecha, DNI, IdEstudio,IdInstituto, Matricula, Sigla) VALUES ('06/04/2019', 11112222,3,1,000011,'OS')
INSERT INTO Registros (Fecha, DNI, IdEstudio,IdInstituto, Matricula, Sigla) VALUES ('06/05/2019', 11113333,3,3,781,'OS')
INSERT INTO Registros (Fecha, DNI, IdEstudio,IdInstituto, Matricula, Sigla) VALUES ('05/29/2019', 11114444,3,3,044025,'GA')
INSERT INTO Registros (Fecha, DNI, IdEstudio,IdInstituto, Matricula, Sigla) VALUES ('05/24/2019', 11115555,3,3,044025,'GA')