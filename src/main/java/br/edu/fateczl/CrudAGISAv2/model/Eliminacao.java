package br.edu.fateczl.CrudAGISAv2.model;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class Eliminacao {
	
	int codigo;
	Date dataEliminacao;
	String status;
	String nomeInstituicao;
	int codigoMatricula;
	int codigoDisciplina;
	Aluno aluno;
	Curso curso;
	Disciplina disciplina;
	
}