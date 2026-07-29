<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="controller.MembresiaController, model.Membresia, java.util.List" %>
<%
    request.setAttribute("titulo", "Socios Activos Vigentes - Sistema FitCIMM");

    // Instanciar controlador y consultar únicamente activos
    MembresiaController controller = new MembresiaController();
    controller.MtSociosActivosVigentes();
    List<Membresia> membresiasVigentes = controller.getSociosActivosVigentes();
%>
<jsp:include page="../includes/header.jsp" />
<jsp:include page="../includes/navbar.jsp" />

<div class="container my-4">
    <!-- Encabezado -->
    <div class="row mb-4 align-items-center">
        <div class="col-md-7">
            <h2><i class="bi bi-person-check-fill text-success"></i> Socios Activos con Membresía Vigente</h2>
            <p class="text-muted mb-0">Listado exclusivo de socios con afiliación activa al día de hoy</p>
        </div>
        <div class="col-md-5 text-md-end mt-3 mt-md-0 d-flex justify-content-md-end gap-2">
            <a href="<%= request.getContextPath()%>/views/membresia/listar.jsp" class="btn btn-outline-secondary">
                <i class="bi bi-arrow-left"></i> Volver al Historial
            </a>
        </div>
    </div>

    <!-- Contador -->
    <div class="row mb-3">
        <div class="col-12 text-end">
            <span class="text-muted">Total Socios Activos: <strong><%= membresiasVigentes != null ? membresiasVigentes.size() : 0%></strong></span>
        </div>
    </div>

    <!-- Tabla -->
    <div class="card shadow-sm">
        <div class="card-header card-header-sena">
            <h5 class="mb-0"><i class="bi bi-check2-square"></i> Reporte de Afiliaciones Activas</h5>
        </div>
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover align-middle mb-0">
                    <thead class="table-light">
                        <tr>
                            <th scope="col">Socio / Documento</th>
                            <th scope="col">Plan</th>
                            <th scope="col" class="text-center">Fecha Inicio</th>
                            <th scope="col" class="text-center">Fecha Vencimiento</th>
                            <th scope="col" class="text-end">Valor Pagado</th>
                            <th scope="col" class="text-center">Estado</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% if (membresiasVigentes == null || membresiasVigentes.isEmpty()) { %>
                        <tr>
                            <td colspan="6" class="text-center py-4 text-muted">
                                <i class="bi bi-inbox fs-1 d-block mb-2"></i>
                                No hay socios activos con membresía vigente en este momento.
                            </td>
                        </tr>
                        <% } else {
                            for (Membresia m : membresiasVigentes) {
                                String estado = m.getEstadoCalculado();
                        %>
                        <tr>
                            <td>
                                <div>
                                    <strong><%= (m.getSocio() != null) ? m.getSocio().getNombre() + " " + m.getSocio().getApellido() : "Socio ID: " + m.getIdSocio()%></strong>
                                </div>
                                <small class="text-muted">
                                    <i class="bi bi-person-vcard"></i> <%= (m.getSocio() != null) ? m.getSocio().getDocumento() : "-"%>
                                </small>
                            </td>
                            <td>
                                <span class="fw-semibold">
                                    <%= (m.getPlan() != null) ? m.getPlan().getNombre() : "Plan ID: " + m.getIdPlan()%>
                                </span>
                            </td>
                            <td class="text-center">
                                <small class="text-muted"><%= m.getFechaInicio()%></small>
                            </td>
                            <td class="text-center">
                                <small class="fw-bold"><%= m.getFechaFin()%></small>
                            </td>
                            <td class="text-end text-success fw-bold">
                                $<%= String.format("%,.0f", m.getValorPagado() != null ? m.getValorPagado().doubleValue() : 0.0)%>
                            </td>
                            <td class="text-center">
                                <% if ("POR VENCER".equalsIgnoreCase(estado)) { %>
                                <span class="badge bg-warning text-dark"><i class="bi bi-exclamation-triangle"></i> POR VENCER</span>
                                <% } else { %>
                                <span class="badge bg-success"><i class="bi bi-check-circle"></i> VIGENTE</span>
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