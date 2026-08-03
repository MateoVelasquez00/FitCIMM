<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="service.*, model.*, java.util.*" %>
<%
    request.setAttribute("titulo", "Gestión de Socios - FitCIMM");

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
    .form-control:focus {
        border-color: #dc3545;
        box-shadow: 0 0 0 0.25rem rgba(220, 53, 69, 0.15);
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

    <div class="row mb-4">
        <div class="col-12">
            <div class="p-4 p-md-5 bg-dark text-white rounded-4 shadow-sm position-relative overflow-hidden" 
                 style="background: linear-gradient(135deg, #121212 0%, #212529 100%);">
                <div class="row align-items-center">
                    <div class="col-md-8">
                        <div class="d-flex align-items-center gap-2 mb-3">
                            <span class="badge bg-danger text-uppercase px-3 py-2 fw-bold" style="letter-spacing: 1px;">Gestión de Directorio</span>
                            <span class="badge bg-secondary text-uppercase px-3 py-2 fw-bold">FitCIMM System</span>
                        </div>
                        <h1 class="display-6 fw-extrabold mb-2">
                            Socios Registrados
                        </h1>
                        <p class="text-secondary fs-6 mb-0">
                            <i class="bi bi-people me-1 text-danger"></i> Administra la información de los Socio.
                        </p>
                    </div>
                    <div class="col-md-4 text-end d-none d-md-block">
                        <a href="<%= request.getContextPath()%>/views/socio/crear.jsp" class="btn btn-danger btn-action-pro px-4 py-3 shadow-sm">
                            <i class="bi bi-person-plus-fill me-2"></i>Nuevo Socio
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="d-block d-md-none mb-3">
        <a href="<%= request.getContextPath()%>/views/socio/crear.jsp" class="btn btn-danger btn-action-pro w-100 py-2">
            <i class="bi bi-person-plus-fill me-2"></i>Nuevo Socio
        </a>
    </div>

    <div class="row g-3 align-items-center mb-4">
        <div class="col-md-7 col-lg-6">
            <form action="listar.jsp" method="get">
                <div class="input-group shadow-sm rounded-3 overflow-hidden">
                    <span class="input-group-text bg-white border-end-0 text-muted ps-3">
                        <i class="bi bi-search"></i>
                    </span>
                    <input type="text" class="form-control border-start-0 border-end-0 py-2" name="buscar" 
                           placeholder="Buscar por apellido o documento..." 
                           value="<%= buscar != null ? buscar : ""%>">
                    <button class="btn btn-dark px-4 fw-semibold" type="submit">Buscar</button>
                    <% if (buscar != null && !buscar.trim().isEmpty()) {%>
                    <a href="<%= request.getContextPath()%>/controllers/socio/listar.jsp" class="btn btn-outline-secondary px-3" title="Limpiar filtro">
                        <i class="bi bi-x-lg"></i>
                    </a>
                    <% }%>
                </div>
            </form>
        </div>
        <div class="col-md-5 col-lg-6 text-md-end">
            <span class="badge bg-white text-dark border px-3 py-2 rounded-pill shadow-sm fs-7">
                <i class="bi bi-person-badge text-danger me-1"></i> Total Registrados: <strong class="text-danger"><%= socios != null ? socios.size() : 0%></strong>
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
                            <th class="py-3">Documento</th>
                            <th class="py-3">Contacto</th>
                            <th class="py-3">F. Nacimiento</th>
                            <th class="py-3 text-center">Estado</th>
                            <th class="py-3 text-center">Acciones</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% if (socios == null || socios.isEmpty()) { %>
                        <tr>
                            <td colspan="6" class="text-center py-5">
                                <div class="py-4">
                                    <div class="icon-box bg-danger bg-opacity-10 text-danger mx-auto mb-3" style="width: 64px; height: 64px;">
                                        <i class="bi bi-person-x-fill fs-2"></i>
                                    </div>
                                    <h6 class="fw-bold text-dark">No se encontraron socios</h6>
                                    <p class="text-muted small mb-0">Intenta realizar una nueva búsqueda o agrega un nuevo socio al sistema.</p>
                                </div>
                            </td>
                        </tr>
                        <% } else {
                            for (Socio a : socios) {
                                String iniciales = (a.getNombre() != null && !a.getNombre().isEmpty() ? a.getNombre().substring(0, 1) : "")
                                        + (a.getApellido() != null && !a.getApellido().isEmpty() ? a.getApellido().substring(0, 1) : "");
                        %>
                        <tr>
                            <td class="px-4">
                                <div class="d-flex align-items-center gap-3">
                                    <div class="avatar-circle text-uppercase">
                                        <%= iniciales%>
                                    </div>
                                    <div>
                                        <span class="fw-bold text-dark d-block"><%= a.getNombre()%> <%= a.getApellido()%></span>
                                    </div>
                                </div>
                            </td>
                            <td>
                                <span class="badge bg-light text-dark border px-2 py-1 font-monospace"><%= a.getDocumento()%></span>
                            </td>
                            <td>
                                <div class="d-flex flex-column">
                                    <span class="small fw-semibold text-dark"><i class="bi bi-envelope text-muted me-1"></i><%= a.getCorreo()%></span>
                                    <span class="small text-muted"><i class="bi bi-telephone text-muted me-1"></i><%= a.getTelefono() != null ? a.getTelefono() : "N/R"%></span>
                                </div>
                            </td>
                            <td>
                                <span class="small text-muted"><i class="bi bi-calendar3 me-1"></i><%= a.getFechaNacimiento()%></span>
                            </td>
                            <td class="text-center">
                                <% if (a.isEstado()) {%>
                                <a href="<%= request.getContextPath()%>/controllers/socio/procesar.jsp?accion=cambiarEstado&id=<%= a.getId()%>&nuevoEstado=false" 
                                   class="badge bg-success bg-opacity-10 text-success border border-success border-opacity-25 px-3 py-2 rounded-pill fw-bold text-decoration-none" 
                                   title="Clic para desactivar socio"
                                   onclick="return confirm('¿Desea cambiar el estado del socio a INACTIVO?');">
                                    <i class="bi bi-check-circle-fill me-1"></i> ACTIVO
                                </a>
                                <% } else {%>
                                <a href="<%= request.getContextPath()%>/controllers/socio/procesar.jsp?accion=cambiarEstado&id=<%= a.getId()%>&nuevoEstado=true" 
                                   class="badge bg-secondary bg-opacity-10 text-secondary border border-secondary border-opacity-25 px-3 py-2 rounded-pill fw-bold text-decoration-none" 
                                   title="Clic para activar socio"
                                   onclick="return confirm('¿Desea cambiar el estado del socio a ACTIVO?');">
                                    <i class="bi bi-x-circle-fill me-1"></i> INACTIVO
                                </a>
                                <% }%>
                            </td>
                            <td class="text-center">
                                <div class="btn-group shadow-sm" role="group">
                                    <a href="<%= request.getContextPath()%>/controllers/socio/editar.jsp?id=<%= a.getId()%>" 
                                       class="btn btn-sm btn-outline-dark" 
                                       title="Editar Socio">
                                        <i class="bi bi-pencil-fill"></i>
                                    </a>
                                    <a href="<%= request.getContextPath()%>/controllers/socio/historialMembresia.jsp?idSocio=<%= a.getId()%>" 
                                       class="btn btn-sm btn-outline-danger" 
                                       title="Historial de Membresías">
                                        <i class="bi bi-clock-history"></i>
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