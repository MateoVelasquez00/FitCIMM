<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="controller.MembresiaController" %>
<%
    request.setCharacterEncoding("UTF-8");
    
    String accion = request.getParameter("accion");
    MembresiaController controller = new MembresiaController();

    try {
        if ("vender".equals(accion) || "renovar".equals(accion)) {
            String strIdSocio = request.getParameter("idSocio");
            String strIdPlan = request.getParameter("idPlan");

            if (strIdSocio != null && strIdPlan != null && !strIdSocio.isEmpty() && !strIdPlan.isEmpty()) {
                int idSocio = Integer.parseInt(strIdSocio);
                int idPlan = Integer.parseInt(strIdPlan);

                controller.MtVenderRenovarMembresia(idSocio, idPlan);
            } else {
                controller.setMensaje("Debe seleccionar un socio y un plan válidos.");
                controller.setTipoMensaje("warning");
            }
        } else {
            controller.setMensaje("Acción no válida o no permitida.");
            controller.setTipoMensaje("danger");
        }

        session.setAttribute("mensaje", controller.getMensaje());
        session.setAttribute("tipoMensaje", controller.getTipoMensaje());

    } catch (NumberFormatException e) {
        session.setAttribute("mensaje", "Los identificadores seleccionados no son válidos.");
        session.setAttribute("tipoMensaje", "danger");
    } catch (Exception e) {
        session.setAttribute("mensaje", "Error procesando la solicitud: " + e.getMessage());
        session.setAttribute("tipoMensaje", "danger");
    }

    response.sendRedirect(request.getContextPath() + "/controllers/membresia/listar.jsp");
%>