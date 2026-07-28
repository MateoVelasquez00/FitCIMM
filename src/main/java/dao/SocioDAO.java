package dao;

import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import model.Socio;

public class SocioDAO {

    public List<Socio> MtListarSocio() {
        List<Socio> lista = new ArrayList<>();

        String consulta = "SELECT * FROM socio "
                + "ORDER BY apellidos, nombres";

        try (Connection conn = Conexion.getConnection()) {
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery(consulta);

            while (rs.next()) {
                Socio socio = new Socio();
                socio.setId(rs.getInt("id_socio"));
                socio.setDocumento(rs.getString("documento"));
                socio.setNombre(rs.getString("nombres"));
                socio.setApellido(rs.getString("apellidos"));
                socio.setTelefono(rs.getString("telefono"));
                socio.setCorreo(rs.getString("correo"));
                socio.setFechaNacimiento(rs.getDate("fecha_nacimiento").toLocalDate());
                socio.setEstado(rs.getBoolean("estado"));
                lista.add(socio);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }

    public boolean MtInsertarSocio(Socio socio) {
        String consulta = "INSERT INTO socio (documento, nombres, apellidos, telefono, correo, fecha_nacimiento, estado)"
                + "VALUES (?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = Conexion.getConnection(); PreparedStatement pstmt = conn.prepareStatement(consulta)) {

            pstmt.setString(1, socio.getDocumento());
            pstmt.setString(2, socio.getNombre());
            pstmt.setString(3, socio.getApellido());
            pstmt.setString(4, socio.getTelefono());
            pstmt.setString(5, socio.getCorreo());
            pstmt.setDate(6, Date.valueOf(socio.getFechaNacimiento()));
            pstmt.setBoolean(7, socio.isEstado());

            int filasAfectadas = pstmt.executeUpdate();
            return filasAfectadas > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean MtActualizaSocio(Socio socio) {
        String consulta = "UPDATE socio SET "
                + "documento = ?, "
                + "nombres = ?, "
                + "apellidos = ?, "
                + "telefono = ?, "
                + "correo = ?, "
                + "fecha_nacimiento = ?, "
                + "estado = ? "
                + "WHERE id_socio = ?";

        try (Connection conn = Conexion.getConnection(); PreparedStatement pstmt = conn.prepareStatement(consulta)) {

            pstmt.setString(1, socio.getDocumento());
            pstmt.setString(2, socio.getNombre());
            pstmt.setString(3, socio.getApellido());
            pstmt.setString(4, socio.getTelefono());
            pstmt.setString(5, socio.getCorreo());
            pstmt.setDate(6, Date.valueOf(socio.getFechaNacimiento()));
            pstmt.setBoolean(7, socio.isEstado());
            pstmt.setInt(8, socio.getId());

            int filasAfectadas = pstmt.executeUpdate();
            return filasAfectadas > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<Socio> MtBuscarSocio(String criterio) {
        List<Socio> lista = new ArrayList<>();
        String consulta = "SELECT * FROM socio "
                + "WHERE documento LIKE ? OR apellidos LIKE ? "
                + "ORDER BY documento, apellidos";

        try (Connection conn = Conexion.getConnection(); PreparedStatement pstmt = conn.prepareStatement(consulta)) {

            String parametro = "%" + criterio + "%";
            pstmt.setString(1, parametro);
            pstmt.setString(2, parametro);

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    Socio socio = new Socio();
                    socio.setId(rs.getInt("id_socio"));
                    socio.setDocumento(rs.getString("documento"));
                    socio.setNombre(rs.getString("nombres"));
                    socio.setApellido(rs.getString("apellidos"));
                    socio.setTelefono(rs.getString("telefono"));
                    socio.setCorreo(rs.getString("correo"));
                    socio.setFechaNacimiento(rs.getDate("fecha_nacimiento").toLocalDate());
                    socio.setEstado(rs.getBoolean("estado"));
                    lista.add(socio);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }

    public Socio MtDetalleSocio(int membresiaId) {
        Socio socio = null;

        String consulta = "SELECT s.*, m.fecha_inicio,m.fecha_fin, valor_pagado FROM socio s"
                + "INNER JOIN membresia m ON m.id_socio = s.id_socio"
                + "WHERE s.id = ?";

        try (Connection conn = Conexion.getConnection(); PreparedStatement pstmt = conn.prepareStatement(consulta)) {
            pstmt.setInt(1, membresiaId);

            try (ResultSet rs = pstmt.executeQuery()) {

                if (rs.next()) {
                    socio = new Socio();
                    socio.setId(rs.getInt("id_socio"));
                    socio.setDocumento(rs.getString("documento"));
                    socio.setNombre(rs.getString("nombres"));
                    socio.setApellido(rs.getString("apellidos"));
                    socio.setTelefono(rs.getString("telefono"));
                    socio.setCorreo(rs.getString("correo"));
                    socio.setFechaNacimiento(rs.getDate("fecha_nacimiento").toLocalDate());
                    socio.setEstado(rs.getBoolean("estado"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return socio;
    }

    public boolean MtEstadoSocio(int idSocio, boolean nuevoEstado) {

        String consulta = "UPDATE socio SET estado = ? WHERE id_socio = ?";

        try (Connection conn = Conexion.getConnection(); PreparedStatement pstmt = conn.prepareStatement(consulta)) {

            pstmt.setBoolean(1, nuevoEstado);
            pstmt.setInt(2, idSocio);

            int filasAfectadas = pstmt.executeUpdate();
            return filasAfectadas > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public Socio MtBuscarPorDocumento(String documento) {
        Socio socio = null;
        String consulta = "SELECT * FROM socio WHERE documento = ?";

        try (Connection conn = Conexion.getConnection(); PreparedStatement pstmt = conn.prepareStatement(consulta)) {

            pstmt.setString(1, documento);

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    socio = new Socio();
                    socio.setId(rs.getInt("id_socio"));
                    socio.setDocumento(rs.getString("documento"));
                    socio.setNombre(rs.getString("nombres"));
                    socio.setApellido(rs.getString("apellidos"));
                    socio.setTelefono(rs.getString("telefono"));
                    socio.setCorreo(rs.getString("correo"));
                    socio.setFechaNacimiento(rs.getDate("fecha_nacimiento").toLocalDate());
                    socio.setEstado(rs.getBoolean("estado"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return socio;
    }

    public Socio MtObtenerPorId(int idSocio) {
        Socio socio = null;
        String consulta = "SELECT * FROM socio WHERE id_socio = ?";

        try (Connection conn = Conexion.getConnection(); PreparedStatement pstmt = conn.prepareStatement(consulta)) {

            pstmt.setInt(1, idSocio);

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    socio = new Socio();
                    socio.setId(rs.getInt("id_socio"));
                    socio.setDocumento(rs.getString("documento"));
                    socio.setNombre(rs.getString("nombres"));
                    socio.setApellido(rs.getString("apellidos"));
                    socio.setTelefono(rs.getString("telefono"));
                    socio.setCorreo(rs.getString("correo"));
                    socio.setFechaNacimiento(rs.getDate("fecha_nacimiento").toLocalDate());
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return socio;
    }
}
