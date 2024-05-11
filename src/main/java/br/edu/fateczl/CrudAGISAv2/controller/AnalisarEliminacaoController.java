package br.edu.fateczl.CrudAGISAv2.controller;

import java.sql.Date;
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
import br.edu.fateczl.CrudAGISAv2.model.Eliminacao;
import br.edu.fateczl.CrudAGISAv2.model.Matricula;
import br.edu.fateczl.CrudAGISAv2.persistence.AlunoDao;
import br.edu.fateczl.CrudAGISAv2.persistence.CursoDao;
import br.edu.fateczl.CrudAGISAv2.persistence.EliminacaoDao;
import br.edu.fateczl.CrudAGISAv2.persistence.GenericDao;
import br.edu.fateczl.CrudAGISAv2.persistence.MatriculaDao;

@Controller
public class AnalisarEliminacaoController {

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

	@RequestMapping(name = "analisarEliminacao", value = "/analisarEliminacao", method = RequestMethod.GET)
	public ModelAndView analisarEliminacaoGet(@RequestParam Map<String, String> allRequestParam, ModelMap model) {

		String erro = "";
		String saida = "";

		List<Eliminacao> eliminacoes = new ArrayList<>();

		Eliminacao e = new Eliminacao();

		try {
			String cmd = allRequestParam.get("cmd");
			String codigo = allRequestParam.get("codigo");

			eliminacoes = listarEliminacoes();
			if (cmd != null) {
				if (cmd.contains("alterar")) {

					e.setCodigo(Integer.parseInt(codigo));
					e = buscarEliminacao(e);
					// saida = alterarEliminacao(e);
					// e = null;

				}
				eliminacoes = listarEliminacoes();
			}

		} catch (ClassNotFoundException | SQLException error) {
			erro = error.getMessage();
		} finally {
			model.addAttribute("erro", erro);
			model.addAttribute("saida", saida);
			model.addAttribute("analisarEliminacao", e);
			model.addAttribute("eliminacoes", eliminacoes);

		}

		return new ModelAndView("analisarEliminacao");
	}

	@RequestMapping(name = "analisarEliminacao", value = "/analisarEliminacao", method = RequestMethod.POST)
	public ModelAndView analisarEliminacaoPost(@RequestParam Map<String, String> allRequestParam, ModelMap model) {

		String cmd = allRequestParam.get("botao");
		String codigo = allRequestParam.get("codigo");
		String status = allRequestParam.get("status");

		String saida = "";
		String erro = "";

		Eliminacao e = new Eliminacao();

		List<Eliminacao> eliminacoes = new ArrayList<>();

		try {
			if (!cmd.contains("Listar")) {
				e.setCodigo(Integer.parseInt(codigo));
			}

			if (cmd.contains("Cadastrar")) {
				e.setStatus(status);
				e = null;
			} else 
				if (cmd.contains("Alterar")) {
				e = buscarEliminacao(e);
				e.setStatus(status); 
				saida = alterarEliminacao(e);
				
				e = null;
				eliminacoes = listarEliminacoes();
			} else 
				if (cmd.contains("Buscar")) {
				e = buscarEliminacao(e);
				if (e == null) {
					saida = "Nenhuma Eliminação encontrada com o código especificado.";
				}
			} else 
				if (cmd.contains("Listar")) {
				eliminacoes = listarEliminacoes();
			}
		} catch (SQLException | ClassNotFoundException error) {
			erro = error.getMessage();
		} finally {
			model.addAttribute("saida", saida);
			model.addAttribute("erro", erro);
			model.addAttribute("analisarEliminacao", e);
			model.addAttribute("eliminacoes", eliminacoes);
		}

		return new ModelAndView("analisarEliminacao");

	}

	private String alterarEliminacao(Eliminacao e) throws SQLException, ClassNotFoundException {
		String saida = eDao.iudEliminacao("U", e);
		return saida;
	}

	private Eliminacao buscarEliminacao(Eliminacao e) throws SQLException, ClassNotFoundException {
		e = eDao.consultar(e);
		return e;
	}

	private Aluno buscarAluno(Aluno a) throws SQLException, ClassNotFoundException {
		a = aDao.consultar(a);
		return a;
	}

	private Curso buscarCurso(Curso c) throws SQLException, ClassNotFoundException {
		c = cDao.consultar(c);
		return c;
	}

	private Matricula buscarMatricula(Matricula m, int RA) throws SQLException, ClassNotFoundException {
		m = mDao.buscarMatricula(RA);
		return m;
	}

	private List<Eliminacao> listarEliminacoes() throws SQLException, ClassNotFoundException {
		List<Eliminacao> eliminacoes = eDao.listar();
		return eliminacoes;
	}

}