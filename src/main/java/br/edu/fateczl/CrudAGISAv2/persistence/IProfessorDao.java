package br.edu.fateczl.CrudAGISAv2.persistence;

import java.sql.SQLException;
import br.edu.fateczl.CrudAGISAv2.model.Professor;

public interface IProfessorDao {
	
	public String iudProfessor (String acao, Professor p) throws SQLException, ClassNotFoundException;
	

}
