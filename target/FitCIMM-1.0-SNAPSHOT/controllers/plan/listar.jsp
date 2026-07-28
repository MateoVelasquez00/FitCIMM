<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="controller.PlanController" %>
<%
    request.setCharacterEncoding("UTF-8");
    PlanController controller = new PlanController();
    
    request.setAttribute("planes", controller.getPlanes());
    request.setAttribute("titulo", "Planes - Sistema FitCIMM");
    
    RequestDispatcher dispatcher = request.getRequestDispatcher("/views/plan/listar.jsp");
    dispatcher.forward(request, response);
%>

