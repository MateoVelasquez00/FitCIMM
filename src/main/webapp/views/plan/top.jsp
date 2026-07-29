<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="controller.PlanController, model.Plan, java.text.DecimalFormat, java.time.LocalDate" %>
<%
    request.setAttribute("titulo", "Plan Más Vendido - Sistema SENA");

    String fInicioParam = request.getParameter("fechaInicio");
    String fFinParam = request.getParameter("fechaFin");


    LocalDate fechaInicio = (fInicioParam != null && !fInicioParam.isEmpty()) 
                            ? LocalDate.parse(fInicioParam) 
                            : LocalDate.now().withDayOfMonth(1);

    LocalDate fechaFin = (fFinParam != null && !fFinParam.isEmpty()) 
                         ? LocalDate.parse(fFinParam) 
                         : LocalDate.now();

    // Invocación a través del Controller
    PlanController controller = new PlanController();
    controller.MtPlanMasVendidoDelMes(fechaInicio, fechaFin);
    Plan topPlan = controller.getPlanMasVendido();

    DecimalFormat formatoMoneda = new DecimalFormat("$#,##0");
%>
<jsp:include page="../includes/header.jsp" />
<jsp:include page="../includes/navbar.jsp" />

<div class="container my-4">
    <!-- Encabezado -->
    <div class="row mb-4 align-items-center">
        <div class="col-md-7">
            <h2><i class="bi bi-star-fill text-warning"></i> Plan Más Vendido</h2>
          
        </div>
        <div class="col-md-5 text-md-end mt-3 mt-md-0">
            <a href="<%= request.getContextPath()%>/views/plan/listar.jsp" class="btn btn-outline-secondary">
                <i class="bi bi-arrow-left"></i> Volver a Planes
            </a>
        </div>
    </div>

    <!-- Filtro de Rango de Fechas -->
    <div class="card shadow-sm mb-4">
        <div class="card-body">
            <form method="GET" action="<%= request.getContextPath()%>/views/plan/top.jsp" class="row g-3 align-items-end">
                <div class="col-md-4">
                    <label class="form-label fw-bold"><i class="bi bi-calendar-event me-1"></i> Fecha Inicial</label>
                    <input type="date" name="fechaInicio" class="form-control" value="<%= fechaInicio %>" required>
                </div>
                <div class="col-md-4">
                    <label class="form-label fw-bold"><i class="bi bi-calendar-event-fill me-1"></i> Fecha Final</label>
                    <input type="date" name="fechaFin" class="form-control" value="<%= fechaFin %>" required>
                </div>
                <div class="col-md-4">
                    <button type="submit" class="btn btn-warning w-100 text-dark fw-bold">
                        <i class="bi bi-search"></i> Consultar
                    </button>
                </div>
            </form>
        </div>
    </div>

    <!-- Resultados del Reporte -->
    <% if (topPlan == null) { %>
        <div class="card shadow-sm text-center py-5">
            <div class="card-body">
                <i class="bi bi-exclamation-circle text-muted fs-1 d-block mb-3"></i>
                <h4 class="text-muted">No se encontraron ventas de planes en el período seleccionado</h4>
                <p class="text-muted mb-0">Prueba ajustando el rango de fechas en la consulta.</p>
            </div>
        </div>
    <% } else { %>
        <div class="row justify-content-center">
            <div class="col-md-8 col-lg-6">
                <div class="card shadow border-warning text-center">
                    <div class="card-header bg-warning text-dark fw-bold py-3">
                        <i class="bi bi-star-fill me-1"></i> PLAN ESTRELLA DEL PERÍODO
                    </div>
                    <div class="card-body py-4">
                        <h1 class="display-5 fw-bold text-success mb-3">
                            <%= topPlan.getNombre() %>
                        </h1>
                        <hr class="my-4">
                        <div class="row">
                            <div class="col-6 border-end">
                                <p class="text-muted mb-1 fs-6">Duración</p>
                                <h4 class="fw-bold text-dark"><%= topPlan.getDuracionDias() %> días</h4>
                            </div>
                            <div class="col-6">
                                <p class="text-muted mb-1 fs-6">Valor Actual</p>
                                <h4 class="fw-bold text-success"><%= formatoMoneda.format(topPlan.getValor()) %></h4>
                            </div>
                        </div>
                    </div>
                    <div class="card-footer text-muted bg-light">
                        <small><i class="bi bi-calendar3 me-1"></i> Rango evaluado: <strong><%= fechaInicio %></strong> al <strong><%= fechaFin %></strong></small>
                    </div>
                </div>
            </div>
        </div>
    <% } %>
</div>