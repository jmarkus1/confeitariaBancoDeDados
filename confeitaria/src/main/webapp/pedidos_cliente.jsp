<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Relatório de Pedidos por Cliente - Ray Doces</title>
    <style>
        table { width: 80%; border-collapse: collapse; margin: 20px 0; }
        th, td { border: 1px solid #ddd; padding: 12px; text-align: left; }
        th { background-color: #f2f2f2; color: #333; }
        tr:nth-child(even) { background-color: #f9f9f9; }
        h2 { color: #d2691e; }
    </style>
</head>
<body>

    <h2> Relatório: Pedidos Realizados por Cliente</h2>
    <p>Esta consulta utiliza <b>INNER JOIN</b> em 3 tabelas (Cliente, Pedido e Produto).</p>

    <table>
        <thead>
            <tr>
                <th>Nome do Cliente</th>
                <th>Data e Hora do Pedido</th>
                <th>Produto Comprado</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="p" items="${pedidos}">
                <tr>
                    <td>${p.cliente}</td>
                    <td>
                        ${p.data}
                    </td>
                    <td>${p.produto}</td>
                </tr>
            </c:forEach>
        </tbody>
    </table>

    <br>
    <a href="index.jsp">Voltar ao Início</a>

</body>
</html>