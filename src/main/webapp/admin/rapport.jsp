<%@page import="ma.bankati.model.data.MoneyData" pageEncoding="UTF-8" %>
<%@page import="ma.bankati.model.users.User" %>
<%
    var ctx = request.getContextPath();
%>
<html>
<head>
    <title>Rapports - Admin</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="<%= ctx %>/assets/css/bootstrap.min.css">
    <link rel="stylesheet" href="<%= ctx %>/assets/css/bootstrap-icons.css">
    <link rel="stylesheet" href="<%= ctx %>/assets/css/style.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

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

        .dropdown-item.text-danger:hover {
            background: rgba(220, 53, 69, 0.1) !important;
            color: #dc3545 !important;
        }

        /* Cards */
        .report-card {
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

        .report-card:hover {
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

        .card-header {
            background: rgba(255, 255, 255, 0.05) !important;
            border-bottom: 1px solid rgba(255, 255, 255, 0.1) !important;
            color: #ffffff;
            border-radius: 20px 20px 0 0 !important;
        }

        .card-title {
            color: #ffffff !important;
            font-weight: 600;
        }

        .text-muted {
            color: rgba(255, 255, 255, 0.6) !important;
        }

        /* Breadcrumb */
        .breadcrumb {
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(20px);
            border-radius: 12px;
            border: 1px solid rgba(255, 255, 255, 0.15);
        }

        .breadcrumb-item a {
            color: #20c997;
            text-decoration: none;
        }

        .breadcrumb-item.active {
            color: rgba(255, 255, 255, 0.8);
        }

        /* Stats grid */
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }

        .stat-box {
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(20px);
            border: 1px solid rgba(255, 255, 255, 0.15);
            border-radius: 20px;
            padding: 2rem;
            text-align: center;
            transition: all 0.3s ease;
            position: relative;
            z-index: 10;
            animation: slideUp 0.6s ease-out;
            opacity: 0;
        }

        .stat-box:hover {
            transform: translateY(-8px);
            box-shadow: 0 20px 50px rgba(0, 0, 0, 0.2);
            border-color: rgba(255, 255, 255, 0.25);
        }

        .stat-value {
            font-size: 2.5rem;
            font-weight: 700;
            color: #20c997;
            text-shadow: 0 2px 10px rgba(0, 0, 0, 0.3);
        }

        .stat-label {
            color: rgba(255, 255, 255, 0.8);
            font-size: 0.9rem;
            margin-top: 0.5rem;
            font-weight: 500;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        /* Titres */
        .page-title {
            font-size: 2.5rem;
            font-weight: 700;
            color: #ffffff;
            text-shadow: 0 2px 10px rgba(0, 0, 0, 0.3);
            margin-bottom: 0.5rem;
        }

        .page-subtitle {
            color: rgba(255, 255, 255, 0.8);
            font-size: 1.1rem;
            font-weight: 400;
        }

        /* Boutons */
        .btn-outline-secondary {
            background: rgba(255, 255, 255, 0.1) !important;
            border: 1px solid rgba(255, 255, 255, 0.2) !important;
            color: #ffffff !important;
            border-radius: 12px;
            font-weight: 500;
            transition: all 0.3s ease;
        }

        .btn-outline-secondary:hover {
            background: rgba(255, 255, 255, 0.2) !important;
            border-color: rgba(255, 255, 255, 0.3) !important;
            color: #ffffff !important;
            transform: translateY(-2px);
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

        /* Tables */
        .table-dark {
            background: rgba(0, 0, 0, 0.2);
            border-radius: 12px;
            overflow: hidden;
        }

        .table-dark th,
        .table-dark td {
            border-color: rgba(255, 255, 255, 0.1);
            color: rgba(255, 255, 255, 0.9);
        }

        .table-dark thead th {
            background: rgba(255, 255, 255, 0.05);
            font-weight: 600;
        }

        /* Chart container */
        .chart-container {
            position: relative;
            height: 350px;
            padding: 1rem;
        }

        /* Badges */
        .badge {
            font-size: 0.75rem;
            font-weight: 500;
            padding: 0.5em 0.75em;
            border-radius: 8px;
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

        /* Container principal */
        .main-container {
            position: relative;
            z-index: 10;
        }

        /* Responsive */
        @media (max-width: 768px) {
            .page-title {
                font-size: 2rem;
            }
            .stat-value {
                font-size: 2rem;
            }
            .stats-grid {
                grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
                gap: 15px;
            }
        }

        /* Animation des icônes */
        .report-card .bi {
            transition: all 0.3s ease;
        }

        .report-card:hover .bi {
            transform: scale(1.1) rotate(5deg);
        }

        /* Scrollbar personnalisée */
        ::-webkit-scrollbar {
            width: 8px;
        }

        ::-webkit-scrollbar-track {
            background: rgba(255, 255, 255, 0.1);
            border-radius: 4px;
        }

        ::-webkit-scrollbar-thumb {
            background: rgba(255, 255, 255, 0.3);
            border-radius: 4px;
        }

        ::-webkit-scrollbar-thumb:hover {
            background: rgba(255, 255, 255, 0.5);
        }
    </style>
</head>
    <%
    var connectedUser = (User) session.getAttribute("connectedUser");
    var appName = (String) application.getAttribute("AppName");

    // Données pour les rapports - remplacez par vos vraies données
    var totalUsers = request.getAttribute("totalUsers") != null ? (Integer) request.getAttribute("totalUsers") : 245;
    var totalTransactions = request.getAttribute("totalTransactions") != null ? (Integer) request.getAttribute("totalTransactions") : 1547;
    var monthlyRevenue = request.getAttribute("monthlyRevenue") != null ? (Double) request.getAttribute("monthlyRevenue") : 125000.0;
    var averageTransaction = request.getAttribute("averageTransaction") != null ? (Double) request.getAttribute("averageTransaction") : 3500.0;
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
                    <a class="nav-link text-white fw-bold" href="<%= ctx %>/credit-requests">
                        <i class="bi bi-credit-card me-1"></i> Demandes de crédit
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link text-white fw-bold active" href="<%= ctx %>/reports">
                        <i class="bi bi-graph-up me-1"></i> Rapports
                    </a>
                </li>
            </ul>
        </div>

        <!-- Infos session -->
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

    <!-- Breadcrumb -->
    <nav aria-label="breadcrumb" class="mb-4">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="<%= ctx %>/home">Accueil</a></li>
            <li class="breadcrumb-item active" aria-current="page">Rapports</li>
        </ol>
    </nav>

    <!-- Titre de la page -->
    <div class="row mb-5">
        <div class="col-12">
            <div class="d-flex justify-content-between align-items-center flex-wrap">
                <div class="mb-3 mb-md-0">
                    <h1 class="page-title">
                        <i class="bi bi-graph-up text-success me-2"></i>Rapports et Analyses
                    </h1>
                    <p class="page-subtitle">Statistiques détaillées de votre système bancaire</p>
                </div>
                <div>
                    <button class="btn btn-outline-secondary me-2">
                        <i class="bi bi-download me-1"></i>Exporter PDF
                    </button>
                    <button class="btn btn-outline-secondary">
                        <i class="bi bi-printer me-1"></i>Imprimer
                    </button>
                </div>
            </div>
        </div>
    </div>

    <!-- Statistiques rapides -->
    <div class="stats-grid mb-5">
        <div class="stat-box">
            <div class="stat-value"><%= totalUsers %></div>
            <div class="stat-label">Utilisateurs Total</div>
        </div>
        <div class="stat-box">
            <div class="stat-value"><%= totalTransactions %></div>
            <div class="stat-label">Transactions ce mois</div>
        </div>
        <div class="stat-box">
            <div class="stat-value"><%= String.format("%.0f", monthlyRevenue) %> MAD</div>
            <div class="stat-label">Revenus mensuels</div>
        </div>
        <div class="stat-box">
            <div class="stat-value"><%= String.format("%.0f", averageTransaction) %> MAD</div>
            <div class="stat-label">Transaction moyenne</div>
        </div>
    </div>

    <!-- Tableaux de données détaillées -->
    <div class="row mb-4">
        <!-- Top transactions -->
        <div class="col-lg-6 mb-4">
            <div class="card report-card">
                <div class="card-header border-bottom-0">
                    <h5 class="card-title mb-0">
                        <i class="bi bi-trophy text-warning me-2"></i>Top 5 Transactions
                    </h5>
                </div>
                <div class="card-body">
                    <div class="table-responsive">
                        <table class="table table-dark table-striped">
                            <thead>
                            <tr>
                                <th>Date</th>
                                <th>Utilisateur</th>
                                <th>Montant</th>
                                <th>Type</th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr>
                                <td>24/05/2025</td>
                                <td>Ahmed Benali</td>
                                <td class="text-success">+150,000 MAD</td>
                                <td><span class="badge bg-success">Crédit</span></td>
                            </tr>
                            <tr>
                                <td>23/05/2025</td>
                                <td>Fatima Zahra</td>
                                <td class="text-danger">-95,000 MAD</td>
                                <td><span class="badge bg-danger">Débit</span></td>
                            </tr>
                            <tr>
                                <td>22/05/2025</td>
                                <td>Mohammed Alami</td>
                                <td class="text-success">+85,000 MAD</td>
                                <td><span class="badge bg-success">Crédit</span></td>
                            </tr>
                            <tr>
                                <td>21/05/2025</td>
                                <td>Aicha Benali</td>
                                <td class="text-danger">-75,000 MAD</td>
                                <td><span class="badge bg-danger">Débit</span></td>
                            </tr>
                            <tr>
                                <td>20/05/2025</td>
                                <td>Youssef Kadiri</td>
                                <td class="text-success">+65,000 MAD</td>
                                <td><span class="badge bg-success">Crédit</span></td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>

        <!-- Activité mensuelle -->
        <div class="col-lg-6 mb-4">
            <div class="card report-card">
                <div class="card-header border-bottom-0">
                    <h5 class="card-title mb-0">
                        <i class="bi bi-calendar-month text-info me-2"></i>Activité Mensuelle
                    </h5>
                </div>
                <div class="card-body">
                    <div class="row text-center">
                        <div class="col-4">
                            <div class="mb-3">
                                <h4 class="text-success">2,847</h4>
                                <small class="text-muted">Transactions totales</small>
                            </div>
                        </div>
                        <div class="col-4">
                            <div class="mb-3">
                                <h4 class="text-warning">47</h4>
                                <small class="text-muted">Nouveaux utilisateurs</small>
                            </div>
                        </div>
                        <div class="col-4">
                            <div class="mb-3">
                                <h4 class="text-info">1.2M MAD</h4>
                                <small class="text-muted">Volume total</small>
                            </div>
                        </div>
                    </div>
                    <hr style="border-color: rgba(255, 255, 255, 0.2);">
                    <div class="row text-center">
                        <div class="col-6">
                            <div class="mb-2">
                                <span class="text-success">↑ 12%</span>
                                <small class="text-muted d-block">vs mois dernier</small>
                            </div>
                        </div>
                        <div class="col-6">
                            <div class="mb-2">
                                <span class="text-success">↑ 8%</span>
                                <small class="text-muted d-block">vs année dernière</small>
                            </div>
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
                <small class="text-muted">Version 2.1.5 | Rapport généré le: <%= new java.util.Date() %></small>
            </div>
        </div>
    </div>
</footer>

<!-- Scripts pour les graphiques -->
<script>
    // Animation au chargement des cartes
    document.addEventListener('DOMContentLoaded', function() {
        const cards = document.querySelectorAll('.report-card');
        cards.forEach((card, index) => {
            setTimeout(() => {
                card.style.opacity = '1';
                card.style.transform = 'translateY(0)';
            }, index * 150);
        });

        // Animation des statistiques
        const statBoxes = document.querySelectorAll('.stat-box');
        statBoxes.forEach((box, index) => {
            setTimeout(() => {
                box.style.opacity = '1';
                box.style.transform = 'translateY(0)';
            }, index * 100);
        });

        // Animation des valeurs statistiques
        const statValues = document.querySelectorAll('.stat-value');
        statValues.forEach(stat => {
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
</script>

</body>
</html>