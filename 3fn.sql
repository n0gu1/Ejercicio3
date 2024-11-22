CREATE DATABASE IF NOT EXISTS LigaFootball;
USE LigaFootball;

CREATE TABLE Estadio (
    EstadioID INT PRIMARY KEY,
    NombreEstadio VARCHAR(20) NOT NULL,
    Ciudad VARCHAR(20),
    Capacidad INT,
    AnioConstruccion YEAR
);

CREATE TABLE Equipos (
    EquipoID INT PRIMARY KEY,
    NombreEquipo VARCHAR(20) NOT NULL,
    Ciudad VARCHAR(20),
    FechaFundacion YEAR,
    EstadioID INT,
    Entrenador VARCHAR(20),
    FOREIGN KEY (EstadioID) REFERENCES Estadio(EstadioID)
);

CREATE TABLE Arbitros (
    ArbitroID INT PRIMARY KEY,
    Nombre VARCHAR(20) NOT NULL,
    Apellido VARCHAR(20) NOT NULL,
    Nacionalidad VARCHAR(20),
    AniosExperiencia INT
);

CREATE TABLE Jugadores (
    JugadorID INT PRIMARY KEY,
    Nombre VARCHAR(20) NOT NULL,
    Apellido VARCHAR(20) NOT NULL,
    FechaNacimiento DATE,
    Nacionalidad VARCHAR(20),
    Posicion VARCHAR(20),
    EquipoID INT,
    FOREIGN KEY (EquipoID) REFERENCES Equipos(EquipoID)
);

CREATE TABLE AsignacionCamisetas (
    EquipoID INT,
    NumeroCamiseta INT,
    JugadorID INT,
    PRIMARY KEY (EquipoID, NumeroCamiseta),
    FOREIGN KEY (EquipoID) REFERENCES Equipos(EquipoID),
    FOREIGN KEY (JugadorID) REFERENCES Jugadores(JugadorID)
);

CREATE TABLE Partidos (
    PartidoID INT PRIMARY KEY,
    FechaPartido DATE,
    EquipoLocalID INT,
    EquipoVisitanteID INT,
    EstadioID INT,
    ArbitroID INT,
    Resultado VARCHAR(10),
    Asistencia INT,
    FOREIGN KEY (EquipoLocalID) REFERENCES Equipos(EquipoID),
    FOREIGN KEY (EquipoVisitanteID) REFERENCES Equipos(EquipoID),
    FOREIGN KEY (EstadioID) REFERENCES Estadio(EstadioID),
    FOREIGN KEY (ArbitroID) REFERENCES Arbitros(ArbitroID)
);

-- Crear la tabla EstadisticasJugadores
CREATE TABLE EstadisticasJugadores (
    JugadorID INT,
    PartidoID INT,
    MinutosJugados INT,
    GolesAnotados INT,
    Asistencias INT,
    TarjetasAmarillas INT,
    TarjetasRojas INT,
    PRIMARY KEY (JugadorID, PartidoID),
    FOREIGN KEY (JugadorID) REFERENCES Jugadores(JugadorID),
    FOREIGN KEY (PartidoID) REFERENCES Partidos(PartidoID)
);

CREATE TABLE Clasificacion (
    EquipoID INT PRIMARY KEY,
    PartidosJugados INT,
    PartidosGanados INT,
    PartidosEmpatados INT,
    PartidosPerdidos INT,
    GolesAFavor INT,
    GolesEnContra INT,
    FOREIGN KEY (EquipoID) REFERENCES Equipos(EquipoID)
);

CREATE TABLE Goles (
    PartidoID INT,
    JugadorID INT,
    MinutoGol INT,
    EquipoBeneficiadoID INT,
    TipoGol VARCHAR(20),
    PRIMARY KEY (PartidoID, JugadorID, MinutoGol),
    FOREIGN KEY (PartidoID) REFERENCES Partidos(PartidoID),
    FOREIGN KEY (JugadorID) REFERENCES Jugadores(JugadorID),
    FOREIGN KEY (EquipoBeneficiadoID) REFERENCES Equipos(EquipoID)
);
