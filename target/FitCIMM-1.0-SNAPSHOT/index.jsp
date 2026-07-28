<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="service.*" %>
<%
    request.setAttribute("titulo", "Inicio - Sistema de Gestión FitCIMM");

    SocioService socioService = new SocioService();
    PlanService planService = new PlanService();
    MembresiaService membresiaService = new MembresiaService();
    IngresoService ingresoService = new IngresoService();

    int totalSocios = socioService.MtListarSocios().size();
    int totalPlanes = planService.MtListarPlanes().size();
    int totalMembresias = membresiaService.MtListarMembresias().size();
    int totalIngresos = ingresoService.MtListarIngresos().size();

    request.setAttribute("totalSocios", totalSocios);
    request.setAttribute("totalPlanes", totalPlanes);
    request.setAttribute("totalMembresias", totalMembresias);
    request.setAttribute("totalIngresos", totalIngresos);
    
%>

<jsp:include page="views/includes/header.jsp" />
<jsp:include page="views/includes/navbar.jsp" />

<div class="container my-4">

    <!-- Hero Section -->
    <div class="row mb-5">
        <div class="col-12">
            <div class="p-5 text-center bg-light rounded-3 shadow">
                <i class="bi bi-trophy-fill text-success" style="font-size: 4rem;"></i>
                <h1 class="display-4 fw-bold text-success">Sistema de Gestión FitCIMM</h1>
                <p class="lead text-muted">
                    Servicio de control de membresías del gimnacio FitCIMM
                </p>
            </div>
        </div>
    </div>

    <!-- Estadísticas -->
    <div class="row mb-5">
        <div class="col-md-3 mb-3">
            <div class="card border-0 shadow-sm h-100">
                <div class="card-body text-center">
                    <i class="bi bi-people-fill text-primary" style="font-size: 3rem;"></i>
                    <h3 class="mt-3 mb-2">${totalSocios}</h3>
                    <p class="text-muted mb-0">Socios Registrados</p>
                </div>
                <div class="card-footer bg-transparent border-0 text-center">
                    <a href="<%= request.getContextPath()%>/views/socio/listar.jsp" class="btn btn-sm btn-success">
                        <i class="bi bi-eye"></i> Ver Socios
                    </a>
                </div>
            </div>
        </div>
        <div class="col-md-3 mb-3">
            <div class="card border-0 shadow-sm h-100">
                <div class="card-body text-center">
                    <i class="bi bi-wallet2 text-primary" style="font-size: 3rem;"></i>
                    <h3 class="mt-3 mb-2">${totalPlanes}</h3>
                    <p class="text-muted mb-0">Planes Registrados</p>
                </div>
                <div class="card-footer bg-transparent border-0 text-center">
                    <a href="<%= request.getContextPath()%>/views/plan/listar.jsp" class="btn btn-sm btn-success">
                        <i class="bi bi-eye"></i> Ver Planes
                    </a>
                </div>
            </div>
        </div>
        <div class="col-md-3 mb-3">
            <div class="card border-0 shadow-sm h-100">
                <div class="card-body text-center">
                    <i class="bi bi-gem text-primary" style="font-size: 3rem;"></i>
                    <h3 class="mt-3 mb-2">${totalMembresias}</h3>
                    <p class="text-muted mb-0">Membresias Vendidas</p>
                </div>
                <div class="card-footer bg-transparent border-0 text-center">
                    <a href="<%= request.getContextPath()%>/views/membresia/listar.jsp" class="btn btn-sm btn-success">
                        <i class="bi bi-eye"></i> Ver Membresias
                    </a>
                </div>
            </div>
        </div>
        <div class="col-md-3 mb-3">
            <div class="card border-0 shadow-sm h-100">
                <div class="card-body text-center">
                    <i class="bi bi-calendar-check-fill text-primary" style="font-size: 3rem;"></i>
                    <h3 class="mt-3 mb-2">${totalIngresos}</h3>
                    <p class="text-muted mb-0">Ingresos Registrados</p>
                </div>
                <div class="card-footer bg-transparent border-0 text-center">
                    <a href="<%= request.getContextPath()%>/views/ingreso/listar.jsp" class="btn btn-sm btn-success">
                        <i class="bi bi-eye"></i> Ver Ingresos
                    </a>
                </div>
            </div>
        </div>
    </div> 

    <!-- Accesos Rápidos -->
    <div class="row mb-5">
        <div class="col-12">
            <h3 class="mb-4"><i class="bi bi-lightning-fill text-warning"></i> Accesos Rápidos</h3>
        </div>

        <div class="col-md-4 mb-3">
            <div class="card border-0 shadow-sm">
                <div class="card-body">
                    <h5 class="card-title">
                        <i class="bi bi-person-plus-fill text-success"></i> Ingreso Diario
                    </h5>
                    <p class="card-text text-muted"> Realizar Ingreso Diario</p>
                    <a href="<%= request.getContextPath()%>/views/socio/crear.jsp" class="btn btn-outline-success btn-sm">
                        <i class="bi bi-arrow-right"></i> Realizar Ingreso
                    </a>
                </div>
            </div>
        </div>
    </div>

</div>