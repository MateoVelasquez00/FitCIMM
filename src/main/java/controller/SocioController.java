package controller;

import java.io.Serializable;
import java.util.List;
import model.Socio;
import service.SocioService;

public class SocioController implements Serializable {
    
    private static final long serialVersionUID = 1L;
    
    private SocioService socioService;
    private Socio socio;
    private List<Socio> socios;
    private String mensaje;
    private String tipoMensaje;
    
    public SocioController() {
        this.socioService = new SocioService();
        this.socio = new Socio();
    }
    
    public String MtListarSocios() {
        try {
            socios = socioService.MtListarSocios();
            return "success";
        } catch (Exception e) {
            mensaje = "Error al listar socios: " + e.getMessage();
            tipoMensaje = "danger";
            return "error";
        }
    }
    
    public String MtBuscarSocio(String criterio) {
        try {
            if (criterio != null && !criterio.trim().isEmpty()) {
                socios = socioService.MtBuscarSocio(criterio);
            } else {
                socios = socioService.MtListarSocios();
            }
            return "success";
        } catch (Exception e) {
            mensaje = "Error en la busqueda: " + e.getMessage();
            tipoMensaje = "danger";
            return "error";
        }
    }
    
    public String MtCrearSocio(Socio NuevoSocio) {
        try {
            socioService.MtInsertarSocio(NuevoSocio);
            mensaje = "Socio registrado exitosamente";
            tipoMensaje = "success";
            return "success";
        } catch (Exception e) {
            mensaje = "Error: " + e.getMessage();
            tipoMensaje = "danger";
            return "error";
        }
    }
    
    public String MtActualizarSocio(Socio socioActualizado) {
        try {
            socioService.MtActualizarSocio(socioActualizado);
            mensaje = "Socio actualizado correctamente";
            tipoMensaje = "success";
            return "success";
        } catch (Exception e) {
            mensaje = "Error " + e.getMessage();
            tipoMensaje = "danger";
            return "error";
        }
    }
    
    public String MtEstadoSocio(int idSocio, boolean nuevoEstado) {
        try {
            socioService.MtEstadoSocio(idSocio, nuevoEstado);
            mensaje = "Estado del Socio actualizado correctamente";
            tipoMensaje = "success";
            return "success";
        } catch (Exception e) {
            mensaje = "Error: " + e.getMessage();
            tipoMensaje = "danger";
            return "error";
        }
    }
    
    public String MtDetalleSocio(int idMembresia) {
        try {
            socio = socioService.MtDetalleSocio(idMembresia);
            return "success";
        } catch (Exception e) {
            mensaje = "Error al mostrar detalle: " + e.getMessage();
            tipoMensaje = "danger";
            return "error";
        }
    }
    
    public String MtBuscarPorDocumento(String documento) {
        try {
            socio = socioService.MtBuscarPorDocumento(documento);
            if (socio == null) {
                mensaje = "Socio no encointrado";
                tipoMensaje = "warning";
                return "notfound";
            }
            return "success";
        } catch (Exception e) {
            mensaje = "Error: " + e.getMessage();
            tipoMensaje = "danger";
            return "error";
        }
    }
    
    public String MtObtenerPorId(int idSocio) {
        try {
            socio = socioService.MtObtenerPorId(idSocio);
            if (socio == null) {
                mensaje = "Socio no encointrado";
                tipoMensaje = "warning";
                return "notfound";
            }
            return "success";
        } catch (Exception e) {
            mensaje = "Error: " + e.getMessage();
            tipoMensaje = "danger";
            return "error";
        }
    }
    
    public Socio getSocio() {
        return socio;
    }
    
    public void setSocio(Socio socio) {
        this.socio = socio;
    }
    
    public List<Socio> getSocios() {
        return socios;
    }
    
    public void setSocios(List<Socio> socios) {
        this.socios = socios;
    }
    
    public String getMensaje() {
        return mensaje;
    }
    
    public void setMensaje(String mensaje) {
        this.mensaje = mensaje;
    }
    
    public String getTipoMensaje() {
        return tipoMensaje;
    }
    
    public void setTipoMensaje(String tipoMensaje) {
        this.tipoMensaje = tipoMensaje;
    }
}
