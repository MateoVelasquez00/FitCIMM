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

<style>
    .card-kpi {
        transition: transform 0.2s ease, box-shadow 0.2s ease;
        border: 1px solid rgba(0,0,0,0.08) !important;
    }
    .card-kpi:hover {
        transform: translateY(-4px);
        box-shadow: 0 10px 20px rgba(0, 0, 0, 0.08) !important;
    }
    .icon-box {
        width: 52px;
        height: 52px;
        display: flex;
        align-items: center;
        justify-content: center;
        border-radius: 12px;
    }
    .btn-action-pro {
        border-radius: 8px;
        font-weight: 600;
        letter-spacing: 0.3px;
        transition: all 0.2s ease;
    }
</style>

<div class="container my-5">

    <div class="row mb-5">
        <div class="col-12">
            <div class="p-4 p-md-5 bg-dark text-white rounded-4 shadow-sm position-relative overflow-hidden" 
                 style="background: linear-gradient(135deg, #121212 0%, #212529 100%);">
                <div class="row align-items-center">
                    <div class="col-md-8">
                        <span class="badge bg-danger text-uppercase px-3 py-2 mb-3 fw-bold" style="letter-spacing: 1px;">Panel Principal</span>
                        <h1 class="display-5 fw-extrabold mb-2">Sistema de Gestión <span class="text-danger">FitCIMM</span></h1>
                        <p class="text-secondary fs-5 mb-0">Gestión de membresías, socios, planes y ingresos.</p>
                    </div>
                    <div class="col-md-4 text-center d-none d-md-flex justify-content-center align-items-center">
                        <svg xmlns="http://www.w3.org/2000/svg" width="130" height="130" viewBox="0 0 24 24" fill="currentColor" class="text-danger opacity-25">
                            <path d="M6 5a1 1 0 0 1 1 1v12a1 1 0 1 1-2 0V6a1 1 0 0 1 1-1zm-3 2a1 1 0 0 1 1 1v8a1 1 0 1 1-2 0V8a1 1 0 0 1 1-1zm15-2a1 1 0 0 1 1 1v12a1 1 0 1 1-2 0V6a1 1 0 0 1 1-1zm3 2a1 1 0 0 1 1 1v8a1 1 0 1 1-2 0V8a1 1 0 0 1 1-1zM7 11h10v2H7v-2z"/>
                        </svg>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="d-flex align-items-center justify-content-between mb-4">
        <h5 class="fw-bold m-0 text-uppercase text-muted" style="letter-spacing: 1px; font-size: 0.85rem;">
            <i class="bi bi-grid-fill text-danger me-2"></i> Modulo General
        </h5>
    </div>

    <div class="row mb-5 g-4">
        <!-- KPI: Socios -->
        <div class="col-xl-3 col-md-6">
            <div class="card card-kpi bg-white rounded-4 p-3 shadow-sm h-100">
                <div class="card-body d-flex flex-column justify-content-between p-2">
                    <div class="d-flex align-items-center justify-content-between mb-3">
                        <div>
                            <span class="text-muted fw-bold text-uppercase fs-7 d-block mb-1">Socios</span>
                            <h2 class="fw-bold m-0 text-dark">${totalSocios}</h2>
                        </div>
                        <div class="icon-box bg-danger bg-opacity-10 text-danger">
                            <i class="bi bi-people-fill fs-3"></i>
                        </div>
                    </div>
                    <a href="<%= request.getContextPath()%>/controllers/socio/listar.jsp" 
                       class="btn btn-sm btn-light text-dark btn-action-pro w-100 border mt-2 d-flex align-items-center justify-content-center gap-2">
                        <span>Gestionar Socios</span>
                        <i class="bi bi-arrow-right fs-7"></i>
                    </a>
                </div>
            </div>
        </div>

        <div class="col-xl-3 col-md-6">
            <div class="card card-kpi bg-white rounded-4 p-3 shadow-sm h-100">
                <div class="card-body d-flex flex-column justify-content-between p-2">
                    <div class="d-flex align-items-center justify-content-between mb-3">
                        <div>
                            <span class="text-muted fw-bold text-uppercase fs-7 d-block mb-1">Planes</span>
                            <h2 class="fw-bold m-0 text-dark">${totalPlanes}</h2>
                        </div>
                        <div class="icon-box bg-dark bg-opacity-10 text-dark">
                            <i class="bi bi-card-checklist fs-3"></i>
                        </div>
                    </div>
                    <a href="<%= request.getContextPath()%>/controllers/plan/listar.jsp" 
                       class="btn btn-sm btn-light text-dark btn-action-pro w-100 border mt-2 d-flex align-items-center justify-content-center gap-2">
                        <span>Ver Catálogo</span>
                        <i class="bi bi-arrow-right fs-7"></i>
                    </a>
                </div>
            </div>
        </div>

        <div class="col-xl-3 col-md-6">
            <div class="card card-kpi bg-white rounded-4 p-3 shadow-sm h-100">
                <div class="card-body d-flex flex-column justify-content-between p-2">
                    <div class="d-flex align-items-center justify-content-between mb-3">
                        <div>
                            <span class="text-muted fw-bold text-uppercase fs-7 d-block mb-1">Membresías</span>
                            <h2 class="fw-bold m-0 text-dark">${totalMembresias}</h2>
                        </div>
                        <div class="icon-box bg-danger bg-opacity-10 text-danger">
                            <i class="bi bi-award-fill fs-3"></i>
                        </div>
                    </div>
                    <a href="<%= request.getContextPath()%>/controllers/membresia/listar.jsp" 
                       class="btn btn-sm btn-light text-dark btn-action-pro w-100 border mt-2 d-flex align-items-center justify-content-center gap-2">
                        <span>Historial Membresías</span>
                        <i class="bi bi-arrow-right fs-7"></i>
                    </a>
                </div>
            </div>
        </div>

        <div class="col-xl-3 col-md-6">
            <div class="card card-kpi bg-white rounded-4 p-3 shadow-sm h-100">
                <div class="card-body d-flex flex-column justify-content-between p-2">
                    <div class="d-flex align-items-center justify-content-between mb-3">
                        <div>
                            <span class="text-muted fw-bold text-uppercase fs-7 d-block mb-1">Ingresos</span>
                            <h2 class="fw-bold m-0 text-dark">${totalIngresos}</h2>
                        </div>
                        <div class="icon-box bg-dark bg-opacity-10 text-dark">
                            <i class="bi bi-door-open-fill fs-3"></i>
                        </div>
                    </div>
                    <a href="<%= request.getContextPath()%>/controllers/ingreso/listar.jsp" 
                       class="btn btn-sm btn-light text-dark btn-action-pro w-100 border mt-2 d-flex align-items-center justify-content-center gap-2">
                        <span>Registro Accesos</span>
                        <i class="bi bi-arrow-right fs-7"></i>
                    </a>
                </div>
            </div>
        </div>
    </div> 

    <div class="d-flex align-items-center mb-4">
        <h5 class="fw-bold m-0 text-uppercase text-muted" style="letter-spacing: 1px; font-size: 0.85rem;">
            <i class="bi bi-lightning-charge-fill text-danger me-2"></i> Acciones Rapidas
        </h5>
    </div>

    <div class="row g-4">
        <div class="col-md-6">
            <div class="card card-kpi rounded-4 border-0 shadow-sm bg-white p-2">
                <div class="card-body d-flex align-items-center justify-content-between">
                    <div class="d-flex align-items-center gap-3">
                        <div class="icon-box bg-danger text-white rounded-3">
                            <i class="bi bi-person-check-fill fs-4"></i>
                        </div>
                        <div>
                            <h6 class="fw-bold mb-1 text-dark">Marcar Ingreso Diario</h6>
                            <p class="text-muted small mb-0">Valida la entrada de un socio al gimnasio.</p>
                        </div>
                    </div>
                    <a href="<%= request.getContextPath()%>/views/ingreso/crear.jsp" class="btn btn-danger btn-action-pro px-4 py-2 text-white">
                        Registrar
                    </a>
                </div>
            </div>
        </div>

        <div class="col-md-6">
            <div class="card card-kpi rounded-4 border-0 shadow-sm bg-white p-2">
                <div class="card-body d-flex align-items-center justify-content-between">
                    <div class="d-flex align-items-center gap-3">
                        <div class="icon-box bg-dark text-white rounded-3">
                            <i class="bi bi-cart-plus-fill fs-4"></i>
                        </div>
                        <div>
                            <h6 class="fw-bold mb-1 text-dark">Vender / Renovar</h6>
                            <p class="text-muted small mb-0">Asigna un plan o renueva una membresia.</p>
                        </div>
                    </div>
                    <a href="<%= request.getContextPath()%>/views/membresia/crear.jsp" class="btn btn-dark btn-action-pro px-4 py-2">
                        Nueva Venta
                    </a>
                </div>
            </div>
        </div>
    </div>
</div>