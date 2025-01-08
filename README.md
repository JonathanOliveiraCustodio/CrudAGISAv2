# AGIS - Sistema Acadêmico

Este projeto é uma evolução do sistema acadêmico AGIS, desenvolvido para atender às necessidades de gestão de matrículas, disciplinas, e históricos acadêmicos na FATEC-ZL. O sistema implementa novas funcionalidades para otimizar o gerenciamento de alunos e cursos, utilizando Java Web (Spring Web, JSP, JSTL) com SQL Server.

## Funcionalidades

- **Matrículas Automáticas**: Todos os alunos matriculados no curso pós-vestibular são automaticamente matriculados em todas as disciplinas do curso escolhido. O sistema permite o registro de eliminação de matérias com um conceito que determina que a disciplina foi cursada em outra instituição.
  
- **Lista de Chamada**: A tela de lista de chamada permite que os professores registrem as chamadas para cada hora de aula (2 ou 4 horas por disciplina). As chamadas podem ser atualizadas, mas nunca excluídas após realizadas.

- **Histórico do Aluno**: A tela de histórico permite que a secretaria consulte as informações principais do aluno, como RA, nome completo, curso, data da primeira matrícula, pontuação e posição no vestibular, seguidas pela lista de disciplinas nas quais o aluno foi aprovado, incluindo:
  - Código da disciplina
  - Nome da disciplina
  - Nome do professor
  - Nota final
  - Quantidade de faltas
  Caso o aluno tenha sido dispensado, a nota final será exibida como "D".

## Tecnologias Utilizadas

- Java 11
- Spring Web
- JSP e JSTL
- SQL Server
- Maven

## Funcionalidades Implementadas

1. **Matrículas Automáticas**: Implementação de lógica para matricular automaticamente alunos em todas as disciplinas do curso.
2. **UDFs**:
   - **Lista de Chamada**: Registro e atualização das chamadas de aula.
   - **Histórico do Aluno**: Exibição das matrículas, disciplinas aprovadas, notas e faltas.
3. **Consultas e Relatórios**: Tela para consultar o histórico do aluno, com informações detalhadas de cada disciplina cursada.
   
## Como Executar o Projeto

1. Clone o repositório:

   ```bash
   git clone https://github.com/JonathanOliveiraCustodio/CrudAGISAv2.git
