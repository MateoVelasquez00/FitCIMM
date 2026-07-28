<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="controller.PlanController, model.Plan, java.math.BigDecimal" %>
<%
    request.setCharacterEncoding("UTF-8");
    String accion = request.getParameter("accion");
    PlanController controller = new PlanController();

    try {
        if ("crear".equals(accion)) {
            Plan plan = new Plan();
            plan.setNombre(request.getParameter("nombre"));
            
            String duracionStr = request.getParameter("duracionDias");
            if (duracionStr != null && !duracionStr.trim().isEmpty()) {
                try {
                    int duracion = Integer.parseInt(duracionStr.trim());
                    plan.setDuracionDias(duracion);
                } catch (NumberFormatException e) {
                    plan.setDuracionDias(0);
                }
            }

            String valorStr = request.getParameter("valor");
            if (valorStr != null && !valorStr.trim().isEmpty()) {
                try {
                    plan.setValor(new BigDecimal(valorStr.trim()));
                } catch (NumberFormatException e) {
                    System.err.println("El valor ingresado no es un número válido: " + valorStr);
                    plan.setValor(BigDecimal.ZERO);
                }
            } else {
                plan.setValor(BigDecimal.ZERO);
            }

            boolean estado = Boolean.parseBoolean(request.getParameter("estado"));
            plan.setEstado(estado);
            controller.MtCrearPlan(plan);

        } else if ("editar".equals(accion)) {
            Plan plan = new Plan();
            plan.setId(Integer.parseInt(request.getParameter("id")));
            plan.setNombre(request.getParameter("nombre"));
            String duracionStr = request.getParameter("duracionDias");

            if (duracionStr != null && !duracionStr.trim().isEmpty()) {
                try {
                    int duracion = Integer.parseInt(duracionStr.trim());
                    plan.setDuracionDias(duracion);
                } catch (NumberFormatException e) {
                    plan.setDuracionDias(0);
                }
            }

            String valorStr = request.getParameter("valor");

            if (valorStr != null && !valorStr.trim().isEmpty()) {
                try {
                    plan.setValor(new BigDecimal(valorStr.trim()));
                } catch (NumberFormatException e) {
                    System.err.println("El valor ingresado no es un número válido: " + valorStr);
                    plan.setValor(BigDecimal.ZERO);
                }
            } else {
                plan.setValor(BigDecimal.ZERO);
            }

            boolean estado = Boolean.parseBoolean(request.getParameter("estado"));
            plan.setEstado(estado);
            controller.MtActualizarPlan(plan);

        } else if ("cambiarEstado".equals(accion)) {
            int idPlan = Integer.parseInt(request.getParameter("id"));
            boolean nuevoEstado = Boolean.parseBoolean(request.getParameter("nuevoEstado"));
            controller.MtEstadoPlan(idPlan, nuevoEstado);
        }

        session.setAttribute("mensaje", controller.getMensaje());
        session.setAttribute("tipoMensaje", controller.getTipoMensaje());

    } catch (Exception e) {
        session.setAttribute("mensaje", "Error: " + e.getMessage());
        session.setAttribute("tipoMensaje", "danger");
    }

    response.sendRedirect(request.getContextPath() + "/controllers/plan/listar.jsp");
%>
