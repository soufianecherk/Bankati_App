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
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
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

        /* Cards principales */
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

        /* Titre de bienvenue */
        .welcome-hero {
            text-align: center;
            padding: 4rem 0;
            position: relative;
            z-index: 10;
        }

        .welcome-title {
            font-size: 3rem;
            font-weight: 700;
            color: #ffffff;
            text-shadow: 0 2px 20px rgba(0, 0, 0, 0.3);
            margin-bottom: 1rem;
            animation: fadeInUp 1s ease-out;
        }

        .welcome-subtitle {
            color: rgba(255, 255, 255, 0.8);
            font-size: 1.2rem;
            font-weight: 400;
            margin-bottom: 2rem;
            animation: fadeInUp 1s ease-out 0.2s both;
        }

        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        /* Services rapides */
        .service-card {
            background: rgba(255, 255, 255, 0.08);
            border: 1px solid rgba(255, 255, 255, 0.15);
            border-radius: 20px;
            padding: 2rem;
            text-align: center;
            transition: all 0.3s ease;
            text-decoration: none;
            color: #ffffff;
            display: block;
            height: 100%;
            position: relative;
            overflow: hidden;
        }

        .service-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.1), transparent);
            transition: left 0.5s;
        }

        .service-card:hover::before {
            left: 100%;
        }

        .service-card:hover {
            background: rgba(255, 255, 255, 0.15);
            transform: translateY(-5px) scale(1.02);
            border-color: rgba(255, 255, 255, 0.25);
            color: #ffffff;
            text-decoration: none;
            box-shadow: 0 15px 40px rgba(0, 0, 0, 0.2);
        }

        .service-icon {
            font-size: 3rem;
            margin-bottom: 1rem;
            color: rgba(255, 255, 255, 0.9);
            transition: all 0.3s ease;
        }

        .service-card:hover .service-icon {
            transform: scale(1.1) rotate(5deg);
            color: #ffffff;
        }

        .service-title {
            font-size: 1.2rem;
            font-weight: 600;
            margin-bottom: 0.5rem;
        }

        .service-description {
            color: rgba(255, 255, 255, 0.7);
            font-size: 0.9rem;
            line-height: 1.5;
        }

        /* Stats utilisateur */
        .user-stats {
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(20px);
            border: 1px solid rgba(255, 255, 255, 0.15);
            border-radius: 20px;
            padding: 2rem;
            margin: 2rem 0;
        }

        .stat-item {
            text-align: center;
            padding: 1rem;
        }

        .stat-number {
            font-size: 2rem;
            font-weight: 700;
            color: #ffffff;
            display: block;
        }

        .stat-label {
            color: rgba(255, 255, 255, 0.7);
            font-size: 0.9rem;
            font-weight: 500;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        /* Boutons */
        .btn-primary-custom {
            background: linear-gradient(135deg, #0066cc, #004499);
            border: none;
            border-radius: 12px;
            padding: 0.8rem 2rem;
            font-weight: 600;
            font-size: 1rem;
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(0, 102, 204, 0.3);
        }

        .btn-primary-custom:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(0, 102, 204, 0.4);
            background: linear-gradient(135deg, #004499, #0066cc);
        }

        .btn-outline-light {
            background: rgba(255, 255, 255, 0.1);
            border-color: rgba(255, 255, 255, 0.2);
            border-radius: 12px;
            font-weight: 500;
            transition: all 0.3s ease;
        }

        .btn-outline-light:hover {
            background: rgba(255, 255, 255, 0.2);
            border-color: rgba(255, 255, 255, 0.3);
            color: #ffffff;
            transform: translateY(-2px);
        }

        /* Footer */
        .footer {
            background: rgba(255, 255, 255, 0.05);
            backdrop-filter: blur(20px);
            border-top: 1px solid rgba(255, 255, 255, 0.1);
            margin-top: 4rem;
            padding: 2rem 0;
            text-align: center;
            color: rgba(255, 255, 255, 0.7);
        }

        /* Responsive */
        @media (max-width: 768px) {
            .welcome-title {
                font-size: 2.2rem;
            }
            .welcome-subtitle {
                font-size: 1rem;
            }
            .service-card {
                margin-bottom: 1rem;
            }
        }

        /* Container principal */
        .main-container {
            position: relative;
            z-index: 10;
        }

        /* Animation loading */
        .loading-animation {
            opacity: 0;
            animation: slideUp 0.6s ease-out forwards;
        }
    </style>
</head>
<body>

<!-- NAVBAR -->
<nav class="navbar navbar-expand-lg navbar-dark sticky-top shadow">
    <div class="container-fluid">
        <!-- Logo & Brand -->
        <a class="navbar-brand d-flex align-items-center" href="<%= ctx %>/home">
            <img src="<%= ctx %>/assets/img/logoBlue.png" alt="Logo" width="40" height="40" class="d-inline-block align-text-top me-2">
            <strong class="text-white">Bankati</strong>
        </a>

        <!-- Bouton toggle pour mobile -->
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <!-- Menu de navigation -->
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                <li class="nav-item">
                    <a class="nav-link text-white fw-bold active" href="<%= ctx %>/home">
                        <i class="bi bi-house-fill me-1"></i> Accueil
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link text-white fw-bold" href="<%= ctx %>/credit">
                        <i class="bi bi-bank2 me-1"></i> Mes crédits
                    </a>
                </li>
            </ul>

            <!-- Infos utilisateur -->
            <div class="dropdown d-flex align-items-center">
                <a class="btn btn-outline-light dropdown-toggle"
                   href="#" role="button" id="dropdownUserMenu" data-bs-toggle="dropdown" aria-expanded="false">
                    <i class="bi bi-person-circle me-1"></i> <%= connectedUser.getFirstName() + " " + connectedUser.getLastName() %>
                </a>
                <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="dropdownUserMenu">
                    <li><span class="dropdown-item-text fw-bold text-primary"><%= connectedUser.getRole() %></span></li>
                    <li><hr class="dropdown-divider"></li>
                    <li><a class="dropdown-item" href="#"><i class="bi bi-person me-1"></i> Mon profil</a></li>
                    <li><a class="dropdown-item" href="#"><i class="bi bi-gear me-1"></i> Paramètres</a></li>
                    <li><hr class="dropdown-divider"></li>
                    <li>
                        <a class="dropdown-item text-danger logout-btn fw-bold" href="<%= ctx %>/logout">
                            <i class="bi bi-box-arrow-right me-1"></i> Déconnexion
                        </a>
                    </li>
                </ul>
            </div>
        </div>
    </div>
</nav>

<!-- CONTENU PRINCIPAL -->
<div class="container-fluid main-container">

    <!-- Hero Section -->
    <div class="welcome-hero">
        <div class="container">
            <h1 class="welcome-title">Bienvenue, <%= connectedUser.getFirstName() %> ! 👋</h1>
            <p class="welcome-subtitle">Gérez vos finances en toute simplicité avec Bankati</p>
            <a href="<%= ctx %>/credit" class="btn btn-primary-custom btn-lg">
                <i class="bi bi-bank2 me-2"></i>Accéder à mes crédits
            </a>
        </div>
    </div>

    <!-- Services rapides -->
    <div class="container mb-5">
        <div class="row">
            <div class="col-12 text-center mb-4">
                <h2 class="text-white fw-bold">Services disponibles</h2>
                <p class="text-white-50">Découvrez nos services bancaires</p>
            </div>
        </div>

        <div class="row g-4 loading-animation">
            <div class="col-lg-4 col-md-6">
                <a href="<%= ctx %>/credit" class="service-card">
                    <i class="bi bi-credit-card service-icon"></i>
                    <h4 class="service-title">Mes Crédits</h4>
                    <p class="service-description">Consultez et gérez vos demandes de crédit en cours et historique</p>
                </a>
            </div>

            <div class="col-lg-4 col-md-6">
                <a href="#" class="service-card">
                    <i class="bi bi-graph-up service-icon"></i>
                    <h4 class="service-title">Mes Finances</h4>
                    <p class="service-description">Suivez l'évolution de vos comptes et vos investissements</p>
                </a>
            </div>

            <div class="col-lg-4 col-md-6">
                <a href="#" class="service-card">
                    <i class="bi bi-telephone service-icon"></i>
                    <h4 class="service-title">Support Client</h4>
                    <p class="service-description">Contactez notre équipe pour toute assistance personnalisée</p>
                </a>
            </div>
        </div>
    </div>

    <!-- Statistiques utilisateur (si disponibles) -->
    <div class="container mb-5">
        <div class="user-stats loading-animation">
            <div class="row">
                <div class="col-12 text-center mb-3">
                    <h3 class="text-white fw-bold">Votre profil en un coup d'œil</h3>
                </div>
            </div>
            <div class="row">
                <div class="col-md-4">
                    <div class="stat-item">
                        <span class="stat-number">0</span>
                        <div class="stat-label">Crédits actifs</div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="stat-item">
                        <span class="stat-number">0</span>
                        <div class="stat-label">Demandes en cours</div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="stat-item">
                        <span class="stat-number" id="memberSince">2025</span>
                        <div class="stat-label">Membre depuis</div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Actions rapides -->
    <div class="container mb-5">
        <div class="dashboard-card loading-animation">
            <div class="row p-4">
                <div class="col-12 text-center mb-4">
                    <h3 class="text-white fw-bold">
                        <i class="bi bi-lightning-fill text-warning me-2"></i>Actions Rapides
                    </h3>
                </div>
                <div class="col-md-6 mb-3">
                    <a href="<%= ctx %>/credit" class="btn btn-outline-light w-100 p-3">
                        <i class="bi bi-plus-circle me-2"></i>
                        <strong>Nouvelle Demande de Crédit</strong>
                    </a>
                </div>
                <div class="col-md-6 mb-3">
                    <a href="#" class="btn btn-outline-light w-100 p-3">
                        <i class="bi bi-file-earmark-text me-2"></i>
                        <strong>Mes Documents</strong>
                    </a>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- FOOTER -->
<footer class="footer">
    <div class="container">
        <div class="row align-items-center">
            <div class="col-md-6">
                <span class="text-muted">
                    <strong style="color: #ffffff;">Bankati</strong> © 2025 - Tous droits réservés
                </span>
            </div>
            <div class="col-md-6 text-end">
                <small class="text-muted">Dernière connexion: <%= new java.util.Date() %></small>
            </div>
        </div>
    </div>
</footer>

<!-- Scripts -->
<script>
    // Animation au chargement
    document.addEventListener('DOMContentLoaded', function() {
        // Animation des cartes
        const loadingElements = document.querySelectorAll('.loading-animation');
        loadingElements.forEach((element, index) => {
            setTimeout(() => {
                element.style.opacity = '1';
                element.style.transform = 'translateY(0)';
            }, index * 300);
        });

        // Animation des cartes dashboard
        const dashboardCards = document.querySelectorAll('.dashboard-card');
        dashboardCards.forEach((card, index) => {
            setTimeout(() => {
                card.style.opacity = '1';
                card.style.transform = 'translateY(0)';
            }, (index + 2) * 200);
        });

        // Animation des statistiques
        animateStats();
    });

    // Animation des statistiques
    function animateStats() {
        const statNumbers = document.querySelectorAll('.stat-number');
        statNumbers.forEach(stat => {
            if (stat.id === 'memberSince') return; // Skip year animation

            const finalValue = parseInt(stat.textContent) || 0;
            let currentValue = 0;
            const increment = Math.max(1, Math.ceil(finalValue / 50));

            const timer = setInterval(() => {
                currentValue += increment;
                if (currentValue >= finalValue) {
                    currentValue = finalValue;
                    clearInterval(timer);
                }
                stat.textContent = currentValue;
            }, 30);
        });
    }

    // Effet de hover sur les cartes de service
    document.querySelectorAll('.service-card').forEach(card => {
        card.addEventListener('mouseenter', function() {
            this.style.transform = 'translateY(-8px) scale(1.02)';
        });

        card.addEventListener('mouseleave', function() {
            this.style.transform = 'translateY(0) scale(1)';
        });
    });

    // Console log pour debug (à retirer en production)
    console.log('Bankati Client Dashboard loaded successfully');
</script>

</body>
</html>