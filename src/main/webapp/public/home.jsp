<%@ page contentType="text/html;charset=UTF-8" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    var ctx = request.getContextPath();
    var connectedUser = (ma.bankati.model.users.User) session.getAttribute("connectedUser");
%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Accueil | Bankati</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background-color: #f5f7fa;
        }

        .navbar {
            background: linear-gradient(135deg, #4361ee, #3f37c9);
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }

        .welcome-box {
            margin-top: 80px;
            background: white;
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.05);
        }

        .logo-text {
            font-weight: 700;
            letter-spacing: 0.5px;
        }
    </style>
</head>
<body>

<nav class="navbar navbar-expand-lg navbar-dark sticky-top">
    <div class="container">
        <a class="navbar-brand d-flex align-items-center" href="<%= ctx %>/home">
            <img src="<%= ctx %>/assets/img/logoBlue.png" alt="Logo" width="35" class="me-2">
            <span class="logo-text">Bankati</span>
        </a>

        <div class="d-flex align-items-center">
            <ul class="navbar-nav me-3">
                <li class="nav-item">
                    <a class="nav-link" href="<%= ctx %>/credit">
                        <i class="bi bi-bank2 me-1"></i> Mes crédits
                    </a>
                </li>
            </ul>
            <div class="dropdown">
                <button class="btn btn-outline-light dropdown-toggle" id="userDropdown" data-bs-toggle="dropdown">
                    <i class="bi bi-person-circle me-2"></i>
                    <span class="d-none d-md-inline">
                        <%= connectedUser.getFirstName() + " " + connectedUser.getLastName() %>
                    </span>
                </button>
                <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="userDropdown">
                    <li><span class="dropdown-item-text fw-bold"><%= connectedUser.getRole() %></span></li>
                    <li><hr class="dropdown-divider"></li>
                    <li><a class="dropdown-item" href="#"><i class="bi bi-person me-2"></i>Mon profil</a></li>
                    <li><a class="dropdown-item" href="<%= ctx %>/logout"><i class="bi bi-box-arrow-right me-2"></i>Déconnexion</a></li>
                </ul>
            </div>
        </div>
    </div>
</nav>

<div class="container">
    <div class="row justify-content-center">
        <div class="col-lg-8">
            <div class="welcome-box text-center">
                <h1 class="fw-bold mb-3">Bienvenue, <%= connectedUser.getFirstName() %> 👋</h1>
                <p class="lead">Nous sommes heureux de vous revoir sur votre espace personnel Bankati.</p>
                <a href="<%= ctx %>/credit" class="btn btn-primary mt-4">
                    <i class="bi bi-bank2 me-2"></i>Accéder à mes crédits
                </a>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>