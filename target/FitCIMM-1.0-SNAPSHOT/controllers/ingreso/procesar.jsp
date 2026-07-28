<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="controller.IngresoController, model.Ingreso" %>
<%
    request.setCharacterEncoding("UTF-8");
    String accion = request.getParameter("accion");
    IngresoController controller = new IngresoController();

    try {
        if ("crear".equals(accion)) {
            String documento = request.getParameter("documento");
            
            if (documento != null && !documento.trim().isEmpty()) {
                controller.MtRegistrarPorDocumento(documento.trim());
            } else {
                controller.setMensaje("Debe ingresar un número de documento válido.");
                controller.setTipoMensaje("warning");
            }
        }
        session.setAttribute("mensaje", controller.getMensaje());
        session.setAttribute("tipoMensaje", controller.getTipoMensaje());
    } catch (Exception e) {
        session.setAttribute("mensaje", "Error: " + e.getMessage());
        session.setAttribute("tipoMensaje", "danger");
    }
    response.sendRedirect(request.getContextPath() + "/controllers/ingreso/listar.jsp");
%>
