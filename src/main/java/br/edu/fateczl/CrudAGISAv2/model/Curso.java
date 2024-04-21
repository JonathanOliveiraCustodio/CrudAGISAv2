package br.edu.fateczl.CrudAGISAv2.model;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class Curso {
    int codigo;
    String nome;
    int cargaHoraria;			
    String sigla;
    float ultimaNotaENADE;
    String turno;
    Date periodoMatriculaInicio;
    Date periodoMatriculaFim;
    
    @Override
	public String toString() {
		return nome + " " + turno;
	}

}
