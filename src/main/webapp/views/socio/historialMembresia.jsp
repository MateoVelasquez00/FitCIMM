<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="service.*, model.*, java.util.*, java.time.LocalDate" %>
<%
    int idSocio = Integer.parseInt(request.getParameter("idSocio"));
    SocioService service = new SocioService();

    Socio socio = service.MtObtenerPorId(idSocio); 
    List<Membresia> historial = service.MtDetalleSocio(idSocio);
    
    request.setAttribute("titulo", "Historial de Membresías - FitCIMM");
%>
<jsp:include page="../includes/header.jsp" />
<jsp:include page="../includes/navbar.jsp" />

<style>
    .card-kpi {
        transition: transform 0.2s ease, box-shadow 0.2s ease;
        border: 1px solid rgba(0,0,0,0.08) !important;
    }
    .icon-box {
        width: 48px;
        height: 48px;
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
    .table-custom tbody tr {
        vertical-align: middle;
        transition: background-color 0.15s ease;
    }
</style>

<div class="container my-5">

    <div class="row mb-4">
        <div class="col-12">
            <div class="p-4 p-md-5 bg-dark text-white rounded-4 shadow-sm position-relative overflow-hidden" 
                 style="background: linear-gradient(135deg, #121212 0%, #212529 100%);">
                <div class="row align-items-center">
                    <div class="col-md-8">
                        <div class="d-flex align-items-center gap-2 mb-3">
                            <span class="badge bg-danger text-uppercase px-3 py-2 fw-bold" style="letter-spacing: 1px;">Socio FitCIMM</span>
                        </div>
                        <h1 class="display-6 fw-extrabold mb-2">
                            <%= socio != null ? socio.getNombre() + " " + socio.getApellido() : "Socio No Encontrado" %>
                        </h1>
                        <p class="text-secondary fs-6 mb-0">
                            <i class="bi bi-card-heading me-1 text-danger"></i> Documento: <%= socio != null ? socio.getDocumento() : "N/A" %> | 
                            <i class="bi bi-clock-history me-1 text-danger"></i> Historial completo de membresias y renovaciones.
                        </p>
                    </div>
                    <div class="col-md-4 text-end d-none d-md-block">
                        <a href="listar.jsp" class="btn btn-outline-light btn-action-pro px-4 py-2">
                            <i class="bi bi-arrow-left me-2"></i>Volver a Socios
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="d-block d-md-none mb-3">
        <a href="listar.jsp" class="btn btn-outline-dark btn-action-pro w-100">
            <i class="bi bi-arrow-left me-2"></i>Volver a Socios
        </a>
    </div>

    <!-- Métrica Rápida -->
    <div class="d-flex align-items-center justify-content-between mb-3">
        <h5 class="fw-bold m-0 text-uppercase text-muted" style="letter-spacing: 1px; font-size: 0.85rem;">
            <i class="bi bi-award-fill text-danger me-2"></i> Registro de Membresías
        </h5>
        <span class="badge bg-dark rounded-pill px-3 py-2">
            Total Registros: <%= historial != null ? historial.size() : 0 %>
        </span>
    </div>

    <!-- Tabla Principal con Estilo Card -->
    <div class="card card-kpi bg-white rounded-4 shadow-sm overflow-hidden mb-5">
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover table-custom mb-0">
                    <thead class="bg-light border-bottom">
                        <tr class="text-uppercase text-muted fs-7 fw-bold" style="letter-spacing: 0.5px;">
                            <th class="py-3 px-4">Código / ID</th>
                            <th class="py-3">Fecha Inicio</th>
                            <th class="py-3">Fecha Fin</th>
                            <th class="py-3">Monto Pagado</th>
                            <th class="py-3 text-center">Estado Cobertura</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% if (historial == null || historial.isEmpty()) { %>
                        <tr>
                            <td colspan="5" class="text-center py-5">
                                <div class="py-4">
                                    <div class="icon-box bg-danger bg-opacity-10 text-danger mx-auto mb-3" style="width: 64px; height: 64px;">
                                        <i class="bi bi-inbox-fill fs-2"></i>
                                    </div>
                                    <h6 class="fw-bold text-dark">Sin registros de membresía</h6>
                                    <p class="text-muted small mb-0">Este socio no cuenta con suscripciones ni ventas asociadas en el sistema.</p>
                                </div>
                            </td>
                        </tr>
                        <% } else {
                            LocalDate hoy = LocalDate.now();
                            for (Membresia m : historial) {
                                boolean esVigente = m.getFechaFin() != null && !m.getFechaFin().isBefore(hoy);
                        %>
                        <tr>
                            <td class="px-4">
                                <div class="d-flex align-items-center gap-3">
                                    <div class="icon-box bg-dark bg-opacity-10 text-dark">
                                        <i class="bi bi-receipt fs-5"></i>
                                    </div>
                                    <div>
                                        <span class="fw-bold text-dark d-block">#MB-<%= m.getId() %></span>
                                        <span class="text-muted small">Membresias</span>
                                    </div>
                                </div>
                            </td>
                            <td>
                                <span class="fw-semibold text-dark"><%= m.getFechaInicio() %></span>
                            </td>
                            <td>
                                <span class="fw-semibold text-dark"><%= m.getFechaFin() %></span>
                            </td>
                            <td>
                                <span class="fs-6 fw-extrabold text-success">
                                    $ <%= String.format("%,.2f", m.getValorPagado()) %>
                                </span>
                            </td>
                            <td class="text-center">
                                <% if (esVigente) { %>
                                    <span class="badge bg-success bg-opacity-10 text-success border border-success border-opacity-25 px-3 py-2 rounded-pill fw-bold">
                                        <i class="bi bi-check-circle-fill me-1"></i> Vigente
                                    </span>
                                <% } else { %>
                                    <span class="badge bg-secondary bg-opacity-10 text-secondary border border-secondary border-opacity-25 px-3 py-2 rounded-pill fw-bold">
                                        <i class="bi bi-x-circle-fill me-1"></i> Vencida
                                    </span>
                                <% } %>
                            </td>
                        </tr>
                        <%  } 
                           } %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

</div>