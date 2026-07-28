package model;

import java.math.BigDecimal;

public class Plan {
    private int Id;
    private String Nombre;
    private int DuracionDias;
    private BigDecimal Valor;
    private boolean Estado;

    public Plan() {
    }

    public Plan(String Nombre, int DuracionDias, BigDecimal Valor, boolean Estado) {
        this.Nombre = Nombre;
        this.DuracionDias = DuracionDias;
        this.Valor = Valor;
        this.Estado = Estado;
    }

    public int getId() {
        return Id;
    }

    public void setId(int Id) {
        this.Id = Id;
    }

    public String getNombre() {
        return Nombre;
    }

    public void setNombre(String Nombre) {
        this.Nombre = Nombre;
    }

    public int getDuracionDias() {
        return DuracionDias;
    }

    public void setDuracionDias(int DuracionDias) {
        this.DuracionDias = DuracionDias;
    }
    
    public BigDecimal getValor() {
        return Valor;
    }

    public void setValor(BigDecimal Valor) {
        this.Valor = Valor;
    }

    public boolean isEstado() {
        return Estado;
    }

    public void setEstado(boolean Estado) {
        this.Estado = Estado;
    }



    @Override
    public String toString() {
        return "Plan{" + 
                "Id=" + Id + 
                ", Nombre=" + Nombre + 
                ", DuracionDias=" + DuracionDias + 
                ", Valor=" + Valor + 
                ", Estado=" + Estado + 
                '}';
    }
    
    
    
}
