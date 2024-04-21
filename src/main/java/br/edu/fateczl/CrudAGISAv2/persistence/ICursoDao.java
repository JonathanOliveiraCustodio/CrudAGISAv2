package br.edu.fateczl.CrudAGISAv2.persistence;

import java.sql.SQLException;

import br.edu.fateczl.CrudAGISAv2.model.Curso;

public interface ICursoDao {
	
	public String iudCurso (String acao, Curso c) throws SQLException, ClassNotFoundException;

}
