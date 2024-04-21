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

import br.edu.fateczl.CrudAGISAv2.model.Conteudo;
import br.edu.fateczl.CrudAGISAv2.model.Disciplina;

@Repository
public class ConteudoDao implements ICrud<Conteudo>, IConteudoDao {

	private GenericDao gDao;

	public ConteudoDao(GenericDao gDao) {
		this.gDao = gDao;
	}

	@Override
	public Conteudo consultar(Conteudo c) throws SQLException, ClassNotFoundException {
		Connection con = gDao.getConnection();
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT c.codigo AS codigoConteudo, c.nome AS nomeConteudo, c.descricao AS descricaoConteudo, d.nome AS nomeDisciplina, ");
		sql.append("d.codigo AS codigoDisciplina, d.nome AS nomeDisciplina  ");
		sql.append("FROM conteudo c JOIN disciplina d ON c.codigoDisciplina = d.codigo ");
		sql.append("WHERE c.codigo = ? ");

		PreparedStatement ps = con.prepareStatement(sql.toString());
		ps.setInt(1, c.getCodigo());
		ResultSet rs = ps.executeQuery();
		if (rs.next()) {

			Disciplina d = new Disciplina();
			d.setCodigo(rs.getInt("codigoDisciplina"));
			d.setNome(rs.getString("nomeDisciplina"));

			c.setCodigo(rs.getInt("codigoConteudo"));
			c.setNome(rs.getString("nomeConteudo"));
			c.setDescricao(rs.getString("descricaoConteudo"));
			c.setDisciplina(d);

			rs.close();
	        ps.close();
	        con.close();
	        return c;
	    } else {
	        rs.close();
	        ps.close();
	        con.close();
	        return null;
	    }
	}

	@Override
	public List<Conteudo> listar() throws SQLException, ClassNotFoundException {
		List<Conteudo> conteudos = new ArrayList<>();
		Connection con = gDao.getConnection();
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT c.codigo AS codigoConteudo, c.nome AS nomeConteudo, c.descricao AS descricaoConteudo, d.nome AS nomeDisciplina  ");
		sql.append("FROM conteudo c JOIN disciplina d ON c.codigoDisciplina = d.codigo ");
		PreparedStatement ps = con.prepareStatement(sql.toString());
		ResultSet rs = ps.executeQuery();
		while (rs.next()) {
			Disciplina d = new Disciplina();
			d.setNome(rs.getString("nomeDisciplina"));
			Conteudo c = new Conteudo();
			c.setCodigo(rs.getInt("codigoConteudo"));
			c.setNome(rs.getString("nomeConteudo"));
			c.setDescricao(rs.getString("descricaoConteudo"));
			c.setDisciplina(d);
			conteudos.add(c);
		}
		rs.close();
		ps.close();
		con.close();

		return conteudos;
	}

	@Override
	public String iudConteudo(String acao, Conteudo c) throws SQLException, ClassNotFoundException {
		Connection con = gDao.getConnection();
		String sql = "{CALL sp_iud_conteudo (?,?,?,?,?,?)}";
		CallableStatement cs = con.prepareCall(sql);
		cs.setString(1, acao);
		cs.setInt(2, c.getCodigo());
		cs.setString(3, c.getNome());
		cs.setString(4, c.getDescricao());	
		cs.setInt(5, c.getDisciplina().getCodigo());
		cs.registerOutParameter(6, Types.VARCHAR);
		cs.execute();
		String saida = cs.getString(6);
		cs.close();
		con.close();

		return saida;
	}

}
