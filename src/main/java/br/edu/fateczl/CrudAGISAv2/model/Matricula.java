package br.edu.fateczl.CrudAGISAv2.model;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter

public class Matricula {
	
	int codigo;
	String codigoAluno;
	Date dataMatricula;
	int semestre;

}
