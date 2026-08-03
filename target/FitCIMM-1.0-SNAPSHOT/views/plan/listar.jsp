<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="service.*, model.*, java.util.*, java.text.DecimalFormat" %>
<%
    request.setAttribute("titulo", "Gestión de Planes - FitCIMM");

    PlanService service = new PlanService();
    List<Plan> planes = service.MtListarPlanes();
    DecimalFormat formatoMoneda = new DecimalFormat("$#,##0");
%>
<jsp:include page="../includes/header.jsp" />
<jsp:include page="../includes/navbar.jsp" />

<style>
    .card-kpi {
        transition: transform 0.2s ease, box-shadow 0.2s ease;
        border: 1px solid rgba(0,0,0,0.08) !important;
    }
    .icon-box {
        width: 40px;
        height: 40px;
        display: flex;
        align-items: center;
        justify-content: center;
        border-radius: 10px;
    }
    .btn-action-pro {
        border-radius: 8px;
        font-weight: 600;
        letter-spacing: 0.3px;
        transition: all 0.2s ease;
    }
    .table-custom tbody tr {
        vertical-align: middle;
        transition: background-color 0.15s ease;
    }
    .avatar-circle {
        width: 38px;
        height: 38px;
        border-radius: 50%;
        background-color: rgba(220, 53, 69, 0.1);
        color: #dc3545;
        display: flex;
        align-items: center;
        justify-content: center;
        font-weight: 700;
        font-size: 0.85rem;
    }
</style>

<div class="container my-5">

    <%-- Mensajes Informativos --%>
    <%
        String mensaje = (String) session.getAttribute("mensaje");
        String tipoMensaje = (String) session.getAttribute("tipoMensaje");
        if (mensaje != null) {
            session.removeAttribute("mensaje");
            session.removeAttribute("tipoMensaje");
            boolean esExito = "success".equals(tipoMensaje);
    %>
    <div class="alert alert-<%= esExito ? "success" : "danger"%> alert-dismissible fade show rounded-3 shadow-sm border-0 mb-4" role="alert">
        <div class="d-flex align-items-center">
            <i class="bi <%= esExito ? "bi-check-circle-fill" : "bi-exclamation-triangle-fill"%> fs-5 me-2"></i>
            <div><%= mensaje%></div>
        </div>
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>
    <% }%>

    <%-- Banner Principal --%>
    <div class="row mb-4">
        <div class="col-12">
            <div class="p-4 p-md-5 bg-dark text-white rounded-4 shadow-sm position-relative overflow-hidden" 
                 style="background: linear-gradient(135deg, #121212 0%, #212529 100%);">
                <div class="row align-items-center">
                    <div class="col-md-7">
                        <div class="d-flex align-items-center gap-2 mb-3">
                            <span class="badge bg-danger text-uppercase px-3 py-2 fw-bold" style="letter-spacing: 1px;">Suscripciones</span>
                        </div>
                        <h1 class="display-6 fw-extrabold mb-2">
                            Planes Disponibles
                        </h1>
                        <p class="text-secondary fs-6 mb-0">
                            <i class="bi bi-box-seam me-1 text-danger"></i> Administra la información de los Planes.
                        </p>
                    </div>
                    <div class="col-md-5 text-end d-none d-md-flex justify-content-end gap-2">
                        <a href="<%= request.getContextPath()%>/views/plan/top.jsp" class="btn btn-outline-light btn-action-pro px-3 py-3 shadow-sm">
                            <i class="bi bi-trophy-fill text-warning me-2"></i>Plan Más Vendido
                        </a>
                        <a href="<%= request.getContextPath()%>/views/plan/crear.jsp" class="btn btn-danger btn-action-pro px-5 py-3 shadow-sm">
                            <i class="bi bi-plus-circle-fill me-2"></i>Nuevo Plan
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <%-- Botones Móviles --%>
    <div class="d-grid gap-2 d-md-none mb-3">
        <a href="<%= request.getContextPath()%>/views/plan/crear.jsp" class="btn btn-danger btn-action-pro py-2">
            <i class="bi bi-plus-circle-fill me-2"></i>Nuevo Plan
        </a>
        <a href="<%= request.getContextPath()%>/views/plan/top.jsp" class="btn btn-outline-dark btn-action-pro py-2">
            <i class="bi bi-trophy-fill text-warning me-2"></i>Plan Más Vendido
        </a>
    </div>

    <%-- Contador de Registros --%>
    <div class="row g-3 align-items-center mb-4">
        <div class="col-12 text-md-end">
            <span class="badge bg-white text-dark border px-3 py-2 rounded-pill shadow-sm fs-7">
                <i class="bi bi-box-seam text-danger me-1"></i> Total Planes: <strong class="text-danger"><%= planes != null ? planes.size() : 0%></strong>
            </span>
        </div>
    </div>

    <%-- Tabla de Datos --%>
    <div class="card card-kpi bg-white rounded-4 shadow-sm overflow-hidden mb-5">
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover table-custom mb-0">
                    <thead class="bg-light border-bottom">
                        <tr class="text-uppercase text-muted fs-7 fw-bold" style="letter-spacing: 0.5px;">
                            <th class="py-3 px-4">Nombre del Plan</th>
                            <th class="py-3">Duración</th>
                            <th class="py-3">Valor</th>
                            <th class="py-3 text-center">Estado</th>
                            <th class="py-3 text-center">Acciones</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% if (planes == null || planes.isEmpty()) { %>
                        <tr>
                            <td colspan="5" class="text-center py-5">
                                <div class="py-4">
                                    <div class="icon-box bg-danger bg-opacity-10 text-danger mx-auto mb-3" style="width: 64px; height: 64px;">
                                        <i class="bi bi-inbox-fill fs-2"></i>
                                    </div>
                                    <h6 class="fw-bold text-dark">No se encontraron planes</h6>
                                    <p class="text-muted small mb-0">Agrega un nuevo plan para comenzar a registrar ofertas en el sistema.</p>
                                </div>
                            </td>
                        </tr>
                        <% } else {
                            for (Plan p : planes) {
                        %>
                        <tr>
                            <td class="px-4">
                                <div class="d-flex align-items-center gap-3">
                                    <div class="avatar-circle">
                                        <i class="bi bi-tag-fill"></i>
                                    </div>
                                    <div>
                                        <span class="fw-bold text-dark d-block"><%= p.getNombre()%></span>
                                    </div>
                                </div>
                            </td>
                            <td>
                                <span class="badge bg-light text-dark border px-2 py-1">
                                    <i class="bi bi-clock text-muted me-1"></i><%= p.getDuracionDias()%> Días
                                </span>
                            </td>
                            <td>
                                <span class="fw-bold text-dark font-monospace"><%= formatoMoneda.format(p.getValor())%></span>
                            </td>
                            <td class="text-center">
                                <% if (p.isEstado()) {%>
                                <a href="<%= request.getContextPath()%>/controllers/plan/procesar.jsp?accion=cambiarEstado&id=<%= p.getId()%>&nuevoEstado=false" 
                                   class="badge bg-success bg-opacity-10 text-success border border-success border-opacity-25 px-3 py-2 rounded-pill fw-bold text-decoration-none" 
                                   title="Clic para desactivar plan"
                                   onclick="return confirm('¿Desea cambiar el estado del plan a INACTIVO?');">
                                    <i class="bi bi-check-circle-fill me-1"></i> ACTIVO
                                </a>
                                <% } else {%>
                                <a href="<%= request.getContextPath()%>/controllers/plan/procesar.jsp?accion=cambiarEstado&id=<%= p.getId()%>&nuevoEstado=true" 
                                   class="badge bg-secondary bg-opacity-10 text-secondary border border-secondary border-opacity-25 px-3 py-2 rounded-pill fw-bold text-decoration-none" 
                                   title="Clic para activar plan"
                                   onclick="return confirm('¿Desea cambiar el estado del plan a ACTIVO?');">
                                    <i class="bi bi-x-circle-fill me-1"></i> INACTIVO
                                </a>
                                <% }%>
                            </td>
                            <td class="text-center">
                                <div class="btn-group shadow-sm" role="group">
                                    <a href="<%= request.getContextPath()%>/controllers/plan/editar.jsp?id=<%= p.getId()%>" 
                                       class="btn btn-sm btn-outline-dark" 
                                       title="Editar Plan">
                                        <i class="bi bi-pencil-fill"></i>
                                    </a>
                                </div>
                            </td>
                        </tr>
                        <%
                                }
                            }
                        %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

</div>