package br.edu.fateczl.CrudAGISAv2.model;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter

public class Conteudo {
	int codigo;			
	String nome;				
	String descricao;		
	Disciplina disciplina;
	
	@Override
	public String toString() {
		return nome;
	}

}



