<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="service.*, model.*, java.util.*" %>
<%
    request.setAttribute("titulo", "Nuevo Socio - Sistema FitCIMM");
%>
<jsp:include page="../includes/header.jsp" />
<jsp:include page="../includes/navbar.jsp" />

<div class="container my-4">
    <div class="row mb-4">
        <div class="col-12">
            <h2><i class="bi bi-person-fill-add text-success"></i> Nuevo Socio</h2>
        </div>
    </div>

    <div class="row justify-content-center">
        <div class="col-lg-10">
            <div class="card shadow-sm">
                <div class="card-header card-header-sena">
                    <h5 class="mb-0"><i class="bi bi-person-vcard"></i> Datos del Socio</h5>
                </div>
                
                <div class="card-body">
                    <form action="<%= request.getContextPath()%>/controllers/socio/procesar.jsp" method="post">
                        <input type="hidden" name="accion" value="crear">

                        <!-- Sección: Información Personal -->
                        <h6 class="text-muted mb-3"><i class="bi bi-person"></i> Información Personal</h6>

                        <div class="row">
                            <div class="col-md-3 mb-3">
                                <label class="form-label">Número Documento <span class="text-danger">*</span></label>
                                <input type="text" class="form-control" name="documento" 
                                       placeholder="123456789" required maxlength="20">
                            </div>

                            <div class="col-md-3 mb-3">
                                <label class="form-label">Nombres <span class="text-danger">*</span></label>
                                <input type="text" class="form-control" name="nombres" 
                                       placeholder="Juan Carlos" required maxlength="100">
                            </div>

                            <div class="col-md-3 mb-3">
                                <label class="form-label">Apellidos <span class="text-danger">*</span></label>
                                <input type="text" class="form-control" name="apellidos" 
                                       placeholder="Pérez Gómez" required maxlength="100">
                            </div>

                            <div class="col-md-3 mb-3">
                                <label class="form-label">Fecha de Nacimiento <span class="text-danger">*</span></label>
                                <input type="date" class="form-control" name="fechaNacimiento" required>
                            </div>
                        </div>

                        <hr class="my-3">

                        <h6 class="text-muted mb-3"><i class="bi bi-telephone"></i> Información de Contacto</h6>

                        <div class="row">
                            <div class="col-md-4 mb-3">
                                <label class="form-label">Email <span class="text-danger">*</span></label>
                                <input type="email" class="form-control" name="email" 
                                       placeholder="ejemplo@mail.com" required maxlength="100">
                            </div>

                            <div class="col-md-4 mb-3">
                                <label class="form-label">Teléfono</label>
                                <input type="tel" class="form-control" name="telefono" 
                                       placeholder="3101234567" maxlength="20">
                            </div>

                            <div class="col-md-4 mb-3">
                                <label class="form-label">Estado <span class="text-danger">*</span></label>
                                <select class="form-select" name="estado" required>
                                    <option value="true" selected>ACTIVO</option>
                                    <option value="false">INACTIVO</option>
                                </select>
                            </div>
                        </div>

                        <hr class="my-4">

                        <div class="d-flex justify-content-between">
                            <a href="<%= request.getContextPath()%>/controllers/socio/listar.jsp" class="btn btn-secondary">
                                <i class="bi bi-arrow-left"></i> Cancelar
                            </a>
                            <button type="submit" class="btn btn-success">
                                <i class="bi bi-save"></i> Guardar Socio
                            </button>
                        </div>
                    </form>
                </div> 
            </div>

            <div class="alert alert-info mt-3 border-0">
                <i class="bi bi-info-circle"></i> 
                <strong>Nota:</strong> El número de documento debe ser único en el sistema. - La edad minima son 15 años.
            </div>
        </div>
    </div>
</div>