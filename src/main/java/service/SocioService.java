package service;

import dao.SocioDAO;
import java.time.LocalDate;
import java.time.Period;
import java.util.List;
import model.Socio;
import model.Membresia;

public class SocioService {

    private SocioDAO socioDAO = new SocioDAO();

    public void MtInsertarSocio(Socio socio) throws Exception {
        if (socioDAO.MtBuscarPorDocumento(socio.getDocumento()) != null) {
            throw new Exception("Ya existe un socio con el documento: " + socio.getDocumento());
        }

        if (socio.getFechaNacimiento() == null) {
            throw new Exception("La fecha de nacimiento es obligatoria");
        }

        int edad = Period.between(socio.getFechaNacimiento(), LocalDate.now()).getYears();

        if (edad < 15) {
            throw new Exception("El socio debe ser mayor de 15 años. Edad actual: " + edad + " años"); 
        }
        
        socioDAO.MtInsertarSocio(socio);
    }

    public void MtEstadoSocio(int idSocio, boolean NuevoEstado) throws Exception {
        boolean actualizado = socioDAO.MtEstadoSocio(idSocio, NuevoEstado);
        if (!actualizado){
            throw new Exception("No se pudo inactivar el socio. El ID no existe");
        }
    }
    
    public List<Socio> MtListarSocios(){
        return socioDAO.MtListarSocio();
    }
    
    public boolean MtActualizarSocio(Socio socio)throws Exception{
        boolean actualizado = socioDAO.MtActualizaSocio(socio);
        if (!actualizado){
            throw new Exception("No se pudo actualizar el socio");
        }
        return true;
    }
    
    public List<Socio> MtBuscarSocio(String criterio){
        return socioDAO.MtBuscarSocio(criterio);
    }
    
    public List<Membresia> MtDetalleSocio(int socioId){
        return socioDAO.MtListarMembresiasPorSocio(socioId);
    }
    
    public Socio MtBuscarPorDocumento(String documento){
        return socioDAO.MtBuscarPorDocumento(documento);
    }   
    
    public Socio MtObtenerPorId(int idSocio){
        return socioDAO.MtObtenerPorId(idSocio);
    }
}
