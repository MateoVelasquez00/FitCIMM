<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="service.*, model.*, java.util.*" %>
<%
    request.setAttribute("titulo", "Nuevo Plan - Sistema FitCIMM");
%>
<jsp:include page="../includes/header.jsp" />
<jsp:include page="../includes/navbar.jsp" />

<div class="container my-4">
    <div class="row mb-4">
        <div class="col-12">
            <h2><i class="bi bi-plus-circle text-success"></i> Nuevo Plan</h2>
        </div>
    </div>

    <div class="row justify-content-center">
        <div class="col-lg-10">
            <div class="card shadow-sm">
                <div class="card-header card-header-sena">
                    <h5 class="mb-0"><i class="bi bi-card-text"></i> Datos del Plan</h5>
                </div>

                <div class="card-body">
                    <form action="<%= request.getContextPath()%>/controllers/plan/procesar.jsp" method="post">
                        <input type="hidden" name="accion" value="crear">

                        <h6 class="text-muted mb-3"><i class="bi bi-card-list"></i> Información del Plan</h6>

                        <div class="row">
                            <div class="col-md-3 mb-3">
                                <label class="form-label">Nombre del Plan <span class="text-danger">*</span></label>
                                <input type="text" class="form-control" name="nombre" 
                                       placeholder="Trimestral, Semestral..." required maxlength="100">
                            </div>

                            <div class="col-md-3 mb-3">
                                <label class="form-label">Duración Días <span class="text-danger">*</span></label>
                                <input type="number" class="form-control" name="duracionDias" 
                                       placeholder="0" required maxlength="100">
                            </div>

                            <div class="col-md-3 mb-3">
                                <label class="form-label">Valor <span class="text-danger">*</span></label>
                                <input type="number" min="0" class="form-control" name="valor" 
                                       placeholder="0.00" required maxlength="100""
                                       required>
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
                            <a href="<%= request.getContextPath()%>/controllers/plan/listar.jsp" class="btn btn-secondary">
                                <i class="bi bi-arrow-left"></i> Cancelar
                            </a>
                            <button type="submit" class="btn btn-success">
                                <i class="bi bi-save"></i> Guardar Plan
                            </button>
                        </div>
                    </form>
                </div> 
            </div>
        </div>
    </div>
</div>