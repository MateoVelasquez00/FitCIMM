package dao;

import java.sql.Date;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import model.Membresia;
import model.Socio;
import model.Plan;

public class MembresiaDAO {

    public boolean MtVentaMembresia(Membresia membresia) {
        String consulta = "INSERT INTO membresia (id_socio, id_plan, fecha_inicio, fecha_fin, valor_pagado)"
                + "VALUES (?, ?, ?, ?, ?)";

        try (Connection conn = Conexion.getConnection(); PreparedStatement pstmt = conn.prepareStatement(consulta)) {

            pstmt.setInt(1, membresia.getIdSocio());
            pstmt.setInt(2, membresia.getIdPlan());
            pstmt.setDate(3, Date.valueOf(membresia.getFechaInicio()));
            pstmt.setDate(4, Date.valueOf(membresia.getFechaFin()));
            pstmt.setBigDecimal(5, membresia.getValorPagado());

            int filasAfectadas = pstmt.executeUpdate();
            return filasAfectadas > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public Membresia MtUltimaMembresiaPorSocio(int idSocio) {
        Membresia membresia = null;

        String consulta = "SELECT * FROM membresia WHERE id_socio = ? "
                + "ORDER BY fecha_fin DESC LIMIT 1";

        try (Connection conn = Conexion.getConnection(); PreparedStatement pstmt = conn.prepareStatement(consulta)) {

            pstmt.setInt(1, idSocio);

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    membresia = new Membresia();
                    membresia.setId(rs.getInt("id_membresia"));
                    membresia.setIdSocio(rs.getInt("id_socio"));
                    membresia.setIdPlan(rs.getInt("id_plan"));
                    membresia.setFechaInicio(rs.getDate("fecha_inicio").toLocalDate());
                    membresia.setFechaFin(rs.getDate("fecha_fin").toLocalDate());
                    membresia.setValorPagado(rs.getBigDecimal("valor_pagado"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return membresia;
    }

    public List<Socio> MtSociosPorVencer() {
        List<Socio> lista = new ArrayList<>();

        LocalDate hoy = LocalDate.now();
        LocalDate limite = hoy.plusDays(5);

        String consulta = "SELECT s.id_socio, s.nombres, s.apellidos, s.telefono, s.correo, m.fecha_fin"
                + "FROM socio s"
                + "INNER JOIN membresia m ON s.id_socio = m.id_socio"
                + "WHERE m.fecha_fin BETWEEN ? AND ? "
                + "ORDER BY m.fecha_fin ASC";

        try (Connection conn = Conexion.getConnection(); PreparedStatement pstmt = conn.prepareStatement(consulta)) {

            pstmt.setDate(1, Date.valueOf(hoy));
            pstmt.setDate(2, Date.valueOf(limite));

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    Socio socio = new Socio();
                    socio.setId(rs.getInt("id_socio"));
                    socio.setNombre(rs.getString("nombres"));
                    socio.setApellido(rs.getString("apellidos"));
                    socio.setTelefono(rs.getString("telefono"));
                    socio.setCorreo(rs.getString("correo"));

                    lista.add(socio);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }

    public List<Membresia> MtListarMembresias() {
        List<Membresia> lista = new ArrayList<>();

        String consulta = "SELECT m.id_membresia, m.id_socio, m.id_plan, m.fecha_inicio, m.fecha_fin, m.valor_pagado, "
                + "s.nombres, s.apellidos, s.documento, p.nombre "
                + "FROM membresia m "
                + "INNER JOIN socio s ON m.id_socio = s.id_socio "
                + "INNER JOIN plan p ON m.id_plan = p.id_plan "
                + "ORDER BY m.fecha_fin DESC";

        try (Connection conn = Conexion.getConnection(); Statement stmt = conn.createStatement(); ResultSet rs = stmt.executeQuery(consulta)) {

            while (rs.next()) {
                Membresia membresia = new Membresia();
                membresia.setId(rs.getInt("id_membresia"));
                membresia.setIdSocio(rs.getInt("id_socio"));
                membresia.setIdPlan(rs.getInt("id_plan"));
                membresia.setFechaInicio(rs.getDate("fecha_inicio").toLocalDate());
                membresia.setFechaFin(rs.getDate("fecha_fin").toLocalDate());
                membresia.setValorPagado(rs.getBigDecimal("valor_pagado"));

                Socio socio = new Socio();
                socio.setId(rs.getInt("id_socio"));
                socio.setNombre(rs.getString("nombres"));
                socio.setApellido(rs.getString("apellidos"));
                socio.setDocumento(rs.getString("documento"));
                membresia.setSocio(socio);

                Plan plan = new Plan();
                plan.setId(rs.getInt("id_plan"));
                plan.setNombre(rs.getString("nombre"));
                membresia.setPlan(plan);
                
                lista.add(membresia);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }
    public List<Membresia> MtSociosActivosVigentes() {
    List<Membresia> lista = new ArrayList<>();
    
    // Consulta los socios con su membresía más reciente vigente (fecha_fin >= HOY)
    String consulta = "SELECT m.id_membresia, m.id_socio, m.id_plan, m.fecha_inicio, m.fecha_fin, m.valor_pagado, "
        + "s.nombres, s.apellidos, s.documento, s.telefono, s.correo, s.estado, p.nombre AS nombre_plan "
        + "FROM membresia m "
        + "INNER JOIN socio s ON m.id_socio = s.id_socio "
        + "INNER JOIN plan p ON m.id_plan = p.id_plan "
        + "WHERE s.estado = 1 " 
        + "AND m.fecha_fin >= CURDATE() "
        + "AND m.fecha_fin = (SELECT MAX(m2.fecha_fin) FROM membresia m2 WHERE m2.id_socio = m.id_socio) "
        + "ORDER BY m.fecha_fin ASC";

    try (Connection conn = Conexion.getConnection();
         PreparedStatement pstmt = conn.prepareStatement(consulta);
         ResultSet rs = pstmt.executeQuery()) {

        while (rs.next()) {
            Membresia membresia = new Membresia();
            membresia.setId(rs.getInt("id_membresia"));
            membresia.setIdSocio(rs.getInt("id_socio"));
            membresia.setIdPlan(rs.getInt("id_plan"));
            membresia.setFechaInicio(rs.getDate("fecha_inicio").toLocalDate());
            membresia.setFechaFin(rs.getDate("fecha_fin").toLocalDate());
            membresia.setValorPagado(rs.getBigDecimal("valor_pagado"));

            Socio socio = new Socio();
            socio.setId(rs.getInt("id_socio"));
            socio.setNombre(rs.getString("nombres"));
            socio.setApellido(rs.getString("apellidos"));
            socio.setDocumento(rs.getString("documento"));
            socio.setTelefono(rs.getString("telefono"));
            socio.setCorreo(rs.getString("correo"));
            membresia.setSocio(socio);

            Plan plan = new Plan();
            plan.setId(rs.getInt("id_plan"));
            plan.setNombre(rs.getString("nombre_plan"));
            membresia.setPlan(plan);

            lista.add(membresia);
        }

    } catch (SQLException e) {
        e.printStackTrace();
    }
    return lista;
}
    public List<Membresia> MtRecaudacionPorRangoFechas(LocalDate fechaInicio, LocalDate fechaFin) {
    List<Membresia> lista = new ArrayList<>();

    String consulta = "SELECT p.id_plan, p.nombre AS nombre_plan, "
            + "COUNT(m.id_membresia) AS total_ventas, "
            + "SUM(m.valor_pagado) AS total_recaudado "
            + "FROM membresia m "
            + "INNER JOIN plan p ON m.id_plan = p.id_plan "
            + "WHERE m.fecha_inicio BETWEEN ? AND ? "
            + "GROUP BY p.id_plan, p.nombre "
            + "ORDER BY total_recaudado DESC";

    try (Connection conn = Conexion.getConnection(); 
         PreparedStatement pstmt = conn.prepareStatement(consulta)) {

        pstmt.setDate(1, Date.valueOf(fechaInicio));
        pstmt.setDate(2, Date.valueOf(fechaFin));

        try (ResultSet rs = pstmt.executeQuery()) {
            while (rs.next()) {
                Membresia membresia = new Membresia();
                           
                membresia.setValorPagado(rs.getBigDecimal("total_recaudado"));
 
                Plan plan = new Plan();
                plan.setId(rs.getInt("id_plan"));
                plan.setNombre(rs.getString("nombre_plan"));
                
                membresia.setPlan(plan);
                
                lista.add(membresia);
            }
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return lista;
}
}
