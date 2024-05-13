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
import br.edu.fateczl.CrudAGISAv2.model.Matricula;


@Repository
public class AlunoDao implements ICrud<Aluno>, IAlunoDao {

	private GenericDao gDao;

	public AlunoDao(GenericDao gDao) {
		this.gDao = gDao;
	}

	@Override
	public Aluno consultar(Aluno a) throws SQLException, ClassNotFoundException {
	    Connection con = gDao.getConnection();
	    StringBuilder sql = new StringBuilder();
	    sql.append("SELECT a.CPF, a.nome, a.nomeSocial, a.dataNascimento, a.telefoneContato, ");
	    sql.append("a.emailPessoal, a.emailCorporativo, a.dataConclusao2Grau, a.instituicaoConclusao2Grau, ");
	    sql.append("a.pontuacaoVestibular, a.posicaoVestibular, a.anoIngresso, a.semestreIngresso, ");
	    sql.append("a.semestreAnoLimiteGraduacao, a.RA, c.codigo AS codigoCurso, c.nome AS nomeCurso ");
	    sql.append("FROM aluno a ");
	    sql.append("JOIN curso c ON a.curso = c.codigo ");
	    sql.append("WHERE a.CPF = ?");

	    PreparedStatement ps = con.prepareStatement(sql.toString());
	    ps.setString(1, a.getCPF());
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
	
	public Aluno consultarPorRA(Aluno a) throws SQLException, ClassNotFoundException {
	    Connection con = gDao.getConnection();
	    StringBuilder sql = new StringBuilder();
	    sql.append("SELECT a.CPF, a.nome, a.nomeSocial, a.dataNascimento, a.telefoneContato, ");
	    sql.append("a.emailPessoal, a.emailCorporativo, a.dataConclusao2Grau, a.instituicaoConclusao2Grau, ");
	    sql.append("a.pontuacaoVestibular, a.posicaoVestibular, a.anoIngresso, a.semestreIngresso, ");
	    sql.append("a.semestreAnoLimiteGraduacao, a.RA, c.codigo AS codigoCurso, c.nome AS nomeCurso ");
	    sql.append("FROM aluno a ");
	    sql.append("JOIN curso c ON a.curso = c.codigo ");
	    sql.append("WHERE a.RA = ?");

	    PreparedStatement ps = con.prepareStatement(sql.toString());
	    ps.setLong(1, a.getRA());
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


	@Override
	public List<Aluno> listar() throws SQLException, ClassNotFoundException {

		List<Aluno> alunos = new ArrayList<>();
	    Connection con = gDao.getConnection();
	    
	    StringBuffer sql = new StringBuffer();
	    sql.append("SELECT * FROM v_listarAluno ");

	    PreparedStatement ps = con.prepareStatement(sql.toString());
	    ResultSet rs = ps.executeQuery();

	    while (rs.next()) {
	    	Aluno a = new Aluno();    
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
		    c.setNome(rs.getString("nomeCurso"));
	        a.setCurso(c);
	        
	        alunos.add(a);
	    }

	    rs.close();
	    ps.close();
	    con.close();
	    
	    return alunos;
	}

	@Override

	public String iudAluno(String acao, Aluno a) throws SQLException, ClassNotFoundException {
		Connection c = gDao.getConnection();
		String sql = "{CALL sp_iud_aluno (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}";
		CallableStatement cs = c.prepareCall(sql);
		cs.setString(1, acao);
		cs.setString(2, a.getCPF());
		cs.setString(3, a.getNome());
		cs.setString(4, a.getNomeSocial());    
		cs.setDate(5, a.getDataNascimento());
		cs.setString(6, a.getTelefoneContato());
		cs.setString(7, a.getEmailPessoal());
		cs.setString(8, a.getEmailCorporativo());		
		cs.setDate(9, a.getDataConclusao2Grau());
		cs.setString(10, a.getInstituicaoConclusao2Grau());
		cs.setFloat(11, a.getPontuacaoVestibular());
		cs.setInt(12, a.getPosicaoVestibular());
		cs.setInt(13, a.getAnoIngresso());
		cs.setInt(14, a.getSemestreIngresso());
		cs.setDate(15, a.getSemestreAnoLimiteGraduacao());		
		cs.setInt(16, a.getRA());
		cs.setInt(17, a.getCurso().getCodigo());
		cs.registerOutParameter(18, Types.VARCHAR);
		cs.execute();
		String saida = cs.getString(18);
		cs.close();
		c.close();

		return saida;
	}

	public Aluno construirCabecalhoHistorico(String cpf) throws ClassNotFoundException, SQLException {
		Aluno a = new Aluno();
		
		Connection c = gDao.getConnection();
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT * FROM fn_cabecalho_historico(?)");
		PreparedStatement ps = c.prepareStatement(sql.toString());
		ps.setString(1, cpf);
		ResultSet rs = ps.executeQuery();
		if (rs.next()) {
			a.setCPF(cpf);
			a.setRA(rs.getInt("RA"));
			a.setNome(rs.getString("nome"));
			a.setPontuacaoVestibular(rs.getFloat("pontuacaoVestibular"));
			a.setPosicaoVestibular(rs.getInt("posicaoVestibular"));
			
			Curso curso = new Curso();
			curso.setNome(rs.getString("curso"));
			a.setCurso(curso);
			
			Matricula m = new Matricula();
			m.setDataMatricula(rs.getDate("dataMatricula"));
			a.setMatricula(m);
		} else {
			a = null;
		}
		rs.close();
		ps.close();
		c.close();
		return a;
	}

}
