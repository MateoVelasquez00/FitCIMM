package controller;

import java.io.Serializable;
import java.time.LocalDate;
import java.util.List;
import service.IngresoService;
import model.Ingreso;

public class IngresoController implements Serializable {

    private static final long serialVersionUID = 1L;

    private IngresoService ingresoService;
    private Ingreso ingreso;
    private List<Ingreso> ingresos;
    private String mensaje;
    private String tipoMensaje;

    public IngresoController() {
        this.ingresoService = new IngresoService();
        this.ingreso = new Ingreso();
    }

    public String MtListarIngresos() {
        try {
            ingresos = ingresoService.MtListarIngresos();
            return "success";
        } catch (Exception e) {
            mensaje = "Error al listar los ingresos: " + e.getMessage();
            tipoMensaje = "danger";
            return "error";
        }
    }

    public String MtRegistrarPorDocumento(String documento) {
        try {
            mensaje = ingresoService.MtRegistrarPorDocumento(documento);
            tipoMensaje = "success";
            return "success";
        } catch (Exception e) {
            mensaje = e.getMessage();
            tipoMensaje = "danger";
            return "error";
        }
    }

    public String MtConsultarIngresosPorFecha(LocalDate fecha) {
        try {
            ingresos = ingresoService.MtconsultarIngresosPorFecha(fecha);
            return "success";
        } catch (Exception e) {
            mensaje = "Error al consultar ingresos por fecha: " + e.getMessage();
            tipoMensaje = "danger";
            return "error";
        }
    }
    
    public Ingreso getIngreso() {
        return ingreso;
    }

    public void setIngreso(Ingreso ingreso) {
        this.ingreso = ingreso;
    }

    public List<Ingreso> getIngresos() {
        return ingresos;
    }

    public void setIngresos(List<Ingreso> ingresos) {
        this.ingresos = ingresos;
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