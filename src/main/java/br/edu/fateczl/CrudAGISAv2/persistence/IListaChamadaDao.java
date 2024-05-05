package br.edu.fateczl.CrudAGISAv2.persistence;

import java.sql.SQLException;

import br.edu.fateczl.CrudAGISAv2.model.ListaChamada;


public interface IListaChamadaDao {
	
	public String iudListaChamada(String acao, ListaChamada lc) throws SQLException, ClassNotFoundException;
	
	

}
