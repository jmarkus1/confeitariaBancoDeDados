package br.edu.ifpb.confeitaria.controller;

import java.io.IOException;

import br.edu.ifpb.confeitaria.dao.RelatorioDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/central-relatorios")
public class RelatoriosServlet extends HttpServlet {
    private RelatorioDAO dao = new RelatorioDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Pega qual relatório o usuário clicou
        String tipo = request.getParameter("tipo");

        if ("ranking".equals(tipo)) {
            request.setAttribute("dados", dao.obterRankingVendas());
            request.setAttribute("titulo", " Ranking de Vendas por Produto");
            request.getRequestDispatcher("relatorio_geral.jsp").forward(request, response);
        } 
        else if ("fornecedores".equals(tipo)) {
            request.setAttribute("dados", dao.listarIngredientesPorFornecedor());
            request.setAttribute("titulo", " Ingredientes por Fornecedor");
            request.getRequestDispatcher("relatorio_geral.jsp").forward(request, response);
        }
        else if ("clientes_top".equals(tipo)) {
            request.setAttribute("dados", dao.totalPedidosPorCliente());
            request.setAttribute("titulo", " Total de Pedidos por Cliente");
            request.getRequestDispatcher("relatorio_geral.jsp").forward(request, response);
        }
        else if ("estoque_total".equals(tipo)) {
            request.setAttribute("dados", dao.listarTodosIngredientesEFornecedores());
            request.setAttribute("titulo", " Listagem Geral de Estoque (Left Join)");
            request.getRequestDispatcher("relatorio_geral.jsp").forward(request, response);
        }
        else if ("acima_media".equals(tipo)) {
            request.setAttribute("dados", dao.listarPedidosAcimaMedia());
            request.setAttribute("titulo", " Pedidos Acima da Média de Valor");
            request.getRequestDispatcher("relatorio_geral.jsp").forward(request, response);
        }
    }
}