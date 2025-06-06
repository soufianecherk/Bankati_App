<%@page import="ma.bankati.model.data.MoneyData" pageEncoding="UTF-8" %>
<%@page import="ma.bankati.model.users.User" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    var ctx = request.getContextPath();
    var connectedUser = (User) session.getAttribute("connectedUser");
    var appName = (String) application.getAttribute("AppName");
%>
<html>
<head>
    <title>Demandes de Crédit - Admin</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="<%= ctx %>/assets/css/bootstrap.min.css">
    <link rel="stylesheet" href="<%= ctx %>/assets/css/bootstrap-icons.css">
    <link rel="stylesheet" href="<%= ctx %>/assets/css/style.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', sans-serif;
            background: linear-gradient(135deg, rgba(0, 32, 96, 0.95), rgba(0, 64, 128, 0.9)),
            url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1000 1000"><defs><linearGradient id="bg" x1="0%" y1="0%" x2="100%" y2="100%"><stop offset="0%" style="stop-color:%23001f3f;stop-opacity:1" /><stop offset="100%" style="stop-color:%23003d7a;stop-opacity:1" /></linearGradient></defs><rect width="1000" height="1000" fill="url(%23bg)"/><g opacity="0.08"><circle cx="200" cy="200" r="100" fill="white"/><circle cx="800" cy="300" r="150" fill="white"/><circle cx="400" cy="700" r="80" fill="white"/><circle cx="700" cy="800" r="120" fill="white"/><rect x="100" y="500" width="200" height="100" rx="10" fill="white"/><rect x="600" y="100" width="250" height="120" rx="15" fill="white"/></g></svg>');
            background-size: cover;
            background-attachment: fixed;
            min-height: 100vh;
            color: #ffffff;
        }

        /* Particules flottantes */
        body::before {
            content: '';
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background-image:
                    radial-gradient(circle at 20% 20%, rgba(255, 255, 255, 0.05) 1px, transparent 1px),
                    radial-gradient(circle at 80% 30%, rgba(255, 255, 255, 0.03) 1px, transparent 1px),
                    radial-gradient(circle at 40% 70%, rgba(255, 255, 255, 0.04) 1px, transparent 1px),
                    radial-gradient(circle at 90% 80%, rgba(255, 255, 255, 0.05) 1px, transparent 1px);
            background-size: 200px 200px, 300px 300px, 250px 250px, 180px 180px;
            animation: float 20s infinite linear;
            pointer-events: none;
            z-index: 1;
        }

        @keyframes float {
            0% { transform: translateY(0px) translateX(0px); }
            25% { transform: translateY(-10px) translateX(5px); }
            50% { transform: translateY(-5px) translateX(-5px); }
            75% { transform: translateY(-15px) translateX(3px); }
            100% { transform: translateY(0px) translateX(0px); }
        }

        /* Navbar */
        .navbar {
            background: rgba(255, 255, 255, 0.1) !important;
            backdrop-filter: blur(20px);
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
            z-index: 1000;
            position: relative;
        }

        .navbar-brand {
            font-weight: 700 !important;
            font-size: 1.3rem;
        }

        .nav-link {
            color: rgba(255, 255, 255, 0.9) !important;
            font-weight: 500 !important;
            padding: 0.7rem 1.2rem !important;
            border-radius: 10px;
            margin: 0 0.2rem;
            transition: all 0.3s ease;
        }

        .nav-link:hover, .nav-link.active {
            background: rgba(255, 255, 255, 0.15) !important;
            color: #ffffff !important;
            transform: translateY(-2px);
        }

        .dropdown-menu {
            background: rgba(255, 255, 255, 0.95) !important;
            backdrop-filter: blur(20px);
            border: 1px solid rgba(255, 255, 255, 0.2);
            border-radius: 12px;
        }

        .dropdown-item {
            color: #333 !important;
            padding: 0.7rem 1.2rem;
            border-radius: 8px;
            margin: 0.2rem;
        }

        .dropdown-item:hover {
            background: rgba(0, 102, 204, 0.1) !important;
            color: #0066cc !important;
        }

        /* Cards */
        .dashboard-card {
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(20px);
            border: 1px solid rgba(255, 255, 255, 0.15);
            border-radius: 20px;
            transition: all 0.3s ease;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            position: relative;
            z-index: 10;
            animation: slideUp 0.6s ease-out;
            opacity: 0;
        }

        .dashboard-card:hover {
            transform: translateY(-3px);
            box-shadow: 0 15px 40px rgba(0, 0, 0, 0.15);
            border-color: rgba(255, 255, 255, 0.25);
        }

        @keyframes slideUp {
            to {
                opacity: 1;
                transform: translateY(0);
            }
            from {
                opacity: 0;
                transform: translateY(30px);
            }
        }

        /* Table moderne */
        .modern-table {
            background: rgba(255, 255, 255, 0.08);
            backdrop-filter: blur(20px);
            border-radius: 16px;
            overflow: hidden;
            border: 1px solid rgba(255, 255, 255, 0.1);
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
        }

        .modern-table table {
            width: 100%;
            margin: 0;
            border-collapse: separate;
            border-spacing: 0;
        }

        .modern-table th {
            background: rgba(255, 255, 255, 0.1);
            color: #ffffff;
            font-weight: 600;
            padding: 1.2rem 1rem;
            text-align: left;
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
            font-size: 0.9rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .modern-table td {
            padding: 1rem;
            border-bottom: 1px solid rgba(255, 255, 255, 0.05);
            color: rgba(255, 255, 255, 0.9);
            vertical-align: middle;
        }

        .modern-table tr:hover {
            background: rgba(255, 255, 255, 0.05);
        }

        .modern-table tr:last-child td {
            border-bottom: none;
        }

        /* Badges de statut */
        .status-badge {
            padding: 0.4rem 0.8rem;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .status-pending {
            background: rgba(255, 193, 7, 0.2);
            color: #ffc107;
            border: 1px solid rgba(255, 193, 7, 0.3);
        }

        .status-approved {
            background: rgba(40, 167, 69, 0.2);
            color: #28a745;
            border: 1px solid rgba(40, 167, 69, 0.3);
        }

        .status-rejected {
            background: rgba(220, 53, 69, 0.2);
            color: #dc3545;
            border: 1px solid rgba(220, 53, 69, 0.3);
        }

        /* Boutons d'action */
        .action-btn {
            padding: 0.5rem 1rem;
            border: none;
            border-radius: 10px;
            font-weight: 500;
            font-size: 0.85rem;
            cursor: pointer;
            transition: all 0.3s ease;
            margin: 0 0.2rem;
            text-decoration: none;
            display: inline-block;
        }

        .btn-accept {
            background: linear-gradient(135deg, #28a745, #20c997);
            color: white;
            border: 1px solid rgba(40, 167, 69, 0.3);
        }

        .btn-accept:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(40, 167, 69, 0.3);
            background: linear-gradient(135deg, #20c997, #28a745);
        }

        .btn-reject {
            background: linear-gradient(135deg, #dc3545, #e74c3c);
            color: white;
            border: 1px solid rgba(220, 53, 69, 0.3);
        }

        .btn-reject:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(220, 53, 69, 0.3);
            background: linear-gradient(135deg, #e74c3c, #dc3545);
        }

        .btn-disabled {
            background: rgba(108, 117, 125, 0.3);
            color: rgba(255, 255, 255, 0.5);
            cursor: not-allowed;
            border: 1px solid rgba(108, 117, 125, 0.2);
        }

        /* Statistiques en en-tête */
        .stats-header {
            background: rgba(255, 255, 255, 0.08);
            backdrop-filter: blur(20px);
            border-radius: 16px;
            padding: 1.5rem;
            margin-bottom: 2rem;
            border: 1px solid rgba(255, 255, 255, 0.1);
        }

        .stat-item {
            text-align: center;
        }

        .stat-number {
            font-size: 2rem;
            font-weight: 700;
            color: #ffffff;
            display: block;
        }

        .stat-label {
            font-size: 0.9rem;
            color: rgba(255, 255, 255, 0.7);
            text-transform: uppercase;
            font-weight: 500;
            letter-spacing: 0.5px;
        }

        /* Filtres */
        .filter-section {
            background: rgba(255, 255, 255, 0.08);
            backdrop-filter: blur(20px);
            border-radius: 16px;
            padding: 1.5rem;
            margin-bottom: 2rem;
            border: 1px solid rgba(255, 255, 255, 0.1);
        }

        .filter-btn {
            background: rgba(255, 255, 255, 0.1);
            border: 1px solid rgba(255, 255, 255, 0.2);
            color: rgba(255, 255, 255, 0.8);
            padding: 0.5rem 1rem;
            border-radius: 10px;
            margin: 0.2rem;
            transition: all 0.3s ease;
            cursor: pointer;
        }

        .filter-btn:hover, .filter-btn.active {
            background: rgba(255, 255, 255, 0.2);
            color: #ffffff;
            border-color: rgba(255, 255, 255, 0.3);
        }

        /* Titres */
        .page-title {
            font-size: 2.2rem;
            font-weight: 700;
            color: #ffffff;
            text-shadow: 0 2px 10px rgba(0, 0, 0, 0.3);
            margin-bottom: 0.5rem;
            text-align: center;
        }

        .page-subtitle {
            color: rgba(255, 255, 255, 0.8);
            font-size: 1.1rem;
            font-weight: 400;
            text-align: center;
            margin-bottom: 2rem;
        }

        /* Container principal */
        .main-container {
            position: relative;
            z-index: 10;
        }

        /* Footer */
        footer {
            background: rgba(255, 255, 255, 0.05) !important;
            backdrop-filter: blur(20px);
            border-top: 1px solid rgba(255, 255, 255, 0.1);
            margin-top: 4rem;
            position: relative;
            z-index: 10;
        }

        /* Responsive */
        @media (max-width: 768px) {
            .page-title {
                font-size: 1.8rem;
            }
            .modern-table {
                font-size: 0.9rem;
            }
            .modern-table th,
            .modern-table td {
                padding: 0.8rem 0.5rem;
            }
            .action-btn {
                padding: 0.4rem 0.8rem;
                font-size: 0.8rem;
                margin: 0.1rem;
            }
        }

        /* Animation de chargement */
        .loading-shimmer {
            animation: shimmer 1.5s infinite;
        }

        @keyframes shimmer {
            0% { opacity: 0.5; }
            50% { opacity: 1; }
            100% { opacity: 0.5; }
        }
    </style>
</head>
<body class="Optima">

<!-- NAVBAR -->
<nav class="navbar navbar-expand-lg navbar-dark shadow">
    <div class="container-fluid">
        <!-- Logo & Brand -->
        <a class="navbar-brand d-flex align-items-center" href="<%= ctx %>/home">
            <img src="<%= ctx %>/assets/img/logoBlue.png" alt="Logo" width="40" height="40" class="d-inline-block align-text-top me-2">
            <strong class="text-white"><%=application.getAttribute("AppName")%> - Admin</strong>
        </a>

        <!-- Menu de navigation -->
        <div class="collapse navbar-collapse">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                <li class="nav-item">
                    <a class="nav-link text-white fw-bold" href="<%= ctx %>/home">
                        <i class="bi bi-speedometer2 me-1"></i> Tableau de bord
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link text-white fw-bold" href="<%= ctx %>/users">
                        <i class="bi bi-people-fill me-1"></i> Utilisateurs
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link text-white fw-bold active" href="<%= ctx %>/credit-requests">
                        <i class="bi bi-credit-card me-1"></i> Demandes de crédit
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link text-white fw-bold" href="<%= ctx %>/reports">
                        <i class="bi bi-graph-up me-1"></i> Rapports
                    </a>
                </li>
            </ul>
        </div>

        <!-- Infos session avec sous-menu -->
        <div class="dropdown d-flex align-items-center">
            <a class="btn btn-outline-light dropdown-toggle"
               href="#" role="button" id="dropdownSessionMenu" data-bs-toggle="dropdown" aria-expanded="false">
                <i class="bi bi-person-circle me-1"></i> <%= connectedUser.getFirstName() + " " + connectedUser.getLastName() %>
            </a>
            <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="dropdownSessionMenu">
                <li><a class="dropdown-item" href="<%= ctx %>/admin/profile"><i class="bi bi-person me-1"></i> Mon profil</a></li>
                <li><a class="dropdown-item" href="<%= ctx %>/admin/settings"><i class="bi bi-gear me-1"></i> Paramètres</a></li>
                <li><hr class="dropdown-divider"></li>
                <li>
                    <a class="dropdown-item text-danger logout-btn fw-bold" href="<%= ctx %>/logout">
                        <i class="bi bi-box-arrow-right me-1"></i> Déconnexion
                    </a>
                </li>
            </ul>
        </div>
    </div>
</nav>

<!-- CONTENU PRINCIPAL -->
<div class="container-fluid mt-4 main-container">

    <!-- Titre de la page -->
    <div class="row mb-4">
        <div class="col-12">
            <h1 class="page-title">
                <i class="bi bi-credit-card me-3"></i>Gestion des Demandes de Crédit
            </h1>
            <p class="page-subtitle">Gérez et approuvez les demandes de crédit de vos clients</p>
        </div>
    </div>

    <!-- Statistiques en en-tête -->
    <div class="stats-header">
        <div class="row">
            <div class="col-md-3 stat-item">
                <span class="stat-number text-warning">${totalPending != null ? totalPending : 0}</span>
                <span class="stat-label">En Attente</span>
            </div>
            <div class="col-md-3 stat-item">
                <span class="stat-number text-success">${totalApproved != null ? totalApproved : 0}</span>
                <span class="stat-label">Approuvées</span>
            </div>
            <div class="col-md-3 stat-item">
                <span class="stat-number text-danger">${totalRejected != null ? totalRejected : 0}</span>
                <span class="stat-label">Rejetées</span>
            </div>
            <div class="col-md-3 stat-item">
                <span class="stat-number text-info">${totalRequests != null ? totalRequests : 0}</span>
                <span class="stat-label">Total</span>
            </div>
        </div>
    </div>

    <!-- Section de filtres -->
    <div class="filter-section">
        <div class="row align-items-center">
            <div class="col-md-6">
                <h6 class="mb-2 text-white"><i class="bi bi-funnel me-2"></i>Filtrer par statut :</h6>
                <button class="filter-btn active" onclick="filterByStatus('all')">Tous</button>
                <button class="filter-btn" onclick="filterByStatus('EN_ATTENTE')">En Attente</button>
                <button class="filter-btn" onclick="filterByStatus('APPROVED')">Approuvées</button>
                <button class="filter-btn" onclick="filterByStatus('REJECTED')">Rejetées</button>
            </div>
            <div class="col-md-6 text-end">
                <button class="btn btn-outline-light" onclick="refreshData()">
                    <i class="bi bi-arrow-clockwise me-2"></i>Actualiser
                </button>
            </div>
        </div>
    </div>

    <!-- Tableau des demandes -->
    <div class="row">
        <div class="col-12">
            <div class="dashboard-card">
                <div class="card-body p-0">
                    <div class="modern-table">
                        <table>
                            <thead>
                            <tr>
                                <th><i class="bi bi-hash me-2"></i>ID</th>
                                <th><i class="bi bi-person me-2"></i>Client</th>
                                <th><i class="bi bi-cash-stack me-2"></i>Montant</th>
                                <th><i class="bi bi-calendar me-2"></i>Date Demande</th>
                                <th><i class="bi bi-clock me-2"></i>Durée</th>
                                <th><i class="bi bi-flag me-2"></i>Statut</th>
                                <th><i class="bi bi-gear me-2"></i>Actions</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:choose>
                                <c:when test="${not empty demandes}">
                                    <c:forEach var="demande" items="${demandes}">
                                        <tr data-status="${demande.etat}">
                                            <td><strong>#${demande.id}</strong></td>
                                            <td>
                                                <div class="d-flex align-items-center">
                                                    <i class="bi bi-person-circle me-2" style="font-size: 1.5rem; opacity: 0.7;"></i>
                                                    <div>
                                                        <strong>${demande.user.firstName} ${demande.user.lastName}</strong>
                                                        <br><small class="text-muted">ID: ${demande.user.id}</small>
                                                    </div>
                                                </div>
                                            </td>
                                            <td>
                                                <strong style="color: #28a745; font-size: 1.1rem;">
                                                        ${demande.montant} MAD
                                                </strong>
                                            </td>
                                            <td>
                                                <i class="bi bi-calendar3 me-1"></i>
                                                    ${demande.dateDemande}
                                            </td>
                                            <td>
                                                <i class="bi bi-clock me-1"></i>
                                                    ${demande.duree != null ? demande.duree : '12'} mois
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${demande.etat == 'EN_ATTENTE'}">
                                                            <span class="status-badge status-pending">
                                                                <i class="bi bi-hourglass-split me-1"></i>En Attente
                                                            </span>
                                                    </c:when>
                                                    <c:when test="${demande.etat == 'APPROVED'}">
                                                            <span class="status-badge status-approved">
                                                                <i class="bi bi-check-circle me-1"></i>Approuvée
                                                            </span>
                                                    </c:when>
                                                    <c:when test="${demande.etat == 'REJECTED'}">
                                                            <span class="status-badge status-rejected">
                                                                <i class="bi bi-x-circle me-1"></i>Rejetée
                                                            </span>
                                                    </c:when>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <c:if test="${demande.etat == 'EN_ATTENTE'}">
                                                    <form method="post" action="<%= ctx %>/credit-requests" style="display:inline;">
                                                        <input type="hidden" name="id" value="${demande.id}" />
                                                        <button type="submit" name="action" value="accepter" class="action-btn btn-accept">
                                                            <i class="bi bi-check-lg me-1"></i>Accepter
                                                        </button>
                                                    </form>
                                                    <form method="post" action="<%= ctx %>/credit-requests" style="display:inline;">
                                                        <input type="hidden" name="id" value="${demande.id}" />
                                                        <button type="submit" name="action" value="refuser" class="action-btn btn-reject">
                                                            <i class="bi bi-x-lg me-1"></i>Refuser
                                                        </button>
                                                    </form>
                                                </c:if>
                                                <c:if test="${demande.etat != 'EN_ATTENTE'}">
                                                        <span class="action-btn btn-disabled">
                                                            <i class="bi bi-lock me-1"></i>Traitée
                                                        </span>
                                                </c:if>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <tr>
                                        <td colspan="7" class="text-center py-5">
                                            <div class="text-muted">
                                                <i class="bi bi-inbox" style="font-size: 3rem; opacity: 0.5;"></i>
                                                <h5 class="mt-3">Aucune demande de crédit trouvée</h5>
                                                <p>Il n'y a actuellement aucune demande de crédit à afficher.</p>
                                            </div>
                                        </td>
                                    </tr>
                                </c:otherwise>
                            </c:choose>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- FOOTER -->
<footer class="shadow-sm py-4">
    <div class="container">
        <div class="row align-items-center">
            <div class="col-md-6">
                <span class="text-muted">
                    <strong style="color: #ffffff;"><%= appName %></strong> Admin Panel © 2025 - Tous droits réservés
                </span>
            </div>
            <div class="col-md-6 text-end">
                <small class="text-muted">Version 2.1.5 | Dernière connexion: <%= new java.util.Date() %></small>
            </div>
        </div>
    </div>
</footer>

<!-- Scripts d'animation -->
<script>
    // Animation au chargement des cartes
    document.addEventListener('DOMContentLoaded', function() {
        const cards = document.querySelectorAll('.dashboard-card');
        cards.forEach((card, index) => {
            setTimeout(() => {
                card.style.opacity = '1';
                card.style.transform = 'translateY(0)';
            }, index * 200);
        });

        // Animation des statistiques (compteur)
        const statNumbers = document.querySelectorAll('.stat-number');
        statNumbers.forEach(stat => {
            const text = stat.textContent;
            const number = parseInt(text.replace(/[^\d]/g, ''));
            if (!isNaN(number) && number > 0) {
                animateNumber(stat, 0, number, 2000, text);
            }
        });
    });

    // Animation des nombres
    function animateNumber(element, start, end, duration, originalText) {
        const isMAD = originalText.includes('MAD');
        const startTime = performance.now();

        function updateNumber(currentTime) {
            const elapsed = currentTime - startTime;
            const progress = Math.min(elapsed / duration, 1);
            const current = Math.round(start + (end - start) * easeOutCubic(progress));

            if (isMAD) {
                element.textContent = current.toLocaleString() + ' MAD';
            } else {
                element.textContent = current.toLocaleString();
            }

            if (progress < 1) {
                requestAnimationFrame(updateNumber);
            }
        }

        requestAnimationFrame(updateNumber);
    }

    // Fonction d'easing
    function easeOutCubic(t) {
        return 1 - Math.pow(1 - t, 3);
    }

    // Actualisation automatique des données
    setInterval(function() {
        console.log('Vérification des nouvelles données...');
    }, 30000);
</script>

</body>
</html>