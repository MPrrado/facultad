CREATE TABLE parentesco(
id_parentesco INT AUTO_INCREMENT,
PRIMARY KEY (id_parentesco),
parentesco VARCHAR(50)
);
TRUNCATE parentesco; -- me resetea las id, funciona como el DELETE sin WHERE pero este hace ese extra de las id´s

INSERT INTO parentesco (parentesco)
SELECT DISTINCT(parentesco) FROM familiar;
rollback;


ALTER TABLE familiar
	ADD id_parentesco INT,
    ADD CONSTRAINT fk_parentesco FOREIGN KEY (id_parentesco) REFERENCES parentesco(id_parentesco); -- no hace falta poner fk_parentesco, es un identificador para la constraint por temas de simplicidad a la hora de errores

UPDATE familiar f
INNER JOIN  parentesco p ON p.parentesco = f.parentesco
SET f.id_parentesco = p.id_parentesco;

start transaction;
ALTER TABLE familiarparentesco
	DROP COLUMN parentesco;
    
    
	


 
