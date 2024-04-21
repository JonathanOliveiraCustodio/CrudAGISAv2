package br.edu.fateczl.CrudAGISAv2.controller;

import java.sql.Date;
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
import br.edu.fateczl.CrudAGISAv2.model.Curso;
import br.edu.fateczl.CrudAGISAv2.persistence.AlunoDao;
import br.edu.fateczl.CrudAGISAv2.persistence.CursoDao;
import br.edu.fateczl.CrudAGISAv2.persistence.GenericDao;

@Controller
public class AlunoController {

	@RequestMapping(name = "aluno", value = "/aluno", method = RequestMethod.GET)
	public ModelAndView alunoGet(@RequestParam Map<String, String> allRequestParam, ModelMap model) {

		String cmd = allRequestParam.get("cmd");
		String CPF = allRequestParam.get("CPF");

		Aluno a = new Aluno();
		a.setCPF(CPF);

		String saida = "";
		String erro = "";
		List<Aluno> alunos = new ArrayList<>();
		List<Curso> cursos = new ArrayList<>();

		try {
			if (cmd != null) {
				if (cmd.contains("alterar")) {
					a = buscarAluno(a);
				} else 
					if (cmd.contains("excluir")) {
					a = buscarAluno(a);
					saida = excluirAluno(a);
				}
				alunos = listarAlunos();
			}
			cursos = listarCursos();
		} catch (SQLException | ClassNotFoundException e) {
			erro = e.getMessage();
		} finally {
			model.addAttribute("saida", saida);
			model.addAttribute("erro", erro);
			model.addAttribute("aluno", a);
			model.addAttribute("alunos", alunos);
			model.addAttribute("cursos", cursos);
		}

		return new ModelAndView("aluno");
	}

	@RequestMapping(name = "aluno", value = "/aluno", method = RequestMethod.POST)
	public ModelAndView alunoPost(@RequestParam Map<String, String> allRequestParam, ModelMap model) {

		String cmd = allRequestParam.get("botao");
		String CPF = allRequestParam.get("CPF");
		String nome = allRequestParam.get("nome");
		String nomeSocial = allRequestParam.get("nomeSocial");
		String dataNascimento = allRequestParam.get("dataNascimento");
		String telefoneContato = allRequestParam.get("telefoneContato");
		String emailPessoal = allRequestParam.get("emailPessoal");
		String emailCorporativo = allRequestParam.get("emailCorporativo");
		String dataConclusao2Grau = allRequestParam.get("dataConclusao2Grau");
		String instituicaoConclusao2Grau = allRequestParam.get("instituicaoConclusao2Grau");
		String pontuacaoVestibular = allRequestParam.get("pontuacaoVestibular");
		String posicaoVestibular = allRequestParam.get("posicaoVestibular");
		String anoIngresso = allRequestParam.get("anoIngresso");
		String semestreIngresso = allRequestParam.get("semestreIngresso");
		String semestreAnoLimiteGraduacao = allRequestParam.get("semestreAnoLimiteGraduacao");
		String RA = allRequestParam.get("RA");
		String curso = allRequestParam.get("curso");

		// saida
		String saida = "";
		String erro = "";
		Aluno a = new Aluno();
		Curso c = new Curso();
		List<Aluno> alunos = new ArrayList<>();
		List<Curso> cursos = new ArrayList<>();

		if (!cmd.contains("Listar")) {
			a.setCPF((CPF));
		}
		try {
			cursos = listarCursos();

			if (cmd.contains("Cadastrar") || cmd.contains("Alterar")) {

				a.setNome(nome);
				a.setNomeSocial(nomeSocial);
				a.setDataNascimento(Date.valueOf(dataNascimento));
				a.setTelefoneContato(telefoneContato);
				a.setEmailPessoal(emailPessoal);
				a.setEmailCorporativo(emailCorporativo);
				a.setDataConclusao2Grau(Date.valueOf(dataConclusao2Grau));
				a.setInstituicaoConclusao2Grau(instituicaoConclusao2Grau);
				a.setPontuacaoVestibular(Float.parseFloat(pontuacaoVestibular));
				a.setPosicaoVestibular(Integer.parseInt(posicaoVestibular));
				a.setAnoIngresso(Integer.parseInt(anoIngresso));
				a.setSemestreIngresso(Integer.parseInt(semestreIngresso));
				a.setSemestreAnoLimiteGraduacao(Date.valueOf(semestreAnoLimiteGraduacao));
				a.setRA(Integer.parseInt(RA));

				c.setCodigo(Integer.parseInt(curso));
				c = buscarCurso(c);
				a.setCurso(c);
			}

			if (cmd.contains("Cadastrar")) {
				saida = cadastrarAluno(a);
				a = null;
			}
			if (cmd.contains("Alterar")) {
				saida = alterarAluno(a);
				a = null;
			}
			if (cmd.contains("Excluir")) {
				a = buscarAluno(a);
				saida = excluirAluno(a);
				a = null;
			}
			if (cmd.contains("Buscar")) {
				a = buscarAluno(a);
				if (a == null) {
					saida = "Nenhum aluno encontrado com o CPF especificado.";
					a = null;
				}
			}
			if (cmd != null && !cmd.isEmpty() && cmd.contains("Limpar")) {
				a = null;
			}

			if (cmd.contains("Listar")) {
				alunos = listarAlunos();
			}

			if (cmd.contains("Telefone")) {
				a = buscarAluno(a);
				if (a == null) {
					saida = "Nenhum aluno encontrado com o CPF especificado.";
					a = null;
				} else {
					model.addAttribute("aluno", a);
					return new ModelAndView("forward:/telefone", model);
				}
			}
		} catch (SQLException | ClassNotFoundException e) {
			erro = e.getMessage();
		} finally {
			model.addAttribute("saida", saida);
			model.addAttribute("erro", erro);
			model.addAttribute("aluno", a);
			model.addAttribute("alunos", alunos);
			model.addAttribute("cursos", cursos);
		}

		return new ModelAndView("aluno");
	}

	private String cadastrarAluno(Aluno a) throws SQLException, ClassNotFoundException {
		GenericDao gDao = new GenericDao();
		AlunoDao pDao = new AlunoDao(gDao);
		String saida = pDao.iudAluno("I", a);
		return saida;

	}

	private String alterarAluno(Aluno a) throws SQLException, ClassNotFoundException {
		GenericDao gDao = new GenericDao();
		AlunoDao pDao = new AlunoDao(gDao);
		String saida = pDao.iudAluno("U", a);
		return saida;

	}

	private String excluirAluno(Aluno a) throws SQLException, ClassNotFoundException {
		GenericDao gDao = new GenericDao();
		AlunoDao pDao = new AlunoDao(gDao);
		String saida = pDao.iudAluno("D", a);
		return saida;

	}

	private Aluno buscarAluno(Aluno a) throws SQLException, ClassNotFoundException {
		GenericDao gDao = new GenericDao();
		AlunoDao pDao = new AlunoDao(gDao);
		a = pDao.consultar(a);
		return a;
	}

	private List<Aluno> listarAlunos() throws SQLException, ClassNotFoundException {
		GenericDao gDao = new GenericDao();
		AlunoDao pDao = new AlunoDao(gDao);
		List<Aluno> alunos = pDao.listar();
		return alunos;
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