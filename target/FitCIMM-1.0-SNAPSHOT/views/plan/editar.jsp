<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="service.*, model.*, java.util.*" %>
<%
    request.setAttribute("titulo", "Editar Plan - FitCIMM");

    String idParam = request.getParameter("id");
    if (idParam == null || idParam.trim().isEmpty()) {
        response.sendRedirect(request.getContextPath() + "/views/plan/listar.jsp");
        return;
    }

    int id = Integer.parseInt(idParam);
    PlanService service = new PlanService();
    Plan plan = service.MtObtenerPorId(id);

    if (plan == null) {
        response.sendRedirect(request.getContextPath() + "/views/plan/listar.jsp");
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

                    <form action="<%= request.getContextPath()%>/controllers/plan/procesar.jsp" method="post">
                        <input type="hidden" name="accion" value="editar">
                        <input type="hidden" name="id" value="<%= plan.getId()%>">

                        <!-- Sección: Detalles del Plan -->
                        <div class="d-flex align-items-center mb-4">
                            <div class="icon-box bg-danger bg-opacity-10 text-danger me-3">
                                <i class="bi bi-card-checklist fs-4"></i>
                            </div>
                            <div>
                                <h5 class="fw-bold mb-0 text-dark">Información del Plan</h5>
                                <small class="text-muted">Ajusta las especificaciones comerciales y la vigencia</small>
                            </div>
                        </div>

                        <div class="row g-3 mb-4">
                            <div class="col-md-6">
                                <label class="form-label fw-semibold small text-muted">Nombre del Plan <span class="text-danger">*</span></label>
                                <div class="input-group">
                                    <span class="input-group-text bg-light text-secondary"><i class="bi bi-tag"></i></span>
                                    <input type="text" class="form-control" name="nombre" 
                                           value="<%= plan.getNombre()%>" required maxlength="50">
                                </div>
                            </div>

                            <div class="col-md-3">
                                <label class="form-label fw-semibold small text-muted">Duración (Días) <span class="text-danger">*</span></label>
                                <div class="input-group">
                                    <span class="input-group-text bg-light text-secondary"><i class="bi bi-calendar-range"></i></span>
                                    <input type="number" class="form-control" name="duracionDias" 
                                           value="<%= plan.getDuracionDias()%>" min="1" required>
                                </div>
                            </div>

                            <div class="col-md-3">
                                <label class="form-label fw-semibold small text-muted">Valor / Tarifa <span class="text-danger">*</span></label>
                                <div class="input-group">
                                    <span class="input-group-text bg-light text-secondary"><i class="bi bi-currency-dollar"></i></span>
                                    <input type="number" step="0.01" min="0" class="form-control" name="valor" 
                                           value="<%= plan.getValor()%>" required>
                                </div>
                            </div>
                        </div>

                        <div class="row g-3 mb-4">
                            <div class="col-md-4">
                                <label class="form-label fw-semibold small text-muted">Estado del Plan <span class="text-danger">*</span></label>
                                <div class="input-group">
                                    <span class="input-group-text bg-light text-secondary"><i class="bi bi-toggle-on"></i></span>
                                    <select class="form-select" name="estado" required>
                                        <option value="true" <%= plan.isEstado() ? "selected" : ""%>>ACTIVO</option>
                                        <option value="false" <%= !plan.isEstado() ? "selected" : ""%>>INACTIVO</option>
                                    </select>
                                </div>
                            </div>
                        </div>

                        <hr class="my-4 text-muted opacity-25">

                        <div class="d-flex align-items-center justify-content-between pt-2">
                            <a href="<%= request.getContextPath()%>/views/plan/listar.jsp" class="btn btn-outline-secondary btn-action-pro px-4 py-2">
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