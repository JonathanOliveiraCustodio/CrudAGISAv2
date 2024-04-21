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
import br.edu.fateczl.CrudAGISAv2.persistence.CursoDao;
import br.edu.fateczl.CrudAGISAv2.persistence.GenericDao;

@Controller
public class CursoController {

	@RequestMapping(name = "curso", value = "/curso", method = RequestMethod.GET)
	public ModelAndView cursoGet(@RequestParam Map<String, String> allRequestParam, ModelMap model) {

		return new ModelAndView("curso");
	}

	@RequestMapping(name = "curso", value = "/curso", method = RequestMethod.POST)
	public ModelAndView cursoPost(@RequestParam Map<String, String> allRequestParam, ModelMap model) {

		String cmd = allRequestParam.get("botao");
		String codigo = allRequestParam.get("codigo");
		String nome = allRequestParam.get("nome");
		String cargaHoraria = allRequestParam.get("cargaHoraria");
		String sigla = allRequestParam.get("sigla");
		String ultimaNotaENADE = allRequestParam.get("ultimaNotaENADE");
		String turno = allRequestParam.get("turno");

		// saida
		String saida = "";
		String erro = "";
		Curso c = new Curso();
		List<Curso> cursos = new ArrayList<>();

		if (cmd != null && !cmd.isEmpty() && cmd.contains("Limpar")) {
			c = null;

		} else {

			if (!cmd.contains("Listar")) {
				c.setCodigo(Integer.parseInt(codigo));
			}
			if (cmd.contains("Cadastrar") || cmd.contains("Alterar")) {
				c.setNome(nome);
				c.setCargaHoraria(Integer.parseInt(cargaHoraria));
				c.setSigla(sigla);
				c.setUltimaNotaENADE(Float.parseFloat(ultimaNotaENADE));
				c.setTurno(turno);

			}
			try {
				if (cmd.contains("Cadastrar")) {
					saida = cadastrarCurso(c);
					c = null;
				}
				if (cmd.contains("Alterar")) {
					saida = alterarCurso(c);
					c = null;
				}
				if (cmd.contains("Excluir")) {
					saida = excluirCurso(c);
					c = null;
				}
				if (cmd.contains("Buscar")) {
					c = buscarCurso(c);
					if (c == null) {
						saida = "Nenhum curso encontrado com o código especificado.";
						c = null;
					}
				}

				if (cmd.contains("Listar")) {
					cursos = listarCurso();
				}
			} catch (SQLException | ClassNotFoundException e) {
				erro = e.getMessage();
			}
		}

		model.addAttribute("saida", saida);
		model.addAttribute("erro", erro);
		model.addAttribute("curso", c);
		model.addAttribute("cursos", cursos);

		return new ModelAndView("curso");
	}

	private String cadastrarCurso(Curso c) throws SQLException, ClassNotFoundException {
		GenericDao gDao = new GenericDao();
		CursoDao pDao = new CursoDao(gDao);
		String saida = pDao.iudCurso("I", c);
		return saida;

	}

	private String alterarCurso(Curso c) throws SQLException, ClassNotFoundException {
		GenericDao gDao = new GenericDao();
		CursoDao pDao = new CursoDao(gDao);
		String saida = pDao.iudCurso("U", c);
		return saida;

	}

	private String excluirCurso(Curso c) throws SQLException, ClassNotFoundException {
		GenericDao gDao = new GenericDao();
		CursoDao pDao = new CursoDao(gDao);
		String saida = pDao.iudCurso("D", c);
		return saida;

	}

	private Curso buscarCurso(Curso c) throws SQLException, ClassNotFoundException {
		GenericDao gDao = new GenericDao();
		CursoDao pDao = new CursoDao(gDao);
		c = pDao.consultar(c);
		return c;

	}

	private List<Curso> listarCurso() throws SQLException, ClassNotFoundException {

		GenericDao gDao = new GenericDao();
		CursoDao pDao = new CursoDao(gDao);
		List<Curso> cursos = pDao.listar();

		return cursos;
	}

}