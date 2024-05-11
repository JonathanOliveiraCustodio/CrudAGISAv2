package br.edu.fateczl.CrudAGISAv2.controller;

import java.sql.Date;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import br.edu.fateczl.CrudAGISAv2.model.Disciplina;
import br.edu.fateczl.CrudAGISAv2.model.ListaChamada;
import br.edu.fateczl.CrudAGISAv2.model.Professor;
import br.edu.fateczl.CrudAGISAv2.persistence.DisciplinaDao;
import br.edu.fateczl.CrudAGISAv2.persistence.GenericDao;
import br.edu.fateczl.CrudAGISAv2.persistence.ListaChamadaDao;
import br.edu.fateczl.CrudAGISAv2.persistence.ProfessorDao;

@Controller
public class ListaChamadaController {

	@Autowired
	GenericDao gDao;

	@Autowired
	DisciplinaDao dDao;

	@Autowired
	ListaChamadaDao lcDao;
	
	@Autowired
	ProfessorDao pDao;

	 
	@RequestMapping(name = "listaChamada", value = "/listaChamada", method = RequestMethod.GET)
	public ModelAndView chamadaGet(@RequestParam Map<String, String> allRequestParam, ModelMap model) {

		String erro = "";
		String saida = "";

		List<Disciplina> disciplinas = new ArrayList<>();
		List<Professor> professores = new ArrayList<>();
		List<ListaChamada> datasChamadas = new ArrayList<>();
		
		ListaChamada lc = new ListaChamada();

		try {
			String cmd = allRequestParam.get("cmd");
			String codigo = allRequestParam.get("codigo");

			if (cmd != null) {
				if (cmd.contains("Realizar Chamada")) {

					 lc.setCodigo(Integer.parseInt(codigo));
					// c = buscarConteudo(c);

				} else if (cmd.contains("Alterar Chamada")) {

					lc.setCodigo(Integer.parseInt(codigo));
					// c = buscarConteudo(c);
					/// saida = excluirConteudo(c);
				//	lc = null;

				}

			}
			professores = listaProfessores();
			datasChamadas = listaChamadas();
		

		} catch (ClassNotFoundException | SQLException e) {
			erro = e.getMessage();
		} finally {
			model.addAttribute("erro", erro);
			model.addAttribute("saida", saida);
			model.addAttribute("listaChamada", lc);
			model.addAttribute("disciplinas", disciplinas);
			model.addAttribute("professores", professores);
			model.addAttribute("disciplinas", disciplinas);
			model.addAttribute("datasChamadas", datasChamadas);
		}

		return new ModelAndView("listaChamada");
	}

	@RequestMapping(name = "listaChamada", value = "/listaChamada", method = RequestMethod.POST)
	public ModelAndView listaChamdaPost(@RequestParam Map<String, String> allRequestParam, ModelMap model) {

		String cmd = allRequestParam.get("botao");
		String professor = allRequestParam.get("professor");
		String dataChamada = allRequestParam.get("dataChamada");
		String presenca1 = allRequestParam.get("presenca1");
		String presenca2 = allRequestParam.get("presenca2");
		String presenca3 = allRequestParam.get("presenca3");
		String presenca4 = allRequestParam.get("presenca4");		
		String codigoMatricula = allRequestParam.get("codigoMatricula");
		String codigoDisciplina = allRequestParam.get("codigoDisciplina");
		String disciplina = allRequestParam.get("disciplina");
	
		String saida = "";
		String erro = "";

		ListaChamada lc = new ListaChamada();
		
		Professor p = new Professor();
		Disciplina d = new Disciplina();

		List<Disciplina> disciplinas = new ArrayList<>();
		List<ListaChamada> listasChamadas = new ArrayList<>();
		List<Professor> professores = new ArrayList<>();
		List<ListaChamada> datasChamadas = new ArrayList<>();
		
		try {        
			
			p.setCodigo(Integer.parseInt(professor));			
			p = buscarProfessor(p);
			lc.setProfessor(p);
			

		
			professores = listaProfessores();
		        if (cmd.contains("Cadastrar") || cmd.contains("Alterar")) {
		        	
		            lc.setPresenca1(Integer.parseInt(presenca1));
		            lc.setPresenca2(Integer.parseInt(presenca2));
		            lc.setPresenca3(Integer.parseInt(presenca3));
		            lc.setPresenca4(Integer.parseInt(presenca4));
		        }
		        if (cmd.contains("Cadastrar")) {
		            saida = cadastrarListaChamada(lc);
		            lc = null;
		        }
		        if (cmd.contains("Alterar")) {	
		            saida = alterarListaChamada(lc);
		            lc = null;
		        }
		        if (cmd.contains("Buscar")) {
		
		        	 disciplinas = listarDisciplinas(Integer.parseInt(professor));
		        	 datasChamadas = listaChamadas();
		        	System.out.println("Valor selecionado do código do professor: " + professor);	
		        		
		        }

		       		        
		        if (cmd.contains("Consultar")) {
		        	d.setCodigo(Integer.parseInt(disciplina));			
					d = buscarDisciplina(d);
					lc.setDisciplina(d);
		        	
		        	System.out.println("Valor selecionado do código da Disciplina: " + disciplina);
		        	System.out.println("Data: " + dataChamada);	
		            listasChamadas = consultarListaChamada(Integer.parseInt(disciplina), Date.valueOf(dataChamada));
		            
		        }
		       
		} catch (SQLException | ClassNotFoundException e) {
		    erro = e.getMessage();
		} finally {

		model.addAttribute("saida", saida);
		model.addAttribute("erro", erro);
		model.addAttribute("listaChamada", lc);
		model.addAttribute("listasChamadas", listasChamadas);
		model.addAttribute("disciplinas", disciplinas);
		model.addAttribute("professores", professores);
		model.addAttribute("datasChamadas", datasChamadas);
		}
		return new ModelAndView("listaChamada");
	}
	
	

	
	private String cadastrarListaChamada(ListaChamada lc) throws SQLException, ClassNotFoundException {
		String saida = lcDao.iudListaChamada("I", lc);
		return saida;

	}

	private String alterarListaChamada(ListaChamada lc) throws SQLException, ClassNotFoundException {
		String saida = lcDao.iudListaChamada("U", lc);
		return saida;

	}
	
	
	private Professor buscarProfessor(Professor p) throws SQLException, ClassNotFoundException {
		p = pDao.consultar(p);
		return p;
	}
	
	private Disciplina buscarDisciplina(Disciplina d) throws SQLException, ClassNotFoundException {
		d = dDao.consultar(d);
		return d;
	}

	private List<ListaChamada> consultarListaChamada(int codigoDisciplina, Date dataChamada)
			throws ClassNotFoundException, SQLException {
		List<ListaChamada> listachamada = lcDao.consultarListaChamada(codigoDisciplina, dataChamada);
		return listachamada;
	}

	private List<Disciplina> listarDisciplinas(int codigoProfessor) throws ClassNotFoundException, SQLException {
		List<Disciplina> disciplinas = lcDao.listarDisciplinaProfessor(codigoProfessor);
		return disciplinas;
	}
	
	private List<Professor> listaProfessores() throws ClassNotFoundException, SQLException {
		List<Professor> professores = pDao.listar();
		return professores;
	}
	
	private List<ListaChamada> listaChamadas() throws ClassNotFoundException, SQLException {
		List<ListaChamada> datasChamadas = lcDao.listar();
		return datasChamadas;
	}

}