package service;

import dao.PlanDAO;
import dao.MembresiaDAO;
import java.time.LocalDate;
import java.util.List;
import model.Plan;
import model.Membresia;
import model.Socio;

public class MembresiaService {

    private MembresiaDAO membresiaDAO = new MembresiaDAO();
    private PlanDAO planDAO = new PlanDAO();
    
    public void MtVenderRenovarMembresia(int idSocio, int idPlan) throws Exception{
        Plan plan = planDAO.MtObtenerPorId(idPlan);
        if (plan == null || !plan.isEstado()){
            throw new Exception("El plan seleccionado no esta disponible");
        }
        
        Membresia ultimaMembresia = membresiaDAO.MtUltimaMembresiaPorSocio(idSocio);
        
        LocalDate fechaInicio;
        LocalDate hoy = LocalDate.now();
        
        if(ultimaMembresia != null && ultimaMembresia.getFechaFin().isAfter(hoy)){
            fechaInicio = ultimaMembresia.getFechaFin().plusDays(1);
        } else {
            fechaInicio = hoy;
        }
        
        LocalDate fechaFin = fechaInicio.plusDays(plan.getDuracionDias());
        
        Membresia nueva = new Membresia();
        nueva.setIdSocio(idSocio);
        nueva.setIdPlan(idPlan);
        nueva.setFechaInicio(fechaInicio);
        nueva.setFechaFin(fechaFin);
        nueva.setValorPagado(plan.getValor());
        
        membresiaDAO.MtVentaMembresia(nueva);
    }
    
    public Membresia MtUltimaMembresiaPorSocio(int idSocio){
        return membresiaDAO.MtUltimaMembresiaPorSocio(idSocio);
    }
    
    public List<Socio> MtSociosPorVencer(){
        return membresiaDAO.MtSociosPorVencer();
    }
    
    public List<Membresia> MtListarMembresias(){
        return membresiaDAO.MtListarMembresias();
    }
}
