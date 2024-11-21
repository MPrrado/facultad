CREATE TABLE participante(
id_participante INT PRIMARY KEY,
nombre VARCHAR(100) NOT NULL,
direccion VARCHAR(50) NOT NULL,
telefono VARCHAR(20));

CREATE TABLE pais(
id_pais INT PRIMARY KEY,
nombre VARCHAR(100) NOT NULL,
cantidad_clubes INT NOT NULL);

CREATE TABLE sala(
id_sala INT PRIMARY KEY,
capacidad INT NOT NULL);

CREATE TABLE jugador(
id_jugador INT PRIMARY KEY ,
nivel INT NOT NULL,
id_pais INT,
FOREIGN KEY (id_pais) REFERENCES pais(id_pais) ON DELETE NO ACTION ON UPDATE CASCADE,
FOREIGN KEY (id_jugador) REFERENCES participante(id_participante) ON DELETE NO ACTION ON UPDATE CASCADE );

CREATE TABLE arbitro(
id_arbitro INT PRIMARY KEY ,
academia VARCHAR(50) NOT NULL,
experiencia INT NOT NULL,
id_pais INT,
FOREIGN KEY (id_pais) REFERENCES pais(id_pais) ON DELETE NO ACTION ON UPDATE CASCADE,
FOREIGN KEY (id_arbitro) REFERENCES participante(id_participante) ON DELETE NO ACTION ON UPDATE CASCADE );

CREATE TABLE partida(
id_partida INT PRIMARY KEY,
fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
id_arbitro INT,
id_sala INT,
entradas INT NOT NULL,
FOREIGN KEY (id_arbitro) REFERENCES participante(id_participante) ON DELETE NO ACTION ON UPDATE CASCADE,
FOREIGN KEY (id_sala) REFERENCES sala(id_sala) ON DELETE NO ACTION ON UPDATE CASCADE );

CREATE TABLE juega(
id_partida INT,
id_jugador INT,
PRIMARY KEY (id_partida, id_jugador), -- asi para poder generar distintas pk's
color VARCHAR(30),
FOREIGN KEY (id_partida) REFERENCES partida(id_partida) ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY (id_jugador) REFERENCES jugador(id_jugador) ON DELETE NO ACTION ON UPDATE CASCADE
);

CREATE TABLE torneos(
id_jugador INT,
torneos VARCHAR(500),
PRIMARY KEY(id_jugador, torneos),
FOREIGN KEY (id_jugador) REFERENCES jugador(id_jugador) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE medios(
id_sala INT,
medio VARCHAR(50),
PRIMARY KEY(id_sala, medio),
FOREIGN KEY (id_sala) REFERENCES sala(id_sala) ON DELETE CASCADE ON UPDATE CASCADE
);


