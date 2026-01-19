CREATE DATABASE IF NOT EXISTS SistemaMetro;
USE SistemaMetro;

-- =====================================================
-- Tablas de la DB
-- =====================================================

-- tabla usuarios
CREATE TABLE Usuarios (
    cedula_usuario INT NOT NULL,
    nombre_usuario VARCHAR(40) NOT NULL,
    apellido_usuario VARCHAR(40) NOT NULL,
    direccion_usuario VARCHAR(40) NOT NULL,
    telefono_usuario VARCHAR(10) NOT NULL,
    estrato_usuario INT NOT NULL,
    fecha_nacimiento_usuario DATE NOT NULL,
    PRIMARY KEY (cedula_usuario)
);

-- Tabla Perfil_civica
CREATE TABLE Perfil_civica (
    id_perfil_civica INT NOT NULL AUTO_INCREMENT,
    tipo_perfil VARCHAR(40) NOT NULL,
    descuento_tarifa INT NOT NULL,
    descripcion VARCHAR(100) NOT NULL,
    PRIMARY KEY (id_perfil_civica)
);

-- Tabla Civica
CREATE TABLE Civica (
    id_civica INT NOT NULL AUTO_INCREMENT,
    saldo INT NOT NULL,
    fecha_emision DATE NOT NULL,
    estado_civica VARCHAR(1) NOT NULL,
    cedula_usuario INT NOT NULL,
    id_perfil_civica INT NOT NULL,
    PRIMARY KEY (id_civica),
    FOREIGN KEY (cedula_usuario) REFERENCES Usuarios(cedula_usuario),
    FOREIGN KEY (id_perfil_civica) REFERENCES Perfil_civica(id_perfil_civica)
);

-- Tabla Estaciones
CREATE TABLE Estaciones (
    codigo_estacion INT NOT NULL,
    nombre_estacion VARCHAR(40) NOT NULL,
    ubicacion_estacion VARCHAR(40) NOT NULL,
    estado_operacion VARCHAR(1) NOT NULL,
    PRIMARY KEY (codigo_estacion)
);

-- Tabla Tipo_lineas
CREATE TABLE Tipo_lineas (
    id_tipo_linea INT NOT NULL AUTO_INCREMENT,
    nombre_tipo_linea VARCHAR(60) NOT NULL,
    PRIMARY KEY (id_tipo_linea)
);

-- Tabla Lineas
CREATE TABLE Lineas (
    codigo_linea VARCHAR(20) NOT NULL,
    color_linea VARCHAR(20) NOT NULL,
    longitud_linea FLOAT NOT NULL,
    id_tipo_linea INT NOT NULL,
    PRIMARY KEY (codigo_linea),
    FOREIGN KEY (id_tipo_linea) REFERENCES Tipo_lineas(id_tipo_linea)
);

-- Tabla Lineas_estaciones
CREATE TABLE Lineas_estaciones (
    codigo_estacion INT NOT NULL,
    codigo_linea VARCHAR(20) NOT NULL,
    PRIMARY KEY (codigo_estacion, codigo_linea),
    FOREIGN KEY (codigo_estacion) REFERENCES Estaciones(codigo_estacion),
    FOREIGN KEY (codigo_linea) REFERENCES Lineas(codigo_linea)
);

-- Tabla Viajes
CREATE TABLE Viajes (
    id_viaje INT NOT NULL AUTO_INCREMENT,
    Tarifa_aplicada INT NOT NULL,
    hora_acceso DATETIME NOT NULL,
    id_civica INT NOT NULL,
    codigo_estacion INT NOT NULL,
    PRIMARY KEY (id_viaje),
    FOREIGN KEY (id_civica) REFERENCES Civica(id_civica),
    FOREIGN KEY (codigo_estacion) REFERENCES Estaciones(codigo_estacion)
);

-- Tabla Horarios
CREATE TABLE Horarios (
    id_horario INT NOT NULL AUTO_INCREMENT,
    inicio_operacion TIME NOT NULL,
    fin_operacion TIME NOT NULL,
    dia_operacion DATE NOT NULL,
    codigo_linea VARCHAR(20) NOT NULL,
    PRIMARY KEY (id_horario),
    FOREIGN KEY (codigo_linea) REFERENCES Lineas(codigo_linea)
);

-- Tabla Tipo_vehiculos
CREATE TABLE Tipo_vehiculos (
    id_tipo_vehiculo INT NOT NULL AUTO_INCREMENT,
    nombre_tipo_vehiculo VARCHAR(60) NOT NULL,
    capacidad INT NOT NULL,
	PRIMARY KEY (id_tipo_vehiculo)
);

-- Tabla Vehiculos
CREATE TABLE Vehiculos (
    codigo_vehiculo INT NOT NULL,
    modelo_vehiculo VARCHAR(40) NOT NULL,
    fecha_fabricacion DATE NOT NULL,
    estado_vehiculo VARCHAR(1) NOT NULL,
    id_tipo_vehiculo INT NOT NULL,
    codigo_linea VARCHAR(20) NOT NULL,
    PRIMARY KEY (codigo_vehiculo),
    FOREIGN KEY (id_tipo_vehiculo) REFERENCES Tipo_vehiculos(id_tipo_vehiculo),
    FOREIGN KEY (codigo_linea) REFERENCES Lineas(codigo_linea)
);

-- Tabla Recorridos
CREATE TABLE Recorridos (
    id_recorrido INT NOT NULL AUTO_INCREMENT,
    nombre_recorrido VARCHAR(40) NOT NULL,
    estado_recorrido VARCHAR(1) NOT NULL,
	PRIMARY KEY (id_recorrido)
);

-- Tabla Recorridos_vehiculos
CREATE TABLE Recorridos_vehiculos (
    id_recorrido INT NOT NULL,
    codigo_vehiculo INT NOT NULL,
    hora_inicio TIME NOT NULL,
    hora_llegada TIME,
    PRIMARY KEY (id_recorrido, codigo_vehiculo),
    FOREIGN KEY (id_recorrido) REFERENCES Recorridos(id_recorrido),
    FOREIGN KEY (codigo_vehiculo) REFERENCES Vehiculos(codigo_vehiculo)
);

-- Tabla Cargo_empleados
CREATE TABLE Cargo_empleados (
    id_cargo INT NOT NULL AUTO_INCREMENT,
    nombre_cargo VARCHAR(60) NOT NULL,
    salario_cargo INT NOT NULL,
    descripcion_cargo VARCHAR(100) NOT NULL,
    PRIMARY KEY (id_cargo)
);

CREATE TABLE Empleados (
    codigo_empleado INT NOT NULL,
    nombre_empleado VARCHAR(40) NOT NULL,
    apellido_empleado VARCHAR(40) NOT NULL,
    fecha_contratacion DATE NOT NULL,
    id_cargo INT NOT NULL,
    PRIMARY KEY (codigo_empleado),
    FOREIGN KEY (id_cargo) REFERENCES Cargo_empleados(id_cargo)
);

-- Tabla Empleados_estaciones
CREATE TABLE Empleados_estaciones (
    codigo_empleado INT NOT NULL,
    codigo_estacion INT NOT NULL,
    PRIMARY KEY (codigo_empleado, codigo_estacion),
    FOREIGN KEY (codigo_empleado) REFERENCES Empleados(codigo_empleado),
    FOREIGN KEY (codigo_estacion) REFERENCES Estaciones(codigo_estacion)
);

-- Tabla conductor_vehiculos
CREATE TABLE conductor_vehiculos (
    codigo_empleado INT NOT NULL,
    codigo_vehiculo INT NOT NULL,
    PRIMARY KEY (codigo_empleado, codigo_vehiculo),
    FOREIGN KEY (codigo_empleado) REFERENCES Empleados(codigo_empleado),
    FOREIGN KEY (codigo_vehiculo) REFERENCES Vehiculos(codigo_vehiculo)
);

-- Tabla Tipo_incidente
CREATE TABLE Tipo_incidente (
    id_tipo_incidente INT NOT NULL AUTO_INCREMENT,
    nombre_tipo_incidente VARCHAR(60) NOT NULL,
    PRIMARY KEY (id_tipo_incidente)
);

-- Tabla Incidentes
CREATE TABLE Incidentes (
    id_incidente INT NOT NULL AUTO_INCREMENT,
    fecha_hora_incidente DATETIME NOT NULL,
    id_tipo_incidente INT NOT NULL,
    descripcion_incidente VARCHAR(40) NOT NULL,
    codigo_estacion INT,
    codigo_linea VARCHAR(20),
    codigo_vehiculo INT,
    PRIMARY KEY (id_incidente),
    FOREIGN KEY (id_tipo_incidente) REFERENCES Tipo_incidente(id_tipo_incidente),
    FOREIGN KEY (codigo_estacion) REFERENCES Estaciones(codigo_estacion),
    FOREIGN KEY (codigo_linea) REFERENCES Lineas(codigo_linea),
    FOREIGN KEY (codigo_vehiculo) REFERENCES Vehiculos(codigo_vehiculo)
);

-- Tabla Tipo_mantenimiento
CREATE TABLE Tipo_mantenimiento (
    id_tipo_mantenimiento INT NOT NULL AUTO_INCREMENT,
    nombre_tipo_mantenimiento VARCHAR(60) NOT NULL,
    PRIMARY KEY (id_tipo_mantenimiento)
);	

-- Tabla Mantenimientos
CREATE TABLE Mantenimientos (
    id_mantenimiento INT NOT NULL AUTO_INCREMENT,
    id_tipo_mantenimiento INT NOT NULL,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE,
    descripcion_mantenimiento VARCHAR(100) NOT NULL,
    codigo_vehiculo INT,
    codigo_estacion INT,
    PRIMARY KEY (id_mantenimiento),
    FOREIGN KEY (id_tipo_mantenimiento) REFERENCES Tipo_mantenimiento(id_tipo_mantenimiento),
    FOREIGN KEY (codigo_vehiculo) REFERENCES Vehiculos(codigo_vehiculo),
    FOREIGN KEY (codigo_estacion) REFERENCES Estaciones(codigo_estacion)
);

-- Tabla Empleados_mantenimiento
CREATE TABLE Empleados_mantenimiento (
    id_mantenimiento INT NOT NULL,
    codigo_empleado INT NOT NULL,
    PRIMARY KEY (id_mantenimiento, codigo_empleado),
    FOREIGN KEY (id_mantenimiento) REFERENCES Mantenimientos(id_mantenimiento),
    FOREIGN KEY (codigo_empleado) REFERENCES Empleados(codigo_empleado)
);


-- =====================================================
-- INSERCIÓN DE LOS 10 REGISTROS A CADA TABLA
-- =====================================================

-- Inserción de datos en Usuarios
INSERT INTO Usuarios (cedula_usuario, nombre_usuario, apellido_usuario, direccion_usuario, telefono_usuario, estrato_usuario, fecha_nacimiento_usuario) VALUES
(1001234567, 'Carlos', 'Ramírez', 'Calle 50 #45-32', '3001234567', 3, '1985-03-15'),
(1002345678, 'María', 'González', 'Carrera 70 #23-11', '3012345678', 2, '1990-07-22'),
(1003456789, 'Luis', 'Martínez', 'Avenida 80 #12-45', '3023456789', 4, '1978-11-30'),
(1004567890, 'Ana', 'López', 'Calle 100 #34-67', '3034567890', 3, '1995-05-10'),
(1005678901, 'Roberto', 'Pérez', 'Calle 45 #78-90', '3045678901', 5, '1982-09-18'),
(1006789012, 'Diana', 'Torres', 'Carrera 65 #89-12', '3056789012', 2, '1992-12-25'),
(1007890123, 'Sofía', 'Mendoza', 'Carrera 43 #52-18', '3067890123', 3, '1988-04-12'),
(1008901234, 'Miguel', 'Castro', 'Calle 33 #70-25', '3078901234', 4, '1975-08-07'),
(1009012345, 'Valentina', 'Rojas', 'Avenida 34 #15-90', '3089012345', 2, '1998-01-20'),
(1010123456, 'Fernando', 'Silva', 'Calle 10 #45-33', '3090123456', 5, '1980-06-14');


select * from Usuarios;

-- Inserción de datos en Perfil_civica
INSERT INTO Perfil_civica (tipo_perfil, descuento_tarifa, descripcion) VALUES
('Estudiante', 50, 'Perfil para estudiantes universitarios con descuento del 50%'),
('Adulto Mayor', 100, 'Perfil para adultos mayores con servicio gratuito'),
('Regular', 0, 'Perfil regular sin descuentos'),
('Discapacitado', 100, 'Perfil para personas con discapacidad con servicio gratuito'),
('Empleado Metro', 70, 'Perfil para empleados del sistema Metro con descuento del 70%'),
('VIP', 30, 'Perfil VIP con descuento del 30% para usuarios frecuentes'),
('Madre Gestante', 80, 'Perfil para mujeres embarazadas con descuento del 80%'),
('Docente', 40, 'Perfil para docentes activos con descuento del 40%'),
('Pensionado', 60, 'Perfil para pensionados con descuento del 60%'),
('Deportista Elite', 50, 'Perfil para deportistas de alto rendimiento con descuento del 50%');

SELECT * FROM Perfil_civica;

-- Inserción de datos en Civica
INSERT INTO Civica (saldo, fecha_emision, estado_civica, cedula_usuario, id_perfil_civica) VALUES
(50000, '2024-01-15', 'A', 1001234567, 3),
(30000, '2024-02-20', 'E', 1002345678, 1),
(0, '2024-03-10', 'A', 1003456789, 2),
(45000, '2024-04-05', 'A', 1004567890, 3),
(75000, '2024-05-12', 'V', 1005678901, 6),
(20000, '2024-06-18', 'E', 1006789012, 1),
(60000, '2024-07-22', 'A', 1007890123, 3),
(40000, '2024-08-15', 'A', 1008901234, 8),
(25000, '2024-09-10', 'E', 1009012345, 7),
(80000, '2024-10-01', 'A', 1010123456, 6);

SELECT * FROM Civica;

-- Inserción de datos en Estaciones
INSERT INTO Estaciones (codigo_estacion, nombre_estacion, ubicacion_estacion, estado_operacion) VALUES
(1, 'Niquía', 'Norte de Medellín', 'A'),
(2, 'Bello', 'Centro de Bello', 'A'),
(3, 'Madera', 'Norte de Medellín', 'A'),
(4, 'Acevedo', 'Nororiente de Medellín', 'A'),
(5, 'Tricentenario', 'Norte de Medellín', 'A'),
(6, 'Caribe', 'Norte de Medellín', 'M'),
(7, 'Hospital', 'Centro de Medellín', 'A'),
(8, 'Prado', 'Centro de Medellín', 'A'),
(9, 'Parque Berrío', 'Centro de Medellín', 'A'),
(10, 'San Antonio', 'Centro de Medellín', 'A'),
(11, 'San Antonio B', 'Centro de Medellín', 'A'),
(12, 'Cisneros', 'Oeste Centro de Medellín', 'A');

SELECT * FROM estaciones;

-- Inserción de datos en Tipo_lineas
INSERT INTO Tipo_lineas (nombre_tipo_linea) VALUES
('Metro'),
('Metrocable'),
('Tranvía'),
('Metroplús');
-- No hay más tipos de Líneas en el sistema metro de Medellín.

SELECT * FROM Tipo_lineas;

-- Inserción de datos en Lineas
INSERT INTO Lineas (codigo_linea, color_linea, longitud_linea, id_tipo_linea) VALUES
('LA', 'Azul', 0.25, 1),
('LB', 'Naranja', 0.18, 1),
('LK', 'Verde', 0.12, 2),
('LT', 'Verdeoscuro', 0.15, 3),
('L1', 'Azulclaro', 0.1, 4),
('L2', 'Aguamarina', 0.21, 4),
('LJ', 'Amarillo', 0.15, 2),
('LH', 'Rosada', 0.07, 2),
('LM', 'Morada', 0.07, 2),
('LP', 'Roja', 0.09, 2);


SELECT * FROM Lineas;

-- Inserción de datos en Lineas_estaciones
INSERT INTO Lineas_estaciones (codigo_estacion, codigo_linea) VALUES
(1, 'LA'),
(2, 'LA'),
(3, 'LA'),
(4, 'LA'),
(5, 'LA'),
(6, 'LA'),
(7, 'LA'),
(8, 'LA'),
(9, 'LA'),
(10, 'LA'),
(11, 'LB'),
(12, 'LB');

SELECT * FROM lineas_estaciones;

-- Inserción de datos en Viajes
INSERT INTO Viajes (Tarifa_aplicada, hora_acceso, id_civica, codigo_estacion) VALUES
(2500, '2024-10-01 07:30:00', 1, 1),
(1250, '2024-10-01 08:15:00', 2, 2),
(0, '2024-10-01 09:00:00', 3, 3),
(2500, '2024-10-01 10:45:00', 4, 4),
(750, '2024-10-02 06:45:00', 5, 5),
(1250, '2024-10-02 16:30:00', 6, 6),
(2500, '2024-10-03 07:45:00', 7, 7),
(500, '2024-10-03 08:30:00', 8, 8),
(1500, '2024-10-03 12:15:00', 9, 9),
(1750, '2024-10-04 14:20:00', 10, 10);

SELECT * FROM viajes;

-- Inserción de datos en Horarios
INSERT INTO Horarios (inicio_operacion, fin_operacion, dia_operacion, codigo_linea) VALUES
('04:30:00', '23:00:00', '2024-10-05', 'LA'),
('05:00:00', '22:30:00', '2024-10-05', 'LB'),
('05:30:00', '22:00:00', '2024-10-05', 'LK'),
('06:00:00', '22:00:00', '2024-10-05', 'LT'),
('05:45:00', '21:30:00', '2024-10-05', 'L1'),
('05:45:00', '21:30:00', '2024-10-05', 'L2'),
('04:30:00', '23:00:00', '2024-10-06', 'LA'),
('05:00:00', '22:30:00', '2024-10-06', 'LB'),
('05:30:00', '22:00:00', '2024-10-06', 'LK'),
('06:00:00', '22:00:00', '2024-10-06', 'LT');


SELECT * FROM Horarios;

-- Inserción de datos en Tipo_vehiculos
INSERT INTO Tipo_vehiculos (nombre_tipo_vehiculo, capacidad) VALUES
('Tren Metro', 1200),
('Cabina Metrocable', 10),
('Tranvía', 300),
('Bus Metroplús', 160);
-- Estos son los 4 tipos de vehículos del sistema metro

SELECT * FROM Tipo_vehiculos;

-- Inserción de datos en Vehiculos
INSERT INTO Vehiculos (codigo_vehiculo, modelo_vehiculo, fecha_fabricacion, estado_vehiculo, id_tipo_vehiculo, codigo_linea) VALUES
(101, 'Alstom Metropolis', '2015-06-20', 'A', 1, 'LA'),
(102, 'Alstom Metropolis', '2016-08-15', 'A', 1, 'LA'),
(201, 'Poma', '2018-03-10', 'A', 2, 'LK'),
(301, 'CAF Urbos', '2020-11-25', 'A', 3, 'LT'),
(103, 'Alstom Metropolis', '2017-02-14', 'M', 1, 'LB'),
(401, 'Volvo B340M', '2019-07-30', 'A', 4, 'L1'),
(501, 'Volvo B340M', '2019-07-30', 'A', 4, 'L2'),
(104, 'Alstom Metropolis', '2018-05-22', 'A', 1, 'LA'),
(105, 'Alstom Metropolis', '2019-09-18', 'A', 1, 'LB'),
(202, 'Poma', '2020-01-30', 'A', 2, 'LK'),
(302, 'CAF Urbos', '2021-04-15', 'M', 3, 'LT');

SELECT * FROM Vehiculos;

-- Inserción de datos en Recorridos
INSERT INTO Recorridos (nombre_recorrido, estado_recorrido) VALUES
('Niquía - La Estrella', 'A'),
('San Antonio - San Javier', 'A'),
('Acevedo - Santo Domingo', 'A'),
('San Antonio - Oriente', 'A'),
('Circular Centro', 'A'),
('Poblado - Industriales', 'I'),
('Universidad - Hospital', 'A'),
('Envigado - Itagüí', 'A'),
('Buenos Aires - Miraflores', 'A'),
('Poblado - Aguacatala', 'I');

SELECT * FROM recorridos;

-- Inserción de datos en Recorridos_vehiculos
INSERT INTO Recorridos_vehiculos (id_recorrido, codigo_vehiculo, hora_inicio, hora_llegada) VALUES
(1, 101, '06:00:00', '07:15:00'),
(2, 102, '06:30:00', '07:45:00'),
(3, 201, '07:00:00', '07:30:00'),
(4, 301, '07:30:00', '08:15:00'),
(5, 103, '08:00:00', '09:30:00'),
(6, 401, '08:30:00', '10:00:00'),
(7, 104, '09:00:00', '10:15:00'),
(8, 105, '09:30:00', '10:45:00'),
(9, 202, '10:00:00', '10:30:00'),
(10, 302, '10:30:00', '11:15:00');

SELECT * FROM Recorridos_vehiculos;

-- Inserción de datos en Cargo_empleados
INSERT INTO Cargo_empleados (nombre_cargo, salario_Cargo, descripcion_cargo) VALUES
('Conductor Metro', 3500000, 'Operador de trenes del sistema Metro'),
('Supervisor Estación', 2800000, 'Encargado de supervisar operaciones en estación'),
('Técnico Mantenimiento', 3000000, 'Técnico especializado en mantenimiento de vehículos'),
('Agente Atención', 2200000, 'Agente de servicio al cliente en estaciones'),
('Ingeniero Sistemas', 4500000, 'Ingeniero encargado de sistemas tecnológicos'),
('Jefe Operaciones', 5500000, 'Jefe del departamento de operaciones'),
('Electricista', 3200000, 'Técnico especializado en sistemas eléctricos'),
('Coordinador Seguridad', 4000000, 'Encargado de seguridad y vigilancia del sistema'),
('Analista de Datos', 3800000, 'Analista de información operacional y estadísticas'),
('Asistente Administrativo', 2500000, 'Apoyo administrativo en oficinas centrales');

SELECT * FROM Cargo_empleados;

-- Inserción de datos en Empleados
INSERT INTO Empleados (codigo_empleado, nombre_empleado, apellido_empleado, fecha_contratacion, id_cargo) VALUES
(5001, 'Pedro', 'Sánchez', '2018-01-10', 1),
(5002, 'Laura', 'Díaz', '2019-03-15', 2),
(5003, 'Jorge', 'Hernández', '2017-06-20', 3),
(5004, 'Sandra', 'Vargas', '2020-09-01', 4),
(5005, 'Andrés', 'Moreno', '2016-11-12', 5),
(5006, 'Patricia', 'Ruiz', '2015-04-08', 6),
(5007, 'Raúl', 'Gómez', '2022-01-10', 1),
(5008, 'Camila', 'Ortiz', '2021-02-15', 7),
(5009, 'Ricardo', 'Navarro', '2019-07-22', 8),
(5010, 'Daniela', 'Cárdenas', '2020-05-18', 9),
(5011, 'Julián', 'Mejía', '2022-03-10', 10);

SELECT * FROM Empleados;

-- Inserción de datos en Empleados_estaciones
INSERT INTO Empleados_estaciones (codigo_empleado, codigo_estacion) VALUES
(5002, 1),
(5004, 2),
(5002, 3),
(5004, 4),
(5005, 5),
(5006, 1),
(5008, 7),
(5009, 8),
(5010, 9),
(5011, 10);

SELECT * FROM Empleados_estaciones;

-- Inserción de datos en conductor_vehiculos
INSERT INTO conductor_vehiculos (codigo_empleado, codigo_vehiculo) VALUES
(5001, 101),
(5001, 102),
(5001, 201),
(5001, 301),
(5007, 103),
(5007, 401),
(5001, 104),
(5007, 105),
(5001, 202),
(5007, 302);

SELECT * FROM conductor_vehiculos;

-- Inserción de datos en Tipo_incidente
INSERT INTO Tipo_incidente (nombre_tipo_incidente) VALUES
('Falla Técnica'),
('Accidente'),
('Vandalismo'),
('Emergencia Médica'),
('Retraso Operacional'),
('Falla de Comunicación'),
('Corte de Energía'),
('Obstrucción de Vías'),
('Falla en Puertas'),
('Alarma Activada');

SELECT * FROM Tipo_incidente;

-- Inserción de datos en Incidentes
INSERT INTO Incidentes (fecha_hora_incidente, id_tipo_incidente, descripcion_incidente, codigo_estacion, codigo_linea, codigo_vehiculo) VALUES
('2024-09-15 14:30:00', 1, 'Falla en sistema de frenos', 1, 'LA', 101),
('2024-09-20 10:15:00', 4, 'Usuario con desmayo en estación', 2, 'LA', NULL),
('2024-09-25 18:45:00', 3, 'Daño en torniquete de acceso', 3, NULL, NULL),
('2024-09-30 12:00:00', 1, 'Falla eléctrica en cabina', NULL, 'LK', 201),
('2024-10-01 16:20:00', 5, 'Retraso por alta demanda de pasajeros', 4, 'LA', 102),
('2024-10-02 11:35:00', 6, 'Falla en radio de comunicación', 5, 'LB', 103),
('2024-10-03 09:20:00', 7, 'Corte temporal de energía eléctrica', 7, 'LA', NULL),
('2024-10-04 15:30:00', 8, 'Objeto en vías detiene tren', NULL, 'LB', 105),
('2024-10-05 11:45:00', 9, 'Puerta de vagón no cierra correctamente', NULL, 'LK', 202),
('2024-10-06 17:10:00', 10, 'Activación de alarma de emergencia', 9, 'LA', 104);

SELECT * FROM Incidentes;

-- Inserción de datos en Tipo_mantenimiento
INSERT INTO Tipo_mantenimiento (nombre_tipo_mantenimiento) VALUES
('Preventivo'),
('Correctivo'),
('Predictivo'),
('Mejorativo'),
('Limpieza Profunda'),
('Actualización Sistemas'),
('Inspección Técnica'),
('Reemplazo de Piezas'),
('Calibración'),
('Pintura y Estética');

SELECT * FROM Tipo_mantenimiento;

-- Inserción de datos en Mantenimientos
INSERT INTO Mantenimientos (id_tipo_mantenimiento, fecha_inicio, fecha_fin, descripcion_mantenimiento, codigo_vehiculo, codigo_estacion) VALUES
(1, '2024-10-01', '2024-10-02', 'Revisión general de sistemas de seguridad', 101, NULL),
(2, '2024-10-03', '2024-10-04', 'Reparación de sistema de frenos', 102, NULL),
(1, '2024-10-05', '2024-10-05', 'Mantenimiento de escaleras eléctricas', NULL, 1),
(3, '2024-10-06', '2024-10-07', 'Análisis predictivo de cables', 201, NULL),
(5, '2024-10-08', '2024-10-08', 'Limpieza y desinfección profunda de vagones', 103, NULL),
(6, '2024-10-09', '2024-10-10', 'Actualización de software de control', NULL, 4),
(7, '2024-10-11', '2024-10-11', 'Inspección técnica completa de sistemas', 104, NULL),
(8, '2024-10-12', '2024-10-13', 'Reemplazo de pastillas de freno', 105, NULL),
(9, '2024-10-14', '2024-10-14', 'Calibración de sistemas de señalización', NULL, 7),
(10, '2024-10-15', '2024-10-16', 'Renovación de pintura exterior de vagones', 202, NULL);


SELECT * FROM Mantenimientos;

-- Inserción de datos en Empleados_mantenimiento
INSERT INTO Empleados_mantenimiento (id_mantenimiento, codigo_empleado) VALUES
(1, 5003),
(2, 5003),
(3, 5003),
(4, 5003),
(5, 5003),
(6, 5005),
(7, 5003),
(8, 5003),
(9, 5008),
(10, 5003);

SELECT * FROM Empleados_mantenimiento; 

-- =====================================================
-- 2 ACTUALIZACIONES DE CADA TABLA
-- =====================================================

-- =====================================================
-- ACTUALIZACIONES TABLA USUARIO
-- =====================================================

-- 1. Actualizar teléfono de un usuario
UPDATE Usuarios 
SET telefono_usuario = '3111234567' 
WHERE cedula_usuario = 1001234567;

-- 2. Actualizar dirección y estrato (impacta relación con Civica vía FK)
UPDATE Usuarios 
SET direccion_usuario = 'Carrera 80 #50-25', estrato_usuario = 4 
WHERE cedula_usuario = 1002345678;

SELECT * FROM Usuarios;

-- =====================================================
-- ACTUALIZACIONES TABLA PERFIL_CIVICA
-- =====================================================

-- 1. Ajustar descuento de tarifa para estudiantes
UPDATE Perfil_civica 
SET descuento_tarifa = 60 
WHERE tipo_perfil = 'Estudiante';

-- 2. Actualizar descripción del perfil VIP (relacionado con Civica vía FK)
UPDATE Perfil_civica 
SET descripcion = 'Perfil VIP con descuento del 30% y acceso prioritario para usuarios frecuentes' 
WHERE id_perfil_civica = 6;

SELECT * FROM Perfil_civica;

-- =====================================================
-- ACTUALIZACIONES TABLA CÍVICA
-- =====================================================

-- 1. Recargar saldo en tarjeta cívica
UPDATE Civica 
SET saldo = saldo + 50000 
WHERE id_civica = 2;

-- 2. Cambiar estado de cívica y perfil (involucra FK con cedula_usuario y id_perfil_civica)
UPDATE Civica 
SET estado_civica = 'A', id_perfil_civica = 3 
WHERE id_civica = 2 AND cedula_usuario = 1002345678;

SELECT * FROM Civica;

-- =====================================================
-- ACTUALIZACIONES TABLA ESTACIONES
-- =====================================================

-- 1. Cambiar estado de operación de estación a mantenimiento
UPDATE Estaciones 
SET estado_operacion = 'M' 
WHERE codigo_estacion = 6;

-- 2. Actualizar ubicación de estación (afecta relación con Lineas_estaciones vía FK)
UPDATE Estaciones 
SET ubicacion_estacion = 'Noroccidente de Medellín', estado_operacion = 'A' 
WHERE codigo_estacion = 1;

SELECT * FROM Estaciones;

-- =====================================================
-- ACTUALIZACIONES TABLA TIPO_LINEAS
-- ====================================================

-- 1. Actualizar nombre del tipo de línea
UPDATE Tipo_lineas 
SET nombre_tipo_linea = 'Metro Pesado' 
WHERE id_tipo_linea = 1;

-- 2. Actualizar nombre de Metrocable (afecta relación con Lineas vía FK)
UPDATE Tipo_lineas 
SET nombre_tipo_linea = 'Metrocable Aéreo' 
WHERE id_tipo_linea = 2;

SELECT * FROM Tipo_lineas;

-- =====================================================
-- ACTUALIZACIONES TABLA LINEAS
-- =====================================================

-- 1. Actualizar longitud de una línea
UPDATE Lineas 
SET longitud_linea = 0.28 
WHERE codigo_linea = 'LA';

-- 2. Cambiar tipo de línea (involucra FK con id_tipo_linea)
UPDATE Lineas 
SET id_tipo_linea = 1, color_linea = 'Naranja' 
WHERE codigo_linea = 'LB';

SELECT * FROM Lineas;

-- =====================================================
-- ACTUALIZACIONES TABLA LINEAS_ESTACIONES
-- =====================================================

-- 1. Agregar nueva conexión estación-línea (involucra FK con codigo_estacion y codigo_linea)
UPDATE Lineas_estaciones 
SET codigo_linea = 'LB' 
WHERE codigo_estacion = 2 AND codigo_linea = 'LA';

-- 2. Actualizar asignación de estación a línea diferente (involucra ambas FK)
UPDATE Lineas_estaciones 
SET codigo_linea = 'LK' 
WHERE codigo_estacion = 3 AND codigo_linea = 'LA';

SELECT * FROM Lineas_estaciones;

-- =====================================================
-- ACTUALIZACIONES TABLA VIAJES
-- =====================================================

-- 1. Ajustar tarifa aplicada por corrección
UPDATE Viajes 
SET Tarifa_aplicada = 2000 
WHERE id_viaje = 1;

-- 2. Actualizar estación de acceso (involucra FK con codigo_estacion y id_civica)
UPDATE Viajes 
SET codigo_estacion = 2, Tarifa_aplicada = 1250 
WHERE id_viaje = 3 AND id_civica = 3;

SELECT * FROM Viajes;

-- =====================================================
-- ACTUALIZACIONES TABLA HORARIOS
-- =====================================================

-- 1. Extender horario de operación
UPDATE Horarios 
SET fin_operacion = '23:30:00' 
WHERE id_horario = 1;

-- 2. Modificar horarios de línea específica (involucra FK con codigo_linea)
UPDATE Horarios 
SET inicio_operacion = '04:45:00', fin_operacion = '23:15:00' 
WHERE codigo_linea = 'LA' AND dia_operacion = '2024-10-05';

SELECT * FROM Horarios;

-- =====================================================
-- ACTUALIZACIONES TABLA TIPO_VEHICULOS
-- =====================================================

-- 1. Actualizar capacidad de tipo de vehículo
UPDATE Tipo_vehiculos 
SET capacidad = 1250 
WHERE id_tipo_vehiculo = 1;

-- 2. Cambiar nombre del tipo (afecta relación con Vehiculos vía FK)
UPDATE Tipo_vehiculos 
SET nombre_tipo_vehiculo = 'Tren Metro Pesado' 
WHERE id_tipo_vehiculo = 1;

SELECT * FROM Tipo_vehiculos;

-- =====================================================
-- ACTUALIZACIONES TABLA VEHICULOS
-- =====================================================

-- 1. Cambiar estado del vehículo a mantenimiento
UPDATE Vehiculos 
SET estado_vehiculo = 'M' 
WHERE codigo_vehiculo = 101;

-- 2. Reasignar vehículo a otra línea (involucra FK con codigo_linea)
UPDATE Vehiculos 
SET codigo_linea = 'LA', estado_vehiculo = 'A' 
WHERE codigo_vehiculo = 103;

SELECT * FROM Vehiculos;

-- =====================================================
-- ACTUALIZACIONES TABLA RECORRIDOS
-- =====================================================

-- 1. Activar recorrido inactivo
UPDATE Recorridos 
SET estado_recorrido = 'A' 
WHERE id_recorrido = 6;

-- 2. Actualizar nombre y estado del recorrido (afecta Recorridos_vehiculos vía FK)
UPDATE Recorridos 
SET nombre_recorrido = 'Niquía - Poblado', estado_recorrido = 'A' 
WHERE id_recorrido = 1;

SELECT * FROM Recorridos;

-- =====================================================
-- ACTUALIZACIONES TABLA RECORRIDOS_VEHICULOS
-- =====================================================

-- 1. Actualizar hora de llegada real
UPDATE Recorridos_vehiculos 
SET hora_llegada = '07:20:00' 
WHERE id_recorrido = 1 AND codigo_vehiculo = 101;

-- 2. Cambiar vehículo asignado al recorrido (involucra FK con codigo_vehiculo)
UPDATE Recorridos_vehiculos 
SET codigo_vehiculo = 104, hora_inicio = '06:15:00' 
WHERE id_recorrido = 1 AND codigo_vehiculo = 101;

SELECT * FROM Recorridos_vehiculos;

-- =====================================================
-- ACTUALIZACIONES TABLA CARGO_EMPLEADOS
-- =====================================================

-- 1. Ajustar salario por incremento anual
UPDATE Cargo_empleados 
SET salario_cargo = 3850000 
WHERE id_cargo = 1;

-- 2. Actualizar descripción del cargo (afecta Empleados vía FK)
UPDATE Cargo_empleados 
SET descripcion_cargo = 'Operador certificado de trenes del sistema Metro con licencia tipo A' 
WHERE id_cargo = 1;

SELECT * FROM Cargo_empleados;

-- =====================================================
-- ACTUALIZACIONES TABLA EMPLEADOS
-- =====================================================

-- 1. Actualizar apellido de empleado
UPDATE Empleados 
SET apellido_empleado = 'Sánchez Morales' 
WHERE codigo_empleado = 5001;

-- 2. Promoción de cargo (involucra FK con id_cargo)
UPDATE Empleados 
SET id_cargo = 6, fecha_contratacion = '2015-04-08' 
WHERE codigo_empleado = 5002;

SELECT * FROM Empleados;

-- =====================================================
-- ACTUALIZACIONES TABLA EMPLEADOS_ESTACIONES
-- =====================================================

-- 1. Reasignar empleado a otra estación (involucra FK codigo_estacion)
UPDATE Empleados_estaciones 
SET codigo_estacion = 7 
WHERE codigo_empleado = 5002 AND codigo_estacion = 1;

-- 2. Actualizar asignación de empleado (involucra ambas FK)
UPDATE Empleados_estaciones 
SET codigo_estacion = 8, codigo_empleado = 5004 
WHERE codigo_empleado = 5004 AND codigo_estacion = 2;

SELECT * FROM Empleados_estaciones;

-- =====================================================
-- ACTUALIZACIONES TABLA CONDUCTOR_VEHICULOS
-- =====================================================

-- 1. Reasignar conductor a otro vehículo (involucra FK codigo_vehiculo)
UPDATE conductor_vehiculos 
SET codigo_vehiculo = 105 
WHERE codigo_empleado = 5001 AND codigo_vehiculo = 101;

-- 2. Cambiar asignación completa (involucra ambas FK)
UPDATE conductor_vehiculos 
SET codigo_vehiculo = 104, codigo_empleado = 5007 
WHERE codigo_empleado = 5007 AND codigo_vehiculo = 103;

SELECT * FROM conductor_vehiculos;

-- =====================================================
-- ACTUALIZACIONES TABLA TIPO_INCIDENTE
-- =====================================================

-- 1. Actualizar nombre del tipo de incidente
UPDATE Tipo_incidente 
SET nombre_tipo_incidente = 'Falla Técnica Mecánica' 
WHERE id_tipo_incidente = 1;

-- 2. Mejorar nomenclatura (afecta Incidentes vía FK)
UPDATE Tipo_incidente 
SET nombre_tipo_incidente = 'Emergencia Médica Pasajeros' 
WHERE id_tipo_incidente = 4;

SELECT * FROM Tipo_incidente;

-- =====================================================
-- ACTUALIZACIONES TABLA INCIDENTES
-- =====================================================

-- 1. Actualizar descripción del incidente
UPDATE Incidentes 
SET descripcion_incidente = 'Falla crítica en sistema de frenos' 
WHERE id_incidente = 1;

-- 2. Cambiar estación asociada al incidente (involucra FK codigo_estacion)
UPDATE Incidentes 
SET codigo_estacion = 3, descripcion_incidente = 'Usuario con desmayo reportado' 
WHERE id_incidente = 2;

SELECT * FROM Incidentes;

-- =====================================================
-- ACTUALIZACIONES TABLA TIPO_MANTENIMIENTO
-- =====================================================

-- 1. Actualizar nombre del tipo
UPDATE Tipo_mantenimiento 
SET nombre_tipo_mantenimiento = 'Mantenimiento Preventivo' 
WHERE id_tipo_mantenimiento = 1;

-- 2. Estandarizar nomenclatura (afecta Mantenimientos vía FK)
UPDATE Tipo_mantenimiento 
SET nombre_tipo_mantenimiento = 'Mantenimiento Correctivo' 
WHERE id_tipo_mantenimiento = 2;

SELECT * FROM Tipo_mantenimiento;

-- =====================================================
-- ACTUALIZACIONES TABLA MANTENIMIENTOS
-- =====================================================

-- 1. Registrar fecha de finalización de mantenimiento
UPDATE Mantenimientos 
SET fecha_fin = '2024-10-02' 
WHERE id_mantenimiento = 1;

-- 2. Cambiar vehículo en mantenimiento (involucra FK codigo_vehiculo)
UPDATE Mantenimientos 
SET codigo_vehiculo = 105, descripcion_mantenimiento = 'Reparación de sistema de frenos delanteros' 
WHERE id_mantenimiento = 2;

SELECT * FROM Mantenimientos;

-- =====================================================
-- ACTUALIZACIONES TABLA EMPLEADOS_MANTENIMIENTO
-- =====================================================

-- 1. Reasignar empleado a otro mantenimiento (involucra FK id_mantenimiento)
UPDATE Empleados_mantenimiento 
SET id_mantenimiento = 2 
WHERE id_mantenimiento = 6 AND codigo_empleado = 5005;

-- 2. Cambiar empleado asignado (involucra ambas FK)
UPDATE Empleados_mantenimiento 
SET codigo_empleado = 5008, id_mantenimiento = 3 
WHERE id_mantenimiento = 3 AND codigo_empleado = 5003;

SELECT * FROM Empleados_mantenimiento;



-- =====================================================
-- EJECUTAR 10 CONSULTAS A LA DB
-- =====================================================


-- =====================================================
-- CONSULTA a.): Clausula ORDER BY
-- =====================================================
-- Listar todos los usuarios ordenados por fecha de nacimiento (más jóvenes primero)
SELECT cedula_usuario, nombre_usuario, apellido_usuario, fecha_nacimiento_usuario, estrato_usuario
FROM Usuarios
ORDER BY fecha_nacimiento_usuario DESC;

-- =====================================================
-- CONSULTA b.): Múltiples condiciones
-- =====================================================
-- Buscar usuarios de estrato 3 o 4 que hayan nacido después de 1985
SELECT cedula_usuario, nombre_usuario, apellido_usuario, estrato_usuario, fecha_nacimiento_usuario
FROM Usuarios
WHERE (estrato_usuario = 3 OR estrato_usuario = 4) 
  AND fecha_nacimiento_usuario > '1985-01-01';

-- =====================================================
-- CONSULTA c.): Clausula IN
-- =====================================================
-- Listar vehículos que estén asignados a las líneas LA, LB o LK
SELECT codigo_vehiculo, modelo_vehiculo, estado_vehiculo, codigo_linea
FROM Vehiculos
WHERE codigo_linea IN ('LA', 'LB', 'LK');

-- =====================================================
-- CONSULTA d.): Clausula LIKE/NOT LIKE
-- =====================================================
-- Buscar empleados cuyo nombre empiece con 'P' y apellido no contenga 'ez'
SELECT codigo_empleado, nombre_empleado, apellido_empleado, fecha_contratacion
FROM Empleados
WHERE nombre_empleado LIKE 'P%' 
  AND apellido_empleado NOT LIKE '%ez%';

-- =====================================================
-- CONSULTA e.): JOIN
-- =====================================================
-- Mostrar información de viajes con datos del usuario y la estación
SELECT 
    v.id_viaje,
    v.Tarifa_aplicada,
    v.hora_acceso,
    u.nombre_usuario,
    u.apellido_usuario,
    e.nombre_estacion,
    e.ubicacion_estacion
FROM Viajes v
INNER JOIN Civica c ON v.id_civica = c.id_civica
INNER JOIN Usuarios u ON c.cedula_usuario = u.cedula_usuario
INNER JOIN Estaciones e ON v.codigo_estacion = e.codigo_estacion;

-- =====================================================
-- CONSULTA f.): Clausula COUNT()
-- =====================================================
-- Contar cuántos vehículos hay por cada tipo de vehículo
SELECT 
    tv.nombre_tipo_vehiculo,
    COUNT(v.codigo_vehiculo) AS cantidad_vehiculos
FROM Tipo_vehiculos tv
LEFT JOIN Vehiculos v ON tv.id_tipo_vehiculo = v.id_tipo_vehiculo
GROUP BY tv.id_tipo_vehiculo, tv.nombre_tipo_vehiculo;

-- =====================================================
-- CONSULTA g.): Clausula GROUP BY
-- =====================================================
-- Calcular el saldo total y promedio de tarjetas cívicas por perfil
SELECT 
    pc.tipo_perfil,
    pc.descuento_tarifa,
    SUM(c.saldo) AS saldo_total,
    AVG(c.saldo) AS saldo_promedio,
    COUNT(c.id_civica) AS cantidad_tarjetas
FROM Perfil_civica pc
LEFT JOIN Civica c ON pc.id_perfil_civica = c.id_perfil_civica
GROUP BY pc.id_perfil_civica, pc.tipo_perfil, pc.descuento_tarifa
ORDER BY saldo_total DESC;

-- =====================================================
-- CONSULTA h.): Clausula GROUP BY HAVING
-- =====================================================
-- Listar líneas que tienen más de 2 estaciones asignadas
SELECT 
    l.codigo_linea,
    l.color_linea,
    tl.nombre_tipo_linea,
    COUNT(le.codigo_estacion) AS cantidad_estaciones
FROM Lineas l
INNER JOIN Tipo_lineas tl ON l.id_tipo_linea = tl.id_tipo_linea
LEFT JOIN Lineas_estaciones le ON l.codigo_linea = le.codigo_linea
GROUP BY l.codigo_linea, l.color_linea, tl.nombre_tipo_linea
HAVING COUNT(le.codigo_estacion) > 2
ORDER BY cantidad_estaciones DESC;

-- =====================================================
-- CONSULTA i.): Consulta anidada 
-- =====================================================
-- Listar empleados que ganan más que el salario promedio de todos los cargos
SELECT 
    e.codigo_empleado,
    e.nombre_empleado,
    e.apellido_empleado,
    ce.nombre_cargo,
    ce.salario_cargo
FROM Empleados e
INNER JOIN Cargo_empleados ce ON e.id_cargo = ce.id_cargo
WHERE ce.salario_cargo > (
    SELECT AVG(salario_cargo) 
    FROM Cargo_empleados
)
ORDER BY ce.salario_cargo DESC;

-- =====================================================
-- CONSULTA j.): Consulta compleja combinando múltiples elementos
-- (ORDER BY, JOIN, GROUP BY, HAVING, múltiples condiciones)
-- =====================================================
-- Reportar cantidad de incidentes por tipo en octubre 2024,
-- mostrando los tipos con 1 o más incidentes
SELECT 
    ti.nombre_tipo_incidente,
    COUNT(i.id_incidente) AS cantidad_incidentes,
    MIN(i.fecha_hora_incidente) AS primer_incidente,
    MAX(i.fecha_hora_incidente) AS ultimo_incidente
FROM Tipo_incidente ti
INNER JOIN Incidentes i ON ti.id_tipo_incidente = i.id_tipo_incidente
WHERE i.fecha_hora_incidente >= '2024-10-01' 
  AND i.fecha_hora_incidente < '2024-11-01'
GROUP BY ti.id_tipo_incidente, ti.nombre_tipo_incidente
HAVING COUNT(i.id_incidente) >= 1
ORDER BY cantidad_incidentes DESC;



-- =====================================================
-- PROCEDIMIENTOS ALMACENADOS
-- =====================================================

-- =====================================================
-- PROCEDIMIENTO 1: INSERCIÓN
-- Insertar un nuevo usuario en el sistema
-- =====================================================

DELIMITER $$
CREATE PROCEDURE insertar_usuario(
    IN p_cedula INT,
    IN p_nombre VARCHAR(40),
    IN p_apellido VARCHAR(40),
    IN p_direccion VARCHAR(40),
    IN p_telefono VARCHAR(10),
    IN p_estrato INT,
    IN p_fecha_nacimiento DATE
)
BEGIN
    INSERT INTO Usuarios (cedula_usuario, nombre_usuario, apellido_usuario, 
                         direccion_usuario, telefono_usuario, estrato_usuario, 
                         fecha_nacimiento_usuario)
    VALUES (p_cedula, p_nombre, p_apellido, p_direccion, p_telefono, 
            p_estrato, p_fecha_nacimiento);
    
    SELECT 'Usuario insertado exitosamente' AS mensaje;
END $$
DELIMITER ;

-- Llamado del procedimiento 1:
CALL insertar_usuario(1011234567, 'Andrea', 'Gómez', 'Calle 55 #20-30', 
'3101234567', 3, '1993-08-15');

-- =====================================================
-- PROCEDIMIENTO 2: ACTUALIZACIÓN
-- Actualizar el saldo de una tarjeta cívica
-- =====================================================

DELIMITER $$
CREATE PROCEDURE recargar_civica(
    IN p_id_civica INT,
    IN p_monto_recarga INT
)
BEGIN
    UPDATE Civica 
    SET saldo = saldo + p_monto_recarga
    WHERE id_civica = p_id_civica;
    
    SELECT CONCAT('Recarga exitosa. Nuevo saldo: ', saldo) AS mensaje
    FROM Civica
    WHERE id_civica = p_id_civica;
END $$
DELIMITER ;

-- Llamado del procedimiento 2:
CALL recargar_civica(1, 30000);

-- =====================================================
-- PROCEDIMIENTO 3: BORRADO
-- Eliminar un incidente del sistema
-- =====================================================

DELIMITER $$
CREATE PROCEDURE eliminar_incidente(
    IN p_id_incidente INT
)
BEGIN
    DECLARE v_existe INT;
    
    SELECT COUNT(*) INTO v_existe
    FROM Incidentes
    WHERE id_incidente = p_id_incidente;
    
    IF v_existe > 0 THEN
        DELETE FROM Incidentes
        WHERE id_incidente = p_id_incidente;
        
        SELECT 'Incidente eliminado exitosamente' AS mensaje;
    ELSE
        SELECT 'El incidente no existe' AS mensaje;
    END IF;
END $$
DELIMITER ;

-- Llamado del procedimiento 3:
CALL eliminar_incidente(6);

-- =====================================================
-- PROCEDIMIENTO 4: CONSULTA CON PARÁMETROS IN
-- Consultar viajes de un usuario específico por su cédula
-- =====================================================

DELIMITER $$
CREATE PROCEDURE consultar_viajes_usuario(
    IN p_cedula_usuario INT
)
BEGIN
    SELECT 
        v.id_viaje,
        v.Tarifa_aplicada,
        v.hora_acceso,
        e.nombre_estacion,
        e.ubicacion_estacion,
        c.saldo AS saldo_actual
    FROM Viajes v
    INNER JOIN Civica c ON v.id_civica = c.id_civica
    INNER JOIN Usuarios u ON c.cedula_usuario = u.cedula_usuario
    INNER JOIN Estaciones e ON v.codigo_estacion = e.codigo_estacion
    WHERE u.cedula_usuario = p_cedula_usuario
    ORDER BY v.hora_acceso DESC;
END $$
DELIMITER ;

-- Llamado del procedimiento 4:
CALL consultar_viajes_usuario(1001234567);

-- =====================================================
-- PROCEDIMIENTO 5: CONSULTA CON PARÁMETROS IN Y OUT
-- Consultar información de una línea y retornar cantidad de estaciones
-- =====================================================

DELIMITER $$
CREATE PROCEDURE info_linea_estaciones(
    IN p_codigo_linea VARCHAR(20),
    OUT p_cantidad_estaciones INT,
    OUT p_nombre_tipo_linea VARCHAR(60),
    OUT p_codigo_linea_out VARCHAR(20)
)
BEGIN
    -- Obtener cantidad de estaciones
    SELECT COUNT(le.codigo_estacion)
    INTO p_cantidad_estaciones
    FROM Lineas_estaciones le
    WHERE le.codigo_linea = p_codigo_linea;
    
    -- Obtener tipo de línea y código
    SELECT tl.nombre_tipo_linea, l.codigo_linea
    INTO p_nombre_tipo_linea, p_codigo_linea_out
    FROM Lineas l
    INNER JOIN Tipo_lineas tl ON l.id_tipo_linea = tl.id_tipo_linea
    WHERE l.codigo_linea = p_codigo_linea;
    
    -- Mostrar información detallada de la línea
    SELECT 
        l.codigo_linea,
        l.color_linea,
        l.longitud_linea,
        tl.nombre_tipo_linea
    FROM Lineas l
    INNER JOIN Tipo_lineas tl ON l.id_tipo_linea = tl.id_tipo_linea
    WHERE l.codigo_linea = p_codigo_linea;
END $$
DELIMITER ;

-- Llamado del procedimiento 5:
CALL info_linea_estaciones('LA', @cantidad, @tipo, @codigo);
SELECT @codigo AS codigo_linea, @cantidad AS cantidad_estaciones, @tipo AS tipo_linea;

-- =====================================================
-- PROCEDIMIENTO 6: CONSULTA CON PARÁMETROS IN Y OUT
-- Registrar un viaje y retornar el nuevo saldo
-- =====================================================
DELIMITER $$
CREATE PROCEDURE registrar_viaje(
    IN p_id_civica INT,
    IN p_codigo_estacion INT,
    IN p_tarifa INT,
    OUT p_saldo_anterior INT,
    OUT p_saldo_nuevo INT,
    OUT p_mensaje VARCHAR(100)
)
BEGIN
    DECLARE v_saldo_actual INT;
    
    -- Obtener saldo actual
    SELECT saldo INTO v_saldo_actual
    FROM Civica
    WHERE id_civica = p_id_civica;
    
    SET p_saldo_anterior = v_saldo_actual;
    
    -- Verificar si hay saldo suficiente
    IF v_saldo_actual >= p_tarifa THEN
        -- Registrar el viaje
        INSERT INTO Viajes (Tarifa_aplicada, hora_acceso, id_civica, codigo_estacion)
        VALUES (p_tarifa, NOW(), p_id_civica, p_codigo_estacion);
        
        -- Descontar tarifa del saldo
        UPDATE Civica
        SET saldo = saldo - p_tarifa
        WHERE id_civica = p_id_civica;
        
        -- Obtener nuevo saldo
        SELECT saldo INTO p_saldo_nuevo
        FROM Civica
        WHERE id_civica = p_id_civica;
        
        SET p_mensaje = 'Viaje registrado exitosamente';
    ELSE
        SET p_saldo_nuevo = v_saldo_actual;
        SET p_mensaje = 'Saldo insuficiente para realizar el viaje';
    END IF;
END $$
DELIMITER ;

-- Llamado del procedimiento 6:
CALL registrar_viaje(1, 1, 2500, @saldo_ant, @saldo_new, @msg);
SELECT @saldo_ant AS saldo_anterior, @saldo_new AS saldo_nuevo, @msg AS mensaje;



-- =====================================================
-- TRIGGERS DE LA DB
-- =====================================================

-- =====================================================
-- TRIGGER 1: INSERCIÓN - AFTER INSERT
-- Descontar la tarifa del saldo de la cívica cuando se registra un viaje
-- =====================================================
DELIMITER $$
CREATE TRIGGER after_insert_viaje_descontar_saldo
AFTER INSERT ON Viajes
FOR EACH ROW
BEGIN
    UPDATE Civica
    SET saldo = saldo - NEW.Tarifa_aplicada
    WHERE id_civica = NEW.id_civica;
END $$
DELIMITER ;

-- Prueba del trigger 1:
-- Verificar saldo actual
SELECT id_civica, saldo FROM Civica WHERE id_civica = 4;

-- Insertar un viaje (automáticamente descontará del saldo)
INSERT INTO Viajes (Tarifa_aplicada, hora_acceso, id_civica, codigo_estacion)
VALUES (2500, NOW(), 4, 3);

-- Verificar nuevo saldo
SELECT id_civica, saldo FROM Civica WHERE id_civica = 4;

-- =====================================================
-- TRIGGER 2: ACTUALIZACIÓN - AFTER UPDATE
-- Cuando un vehículo pasa a estado de mantenimiento (M),
-- cambiar el estado de sus recorridos a inactivo (I)
-- =====================================================
DELIMITER $$
CREATE TRIGGER after_update_vehiculo_actualizar_recorrido
AFTER UPDATE ON Vehiculos
FOR EACH ROW
BEGIN
    IF NEW.estado_vehiculo = 'M' AND OLD.estado_vehiculo != 'M' THEN
        UPDATE Recorridos r
        INNER JOIN Recorridos_vehiculos rv ON r.id_recorrido = rv.id_recorrido
        SET r.estado_recorrido = 'I'
        WHERE rv.codigo_vehiculo = NEW.codigo_vehiculo;
    END IF;
    
    IF NEW.estado_vehiculo = 'A' AND OLD.estado_vehiculo = 'M' THEN
        UPDATE Recorridos r
        INNER JOIN Recorridos_vehiculos rv ON r.id_recorrido = rv.id_recorrido
        SET r.estado_recorrido = 'A'
        WHERE rv.codigo_vehiculo = NEW.codigo_vehiculo;
    END IF;
END $$
DELIMITER ;

-- Prueba del trigger 2:
-- Verificar estado actual del recorrido
SELECT r.id_recorrido, r.nombre_recorrido, r.estado_recorrido, rv.codigo_vehiculo
FROM Recorridos r
INNER JOIN Recorridos_vehiculos rv ON r.id_recorrido = rv.id_recorrido
WHERE rv.codigo_vehiculo = 102;

-- Cambiar vehículo a mantenimiento
UPDATE Vehiculos SET estado_vehiculo = 'M' WHERE codigo_vehiculo = 102;

-- Verificar que el recorrido cambió a inactivo
SELECT r.id_recorrido, r.nombre_recorrido, r.estado_recorrido, rv.codigo_vehiculo
FROM Recorridos r
INNER JOIN Recorridos_vehiculos rv ON r.id_recorrido = rv.id_recorrido
WHERE rv.codigo_vehiculo = 102;

-- Reactivar vehículo
UPDATE Vehiculos SET estado_vehiculo = 'A' WHERE codigo_vehiculo = 102;

-- =====================================================
-- TRIGGER 3: BORRADO
-- Validar que no se eliminen perfiles de cívica que estén en uso
-- =====================================================
DELIMITER $$
CREATE TRIGGER before_delete_perfil_civica
BEFORE DELETE ON Perfil_civica
FOR EACH ROW
BEGIN
    DECLARE v_cantidad_civicas INT;
    
    SELECT COUNT(*) INTO v_cantidad_civicas
    FROM Civica
    WHERE id_perfil_civica = OLD.id_perfil_civica;
    
    IF v_cantidad_civicas > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: No se puede eliminar un perfil que tiene tarjetas cívicas asociadas';
    END IF;
END $$
DELIMITER ;


-- Prueba del trigger 3 (esto debería dar error porque el perfil 3 tiene cívicas):
-- DELETE FROM Perfil_civica WHERE id_perfil_civica = 3;

-- Insertar un perfil sin uso para probar el borrado exitoso:
INSERT INTO Perfil_civica (tipo_perfil, descuento_tarifa, descripcion)
VALUES ('Prueba Temporal', 0, 'Perfil de prueba para trigger');

-- Este borrado debería funcionar (obtener el id insertado primero):
SET @ultimo_id = LAST_INSERT_ID();
DELETE FROM Perfil_civica WHERE id_perfil_civica = @ultimo_id;

-- =====================================================
-- TRIGGER 4: ACTUALIZACIÓN - BEFORE (EJECUCIÓN ANTES DE LA ACCIÓN)
-- Validar que el estrato del usuario esté entre 1 y 6
-- Validar el número de dígitos del teléfono.
-- =====================================================

DELIMITER $$
CREATE TRIGGER validar_estrato_telefono
BEFORE UPDATE ON Usuarios
FOR EACH ROW
BEGIN
    IF NEW.estrato_usuario < 1 OR NEW.estrato_usuario > 6 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: El estrato debe estar entre 1 y 6';
    END IF;
    
    IF LENGTH(NEW.telefono_usuario) != 10 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: El teléfono debe tener exactamente 10 dígitos';
    END IF;
END $$
DELIMITER ;

-- Prueba del trigger 4 (esto debería dar error):
-- UPDATE Usuarios SET estrato_usuario = 7 WHERE cedula_usuario = 1001234567;
-- UPDATE Usuarios SET telefono_usuario = '123' WHERE cedula_usuario = 1001234567;

-- Prueba correcta del trigger 4:
UPDATE Usuarios SET estrato_usuario = 4 WHERE cedula_usuario = 1001234567;


-- =====================================================
-- TRIGGER 5: AFTER (Se ejecuta DESPUÉS de la acción)
-- Cuando se inserta un nuevo incidente en una estación o línea,
-- cambiar automáticamente su estado de operación a 'M' (Mantenimiento)
-- si el tipo de incidente es crítico (Falla Técnica o Accidente)
-- =====================================================
DELIMITER $$
CREATE TRIGGER after_insert_incidente_cambiar_estado_estaciones_lineas
AFTER INSERT ON Incidentes
FOR EACH ROW
BEGIN
    -- Si el incidente es de tipo Falla Técnica (1) o Accidente (2)
    IF NEW.id_tipo_incidente IN (1, 2) THEN
        
        -- Si el incidente afecta una estación, cambiarla a mantenimiento
        IF NEW.codigo_estacion IS NOT NULL THEN
            UPDATE Estaciones
            SET estado_operacion = 'M'
            WHERE codigo_estacion = NEW.codigo_estacion;
        END IF;
        
        -- Si el incidente afecta un vehículo, cambiarlo a mantenimiento
        IF NEW.codigo_vehiculo IS NOT NULL THEN
            UPDATE Vehiculos
            SET estado_vehiculo = 'M'
            WHERE codigo_vehiculo = NEW.codigo_vehiculo;
        END IF;
        
    END IF;
END $$
DELIMITER ;

-- Prueba del trigger 5:
-- Ver estado actual de la estación 4
SELECT codigo_estacion, nombre_estacion, estado_operacion 
FROM Estaciones 
WHERE codigo_estacion = 4;

-- Ver estado actual del vehículo 201
SELECT codigo_vehiculo, modelo_vehiculo, estado_vehiculo 
FROM Vehiculos 
WHERE codigo_vehiculo = 201;

-- Insertar un incidente crítico (Falla Técnica) en la estación 4
INSERT INTO Incidentes (fecha_hora_incidente, id_tipo_incidente, descripcion_incidente, 
                        codigo_estacion, codigo_linea, codigo_vehiculo)
VALUES (NOW(), 1, 'Falla crítica en sistema eléctrico', 4, 'LA', NULL);

-- Verificar que la estación cambió a mantenimiento
SELECT codigo_estacion, nombre_estacion, estado_operacion 
FROM Estaciones 
WHERE codigo_estacion = 4;

-- Insertar un incidente de accidente en un vehículo
INSERT INTO Incidentes (fecha_hora_incidente, id_tipo_incidente, descripcion_incidente, 
                        codigo_estacion, codigo_linea, codigo_vehiculo)
VALUES (NOW(), 2, 'Colisión menor durante maniobra', NULL, 'LK', 201);

-- Verificar que el vehículo cambió a mantenimiento
SELECT codigo_vehiculo, modelo_vehiculo, estado_vehiculo 
FROM Vehiculos 
WHERE codigo_vehiculo = 201;

-- Restaurar estados (si es necesario)
UPDATE Estaciones SET estado_operacion = 'A' WHERE codigo_estacion = 4;
UPDATE Vehiculos SET estado_vehiculo = 'A' WHERE codigo_vehiculo = 201;




