package br.edu.fateczl.CrudAGISAv2.persistence;

import java.sql.SQLException;

import br.edu.fateczl.CrudAGISAv2.model.Aluno;



public interface IAlunoDao {
	
	public String iudAluno(String acao, Aluno a) throws SQLException, ClassNotFoundException;
	

}
