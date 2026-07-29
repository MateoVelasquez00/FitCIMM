<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="controller.IngresoController, model.Ingreso, java.util.List" %>
<%
    request.setAttribute("titulo", "Historial de Ingresos - Sistema FitCIMM");

    // Instanciar el controlador y listar
    IngresoController controller = new IngresoController();
    controller.MtListarIngresos();
    List<Ingreso> listaIngresos = controller.getIngresos();

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
    <% if (mensaje != null) { %>
    <div class="alert alert-<%= tipoMensaje != null ? tipoMensaje : "info" %> alert-dismissible fade show" role="alert">
        <i class="bi <%= "success".equals(tipoMensaje) ? "bi-check-circle-fill" : "bi-exclamation-triangle-fill" %> me-2"></i>
        <%= mensaje %>
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>
    <% } %>

    <!-- Encabezado y Acciones principales -->
    <div class="row mb-4 align-items-center">
        <div class="col-md-8">
            <h2><i class="bi bi-door-open text-danger"></i> Registro de Ingresos</h2>
            <p class="text-muted mb-0">Historial de accesos marcados en el gimnasio</p>
        </div>
        <div class="col-md-4 text-md-end mt-3 mt-md-0">
            <a href="<%= request.getContextPath()%>/views/ingreso/crear.jsp" class="btn btn-danger text-white fw-bold">
                <i class="bi bi-plus-circle"></i> Registrar Ingreso
            </a>
        </div>
    </div>

    <!-- Contador General -->
    <div class="row mb-3">
        <div class="col-12 text-end">
            <span class="text-muted">Total Registros: <strong><%= listaIngresos != null ? listaIngresos.size() : 0 %></strong></span>
        </div>
    </div>

    <!-- Tabla de Ingresos -->
    <div class="card shadow-sm">
        <div class="card-header card-header-sena">
            <h5 class="mb-0"><i class="bi bi-list-check"></i> Historial de Accesos al Gimnasio</h5>
        </div>
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover align-middle mb-0">
                    <thead class="table-light">
                        <tr>
                            <th scope="col">Socio / Documento</th>
                            <th scope="col" class="text-center">Fecha de Ingreso</th>
                            <th scope="col" class="text-center">Hora de Ingreso</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% if (listaIngresos == null || listaIngresos.isEmpty()) { %>
                        <tr>
                            <td colspan="4" class="text-center py-4 text-muted">
                                <i class="bi bi-inbox fs-1 d-block mb-2"></i>
                                No se encontraron registros de ingreso.
                            </td>
                        </tr>
                        <% } else {
                            for (Ingreso ing : listaIngresos) {
                        %>
                        <tr>
                            <td>
                                <div>
                                    <strong>
                                        <%= (ing.getSocio() != null && ing.getSocio().getNombre() != null) 
                                            ? ing.getSocio().getNombre() + " " + ing.getSocio().getApellido() 
                                            : "Socio ID: " + ing.getIdSocio() %>
                                    </strong>
                                </div>
                                <small class="text-muted">
                                    <i class="bi bi-person-vcard me-1"></i>
                                    <%= (ing.getSocio() != null && ing.getSocio().getDocumento() != null) 
                                        ? ing.getSocio().getDocumento() 
                                        : "-" %>
                                </small>
                            </td>
                            <td class="text-center">
                                <small class="text-muted">
                                    <i class="bi bi-calendar3 me-1"></i><%= ing.getFechaIngreso() %>
                                </small>
                            </td>
                            <td class="text-center">
                                <span class="badge bg-dark text-white">
                                    <i class="bi bi-clock me-1 text-danger"></i><%= ing.getHoraIngreso() %>
                                </span>
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