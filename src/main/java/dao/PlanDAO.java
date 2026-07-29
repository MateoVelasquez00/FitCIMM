package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import model.Plan;

public class PlanDAO {

    public boolean MtInsertarPlan(Plan plan) {

        String consulta = "INSERT INTO plan (nombre, duracion_dias, valor, estado) "
                + "VALUES (?, ?, ?, ?)";

        try (Connection conn = Conexion.getConnection(); PreparedStatement pstmt = conn.prepareStatement(consulta)) {

            pstmt.setString(1, plan.getNombre());
            pstmt.setInt(2, plan.getDuracionDias());
            pstmt.setBigDecimal(3, plan.getValor());
            pstmt.setBoolean(4, plan.isEstado());

            int filasAfectadas = pstmt.executeUpdate();
            return filasAfectadas > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<Plan> MtListarPlanes() {
        List<Plan> lista = new ArrayList<>();
        String consulta = "SELECT * FROM plan "
                + "ORDER BY nombre";

        try (Connection conn = Conexion.getConnection(); Statement stmt = conn.createStatement(); ResultSet rs = stmt.executeQuery(consulta)) {

            while (rs.next()) {
                Plan plan = new Plan();
                plan.setId(rs.getInt("id_plan"));
                plan.setNombre(rs.getString("nombre"));
                plan.setDuracionDias(rs.getInt("duracion_dias"));
                plan.setValor(rs.getBigDecimal("valor"));
                plan.setEstado(rs.getBoolean("estado"));
                lista.add(plan);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }

    public boolean MtActualizarPlan(Plan plan) {
        String consulta = "UPDATE plan SET nombre = ?, duracion_dias = ?, valor = ?, estado = ? "
                + "WHERE id_plan = ?";

        try (Connection conn = Conexion.getConnection(); PreparedStatement pstmt = conn.prepareStatement(consulta)) {

            pstmt.setString(1, plan.getNombre());
            pstmt.setInt(2, plan.getDuracionDias());
            pstmt.setBigDecimal(3, plan.getValor());
            pstmt.setBoolean(4, plan.isEstado());
            pstmt.setInt(5, plan.getId());

            int filasAfectadas = pstmt.executeUpdate();
            return filasAfectadas > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean MtEstadoPlan(int idPlan, boolean nuevoEstado) {

        String consulta = "UPDATE plan SET estado = ? WHERE id_plan = ?";

        try (Connection conn = Conexion.getConnection(); PreparedStatement pstmt = conn.prepareStatement(consulta)) {

            pstmt.setBoolean(1, nuevoEstado);
            pstmt.setInt(2, idPlan);

            int filasAfectadas = pstmt.executeUpdate();
            return filasAfectadas > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public Plan MtObtenerPorId(int id) {
        Plan plan = null;

        String consulta = "SELECT * FROM plan WHERE id_plan = ?";

        try (Connection conn = Conexion.getConnection(); PreparedStatement pstmt = conn.prepareStatement(consulta)) {
            pstmt.setInt(1, id);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                plan = new Plan();
                plan.setId(rs.getInt("id_plan"));
                plan.setNombre(rs.getString("nombre"));
                plan.setDuracionDias(rs.getInt("duracion_dias"));
                plan.setValor(rs.getBigDecimal("valor"));
                plan.setEstado(rs.getBoolean("estado"));
            }
        } catch (SQLException e){
            e.printStackTrace();
        }
        return plan;
    }
    
    public boolean MtTieneMembresiasAsociadas(int idPlan){
        String consulta = "SELECT COUNT(*) FROM membresia WHERE id_plan = ?";
        
        try (Connection conn = Conexion.getConnection();
                PreparedStatement pstmt = conn.prepareStatement(consulta)) {
            pstmt.setInt(1, idPlan);
            try (ResultSet rs = pstmt.executeQuery()){
                if(rs.next()){
                    return rs.getInt(1) > 0;
                }
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
public Plan MtPlanMasVendidoDelMes(LocalDate fechaInicio, LocalDate fechaFin) {
    Plan plan = null;

    String consulta = "SELECT p.id_plan, p.nombre, p.duracion_dias, p.valor, p.estado, "
            + "COUNT(m.id_membresia) AS total_ventas "
            + "FROM membresia m "
            + "INNER JOIN plan p ON m.id_plan = p.id_plan "
            + "WHERE m.fecha_inicio BETWEEN ? AND ? "
            + "GROUP BY p.id_plan, p.nombre, p.duracion_dias, p.valor, p.estado "
            + "ORDER BY total_ventas DESC "
            + "LIMIT 1";

    try (Connection conn = Conexion.getConnection();
         PreparedStatement pstmt = conn.prepareStatement(consulta)) {

        pstmt.setDate(1, java.sql.Date.valueOf(fechaInicio));
        pstmt.setDate(2, java.sql.Date.valueOf(fechaFin));

        try (ResultSet rs = pstmt.executeQuery()) {
            if (rs.next()) {
                plan = new Plan();
                plan.setId(rs.getInt("id_plan"));
                plan.setNombre(rs.getString("nombre"));
                plan.setDuracionDias(rs.getInt("duracion_dias"));
                plan.setValor(rs.getBigDecimal("valor"));
                plan.setEstado(rs.getBoolean("estado"));
            }
        }

    } catch (SQLException e) {
        e.printStackTrace();
    }
    return plan;
}
}
                                                                                                                                                    