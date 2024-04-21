package br.edu.fateczl.CrudAGISAv2.model;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class Professor {
	 int codigo;
	 String nome;
	 String titulacao;
	 
	@Override
	public String toString() {
		return nome;
	}
	
	
	 
	 

}
