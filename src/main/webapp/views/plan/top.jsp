<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="controller.PlanController, model.Plan, java.text.DecimalFormat, java.time.LocalDate" %>
<%
    request.setAttribute("titulo", "Plan Más Vendido");

    String fInicioParam = request.getParameter("fechaInicio");
    String fFinParam = request.getParameter("fechaFin");

    LocalDate fechaInicio = (fInicioParam != null && !fInicioParam.isEmpty())
            ? LocalDate.parse(fInicioParam)
            : LocalDate.now().withDayOfMonth(1);

    LocalDate fechaFin = (fFinParam != null && !fFinParam.isEmpty())
            ? LocalDate.parse(fFinParam)
            : LocalDate.now();

    PlanController controller = new PlanController();
    controller.MtPlanMasVendidoDelMes(fechaInicio, fechaFin);
    Plan topPlan = controller.getPlanMasVendido();

    DecimalFormat formatoMoneda = new DecimalFormat("$#,##0");
%>
<jsp:include page="../includes/header.jsp" />
<jsp:include page="../includes/navbar.jsp" />

<style>
    .card-pro {
        border: 1px solid rgba(0,0,0,0.08) !important;
        transition: transform 0.2s ease, box-shadow 0.2s ease;
    }
    .card-pro:hover {
        transform: translateY(-2px);
        box-shadow: 0 8px 16px rgba(0,0,0,0.08) !important;
    }

    .card-featured-red {
        border: 2px solid #dc3545 !important;
        box-shadow: 0 8px 20px rgba(220, 53, 69, 0.12) !important;
    }
    .btn-pro {
        border-radius: 8px;
        font-weight: 600;
        letter-spacing: 0.3px;
    }
</style>

<div class="container my-5">
    <!-- Encabezado -->
    <div class="row mb-4 align-items-center">
        <div class="col-md-7">
            <h2 class="fw-extrabold text-dark m-0">
                <i class="bi bi-trophy-fill text-danger me-2"></i>Plan Más Vendido
            </h2>
        </div>
        <div class="col-md-5 text-md-end mt-3 mt-md-0">
            <a href="<%= request.getContextPath()%>/views/plan/listar.jsp" class="btn btn-outline-dark btn-pro">
                <i class="bi bi-arrow-left me-1"></i> Volver a Planes
            </a>
        </div>
    </div>


    <div class="card card-pro rounded-4 shadow-sm mb-5">
        <div class="card-body p-4">
            <form method="GET" action="<%= request.getContextPath()%>/views/plan/top.jsp" class="row g-3 align-items-end">
                <div class="col-md-4">
                    <label class="form-label fw-bold text-dark"><i class="bi bi-calendar-event me-1 text-danger"></i> Fecha Inicial</label>
                    <input type="date" name="fechaInicio" class="form-control rounded-3" value="<%= fechaInicio%>" required>
                </div>
                <div class="col-md-4">
                    <label class="form-label fw-bold text-dark"><i class="bi bi-calendar-event-fill me-1 text-danger"></i> Fecha Final</label>
                    <input type="date" name="fechaFin" class="form-control rounded-3" value="<%= fechaFin%>" required>
                </div>
                <div class="col-md-4">
                    <button type="submit" class="btn btn-danger btn-pro w-100 text-white py-2">
                        <i class="bi bi-search me-1"></i> Consultar
                    </button>
                </div>
            </form>
        </div>
    </div>

    <% if (topPlan == null) { %>
    <div class="card card-pro rounded-4 shadow-sm text-center py-5">
        <div class="card-body py-4">
            <i class="bi bi-exclamation-circle text-secondary fs-1 d-block mb-3 opacity-50"></i>
            <h4 class="text-dark fw-bold">No se encontraron ventas de planes en el período seleccionado</h4>
            <p class="text-muted mb-0">Prueba ajustando el rango de fechas en la consulta superior.</p>
        </div>
    </div>
    <% } else {%>
    <div class="row justify-content-center">
        <div class="col-md-8 col-lg-6">
            <!-- Cuadro principal con margen/borde rojo personalizado -->
            <div class="card card-pro card-featured-red rounded-4 overflow-hidden text-center">
                <div class="bg-danger text-white fw-bold py-3 text-uppercase" style="letter-spacing: 1px; font-size: 0.9rem;">
                    <i class="bi bi-star-fill me-1"></i> Plan Estrella del Período
                </div>
                <div class="card-body py-5 px-4">       
                    <h1 class="display-6 fw-bold text-dark mb-4">
                        <%= topPlan.getNombre()%>
                    </h1>
                    <hr class="my-4 text-muted opacity-25">
                    <div class="row g-3">
                        <div class="col-6 border-end">
                            <p class="text-muted text-uppercase fw-bold small mb-1" style="letter-spacing: 0.5px;">Duración</p>
                            <h3 class="fw-bold text-dark m-0"><%= topPlan.getDuracionDias()%> <span class="fs-6 fw-normal text-muted">días</span></h3>
                        </div>
                        <div class="col-6">
                            <p class="text-muted text-uppercase fw-bold small mb-1" style="letter-spacing: 0.5px;">Valor Actual</p>
                            <h3 class="fw-bold text-danger m-0"><%= formatoMoneda.format(topPlan.getValor())%></h3>
                        </div>
                    </div>
                </div>
                <div class="card-footer text-muted bg-light border-0 py-3">
                    <small><i class="bi bi-calendar3 me-1 text-danger"></i> Rango evaluado: <strong><%= fechaInicio%></strong> al <strong><%= fechaFin%></strong></small>
                </div>
            </div>
        </div>
    </div>
    <% }%>
</div>