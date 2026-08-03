<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="service.SocioService, service.PlanService, model.Socio, model.Plan, java.util.List" %>
<%
    request.setAttribute("titulo", "Vender / Renovar Membresía - Sistema FitCIMM");

    SocioService socioService = new SocioService();
    PlanService planService = new PlanService();

    List<Socio> listaSocios = socioService.MtListarSocios();
    List<Plan> listaPlanes = planService.MtListarPlanes();
%>
<jsp:include page="../includes/header.jsp" />
<jsp:include page="../includes/navbar.jsp" />

<div class="container my-4">
    <div class="row justify-content-center">
        <div class="col-lg-8">
            <div class="card border-0 rounded-4 shadow-sm overflow-hidden mb-4"> 
                <div class="card-header bg-white border-0 pt-4 px-4 pb-0">
                    <div class="d-flex align-items-center">
                        <div class="icon-box bg-danger bg-opacity-10 text-danger me-3 rounded-3 p-3 d-flex align-items-center justify-content-center">
                            <i class="bi bi-cart-check-fill fs-3"></i>
                        </div>
                        <div>
                            <h4 class="fw-bold mb-1 text-dark">Venta / Renovación de Membresía</h4>
                            <p class="text-muted small mb-0">Asigna o extiende un plan de entrenamiento a un socio del gimnasio.</p>
                        </div>
                    </div>
                </div>

                <div class="card-body p-4">
                    <form action="<%= request.getContextPath()%>/controllers/membresia/procesar.jsp" method="post">
                        <input type="hidden" name="accion" value="vender">

                        <h6 class="text-uppercase text-muted fw-bold mb-3 small">
                            <i class="bi bi-credit-card me-1"></i> Datos de la Transacción
                        </h6>

                        <div class="row g-3 mb-4">
                            <div class="col-md-12">
                                <label class="form-label fw-semibold text-secondary">Socio <span class="text-danger">*</span></label>
                                <div class="input-group">
                                    <span class="input-group-text bg-light text-secondary border-end-0">
                                        <i class="bi bi-person-check"></i>
                                    </span>
                                    <select name="idSocio" class="form-select border-start-0 ps-0 select2" required>
                                        <option value="" selected disabled>-- Seleccione un Socio --</option>
                                        <% 
                                            if (listaSocios != null) {
                                                for (Socio s : listaSocios) {
                                                    if (s.isEstado()) { // Solo listamos socios activos
                                        %>
                                                        <option value="<%= s.getId() %>">
                                                            <%= s.getDocumento() %> - <%= s.getNombre() %> <%= s.getApellido() %>
                                                        </option>
                                        <% 
                                                    }
                                                }
                                            } 
                                        %>
                                    </select>
                                </div>
                            </div>

                            <div class="col-md-12">
                                <label class="form-label fw-semibold text-secondary">Plan a Adquirir <span class="text-danger">*</span></label>
                                <div class="input-group">
                                    <span class="input-group-text bg-light text-secondary border-end-0">
                                        <i class="bi bi-journal-bookmark"></i>
                                    </span>
                                    <select name="idPlan" class="form-select border-start-0 ps-0" required>
                                        <option value="" selected disabled>-- Seleccione un Plan --</option>
                                        <% 
                                            if (listaPlanes != null) {
                                                for (Plan p : listaPlanes) {
                                                    if (p.isEstado()) { // Solo listamos planes activos
                                        %>
                                                        <option value="<%= p.getId() %>">
                                                            <%= p.getNombre() %> | <%= p.getDuracionDias() %> Días - $<%= String.format("%,.0f", p.getValor().doubleValue()) %>
                                                        </option>
                                        <% 
                                                    }
                                                }
                                            } 
                                        %>
                                    </select>
                                </div>
                            </div>
                        </div>

                        <div class="d-flex justify-content-between align-items-center pt-3 border-top">
                            <a href="<%= request.getContextPath()%>/controllers/membresia/listar.jsp" class="btn btn-outline-secondary btn-action-pro px-4 py-2">
                                <i class="bi bi-arrow-left me-1"></i> Cancelar
                            </a>
                            <button type="submit" class="btn btn-success btn-action-pro px-4 py-2">
                                <i class="bi bi-cash-stack me-1"></i> Procesar Membresía
                            </button>
                        </div>
                    </form>
                </div>
            </div>

            <div class="alert alert-light border rounded-4 shadow-sm p-3 d-flex align-items-center mb-4">
                <i class="bi bi-info-circle text-danger fs-4 me-3"></i>
                <div class="small text-muted">
                    <strong>Cálculo Automático:</strong> Si el socio ya posee una membresía activa, los días del nuevo plan se sumarán automáticamente a partir de su fecha de vencimiento actual. Si la membresía está vencida o es la primera compra, iniciará a partir de hoy.
                </div>
            </div>

        </div>
    </div>
</div>