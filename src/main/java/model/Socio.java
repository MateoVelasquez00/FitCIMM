package model;

import java.time.LocalDate;

public class Socio {
    private int Id;
    private String Documento;
    private String Nombre;
    private String Apellido;
    private String Telefono;
    private String Correo;
    private LocalDate FechaNacimiento;
    private boolean Estado;
    
    //Constructor Vacio
    public Socio() {
}

    public Socio(String Documento, String Nombre, String Apellido, String Telefono, String Correo, LocalDate FechaNacimiento, boolean Estado) {
        this.Documento = Documento;
        this.Nombre = Nombre;
        this.Apellido = Apellido;
        this.Telefono = Telefono;
        this.Correo = Correo;
        this.FechaNacimiento = FechaNacimiento;
        this.Estado = Estado;
    }

    public int getId() {
        return Id;
    }

    public void setId(int Id) {
        this.Id = Id;
    }

    public String getDocumento() {
        return Documento;
    }

    public void setDocumento(String Documeto) {
        this.Documento = Documeto;
    }

    public String getNombre() {
        return Nombre;
    }

    public void setNombre(String Nombre) {
        this.Nombre = Nombre;
    }

    public String getApellido() {
        return Apellido;
    }

    public void setApellido(String Apellido) {
        this.Apellido = Apellido;
    }

    public String getTelefono() {
        return Telefono;
    }

    public void setTelefono(String Telefono) {
        this.Telefono = Telefono;
    }

    public String getCorreo() {
        return Correo;
    }

    public void setCorreo(String Correo) {
        this.Correo = Correo;
    }

    public LocalDate getFechaNacimiento() {
        return FechaNacimiento;
    }

    public void setFechaNacimiento(LocalDate FechaNacimiento) {
        this.FechaNacimiento = FechaNacimiento;
    }

    public boolean isEstado() {
        return Estado;
    }

    public void setEstado(boolean Estado) {
        this.Estado = Estado;
    }
    
    @Override
    public String toString() {
        return "Socio{" + 
                "Id=" + Id + 
                ", Documeto=" + Documento + 
                ", Nombre=" + Nombre + 
                ", Apellido=" + Apellido + 
                ", Telefono=" + Telefono + 
                ", Correo=" + Correo + 
                ", FechaNacimiento=" + FechaNacimiento + 
                ", Estado=" + Estado + 
                '}';
    }
    
}
