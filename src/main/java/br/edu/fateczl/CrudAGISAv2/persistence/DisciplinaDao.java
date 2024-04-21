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
import br.edu.fateczl.CrudAGISAv2.model.Matricula;
import br.edu.fateczl.CrudAGISAv2.model.Professor;

@Repository
public class DisciplinaDao implements ICrud<Disciplina>, IDisciplinaDao {

	private GenericDao gDao;

	public DisciplinaDao(GenericDao gDao) {
		this.gDao = gDao;
	}

	@Override
	public Disciplina consultar(Disciplina d) throws SQLException, ClassNotFoundException {
		Connection con = gDao.getConnection();
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT d.codigo AS codigoDisciplina, d.nome AS nomeDisciplina, d.horasSemanais, ");
		sql.append("d.horarioInicio, d.semestre, d.diaSemana, p.codigo AS codigoProfessor, p.nome AS nomeProfessor, ");
		sql.append("c.codigo AS codigoCurso, c.nome AS nomeCurso ");
		sql.append("FROM disciplina d ");
		sql.append("JOIN professor p ON d.codigoProfessor = p.codigo ");
		sql.append("JOIN curso c ON d.codigoCurso = c.codigo ");
		sql.append("WHERE d.codigo = ?");

		PreparedStatement ps = con.prepareStatement(sql.toString());
		ps.setInt(1, d.getCodigo());
		ResultSet rs = ps.executeQuery();
		if (rs.next()) {

			Professor p = new Professor();
			p.setCodigo(rs.getInt("codigoProfessor"));
			p.setNome(rs.getString("nomeProfessor"));

			Curso c = new Curso();
			c.setCodigo(rs.getInt("codigoCurso"));
			c.setNome(rs.getString("nomeCurso"));

			d.setCodigo(rs.getInt("codigoDisciplina"));
			d.setNome(rs.getString("nomeDisciplina"));
			d.setHorasSemanais(rs.getInt("horasSemanais"));
			d.setHoraInicio(rs.getString("horarioInicio"));
			d.setSemestre(rs.getInt("semestre"));
			d.setDiaSemana(rs.getString("diaSemana"));
			d.setProfessor(p);
			d.setCurso(c);

			rs.close();
			ps.close();
			con.close();
			return d;
			
		} else {
			rs.close();
			ps.close();
			con.close();
			return null;
		}
	}

	@Override
	public List<Disciplina> listar() throws SQLException, ClassNotFoundException {

		List<Disciplina> disciplinas = new ArrayList<>();
		Connection con = gDao.getConnection();
		StringBuffer sql = new StringBuffer();
		sql.append(
				"SELECT d.codigo, d.nome AS nomeDisciplina, d.horasSemanais, SUBSTRING(d.horarioInicio, 1, 5) AS horarioInicio, d.semestre, d.diaSemana, p.nome AS nomeProfessor, c.nome AS nomeCurso ");
		sql.append("FROM disciplina d JOIN professor p ON d.codigoProfessor = p.codigo ");
		sql.append("JOIN curso c ON d.codigoCurso = c.codigo ");

		PreparedStatement ps = con.prepareStatement(sql.toString());
		ResultSet rs = ps.executeQuery();

		while (rs.next()) {

			Professor p = new Professor();
			p.setNome(rs.getString("nomeProfessor"));

			Curso c = new Curso();
			c.setNome(rs.getString("nomeCurso"));

			Disciplina d = new Disciplina();
			d.setCodigo(rs.getInt("codigo"));
			d.setNome(rs.getString("nomeDisciplina"));
			d.setHorasSemanais(rs.getInt("horasSemanais"));
			d.setHoraInicio(rs.getString("horarioInicio"));
			d.setSemestre(rs.getInt("semestre"));
			d.setDiaSemana(rs.getString("diaSemana"));
			d.setProfessor(p);
			d.setCurso(c);
			disciplinas.add(d);
		}
		rs.close();
		ps.close();
		con.close();

		return disciplinas;
	}
	
	public List<Disciplina> listarDisciplinasCursadas(Matricula m) throws SQLException, ClassNotFoundException {
		List<Disciplina> disciplinas = new ArrayList<>();
		Connection con = gDao.getConnection();
		StringBuffer sql = new StringBuffer();
		sql.append(
				"SELECT d.codigo, d.nome AS nomeDisciplina, d.horasSemanais, SUBSTRING(d.horarioInicio, 1, 5) AS horarioInicio, d.semestre, d.diaSemana ");
		sql.append("FROM disciplina d JOIN matriculaDisciplina m ON m.codigoDisciplina = d.codigo WHERE CodigoMatricula = ?");
		PreparedStatement ps = con.prepareStatement(sql.toString());
		ps.setInt(1, m.getCodigo());
		ResultSet rs = ps.executeQuery();

		while (rs.next()) {
			Disciplina d = new Disciplina();
			d.setCodigo(rs.getInt("codigo"));
			d.setNome(rs.getString("nomeDisciplina"));
			d.setHorasSemanais(rs.getInt("horasSemanais"));
			d.setHoraInicio(rs.getString("horarioInicio"));
			d.setSemestre(rs.getInt("semestre"));
			d.setDiaSemana(rs.getString("diaSemana"));
			disciplinas.add(d);
		}
		rs.close();
		ps.close();
		con.close();

		return disciplinas;
	}
	
	public List<Disciplina> listarParaMatricula(Aluno a) throws SQLException, ClassNotFoundException {
		List<Disciplina> disciplinas = new ArrayList<>();
		Connection con = gDao.getConnection();
		StringBuffer sql = new StringBuffer();
		sql.append(
				"SELECT d.codigo, d.nome AS nomeDisciplina, d.horasSemanais, SUBSTRING(d.horarioInicio, 1, 5) AS horarioInicio, d.semestre, d.diaSemana ");
		sql.append("FROM disciplina d WHERE d.codigoCurso = ? ");
		sql.append("AND d.codigo NOT IN (SELECT codigoDisciplina FROM matriculaDisciplina WHERE situacao = 'Aprovado' AND CodigoMatricula IN (SELECT codigo FROM matricula WHERE codigoAluno = ?))");
		PreparedStatement ps = con.prepareStatement(sql.toString());
		ps.setInt(1, a.getCurso().getCodigo());
		ps.setString(2, a.getCPF());
		ResultSet rs = ps.executeQuery();

		while (rs.next()) {
			Disciplina d = new Disciplina();
			d.setCodigo(rs.getInt("codigo"));
			d.setNome(rs.getString("nomeDisciplina"));
			d.setHorasSemanais(rs.getInt("horasSemanais"));
			d.setHoraInicio(rs.getString("horarioInicio"));
			d.setSemestre(rs.getInt("semestre"));
			d.setDiaSemana(rs.getString("diaSemana"));
			disciplinas.add(d);
		}
		rs.close();
		ps.close();
		con.close();

		return disciplinas;
	}

	@Override
	public String iudDisciplina(String acao, Disciplina d) throws SQLException, ClassNotFoundException {
		Connection c = gDao.getConnection();
		String sql = "{CALL sp_iud_disciplina (?,?,?,?,?,?,?,?,?,?)}";
		CallableStatement cs = c.prepareCall(sql);
		cs.setString(1, acao);
		cs.setInt(2, d.getCodigo());
		cs.setString(3, d.getNome());
		cs.setInt(4, d.getHorasSemanais());
		cs.setString(5, d.getHoraInicio());
		cs.setInt(6, d.getSemestre());
		cs.setString(7, d.getDiaSemana());
		cs.setInt(8, d.getProfessor().getCodigo());
		cs.setInt(9, d.getCurso().getCodigo());
		cs.registerOutParameter(10, Types.VARCHAR);
		cs.execute();
		String saida = cs.getString(10);
		cs.close();
		c.close();

		return saida;
	}

}
