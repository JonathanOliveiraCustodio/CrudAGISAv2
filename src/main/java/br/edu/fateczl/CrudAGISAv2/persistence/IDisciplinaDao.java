package br.edu.fateczl.CrudAGISAv2.persistence;

import java.sql.SQLException;
import br.edu.fateczl.CrudAGISAv2.model.Disciplina;

public interface IDisciplinaDao {
	
	public String iudDisciplina (String acao, Disciplina d) throws SQLException, ClassNotFoundException;

}
