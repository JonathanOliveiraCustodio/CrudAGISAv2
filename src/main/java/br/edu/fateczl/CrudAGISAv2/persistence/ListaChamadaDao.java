package br.edu.fateczl.CrudAGISAv2.persistence;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;
import org.springframework.stereotype.Repository;

import br.edu.fateczl.CrudAGISAv2.model.Aluno;
import br.edu.fateczl.CrudAGISAv2.model.Disciplina;
import br.edu.fateczl.CrudAGISAv2.model.ListaChamada;

@Repository
public class ListaChamadaDao implements ICrud<ListaChamada>, IListaChamadaDao {

	private GenericDao gDao;

	public ListaChamadaDao(GenericDao gDao) {
		this.gDao = gDao;
	}


	public List<ListaChamada> consultarListaChamada(int codigoDisciplina, Date dataChamada) throws SQLException, ClassNotFoundException {
		List<ListaChamada> listasChamada = new ArrayList<>();
		Connection con = gDao.getConnection();
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT * FROM fn_Lista_Chamada_Disciplina(?,?) ");
		PreparedStatement ps = con.prepareStatement(sql.toString());		
		ps.setInt(1, codigoDisciplina);
		ps.setDate(2, dataChamada);
		ResultSet rs = ps.executeQuery();
		while (rs.next()) {		
			ListaChamada lc = new ListaChamada();
			lc.setCodigo(rs.getInt("codigo"));
			lc.setCodigoMatricula(rs.getInt("codigoMatricula"));
			lc.setCodigoMatricula(rs.getInt("codigoDisciplina"));
			lc.setDataChamada(rs.getDate("dataChamada"));
			lc.setPresenca1(rs.getInt("presenca1"));
			lc.setPresenca2(rs.getInt("presenca2"));
			lc.setPresenca3(rs.getInt("presenca3"));
			lc.setPresenca4(rs.getInt("presenca4"));		
			Aluno a = new Aluno();
			a.setNome(rs.getString("nomeAluno"));
			lc.setAluno(a);
			Disciplina d = new Disciplina();
			d.setCodigo(rs.getInt("codigoDisciplina"));
			d.setNome(rs.getString("nomeDisciplina"));
			lc.setDisciplina(d);
			listasChamada.add(lc);
		}
		rs.close();
		ps.close();
		con.close();

		return listasChamada;
	}

	@Override
	public String iudListaChamada(String acao, ListaChamada lc) throws SQLException, ClassNotFoundException {
		Connection con = gDao.getConnection();
		String sql = "{CALL sp_iud_lista_chamada (?,?,?,?,?,?,?,?,?,?)}";
		CallableStatement cs = con.prepareCall(sql);
		cs.setString(1, acao);
		cs.setInt(2, lc.getCodigo());
		cs.setInt(3, lc.getCodigoMatricula());
		cs.setInt(4, lc.getCodigoDisciplina());
	    cs.setDate(5, lc.getDataChamada());
	    cs.setInt(6, lc.getPresenca1());
	    cs.setInt(7, lc.getPresenca2());
	    cs.setInt(8, lc.getPresenca3());
	    cs.setInt(9, lc.getPresenca4());
		cs.registerOutParameter(10, Types.VARCHAR);
		cs.execute();
		String saida = cs.getString(10);
		cs.close();
		con.close();

		return saida;
	}

	@Override
	public List<ListaChamada> listar() throws SQLException, ClassNotFoundException {
		// TODO Auto-generated method stub
		return null;
	}



	@Override
	public ListaChamada consultar(ListaChamada lc) throws SQLException, ClassNotFoundException {
		Connection c = gDao.getConnection();
		StringBuffer sql = new StringBuffer();		
		sql.append("SELECT * FROM fn_Lista_Chamada_Disciplina(?) ");
		
		PreparedStatement ps = c.prepareStatement(sql.toString());
		ps.setInt(1, lc.getCodigo());
	

		ResultSet rs = ps.executeQuery();
		if (rs.next()) {
			lc.setCodigo(rs.getInt("codigo"));
			lc.setCodigoMatricula(rs.getInt("codigoMatricula"));
			lc.setCodigoMatricula(rs.getInt("codigoDisciplina"));
			lc.setDataChamada(rs.getDate("dataChamada"));
			lc.setPresenca1(rs.getInt("presenca1"));
			lc.setPresenca2(rs.getInt("presenca2"));
			lc.setPresenca3(rs.getInt("presenca3"));
			lc.setPresenca4(rs.getInt("presenca4"));
			
			Aluno a = new Aluno();
			a.setNome(rs.getString("nomeAluno"));
			lc.setAluno(a);
			
			Disciplina d = new Disciplina();
			d.setCodigo(rs.getInt("codigoDisciplina"));
			d.setNome(rs.getString("nomeDisciplina"));
			lc.setDisciplina(d);
			

		}
		rs.close();
		ps.close();
		c.close();

		return lc;
	}



}
