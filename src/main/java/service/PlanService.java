package service;

import dao.PlanDAO;
import java.util.List;
import model.Plan;

public class PlanService {

    private PlanDAO planDAO = new PlanDAO();

    public void MtInsertarPlan(Plan plan) throws Exception {
        if (plan.getValor() == null || plan.getValor().doubleValue() <= 0) {
            throw new Exception("El valor del plan debe ser mayor a 0");
        }
        if (plan.getDuracionDias() < 1 || plan.getDuracionDias() > 365) {
            throw new Exception("La duracion del plan debe estar entre 1 y 365 dias");
        }
        planDAO.MtInsertarPlan(plan);
    }

    public void MtEstadoPlan(int idPlan, boolean NuevoEstado) throws Exception {

        boolean actualizado = planDAO.MtEstadoPlan(idPlan, NuevoEstado);
        if (!actualizado) {
            throw new Exception("No se pudo inactivar el Plan. El ID no existe");
        }
    }

    public List<Plan> MtListarPlanes() {
        return planDAO.MtListarPlanes();
    }

    public boolean MtActualizarPlan(Plan plan) throws Exception{
        boolean actualizado = planDAO.MtActualizarPlan(plan);
        if (!actualizado) {
            throw new Exception("No se pudo actualizar el Plan");
        }
        return true;
    }

    public Plan MtObtenerPorId(int id) {
        return planDAO.MtObtenerPorId(id);
    }

    public boolean MtTieneMembresiasAsociadas(int idPlan) {
        return planDAO.MtTieneMembresiasAsociadas(idPlan);
    }
}
