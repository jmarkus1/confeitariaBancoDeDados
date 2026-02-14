package br.edu.ifpb.confeitaria.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import br.edu.ifpb.confeitaria.model.Produto;

public class ProdutoDAO {

    //inseri doce novo na tabela
    public void salvar(Produto produto) throws SQLException {
        // Comando sql para colocar os dados a interrogacao serve pra evitar problemas com os digitos
        String sql = "INSERT INTO produtos (nome, descricao, preco) VALUES (?, ?, ?)";
        
        //abre a conexão e prepara o comando
        try (Connection conn = ConnectionFactory.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            //aqui substitui a interrogacão pelos dados do formulário
            stmt.setString(1, produto.getNome());
            stmt.setString(2, produto.getDescricao());
            stmt.setDouble(3, produto.getPreco());
            
            //Executa o comando no banco
            stmt.executeUpdate();
        }
    }

    // metodo que busca os doces cadastrados para mostrar na lista
    public List<Produto> listarTodos() throws SQLException {
        List<Produto> produtos = new ArrayList<>();
        String sql = "SELECT * FROM produtos";

        try (Connection conn = ConnectionFactory.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) { //esse ResultSet guarda o que o banco mandou de volta

            // Enquanto tiver linha no banco cria um objeto e coloca na lista
            while (rs.next()) {
                Produto p = new Produto();
                p.setId(rs.getInt("id"));
                p.setNome(rs.getString("nome"));
                p.setDescricao(rs.getString("descricao"));
                p.setPreco(rs.getDouble("preco"));
                produtos.add(p);
            }
        }
        return produtos; //devolve a lista pronta para o Servlet
    }

    //apaga um doce usando o número do ID dele
    public void excluir(int id) throws SQLException {
        String sql = "DELETE FROM produtos WHERE id = ?";
        try (Connection conn = ConnectionFactory.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, id); // Define o ID pra apagar
            stmt.executeUpdate(); //exclui
        }
    }
}