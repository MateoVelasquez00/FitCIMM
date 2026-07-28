package service;

import dao.*;
import java.time.LocalDate;
import java.util.List;
import model.*;

public class IngresoService {
    
    private SocioDAO socioDAO = new SocioDAO();
    private IngresoDAO ingresoDAO = new IngresoDAO();
    private MembresiaDAO membresiaDAO = new MembresiaDAO();
    
public String MtRegistrarPorDocumento(String documento) throws Exception {
    Socio socio = socioDAO.MtBuscarPorDocumento(documento);
    if (socio == null) {
        throw new Exception("El socio no se encuentra registrado");
    }
    if (!socio.isEstado()) {
        throw new Exception("Acceso Denegado: El socio se encuentra INACTIVO");
    }

    Membresia ultimaMembresia = membresiaDAO.MtUltimaMembresiaPorSocio(socio.getId());
    if (ultimaMembresia == null) {
        throw new Exception("Acceso Denegado: El socio no registra ninguna membresía");
    }

    String estadoMembresia = ultimaMembresia.getEstadoCalculado();
    if ("VENCIDA".equals(estadoMembresia)) {
        throw new Exception("Acceso Denegado: La membresía de " + socio.getNombre() + " venció el " + ultimaMembresia.getFechaFin());
    }

    LocalDate hoy = LocalDate.now();
    if (ingresoDAO.MtIngresoHoy(socio.getId(), hoy)) {
        throw new Exception("Advertencia: El socio " + socio.getNombre() + " " + socio.getApellido() + " ya registró su ingreso el día de hoy");
    }
    
    Ingreso nuevoIngreso = new Ingreso();
    nuevoIngreso.setIdSocio(socio.getId());


    boolean guardado = ingresoDAO.MtInsertarIngreso(nuevoIngreso);
    if (!guardado) {
        throw new Exception("Ocurrió un error en la base de datos al registrar el ingreso.");
    }

    long diasRestantes = java.time.temporal.ChronoUnit.DAYS.between(hoy, ultimaMembresia.getFechaFin());

    return "¡Ingreso Exitoso! Bienvenido(a) " + socio.getNombre() + " " + socio.getApellido() + 
           ". Le quedan " + diasRestantes + " día(s) de membresía (Vence: " + ultimaMembresia.getFechaFin() + ")";
}
    
    public List<Ingreso> MtconsultarIngresosPorFecha(LocalDate fecha) throws Exception {
        if (fecha == null) {
            throw new Exception("Debe proporcionar una fecha válida para la consulta");
        }
        return ingresoDAO.MtConsultarPorFecha(fecha);
    }
    
    public List<Ingreso> MtListarIngresos(){
        return ingresoDAO.MtListarIngresos();
    }
}
