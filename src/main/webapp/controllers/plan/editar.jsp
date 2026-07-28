<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="controller.PlanController, service.PlanService" %>

<%
    int idPlan = Integer.parseInt(request.getParameter("id"));
    PlanController controller = new PlanController();
    String resultado = controller.MtObtenerPorId(idPlan);
    
    if ("notfound".equals(resultado)) {
        response.sendRedirect(request.getContextPath() + "/controllers/plan/listar.jsp");
        return;
    }
    
    request.setAttribute("plan", controller.getPlan());
    request.setAttribute("titulo", "Editar Plan - Sistema FitCIMM");
    
    RequestDispatcher dispatcher = request.getRequestDispatcher("/views/plan/editar.jsp");
    dispatcher.forward(request, response);
   
%>
