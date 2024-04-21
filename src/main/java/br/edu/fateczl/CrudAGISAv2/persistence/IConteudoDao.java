package br.edu.fateczl.CrudAGISAv2.persistence;

import java.sql.SQLException;
import br.edu.fateczl.CrudAGISAv2.model.Conteudo;


public interface IConteudoDao {
	
	public String iudConteudo (String acao, Conteudo c) throws SQLException, ClassNotFoundException;

}
