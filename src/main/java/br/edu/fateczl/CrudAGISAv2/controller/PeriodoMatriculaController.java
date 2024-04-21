package br.edu.fateczl.CrudAGISAv2.controller;

import java.sql.Date;
import java.sql.SQLException;
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
public class PeriodoMatriculaController {

	@RequestMapping(name = "periodoMatricula", value = "/periodoMatricula", method = RequestMethod.GET)
	public ModelAndView periodoMatriculaGet(@RequestParam Map<String, String> allRequestParam, ModelMap model) {

		String erro = "";
		GenericDao gDao = new GenericDao();
		CursoDao cDao = new CursoDao(gDao);
		Curso c = new Curso();

		try {
			c = cDao.consultarPeriodoMatricula();
		} catch (Exception e) {
			erro = e.getMessage();
		}

		// RequestDispatcher rd = request.getRequestDispatcher("periodoMatricula.jsp");
		model.addAttribute("erro", erro);
		model.addAttribute("curso", c);

		return new ModelAndView("periodoMatricula");
	}

	@RequestMapping(name = "periodoMatricula", value = "/periodoMatricula", method = RequestMethod.POST)
	public ModelAndView periodoMatriculaPost(@RequestParam Map<String, String> allRequestParam, ModelMap model) {

		// Entrada
		String periodoMatriculaInicio = allRequestParam.get("periodoMatriculaInicio");
		String periodoMatriculaFim = allRequestParam.get("periodoMatriculaFim");

		// Saída
		String saida = "";
		String erro = "";

		Curso c = new Curso();
		c.setPeriodoMatriculaInicio(Date.valueOf(periodoMatriculaInicio));
		c.setPeriodoMatriculaFim(Date.valueOf(periodoMatriculaFim));

		try {
			saida = alterarPeriodoMatricula(c);
		} catch (Exception e) {
			erro = e.getMessage();
		}
		model.addAttribute("saida", saida);
		model.addAttribute("erro", erro);
		model.addAttribute("curso", c);

		return new ModelAndView("periodoMatricula");
	}

	private String alterarPeriodoMatricula(Curso c) throws SQLException, ClassNotFoundException {
		GenericDao gDao = new GenericDao();
		CursoDao cDao = new CursoDao(gDao);
		String saida = cDao.alterarPeriodoMatricula(c);
		return saida;

	}

}
