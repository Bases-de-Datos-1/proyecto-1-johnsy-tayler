-- 1. Tipos
SELECT * FROM TipoHospedaje;
SELECT * FROM TipoRedSocial;
SELECT * FROM TipoServicioHospedaje;
SELECT * FROM TipoHabitacion;
SELECT * FROM TipoActividad;
SELECT * FROM TipoServicio;

-- 2. EmpresAS y teléfonos
SELECT * FROM EmpresaHospedaje;
SELECT * FROM TelefonosEmpresa;
SELECT * FROM EmpresaRecreacion;

-- 3. Redes sociales
SELECT * FROM Redes;

-- 4. Servicios
SELECT * FROM ServiciosHospedaje;
SELECT * FROM servicio;

-- 5. Habitaciones y sus detalles
SELECT * FROM Habitacion;
SELECT * FROM Comodidades;
SELECT * FROM FotosHabitacion;

-- 6. Clientes y teléfonos
SELECT * FROM Cliente;
SELECT * FROM TelefonosCliente;

-- 7. Reservas y Facturación
SELECT * FROM Reserva;
SELECT * FROM Factura;

-- 8. Actividades
SELECT * FROM Actividad;

-- Vista de hospedaje con info completa
SELECT * FROM VW_InfoCompletaHospedaje;

-- Vista de Habitaciones disponibles (excluye ReservadAS en fecha actual)
SELECT * FROM VW_HabitacionesDisponibles;

-- Vista de detalle de Reservas
SELECT * FROM VW_DetalleReservas;

-- Vista de Facturación por Reserva
SELECT * FROM VW_Facturacion;

-- Vista de Actividades recreativAS
SELECT * FROM VW_ActividadesRecreativas;

--Filtros
--Filtros de hospedajes para usuario
-- Buscar hospedajes en la provincia de Limón
EXEC SP_BuscarHospedajesPorProvincia @provincia = 'Limón';
GO

-- Buscar hospedajes en el cantón de Talamanca
EXEC SP_BuscarHospedajesPorcanton @canton = 'Talamanca';
GO

-- Buscar hospedajes del tipo Cabana
EXEC SP_BuscarHospedajesPortipo @TipoHospedaje = 'Cabana';
GO

-- Buscar hospedajes que incluyan piscina y wIFi
EXEC SP_BuscarHospedajesPorServicios @servicio1 = 'Piscina', @servicio2 = 'WIFi';
GO

-- Buscar hospedajes con precios entre 60 y 120
EXEC SP_BuscarHospedajesPorPrecio @precio_minimo = 60, @precio_maximo = 120;
GO

-- Buscar hospedajes por nombre de hotel (ejemplo: que contenga "Caribe")
EXEC SP_BuscarHospedajesPorNombre @nombreHotel = 'Caribe';
GO

-- Buscar hospedajes con múltiples filtros: provincia Limón, canton Talamanca, tipo Cabana, servicios con WIFi y precio entre 70 y 100
EXEC SP_BuscarHospedajesConFiltros @provincia = 'Limón', @canton = 'Talamanca', @TipoHospedaje = 'Cabana', @servicio = 'WIFi', @precio_minimo = 70, @precio_maximo = 100;
GO


-- Filtros para Facturación
-- Búsqueda de FacturAS en un ranGO de fechAS
EXEC SP_BuscarFacturASPorFecha @fecha_inicio = '2024-04-01', @fecha_fin = '2024-04-30';
GO

-- Búsqueda de FacturAS con paGO en tarjeta
EXEC SP_BuscarFacturASPorPaGO @formaPaGO = 'Tarjeta de crédito';
GO

-- Búsqueda de FacturAS en un ranGO de importe
EXEC SP_BuscarFacturASPorimporte @importe_minimo = 100, @importe_maximo = 400;
GO

-- Búsqueda de FacturAS por tipo de habitación
EXEC SP_BuscarFacturASPorTipoHabitacion @TipoHabitacion = 'Deluxe';
GO

-- Búsqueda de FacturAS por número de habitación
EXEC SP_BuscarFacturASPorNumeroHabitacion @Habitacion = 201;
GO

-- Búsqueda de FacturAS por nombre de Cliente
EXEC SP_BuscarFacturASPorCliente @Cliente = '%Carlos Hernández%';
GO

-- Búsqueda de FacturAS con combinación de filtros
EXEC SP_BuscarFacturASConFiltros @fecha_inicio = '2024-01-01', @fecha_fin = '2024-12-31', @TipoHabitacion = 'Deluxe', @formaPaGO = 'Tarjeta de crédito', @importe_minimo = 300;
GO

-- Obtener ultima Factura de la Habitacion
EXEC SP_ObtenerUltimaFacturaPorHabitacion @idHabitacion = 1;
GO

-- Buscar FacturAS del Cliente con cédula "1122334455"
EXEC SP_BuscarFacturASPorIdentIFicacion @identIFicacion = '1122334455';
GO

-- Buscar tours en bote en Limón, precio máximo $50
EXEC SP_BuscarActividadesConFiltros 
    @TipoActividad = 'Tour en bote',
    @precio_maximo = 50,
    @provincia = 'Limón';
GO

-- Buscar Habitaciones en Limón, tipo "Deluxe", hASta $100/noche, con A/C, disponibles del 1 al 10 de mayo 2024
EXEC SP_BuscarHabitacionesDisponiblesConFiltros 
    @fecha_inicio = '2024-05-01',
    @fecha_fin = '2024-05-10',
    @idTipoHabitacion = 2, -- ID del tipo "Deluxe"
    @precio_maximo = 100,
    @comodidad = 'Aire acondicionado';