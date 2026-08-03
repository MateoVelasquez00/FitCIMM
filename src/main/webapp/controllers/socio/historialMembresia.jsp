<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="service.*, model.*, java.util.*" %>
<%
    String idSocioParam = request.getParameter("idSocio");

    // Validación básica del parámetro
    if (idSocioParam == null || idSocioParam.trim().isEmpty()) {
        session.setAttribute("mensaje", "ID de socio no válido.");
        session.setAttribute("tipoMensaje", "danger");
        response.sendRedirect(request.getContextPath() + "/views/socio/listar.jsp");
        return;
    }

    try {
        int idSocio = Integer.parseInt(idSocioParam);
        SocioService service = new SocioService();

        Socio socio = service.MtObtenerPorId(idSocio);
        List<Membresia> historial = service.MtDetalleSocio(idSocio);

        if (socio == null) {
            session.setAttribute("mensaje", "El socio solicitado no existe.");
            session.setAttribute("tipoMensaje", "warning");
            response.sendRedirect(request.getContextPath() + "/views/socio/listar.jsp");
            return;
        }

        request.setAttribute("socio", socio);
        request.setAttribute("historialMembresias", historial);

        request.getRequestDispatcher("/views/socio/historialMembresia.jsp").forward(request, response);

    } catch (NumberFormatException e) {
        session.setAttribute("mensaje", "Formato de ID inválido.");
        session.setAttribute("tipoMensaje", "danger");
        response.sendRedirect(request.getContextPath() + "/views/socio/listar.jsp");
    } catch (Exception e) {
        session.setAttribute("mensaje", "Error al consultar historial: " + e.getMessage());
        session.setAttribute("tipoMensaje", "danger");
        response.sendRedirect(request.getContextPath() + "/views/socio/listar.jsp");
    }
%>