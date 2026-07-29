<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="service.*, model.*, java.util.*, java.text.DecimalFormat" %>
<%
    request.setAttribute("titulo", "Planes - Sistema SENA");

    PlanService service = new PlanService();
    List<Plan> planes = service.MtListarPlanes();
    DecimalFormat formatoMoneda = new DecimalFormat("$#,##0");
    
%>
<jsp:include page="../includes/header.jsp" />
<jsp:include page="../includes/navbar.jsp" />

<div class="container">
    <!-- Mensajes -->
    <%
        String mensaje = (String) session.getAttribute("mensaje");
        String tipoMensaje = (String) session.getAttribute("tipoMensaje");
        if (mensaje != null) {
            session.removeAttribute("mensaje");
            session.removeAttribute("tipoMensaje");
    %>
    <div class="alert alert-<%= tipoMensaje%> alert-dismissible fade show" role="alert">
        <i class="bi <%= "success".equals(tipoMensaje) ? "bi-check-circle-fill" : "bi-exclamation-triangle-fill"%>"></i>
        <%= mensaje%>
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>
    <% }%>
    
    <div class="row mb-4 align-items-center">
        <div class="col-md-6">
            <h2><i class="bi bi-people-fill text-warning"></i> Gestión de Planes</h2>
            <p class="text-muted mb-0">Administración de Planes FitCIMM</p>
        </div>
        <div class="col-md-6 text-end d-flex justify-content-end gap-2 mt-3 mt-md-0">
            <a href="<%= request.getContextPath()%>/views/plan/top.jsp" class="btn btn-outline-warning text-dark">
                <i class="bi bi-trophy-fill"></i> Plan Más Vendido
            </a>
            <a href="<%= request.getContextPath()%>/views/plan/crear.jsp" class="btn btn-sena">
                <i class="bi bi-plus-circle"></i> Nuevo Plan
            </a>
        </div>
    </div>

    <!-- Tabla de Planes -->
    <div class="card shadow-sm">
        <div class="card-header card-header-sena">
            <h5 class="mb-0"><i class="bi bi-list"></i> Lista de Planes</h5>
        </div>
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover mb-0">
                    <thead class="table-light">
                        <tr>
                            <th>Nombre</th>
                            <th>Duracion Dias</th>
                            <th>Valor</th>
                            <th>Estado</th>
                            <th class="text-center">Acciones</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% if (planes.isEmpty()) { %>
                        <tr>
                            <td colspan="5" class="text-center py-4 text-muted">
                                <i class="bi bi-inbox fs-1 d-block mb-2"></i>
                                No hay planes registrados
                            </td>
                        </tr>
                        <% } else {
                            for (Plan p : planes) {
                        %>
                        <tr>
                            <td><%= p.getNombre()%></td>
                            <td><%= p.getDuracionDias()%></td>
                            <td><small><%= formatoMoneda.format(p.getValor()) %></small></td>
                            <td>
                                <% if (p.isEstado()) {%>
                                <a href="<%= request.getContextPath()%>/controllers/plan/procesar.jsp?accion=cambiarEstado&id=<%= p.getId()%>&nuevoEstado=false" 
                                   class="badge badge-activo text-decoration-none" 
                                   title="Clic para Desactivar"
                                   onclick="return confirm('¿Desea cambiar el estado a INACTIVO?');">
                                    <i class="bi bi-check-circle"></i> ACTIVO
                                </a>
                                <% } else {%>
                                <a href="<%= request.getContextPath()%>/controllers/plan/procesar.jsp?accion=cambiarEstado&id=<%= p.getId()%>&nuevoEstado=true" 
                                   class="badge badge-inactivo text-decoration-none" 
                                   title="Clic para Activar"
                                   onclick="return confirm('¿Desea cambiar el estado a ACTIVO?');">
                                    <i class="bi bi-x-circle"></i> INACTIVO
                                </a>
                                <% }%>
                            </td>
                            <td class="text-center">
                                <a href="<%= request.getContextPath()%>/controllers/plan/editar.jsp?id=<%= p.getId()%>" 
                                   class="btn btn-sm btn-warning" 
                                   title="Editar">
                                    <i class="bi bi-pencil"></i>
                                </a>
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