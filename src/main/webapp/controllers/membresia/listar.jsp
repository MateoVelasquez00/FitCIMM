<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="controller.MembresiaController" %>
<%
    request.setCharacterEncoding("UTF-8");
    MembresiaController controller = new MembresiaController();
    
    request.setAttribute("membresias", controller.getMembresias());
    request.setAttribute("titulo", "Membresias - Sistema FitCIMM");
    
    RequestDispatcher dispatcher = request.getRequestDispatcher("/views/membresia/listar.jsp");
    dispatcher.forward(request, response);
%>

