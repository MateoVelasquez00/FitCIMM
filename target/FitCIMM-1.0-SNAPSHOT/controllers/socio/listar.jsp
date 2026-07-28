<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="controller.SocioController" %>
<%
    request.setCharacterEncoding("UTF-8");
    SocioController controller = new SocioController();
    String buscar = request.getParameter("buscar");
    
    String resultado;
    if (buscar != null && !buscar.trim().isEmpty()) {
        resultado = controller.MtBuscarSocio(buscar);
        request.setAttribute("buscar", buscar);
    } else {
        resultado = controller.MtListarSocios();
    }
    
    request.setAttribute("socios", controller.getSocios());
    request.setAttribute("titulo", "Socios - Sistema FitCIMM");
    
    RequestDispatcher dispatcher = request.getRequestDispatcher("/views/socio/listar.jsp");
    dispatcher.forward(request, response);
%>

