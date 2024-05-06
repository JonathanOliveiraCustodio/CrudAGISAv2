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
import br.edu.fateczl.CrudAGISAv2.persistence.AlunoDao;
import br.edu.fateczl.CrudAGISAv2.persistence.CursoDao;
import br.edu.fateczl.CrudAGISAv2.persistence.EliminacaoDao;
import br.edu.fateczl.CrudAGISAv2.persistence.GenericDao;

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
					saida = alterarEliminacao(e);
					e = null;

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
		String codigoMatricula = allRequestParam.get("codigoMatricula");
		String codigoDisciplina = allRequestParam.get("codigoDisciplina");
		String dataEliminacao = allRequestParam.get("dataEliminacao");
		String status = allRequestParam.get("status");
		String nomeInstituicao = allRequestParam.get("nomeInstituicao");
		String aluno = allRequestParam.get("aluno");
		String curso = allRequestParam.get("curso");

	
		String saida = "";
		String erro = "";
		
		Eliminacao e = new Eliminacao();
		
		Aluno a = new Aluno();
		Curso c = new Curso();
		
		List<Eliminacao> eliminacoes = new ArrayList<>();

		if (!cmd.contains("Listar")) {
			e.setCodigo(Integer.parseInt(codigo));
		}
		try {
		//	cursos = listarCursos();

			if (cmd.contains("Cadastrar") || cmd.contains("Alterar")) {

				e.setCodigo(Integer.parseInt(codigo));
				e.setCodigoMatricula(Integer.parseInt(codigoMatricula));
				e.setCodigoDisciplina(Integer.parseInt(codigoDisciplina));
				e.setDataEliminacao(Date.valueOf(dataEliminacao));
				e.setStatus(status);
				e.setNomeInstituicao(nomeInstituicao);
				
				
				c = buscarCurso(c);
				e.setCurso(c);
				
				a = buscarAluno(a);
				e.setAluno(a);
			}


			if (cmd.contains("Alterar")) {
				saida = alterarEliminacao(e);
				e = null;
			}

			if (cmd.contains("Buscar")) {
				e = buscarEliminacao(e);
				if (e == null) {
					saida = "Nenhum aluno encontrado com o CPF especificado.";
					e = null;
				}
			}
			if (cmd != null && !cmd.isEmpty() && cmd.contains("Limpar")) {
				e = null;
			}

			if (cmd.contains("Listar")) {
				eliminacoes = listarEliminacoes();
			}

	
		} catch (SQLException | ClassNotFoundException error) {
			erro = error.getMessage();
		} finally {
			model.addAttribute("saida", saida);
			model.addAttribute("erro", erro);
			model.addAttribute("aluno", a);
			model.addAttribute("analisarEliminacao", e);
			model.addAttribute("eliminacoes", eliminacoes);
			model.addAttribute("aluno", a);
			model.addAttribute("curso", c);
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
	
	

	private List<Eliminacao> listarEliminacoes() throws SQLException, ClassNotFoundException {
		List<Eliminacao> eliminacoes = eDao.listar();
		return eliminacoes;
	}
	

}