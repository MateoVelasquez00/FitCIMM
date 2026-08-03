<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="service.*, model.*, java.util.*" %>
<%
    request.setAttribute("titulo", "Nuevo Plan - Sistema FitCIMM");
%>
<jsp:include page="../includes/header.jsp" />
<jsp:include page="../includes/navbar.jsp" />

<div class="container my-4">
    <div class="row justify-content-center">
        <div class="col-lg-10">
            <!-- Tarjeta Principal -->
            <div class="card border-0 rounded-4 shadow-sm overflow-hidden mb-4">

                <!-- Header de la tarjeta -->
                <div class="card-header bg-white border-0 pt-4 px-4 pb-0">
                    <div class="d-flex align-items-center">
                        <div class="icon-box bg-danger bg-opacity-10 text-danger me-3 rounded-3 p-3 d-flex align-items-center justify-content-center">
                            <i class="bi bi-journal-plus fs-3"></i>
                        </div>
                        <div>
                            <h4 class="fw-bold mb-1 text-dark">Registrar Nuevo Plan</h4>
                            <p class="text-muted small mb-0">Define la tarifa, duración y estado del plan de membresía.</p>
                        </div>
                    </div>
                </div>

                <!-- Cuerpo del formulario -->
                <div class="card-body p-4">
                    <form action="<%= request.getContextPath()%>/controllers/plan/procesar.jsp" method="post">
                        <input type="hidden" name="accion" value="crear">

                        <!-- Sección: Detalles del Plan -->
                        <h6 class="text-uppercase text-muted fw-bold mb-3 small">
                            <i class="bi bi-card-list me-1"></i> Información del Plan
                        </h6>

                        <div class="row g-3 mb-4">
                            <!-- Nombre del Plan -->
                            <div class="col-md-6">
                                <label class="form-label fw-semibold text-secondary">Nombre del Plan <span class="text-danger">*</span></label>
                                <div class="input-group">
                                    <span class="input-group-text bg-light text-secondary border-end-0">
                                        <i class="bi bi-bookmark-star"></i>
                                    </span>
                                    <input type="text" class="form-control border-start-0 ps-0" name="nombre" 
                                           placeholder="Ej. Trimestral, Semestral, VIP..." required maxlength="100">
                                </div>
                            </div>

                            <!-- Duración Días -->
                            <div class="col-md-6">
                                <label class="form-label fw-semibold text-secondary">Duración (Días) <span class="text-danger">*</span></label>
                                <div class="input-group">
                                    <span class="input-group-text bg-light text-secondary border-end-0">
                                        <i class="bi bi-calendar-event"></i>
                                    </span>
                                    <input type="number" min="1" class="form-control border-start-0 ps-0" name="duracionDias" 
                                           placeholder="Ej. 30, 90, 365" required>
                                </div>
                            </div>

                            <!-- Valor / Precio -->
                            <div class="col-md-6">
                                <label class="form-label fw-semibold text-secondary">Valor ($) <span class="text-danger">*</span></label>
                                <div class="input-group">
                                    <span class="input-group-text bg-light text-secondary border-end-0">
                                        <i class="bi bi-currency-dollar"></i>
                                    </span>
                                    <input type="number" min="0" step="0.01" class="form-control border-start-0 ps-0" name="valor" 
                                           placeholder="0.00" required>
                                </div>
                            </div>

                            <!-- Estado -->
                            <div class="col-md-6">
                                <label class="form-label fw-semibold text-secondary">Estado <span class="text-danger">*</span></label>
                                <div class="input-group">
                                    <span class="input-group-text bg-light text-secondary border-end-0">
                                        <i class="bi bi-toggle-on"></i>
                                    </span>
                                    <select class="form-select border-start-0 ps-0" name="estado" required>
                                        <option value="true" selected>ACTIVO</option>
                                        <option value="false">INACTIVO</option>
                                    </select>
                                </div>
                            </div>
                        </div>

                        <!-- Botones de Acción -->
                        <div class="d-flex justify-content-between align-items-center pt-3 border-top">
                            <a href="<%= request.getContextPath()%>/controllers/plan/listar.jsp" class="btn btn-outline-secondary btn-action-pro px-4 py-2">
                                <i class="bi bi-arrow-left me-1"></i> Cancelar
                            </a>
                            <button type="submit" class="btn btn-success btn-action-pro px-4 py-2">
                                <i class="bi bi-plus-circle-fill me-1"></i> Guardar Plan
                            </button>
                        </div>
                    </form>
                </div>
            </div>

        </div>
    </div>
</div>