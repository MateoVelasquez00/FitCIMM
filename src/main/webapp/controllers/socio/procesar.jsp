<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="controller.SocioController, model.Socio, java.time.LocalDate" %>
<%
    request.setCharacterEncoding("UTF-8");
    String accion = request.getParameter("accion");
    SocioController controller = new SocioController();

    try {
        if ("crear".equals(accion)) {
            Socio socio = new Socio();
            socio.setDocumento(request.getParameter("documento"));
            socio.setNombre(request.getParameter("nombres"));
            socio.setApellido(request.getParameter("apellidos"));
            socio.setTelefono(request.getParameter("telefono"));
            socio.setCorreo(request.getParameter("email"));
            socio.setFechaNacimiento(LocalDate.parse(request.getParameter("fechaNacimiento")));
            boolean estado = Boolean.parseBoolean(request.getParameter("estado"));
            socio.setEstado(estado);
            controller.MtCrearSocio(socio);

        } else if ("editar".equals(accion)) {
            Socio socio = new Socio();
            socio.setId(Integer.parseInt(request.getParameter("id")));
            socio.setDocumento(request.getParameter("documento"));
            socio.setNombre(request.getParameter("nombres"));
            socio.setApellido(request.getParameter("apellidos"));
            socio.setTelefono(request.getParameter("telefono"));
            socio.setCorreo(request.getParameter("email"));
            socio.setFechaNacimiento(LocalDate.parse(request.getParameter("fechaNacimiento")));
            boolean estado = Boolean.parseBoolean(request.getParameter("estado"));
            socio.setEstado(estado);
            controller.MtActualizarSocio(socio);
            
        } else if ("cambiarEstado".equals(accion)) {
            int idSocio = Integer.parseInt(request.getParameter("id"));
            boolean nuevoEstado = Boolean.parseBoolean(request.getParameter("nuevoEstado"));
            controller.MtEstadoSocio(idSocio, nuevoEstado);
        }
        session.setAttribute("mensaje", controller.getMensaje());
        session.setAttribute("tipoMensaje", controller.getTipoMensaje());
    } catch (Exception e) {
        session.setAttribute("mensaje", "Error: " + e.getMessage());
        session.setAttribute("tipoMensaje", "danger");
    }
    response.sendRedirect(request.getContextPath() + "/controllers/socio/listar.jsp");
%>
