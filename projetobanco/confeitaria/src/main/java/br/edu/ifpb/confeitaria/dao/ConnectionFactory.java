package br.edu.ifpb.confeitaria.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConnectionFactory {
    
    //aqui eu defino onde o banco tá, o usuário e a senha do pgAdmin
    private static final String URL = "jdbc:postgresql://localhost:5432/confeitaria_db";
    private static final String USER = "postgres";
    private static final String PASS = "1234"; 

    //método que as outras classes chama para abrir o banco
    public static Connection getConnection() throws SQLException {
        try {
            //avisa ao Java que vamos usar o driver do PostgreSQL
            Class.forName("org.postgresql.Driver");
            
            //aqui ele tenta conectar usando as informações lá de cima
            return DriverManager.getConnection(URL, USER, PASS);
            
        } catch (ClassNotFoundException e) {
            // Se der erro de driver, ele avisa aqui
            throw new SQLException("Driver do PostgreSQL não encontrado!", e);
        }
    }
}

