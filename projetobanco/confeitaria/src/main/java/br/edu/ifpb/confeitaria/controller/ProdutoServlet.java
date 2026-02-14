package br.edu.ifpb.confeitaria.controller;

import java.io.IOException;
import java.sql.SQLException;

import br.edu.ifpb.confeitaria.dao.ProdutoDAO;
import br.edu.ifpb.confeitaria.model.Produto;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

//esse endereço é o que a gente usa no navegador para acessar o sistema
@WebServlet("/produtos")
public class ProdutoServlet extends HttpServlet {
    private ProdutoDAO dao = new ProdutoDAO();

    //doPost roda quando você clica no botão de cadastrar
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        //lê o que o usuário escreveu nas caixinhas do site
        String nome = request.getParameter("nome");
        String descricao = request.getParameter("descricao");
        double preco = Double.parseDouble(request.getParameter("preco"));

        //Cria um objeto novo com esses dados
        Produto novoProduto = new Produto(0, nome, descricao, preco);

        //pede pro dao salvar esse objeto lá no Postgres
        try {
            dao.salvar(novoProduto);
        } catch (SQLException e) {
            e.printStackTrace();
        }

        //depois que salva ele chama o método para atualizar a lista na tela
        doGet(request, response);
    }

    //o doGet roda quando você abre a página ou quando a lista precisa ser atualizada
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            //aqui pede para o dao buscar todos os doces no banco
            request.setAttribute("listaProdutos", dao.listarTodos());
            
            //faz o navegador abrir o index mostrando os dados da lista
            request.getRequestDispatcher("index.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
