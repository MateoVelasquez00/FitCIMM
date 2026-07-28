package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Conexion {
    
    private static final  String URL = "jdbc:mysql://localhost:3307/fitcimm?useSSL=false&serverTimezone=America/Bogota";
    private static final String USER = "root";
    private static final String PASSWORD = "";
    private static final String DRIVER = "com.mysql.cj.jdbc.Driver";
    
    
    public static Connection getConnection(){
        Connection connection = null;
        try {
           Class.forName(DRIVER);
           
           connection = DriverManager.getConnection(URL, USER, PASSWORD);
        } catch (ClassNotFoundException e){
            System.err.println("Error: No se encontro el drive de MYSQL");
            e.printStackTrace();
        } catch (SQLException e){
            System.err.println("Error: No se pudo conectar con la base de datos");
            e.printStackTrace();
        }
        return connection;
    } 
    
    public static void closeConnection(Connection connection){
        if(connection != null) {
            try {
                connection.close();
            }catch (SQLException e) {
                System.err.println("Error al cerrar la conexion");
                e.printStackTrace();
            }
        }
    }
    
    public static boolean testConnection(){
        Connection conn = getConnection();
        boolean isConnected = (conn != null);
        closeConnection(conn);
        return isConnected;
    }
}
