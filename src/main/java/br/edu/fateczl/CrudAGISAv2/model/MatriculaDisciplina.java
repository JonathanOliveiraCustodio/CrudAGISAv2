package br.edu.fateczl.CrudAGISAv2.model;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class MatriculaDisciplina {
	
	int codigoMatricula;
	int codigoDisciplina;
	String situacao;
	double notaFinal;
	int totalFaltas;

}
