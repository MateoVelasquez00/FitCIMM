<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String uri = request.getRequestURI();
%>

<style>
    .navbar-fitcimm {
        background: linear-gradient(135deg, #121212 0%, #1e2227 100%) !important;
        border-bottom: 1px solid rgba(255, 255, 255, 0.08);
        padding: 0.8rem 1rem;
        transition: all 0.3s ease;
    }

    .navbar-fitcimm .navbar-brand {
        font-weight: 800;
        letter-spacing: -0.5px;
        color: #ffffff !important;
    }

    .brand-icon-box {
        width: 38px;
        height: 38px;
        background: rgba(220, 53, 69, 0.15);
        border: 1px solid rgba(220, 53, 69, 0.3);
        border-radius: 10px;
        display: flex;
        align-items: center;
        justify-content: center;
        transition: transform 0.2s ease;
    }

    .navbar-fitcimm .navbar-brand:hover .brand-icon-box {
        transform: scale(1.05);
    }

    .navbar-fitcimm .nav-link {
        color: rgba(255, 255, 255, 0.7) !important;
        font-weight: 500;
        font-size: 0.95rem;
        padding: 0.6rem 1rem !important;
        border-radius: 8px;
        transition: all 0.2s ease;
        display: flex;
        align-items: center;
        gap: 0.5rem;
    }

    .navbar-fitcimm .nav-link i {
        font-size: 1.1rem;
        transition: transform 0.2s ease;
    }

    .navbar-fitcimm .nav-link:hover {
        color: #ffffff !important;
        background: rgba(255, 255, 255, 0.08);
    }

    .navbar-fitcimm .nav-link:hover i {
        transform: translateY(-2px);
        color: #dc3545;
    }

    /* Estado activo */
    .navbar-fitcimm .nav-link.active {
        color: #ffffff !important;
        background: rgba(220, 53, 69, 0.18);
        border: 1px solid rgba(220, 53, 69, 0.3);
        font-weight: 600;
    }

    .navbar-fitcimm .nav-link.active i {
        color: #dc3545;
    }

    .navbar-fitcimm .navbar-toggler {
        border: 1px solid rgba(255, 255, 255, 0.15);
        padding: 0.4rem 0.6rem;
        border-radius: 8px;
    }

    .navbar-fitcimm .navbar-toggler:focus {
        box-shadow: 0 0 0 0.25rem rgba(220, 53, 69, 0.25);
    }
</style>

<nav class="navbar navbar-expand-lg navbar-dark navbar-fitcimm mb-4 sticky-top shadow-sm">
    <div class="container">

        <a class="navbar-brand d-flex align-items-center gap-2" href="<%= request.getContextPath()%>/">
            <div class="brand-icon-box">
                <i class="bi bi-trophy-fill text-danger fs-5"></i>
            </div>
            <div class="d-flex flex-column">
                <span class="fs-5 lh-1">FitCIMM</span>
                <small class="text-danger fw-bold text-uppercase" style="font-size: 0.65rem; letter-spacing: 1.5px;"></small>
            </div>
        </a>
            
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" 
                aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto gap-1 mt-3 mt-lg-0">

                <li class="nav-item">
                    <a class="nav-link <%= uri.equals(request.getContextPath() + "/") || uri.endsWith("/index.jsp") ? "active" : ""%>" 
                       href="<%= request.getContextPath()%>/">
                        <i class="bi bi-house-door"></i>
                        <span>Inicio</span>
                    </a>
                </li>

                <li class="nav-item">
                    <a class="nav-link <%= uri.contains("/plan/") ? "active" : ""%>" 
                       href="<%= request.getContextPath()%>/views/plan/listar.jsp">
                        <i class="bi bi-wallet2"></i>
                        <span>Planes</span>
                    </a>
                </li>

                <li class="nav-item">
                    <a class="nav-link <%= uri.contains("/membresia/") ? "active" : ""%>" 
                       href="<%= request.getContextPath()%>/views/membresia/listar.jsp">
                        <i class="bi bi-gem"></i>
                        <span>Membresías</span>
                    </a>
                </li>

                <li class="nav-item">
                    <a class="nav-link <%= uri.contains("/socio/") ? "active" : ""%>" 
                       href="<%= request.getContextPath()%>/views/socio/listar.jsp">
                        <i class="bi bi-people"></i>
                        <span>Socios</span>
                    </a>
                </li>

                <li class="nav-item">
                    <a class="nav-link <%= uri.contains("/ingreso/") ? "active" : ""%>" 
                       href="<%= request.getContextPath()%>/views/ingreso/listar.jsp">
                        <i class="bi bi-calendar-check"></i>
                        <span>Ingresos</span>
                    </a>
                </li>

            </ul>
        </div>

    </div>
</nav>