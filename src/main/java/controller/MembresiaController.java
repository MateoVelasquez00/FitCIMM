package controller;

import java.io.Serializable;
import java.time.LocalDate;
import java.util.List;
import service.MembresiaService;
import model.Membresia;
import model.Socio;

public class MembresiaController implements Serializable {

    private static final long serialVersionUID = 1L;

    private MembresiaService membresiaService;
    private Membresia membresia;
    private List<Membresia> membresias;
    private List<Socio> sociosPorVencer;
    private String mensaje;
    private String tipoMensaje;
    private List<Membresia> sociosActivosVigentes;
    private List<Membresia> recaudacionPorPlan;

    public MembresiaController() {
        this.membresiaService = new MembresiaService();
        this.membresia = new Membresia();
    }

    public String MtListarMembresias() {
        try {
            membresias = membresiaService.MtListarMembresias();
            return "success";
        } catch (Exception e) {
            mensaje = "Error al listar las membresías: " + e.getMessage();
            tipoMensaje = "danger";
            return "error";
        }
    }

    public String MtVenderRenovarMembresia(int idSocio, int idPlan) {
        try {
            membresiaService.MtVenderRenovarMembresia(idSocio, idPlan);
            mensaje = "Membresía registrada/renovada exitosamente.";
            tipoMensaje = "success";
            return "success";
        } catch (Exception e) {
            mensaje = "Error al procesar la membresía: " + e.getMessage();
            tipoMensaje = "danger";
            return "error";
        }
    }

    public String MtUltimaMembresiaPorSocio(int idSocio) {
        try {
            membresia = membresiaService.MtUltimaMembresiaPorSocio(idSocio);
            if (membresia == null) {
                mensaje = "El socio no cuenta con historial de membresías.";
                tipoMensaje = "warning";
                return "notfound";
            }
            return "success";
        } catch (Exception e) {
            mensaje = "Error al consultar última membresía: " + e.getMessage();
            tipoMensaje = "danger";
            return "error";
        }
    }

    public String MtSociosPorVencer() {
        try {
            sociosPorVencer = membresiaService.MtSociosPorVencer();
            return "success";
        } catch (Exception e) {
            mensaje = "Error al consultar socios por vencer: " + e.getMessage();
            tipoMensaje = "danger";
            return "error";
        }
        
    }
    public String MtSociosActivosVigentes() {
        try {
            // Llama a la capa de servicio y guarda la lista resultante
            sociosActivosVigentes = membresiaService.MtSociosActivosVigentes();
            return "success";
        } catch (Exception e) {
            mensaje = "Error al obtener el reporte de socios activos: " + e.getMessage();
            tipoMensaje = "danger";
            return "error";
        }
    }
public String MtRecaudacionPorRangoFechas(LocalDate fechaInicio, LocalDate fechaFin) {
    try {
        // Llama a la capa de servicio pasando las fechas seleccionadas
        recaudacionPorPlan = membresiaService.MtRecaudacionPorRangoFechas(fechaInicio, fechaFin);
        return "success";
    } catch (Exception e) {
        mensaje = "Error al obtener la recaudación por plan: " + e.getMessage();
        tipoMensaje = "danger";
        return "error";
    }
}
    public Membresia getMembresia() {
        return membresia;
    }

    public void setMembresia(Membresia membresia) {
        this.membresia = membresia;
    }

    public List<Membresia> getMembresias() {
        return membresias;
    }

    public void setMembresias(List<Membresia> membresias) {
        this.membresias = membresias;
    }

    public List<Socio> getSociosPorVencer() {
        return sociosPorVencer;
    }

    public void setSociosPorVencer(List<Socio> sociosPorVencer) {
        this.sociosPorVencer = sociosPorVencer;
    }

    public List<Membresia> getSociosActivosVigentes() {
        return sociosActivosVigentes;
    }

    public void setSociosActivosVigentes(List<Membresia> sociosActivosVigentes) {
        this.sociosActivosVigentes = sociosActivosVigentes;
    }

    public List<Membresia> getRecaudacionPorPlan() {
        return recaudacionPorPlan;
    }

    public void setRecaudacionPorPlan(List<Membresia> recaudacionPorPlan) {
        this.recaudacionPorPlan = recaudacionPorPlan;
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