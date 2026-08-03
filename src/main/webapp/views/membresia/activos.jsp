<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="controller.MembresiaController, model.Membresia, java.util.List" %>
<%
    request.setAttribute("titulo", "Socios Activos Vigentes - Sistema FitCIMM");

    MembresiaController controller = new MembresiaController();
    controller.MtSociosActivosVigentes();
    List<Membresia> membresiasVigentes = controller.getSociosActivosVigentes();
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

    <div class="row mb-4 align-items-center">
        <div class="col-md-7">
            <h2 class="fw-extrabold text-dark m-0">
                <i class="bi bi-person-check-fill text-danger me-2"></i>Socios Activos Vigentes
            </h2>

        </div>
        <div class="col-md-5 text-md-end mt-3 mt-md-0 d-flex justify-content-md-end gap-2">
            <a href="<%= request.getContextPath()%>/views/membresia/listar.jsp" class="btn btn-outline-dark btn-pro">
                <i class="bi bi-arrow-left me-1"></i> Volver al Historial
            </a>
        </div>
    </div>

    <!-- Tabla -->
    <div class="card card-pro rounded-4 shadow-sm overflow-hidden border-0">
        <div class="bg-dark text-white p-3 d-flex justify-content-between align-items-center">
            <h5 class="mb-0 fw-bold fs-6 text-uppercase" style="letter-spacing: 0.5px;">
                <i class="bi bi-check2-square me-2 text-danger"></i>Reporte de Membresias Activas
            </h5>
            <span class="badge bg-danger text-white fs-6 fw-bold px-3 py-2 rounded-3">
                Total Activos: <%= membresiasVigentes != null ? membresiasVigentes.size() : 0%>
            </span>
        </div>
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover align-middle mb-0">
                    <thead class="bg-light text-uppercase text-muted small" style="letter-spacing: 0.5px;">
                        <tr>
                            <th scope="col" class="py-3 px-4">Socio / Documento</th>
                            <th scope="col" class="py-3">Plan</th>
                            <th scope="col" class="text-center py-3">Fecha Inicio</th>
                            <th scope="col" class="text-center py-3">Fecha Vencimiento</th>
                            <th scope="col" class="text-end py-3">Valor Pagado</th>
                            <th scope="col" class="text-center py-3 px-4">Estado</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% if (membresiasVigentes == null || membresiasVigentes.isEmpty()) { %>
                        <tr>
                            <td colspan="6" class="text-center py-5 text-muted">
                                <i class="bi bi-inbox fs-1 d-block mb-2 opacity-50"></i>
                                No hay socios activos con membresía vigente en este momento.
                            </td>
                        </tr>
                        <% } else {
                            for (Membresia m : membresiasVigentes) {
                                String estado = m.getEstadoCalculado();
                        %>
                        <tr>
                            <td class="px-4 py-3">
                                <div class="fw-bold text-dark">
                                    <%= (m.getSocio() != null) ? m.getSocio().getNombre() + " " + m.getSocio().getApellido() : "Socio ID: " + m.getIdSocio()%>
                                </div>
                                <small class="text-muted">
                                    <i class="bi bi-person-vcard text-danger me-1"></i><%= (m.getSocio() != null) ? m.getSocio().getDocumento() : "-"%>
                                </small>
                            </td>
                            <td class="py-3">
                                <span class="fw-semibold text-dark">
                                    <%= (m.getPlan() != null) ? m.getPlan().getNombre() : "Plan ID: " + m.getIdPlan()%>
                                </span>
                            </td>
                            <td class="text-center py-3">
                                <small class="text-muted"><%= m.getFechaInicio()%></small>
                            </td>
                            <td class="text-center py-3">
                                <small class="fw-bold text-dark"><%= m.getFechaFin()%></small>
                            </td>
                            <td class="text-end text-danger fw-bold py-3">
                                $<%= String.format("%,.0f", m.getValorPagado() != null ? m.getValorPagado().doubleValue() : 0.0)%>
                            </td>
                            <td class="text-center px-4 py-3">
                                <% if ("POR VENCER".equalsIgnoreCase(estado)) { %>
                                <span class="badge bg-warning bg-opacity-25 text-dark border border-warning px-3 py-2 rounded-2 fw-bold">
                                    <i class="bi bi-exclamation-triangle-fill me-1 text-warning"></i> POR VENCER
                                </span>
                                <% } else { %>
                                <span class="badge bg-success bg-opacity-10 text-success border border-success px-3 py-2 rounded-2 fw-bold">
                                    <i class="bi bi-check-circle-fill me-1"></i> VIGENTE
                                </span>
                                <% } %>
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