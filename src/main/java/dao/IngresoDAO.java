package dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import model.Ingreso;
import model.Socio;

public class IngresoDAO {

    public boolean MtInsertarIngreso(Ingreso ingreso) {
        String consulta = "INSERT INTO ingreso (id_socio) VALUES (?)";

        try (Connection conn = Conexion.getConnection(); PreparedStatement pstmt = conn.prepareStatement(consulta)) {

            pstmt.setInt(1, ingreso.getIdSocio());
            
            int filasAfectadas = pstmt.executeUpdate();
            return filasAfectadas > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean MtIngresoHoy(int idSocio, LocalDate fecha) {
        String consulta = "SELECT COUNT(*) FROM ingreso"
                + "WHERE id_socio AND fecha_ingreso = ?";

        try (Connection conn = Conexion.getConnection(); PreparedStatement pstmt = conn.prepareStatement(consulta)) {

            pstmt.setInt(1, idSocio);
            pstmt.setDate(2, Date.valueOf(fecha));

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public List<Ingreso> MtConsultarPorFecha(LocalDate fecha) {
        List<Ingreso> lista = new ArrayList<>();
        String consulta = "SELECT * FROM ingreso"
                + "WHERE fecha_ingreso = ?"
                + "ORDER BY hora_ingreso DESC";

        try (Connection conn = Conexion.getConnection(); PreparedStatement pstmt = conn.prepareStatement(consulta)) {

            pstmt.setDate(1, Date.valueOf(fecha));

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    Ingreso ingreso = new Ingreso();
                    ingreso.setId(rs.getInt("id_ingreso"));
                    ingreso.setIdSocio(rs.getInt("id_socio"));
                    ingreso.setFechaIngreso(rs.getDate("fecha_ingreso").toLocalDate());
                    ingreso.setHoraIngreso(rs.getTime("hora_ingreso").toLocalTime());
                    lista.add(ingreso);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }

    public List<Ingreso> MtListarIngresos() {
        List<Ingreso> lista = new ArrayList<>();
        String consulta = "SELECT i.*, s.documento FROM ingreso i "
                + "INNER JOIN socio s ON i.id_socio = s.id_socio "
                + "ORDER BY i.fecha_ingreso DESC";

        try (Connection conn = Conexion.getConnection(); PreparedStatement pstmt = conn.prepareStatement(consulta)) {

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    Ingreso ingreso = new Ingreso();
                    ingreso.setId(rs.getInt("id_ingreso"));
                    ingreso.setIdSocio(rs.getInt("id_socio"));
                    ingreso.setFechaIngreso(rs.getDate("fecha_ingreso").toLocalDate());
                    ingreso.setHoraIngreso(rs.getTime("hora_ingreso").toLocalTime());
                    
                    Socio socio = new Socio();
                    socio.setId(rs.getInt("id_socio"));
                    socio.setDocumento(rs.getString("documento"));
                    ingreso.setSocio(socio);
                    lista.add(ingreso);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }
}
