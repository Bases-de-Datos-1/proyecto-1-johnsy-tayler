-- Insertar datos en tablas con dependencias
INSERT INTO TipoRedSocial (nombre) VALUES 
('Facebook'), 
('Instagram'), 
('Twitter'), 
('YouTube'), 
('TikTok');

INSERT INTO TipoServicioHospedaje (nombre) VALUES 
('Desayuno'),
('Piscina'),
('GimnASio'),
('Spa'),
('Bar'),
('Wi-Fi'),
('Estacionamiento'),
('Lavandería'),
('Cocina'),
('Limpieza'),
('Recepción'),
('Acceso'),
('MAScota'),
('Caja fuerte'),
('Televisión'),
('Climatización'),
('Minibar'),
('Barbacoa'),
('Chimenea'),
('Terraza');

INSERT INTO TipoActividad (nombre) VALUES 
('Aventura'),
('Cultura'),
('Relajación'),
('Deporte'),
('Ecoturismo'),
('GAStronomía'),
('Náutica'),
('Fotografía'),
('Avistamiento'),
('Taller'),
('Pesca'),
('Camping'),
('Escalada'),
('Esquí');

INSERT INTO TipoServicio (nombre) VALUES 
('Transporte'),
('Guía'),
('Comida'),
('Alquiler'),
('Tour'),
('ClASe'),
('Reserva'),
('ASistencia'),
('Concierge'),
('Traducción'),
('Fotografía'),
('Animación'),
('Espectáculo'),
('Degustación'),
('Taller'),
('Entrenamiento'),
('Excursión'),
('Experiencia'),
('Demostración'),
('Recreación'),
('Evento'),
('Competencia'),
('Campamento'),
('Charla'),
('Cuidado infantil');

-- Insertar datos utilizando procedimientos almacenados
EXEC SP_InsertarTipoHospedaje 'Hotel Tropical';
EXEC SP_InsertarEmpresaRecreacion 'Aventura Costa Rica', '223344556', 'contacto@aventuracr.com', '223-4455', 'Carlos Mena', 'San José', 'Escazú', 'Avenida 2', 'Junto a la autopista', 9.997777, -83.050000;
EXEC SP_InsertarActividad 1, 1, 'Trekking por la selva', 50.00; -- Aventura tiene id=1
EXEC SP_InsertarServicio 1, 1; -- Guía turístico tiene id=2
EXEC SP_InsertarEmpresaHospedaje 'Hotel Caribe', '111223344', 1, 'Heredia', 'Barva', 'San José', 'Barrio 2', 'Frente a la plaza', 9.998888, -83.043322, 'contacto@hotelcaribe.com';
EXEC SP_InsertarTelefonoEmpresa 1, '222-3344';
EXEC SP_InsertarRedSocial 1, 3, 'https://twitter.com/hotelcaribe'; -- Twitter tiene id=3
EXEC SP_InsertarRedSocial 1, 2, 'https://instagram.com/hoteleliminar';
EXEC SP_InsertarServicio_hospedaje 1, 2; -- Piscina tiene id=2
EXEC SP_InsertarTipoHabitacion 'Estándar', 'Habitación básica', 'Queen', 70.00;
EXEC SP_InsertarComodidad 1, 'WIFi';
EXEC SP_InsertarFotoHabitacion 1, 'https://example.com/standard_room.jpg';
EXEC SP_InsertarHabitacion 1, 201, 1;

EXEC SP_InsertarCliente 'Juan', 'Gómez', 'Alvarado', '1990-02-20', 'ID', '1122334455', 'Costa Rica', 'San José', 'Escazú', 'Barrio Central', 'juan@example.com';
EXEC SP_InsertarTelefonoCliente 1, '222-5555';

-- Insertar Reserva
DECLARE @idHabitacion1 INT;
SELECT @idHabitacion1 = idHabitacion FROM Habitacion WHERE numero = 201 AND idEmpresaHospedaje = 1;
EXEC SP_InsertarReserva 1, 1, @idHabitacion1, '2025-06-10', 1, 0, '2025-06-12', '09:00:00';

-- Insertar Factura
DECLARE @idReserva1 INT;
SELECT @idReserva1 = idReserva FROM Reserva WHERE idCliente = 1 AND idEmpresaHospedaje = 1;
EXEC SP_InsertarFactura @idReserva1, 140.00, 'Efectivo';

-- Eliminar
-- Insertar datos de prueba
EXEC SP_InsertarTipoHospedaje 'Hotel Ejemplo Eliminar';
EXEC SP_InsertarTipoHabitacion 'Prueba Eliminar', 'Habitación para demostración', 'King', 150.00;
EXEC SP_InsertarEmpresaRecreacion 'Eliminar Tours', '445566778', 'info@eliminartours.com', '2233-4455', 'María Eliminar', 'San José', 'Escazú', 'Calle Eliminar', 'Junto al parque', 9.922222, -84.044444;
EXEC SP_InsertarActividad 2, 2, 'Tour de eliminación', 75.00;
EXEC SP_InsertarServicio 1, 2;
EXEC SP_InsertarEmpresaHospedaje 'Hotel Prueba Eliminación', '999888777', 2, 'San José', 'Montes de Oca', 'San Pedro', 'Barrio Prueba', 'Frente al mall', 9.933333, -84.033333, 'prueba@eliminar.com';
EXEC SP_InsertarTelefonoEmpresa 2, '222-9999';
EXEC SP_InsertarRedSocial 2, 1, 'https://facebook.com/hoteleliminar';
EXEC SP_InsertarServicio_hospedaje 2, 1;
EXEC SP_InsertarComodidad 2, 'TV Pantalla Plana';
EXEC SP_InsertarFotoHabitacion 2, 'https://example.com/prueba_eliminar.jpg';
EXEC SP_InsertarHabitacion 2, 401, 2;

EXEC SP_InsertarCliente 'Ana', 'Prueba', 'Eliminar', '1980-05-15', 'ID', '9988776655', 'Costa Rica', 'San José', 'Curridabat', 'Barrio Este', 'ana@eliminar.com';
EXEC SP_InsertarTelefonoCliente 2, '888-4444';

-- Eliminar los datos
DECLARE @idHabitacion_eliminar INT;
SELECT @idHabitacion_eliminar = idHabitacion FROM Habitacion WHERE numero = 401 AND idEmpresaHospedaje = 2;
EXEC SP_InsertarReserva 2, 2, @idHabitacion_eliminar, '2025-09-01', 2, 1, '2025-09-05', '10:00:00';

DECLARE @idReserva_eliminar INT;
SELECT @idReserva_eliminar = idReserva FROM Reserva WHERE idCliente = 2 AND idEmpresaHospedaje = 2;
EXEC SP_InsertarFactura @idReserva_eliminar, 600.00, 'Tarjeta débito';

DECLARE @idActividad_eliminar INT;
SELECT @idActividad_eliminar = SCOPE_IDENTITY();
EXEC SP_InsertarServicio 2, 2;

EXEC SP_EliminarFactura @idFactura = 1003;
EXEC SP_EliminarReserva @idReserva = @idReserva_eliminar;
EXEC SP_EliminarActividad @idActividad = @idActividad_eliminar;
EXEC SP_EliminarHabitacion @idHabitacion = @idHabitacion_eliminar;
EXEC SP_EliminarCliente @idCliente = 2;
EXEC SP_EliminarHospedaje @id_hospedaje = 2;

-- VerIFicar eliminación
SELECT * FROM EmpresaHospedaje WHERE idEmpresaHospedaje = 2;
SELECT * FROM Cliente WHERE idCliente = 2;
SELECT * FROM Habitacion WHERE idHabitacion = @idHabitacion_eliminar;
SELECT * FROM Actividad WHERE idActividad = @idActividad_eliminar;

-- Actualizaciones (Updates)
-- Insertar datos
EXEC SP_InsertarTipoHospedaje 'Hotel Marítimo';
EXEC SP_InsertarEmpresaHospedaje 'Hotel Marítimo Azul', '223355667', 3, 'GuanacASte', 'Liberia', 'CanAS', 'Barrio 5', 'Frente a la playa', 10.022222, -85.050000, 'Reservas@hotelmaritimo.com';
EXEC SP_InsertarTelefonoEmpresa 3, '444-7777';
EXEC SP_InsertarRedSocial 3, 1, 'https://facebook.com/hotelmaritimo';
EXEC SP_InsertarServicio_hospedaje 3, 3; -- Spa tiene id=3
EXEC SP_InsertarEmpresaRecreacion 'Trekking GuanacASte', '778899112', 'contacto@trekkingguanacASte.com', '455-6677', 'Juan Pérez', 'GuanacASte', 'Liberia', 'Calle 4', 'Cerca de la estación de bUSEs', 10.022222, -85.062222;
EXEC SP_InsertarActividad 3, 3, 'Excursión al volcán', 120.00; -- Relajación tiene id=3
EXEC SP_InsertarServicio 3, 3; -- Equipo deportivo tiene id=3
EXEC SP_InsertarTipoHabitacion 'Suite Presidencial', 'Habitación de lujo con jacuzzi privado', 'King', 500.00;
EXEC SP_InsertarComodidad 3, 'Sauna';
EXEC SP_InsertarFotoHabitacion 3, 'https://example.com/presidential_suite.jpg';
EXEC SP_InsertarHabitacion 3, 303, 3;
EXEC SP_InsertarCliente 'Pedro', 'Fernández', 'Lopez', '1978-09-30', 'ID', '3344556677', 'Costa Rica', 'GuanacASte', 'Liberia', 'Barrio 6', 'pedro@example.com';
EXEC SP_InsertarTelefonoCliente 3, '444-8888';

-- Insertar Reserva
DECLARE @idHabitacion3 INT;
SELECT @idHabitacion3 = idHabitacion FROM Habitacion WHERE numero = 303 AND idEmpresaHospedaje = 3;
EXEC SP_InsertarReserva 3, 3, @idHabitacion3, '2025-07-15', 3, 0, '2025-07-20', '08:30:00';

-- Insertar Factura
DECLARE @idReserva3 INT;
SELECT @idReserva3 = idReserva FROM Reserva WHERE idCliente = 3 AND idEmpresaHospedaje = 3;
EXEC SP_InsertarFactura @idReserva3, 2500.00, 'Tarjeta de crédito';

EXEC SP_InsertarTipoHospedaje 'Hotel Plaza Real';
EXEC SP_InsertarTipoHabitacion 'Habitación Doble Standard', 'Habitación conforTABLE con dos camAS individuales', 'King', 150.00;
EXEC SP_InsertarEmpresaRecreacion 'Eco Aventura', '45657833', 'contacto@ecoaventura.com', '2233-4455', 'Carlos Martínez', 'San José', 'Escazú', 'Calle Real', 'Cerca del parque central', 9.922222, -84.044444;
EXEC SP_InsertarActividad 3, 4, 'Excursión al Volcán Arenal', 75.00;
EXEC SP_InsertarServicio 1, 4;
EXEC SP_InsertarEmpresaHospedaje 'Hotel Costa Rica Suites', '999888777', 4, 'San José', 'Montes de Oca', 'San Pedro', 'Barrio El Centro', 'A pocos metros de la estación de tren', 9.933333, -84.033333, 'Reservas@costaricASuites.com';
EXEC SP_InsertarTelefonoEmpresa 4, '222-9999';
EXEC SP_InsertarRedSocial 4, 1, 'https://facebook.com/hotelcostaricASuites';
EXEC SP_InsertarServicio_hospedaje 4, 1;
EXEC SP_InsertarComodidad 4, 'WIFi Gratuito';
EXEC SP_InsertarFotoHabitacion 4, 'https://example.com/Habitacion_doble.jpg';
EXEC SP_InsertarHabitacion 4, 401, 4;

EXEC SP_InsertarCliente 'María', 'GOnzález', 'Pérez', '1985-05-15', 'ID', '9988776655', 'Costa Rica', 'San José', 'Curridabat', 'Barrio La Paz', 'maria@ejemplo.com';
EXEC SP_InsertarTelefonoCliente 4, '888-4444';

DECLARE @idHabitacion_eliminar1 INT;
DECLARE @idReserva_eliminar1 INT;
DECLARE @idActividad_eliminar1 INT;

SELECT @idHabitacion_eliminar1 = idHabitacion FROM Habitacion WHERE numero = 401 AND idEmpresaHospedaje = 4;
EXEC SP_InsertarReserva 4, 4, @idHabitacion_eliminar1, '2025-09-01', 2, 1, '2025-09-05', '10:00:00';

SELECT @idReserva_eliminar1 = idReserva FROM Reserva WHERE idCliente = 4 AND idEmpresaHospedaje = 4;
EXEC SP_InsertarFactura @idReserva_eliminar1, 600.00, 'Tarjeta débito';

SELECT @idActividad_eliminar1 = SCOPE_IDENTITY();
EXEC SP_InsertarServicio 2, 4;

-- Actualizar los datos insertados
-- 1. Actualizar Empresa de Hospedaje (ID 4)
BEGIN TRANSACTION;
EXEC SP_ActualizarHospedaje 
  @id_hospedaje = 4,
  @nombre = 'Hotel Costa Rica Premium Suites',
  @cedulaJuridica = '999888777',
  @idTipoHospedaje = 4,
  @provincia = 'San José',
  @canton = 'Montes de Oca',
  @distrito = 'San Pedro',
  @barrio = 'Barrio El Centro',
  @senas = 'A 100 metros de la estación de tren',
  @latitud = 9.934444,
  @longitud = -84.034444,
  @correo = 'Reservas@costaricASuites.com';

-- 2. Actualizar Cliente (ID 4)
EXEC SP_ActualizarCliente 
  @idCliente = 4,
  @nombre = 'María Fernanda',
  @apellido1 = 'GOnzález',
  @apellido2 = 'Pérez',
  @fechaNacimiento = '1985-05-15',
  @tipoIdentIFicacion = 'ID',
  @identIFicacion = '9988776655',
  @pais = 'Costa Rica',
  @provincia = 'San José',
  @canton = 'Curridabat',
  @distrito = 'Barrio La Paz',
  @correo = 'maria.fernanda@ejemplo.com';

-- 3. Actualizar Habitación (401 ? 402)
DECLARE @idHabitacion INT = (SELECT idHabitacion FROM Habitacion WHERE numero = 401 AND idEmpresaHospedaje = 4);
EXEC SP_ActualizarHabitacion 
  @idHabitacion = @idHabitacion,
  @idEmpresaHospedaje = 4,
  @numero = 402,
  @idTipoHabitacion = 4;

-- 4. Actualizar Reserva (ID 10000002)
EXEC SP_ActualizarReserva 
  @idReserva = 10000002,
  @idCliente = 4,
  @idEmpresaHospedaje = 4,
  @idHabitacion = @idHabitacion,
  @fechaIngreso = '2025-09-01',
  @cantidadPersonAS = 3,
  @tieneVehiculo = 1,
  @fechASalida = '2025-09-06',
  @horASalida = '11:30:00';

-- 5. Actualizar Factura (ID 3)
EXEC SP_ActualizarFactura 
  @idFactura = 3,
  @idReserva = 10000002,
  @importeTotal = 750.00,
  @formaPaGO = 'Tarjeta crédito';

-- 6. Actualizar Actividad (ID 3 - Excursión)
EXEC SP_ActualizarActividad 
  @idActividad = 3,
  @idTipoActividad = 4,
  @idEmpresaRecreacion = 4,
  @descripcion = 'Excursión Premium al Volcán Arenal con almuerzo incluido',
  @precio = 95.00;
COMMIT TRANSACTION;

-- -----------------------------------------------------
-- MAS ejemplos de insert
-- Insertar datos
EXEC SP_InsertarTipoHospedaje 'Hotel Los Templos';
EXEC SP_InsertarTipoHabitacion 'Suite Familiar', 'Habitación con cama doble y dos camAS individuales', 'Queen', 180.00;
EXEC SP_InsertarEmpresaRecreacion 'Aventura Total', '567489134', 'contacto@aventuratotal.com', '2233-4455', 'Luis Hernández', 'Alajuela', 'Ciudad Quesada', 'Calle 5', 'Cerca de la plaza central', 10.022222, -84.022222;
EXEC SP_InsertarActividad 2, 5, 'Tour de Observación de Aves', 90.00;
EXEC SP_InsertarServicio 3, 5;
EXEC SP_InsertarEmpresaHospedaje 'Hotel Vista Hermosa', '777666555', 5, 'Alajuela', 'San Carlos', 'Muelle', 'Barrio La Palma', 'A orillAS del río', 10.033333, -84.034444, 'contacto@vistahermosa.com';
EXEC SP_InsertarTelefonoEmpresa 5, '333-7777';
EXEC SP_InsertarRedSocial 5, 2, 'https://twitter.com/hotelvistahermosa';
EXEC SP_InsertarServicio_hospedaje 5, 2;
EXEC SP_InsertarComodidad 5, 'Piscina Climatizada';
EXEC SP_InsertarFotoHabitacion 5, 'https://example.com/suite_familiar.jpg';
EXEC SP_InsertarHabitacion 5, 402, 5;

EXEC SP_InsertarCliente 'José', 'Ramírez', 'Sánchez', '1990-08-20', 'ID', '6677889900', 'Costa Rica', 'Heredia', 'Barva', 'Barrio San Antonio', 'jose@ejemplo.com';
EXEC SP_InsertarTelefonoCliente 5, '777-3333';

DECLARE @idHabitacion_eliminar2 INT;
DECLARE @idReserva_eliminar2 INT;
DECLARE @idActividad_eliminar2 INT;

SELECT @idHabitacion_eliminar2 = idHabitacion FROM Habitacion WHERE numero = 402 AND idEmpresaHospedaje = 5;
EXEC SP_InsertarReserva 5, 5, @idHabitacion_eliminar2, '2025-10-01', 2, 1, '2025-10-05', '12:00:00';

SELECT @idReserva_eliminar2 = idReserva FROM Reserva WHERE idCliente = 5 AND idEmpresaHospedaje = 5;
EXEC SP_InsertarFactura @idReserva_eliminar2, 700.00, 'Tarjeta de crédito';

SELECT @idActividad_eliminar2 = SCOPE_IDENTITY();
EXEC SP_InsertarServicio 3, 5;