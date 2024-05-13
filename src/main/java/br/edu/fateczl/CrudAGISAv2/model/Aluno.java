package br.edu.fateczl.CrudAGISAv2.model;


import java.sql.Date;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter

public class Aluno {

	String CPF;
	String nome;
	String nomeSocial;
	Date dataNascimento;
	String telefoneContato;
	String emailPessoal;
	String emailCorporativo;
	Date dataConclusao2Grau;
	String instituicaoConclusao2Grau;
	float pontuacaoVestibular;
	int posicaoVestibular;
	int anoIngresso;
	int semestreIngresso;
	Date semestreAnoLimiteGraduacao;
	int RA;
	Curso curso;
	Matricula matricula;
	

	@Override
	public String toString() {
		return nome;
	}
}
