USE GestionHotelera;
GO

CREATE VIEW VW_InfoCompletaHospedaje AS
SELECT 
    eh.nombre AS nombreHotel,
    eh.cedulaJuridica,
    th.nombre AS TipoHospedaje,
    eh.provincia,
    eh.canton,
    eh.distrito,
    eh.barrio,
    eh.senas,
    eh.latitud,
    eh.longitud,
    eh.correo,
    STRING_AGG(tsh.nombre, ', ') AS servicios,
    STRING_AGG(trs.nombre + ': ' + r.url, ' | ') AS redesSociales
FROM EmpresaHospedaje eh
JOIN TipoHospedaje th on eh.idTipoHospedaje = th.idTipoHospedaje
LEFT JOIN ServiciosHospedaje sh on eh.idEmpresaHospedaje = sh.idEmpresaHospedaje
LEFT JOIN TipoServicioHospedaje tsh on sh.idTipoServicio = tsh.idTipoServicio
LEFT JOIN Redes r on eh.idEmpresaHospedaje = r.idEmpresaHospedaje
LEFT JOIN TipoRedSocial trs on r.idTipoRed = trs.idTipoRed
GROUP BY eh.idEmpresaHospedaje, eh.nombre, eh.cedulaJuridica, th.nombre, eh.provincia, 
         eh.canton, eh.distrito, eh.barrio, eh.senas, eh.latitud, eh.longitud, eh.correo;
GO

-- Vista para información de Habitaciones disponibles
CREATE VIEW VW_HabitacionesDisponibles AS
SELECT 
    eh.nombre AS nombreHotel,
    th.nombre AS TipoHabitacion,
    th.descripcion,
    th.tipoCama,
    th.precio,
    h.numero AS numero_Habitacion,
    STRING_AGG(c.comodidad, ', ') AS Comodidades
FROM Habitacion h
JOIN EmpresaHospedaje eh on h.idEmpresaHospedaje = eh.idEmpresaHospedaje
JOIN TipoHabitacion th on h.idTipoHabitacion = th.idTipo
LEFT JOIN Comodidades c on th.idTipo = c.idTipoHabitacion
WHERE h.idHabitacion NOT IN (
    SELECT idHabitacion FROM Reserva 
    WHERE GETDATE() BETWEEN fechaIngreso AND fechASalida
)
GROUP BY eh.nombre, th.nombre, th.descripcion, th.tipoCama, th.precio, h.numero;
GO

-- Vista para información de Reservas
CREATE VIEW VW_DetalleReservas AS
SELECT 
    r.idReserva,
    c.nombre + ' ' + c.apellido1 + ' ' + c.apellido2 AS Cliente,
    eh.nombre AS hotel,
    h.numero AS Habitacion,
    th.nombre AS TipoHabitacion,
    r.fechaIngreso,
    r.fechASalida,
    r.horASalida,
    r.cantidadPersonAS,
    CASE WHEN r.tieneVehiculo = 1 THEN 'Sí' ELSE 'No' END AS vehiculo,
    DATEDIFF(day, r.fechaIngreso, r.fechASalida) AS noches,
    (DATEDIFF(day, r.fechaIngreso, r.fechASalida) * th.precio) AS total_estimado
FROM Reserva r
JOIN Cliente c on r.idCliente = c.idCliente
JOIN Habitacion h on r.idHabitacion = h.idHabitacion
JOIN EmpresaHospedaje eh on h.idEmpresaHospedaje = eh.idEmpresaHospedaje
JOIN TipoHabitacion th on h.idTipoHabitacion = th.idTipo;
GO

-- Vista para Facturación
CREATE VIEW VW_Facturacion AS
SELECT 
    f.idFactura,
    r.idReserva,
    c.nombre + ' ' + c.apellido1 + ' ' + c.apellido2 AS Cliente,
    eh.nombre AS hotel,
    h.numero AS Habitacion,
    f.fecha,
    f.importeTotal,
    f.formaPaGO,
    DATEDIFF(day, r.fechaIngreso, r.fechASalida) AS noches
FROM Factura f
JOIN Reserva r on f.idReserva = r.idReserva
JOIN Cliente c on r.idCliente = c.idCliente
JOIN Habitacion h on r.idHabitacion = h.idHabitacion
JOIN EmpresaHospedaje eh on h.idEmpresaHospedaje = eh.idEmpresaHospedaje;
GO

-- Vista para Actividades recreativas
CREATE VIEW VW_ActividadesRecreativas AS
SELECT 
    er.nombre AS empresa,
    er.encargado,
    er.telefono,
    er.correo,
    ta.nombre AS TipoActividad,
    a.descripcion,
    a.precio,
    STRING_AGG(ts.nombre, ', ') AS servicios_incluidos
FROM Actividad a
JOIN EmpresaRecreacion er on a.idEmpresaRecreacion = er.idEmpresaRecreacion
JOIN TipoActividad ta on a.idTipoActividad = ta.idTipoActividad
LEFT JOIN servicio s on er.idEmpresaRecreacion = s.idEmpresaRecreacion
LEFT JOIN TipoServicio ts on s.idTipoServicio = ts.idTipoServicio
GROUP BY er.nombre, er.encargado, er.telefono, er.correo, ta.nombre, a.descripcion, a.precio;
GO

-- Vista de hospedajes con filtros estilo AirBnB
CREATE VIEW VW_BusquedaHospedajes AS
SELECT 
    eh.idEmpresaHospedaje,
    eh.nombre AS nombreHotel,
    eh.provincia,
    eh.canton,
    eh.distrito,
    th.nombre AS TipoHospedaje,
    eh.correo,
    eh.latitud,
    eh.longitud,
    STRING_AGG(tsh.nombre, ', ') AS servicios,
    MIN(thab.precio) AS precio_minimo
FROM EmpresaHospedaje eh
JOIN TipoHospedaje th on eh.idTipoHospedaje = th.idTipoHospedaje
JOIN Habitacion h on eh.idEmpresaHospedaje = h.idEmpresaHospedaje
JOIN TipoHabitacion thab on h.idTipoHabitacion = thab.idTipo
LEFT JOIN ServiciosHospedaje sh on eh.idEmpresaHospedaje = sh.idEmpresaHospedaje
LEFT JOIN TipoServicioHospedaje tsh on sh.idTipoServicio = tsh.idTipoServicio
GROUP BY eh.idEmpresaHospedaje, eh.nombre, eh.provincia, eh.canton, eh.distrito, th.nombre, eh.correo, eh.latitud, eh.longitud;
GO

-- Vista de Facturación con datos combinados
CREATE VIEW VW_ReporteFacturacion AS
SELECT 
    f.idFactura,
    r.idReserva,
    c.nombre + ' ' + c.apellido1 + ' ' + c.apellido2 AS Cliente,
    eh.nombre AS hotel,
    h.numero AS Habitacion,
    th.nombre AS TipoHabitacion,
    f.fecha,
    f.importeTotal,
    f.formaPaGO
FROM Factura f
JOIN Reserva r on f.idReserva = r.idReserva
JOIN Cliente c on r.idCliente = c.idCliente
JOIN Habitacion h on r.idHabitacion = h.idHabitacion
JOIN TipoHabitacion th on h.idTipoHabitacion = th.idTipo
JOIN EmpresaHospedaje eh on h.idEmpresaHospedaje = eh.idEmpresaHospedaje;
GO

--Vista para Habitaciones con Comodidades Específicas
CREATE VIEW VW_HabitacionesConComodidades AS
SELECT 
    h.idHabitacion,
    eh.nombre AS hotel,
    th.nombre AS TipoHabitacion,
    th.precio,
    STRING_AGG(c.comodidad, ', ') AS Comodidades
FROM Habitacion h
JOIN EmpresaHospedaje eh ON h.idEmpresaHospedaje = eh.idEmpresaHospedaje
JOIN TipoHabitacion th ON h.idTipoHabitacion = th.idTipo
JOIN Comodidades c ON th.idTipo = c.idTipoHabitacion
GROUP BY h.idHabitacion, eh.nombre, th.nombre, th.precio;
GO