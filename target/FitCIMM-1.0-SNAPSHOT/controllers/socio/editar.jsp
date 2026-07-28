<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="controller.SocioController, service.SocioService" %>

<%
    int idSocio = Integer.parseInt(request.getParameter("id"));
    SocioController controller = new SocioController();
    String resultado = controller.MtObtenerPorId(idSocio);
    
    if ("notfound".equals(resultado)) {
        response.sendRedirect(request.getContextPath() + "/controllers/socio/listar.jsp");
        return;
    }
    
    request.setAttribute("socio", controller.getSocio());
    request.setAttribute("titulo", "Editar Socio - Sistema FitCIMM");
    
    RequestDispatcher dispatcher = request.getRequestDispatcher("/views/socio/editar.jsp");
    dispatcher.forward(request, response);
   
%>
