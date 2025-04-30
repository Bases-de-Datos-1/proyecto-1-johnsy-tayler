-- Procedures para insertar
CREATE PROCEDURE SP_InsertarTipoHospedaje(
    @p_nombre varchar(50)
)
AS
BEGIN
    INSERT INTO TipoHospedaje (nombre)
    VALUES (@p_nombre);
END;
GO

-- PROCEDURE para insertar una empresa de hospedaje
CREATE PROCEDURE SP_InsertarEmpresaHospedaje(
    @p_nombre varchar(100),
    @p_cedulaJuridica varchar(15),
    @p_idTipoHospedaje int,
    @p_provincia varchar(30),
    @p_canton varchar(30),
    @p_distrito varchar(30),
    @p_barrio varchar(30),
    @p_senas varchar(100),
    @p_latitud decimal(10, 8),
    @p_longitud decimal(11, 8),
    @p_correo varchar(40)
)
AS
BEGIN
    INSERT INTO EmpresaHospedaje (nombre, cedulaJuridica, idTipoHospedaje, provincia, canton, distrito, barrio, senas, latitud, longitud, correo)
    VALUES (@p_nombre, @p_cedulaJuridica, @p_idTipoHospedaje, @p_provincia, @p_canton, @p_distrito, @p_barrio, @p_senas, @p_latitud, @p_longitud, @p_correo);
END;
GO

-- PROCEDURE para insertar un teléfono de empresa
CREATE PROCEDURE SP_InsertarTelefonoEmpresa(
    @p_idEmpresaHospedaje int,
    @p_numero varchar(20)
)
AS
BEGIN
    INSERT INTO TelefonosEmpresa (idEmpresaHospedaje, numero)
    VALUES (@p_idEmpresaHospedaje, @p_numero);
END;
GO

-- PROCEDURE para insertar una red social
CREATE PROCEDURE SP_InsertarRedSocial(
    @p_idEmpresaHospedaje int,
    @p_idTipoRed int,
    @p_url varchar(200)
)
AS
BEGIN
    INSERT INTO Redes (idEmpresaHospedaje, idTipoRed, url)
    VALUES (@p_idEmpresaHospedaje, @p_idTipoRed, @p_url);
END;
GO

-- PROCEDURE para insertar un servicio de hospedaje
CREATE PROCEDURE SP_InsertarServicio_hospedaje(
    @p_idEmpresaHospedaje int,
    @p_idTipoServicio int
)
AS
BEGIN
    INSERT INTO ServiciosHospedaje (idEmpresaHospedaje, idTipoServicio)
    VALUES (@p_idEmpresaHospedaje, @p_idTipoServicio);
END;
GO

-- PROCEDURE para insertar un tipo de habitación
CREATE PROCEDURE SP_InsertarTipoHabitacion(
    @p_nombre varchar(50),
    @p_descripcion varchar(150),
    @p_tipoCama varchar(50),
    @p_precio decimal(10, 2)
)
AS
BEGIN
    INSERT INTO TipoHabitacion (nombre, descripcion, tipoCama, precio)
    VALUES (@p_nombre, @p_descripcion, @p_tipoCama, @p_precio);
END;
GO

-- PROCEDURE para insertar una comodidad en habitación
CREATE PROCEDURE SP_InsertarComodidad(
    @p_idTipoHabitacion int,
    @p_comodidad varchar(50)
)
AS
BEGIN
    INSERT INTO Comodidades (idTipoHabitacion, comodidad)
    VALUES (@p_idTipoHabitacion, @p_comodidad);
END;
GO

-- PROCEDURE para insertar una foto de habitación
CREATE PROCEDURE SP_InsertarFotoHabitacion(
    @p_idTipoHabitacion int,
    @p_url varchar(200)
)
AS
BEGIN
    INSERT INTO FotosHabitacion (idTipoHabitacion, url)
    VALUES (@p_idTipoHabitacion, @p_url);
END;
GO

-- PROCEDURE para insertar una habitación
CREATE PROCEDURE SP_InsertarHabitacion(
    @p_idEmpresaHospedaje int,
    @p_numero int,
    @p_idTipoHabitacion int
)
AS
BEGIN
    INSERT INTO Habitacion (idEmpresaHospedaje, numero, idTipoHabitacion)
    VALUES (@p_idEmpresaHospedaje, @p_numero, @p_idTipoHabitacion);
END;
GO

-- PROCEDURE para insertar un Cliente
CREATE PROCEDURE SP_InsertarCliente(
    @p_nombre varchar(50),
    @p_apellido1 varchar(50),
    @p_apellido2 varchar(50),
    @p_fechaNacimiento date,
    @p_tipoIdentIFicacion varchar(20),
    @p_identIFicacion varchar(30),
    @p_pais varchar(30),
    @p_provincia varchar(30),
    @p_canton varchar(30),
    @p_distrito varchar(30),
    @p_correo varchar(40)
)
AS
BEGIN
    INSERT INTO Cliente (nombre, apellido1, apellido2, fechaNacimiento, tipoIdentIFicacion, identIFicacion, pais, provincia, canton, distrito, correo)
    VALUES (@p_nombre, @p_apellido1, @p_apellido2, @p_fechaNacimiento, @p_tipoIdentIFicacion, @p_identIFicacion, @p_pais, @p_provincia, @p_canton, @p_distrito, @p_correo);
END;
GO

-- PROCEDURE para insertar un teléfono de Cliente
CREATE PROCEDURE SP_InsertarTelefonoCliente(
    @p_idCliente int,
    @p_numero varchar(20)
)
AS
BEGIN
    INSERT INTO TelefonosCliente (idCliente, numero)
    VALUES (@p_idCliente, @p_numero);
END;
GO

-- PROCEDURE para insertar una Reserva
CREATE PROCEDURE SP_InsertarReserva(
    @p_idCliente int,
    @p_idEmpresaHospedaje int,
    @p_idHabitacion int,
    @p_fechaIngreso datetime,
    @p_cantidadPersonAS int,
    @p_tieneVehiculo bit,
    @p_fechASalida date,
    @p_horASalida time
)
AS
BEGIN
    INSERT INTO Reserva (idCliente, idEmpresaHospedaje, idHabitacion, fechaIngreso, cantidadPersonAS, tieneVehiculo, fechASalida, horASalida)
    VALUES (@p_idCliente, @p_idEmpresaHospedaje, @p_idHabitacion, @p_fechaIngreso, @p_cantidadPersonAS, @p_tieneVehiculo, @p_fechASalida, @p_horASalida);
END;
GO

-- PROCEDURE para insertar una Factura
CREATE PROCEDURE SP_InsertarFactura(
    @p_idReserva int,
    @p_importeTotal decimal(10, 2),
    @p_formaPaGO varchar(20)
)
AS
BEGIN
    INSERT INTO Factura (idReserva, importeTotal, formaPaGO)
    VALUES (@p_idReserva, @p_importeTotal, @p_formaPaGO);
END;
GO

-- PROCEDURE para insertar una empresa de recreación
CREATE PROCEDURE SP_InsertarEmpresaRecreacion(
    @p_nombre varchar(100),
    @p_cedulaJuridica varchar(15),
    @p_correo varchar(40),
    @p_telefono varchar(20),
    @p_encargado varchar(100),
    @p_provincia varchar(30),
    @p_canton varchar(30),
    @p_distrito varchar(30),
    @p_senas varchar(100),
    @p_latitud decimal(10, 8),
    @p_longitud decimal(11, 8)
)
AS
BEGIN
    INSERT INTO EmpresaRecreacion (nombre, cedulaJuridica, correo, telefono, encargado, provincia, canton, distrito, senas, latitud, longitud)
    VALUES (@p_nombre, @p_cedulaJuridica, @p_correo, @p_telefono, @p_encargado, @p_provincia, @p_canton, @p_distrito, @p_senas, @p_latitud, @p_longitud);
END;
GO

-- PROCEDURE para insertar una Actividad recreativa
CREATE PROCEDURE SP_InsertarActividad(
    @p_idTipoActividad int,
    @p_idEmpresaRecreacion int,
    @p_descripcion varchar(150),
    @p_precio decimal(10, 2)
)
AS
BEGIN
    INSERT INTO Actividad (idTipoActividad, idEmpresaRecreacion, descripcion, precio)
    VALUES (@p_idTipoActividad, @p_idEmpresaRecreacion, @p_descripcion, @p_precio);
END;
GO

-- PROCEDURE para insertar un servicio de recreación
CREATE PROCEDURE SP_InsertarServicio(
    @p_idTipoServicio int,
    @p_idEmpresaRecreacion int
)
AS
BEGIN
    INSERT INTO servicio (idTipoServicio, idEmpresaRecreacion)
    VALUES (@p_idTipoServicio, @p_idEmpresaRecreacion);
END;
GO


-- Procedures para eliminar
CREATE or ALTER PROCEDURE SP_EliminarHospedaje
  @id_hospedaje int
AS
BEGIN
  BEGIN try
    BEGIN transaction;
    delete FROM Factura 
    WHERE idReserva IN (SELECT idReserva FROM Reserva WHERE idEmpresaHospedaje = @id_hospedaje);
    delete FROM Reserva WHERE idEmpresaHospedaje = @id_hospedaje;
    delete FROM Habitacion WHERE idEmpresaHospedaje = @id_hospedaje;
    delete FROM ServiciosHospedaje WHERE idEmpresaHospedaje = @id_hospedaje;
    delete FROM Redes WHERE idEmpresaHospedaje = @id_hospedaje;
    delete FROM TelefonosEmpresa WHERE idEmpresaHospedaje = @id_hospedaje;
    delete FROM EmpresaHospedaje WHERE idEmpresaHospedaje = @id_hospedaje;
    commit transaction;
  END try
  BEGIN catch
    rollbaCK transaction;
    throw;
  END catch
END;
GO

CREATE or ALTER PROCEDURE SP_EliminarCliente
  @idCliente int
AS
BEGIN
  BEGIN try
    BEGIN transaction;
    delete FROM Factura 
    WHERE idReserva IN (SELECT idReserva FROM Reserva WHERE idCliente = @idCliente);
    delete FROM Reserva WHERE idCliente = @idCliente;
    delete FROM TelefonosCliente WHERE idCliente = @idCliente;
    delete FROM Cliente WHERE idCliente = @idCliente;
    commit transaction;
  END try
  BEGIN catch
    rollbaCK transaction;
    throw;
  END catch
END;
GO

CREATE or ALTER PROCEDURE SP_EliminarReserva
  @idReserva int
AS
BEGIN
  BEGIN try
    BEGIN transaction;
    delete FROM Factura WHERE idReserva = @idReserva;
    delete FROM Reserva WHERE idReserva = @idReserva;
    commit transaction;
  END try
  BEGIN catch
    rollbaCK transaction;
    throw;
  END catch
END;
GO

CREATE or ALTER PROCEDURE SP_EliminarFactura
  @idFactura int
AS
BEGIN
  delete FROM Factura WHERE idFactura = @idFactura;
END;
GO

CREATE or ALTER PROCEDURE SP_EliminarActividad
  @idActividad int
AS
BEGIN
  BEGIN try
    BEGIN transaction;
    delete FROM Actividad WHERE idActividad = @idActividad;
    commit transaction;
  END try
  BEGIN catch
    rollbaCK transaction;
    throw;
  END catch
END;
GO

CREATE or ALTER PROCEDURE SP_EliminarHabitacion
  @idHabitacion int
AS
BEGIN
  BEGIN try
    BEGIN transaction;
    DECLARE @idTipoHabitacion int;
    SELECT @idTipoHabitacion = idTipoHabitacion 
    FROM Habitacion 
    WHERE idHabitacion = @idHabitacion;
    delete FROM Factura 
    WHERE idReserva IN (SELECT idReserva FROM Reserva WHERE idHabitacion = @idHabitacion);
    delete FROM Reserva WHERE idHabitacion = @idHabitacion;
    delete FROM Habitacion WHERE idHabitacion = @idHabitacion;
    delete FROM FotosHabitacion WHERE idTipoHabitacion = @idTipoHabitacion;
    delete FROM Comodidades WHERE idTipoHabitacion = @idTipoHabitacion;
    delete FROM TipoHabitacion WHERE idTipo = @idTipoHabitacion;
    commit transaction;
  END try
  BEGIN catch
    rollbaCK transaction;
    throw;
  END catch
END;
GO


-- Procedures para actualizar
CREATE PROCEDURE SP_ActualizarHospedaje
  @id_hospedaje int,
  @nombre varchar(100),
  @cedulaJuridica varchar(15),
  @idTipoHospedaje int,
  @provincia varchar(30),
  @canton varchar(30),
  @distrito varchar(30),
  @barrio varchar(30),
  @senas varchar(100),
  @latitud decimal(10, 8),
  @longitud decimal(11, 8),
  @correo varchar(40)
AS
BEGIN
  update EmpresaHospedaje
  set nombre = @nombre,
      cedulaJuridica = @cedulaJuridica,
      idTipoHospedaje = @idTipoHospedaje,
      provincia = @provincia,
      canton = @canton,
      distrito = @distrito,
      barrio = @barrio,
      senas = @senas,
      latitud = @latitud,
      longitud = @longitud,
      correo = @correo
  WHERE idEmpresaHospedaje = @id_hospedaje;
END;
GO

CREATE PROCEDURE SP_ActualizarCliente
  @idCliente int,
  @nombre varchar(50),
  @apellido1 varchar(50),
  @apellido2 varchar(50),
  @fechaNacimiento date,
  @tipoIdentIFicacion varchar(20),
  @identIFicacion varchar(30),
  @pais varchar(30),
  @provincia varchar(30),
  @canton varchar(30),
  @distrito varchar(30),
  @correo varchar(40)
AS
BEGIN
  update Cliente
  set nombre = @nombre,
      apellido1 = @apellido1,
      apellido2 = @apellido2,
      fechaNacimiento = @fechaNacimiento,
      tipoIdentIFicacion = @tipoIdentIFicacion,
      identIFicacion = @identIFicacion,
      pais = @pais,
      provincia = @provincia,
      canton = @canton,
      distrito = @distrito,
      correo = @correo
  WHERE idCliente = @idCliente;
END;
GO

CREATE PROCEDURE SP_ActualizarReserva
  @idReserva int,
  @idCliente int,
  @idEmpresaHospedaje int,
  @idHabitacion int,
  @fechaIngreso datetime,
  @cantidadPersonAS int,
  @tieneVehiculo bit,
  @fechASalida date,
  @horASalida time
AS
BEGIN
  update Reserva
  set idCliente = @idCliente,
      idEmpresaHospedaje = @idEmpresaHospedaje,
      idHabitacion = @idHabitacion,
      fechaIngreso = @fechaIngreso,
      cantidadPersonAS = @cantidadPersonAS,
      tieneVehiculo = @tieneVehiculo,
      fechASalida = @fechASalida,
      horASalida = @horASalida
  WHERE idReserva = @idReserva;
END;
GO

CREATE PROCEDURE SP_ActualizarFactura
  @idFactura int,
  @idReserva int,
  @importeTotal decimal(10, 2),
  @formaPaGO varchar(20)
AS
BEGIN
  update Factura
  set idReserva = @idReserva,
      importeTotal = @importeTotal,
      formaPaGO = @formaPaGO
  WHERE idFactura = @idFactura;
END;
GO

CREATE PROCEDURE SP_ActualizarActividad
  @idActividad int,
  @idTipoActividad int,
  @idEmpresaRecreacion int,
  @descripcion varchar(150),
  @precio decimal(10, 2)
AS
BEGIN
  update Actividad
  set idTipoActividad = @idTipoActividad,
      idEmpresaRecreacion = @idEmpresaRecreacion,
      descripcion = @descripcion,
      precio = @precio
  WHERE idActividad = @idActividad;
END;
GO

CREATE PROCEDURE SP_ActualizarHabitacion
  @idHabitacion int,
  @idEmpresaHospedaje int,
  @numero int,
  @idTipoHabitacion int
AS
BEGIN
  -- Actualizar la información de la habitación
  update Habitacion
  set idEmpresaHospedaje = @idEmpresaHospedaje,
      numero = @numero,
      idTipoHabitacion = @idTipoHabitacion
  WHERE idHabitacion = @idHabitacion;
END;
GO

--Filtros estilo Airbnb
CREATE PROCEDURE SP_BuscarHospedajesPorProvincia (@provincia varchar(50))
AS
BEGIN
    SELECT * FROM VW_BusquedaHospedajes
    WHERE provincia = @provincia;
END
GO

CREATE PROCEDURE SP_BuscarHospedajesPorcanton (@canton varchar(50))
AS
BEGIN
    SELECT * FROM VW_BusquedaHospedajes
    WHERE canton = @canton;
END
GO

CREATE PROCEDURE SP_BuscarHospedajesPortipo (@TipoHospedaje varchar(50))
AS
BEGIN
    SELECT * FROM VW_BusquedaHospedajes
    WHERE TipoHospedaje = @TipoHospedaje;
END
GO

CREATE PROCEDURE SP_BuscarHospedajesPorServicios (@servicio1 varchar(50), @servicio2 varchar(50))
AS
BEGIN
    SELECT * FROM VW_BusquedaHospedajes
    WHERE servicios like '%' + @servicio1 + '%'
      and servicios like '%' + @servicio2 + '%';
END
GO

CREATE PROCEDURE SP_BuscarHospedajesPorPrecio (@precio_minimo decimal(10, 2), @precio_maximo decimal(10, 2))
AS
BEGIN
    SELECT * FROM VW_BusquedaHospedajes
    WHERE precio_minimo between @precio_minimo and @precio_maximo;
END
GO

CREATE PROCEDURE SP_BuscarHospedajesPorNombre (@nombreHotel varchar(100))
AS
BEGIN
    SELECT * FROM VW_BusquedaHospedajes
    WHERE nombreHotel like '%' + @nombreHotel + '%';
END
GO

CREATE PROCEDURE SP_BuscarHospedajesConFiltros (@provincia varchar(50), @canton varchar(50), @TipoHospedaje varchar(50), @servicio varchar(50), @precio_minimo decimal(10, 2), @precio_maximo decimal(10, 2))
AS
BEGIN
    SELECT * FROM VW_BusquedaHospedajes
    WHERE provincia = @provincia
      and canton = @canton
      and TipoHospedaje = @TipoHospedaje
      and servicios like '%' + @servicio + '%'
      and precio_minimo between @precio_minimo and @precio_maximo;
END
GO

CREATE PROCEDURE SP_BuscarFacturASPorFecha
    @fecha_inicio date,
    @fecha_fin date
AS
BEGIN
    SELECT * FROM VW_ReporteFacturacion
    WHERE fecha between @fecha_inicio and @fecha_fin;
END
GO

CREATE PROCEDURE SP_BuscarFacturASPorPaGO
    @formaPaGO varchar(50)
AS
BEGIN
    SELECT * FROM VW_ReporteFacturacion
    WHERE formaPaGO = @formaPaGO;
END
GO

CREATE PROCEDURE SP_BuscarFacturASPorimporte
    @importe_minimo decimal(10, 2),
    @importe_maximo decimal(10, 2)
AS
BEGIN
    SELECT * FROM VW_ReporteFacturacion
    WHERE importeTotal between @importe_minimo and @importe_maximo;
END
GO

CREATE PROCEDURE SP_BuscarFacturASPorTipoHabitacion
    @TipoHabitacion varchar(50)
AS
BEGIN
    SELECT * FROM VW_ReporteFacturacion
    WHERE TipoHabitacion = @TipoHabitacion;
END
GO

CREATE PROCEDURE SP_BuscarFacturASPorNumeroHabitacion
    @Habitacion int
AS
BEGIN
    SELECT * FROM VW_ReporteFacturacion
    WHERE Habitacion = @Habitacion;
END
GO

CREATE PROCEDURE SP_BuscarFacturASPorCliente
    @Cliente varchar(100)
AS
BEGIN
    SELECT * FROM VW_ReporteFacturacion
    WHERE Cliente like @Cliente;
END
GO

CREATE PROCEDURE SP_BuscarFacturASConFiltros
    @fecha_inicio date,
    @fecha_fin date,
    @TipoHabitacion varchar(50),
    @formaPaGO varchar(50),
    @importe_minimo decimal(10, 2)
AS
BEGIN
    SELECT * FROM VW_ReporteFacturacion
    WHERE fecha between @fecha_inicio and @fecha_fin
    and TipoHabitacion = @TipoHabitacion
    and formaPaGO = @formaPaGO
    and importeTotal > @importe_minimo;
END
GO

-- Filtro de Habitaciones por RanGO de FechAS y Comodidades
CREATE PROCEDURE SP_BuscarHabitacionesDisponiblesConFiltros
    @fecha_inicio DATE,
    @fecha_fin DATE,
    @idEmpresaHospedaje INT = NULL,
    @idTipoHabitacion INT = NULL,
    @precio_maximo DECIMAL(10,2) = NULL,
    @comodidad VARCHAR(50) = NULL
AS
BEGIN
    SELECT 
        h.idHabitacion,
        eh.nombre AS nombreHotel,
        th.nombre AS TipoHabitacion,
        th.precio,
        STRING_AGG(c.comodidad, ', ') AS Comodidades
    FROM Habitacion h
    JOIN EmpresaHospedaje eh ON h.idEmpresaHospedaje = eh.idEmpresaHospedaje
    JOIN TipoHabitacion th ON h.idTipoHabitacion = th.idTipo
    LEFT JOIN Comodidades c ON th.idTipo = c.idTipoHabitacion
    WHERE h.idHabitacion NOT IN (
        SELECT idHabitacion FROM Reserva 
        WHERE @fecha_inicio < fechASalida AND @fecha_fin > fechaIngreso
    )
    AND (@idEmpresaHospedaje IS NULL OR h.idEmpresaHospedaje = @idEmpresaHospedaje)
    AND (@idTipoHabitacion IS NULL OR h.idTipoHabitacion = @idTipoHabitacion)
    AND (@precio_maximo IS NULL OR th.precio <= @precio_maximo)
    AND (@comodidad IS NULL OR EXISTS (
        SELECT 1 FROM Comodidades c2 
        WHERE c2.idTipoHabitacion = th.idTipo AND c2.comodidad LIKE '%' + @comodidad + '%'
    ))
    GROUP BY h.idHabitacion, eh.nombre, th.nombre, th.precio;
END;
GO

-- Filtro de Actividades por Tipo, Precio y Ubicación
CREATE PROCEDURE SP_BuscarActividadesConFiltros
    @TipoActividad VARCHAR(50) = NULL,
    @precio_maximo DECIMAL(10,2) = NULL,
    @provincia VARCHAR(30) = NULL,
    @canton VARCHAR(30) = NULL
AS
BEGIN
    SELECT 
        a.idActividad,
        er.nombre AS empresa,
        ta.nombre AS TipoActividad,
        a.descripcion,
        a.precio,
        er.provincia,
        er.canton
    FROM Actividad a
    JOIN EmpresaRecreacion er ON a.idEmpresaRecreacion = er.idEmpresaRecreacion
    JOIN TipoActividad ta ON a.idTipoActividad = ta.idTipoActividad
    WHERE (@TipoActividad IS NULL OR ta.nombre LIKE '%' + @TipoActividad + '%')
    AND (@precio_maximo IS NULL OR a.precio <= @precio_maximo)
    AND (@provincia IS NULL OR er.provincia = @provincia)
    AND (@canton IS NULL OR er.canton = @canton);
END;
GO

--Búsqueda de FacturAS por IdentIFicación de Cliente
CREATE PROCEDURE SP_BuscarFacturASPorIdentIFicacion
    @identIFicacion VARCHAR(30)
AS
BEGIN
    SELECT 
        f.idFactura,
        r.idReserva,
        c.nombre + ' ' + c.apellido1 AS Cliente,
        c.identIFicacion,
        f.importeTotal,
        f.formaPaGO
    FROM Factura f
    JOIN Reserva r ON f.idReserva = r.idReserva
    JOIN Cliente c ON r.idCliente = c.idCliente
    WHERE c.identIFicacion = @identIFicacion;
END;
GO

CREATE PROCEDURE SP_ObtenerUltimaFacturaPorHabitacion
    @idHabitacion INT
AS
BEGIN
    SELECT 
        h.idHabitacion,
        h.numero AS numero_Habitacion,
        th.nombre AS TipoHabitacion,
        th.descripcion,
        th.tipoCama,
        th.precio,
        eh.nombre AS nombreHotel,
        f.idFactura,
        f.fecha AS fecha_Factura,
        f.importeTotal,
        f.formaPaGO,
        r.idReserva,
        c.nombre + ' ' + c.apellido1 + ' ' + c.apellido2 AS Cliente,
        r.fechaIngreso,
        r.fechASalida
    FROM Habitacion h
    JOIN TipoHabitacion th ON h.idTipoHabitacion = th.idTipo
    JOIN EmpresaHospedaje eh ON h.idEmpresaHospedaje = eh.idEmpresaHospedaje
    LEFT JOIN Reserva r ON h.idHabitacion = r.idHabitacion
    LEFT JOIN Factura f ON r.idReserva = f.idReserva
    LEFT JOIN Cliente c ON r.idCliente = c.idCliente
    WHERE h.idHabitacion = @idHabitacion
    AND f.idFactura = (
        SELECT TOP 1 idFactura 
        FROM Factura f2
        JOIN Reserva r2 ON f2.idReserva = r2.idReserva
        WHERE r2.idHabitacion = @idHabitacion
        ORDER BY f2.fecha DESC
    );
END;