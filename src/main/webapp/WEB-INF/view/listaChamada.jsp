<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous">
<title>Lista de Chamada</title>
<script>
	function validarBusca() {
		var codigo = document.getElementById("codigo").value;
		if (codigo.trim() === "") {
			alert("Por favor, insira um codigo.");
			return false;
		}
		return true;
	}
</script>


</head>
<body>
	<div>
		<jsp:include page="headerProfessor.jsp" />
	</div>
	<div class="container py-4">
		<div class="p-5 mb-4 bg-body-tertiary rounded-3 text-center shadow">
			<div class="container-fluid py-5">
				<h1 class="display-5 fw-bold">Lista de Chamada</h1>
				<div class="d-flex gap-2 justify-content-center py-2">
					<form action="listaChamada" method="post" class="row g-3 mt-3">
						<label for="data" class="form-label col-md-1">Professor:</label>
						<div class="col-md-2">
							<select class="form-select" id="professor" name="professor">
								<option value="0">Escolha um Professor</option>
								<c:forEach var="p" items="${professores}">
									<c:if
										test="${(empty listaChamada) || (p.codigo ne listaChamada.professor.codigo)}">
										<option value="${p.codigo}"><c:out value="${p}" /></option>
									</c:if>
									<c:if test="${p.codigo eq listaChamada.professor.codigo}">
										<option value="${p.codigo}" selected="selected"><c:out
												value="${p}" /></option>
									</c:if>
								</c:forEach>
							</select>
						</div>
						<div class="col-md-1">
							<input type="submit" id="botao" name="botao"
								class="btn btn-primary" value="Buscar">
						</div>


						<label for="data" class="form-label col-md-1">Disciplina:</label>
						<div class="col-md-3">
							<select class="form-select" id="disciplina" name="disciplina">
								<option value="0">Escolha uma Disciplina</option>
								<c:forEach var="d" items="${disciplinas }">
									<c:if
										test="${(empty listaChamada) || (d.codigo ne listaChamada.disciplina.codigo) }">
										<option value="${d.codigo }"><c:out value="${d }" /></option>
									</c:if>
									<c:if test="${d.codigo eq listaChamada.disciplina.codigo }">
										<option value="${d.codigo }" selected="selected"><c:out
												value="${d }" /></option>
									</c:if>
								</c:forEach>
							</select>
						</div>




						<label for="data" class="form-label col-md-1">Data das
							Chamadas:</label>
						<div class="col-md-3">
							<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

							<select class="form-select" id="dataChamada" name="dataChamada">
								<option value="0">Escolha uma Data</option>
								<c:forEach var="d" items="${datasChamadas}">
									<c:choose>
										<c:when
											test="${empty listaChamada || d ne listaChamada.dataChamada}">
											<option value="${d.dataChamada}">
												<fmt:formatDate value="${d.dataChamada}"
													pattern="dd/MM/yyyy" />
											</option>
										</c:when>
										<c:otherwise>
											<option value="${d.dataChamada}" selected="selected">
												<fmt:formatDate value="${d.dataChamada}"
													pattern="dd/MM/yyyy" />
											</option>
										</c:otherwise>
									</c:choose>
								</c:forEach>
							</select>


						</div>

						<div class="col-md-11"></div>

						<div class="col-md-2 d-grid text-center">
							<input type="submit" id="botao" name="botao" value="Nova Chamada"
								class="btn btn-primary">
						</div>
						<div class="col-md-2 d-grid text-center">
							<input type="submit" id="botao" name="botao" value="Consultar"
								class="btn btn-primary">
						</div>
						<div class="col-md-2 d-grid text-center">
							<input type="submit" id="botao" name="botao"
								class="btn btn-success" value="Cadastrar">
						</div>
						<div class="col-md-2 d-grid text-center">
							<input type="submit" id="botao" name="botao"
								class="btn btn-success" value="Alterar">
						</div>
						<div class="col-md-2 d-grid text-center"></div>
						<div class="col-md-2 d-grid text-center">
							<input type="submit" id="botao" name="botao" value="Limpar"
								class="btn btn-primary">
						</div>

					</form>
				</div>
			</div>
		</div>
	</div>
	<div align="center" class="container"></div>
	<br />
	<div align="center">
		<c:if test="${not empty erro }">
			<h2>
				<b><c:out value="${erro }" /></b>
			</h2>
		</c:if>
	</div>
	<br />
	<div align="center">
		<c:if test="${not empty saida }">
			<h3>
				<b><c:out value="${saida }" /></b>
			</h3>
		</c:if>
	</div>
	<br />
	<div class="container py-4 text-center d-flex justify-content-center"
		align="center">
		<c:if test="${not empty listasChamadas }">
			<table class="table table-striped">
				<thead>
					<tr>
						
						<th class="titulo-tabela" colspan="6"
							style="text-align: center; font-size: 23px;">Lista de
							Chamada, Disciplina: <span id="nomeDisciplina">${disciplina.nome}</span>,
							Data: <span id="dataChamada">${dataChamada}</span>
						</th>

					</tr>
					<tr>
						<th>Nome</th>
						<th>Data Chamada</th>
						<th>Presen�a 1</th>
						<th>Presen�a 2</th>
						<th>Presen�a 3</th>
						<th>Presen�a 4</th>
					</tr>
				</thead>
				<tbody class="table-group-divider">
					<c:forEach var="lc" items="${listasChamadas }">
						<tr>
							<td><c:out value="${lc.aluno.nome }" /></td>

							<td><fmt:formatDate value="${lc.dataChamada}"
									pattern="dd/MM/yyyy" /></td>

							<td><input type="checkbox" name="presenca1" value="1"
								<c:if test="${lc.presenca1 == 1}">checked</c:if>></td>
							<td><input type="checkbox" name="presenca2" value="1"
								<c:if test="${lc.presenca2 == 1}">checked</c:if>></td>
							<td><input type="checkbox" name="presenca3" value="1"
								<c:if test="${lc.presenca3 == 1}">checked</c:if>></td>
							<td><input type="checkbox" name="presenca4" value="1"
								<c:if test="${lc.presenca4 == 1}">checked</c:if>></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</c:if>
	</div>
</body>
</html>