package model;

import java.time.LocalDate;
import java.time.LocalTime;

public class Ingreso {
    private int Id;
    private int IdSocio;
    private LocalDate FechaIngreso;
    private LocalTime HoraIngreso;
    private Socio socio;

    public Ingreso() {
    }

    public Ingreso(int IdSocio, LocalDate FechaIngreso, LocalTime HoraIngreso) {
        this.IdSocio = IdSocio;
        this.FechaIngreso = FechaIngreso;
        this.HoraIngreso = HoraIngreso;
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

    public LocalDate getFechaIngreso() {
        return FechaIngreso;
    }

    public void setFechaIngreso(LocalDate FechaIngreso) {
        this.FechaIngreso = FechaIngreso;
    }

    public LocalTime getHoraIngreso() {
        return HoraIngreso;
    }

    public void setHoraIngreso(LocalTime HoraIngreso) {
        this.HoraIngreso = HoraIngreso;
    }

    public Socio getSocio() {
        return socio;
    }

    public void setSocio(Socio socio) {
        this.socio = socio;
    }
    
    @Override
    public String toString() {
        return "Ingreso{" + 
                "Id=" + Id + 
                ", IdSocio=" + IdSocio + 
                ", FechaIngreso=" + FechaIngreso + 
                ", HoraIngreso=" + HoraIngreso + 
                '}';
    }
    
    
}
