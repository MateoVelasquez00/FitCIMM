<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="service.*, model.*, java.util.*" %>
<%
    request.setAttribute("titulo", "Nuevo Ingreso - Sistema FitCIMM");
%>
<jsp:include page="../includes/header.jsp" />
<jsp:include page="../includes/navbar.jsp" />

<div class="container my-4">
    <div class="row justify-content-center">
        <div class="col-lg-6 col-md-8">
            <div class="card border-0 rounded-4 shadow-sm overflow-hidden mb-4">
                <div class="card-header bg-white border-0 pt-4 px-4 pb-0">
                    <div class="d-flex align-items-center">
                        <div class="icon-box bg-danger bg-opacity-10 text-danger me-3 rounded-3 p-3 d-flex align-items-center justify-content-center">
                            <i class="bi bi-door-open-fill fs-3"></i>
                        </div>
                        <div>
                            <h4 class="fw-bold mb-1 text-dark">Registrar Ingreso</h4>
                            <p class="text-muted small mb-0">Control de acceso rápido y verificación de membresía activa.</p>
                        </div>
                    </div>
                </div>

                <div class="card-body p-4">
                    <form action="<%= request.getContextPath()%>/controllers/ingreso/procesar.jsp" method="post">
                        <input type="hidden" name="accion" value="crear">

                        <h6 class="text-uppercase text-muted fw-bold mb-3 small">
                            <i class="bi bi-qr-code-scan me-1"></i> Validación de Socio
                        </h6>

                        <div class="row g-3 mb-4">
                            <div class="col-12">
                                <label class="form-label fw-semibold text-secondary">Número de Documento <span class="text-danger">*</span></label>
                                <div class="input-group input-group-lg">
                                    <span class="input-group-text bg-light text-secondary border-end-0">
                                        <i class="bi bi-person-vcard"></i>
                                    </span>
                                    <input type="text" class="form-control border-start-0 ps-0 fs-5" name="documento" 
                                           placeholder="Ingrese el documento..." required maxlength="20" autofocus>
                                </div>
                            </div>
                        </div>

                        <div class="d-flex justify-content-between align-items-center pt-3 border-top">
                            <a href="<%= request.getContextPath()%>/controllers/ingreso/listar.jsp" class="btn btn-outline-secondary btn-action-pro px-4 py-2">
                                <i class="bi bi-arrow-left me-1"></i> Cancelar
                            </a>
                            <button type="submit" class="btn btn-success btn-action-pro px-4 py-2">
                                <i class="bi bi-check-circle-fill me-1"></i> Confirmar Ingreso
                            </button>
                        </div>
                    </form>
                </div>
            </div>

            <div class="alert alert-light border rounded-4 shadow-sm p-3 d-flex align-items-center mb-4">
                <i class="bi bi-info-circle text-danger fs-4 me-3"></i>
                <div class="small text-muted">
                    <strong>Verificación Automática:</strong> Al enviar el documento, el sistema validará inmediatamente la vigencia de la membresía del socio antes de autorizar el acceso a las instalaciones.
                </div>
            </div>

        </div>
    </div>
</div>