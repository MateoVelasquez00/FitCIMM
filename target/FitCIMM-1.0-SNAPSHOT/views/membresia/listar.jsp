<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="controller.MembresiaController, model.Membresia, java.util.List" %>
<%
    request.setAttribute("titulo", "Gestión de Membresías - Sistema FitCIMM");

    // Instanciar el controlador y listar
    MembresiaController controller = new MembresiaController();
    controller.MtListarMembresias();
    List<Membresia> membresias = controller.getMembresias();

    // Capturar alertas enviadas por la sesión
    String mensaje = (String) session.getAttribute("mensaje");
    String tipoMensaje = (String) session.getAttribute("tipoMensaje");
    if (mensaje != null) {
        session.removeAttribute("mensaje");
        session.removeAttribute("tipoMensaje");
    }
%>
<jsp:include page="../includes/header.jsp" />
<jsp:include page="../includes/navbar.jsp" />

<div class="container my-4">
    <!-- Mensajes de alerta -->
    <% if (mensaje != null) {%>
    <div class="alert alert-<%= tipoMensaje != null ? tipoMensaje : "info"%> alert-dismissible fade show" role="alert">
        <i class="bi <%= "success".equals(tipoMensaje) ? "bi-check-circle-fill" : "bi-exclamation-triangle-fill"%> me-2"></i>
        <%= mensaje%>
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>
    <% }%>

    <!-- Encabezado y Acciones principales -->
    <div class="row mb-4 align-items-center">
        <div class="col-md-8">
            <h2><i class="bi bi-card-heading text-primary"></i> Control de Membresías</h2>
            <p class="text-muted mb-0">Historial de ventas y renovaciones de planes por socio</p>
        </div>
        <div class="col-md-4 text-md-end mt-3 mt-md-0">
            <a href="<%= request.getContextPath()%>/views/membresia/crear.jsp" class="btn btn-success">
                <i class="bi bi-cart-plus-fill"></i> Vender / Renovar Membresía
            </a>
        </div>
    </div>

    <!-- Contador General -->
    <div class="row mb-3">
        <div class="col-12 text-end">
            <span class="text-muted">Total Registros: <strong><%= membresias != null ? membresias.size() : 0%></strong></span>
        </div>
    </div>

    <!-- Tabla de Membresías -->
    <div class="card shadow-sm">
        <div class="card-header card-header-sena">
            <h5 class="mb-0"><i class="bi bi-list-check"></i> Historial de Membresías Activas e Inactivas</h5>
        </div>
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover align-middle mb-0">
                    <thead class="table-light">
                        <tr>
                            <th scope="col">Socio / Documento</th>
                            <th scope="col">Plan</th>
                            <th scope="col" class="text-center">Fecha Inicio</th>
                            <th scope="col" class="text-center">Fecha Fin</th>
                            <th scope="col" class="text-end">Valor Pagado</th>
                            <th scope="col" class="text-center">Estado</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% if (membresias == null || membresias.isEmpty()) { %>
                        <tr>
                            <td colspan="7" class="text-center py-4 text-muted">
                                <i class="bi bi-inbox fs-1 d-block mb-2"></i>
                                No hay historial de membresías registradas.
                            </td>
                        </tr>
                        <% } else {
                            for (Membresia m : membresias) {
                                String estado = m.getEstadoCalculado(); // ACTIVA o VENCIDA
                        %>
                        <tr>
                            <td>
                                <div>
                                    <strong><%= (m.getSocio() != null) ? m.getSocio().getNombre() + " " + m.getSocio().getApellido() : "Socio ID: " + m.getIdSocio()%></strong>
                                </div>
                                <small class="text-muted">
                                    <i class="bi bi-person-vcard"></i> <%= (m.getSocio() != null) ? m.getSocio().getDocumento() : "-"%>
                                </small>
                            </td>
                            <td>
                                <span class="fw-semibold">
                                    <%= (m.getPlan() != null) ? m.getPlan().getNombre() : "Plan ID: " + m.getIdPlan()%>
                                </span>
                            </td>
                            <td class="text-center">
                                <small class="text-muted"><%= m.getFechaInicio()%></small>
                            </td>
                            <td class="text-center">
                                <small class="fw-bold"><%= m.getFechaFin()%></small>
                            </td>
                            <td class="text-end text-success fw-bold">
                                $<%= String.format("%,.0f", m.getValorPagado() != null ? m.getValorPagado().doubleValue() : 0.0)%>
                            </td>
                            <td class="text-center">
                                <% if ("VIGENTE".equalsIgnoreCase(estado)) { %>
                                <span class="badge bg-success"><i class="bi bi-check-circle"></i> VIGENTE</span>
                                <% } else if ("POR VENCER".equalsIgnoreCase(estado)) { %>
                                <span class="badge bg-warning text-dark"><i class="bi bi-exclamation-triangle"></i> POR VENCER</span>
                                <% } else { %>
                                <span class="badge bg-danger"><i class="bi bi-clock-history"></i> VENCIDA</span>
                                <% } %>
                            </td>
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