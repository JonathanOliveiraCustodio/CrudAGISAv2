package br.edu.fateczl.CrudAGISAv2.model;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter

public class ListaChamada {
	int codigo;			
	Date dataChamada;	
	int presenca1;
	int presenca2;
	int presenca3;
	int presenca4;
	int codigoMatricula;
	int codigoDisciplina;
	Aluno aluno;
	Disciplina disciplina;
	
	@Override
	public String toString() {
		return "ListaChamada [codigo=" + codigo + "]";
	}
	


}



