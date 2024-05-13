package br.edu.fateczl.CrudAGISAv2.model;

import java.sql.Date;
import java.text.SimpleDateFormat;

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
	Professor professor;
	MatriculaDisciplina matriculaDisciplina;
	
	public String toString() {
        if (dataChamada != null) {
            SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
            return dateFormat.format(dataChamada);
        } else {
            return "null";
        }
    }
}


