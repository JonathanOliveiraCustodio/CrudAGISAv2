package br.edu.fateczl.CrudAGISAv2.persistence;

import java.sql.SQLException;
import br.edu.fateczl.CrudAGISAv2.model.Aluno;
import br.edu.fateczl.CrudAGISAv2.model.Telefone;

public interface ITelefoneDao {

	String iudTelefone(String acao, Telefone t, Aluno a) throws SQLException, ClassNotFoundException;
	

}
