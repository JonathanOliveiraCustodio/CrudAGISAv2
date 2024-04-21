package br.edu.fateczl.CrudAGISAv2.controller;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import br.edu.fateczl.CrudAGISAv2.model.Aluno;
import br.edu.fateczl.CrudAGISAv2.model.Disciplina;
import br.edu.fateczl.CrudAGISAv2.model.Matricula;
import br.edu.fateczl.CrudAGISAv2.persistence.AlunoDao;
import br.edu.fateczl.CrudAGISAv2.persistence.DisciplinaDao;
import br.edu.fateczl.CrudAGISAv2.persistence.GenericDao;
import br.edu.fateczl.CrudAGISAv2.persistence.MatriculaDao;

@Controller
public class HorariosController {

	@RequestMapping(name = "horarios", value = "/horarios", method = RequestMethod.GET)
	public ModelAndView horariosGet(ModelMap model) {
		return new ModelAndView("horarios");
	}

	@RequestMapping(name = "horarios", value = "/horarios", method = RequestMethod.POST)
	public ModelAndView horariosPost(@RequestParam Map<String, String> allRequestParam, ModelMap model) {
		
		String RA = allRequestParam.get("RA");
		Aluno a = new Aluno();
		Matricula m = new Matricula();
		String erro = null;
		String saida = null;
		Map<String, List<Disciplina>> disciplinasMatriculadas = new HashMap<String, List<Disciplina>>();
		
		try {
			a.setRA(Integer.parseInt(RA));
			a = buscarAluno(a);
			if (a == null) {
				saida = "Nenhum aluno encontrado com o RA especificado.";
				a = null;
			} else {
				m = buscarMatriculaAtual(a);
				disciplinasMatriculadas = buscarDisciplinasAluno(m);				
			}
		} catch (Exception e) {
			erro = e.getMessage();
		}
		
		model.addAttribute("saida", saida);
		model.addAttribute("erro", erro);
		model.addAttribute("aluno", a);
		model.addAttribute("matricula", m);
		model.addAttribute("disciplinas", disciplinasMatriculadas);
		
		return new ModelAndView("horarios");
		
	}
	
	private Map<String, List<Disciplina>> buscarDisciplinasAluno(Matricula m) throws ClassNotFoundException, SQLException {
		List<Disciplina> disciplinas = new ArrayList<>();
		Map<String, List<Disciplina>> disciplinasPorSemana = new HashMap<String, List<Disciplina>>();
		GenericDao gDao2 = new GenericDao();
	 	DisciplinaDao dDao = new DisciplinaDao(gDao2);
	 	
		disciplinas = dDao.listarDisciplinasCursadas(m);
		for(Disciplina d : disciplinas){
		    List<Disciplina> temp = disciplinasPorSemana.get(d.getDiaSemana());

		    if(temp == null){
		        temp = new ArrayList<Disciplina>();
		        disciplinasPorSemana.put(d.getDiaSemana(), temp);
		    }
		    temp.add(d);
		}
		return disciplinasPorSemana;
	}


	private Matricula buscarMatriculaAtual(Aluno a) throws ClassNotFoundException, SQLException {
		GenericDao gDao = new GenericDao();
		MatriculaDao mDao = new MatriculaDao(gDao);
		Matricula m = new Matricula();
		m = mDao.buscarMatriculaAtualAluno(a);
		return m;
	}


	private Aluno buscarAluno(Aluno a) throws ClassNotFoundException, SQLException {
		GenericDao gDao = new GenericDao();
		AlunoDao pDao = new AlunoDao(gDao);
		a = pDao.consultarPorRA(a);
		return a;
	}

}
