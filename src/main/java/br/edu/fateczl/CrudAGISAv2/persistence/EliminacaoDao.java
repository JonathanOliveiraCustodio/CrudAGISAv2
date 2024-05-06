package br.edu.fateczl.CrudAGISAv2.persistence;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Repository;

import br.edu.fateczl.CrudAGISAv2.model.Aluno;
import br.edu.fateczl.CrudAGISAv2.model.Curso;
import br.edu.fateczl.CrudAGISAv2.model.Disciplina;
import br.edu.fateczl.CrudAGISAv2.model.Eliminacao;

@Repository
public class EliminacaoDao implements ICrud<Eliminacao> {

	private GenericDao gDao;

	public EliminacaoDao(GenericDao gDao) {
		this.gDao = gDao;
	}

	@Override
	public Eliminacao consultar(Eliminacao e) throws SQLException, ClassNotFoundException {
		Connection con = gDao.getConnection();
		StringBuffer sql = new StringBuffer();
		
		sql.append("SELECT * FROM fn_buscar_eliminacao(?)");

		PreparedStatement ps = con.prepareStatement(sql.toString());
		ps.setInt(1, e.getCodigo());
		ResultSet rs = ps.executeQuery();
		if (rs.next()) {

			Aluno a = new Aluno();
			a.setCPF(rs.getString("cpfAluno"));
			a.setNome(rs.getString("nomeAluno"));
			
			Disciplina d = new Disciplina();
			d.setCodigo(rs.getInt("codigoDisciplina"));
			d.setNome(rs.getString("nomeDisciplina"));
			
			Curso c = new Curso();
			c.setCodigo(rs.getInt("codigoCurso"));
			c.setNome(rs.getString("nomeCurso"));

			e.setCodigo(rs.getInt("codigo"));
			e.setCodigoMatricula(rs.getInt("codigoMatricula"));
			e.setCodigoDisciplina(rs.getInt("codigoDisciplina"));			
			e.setDataEliminacao(rs.getDate("dataEliminacao"));
			e.setStatus(rs.getString("status"));
			e.setNomeInstituicao(rs.getString("nomeInstituicao"));

			e.setAluno(a);
			e.setDisciplina(d);
			e.setCurso(c);

			rs.close();
	        ps.close();
	        con.close();
	        return e;
	    } else {
	        rs.close();
	        ps.close();
	        con.close();
	        return null;
	    }
	}

	@Override
	public List<Eliminacao> listar() throws SQLException, ClassNotFoundException {
		List<Eliminacao> eliminacoes = new ArrayList<>();
		Connection con = gDao.getConnection();
		StringBuffer sql = new StringBuffer();
		
		sql.append("SELECT * FROM fn_lista_eliminacoes() ");
		PreparedStatement ps = con.prepareStatement(sql.toString());
		ResultSet rs = ps.executeQuery();
		while (rs.next()) {
		
			Eliminacao e = new Eliminacao();
			e.setCodigo(rs.getInt("codigo"));
			e.setDataEliminacao(rs.getDate("dataEliminacao"));
			e.setStatus(rs.getString("status"));
			e.setNomeInstituicao(rs.getString("nomeInstituicao"));
			
			Aluno a = new Aluno();
			a.setNome(rs.getString("nomeAluno"));
			Curso c = new Curso();
			c.setNome(rs.getString("nomeCurso"));
			Disciplina d = new Disciplina();
			d.setNome(rs.getString("nomeDisciplina"));
			
			e.setAluno(a);
			e.setCurso(c);
			e.setDisciplina(d);
			eliminacoes.add(e);
		}
		rs.close();
		ps.close();
		con.close();

		return eliminacoes;
	}


	public String iudEliminacao(String acao, Eliminacao c) throws SQLException, ClassNotFoundException {
		Connection con = gDao.getConnection();
		String sql = "{CALL sp_iud_eliminacao (?,?,?,?,?,?,?,?)}";
		CallableStatement cs = con.prepareCall(sql);
		cs.setString(1, acao);
		cs.setInt(2, c.getCodigo());
		cs.setInt(3, c.getCodigoMatricula());
		cs.setInt(4, c.getCodigoDisciplina());
		cs.setDate(5, c.getDataEliminacao());
		cs.setString(6, c.getStatus());
		cs.setString(7, c.getNomeInstituicao());
		cs.registerOutParameter(8, Types.VARCHAR);
		cs.execute();
		String saida = cs.getString(8);
		cs.close();
		con.close();

		return saida;
	}

}
