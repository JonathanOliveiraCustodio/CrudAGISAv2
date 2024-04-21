package br.edu.fateczl.CrudAGISAv2.model;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class Telefone{
	Aluno aluno;
	String numero;
	String tipo;
    
    @Override
	public String toString() {
		return numero;
	}

}
