CREATE OR REPLACE FUNCTION altera_cpf_function() RETURNS trigger AS $$

	BEGIN
		IF NEW.cpf <> OLD.cpf THEN
		RAISE EXCEPTION 'O CPF não deve ser alterado! Horário: %', now();
		END IF;
		
		NEW.cpf := OLD.cpf;
		
		RETURN NEW;
	END;
	
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS altera_cpf_trigger ON aluno;
CREATE TRIGGER altera_cpf_trigger 
BEFORE UPDATE ON aluno
FOR EACH ROW
EXECUTE PROCEDURE altera_cpf_function();


INSERT INTO aluno (nome, cpf, rg, data_nascimento, sexo, mae, celular, tipo_sanguineo, altura, peso, id_cidade, id_signo)
VALUES 
('Gabriel Felix Faustina', '123.456.789-12', '12.345.678-9', '2004-09-23',
'M', 'Ana Paula', '(48) 12312-2345', 'O-', 1.70, 75.0, 12, 1);

SELECT 
	*
FROM aluno
WHERE aluno.id = 197

UPDATE aluno SET nome = 'Gabriel Felix Faustina', cpf = '123.456.789-12'
WHERE id = 197; 
