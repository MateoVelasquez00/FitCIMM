<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="service.*, model.*, java.util.*" %>
<%
    request.setAttribute("titulo", "Socios - Sistema SENA");

    SocioService service = new SocioService();
    List<Socio> socios = null;

    String buscar = request.getParameter("buscar");
    if (buscar != null && !buscar.trim().isEmpty()) {
        socios = service.MtBuscarSocio(buscar);
    } else {
        socios = service.MtListarSocios();
    }
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
    
    <div class="row mb-4">
        <div class="col-md-8">
            <h2><i class="bi bi-people-fill text-warning"></i> Gestión de Socios</h2>
            <p class="text-muted">Administración de Socios FitCIMM</p>
        </div>
        <div class="col-md-4 text-end">
            <a href="<%= request.getContextPath()%>/views/socio/crear.jsp" class="btn btn-sena">
                <i class="bi bi-plus-circle"></i> Nuevo Socio
            </a>
        </div>
    </div>

    <!-- Buscador -->
    <div class="row mb-3">
        <div class="col-md-6">
            <form action="listar.jsp" method="get" class="input-group">
                <input type="text" class="form-control" name="buscar" 
                       placeholder="Buscar por apellido o documento..." 
                       value="<%= buscar != null ? buscar : ""%>">
                <button class="btn btn-outline-secondary" type="submit">
                    <i class="bi bi-search"></i> Buscar
                </button>
                <% if (buscar != null && !buscar.trim().isEmpty()) {%>
                <a href="<%= request.getContextPath()%>/controllers/socio/listar.jsp" class="btn btn-outline-danger">
                    <i class="bi bi-x-circle"></i> Limpiar
                </a>
                <% }%>
            </form>
        </div>
        <div class="col-md-6 text-end">
            <span class="text-muted">Total: <strong><%= socios.size()%></strong> Socio(os)</span>
        </div>
    </div>

    <!-- Tabla de Aprendices -->
    <div class="card shadow-sm">
        <div class="card-header card-header-sena">
            <h5 class="mb-0"><i class="bi bi-list"></i> Lista de Socios</h5>
        </div>
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover mb-0">
                    <thead class="table-light">
                        <tr>
                            <th>Documento</th>
                            <th>Nombres</th>
                            <th>Apellidos</th>
                            <th>Email</th>
                            <th>Teléfono</th>
                            <th>Fecha Nacimiento</th>
                            <th>Estado</th>
                            <th class="text-center">Acciones</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% if (socios.isEmpty()) { %>
                        <tr>
                            <td colspan="7" class="text-center py-4 text-muted">
                                <i class="bi bi-inbox fs-1 d-block mb-2"></i>
                                No hay socios registrados
                            </td>
                        </tr>
                        <% } else {
                            for (Socio a : socios) {
                        %>
                        <tr>
                            <td>
                                <small><%= a.getDocumento()%></small>
                            </td>
                            <td><%= a.getNombre()%></td>
                            <td><%= a.getApellido()%></td>
                            <td><small><%= a.getCorreo()%></small></td>
                            <td><%= a.getTelefono() != null ? a.getTelefono() : "-"%></td>
                            <td><small><%= a.getFechaNacimiento()%></small></td>
                            <td>
                                <% if (a.isEstado()) {%>
                                <a href="<%= request.getContextPath()%>/controllers/socio/procesar.jsp?accion=cambiarEstado&id=<%= a.getId()%>&nuevoEstado=false" 
                                   class="badge badge-activo text-decoration-none" 
                                   title="Clic para Desactivar"
                                   onclick="return confirm('¿Desea cambiar el estado a INACTIVO?');">
                                    <i class="bi bi-check-circle"></i> ACTIVO
                                </a>
                                <% } else {%>
                                <a href="<%= request.getContextPath()%>/controllers/socio/procesar.jsp?accion=cambiarEstado&id=<%= a.getId()%>&nuevoEstado=true" 
                                   class="badge badge-inactivo text-decoration-none" 
                                   title="Clic para Activar"
                                   onclick="return confirm('¿Desea cambiar el estado a ACTIVO?');">
                                    <i class="bi bi-x-circle"></i> INACTIVO
                                </a>
                                <% }%>
                            </td>
                            <td class="text-center">
                                <a href="<%= request.getContextPath()%>/controllers/socio/editar.jsp?id=<%= a.getId()%>" 
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
