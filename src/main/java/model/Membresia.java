package model;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;

public class Membresia {
    private int Id;
    private int IdSocio;
    private int IdPlan;
    private LocalDate FechaInicio;
    private LocalDate FechaFin;
    private BigDecimal ValorPagado;
    private Socio socio;
    private Plan plan;

    public Membresia() {
    }

    public Membresia(int IdSocio, int IdPlan, LocalDate FechaInicio, LocalDate FechaFin, BigDecimal ValorPagado) {
        this.IdSocio = IdSocio;
        this.IdPlan = IdPlan;
        this.FechaInicio = FechaInicio;
        this.FechaFin = FechaFin;
        this.ValorPagado = ValorPagado;
    }

    public int getId() {
        return Id;
    }

    public void setId(int Id) {
        this.Id = Id;
    }

    public int getIdSocio() {
        return IdSocio;
    }

    public void setIdSocio(int IdSocio) {
        this.IdSocio = IdSocio;
    }

    public int getIdPlan() {
        return IdPlan;
    }

    public void setIdPlan(int IdPlan) {
        this.IdPlan = IdPlan;
    }

    public LocalDate getFechaInicio() {
        return FechaInicio;
    }

    public void setFechaInicio(LocalDate FechaInicio) {
        this.FechaInicio = FechaInicio;
    }

    public LocalDate getFechaFin() {
        return FechaFin;
    }

    public void setFechaFin(LocalDate FechaFin) {
        this.FechaFin = FechaFin;
    }

    public void setValorPagado(BigDecimal ValorPagado) {
        this.ValorPagado = ValorPagado;
    }

    public BigDecimal getValorPagado() {
        return ValorPagado;
    }

    public Socio getSocio() {
        return socio;
    }

    public void setSocio(Socio socio) {
        this.socio = socio;
    }

    public Plan getPlan() {
        return plan;
    }

    public void setPlan(Plan plan) {
        this.plan = plan;
    }
    
    
    
    public String getEstadoCalculado(){
        if(this.FechaFin == null)
            return "DESCONOCIDO";
        
        LocalDate hoy = LocalDate.now();
        
        if(this.FechaFin.isBefore(hoy)){
            return "VENCIDA";
        }
        
        long diasRestantes = ChronoUnit.DAYS.between(hoy, this.FechaFin);
        
        if (diasRestantes <= 5){
            return "POR VENCER";
        }
        return "VIGENTE";
    }

    @Override
    public String toString() {
        return "Membresia{" + 
                "Id=" + Id + 
                ", IdSocio=" + IdSocio + 
                ", IdPlan=" + IdPlan + 
                ", FechaInicio=" + FechaInicio + 
                ", FechaFin=" + FechaFin + 
                ", ValorPagado=" + ValorPagado + 
                '}';
    }
    
    
}
