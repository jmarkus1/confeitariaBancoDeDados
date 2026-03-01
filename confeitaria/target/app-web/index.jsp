<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="br.edu.ifpb.confeitaria.model.Produto, java.util.List" %>
<html>
<head>
    <title>Ray Doces - Sistema</title>
    <style>
        body { font-family: sans-serif; margin: 20px; background-color: #fff5f8; }
        table { border-collapse: collapse; width: 100%; margin-top: 20px; background-color: white; }
        th, td { border: 1px solid #ddd; padding: 12px; text-align: left; }
        th { background-color: #ffc1d6; color: #333; }
        form { background: #fff; padding: 20px; border-radius: 8px; box-shadow: 0 2px 5px rgba(0,0,0,0.1); }
        input, button { padding: 10px; margin: 5px; border-radius: 4px; border: 1px solid #ddd; }
        button { background-color: #ff4d88; color: white; border: none; cursor: pointer; }
        button:hover { background-color: #e6005c; }
        .painel-relatorios { background: #fff; padding: 15px; border-radius: 8px; border-left: 5px solid #ff4d88; margin: 20px 0; }
        .painel-relatorios h3 { margin-top: 0; color: #ff4d88; }
        .painel-relatorios ul { list-style: none; padding: 0; }
        .painel-relatorios li { margin: 8px 0; }
        .painel-relatorios a { text-decoration: none; color: #333; font-weight: bold; }
        .painel-relatorios a:hover { color: #ff4d88; text-decoration: underline; }
    </style>
</head>
<body>
    <h1> Ray Doces - Cadastro de Produtos</h1>
    
    <%-- Formulário de Cadastro (Parte 1) --%>
    <form action="produtos" method="post">
        <input type="text" name="nome" placeholder="Nome do Doce" required>
        <input type="text" name="descricao" placeholder="Descrição">
        <input type="number" step="0.01" name="preco" placeholder="Preço" required>
        <button type="submit">Cadastrar</button>
    </form>

    <%-- PAINEL DE RELATÓRIOS (ATVIDADE 2) --%>
    <div class="painel-relatorios">
        <h3> Painel de Relatórios Profissionais</h3>
        <ul>
            <li><a href="listar-pedidos"> 1. Pedidos por Cliente (INNER JOIN 3 Tabelas)</a></li>
            <li><a href="central-relatorios?tipo=fornecedores"> 2. Ingredientes por Fornecedor (Filtro WHERE)</a></li>
            <li><a href="central-relatorios?tipo=ranking"> 3. Ranking de Vendas (Agrupamento GROUP BY)</a></li>
            <li><a href="central-relatorios?tipo=clientes_top"> 4. Clientes que mais Compram (Função COUNT)</a></li>
            <li><a href="central-relatorios?tipo=estoque_total"> 5. Listagem Geral de Estoque (LEFT JOIN)</a></li>
            <li><a href="central-relatorios?tipo=acima_media"> 6. Pedidos Acima da Média (Subconsulta)</a></li>
        </ul>
    </div>

    <hr>

    <h2>Lista de Doces</h2>
    <table>
        <thead>
            <tr>
                <th>ID</th>
                <th>Nome</th>
                <th>Descrição</th>
                <th>Preço</th>
            </tr>
        </thead>
        <tbody>
            <% 
                List<Produto> lista = (List<Produto>) request.getAttribute("listaProdutos");
                if (lista != null && !lista.isEmpty()) {
                    for (Produto p : lista) {
            %>
                <tr>
                    <td><%= p.getId() %></td>
                    <td><%= p.getNome() %></td>
                    <td><%= p.getDescricao() %></td>
                    <td>R$ <%= String.format("%.2f", p.getPreco()) %></td>
                </tr>
            <% 
                    }
                } else { 
            %>
                <tr>
                    <td colspan="4" style="text-align:center;">Nenhum doce cadastrado ainda. Clique em cadastrar ou verifique o banco.</td>
                </tr>
            <% } %>
        </tbody>
    </table>
</body>
</html>