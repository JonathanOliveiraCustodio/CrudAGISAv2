package br.edu.fateczl.CrudAGISAv2.controller;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import br.edu.fateczl.CrudAGISAv2.model.Aluno;
import br.edu.fateczl.CrudAGISAv2.model.Curso;
import br.edu.fateczl.CrudAGISAv2.model.Disciplina;
import br.edu.fateczl.CrudAGISAv2.model.Eliminacao;
import br.edu.fateczl.CrudAGISAv2.model.Matricula;
import br.edu.fateczl.CrudAGISAv2.persistence.AlunoDao;
import br.edu.fateczl.CrudAGISAv2.persistence.CursoDao;
import br.edu.fateczl.CrudAGISAv2.persistence.EliminacaoDao;
import br.edu.fateczl.CrudAGISAv2.persistence.GenericDao;
import br.edu.fateczl.CrudAGISAv2.persistence.MatriculaDao;
import br.edu.fateczl.CrudAGISAv2.persistence.SolicitarEliminacaoDao;

@Controller
public class SolicitarEliminacaoController {

	@Autowired
	GenericDao gDao;

	@Autowired
	EliminacaoDao eDao;

	@Autowired
	CursoDao cDao;

	@Autowired
	AlunoDao aDao;

	@Autowired
	MatriculaDao mDao;

	@Autowired
	SolicitarEliminacaoDao slDao;

	@RequestMapping(name = "solicitarEliminacao", value = "/solicitarEliminacao", method = RequestMethod.GET)
	public ModelAndView analisarEliminacaoGet(@RequestParam Map<String, String> allRequestParam, ModelMap model) {

//		String erro = "";
//		String saida = "";
//		
//	    List<Eliminacao> eliminacoes = new ArrayList<>(); 
//
//		Eliminacao e = new Eliminacao();
//
//		try {
//			String cmd = allRequestParam.get("cmd");
//			String codigo = allRequestParam.get("codigo");
//			eliminacoes = listarEliminacoes();
//			if (cmd != null) {
//				if (cmd.contains("alterar")) {
//
//					e.setCodigo(Integer.parseInt(codigo));
//					e = buscarEliminacao(e);
//					saida = alterarEliminacao(e);
//					e = null;
//
//				} 
//				eliminacoes = listarEliminacoes();
//			}
//	
//
//		} catch (ClassNotFoundException | SQLException error) {
//			erro = error.getMessage();
//		} finally {
//			model.addAttribute("erro", erro);
//			model.addAttribute("saida", saida);
//			model.addAttribute("analisarEliminacao", e);
//			model.addAttribute("eliminacoes", eliminacoes);
//
//		}

		return new ModelAndView("solicitarEliminacao");
	}

	@RequestMapping(name = "solicitarEliminacao", value = "/solicitarEliminacao", method = RequestMethod.POST)
	public ModelAndView analisarEliminacaoPost(@RequestParam Map<String, String> allRequestParam, ModelMap model) {

		String cmd = allRequestParam.get("botao");
		String codigo = allRequestParam.get("codigo");
		String codigoMatricula = allRequestParam.get("codigoMatricula");
		String codigoDisciplina = allRequestParam.get("codigoDisciplina");
		//String dataEliminacao = allRequestParam.get("dataEliminacao");
		String nomeInstituicao = allRequestParam.get("nomeInstituicao");

	    String disciplina = allRequestParam.get("disciplina");
		String RA = allRequestParam.get("RA");

		String saida = "";
		String erro = "";

		Eliminacao e = new Eliminacao();

		Aluno a = new Aluno();

		Matricula m = new Matricula();

		List<Eliminacao> eliminacoes = new ArrayList<>();
		List<Disciplina> disciplinas = new ArrayList<>();

		try {
			a.setRA(Integer.parseInt(RA));			
			m = buscarMatricula(m,Integer.parseInt(RA));
			m.setCodigoAluno(RA);
			
			if (cmd.contains("Solicitar")) {

			
				e.setCodigoDisciplina(Integer.parseInt(disciplina));
				e.setCodigoMatricula(m.getCodigo()); 
				e.setNomeInstituicao(nomeInstituicao);
				
				System.out.println(disciplina);
				System.out.println(m.getCodigo());
				System.out.println(nomeInstituicao);
				// m.setCodigoAluno(RA);
				
				//e.setCodigoMatricula(m.setCodigoAluno(RA));
				
				
//				c = buscarCurso(c);
//				e.setCurso(c);

				// a = buscarAluno(a);
				// e.setAluno(a);
				saida = cadastrarEliminacao(e);
				e = null;
			}

			if (cmd.contains("Buscar")) {
				// a.setRA(Integer.parseInt(RA));
				a = buscarAluno(a);

				if (a == null) {
					saida = "Nenhum aluno encontrado com o RA especificado.";
				}
				disciplinas = listarDisciplinas(Integer.parseInt(RA));

			}
			if (cmd != null && !cmd.isEmpty() && cmd.contains("Limpar")) {
				a = null;
				e = null;
			}

			if (cmd.contains("Listar")) {
				if (cmd != null && !cmd.isEmpty()) {

					eliminacoes = listarEliminacoes(Integer.parseInt(RA));
				} else {
					saida = "Nenhum aluno encontrado para Listar.";
				}
			}

		} catch (SQLException | ClassNotFoundException error) {
			erro = error.getMessage();
		} finally {
			model.addAttribute("saida", saida);
			model.addAttribute("erro", erro);
			model.addAttribute("solicitarEliminacao", e);
			model.addAttribute("aluno", a);
			model.addAttribute("eliminacoes", eliminacoes);
			model.addAttribute("disciplinas", disciplinas);
		}

		return new ModelAndView("solicitarEliminacao");

	}

	private String cadastrarEliminacao(Eliminacao e) throws SQLException, ClassNotFoundException {
		String saida = slDao.iudSolicitarEliminacao("I", e);
		return saida;
	}

	private Aluno buscarAluno(Aluno a) throws SQLException, ClassNotFoundException {
		a = slDao.consultarAluno(a);
		return a;
	}



	private List<Eliminacao> listarEliminacoes(int RA) throws SQLException, ClassNotFoundException {
		List<Eliminacao> eliminacoes = slDao.listarEliminacoes(RA);
		return eliminacoes;
	}

	private List<Disciplina> listarDisciplinas(int RA) throws SQLException, ClassNotFoundException {
		List<Disciplina> disciplinas = slDao.listarDisciplina(RA);
		return disciplinas;
	}

	private Matricula buscarMatricula(Matricula m, int RA) throws SQLException, ClassNotFoundException {
		m = mDao.buscarMatricula(RA);
		return m;
	}

}