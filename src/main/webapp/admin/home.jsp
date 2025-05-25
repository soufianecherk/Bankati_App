<%@page import="ma.bankati.model.data.MoneyData" pageEncoding="UTF-8" %>
<%@page import="ma.bankati.model.users.User" %>
<%
    var ctx = request.getContextPath();
%>
<html>
<head>
    <title>Tableau de bord - Admin</title>
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
            transform: translateY(-8px);
            box-shadow: 0 20px 50px rgba(0, 0, 0, 0.2);
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

        .stat-number {
            font-size: 2.5rem;
            font-weight: 700;
            color: #ffffff;
            text-shadow: 0 2px 10px rgba(0, 0, 0, 0.3);
        }

        .stat-label {
            font-size: 0.9rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            color: rgba(255, 255, 255, 0.8);
        }

        /* Gradients spéciaux */
        .bg-gradient-primary {
            background: linear-gradient(135deg, #0066cc, #004499) !important;
        }

        .bg-gradient-success {
            background: linear-gradient(135deg, #28a745, #1e7e34) !important;
        }

        .bg-gradient-warning {
            background: linear-gradient(135deg, #ffc107, #e0a800) !important;
        }

        .bg-gradient-info {
            background: linear-gradient(135deg, #17a2b8, #138496) !important;
        }

        /* Actions rapides */
        .quick-action-btn {
            background: rgba(255, 255, 255, 0.08) !important;
            border: 1px solid rgba(255, 255, 255, 0.15) !important;
            border-radius: 16px !important;
            padding: 1.2rem !important;
            margin: 0.5rem 0 !important;
            transition: all 0.3s ease !important;
            color: #ffffff !important;
            text-decoration: none;
            display: block;
        }

        .quick-action-btn:hover {
            background: rgba(255, 255, 255, 0.15) !important;
            transform: translateY(-3px) scale(1.02);
            border-color: rgba(255, 255, 255, 0.25) !important;
            color: #ffffff !important;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.15);
        }

        /* Titres et textes */
        .welcome-title {
            font-size: 2.5rem;
            font-weight: 700;
            color: #ffffff;
            text-shadow: 0 2px 10px rgba(0, 0, 0, 0.3);
            margin-bottom: 0.5rem;
        }

        .welcome-subtitle {
            color: rgba(255, 255, 255, 0.8);
            font-size: 1.1rem;
            font-weight: 400;
        }

        .card-title {
            color: #ffffff !important;
            font-weight: 600;
        }

        .text-muted {
            color: rgba(255, 255, 255, 0.6) !important;
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

        /* Boutons */
        .btn-outline-primary {
            border-color: rgba(255, 255, 255, 0.3) !important;
            color: #ffffff !important;
            border-radius: 10px;
            font-weight: 500;
        }

        .btn-outline-primary:hover {
            background: rgba(255, 255, 255, 0.1) !important;
            border-color: rgba(255, 255, 255, 0.5) !important;
            color: #ffffff !important;
        }

        .btn-outline-light {
            background: rgba(255, 255, 255, 0.1);
            border-color: rgba(255, 255, 255, 0.2);
            border-radius: 12px;
            font-weight: 500;
        }

        .btn-outline-light:hover {
            background: rgba(255, 255, 255, 0.2);
            border-color: rgba(255, 255, 255, 0.3);
            color: #ffffff;
        }

        /* Responsive */
        @media (max-width: 768px) {
            .welcome-title {
                font-size: 2rem;
            }
            .stat-number {
                font-size: 2rem;
            }
            .dashboard-card {
                margin-bottom: 1.5rem;
            }
        }

        /* Animation des icônes */
        .dashboard-card .bi {
            transition: all 0.3s ease;
        }

        .dashboard-card:hover .bi {
            transform: scale(1.1) rotate(5deg);
        }

        /* Container principal */
        .main-container {
            position: relative;
            z-index: 10;
        }
    </style>
</head>
<%
    var result = (MoneyData) request.getAttribute("result");
    var connectedUser = (User) session.getAttribute("connectedUser");
    var appName = (String) application.getAttribute("AppName");

    // Données fictives pour la démonstration - à remplacer par vos vraies données
    var totalUsers = request.getAttribute("totalUsers") != null ? (Integer) request.getAttribute("totalUsers") : 245;
    var pendingCreditRequests = request.getAttribute("pendingCreditRequests") != null ? (Integer) request.getAttribute("pendingCreditRequests") : 12;
    var systemAlerts = request.getAttribute("systemAlerts") != null ? (Integer) request.getAttribute("systemAlerts") : 3;
%>
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
                    <a class="nav-link text-white fw-bold active" href="<%= ctx %>/home">
                        <i class="bi bi-speedometer2 me-1"></i> Tableau de bord
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link text-white fw-bold" href="<%= ctx %>/users">
                        <i class="bi bi-people-fill me-1"></i> Utilisateurs
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link text-white fw-bold" href="<%= ctx %>/credit-requests">
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

    <!-- Titre de bienvenue -->
    <div class="row mb-5">
        <div class="col-12 text-center">
            <h1 class="welcome-title">Bienvenue, <%= connectedUser.getFirstName() %> !</h1>
            <p class="welcome-subtitle">Voici un aperçu de votre système bancaire Bankati</p>
        </div>
    </div>

    <!-- CARTES DE STATISTIQUES -->
    <div class="row mb-5">
        <!-- Solde total du système -->
        <div class="col-xl-4 col-md-6 mb-4">
            <div class="card dashboard-card bg-gradient-primary text-white h-100">
                <div class="card-body">
                    <div class="row no-gutters align-items-center">
                        <div class="col mr-2">
                            <div class="stat-label mb-2">Solde Total Système</div>
                            <div class="stat-number"><%= result != null ? result.toString() : "0 MAD" %></div>
                        </div>
                        <div class="col-auto">
                            <i class="bi bi-wallet2" style="font-size: 3rem; opacity: 0.7;"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Nombre total d'utilisateurs -->
        <div class="col-xl-4 col-md-6 mb-4">
            <div class="card dashboard-card bg-gradient-success text-white h-100">
                <div class="card-body">
                    <div class="row no-gutters align-items-center">
                        <div class="col mr-2">
                            <div class="stat-label mb-2">Utilisateurs Actifs</div>
                            <div class="stat-number"><%= totalUsers %></div>
                        </div>
                        <div class="col-auto">
                            <i class="bi bi-people-fill" style="font-size: 3rem; opacity: 0.7;"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Demandes de crédit en attente -->
        <div class="col-xl-4 col-md-6 mb-4">
            <div class="card dashboard-card bg-gradient-warning text-white h-100">
                <div class="card-body">
                    <div class="row no-gutters align-items-center">
                        <div class="col mr-2">
                            <div class="stat-label mb-2">Demandes en Attente</div>
                            <div class="stat-number"><%= pendingCreditRequests %></div>
                        </div>
                        <div class="col-auto">
                            <i class="bi bi-credit-card" style="font-size: 3rem; opacity: 0.7;"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- ACTIONS RAPIDES -->
    <div class="row mb-5">
        <div class="col-12">
            <div class="card dashboard-card">
                <div class="card-body p-4">
                    <h4 class="card-title mb-4 text-center">
                        <i class="bi bi-lightning-fill text-warning me-2"></i>Actions Rapides
                    </h4>
                    <div class="row">
                        <div class="col-lg-4 col-md-6 mb-3">
                            <a href="<%= ctx %>/users" class="quick-action-btn text-start">
                                <div class="d-flex align-items-center">
                                    <i class="bi bi-people-fill me-3" style="font-size: 1.5rem;"></i>
                                    <div>
                                        <strong class="d-block">Gestion Utilisateurs</strong>
                                        <small class="text-muted">Voir, ajouter, modifier les comptes</small>
                                    </div>
                                </div>
                            </a>
                        </div>
                        <div class="col-lg-4 col-md-6 mb-3">
                            <a href="<%= ctx %>/credit-requests" class="quick-action-btn text-start">
                                <div class="d-flex align-items-center">
                                    <i class="bi bi-credit-card me-3" style="font-size: 1.5rem;"></i>
                                    <div>
                                        <strong class="d-block">Demandes de Crédit</strong>
                                        <small class="text-muted">Gérer et approuver les demandes</small>
                                    </div>
                                </div>
                            </a>
                        </div>
                        <div class="col-lg-4 col-md-6 mb-3">
                            <a href="<%= ctx %>/reports" class="quick-action-btn text-start">
                                <div class="d-flex align-items-center">
                                    <i class="bi bi-graph-up me-3" style="font-size: 1.5rem;"></i>
                                    <div>
                                        <strong class="d-block">Rapports & Analytics</strong>
                                        <small class="text-muted">Statistiques et analyses</small>
                                    </div>
                                </div>
                            </a>
                        </div>
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