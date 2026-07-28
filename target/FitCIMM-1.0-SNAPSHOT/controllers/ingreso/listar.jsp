<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="controller.IngresoController" %>
<%
    request.setCharacterEncoding("UTF-8");
    IngresoController controller = new IngresoController();
    
    request.setAttribute("ingresos", controller.getIngresos());
    request.setAttribute("titulo", "Ingresos - Sistema FitCIMM");
    
    RequestDispatcher dispatcher = request.getRequestDispatcher("/views/ingreso/listar.jsp");
    dispatcher.forward(request, response);
%>

