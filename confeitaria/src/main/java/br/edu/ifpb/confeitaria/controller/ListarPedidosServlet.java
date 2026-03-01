package br.edu.ifpb.confeitaria.controller;

import java.io.IOException;

import br.edu.ifpb.confeitaria.dao.RelatorioDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/listar-pedidos")
public class ListarPedidosServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        RelatorioDAO dao = new RelatorioDAO();

        request.setAttribute("pedidos", dao.listarPedidosPorCliente(""));
        
        request.getRequestDispatcher("/pedidos_cliente.jsp").forward(request, response);
    }
}
