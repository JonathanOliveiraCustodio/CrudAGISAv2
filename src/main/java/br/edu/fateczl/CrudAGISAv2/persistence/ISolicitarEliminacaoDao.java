package br.edu.fateczl.CrudAGISAv2.persistence;

import java.sql.SQLException;
import java.util.List;

import br.edu.fateczl.CrudAGISAv2.model.Disciplina;
import br.edu.fateczl.CrudAGISAv2.model.Eliminacao;

public interface ISolicitarEliminacaoDao {
	
	public Eliminacao consultar(Eliminacao e) throws SQLException, ClassNotFoundException;
	public List<Eliminacao> listar() throws SQLException, ClassNotFoundException;
	
	public List<Disciplina> listarDisciplina(int RA) throws SQLException, ClassNotFoundException;
	
	public String iudSolicitarEliminacao (String acao, Eliminacao e) throws SQLException, ClassNotFoundException;

}
