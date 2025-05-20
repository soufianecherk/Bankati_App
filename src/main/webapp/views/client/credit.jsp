<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Mes Demandes de Crédit</title>
    <style>
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th, td { border: 1px solid #ccc; padding: 8px; text-align: center; }
        th { background-color: #f2f2f2; }
        .btn { padding: 6px 12px; background-color: #007bff; color: white; border: none; cursor: pointer; }
        .btn-danger { background-color: #dc3545; }
    </style>
</head>
<body>
<h2>Mes Demandes de Crédit</h2>

<!-- Formulaire d'ajout -->
<form action="credit" method="post">
    <input type="hidden" name="action" value="ajouter" />
    <label>Montant :</label>
    <input type="number" name="montant" step="0.01" required />
    <button type="submit" class="btn">Ajouter</button>
</form>

<!-- Liste des demandes -->
<table>
    <thead>
    <tr>
        <th>ID</th>
        <th>Montant</th>
        <th>Date</th>
        <th>État</th>
        <th>Action</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach var="demande" items="${demandes}">
        <tr>
            <td>${demande.id}</td>
            <td>${demande.montant}</td>
            <td>${demande.dateDemande}</td>
            <td>${demande.etat}</td>
            <td>
                <c:if test="${demande.etat == 'EN_ATTENTE'}">
                    <form action="credit" method="post" style="display:inline;">
                        <input type="hidden" name="action" value="supprimer"/>
                        <input type="hidden" name="id" value="${demande.id}"/>
                        <button type="submit" class="btn btn-danger">Supprimer</button>
                    </form>
                </c:if>
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>
</body>
</html>
