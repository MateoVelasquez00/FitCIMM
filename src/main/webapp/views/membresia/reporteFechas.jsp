<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="controller.MembresiaController, model.Membresia, java.util.List, java.time.LocalDate, java.math.BigDecimal" %>
<%
    request.setAttribute("titulo", "Reporte de Recaudación - Sistema FitCIMM");

    String fInicioParam = request.getParameter("fechaInicio");
    String fFinParam = request.getParameter("fechaFin");

    LocalDate fechaInicio = (fInicioParam != null && !fInicioParam.isEmpty())
            ? LocalDate.parse(fInicioParam)
            : LocalDate.now().withDayOfMonth(1);

    LocalDate fechaFin = (fFinParam != null && !fFinParam.isEmpty())
            ? LocalDate.parse(fFinParam)
            : LocalDate.now();

    MembresiaController controller = new MembresiaController();
    controller.MtRecaudacionPorRangoFechas(fechaInicio, fechaFin);
    List<Membresia> reportes = controller.getRecaudacionPorPlan();

    BigDecimal granTotal = BigDecimal.ZERO;
    if (reportes != null) {
        for (Membresia m : reportes) {
            if (m.getValorPagado() != null) {
                granTotal = granTotal.add(m.getValorPagado());
            }
        }
    }

    String mensaje = controller.getMensaje();
    String tipoMensaje = controller.getTipoMensaje();
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
    .btn-pro {
        border-radius: 8px;
        font-weight: 600;
        letter-spacing: 0.3px;
    }
</style>

<div class="container my-5">
    <% if (mensaje != null) {%>
    <div class="alert alert-<%= tipoMensaje != null ? tipoMensaje : "info"%> alert-dismissible fade show rounded-3 shadow-sm mb-4" role="alert">
        <i class="bi <%= "success".equals(tipoMensaje) ? "bi-check-circle-fill text-success" : "bi-exclamation-triangle-fill text-warning"%> me-2"></i>
        <%= mensaje%>
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>
    <% }%>

    <div class="row mb-4 align-items-center">
        <div class="col-md-7">
            <h2 class="fw-extrabold text-dark m-0">
                <i class="bi bi-cash-stack text-danger me-2"></i>Reporte de Recaudación por Plan
            </h2>
        </div>
        <div class="col-md-5 text-md-end mt-3 mt-md-0 d-flex justify-content-md-end gap-2">
            <a href="<%= request.getContextPath()%>/views/membresia/listar.jsp" class="btn btn-outline-dark btn-pro">
                <i class="bi bi-arrow-left me-1"></i> Volver al Historial
            </a>
        </div>
    </div>

    <div class="card card-pro rounded-4 shadow-sm mb-4">
        <div class="card-body p-4">
            <form method="GET" action="reporteFechas.jsp" class="row g-3 align-items-end">
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
                        <i class="bi bi-filter me-1"></i> Consultar Recaudación
                    </button>
                </div>
            </form>
        </div>
    </div>

    <div class="card card-pro rounded-4 shadow-sm overflow-hidden border-0">
        <div class="bg-dark text-white p-3 d-flex justify-content-between align-items-center">
            <h5 class="mb-0 fw-bold fs-6 text-uppercase" style="letter-spacing: 0.5px;">
                <i class="bi bi-pie-chart-fill me-2 text-danger"></i>Consolidado de Ventas
            </h5>
            <span class="badge bg-danger text-white fs-6 fw-bold px-3 py-2 rounded-3">
                Total Recaudado: $<%= String.format("%,.0f", granTotal.doubleValue())%>
            </span>
        </div>
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover align-middle mb-0">
                    <thead class="bg-light text-uppercase text-muted small" style="letter-spacing: 0.5px;">
                        <tr>
                            <th scope="col" class="py-3 px-4">Nombre del Plan</th>
                            <th scope="col" class="text-end py-3 px-4">Total Recaudado</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% if (reportes == null || reportes.isEmpty()) { %>
                        <tr>
                            <td colspan="2" class="text-center py-5 text-muted">
                                <i class="bi bi-inbox fs-1 d-block mb-2 opacity-50"></i>
                                No se encontraron registros de ventas en el rango de fechas seleccionado.
                            </td>
                        </tr>
                        <% } else {
                            for (Membresia m : reportes) {
                        %>
                        <tr>
                            <td class="px-4 py-3">
                                <span class="fw-bold text-dark">
                                    <%= (m.getPlan() != null) ? m.getPlan().getNombre() : "Plan N/A"%>
                                </span>
                            </td>
                            <td class="text-end text-danger fw-bold fs-6 px-4 py-3">
                                $<%= String.format("%,.0f", m.getValorPagado() != null ? m.getValorPagado().doubleValue() : 0.0)%>
                            </td>
                        </tr>
                        <%
                                }
                            }
                        %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>