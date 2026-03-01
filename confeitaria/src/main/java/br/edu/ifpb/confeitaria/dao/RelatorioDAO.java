package br.edu.ifpb.confeitaria.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class RelatorioDAO {

    //relatório de pedidos por cliente vai ter o INNER JOIN em 3 tabelas e o WHERE)
    public List<Map<String, Object>> listarPedidosPorCliente(String nomeCliente) {
        List<Map<String, Object>> lista = new ArrayList<>();
        // aqui cruza as tabelas cliente, Pedido e Produto para saber quem comprou cada coisa.
        String sql = "SELECT c.nome as cliente, p.data_hora_pedido as data, pr.nome as produto " +
                     "FROM cliente c " +
                     "INNER JOIN pedido p ON c.id = p.id_cliente " +
                     "INNER JOIN item_pedido ip ON p.id = ip.id_pedido " +
                     "INNER JOIN produtos pr ON ip.id_produto = pr.id " +
                     "WHERE c.nome LIKE ?"; 
        
        try (Connection conn = ConnectionFactory.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, "%" + nomeCliente + "%"); // O % permite buscar partes do nome
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Map<String, Object> linha = new HashMap<>();
                linha.put("cliente", rs.getString("cliente"));
                linha.put("data", rs.getTimestamp("data"));
                linha.put("produto", rs.getString("produto"));
                lista.add(linha);
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return lista;
    }

    //Ranking de Vendas GROUP BY e ORDER BY
    public List<Map<String, Object>> obterRankingVendas() {
        List<Map<String, Object>> lista = new ArrayList<>();
        String sql = "SELECT pr.nome, SUM(ip.quantidade) AS total FROM produtos pr " +
                     "INNER JOIN item_pedido ip ON pr.id = ip.id_produto " +
                     "GROUP BY pr.nome ORDER BY total DESC";
        
        try (Connection conn = ConnectionFactory.getConnection();
             Statement st = conn.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) {
                Map<String, Object> linha = new HashMap<>();
                linha.put("produto", rs.getString("nome"));
                linha.put("total", rs.getInt("total"));
                lista.add(linha);
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return lista;
    }

    // Inredientes por Fornecedor JOIN Simples entre as duas tabelas
    public List<Map<String, Object>> listarIngredientesPorFornecedor() {
        List<Map<String, Object>> lista = new ArrayList<>();
        String sql = "SELECT f.razão_social, i.nome AS ingrediente FROM fornecedor f " +
                     "INNER JOIN ingrediente i ON f.id = i.id_fornecedor";
        
        try (Connection conn = ConnectionFactory.getConnection();
             Statement st = conn.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) {
                Map<String, Object> linha = new HashMap<>();
                linha.put("fornecedor", rs.getString("razão_social"));
                linha.put("ingrediente", rs.getString("ingrediente"));
                lista.add(linha);
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return lista;
    }

    //Quantidade de pedidos função COUNT e GROUP BY
    public List<Map<String, Object>> totalPedidosPorCliente() {
        List<Map<String, Object>> lista = new ArrayList<>();
        String sql = "SELECT c.nome, COUNT(p.id) AS qtd FROM cliente c " +
                     "INNER JOIN pedido p ON c.id = p.id_cliente GROUP BY c.nome";
        
        try (Connection conn = ConnectionFactory.getConnection();
             Statement st = conn.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) {
                Map<String, Object> linha = new HashMap<>();
                linha.put("cliente", rs.getString("nome"));
                linha.put("quantidade", rs.getInt("qtd"));
                lista.add(linha);
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return lista;
    }

    //Lista Geral de Estoque LEFT JOIN
    public List<Map<String, Object>> listarTodosIngredientesEFornecedores() {
        List<Map<String, Object>> lista = new ArrayList<>();
        String sql = "SELECT i.nome, f.razão_social FROM ingrediente i LEFT JOIN fornecedor f ON i.id_fornecedor = f.id";
        
        try (Connection conn = ConnectionFactory.getConnection();
             Statement st = conn.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) {
                Map<String, Object> linha = new HashMap<>();
                linha.put("ingrediente", rs.getString("nome"));
                linha.put("fornecedor", rs.getString("razão_social"));
                lista.add(linha);
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return lista;
    }

    //pedidos VIP SUBCONSULTA com AVG
    public List<Map<String, Object>> listarPedidosAcimaMedia() {
        List<Map<String, Object>> lista = new ArrayList<>();
        String sql = "SELECT id, valor_total FROM pedido WHERE valor_total > (SELECT AVG(valor_total) FROM pedido)";
        
        try (Connection conn = ConnectionFactory.getConnection();
             Statement st = conn.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) {
                Map<String, Object> linha = new HashMap<>();
                linha.put("id_pedido", rs.getInt("id"));
                linha.put("valor", rs.getDouble("valor_total"));
                lista.add(linha);
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return lista;
    }
}