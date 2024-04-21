package br.edu.fateczl.CrudAGISAv2.controller;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import br.edu.fateczl.CrudAGISAv2.model.Curso;
import br.edu.fateczl.CrudAGISAv2.model.Disciplina;
import br.edu.fateczl.CrudAGISAv2.model.Professor;
import br.edu.fateczl.CrudAGISAv2.persistence.CursoDao;
import br.edu.fateczl.CrudAGISAv2.persistence.DisciplinaDao;
import br.edu.fateczl.CrudAGISAv2.persistence.GenericDao;
import br.edu.fateczl.CrudAGISAv2.persistence.ProfessorDao;


@Controller
public class DisciplinaController {

	@RequestMapping(name = "disciplina", value = "/disciplina", method = RequestMethod.GET)
	public ModelAndView disciplinaGet(@RequestParam Map<String, String> allRequestParam, ModelMap model) {
String erro = "";
		
		List<Professor> professores = new ArrayList<>();
		GenericDao gDao = new GenericDao();
		ProfessorDao pDao = new ProfessorDao(gDao);
		
		List<Curso> cursos = new ArrayList<>();
		CursoDao cDao = new CursoDao(gDao);
			
		List<Disciplina> disciplinas = new ArrayList<>();
	//	DisciplinaDao dDao = new DisciplinaDao(gDao);
		
		try {
			professores = pDao.listar();
			cursos = cDao.listar();
		//	disciplinas = dDao.listar();
					
		} catch (ClassNotFoundException | SQLException e) {
			erro = e.getMessage();

		} finally {
			model.addAttribute("erro", erro);
			model.addAttribute("professores", professores);	
			model.addAttribute("cursos", cursos);
			model.addAttribute("disciplinas", disciplinas);			
		}
	
		return new ModelAndView("disciplina");
	}

	@RequestMapping(name = "disciplina", value = "/disciplina", method = RequestMethod.POST)
	public ModelAndView disciplinaPost(@RequestParam Map<String, String> allRequestParam, ModelMap model) {
		
		String cmd = allRequestParam.get("botao");
		String codigo = allRequestParam.get("codigo");
		String nome = allRequestParam.get("nome");
		String horasSemanais = allRequestParam.get("horasSemanais");		
		String horaInicio = allRequestParam.get("horaInicio");
		String semestre = allRequestParam.get("semestre");
		String diaSemana = allRequestParam.get("diaSemana");
		String professor = allRequestParam.get("professor");
		String curso = allRequestParam.get("curso");
		
		// saida
		String saida = "";
		String erro = "";	
		
		
		Disciplina d = new Disciplina();
		Professor p = new Professor();
        Curso c = new Curso();
		
		
		List<Professor> professores = new ArrayList<>();
		List<Curso> cursos = new ArrayList<>();
		List<Disciplina> disciplinas = new ArrayList<>();
	    

		try {
			
		if (!cmd.contains("Listar")) {
			p.setCodigo(Integer.parseInt(professor));
			p = buscarProfessor(p);
			d.setProfessor(p);			
			c.setCodigo(Integer.parseInt(curso));
			c = buscarCurso(c);
			d.setCurso(c);			
			d.setCodigo(Integer.parseInt(codigo));
		}			
			professores = listarProfessores();
			cursos = listarCursos();
				
		    if (cmd.contains("Cadastrar") || cmd.contains("Alterar")) {	  			
		    	d.setNome(nome);
		    	d.setHorasSemanais(Integer.parseInt(horasSemanais));
		    	d.setHoraInicio(horaInicio);
		    	d.setSemestre(Integer.parseInt(semestre));
		    	d.setDiaSemana(diaSemana);			
		    }

		    if (cmd.contains("Cadastrar")) {
		    	saida = cadastrarDisciplina(d);
				d = null;
		    }
		    if (cmd.contains("Alterar")) {
		    	saida = alterarDisciplina(d);
				d = null;
		    }
		    if (cmd.contains("Excluir")) {    	
		   
		    	saida = excluirDisciplina(d);
				d = null;
		    }
		    if (cmd.contains("Buscar")) {
				d = buscarDisciplina(d);
				if (d == null) {
					saida = "Nenhuma disciplina encontrado com o código especificado.";
					d = null;
				}
			}
			if (cmd != null && !cmd.isEmpty() && cmd.contains("Limpar")) {
				d = null;
			}

			if (cmd.contains("Listar")) {
				disciplinas = listarDisciplinas();
			}
		    			    
		} catch (SQLException | ClassNotFoundException e) {
		    erro = e.getMessage();
		} finally {
			model.addAttribute("saida", saida);
		    model.addAttribute("erro", erro);
		    model.addAttribute("disciplina", d);
		    model.addAttribute("professores", professores);
		    model.addAttribute("cursos", cursos);
		    model.addAttribute("disciplinas", disciplinas);		   
	
		}
		
		return new ModelAndView("disciplina");
	}
	
	private String cadastrarDisciplina(Disciplina d) throws SQLException, ClassNotFoundException {
		GenericDao gDao = new GenericDao();
		DisciplinaDao pDao = new DisciplinaDao(gDao);
		String saida = pDao.iudDisciplina("I", d);
		return saida;

	}

	private String alterarDisciplina(Disciplina d) throws SQLException, ClassNotFoundException {
		GenericDao gDao = new GenericDao();
		DisciplinaDao dDao = new DisciplinaDao(gDao);
		String saida = dDao.iudDisciplina("U", d);
		return saida;

	}

	private String excluirDisciplina(Disciplina d) throws SQLException, ClassNotFoundException {
		GenericDao gDao = new GenericDao();
		DisciplinaDao dDao = new DisciplinaDao(gDao);
		String saida = dDao.iudDisciplina("D", d);
		return saida;

	}
	private Disciplina buscarDisciplina(Disciplina d) throws SQLException, ClassNotFoundException {
		GenericDao gDao = new GenericDao();
		DisciplinaDao dDao = new DisciplinaDao(gDao);
		d = dDao.consultar(d);
		return d;
	}

	private List<Disciplina> listarDisciplinas() throws SQLException, ClassNotFoundException {
		GenericDao gDao = new GenericDao();
		DisciplinaDao dDao = new DisciplinaDao(gDao);
		List<Disciplina> disciplinas = dDao.listar();
		return disciplinas;
	}
	

	private Professor buscarProfessor(Professor p) throws SQLException, ClassNotFoundException {
		GenericDao gDao = new GenericDao();
		ProfessorDao pDao = new ProfessorDao(gDao);
		p = pDao.consultar(p);
		return p;

	}

	private List<Professor> listarProfessores() throws ClassNotFoundException, SQLException {
		GenericDao gDao = new GenericDao();
		ProfessorDao pDao = new ProfessorDao(gDao);
		List<Professor> professores = pDao.listar();

		return professores;
	}
	
	private Curso buscarCurso(Curso c) throws SQLException, ClassNotFoundException {
		GenericDao gDao = new GenericDao();
		CursoDao cDao = new CursoDao(gDao);
		c = cDao.consultar(c);
		return c;

	}

	private List<Curso> listarCursos() throws ClassNotFoundException, SQLException {
		GenericDao gDao = new GenericDao();
		CursoDao cDao = new CursoDao(gDao);
		List<Curso> cursos = cDao.listar();

		return cursos;
	}

}


