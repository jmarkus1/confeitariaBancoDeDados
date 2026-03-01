<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<html>
<head>
    <title>Ray Doces - Relatórios</title>
    <style>
        body { font-family: sans-serif; background: #fff5f8; padding: 20px; }
        table { width: 100%; border-collapse: collapse; background: white; }
        th, td { border: 1px solid #ddd; padding: 10px; }
        th { background: #ff4d88; color: white; }
        .voltar { display: inline-block; margin-top: 20px; text-decoration: none; color: #ff4d88; font-weight: bold; }
    </style>
</head>
<body>
    <h1>${titulo}</h1>

    <table>
        <thead>
            <tr>
                <c:forEach var="coluna" items="${dados[0].keySet()}">
                    <th>${coluna.toUpperCase()}</th>
                </c:forEach>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="linha" items="${dados}">
                <tr>
                    <c:forEach var="valor" items="${linha.values()}">
                        <td>${valor}</td>
                    </c:forEach>
                </tr>
            </c:forEach>
        </tbody>
    </table>

    <a href="index.jsp" class="voltar">⬅ Voltar ao Início</a>
</body>
</html>