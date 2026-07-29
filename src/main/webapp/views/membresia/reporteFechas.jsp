<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="controller.MembresiaController, model.Membresia, java.util.List, java.time.LocalDate, java.math.BigDecimal" %>
<%
    request.setAttribute("titulo", "Reporte de Recaudación - Sistema FitCIMM");

    // Recibir parámetros del filtro
    String fInicioParam = request.getParameter("fechaInicio");
    String fFinParam = request.getParameter("fechaFin");

    // Fechas por defecto: Primer día del mes actual hasta la fecha de hoy
    LocalDate fechaInicio = (fInicioParam != null && !fInicioParam.isEmpty()) 
                            ? LocalDate.parse(fInicioParam) 
                            : LocalDate.now().withDayOfMonth(1);

    LocalDate fechaFin = (fFinParam != null && !fFinParam.isEmpty()) 
                         ? LocalDate.parse(fFinParam) 
                         : LocalDate.now();

    // Instanciar el controlador y consultar la recaudación
    MembresiaController controller = new MembresiaController();
    controller.MtRecaudacionPorRangoFechas(fechaInicio, fechaFin);
    List<Membresia> reportes = controller.getRecaudacionPorPlan();

    // Sumar el valor total de todas las categorías recibidas
    BigDecimal granTotal = BigDecimal.ZERO;
    if (reportes != null) {
        for (Membresia m : reportes) {
            if (m.getValorPagado() != null) {
                granTotal = granTotal.add(m.getValorPagado());
            }
        }
    }

    // Capturar alertas del sistema en caso de error
    String mensaje = controller.getMensaje();
    String tipoMensaje = controller.getTipoMensaje();
%>
<jsp:include page="../includes/header.jsp" />
<jsp:include page="../includes/navbar.jsp" />

<div class="container my-4">
    <!-- Mensajes de alerta -->
    <% if (mensaje != null) {%>
    <div class="alert alert-<%= tipoMensaje != null ? tipoMensaje : "info"%> alert-dismissible fade show" role="alert">
        <i class="bi <%= "success".equals(tipoMensaje) ? "bi-check-circle-fill" : "bi-exclamation-triangle-fill"%> me-2"></i>
        <%= mensaje%>
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>
    <% }%>

    <!-- Encabezado y Navegación -->
    <div class="row mb-4 align-items-center">
        <div class="col-md-7">
            <h2><i class="bi bi-cash-stack text-success"></i> Reporte de Recaudación por Plan</h2>
            <p class="text-muted mb-0">Consulta del dinero total ingresado según el plan de membresía en un período</p>
        </div>
        <div class="col-md-5 text-md-end mt-3 mt-md-0 d-flex justify-content-md-end gap-2">
            <a href="<%= request.getContextPath()%>/views/membresia/listar.jsp" class="btn btn-outline-secondary">
                <i class="bi bi-arrow-left"></i> Volver al Historial
            </a>
           
        </div>
    </div>

    <!-- Filtro de Rango de Fechas -->
    <div class="card shadow-sm mb-4">
        <div class="card-body">
            <form method="GET" action="reporteFechas.jsp" class="row g-3 align-items-end">
                <div class="col-md-4">
                    <label class="form-label fw-bold"><i class="bi bi-calendar-event me-1"></i> Fecha Inicial</label>
                    <input type="date" name="fechaInicio" class="form-control" value="<%= fechaInicio %>" required>
                </div>
                <div class="col-md-4">
                    <label class="form-label fw-bold"><i class="bi bi-calendar-event-fill me-1"></i> Fecha Final</label>
                    <input type="date" name="fechaFin" class="form-control" value="<%= fechaFin %>" required>
                </div>
                <div class="col-md-4">
                    <button type="submit" class="btn btn-success w-100">
                        <i class="bi bi-filter"></i> Consultar Recaudación
                    </button>
                </div>
            </form>
        </div>
    </div>

    <!-- Tabla con los totales por Plan -->
    <div class="card shadow-sm">
        <div class="card-header card-header-sena d-flex justify-content-between align-items-center">
            <h5 class="mb-0"><i class="bi bi-pie-chart-fill"></i> Consolidado de Ventas</h5>
            <span class="badge bg-light text-dark fs-6 fw-bold">
                Total Recaudado: $<%= String.format("%,.0f", granTotal.doubleValue()) %>
            </span>
        </div>
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover align-middle mb-0">
                    <thead class="table-light">
                        <tr>
                            <th scope="col">Nombre del Plan</th>
                            <th scope="col" class="text-end">Total Recaudado</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% if (reportes == null || reportes.isEmpty()) { %>
                        <tr>
                            <td colspan="2" class="text-center py-4 text-muted">
                                <i class="bi bi-inbox fs-1 d-block mb-2"></i>
                                No se encontraron registros de ventas en el rango de fechas seleccionado.
                            </td>
                        </tr>
                        <% } else {
                            for (Membresia m : reportes) {
                        %>
                        <tr>
                            <td>
                                <span class="fw-bold text-dark">
                                    <%= (m.getPlan() != null) ? m.getPlan().getNombre() : "Plan N/A" %>
                                </span>
                            </td>
                            <td class="text-end text-success fw-bold fs-6">
                                $<%= String.format("%,.0f", m.getValorPagado() != null ? m.getValorPagado().doubleValue() : 0.0) %>
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