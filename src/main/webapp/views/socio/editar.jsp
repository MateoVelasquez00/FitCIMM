<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="service.*, model.*, java.util.*" %>
<%
    request.setAttribute("titulo", "Editar Socio - FitCIMM");

    int id = Integer.parseInt(request.getParameter("id"));
    SocioService socioService = new SocioService();
    Socio socio = socioService.MtObtenerPorId(id);

    if (socio == null) {
        response.sendRedirect("listar.jsp");
        return;
    }
%>
<jsp:include page="../includes/header.jsp" />
<jsp:include page="../includes/navbar.jsp" />

<style>
    .icon-box {
        width: 44px;
        height: 44px;
        display: flex;
        align-items: center;
        justify-content: center;
        border-radius: 10px;
    }
    .form-control:focus, .form-select:focus {
        border-color: #dc3545;
        box-shadow: 0 0 0 0.25rem rgba(220, 53, 69, 0.15);
    }
    .input-group-text {
        border-top-left-radius: 8px;
        border-bottom-left-radius: 8px;
    }
    .form-control, .form-select {
        border-top-right-radius: 8px;
        border-bottom-right-radius: 8px;
    }
</style>

<div class="container my-5">

    <div class="row justify-content-center">
        <div class="col-12">
            <div class="card card-kpi bg-white rounded-4 shadow-sm overflow-hidden mb-5">
                <div class="card-body p-4 p-md-5">
                    
                    <form action="<%= request.getContextPath()%>/controllers/socio/procesar.jsp" method="post">
                        <input type="hidden" name="accion" value="editar">
                        <input type="hidden" name="id" value="<%= socio.getId()%>">

                        <!-- Sección: Información Personal -->
                        <div class="d-flex align-items-center mb-4">
                            <div class="icon-box bg-danger bg-opacity-10 text-danger me-3">
                                <i class="bi bi-person-vcard fs-4"></i>
                            </div>
                            <div>
                                <h5 class="fw-bold mb-0 text-dark">Información Personal</h5>
                                <small class="text-muted">Datos de identificación básica del socio</small>
                            </div>
                        </div>

                        <div class="row g-3 mb-4">
                            <div class="col-md-3">
                                <label class="form-label fw-semibold small text-muted">Número Documento <span class="text-danger">*</span></label>
                                <div class="input-group">
                                    <span class="input-group-text bg-light text-secondary"><i class="bi bi-card-text"></i></span>
                                    <input type="text" class="form-control" name="documento" 
                                           value="<%= socio.getDocumento() %>" required maxlength="20">
                                </div>
                            </div>

                            <div class="col-md-3">
                                <label class="form-label fw-semibold small text-muted">Nombres <span class="text-danger">*</span></label>
                                <div class="input-group">
                                    <span class="input-group-text bg-light text-secondary"><i class="bi bi-person"></i></span>
                                    <input type="text" class="form-control" name="nombres" 
                                           value="<%= socio.getNombre() %>" required maxlength="100">
                                </div>
                            </div>

                            <div class="col-md-3">
                                <label class="form-label fw-semibold small text-muted">Apellidos <span class="text-danger">*</span></label>
                                <div class="input-group">
                                    <span class="input-group-text bg-light text-secondary"><i class="bi bi-person"></i></span>
                                    <input type="text" class="form-control" name="apellidos" 
                                           value="<%= socio.getApellido() %>" required maxlength="100">
                                </div>
                            </div>

                            <div class="col-md-3">
                                <label class="form-label fw-semibold small text-muted">Fecha Nacimiento <span class="text-danger">*</span></label>
                                <div class="input-group">
                                    <span class="input-group-text bg-light text-secondary"><i class="bi bi-calendar-event"></i></span>
                                    <input type="date" class="form-control" name="fechaNacimiento"
                                           value="<%= socio.getFechaNacimiento() %>" required>
                                </div>
                            </div>
                        </div>

                        <hr class="my-4 text-muted opacity-25">

                        <div class="d-flex align-items-center mb-4">
                            <div class="icon-box bg-danger bg-opacity-10 text-danger me-3">
                                <i class="bi bi-telephone-inbound fs-4"></i>
                            </div>
                            <div>
                                <h5 class="fw-bold mb-0 text-dark">Contacto y Estado</h5>
                                <small class="text-muted">Canales de comunicación y estado en la plataforma</small>
                            </div>
                        </div>

                        <div class="row g-3 mb-4">
                            <div class="col-md-4">
                                <label class="form-label fw-semibold small text-muted">Correo Electrónico <span class="text-danger">*</span></label>
                                <div class="input-group">
                                    <span class="input-group-text bg-light text-secondary"><i class="bi bi-envelope"></i></span>
                                    <input type="email" class="form-control" name="email" 
                                           value="<%= socio.getCorreo() %>" required maxlength="100">
                                </div>
                            </div>

                            <div class="col-md-4">
                                <label class="form-label fw-semibold small text-muted">Teléfono de Contacto</label>
                                <div class="input-group">
                                    <span class="input-group-text bg-light text-secondary"><i class="bi bi-telephone"></i></span>
                                    <input type="tel" class="form-control" name="telefono" 
                                           value="<%= socio.getTelefono() %>" maxlength="20">
                                </div>
                            </div>

                            <div class="col-md-4">
                                <label class="form-label fw-semibold small text-muted">Estado de la Cuenta <span class="text-danger">*</span></label>
                                <div class="input-group">
                                    <span class="input-group-text bg-light text-secondary"><i class="bi bi-toggle-on"></i></span>
                                    <select class="form-select" name="estado" required>
                                        <option value="true" <%= socio.isEstado() ? "selected" : ""%>>ACTIVO</option>
                                        <option value="false" <%= !socio.isEstado() ? "selected" : ""%>>INACTIVO</option>
                                    </select>
                                </div>
                            </div>
                        </div>

                        <hr class="my-4 text-muted opacity-25">

                        <div class="d-flex align-items-center justify-content-between pt-2">
                            <a href="<%= request.getContextPath()%>/controllers/socio/listar.jsp" class="btn btn-outline-secondary btn-action-pro px-4 py-2">
                                <i class="bi bi-arrow-left me-1"></i> Cancelar
                            </a>
                            <button type="submit" class="btn btn-warning text-dark btn-action-pro px-4 py-2">
                                <i class="bi bi-check-circle-fill me-1"></i> Guardar Cambios
                            </button>
                        </div>

                    </form>

                </div>
            </div>
        </div>
    </div>

</div>