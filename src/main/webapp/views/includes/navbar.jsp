<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-dark navbar-sena mb-4">
    <div class="container-fluid">
        <a class="navbar-brand d-flex align-items-center" href="<%= request.getContextPath()%>/">
            <i class="bi bi-trophy-fill fs-3 me-2 text-danger"></i>
            <span class="fw-bold">Sistema FitCIMM</span>
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item">
                    <a class="nav-link" href="<%= request.getContextPath()%>/">
                        <i class="bi bi-house-fill"></i> Inicio
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="<%= request.getContextPath()%>/controllers/plan/listar.jsp">
                        <i class="bi bi-wallet2"></i> Planes
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="<%= request.getContextPath()%>/controllers/membresia/listar.jsp">
                        <i class="bi bi-gem"></i> Membresias
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="<%= request.getContextPath()%>/controllers/socio/listar.jsp">
                        <i class="bi bi-people-fill"></i> Socios
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="<%= request.getContextPath()%>/controllers/ingreso/listar.jsp">
                        <i class="bi bi-calendar-check-fill"></i> Ingreso
                    </a>
                </li>
            </ul>
        </div>
    </div>
</nav>