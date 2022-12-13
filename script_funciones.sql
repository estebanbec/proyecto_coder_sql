-- Primera Función: Esta función nos permitirá conocer cual sería el interés mensual que se debería abonar si 
-- se tomara todo el capital de todos los plazos fijos invertidos y se invirtieran a una tasa determinada
-- por el usuario. Le permitirá conocer a la entidad cuáles son los intereses a afrontar en caso que la misma
-- desee abordar un cambio de tasa para ser más competitivo en el mercado.

DELIMITER $$
CREATE FUNCTION `calculo_intereses`(tasa INT) RETURNS double
    DETERMINISTIC
BEGIN
	DECLARE nuevos_intereses DOUBLE;
    SET nuevos_intereses = ((SELECT SUM(capital) FROM plazos_fijos) * (tasa / 12 / 100));
RETURN nuevos_intereses;
END$$
DELIMITER ;

SELECT calculo_intereses (75) AS total_intereses;


-- Función 2: Capital necesario a partir de intereses esperado, nos permitirá conocer cuál es la suma
-- de capital que deberá captarse por parte de inversores/clientes para que al aplicar determinada tasa, pueda arribarse
-- a los intereses esperados, también ingresados como parámetro

DELIMITER $$
CREATE FUNCTION `calculo_capital_necesario`(tasa INT, intereses DOUBLE) RETURNS double
    DETERMINISTIC
BEGIN
	DECLARE capital_esperado DOUBLE;
    SET capital_esperado = (intereses / (tasa / 12 /100) );
	RETURN capital_esperado;
END$$
DELIMITER ;

SELECT calculo_capital_necesario (90, 100000) as Capital_Necesario;