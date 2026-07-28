<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="service.SocioService, service.PlanService, model.Socio, model.Plan, java.util.List" %>
<%
    request.setAttribute("titulo", "Vender / Renovar Membresía - Sistema FitCIMM");

    // Instanciar servicios para llenar los desplegables de la interfaz
    SocioService socioService = new SocioService();
    PlanService planService = new PlanService();

    List<Socio> listaSocios = socioService.MtListarSocios();
    List<Plan> listaPlanes = planService.MtListarPlanes();
%>
<jsp:include page="../includes/header.jsp" />
<jsp:include page="../includes/navbar.jsp" />

<div class="container my-4">
    <div class="row mb-4">
        <div class="col-12">
            <h2><i class="bi bi-cart-check-fill text-success"></i> Venta / Renovación de Membresía</h2>
            <p class="text-muted">Asigna o extiende un plan de entrenamiento a un socio</p>
        </div>
    </div>

    <div class="row justify-content-center">
        <div class="col-lg-8">
            <div class="card shadow-sm">
                <div class="card-header card-header-sena">
                    <h5 class="mb-0"><i class="bi bi-credit-card"></i> Datos de la Transacción</h5>
                </div>

                <div class="card-body">
                    <form action="<%= request.getContextPath()%>/controllers/membresia/procesar.jsp" method="post">
                        <input type="hidden" name="accion" value="vender">

                        <div class="row g-3">
                            <!-- Selección de Socio -->
                            <div class="col-md-12">
                                <label class="form-label font-weight-bold">Socio <span class="text-danger">*</span></label>
                                <select name="idSocio" class="form-select select2" required>
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

                            <!-- Selección de Plan -->
                            <div class="col-md-12">
                                <label class="form-label font-weight-bold">Plan a Adquirir <span class="text-danger">*</span></label>
                                <select name="idPlan" class="form-select" required>
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

                        <hr class="my-4">

                        <div class="d-flex justify-content-between">
                            <a href="<%= request.getContextPath()%>/controllers/membresia/listar.jsp" class="btn btn-secondary">
                                <i class="bi bi-arrow-left"></i> Cancelar
                            </a>
                            <button type="submit" class="btn btn-success">
                                <i class="bi bi-cash-stack"></i> Procesar Membresía
                            </button>
                        </div>
                    </form>
                </div> 
            </div>

            <div class="alert alert-info mt-3 border-0">
                <i class="bi bi-info-circle-fill"></i> 
                <strong>Cálculo Automático:</strong> Si el socio ya posee una membresía activa, los días del nuevo plan se sumarán automáticamente a partir de la fecha de vencimiento actual. Si está vencida o es nuevo, iniciará a partir de hoy.
            </div>
        </div>
    </div>
</div>