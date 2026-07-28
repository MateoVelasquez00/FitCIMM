package controller;

import java.io.Serializable;
import java.util.List;
import service.PlanService;
import model.Plan;

public class PlanController implements Serializable {

    private static final long serialVersionUID = 1L;

    private PlanService planService;
    private Plan plan;
    private List<Plan> planes;
    private String mensaje;
    private String tipoMensaje;

    public PlanController() {
        this.planService = new PlanService();
        this.plan = new Plan();
    }

    public String MtListarPlanes() {
        try {
            planes = planService.MtListarPlanes();
            return "success";
        } catch (Exception e) {
            mensaje = "Error al listar los planes: " + e.getMessage();
            tipoMensaje = "danger";
            return "error";
        }
    }

    public String MtCrearPlan(Plan NuevoPlan) {
        try {
            planService.MtInsertarPlan(NuevoPlan);
            mensaje = "Plan registrado exitosamente";
            tipoMensaje = "success";
            return "success";
        } catch (Exception e) {
            mensaje = "Error: " + e.getMessage();
            tipoMensaje = "danger";
            return "error";
        }
    }

    public String MtActualizarPlan(Plan planActualizado) {
        try {
            planService.MtActualizarPlan(planActualizado);
            mensaje = "Plan actualizado correctamente";
            tipoMensaje = "success";
            return "success";
        } catch (Exception e) {
            mensaje = "Error: " + e.getMessage();
            tipoMensaje = "danger";
            return "error";
        }
    }

    public String MtObtenerPorId(int idPlan) {
        try {
            plan = planService.MtObtenerPorId(idPlan);
            if (plan == null) {
                mensaje = "Plan no encointrado";
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

    public String MtEstadoPlan(int idPlan, boolean nuevoEstado) {
        try {
            planService.MtEstadoPlan(idPlan, nuevoEstado);
            mensaje = "Estado del Plan actualizado correctamente";
            tipoMensaje = "success";
            return "success";
        } catch (Exception e) {
            mensaje = "Error: " + e.getMessage();
            tipoMensaje = "danger";
            return "error";
        }
    }

    public Plan getPlan() {
        return plan;
    }

    public void setPlan(Plan plan) {
        this.plan = plan;
    }

    public List<Plan> getPlanes() {
        return planes;
    }

    public void setPlanes(List<Plan> planes) {
        this.planes = planes;
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
