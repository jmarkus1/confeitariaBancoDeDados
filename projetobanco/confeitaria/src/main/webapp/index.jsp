<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%-- Importamos a classe Produto e a lista para o JSP conseguir ler os dados --%>
<%@ page import="br.edu.ifpb.confeitaria.model.Produto, java.util.List" %>
<html>
<head>
    <title>Ray Doces - Sistema</title>
    <style>
        /* Estilos */
        body { font-family: sans-serif; margin: 20px; background-color: #fff5f8; }
        table { border-collapse: collapse; width: 100%; margin-top: 20px; background-color: white; }
        th, td { border: 1px solid #ddd; padding: 12px; text-align: left; }
        th { background-color: #ffc1d6; color: #333; }
        form { background: #fff; padding: 20px; border-radius: 8px; box-shadow: 0 2px 5px rgba(0,0,0,0.1); }
        input, button { padding: 10px; margin: 5px; border-radius: 4px; border: 1px solid #ddd; }
        button { background-color: #ff4d88; color: white; border: none; cursor: pointer; }
        button:hover { background-color: #e6005c; }
    </style>
</head>
<body>
    <h1> Ray Doces - Cadastro de Produtos</h1>
    
    //Formulário que envia os dados para a rota "/produtos" usando o método POST
    <form action="produtos" method="post">
        <input type="text" name="nome" placeholder="Nome do Doce" required>
        <input type="text" name="descricao" placeholder="Descrição">
        <input type="number" step="0.01" name="preco" placeholder="Preço" required>
        <button type="submit">Cadastrar</button>
    </form>

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
                //Esse bloco Java pega a lista que o Servlet tinha enviado
                List<Produto> lista = (List<Produto>) request.getAttribute("listaProdutos");
                
                //Se a lista existir e não tiver vazia ele vai desenhar as linhas da tabela
                if (lista != null && !lista.isEmpty()) {
                    for (Produto p : lista) {
            %>
                <tr>
                    //O '=' vai servir pra imprimir o valor direto na tabela
                    <td><%= p.getId() %></td>
                    <td><%= p.getNome() %></td>
                    <td><%= p.getDescricao() %></td>
                    <td>R$ <%= String.format("%.2f", p.getPreco()) %></td>
                </tr>
            <% 
                    }
                } else { 
            %>
                // se não tiver nada no banco vai mostrar essa mensagem
                <tr>
                    <td colspan="4" style="text-align:center;">Nenhum doce cadastrado ainda.</td>
                </tr>
            <% } %>
        </tbody>
    </table>
</body>
</html>