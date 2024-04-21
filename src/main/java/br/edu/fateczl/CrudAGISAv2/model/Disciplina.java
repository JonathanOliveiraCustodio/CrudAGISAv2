package br.edu.fateczl.CrudAGISAv2.model;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class Disciplina {
	
	int codigo;
	String nome;
	int horasSemanais;
	String horaInicio;
	int semestre;
	String diaSemana;
	Professor professor;
	Curso curso;
	

	@Override
	public String toString() {
		return nome;
	} 

}
