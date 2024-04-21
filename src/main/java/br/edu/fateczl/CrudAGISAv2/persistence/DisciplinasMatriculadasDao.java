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

import br.edu.fateczl.CrudAGISAv2.model.Disciplina;
import br.edu.fateczl.CrudAGISAv2.model.Matricula;

@Repository
public class DisciplinasMatriculadasDao {
	
	private GenericDao gDao;

	public DisciplinasMatriculadasDao(GenericDao gDao) {
		this.gDao = gDao;
	}
	
	public List<Integer> buscarCodigoDisciplinasMatriculadas(int codigo) throws SQLException, ClassNotFoundException {
		Connection c = gDao.getConnection();
		String sql = "SELECT codigoDisciplina FROM matriculaDisciplina WHERE CodigoMatricula = ?";
		PreparedStatement ps = c.prepareStatement(sql.toString());
	    ps.setInt(1, codigo);
	    ResultSet rs = ps.executeQuery();
	    
	    List<Integer> codigos = new ArrayList<>();
	    while (rs.next()) {
	    	codigos.add(rs.getInt("codigoDisciplina"));
	    }
	    
	    return codigos;
	}
	
	public String matricularDisciplina(Disciplina d, Matricula m) throws SQLException, ClassNotFoundException {
		Connection c = gDao.getConnection();
		String sql = "{CALL sp_matricular_disciplina (?,?,?)}";
		CallableStatement cs = c.prepareCall(sql);
		cs.setInt(1, d.getCodigo());
		cs.setInt(2, m.getCodigo());
		cs.registerOutParameter(3, Types.VARCHAR);
		cs.execute();
		String saida = cs.getString(3);
		cs.close();
		c.close();

		return saida;
	}


}
