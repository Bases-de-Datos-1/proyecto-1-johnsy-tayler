USE master;
GO

IF exists (SELECT NAME FROM sys.DATABASEs WHERE NAME = 'GestionHotelera') 
BEGIN
    -- Forzar el modo de un solo usuario y cerrar conexiones activAS
    ALTER DATABASE GestionHotelera SET SINGLE_USER WITH ROLLBACK IMMEDIATE;

    -- Eliminar la bASe de datos
    DROP DATABASE GestionHotelera;
END
GO

CREATE DATABASE GestionHotelera;
GO

USE GestionHotelera;
GO

CREATE TABLE TipoHospedaje (
    idTipoHospedaje int identity(1,1) primary key,
    nombre varchar(50) not null
);

CREATE TABLE EmpresaHospedaje (
    idEmpresaHospedaje int identity(1,1) primary key,
    nombre varchar(100) not null,
    cedulaJuridica varchar(15) unique not null,
    idTipoHospedaje int not null,
    provincia varchar(30) not null,
    canton varchar(30) not null,
    distrito varchar(30) not null,
    barrio varchar(30),
    senas varchar(100) not null,
    latitud decimal(10, 8),
    longitud decimal(11, 8),
    correo varchar(40) unique,
    constraint FK_EmpresaHospedaje_TipoHospedaje 
    foreign key (idTipoHospedaje) references TipoHospedaje(idTipoHospedaje)
);

CREATE TABLE TelefonosEmpresa (
    idTelefono int identity(1,1) primary key,
    idEmpresaHospedaje int not null,
    numero varchar(20) not null,
    constraint FK_TelefonosEmpresa_EmpresaHospedaje 
    foreign key (idEmpresaHospedaje) references EmpresaHospedaje(idEmpresaHospedaje)
);

CREATE TABLE TipoRedSocial (
    idTipoRed int identity(1,1) primary key,
    nombre varchar(30) not null
);

CREATE TABLE Redes (
    idRed int identity(1,1) primary key,
    idEmpresaHospedaje int not null,
    idTipoRed int not null,
    url varchar(200) not null,
    constraint FK_Redes_EmpresaHospedaje 
    foreign key (idEmpresaHospedaje) references EmpresaHospedaje(idEmpresaHospedaje),
    constraint FK_Redes_TipoRedSocial 
    foreign key (idTipoRed) references TipoRedSocial(idTipoRed)
);

CREATE TABLE TipoServicioHospedaje (
    idTipoServicio int identity(1,1) primary key,
    nombre varchar(50) not null
);

CREATE TABLE ServiciosHospedaje (
    idServicio int identity(1,1) primary key,
    idEmpresaHospedaje int not null,
    idTipoServicio int not null,
    constraint FK_Serv_Hosp_Empresa 
    foreign key (idEmpresaHospedaje) references EmpresaHospedaje(idEmpresaHospedaje),
    constraint FK_Serv_Hosp_Tipo_Serv 
    foreign key (idTipoServicio) references TipoServicioHospedaje(idTipoServicio)
);

CREATE TABLE TipoHabitacion (
    idTipo int identity(1,1) primary key,
    nombre varchar(50) not null,
    descripcion varchar(150) not null,
    tipoCama varchar(50) not null,
    precio decimal(10, 2) check (precio >= 0) not null
);

CREATE TABLE Comodidades (
    idComodidad int identity(1,1) primary key,
    idTipoHabitacion int not null,
    comodidad varchar(50) not null,
    constraint FK_ComodidadTipoHab 
    foreign key (idTipoHabitacion) references TipoHabitacion(idTipo)
);

CREATE TABLE FotosHabitacion (
    idFoto int identity(1,1) primary key,
    idTipoHabitacion int not null,
    url varchar(200) not null,
    constraint FK_Foto_Tipo_Hab 
    foreign key (idTipoHabitacion) references TipoHabitacion(idTipo)
);

CREATE TABLE Habitacion (
    idHabitacion int identity(1,1) primary key,
    idEmpresaHospedaje int not null,
    numero int check (numero > 0) not null,
    idTipoHabitacion int not null,
    constraint UQ_Habitacion_numero_empresa unique (idEmpresaHospedaje, numero),
    constraint FK_Habitacion_TipoHabitacion 
    foreign key (idTipoHabitacion) references TipoHabitacion(idTipo),
    constraint FK_Habitacion_EmpresaHospedaje 
    foreign key (idEmpresaHospedaje) references EmpresaHospedaje(idEmpresaHospedaje)
);

CREATE TABLE Cliente (
    idCliente int identity(1,1) primary key,
    nombre varchar(50) not null,
    apellido1 varchar(50) not null,
    apellido2 varchar(50) not null,
    fechaNacimiento date not null,
    tipoIdentIFicacion varchar(20) not null,
    identIFicacion varchar(30) unique not null,
    pais varchar(30) not null,
    provincia varchar(30),
    canton varchar(30),
    distrito varchar(30),
    correo varchar(40) unique not null,
    constraint CK_Provincia check (
        (pais != 'Costa Rica') or (pais = 'Costa Rica' and provincia is not null)
    ),
    constraint CK_Canton check (
        (pais != 'Costa Rica') or (pais = 'Costa Rica' and canton is not null)
    ),
    constraint CK_Distrito check (
        (pais != 'Costa Rica') or (pais = 'Costa Rica' and distrito is not null)
    )
);

CREATE TABLE TelefonosCliente (
    idTelefono int identity(1,1) primary key,
    idCliente int not null,
    numero varchar(20) not null,
    constraint FK_Tel_Cliente_Cliente 
    foreign key (idCliente) references Cliente(idCliente)
);

CREATE TABLE Reserva (
    idReserva int identity(10000000,1) primary key,
    idCliente int not null,
    idEmpresaHospedaje int not null,
    idHabitacion int not null,
    fechaIngreso datetime not null,
    cantidadPersonAS int not null,
    tieneVehiculo bit not null,
    fechASalida date not null,
    horASalida time not null constraint DF_Reserva_horASalida default '12:00:00',
    constraint idReserva 
	foreign key (idReserva) references Reserva(idReserva),
    constraint FK_Reserva_Cliente 
    foreign key (idCliente) references Cliente(idCliente),
    constraint FK_Reserva_Habitacion 
    foreign key (idHabitacion) references Habitacion(idHabitacion),
    constraint FK_Reserva_EmpresaHospedaje 
    foreign key (idEmpresaHospedaje) references EmpresaHospedaje(idEmpresaHospedaje),
    constraint CK_Fechas_Reserva check (fechASalida >= fechaIngreso),
	constraint CK_Hora_Salida_Maxima check (horASalida <= '12:00:00')
);

CREATE TABLE Factura (
    idFactura int identity(1000, 1) primary key,
    idReserva int not null,
    fecha datetime not null constraint DF_Factura_Fecha default getdate(),
    importeTotal decimal(10, 2) not null,
    formaPaGO varchar(20) not null,
    constraint FK_Factura_Reserva 
    foreign key (idReserva) references Reserva(idReserva)
);

CREATE TABLE EmpresaRecreacion (
    idEmpresaRecreacion int identity(1,1) primary key,
    nombre varchar(100) not null,
    cedulaJuridica varchar(15) unique not null,
    correo varchar(40) unique not null,
    telefono varchar(20) not null,
    encargado varchar(100) not null,
    provincia varchar(30) not null,
    canton varchar(30) not null,
    distrito varchar(30) not null,
    senas varchar(100) not null,
    latitud decimal(10, 8),
    longitud decimal(11, 8)
);

CREATE TABLE TipoActividad (
    idTipoActividad int identity(1,1) primary key,
    nombre varchar(50) not null
);

CREATE TABLE Actividad (
    idActividad int identity(1,1) primary key,
    idTipoActividad int not null,
    idEmpresaRecreacion int not null,
    descripcion varchar(150) not null,
    precio decimal(10, 2) not null check (precio >= 0),
    constraint FK_Actividad_TipoActividad 
    foreign key (idTipoActividad) references TipoActividad(idTipoActividad),
    constraint FK_Actividad_EmpresaRecreacion 
    foreign key (idEmpresaRecreacion) references EmpresaRecreacion(idEmpresaRecreacion)
);

CREATE TABLE TipoServicio (
    idTipoServicio int identity(1,1) primary key,
    nombre varchar(50) not null
);

CREATE TABLE Servicio (
    idServicio int identity(1,1) primary key,
    idTipoServicio int not null,
    idEmpresaRecreacion int not null,
    constraint FK_Servicio_Tipo_Servicio 
    foreign key (idTipoServicio) references TipoServicio(idTipoServicio),
    constraint FK_Servicio_Empresa_Rec 
    foreign key (idEmpresaRecreacion) references EmpresaRecreacion(idEmpresaRecreacion)
);