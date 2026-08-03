<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="controller.MembresiaController, model.Membresia, java.util.List" %>
<%
    request.setAttribute("titulo", "Gestión de Membresías - Sistema FitCIMM");

    MembresiaController controller = new MembresiaController();
    controller.MtListarMembresias();
    List<Membresia> membresias = controller.getMembresias();

    String mensaje = (String) session.getAttribute("mensaje");
    String tipoMensaje = (String) session.getAttribute("tipoMensaje");
    if (mensaje != null) {
        session.removeAttribute("mensaje");
        session.removeAttribute("tipoMensaje");
    }
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

    <% if (mensaje != null) {
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

    <div class="row mb-4">
        <div class="col-12">
            <div class="p-4 p-md-5 bg-dark text-white rounded-4 shadow-sm position-relative overflow-hidden" 
                 style="background: linear-gradient(135deg, #121212 0%, #212529 100%);">
                <div class="row align-items-center g-4">
                    <div class="col-lg-7 col-xl-8">
                        <div class="d-flex align-items-center gap-2 mb-3">
                            <span class="badge bg-danger text-uppercase px-3 py-2 fw-bold" style="letter-spacing: 1px;">Control de Planes</span>
                        </div>
                        <h1 class="display-6 fw-extrabold mb-2">
                            Gestión de Membresías
                        </h1>
                        <p class="text-secondary fs-6 mb-0">
                            <i class="bi bi-card-heading me-1 text-danger"></i> Administra las membresías activas, vencidas y reporte de la membresía más vendida.
                        </p>
                    </div>

                    <%-- Grupo de Botones Ordenados y Uniformes --%>
                    <div class="col-lg-5 col-xl-4">
                        <div class="d-grid gap-2">
                            <a href="<%= request.getContextPath()%>/views/membresia/crear.jsp" class="btn btn-danger btn-action-pro py-2 shadow-sm d-flex align-items-center justify-content-center">
                                <i class="bi bi-cart-plus-fill me-2 fs-5"></i> Vender / Renovar
                            </a>
                            <div class="row g-2">
                                <div class="col-6">
                                    <a href="<%= request.getContextPath()%>/views/membresia/activos.jsp" class="btn btn-outline-light btn-action-pro py-2 w-100 bg-dark bg-opacity-25 d-flex align-items-center justify-content-center border-secondary text-nowrap">
                                        <i class="bi bi-person-check-fill me-1 text-success"></i> Activos
                                    </a>
                                </div>
                                <div class="col-6">
                                    <a href="<%= request.getContextPath()%>/views/membresia/reporteFechas.jsp" class="btn btn-outline-light btn-action-pro py-2 w-100 bg-dark bg-opacity-25 d-flex align-items-center justify-content-center border-secondary text-nowrap">
                                        <i class="bi bi-cash-stack me-1 text-warning"></i> Reporte
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>

    <div class="d-block d-md-none mb-3">
        <div class="d-grid gap-2">
            <a href="<%= request.getContextPath()%>/views/membresia/crear.jsp" class="btn btn-danger btn-action-pro py-2">
                <i class="bi bi-cart-plus-fill me-1"></i>Vender / Renovar Membresía
            </a>
            <div class="d-flex gap-2">
                <a href="<%= request.getContextPath()%>/views/membresia/activos.jsp" class="btn btn-outline-danger btn-action-pro w-50 py-2">
                    <i class="bi bi-person-check-fill me-1"></i> Activos
                </a>
                <a href="<%= request.getContextPath()%>/views/membresia/reporteFechas.jsp" class="btn btn-outline-dark btn-action-pro w-50 py-2">
                    <i class="bi bi-cash-stack me-1"></i> Reporte
                </a>
            </div>
        </div>
    </div>

    <div class="row g-3 align-items-center mb-4">
        <div class="col-12 text-end">
            <span class="badge bg-white text-dark border px-3 py-2 rounded-pill shadow-sm fs-7">
                <i class="bi bi-card-checklist text-danger me-1"></i> Total Registros: <strong class="text-danger"><%= membresias != null ? membresias.size() : 0%></strong>
            </span>
        </div>
    </div>

    <div class="card card-kpi bg-white rounded-4 shadow-sm overflow-hidden mb-5">
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover table-custom mb-0">
                    <thead class="bg-light border-bottom">
                        <tr class="text-uppercase text-muted fs-7 fw-bold" style="letter-spacing: 0.5px;">
                            <th class="py-3 px-4">Socio</th>
                            <th class="py-3">Plan</th>
                            <th class="py-3 text-center">Fecha Inicio</th>
                            <th class="py-3 text-center">Fecha Fin</th>
                            <th class="py-3 text-end">Valor Pagado</th>
                            <th class="py-3 text-center">Estado</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% if (membresias == null || membresias.isEmpty()) { %>
                        <tr>
                            <td colspan="6" class="text-center py-5">
                                <div class="py-4">
                                    <div class="icon-box bg-danger bg-opacity-10 text-danger mx-auto mb-3" style="width: 64px; height: 64px;">
                                        <i class="bi bi-inbox-fill fs-2"></i>
                                    </div>
                                    <h6 class="fw-bold text-dark">No hay membresías registradas</h6>
                                    <p class="text-muted small mb-0">Aún no se registran renovaciones o compras de planes en el sistema.</p>
                                </div>
                            </td>
                        </tr>
                        <% } else {
                            for (Membresia m : membresias) {
                                String estado = m.getEstadoCalculado();
                                String nombreCompleto = (m.getSocio() != null) ? m.getSocio().getNombre() + " " + m.getSocio().getApellido() : "Socio ID: " + m.getIdSocio();
                                String documento = (m.getSocio() != null) ? m.getSocio().getDocumento() : "-";

                                String iniciales = "";
                                if (m.getSocio() != null) {
                                    iniciales = (m.getSocio().getNombre() != null && !m.getSocio().getNombre().isEmpty() ? m.getSocio().getNombre().substring(0, 1) : "")
                                            + (m.getSocio().getApellido() != null && !m.getSocio().getApellido().isEmpty() ? m.getSocio().getApellido().substring(0, 1) : "");
                                } else {
                                    iniciales = "S";
                                }
                        %>
                        <tr>
                            <td class="px-4">
                                <div class="d-flex align-items-center gap-3">
                                    <div class="avatar-circle text-uppercase">
                                        <%= iniciales%>
                                    </div>
                                    <div>
                                        <span class="fw-bold text-dark d-block"><%= nombreCompleto%></span>
                                        <span class="badge bg-light text-dark border px-2 py-1 font-monospace mt-1">
                                            <i class="bi bi-person-vcard text-muted me-1"></i><%= documento%>
                                        </span>
                                    </div>
                                </div>
                            </td>
                            <td>
                                <span class="fw-semibold text-dark">
                                    <%= (m.getPlan() != null) ? m.getPlan().getNombre() : "Plan ID: " + m.getIdPlan()%>
                                </span>
                            </td>
                            <td class="text-center">
                                <span class="small text-muted"><i class="bi bi-calendar-event me-1"></i><%= m.getFechaInicio()%></span>
                            </td>
                            <td class="text-center">
                                <span class="small fw-bold text-dark"><i class="bi bi-calendar-check me-1"></i><%= m.getFechaFin()%></span>
                            </td>
                            <td class="text-end fw-bold text-dark fs-6">
                                $<%= String.format("%,.0f", m.getValorPagado() != null ? m.getValorPagado().doubleValue() : 0.0)%>
                            </td>
                            <td class="text-center">
                                <% if ("VIGENTE".equalsIgnoreCase(estado)) { %>
                                <span class="badge bg-success bg-opacity-10 text-success border border-success border-opacity-25 px-3 py-2 rounded-pill fw-bold">
                                    <i class="bi bi-check-circle-fill me-1"></i> VIGENTE
                                </span>
                                <% } else if ("POR VENCER".equalsIgnoreCase(estado)) { %>
                                <span class="badge bg-warning bg-opacity-10 text-warning border border-warning border-opacity-25 px-3 py-2 rounded-pill fw-bold">
                                    <i class="bi bi-exclamation-triangle-fill me-1"></i> POR VENCER
                                </span>
                                <% } else { %>
                                <span class="badge bg-danger bg-opacity-10 text-danger border border-danger border-opacity-25 px-3 py-2 rounded-pill fw-bold">
                                    <i class="bi bi-clock-history me-1"></i> VENCIDA
                                </span>
                                <% } %>
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