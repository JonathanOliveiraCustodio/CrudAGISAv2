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

import br.edu.fateczl.CrudAGISAv2.model.Aluno;
import br.edu.fateczl.CrudAGISAv2.model.Telefone;
import br.edu.fateczl.CrudAGISAv2.persistence.AlunoDao;
import br.edu.fateczl.CrudAGISAv2.persistence.GenericDao;
import br.edu.fateczl.CrudAGISAv2.persistence.TelefoneDao;

@Controller
public class TelefoneController {

	@RequestMapping(name = "telefone", value = "/telefone", method = RequestMethod.GET)
	public ModelAndView telefoneGet(@RequestParam Map<String, String> allRequestParam, ModelMap model) {

		String erro = "";
		String aluno = allRequestParam.get("aluno");
		
		List<Telefone> telefones = new ArrayList<>();
		Aluno a = new Aluno();
		a.setCPF(aluno);

		try {
			telefones = listarTelefones(aluno);

		} catch (ClassNotFoundException | SQLException e) {
			erro = e.getMessage();

		} finally {
			model.addAttribute("erro", erro);
			model.addAttribute("telefones", telefones);
			model.addAttribute("aluno", a);
		}
		return new ModelAndView("telefone");
	}

	@RequestMapping(name = "telefone", value = "/telefone", method = RequestMethod.POST)
	public ModelAndView telefonePost(@RequestParam Map<String, String> allRequestParam, ModelMap model) {

		String cmd = allRequestParam.get("botao");
		String aluno = allRequestParam.get("aluno");
		String numero = allRequestParam.get("numero");
		String tipo = allRequestParam.get("tipo");

		if (cmd != null && cmd.equals("Telefones")) {

			return new ModelAndView("redirect:/telefone?aluno=" + aluno, model); 
		}

		// Saída
		String saida = "";
		String erro = "";

		Telefone t = new Telefone();
		Aluno a = new Aluno();

		List<Telefone> telefones = new ArrayList<>();

		try {
			if (!cmd.contains("Listar")) {
				a.setCPF(aluno);
				a = buscarAluno(a);
				t.setAluno(a);
				t.setNumero(numero);
				t.setTipo(tipo);
			}

			if (cmd.contains("Cadastrar") || cmd.contains("Alterar")) {
				t.setNumero(numero);
				t.setTipo(tipo);
			}

			if (cmd.contains("Cadastrar")) {
				saida = cadastrarTelefone(t, a);
			}
			if (cmd.contains("Alterar")) {
				saida = alterarTelefone(t, a);
			}
			if (cmd.contains("Excluir")) {
				saida = excluirTelefone(t, a);
			}
			if (cmd.contains("Buscar")) {
				t = buscarTelefone(t);
				if (t == null) {
					saida = "Nenhum conteudo encontrado com o código especificado.";
				}
			}

			telefones = listarTelefones(aluno);

		} catch (SQLException | ClassNotFoundException e) {
			erro = e.getMessage();
		} finally {
			model.addAttribute("saida", saida);
			model.addAttribute("erro", erro);
			model.addAttribute("telefone", t);
			model.addAttribute("telefones", telefones);
			model.addAttribute("aluno", a);
		}

		return new ModelAndView("telefone");

	}

	private String cadastrarTelefone(Telefone a, Aluno al) throws SQLException, ClassNotFoundException {
		GenericDao gDao = new GenericDao();
		TelefoneDao pDao = new TelefoneDao(gDao);
		String saida = pDao.iudTelefone("I", a, al);
		return saida;

	}

	private String alterarTelefone(Telefone a, Aluno al) throws SQLException, ClassNotFoundException {
		GenericDao gDao = new GenericDao();
		TelefoneDao pDao = new TelefoneDao(gDao);
		String saida = pDao.iudTelefone("U", a, al);
		return saida;

	}

	private String excluirTelefone(Telefone a, Aluno al) throws SQLException, ClassNotFoundException {
		GenericDao gDao = new GenericDao();
		TelefoneDao pDao = new TelefoneDao(gDao);
		String saida = pDao.iudTelefone("D", a, al);
		return saida;

	}

	private Telefone buscarTelefone(Telefone a) throws SQLException, ClassNotFoundException {
		GenericDao gDao = new GenericDao();
		TelefoneDao pDao = new TelefoneDao(gDao);
		a = pDao.consultar(a);
		return a;
	}

	private List<Telefone> listarTelefones(String cpfAluno) throws SQLException, ClassNotFoundException {
		GenericDao gDao = new GenericDao();
		TelefoneDao pDao = new TelefoneDao(gDao);
		List<Telefone> telefones = pDao.listar(cpfAluno);
		return telefones;
	}

	private Aluno buscarAluno(Aluno a) throws SQLException, ClassNotFoundException {
		GenericDao gDao = new GenericDao();
		AlunoDao pDao = new AlunoDao(gDao);
		a = pDao.consultar(a);
		return a;
	}

}
