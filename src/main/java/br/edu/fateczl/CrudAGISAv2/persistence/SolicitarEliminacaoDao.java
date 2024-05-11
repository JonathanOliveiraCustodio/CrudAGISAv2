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
import br.edu.fateczl.CrudAGISAv2.model.Matricula;

@Repository
public class SolicitarEliminacaoDao implements ISolicitarEliminacaoDao {

	private GenericDao gDao;

	public SolicitarEliminacaoDao(GenericDao gDao) {
		this.gDao = gDao;
	}

	@Override
	public String iudSolicitarEliminacao(String acao, Eliminacao e) throws SQLException, ClassNotFoundException {
		Connection c = gDao.getConnection();
		String sql = "{CALL sp_inserir_eliminacao (?,?,?,?)}";
		CallableStatement cs = c.prepareCall(sql);
	
		cs.setInt(1, e.getCodigoMatricula());
		cs.setInt(2, e.getCodigoDisciplina());
		cs.setString(3, e.getNomeInstituicao());
		cs.registerOutParameter(4, Types.VARCHAR);
		cs.execute();
		String saida = cs.getString(4);
		cs.close();
		c.close();

		return saida;
	}

	@Override
	public List<Disciplina> listarDisciplina(int RA) throws SQLException, ClassNotFoundException {
		List<Disciplina> listaDisciplinas = new ArrayList<>();
		Connection con = gDao.getConnection();
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT * FROM fn_listar_disciplinas_RA(?)");
		PreparedStatement ps = con.prepareStatement(sql.toString());
		ps.setInt(1, RA);
		ResultSet rs = ps.executeQuery();
		while (rs.next()) {

			Disciplina d = new Disciplina();
			d.setCodigo(rs.getInt("codigoDisciplina"));
			d.setNome(rs.getString("nomeDisciplina"));
			Matricula m = new Matricula();
			m.setCodigo(rs.getInt("codigoMatricula"));

			listaDisciplinas.add(d);
		}
		rs.close();
		ps.close();
		con.close();

		return listaDisciplinas;
	}

	// Usado
	public Aluno consultarAluno(Aluno a) throws SQLException, ClassNotFoundException {
		Connection con = gDao.getConnection();
		StringBuilder sql = new StringBuilder();
		sql.append("SELECT * FROM fn_consultar_aluno_RA(?) ");

		PreparedStatement ps = con.prepareStatement(sql.toString());
		ps.setInt(1, a.getRA());
		ResultSet rs = ps.executeQuery();
		if (rs.next()) {
			a.setCPF(rs.getString("CPF"));
			a.setNome(rs.getString("nome"));
			a.setNomeSocial(rs.getString("nomeSocial"));
			a.setDataNascimento(rs.getDate("dataNascimento"));
			a.setTelefoneContato(rs.getString("telefoneContato"));
			a.setEmailPessoal(rs.getString("emailPessoal"));
			a.setEmailCorporativo(rs.getString("emailCorporativo"));
			a.setDataConclusao2Grau(rs.getDate("dataConclusao2Grau"));
			a.setInstituicaoConclusao2Grau(rs.getString("instituicaoConclusao2Grau"));
			a.setPontuacaoVestibular(rs.getFloat("pontuacaoVestibular"));
			a.setPosicaoVestibular(rs.getInt("posicaoVestibular"));
			a.setAnoIngresso(rs.getInt("anoIngresso"));
			a.setSemestreIngresso(rs.getInt("semestreIngresso"));
			a.setSemestreAnoLimiteGraduacao(rs.getDate("semestreAnoLimiteGraduacao"));
			a.setRA(rs.getInt("RA"));

			Curso c = new Curso();
			c.setCodigo(rs.getInt("codigoCurso"));
			c.setNome(rs.getString("nomeCurso"));
			a.setCurso(c);

			rs.close();
			ps.close();
			con.close();
			return a;
		} else {
			rs.close();
			ps.close();
			con.close();
			return null;
		}
	}

	// @Override
	public List<Eliminacao> listarEliminacoes(int RA) throws SQLException, ClassNotFoundException {
		List<Eliminacao> eliminacoes = new ArrayList<>();
		Connection con = gDao.getConnection();
		StringBuffer sql = new StringBuffer();

		sql.append("SELECT * FROM fn_lista_eliminacoes_por_RA(?) ");
		PreparedStatement ps = con.prepareStatement(sql.toString());
		ps.setInt(1, RA);
		ResultSet rs = ps.executeQuery();
		while (rs.next()) {

			Eliminacao e = new Eliminacao();
			e.setCodigo(rs.getInt("RA"));
			e.setDataEliminacao(rs.getDate("dataEliminacao"));
			e.setStatus(rs.getString("status"));
			e.setNomeInstituicao(rs.getString("nomeInstituicao"));
			
			Matricula m = new Matricula();
			m.setCodigo(rs.getInt("codigoMatricula"));
			
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

	@Override
	public Eliminacao consultar(Eliminacao e) throws SQLException, ClassNotFoundException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Eliminacao> listar() throws SQLException, ClassNotFoundException {
		// TODO Auto-generated method stub
		return null;
	}

}
