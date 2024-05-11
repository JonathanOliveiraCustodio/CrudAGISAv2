<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<title></title>
</head>
<body>
  <div class="container">
  	<header class="d-flex flex-wrap justify-content-center py-3 mb-4 border-bottom">
  		<a class="d-flex align-items-center mb-3 mb-md-0 me-md-auto link-body-emphasis text-decoration-none" href="index">
  			<h3>
  			<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-book" viewBox="0 0 16 16">
			<path d="M1 2.828c.885-.37 2.154-.769 3.388-.893 1.33-.134 2.458.063 3.112.752v9.746c-.935-.53-2.12-.603-3.213-.493-1.18.12-2.37.461-3.287.811zm7.5-.141c.654-.689 1.782-.886 3.112-.752 1.234.124 2.503.523 3.388.893v9.923c-.918-.35-2.107-.692-3.287-.81-1.094-.111-2.278-.039-3.213.492zM8 1.783C7.015.936 5.587.81 4.287.94c-1.514.153-3.042.672-3.994 1.105A.5.5 0 0 0 0 2.5v11a.5.5 0 0 0 .707.455c.882-.4 2.303-.881 3.68-1.02 1.409-.142 2.59.087 3.223.877a.5.5 0 0 0 .78 0c.633-.79 1.814-1.019 3.222-.877 1.378.139 2.8.62 3.681 1.02A.5.5 0 0 0 16 13.5v-11a.5.5 0 0 0-.293-.455c-.952-.433-2.48-.952-3.994-1.105C10.413.809 8.985.936 8 1.783"/>
			</svg>
  			AGIS</h3>
  		</a>
        <ul class="nav nav-pills">
            <li class="nav-item"><a class="nav-link px-2 link-body-emphasis" href="${pageContext.request.contextPath}/aluno">Manter Aluno</a></li>
            <li class="nav-item"><a class="nav-link px-2 link-body-emphasis" href="${pageContext.request.contextPath}/disciplina">Disciplina</a></li>
            <li class="nav-item"><a class="nav-link px-2 link-body-emphasis" href="${pageContext.request.contextPath}/curso">Curso</a></li>
            <li class="nav-item"><a class="nav-link px-2 link-body-emphasis" href="${pageContext.request.contextPath}/professor">Professor</a></li>
            <li class="nav-item"><a class="nav-link px-2 link-body-emphasis" href="${pageContext.request.contextPath}/analisarEliminacao">Solicitações de Dispensas</a></li>
            <li class="nav-item"><a class="nav-link px-2 link-body-emphasis" href="${pageContext.request.contextPath}/periodoMatricula">Periodo de Matrícula</a></li>
        </ul>
  	</header>
  </div>
</body>
</html>