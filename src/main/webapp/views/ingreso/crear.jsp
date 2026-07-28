<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="service.*, model.*, java.util.*" %>
<%
    request.setAttribute("titulo", "Nuevo Ingreso - Sistema FitCIMM");
%>
<jsp:include page="../includes/header.jsp" />
<jsp:include page="../includes/navbar.jsp" />

<div class="container my-4">
    <div class="row mb-4">
        <div class="col-12">
            <h2><i class="bi bi-door-open-fill text-success"></i> Registrar Ingreso</h2>
        </div>
    </div>

    <div class="row justify-content-center">
        <div class="col-lg-6 col-md-8">
            <div class="card shadow-sm">
                <div class="card-header card-header-sena">
                    <h5 class="mb-0"><i class="bi bi-person-vcard"></i> Control de Acceso</h5>
                </div>

                <div class="card-body">
                    <form action="<%= request.getContextPath()%>/controllers/ingreso/procesar.jsp" method="post">
                        <input type="hidden" name="accion" value="crear">

                        <h6 class="text-muted mb-3"><i class="bi bi-qr-code-scan"></i> Validación de Socio</h6>

                        <div class="row">
                            <div class="col-12 mb-3">
                                <label class="form-label">Número de Documento <span class="text-danger">*</span></label>
                                <input type="text" class="form-control form-control-lg" name="documento" 
                                       placeholder="Ingrese o escanee el documento" required maxlength="20" autofocus>
                            </div>
                        </div>
                        
                        <hr class="my-4">

                        <div class="d-flex justify-content-between">
                            <a href="<%= request.getContextPath()%>/controllers/ingreso/listar.jsp" class="btn btn-secondary">
                                <i class="bi bi-arrow-left"></i> Cancelar
                            </a>
                            <button type="submit" class="btn btn-success">
                                <i class="bi bi-check-circle"></i> Confirmar Ingreso
                            </button>
                        </div>
                    </form>
                </div> 
            </div>

            <div class="alert alert-info mt-3 border-0">
                <i class="bi bi-info-circle"></i> 
                <strong>Nota:</strong> El sistema verificará automáticamente si el socio tiene una membresía activa antes de permitir el ingreso.
            </div>
        </div>
    </div>
</div>