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
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Mes Demandes de Crédit | Bankati</title>
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

    /* Main container */
    .main-container {
      position: relative;
      z-index: 10;
      padding-top: 2rem;
      padding-bottom: 2rem;
    }

    /* Page header */
    .page-header {
      text-align: center;
      padding: 2rem 0 3rem 0;
      position: relative;
      z-index: 10;
    }

    .page-title {
      font-size: 2.5rem;
      font-weight: 700;
      color: #ffffff;
      text-shadow: 0 2px 20px rgba(0, 0, 0, 0.3);
      margin-bottom: 0.5rem;
      animation: fadeInUp 1s ease-out;
    }

    .page-subtitle {
      color: rgba(255, 255, 255, 0.8);
      font-size: 1.1rem;
      font-weight: 400;
      animation: fadeInUp 1s ease-out 0.2s both;
    }

    /* Breadcrumb */
    .breadcrumb {
      background: rgba(255, 255, 255, 0.1);
      backdrop-filter: blur(10px);
      border-radius: 50px;
      padding: 0.7rem 1.5rem;
      margin-bottom: 2rem;
      border: 1px solid rgba(255, 255, 255, 0.15);
    }

    .breadcrumb-item a {
      color: rgba(255, 255, 255, 0.8);
      text-decoration: none;
      transition: color 0.3s ease;
    }

    .breadcrumb-item a:hover {
      color: #ffffff;
    }

    .breadcrumb-item.active {
      color: #ffffff;
    }

    .breadcrumb-item + .breadcrumb-item::before {
      color: rgba(255, 255, 255, 0.6);
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
      margin-bottom: 2rem;
    }

    .dashboard-card:hover {
      transform: translateY(-5px);
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

    .card-header {
      background: rgba(255, 255, 255, 0.15);
      border-bottom: 1px solid rgba(255, 255, 255, 0.1);
      border-radius: 20px 20px 0 0 !important;
      padding: 1.5rem 2rem;
    }

    .card-body {
      padding: 2rem;
    }

    .card-title {
      color: #ffffff;
      font-weight: 600;
      font-size: 1.3rem;
      margin-bottom: 0;
    }

    /* Form styling */
    .form-label {
      color: rgba(255, 255, 255, 0.9);
      font-weight: 500;
      margin-bottom: 0.7rem;
    }

    .form-control {
      background: rgba(255, 255, 255, 0.1);
      border: 1px solid rgba(255, 255, 255, 0.2);
      border-radius: 12px;
      color: #ffffff;
      padding: 0.8rem 1rem;
      font-size: 1rem;
      transition: all 0.3s ease;
    }

    .form-control:focus {
      background: rgba(255, 255, 255, 0.15);
      border-color: rgba(255, 255, 255, 0.4);
      box-shadow: 0 0 0 0.2rem rgba(255, 255, 255, 0.1);
      color: #ffffff;
    }

    .form-control::placeholder {
      color: rgba(255, 255, 255, 0.6);
    }

    .input-group-text {
      background: rgba(255, 255, 255, 0.1);
      border: 1px solid rgba(255, 255, 255, 0.2);
      color: rgba(255, 255, 255, 0.8);
      border-radius: 12px;
    }

    .form-text {
      color: rgba(255, 255, 255, 0.7);
      font-size: 0.9rem;
    }

    /* Buttons */
    .btn-primary {
      background: linear-gradient(135deg, #0066cc, #004499);
      border: none;
      border-radius: 12px;
      padding: 0.8rem 2rem;
      font-weight: 600;
      font-size: 1rem;
      transition: all 0.3s ease;
      box-shadow: 0 4px 15px rgba(0, 102, 204, 0.3);
    }

    .btn-primary:hover {
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

    /* Table styling */
    .table {
      color: #ffffff;
      border-collapse: separate;
      border-spacing: 0;
    }

    .table thead th {
      background: rgba(255, 255, 255, 0.1);
      border-bottom: 2px solid rgba(255, 255, 255, 0.2);
      font-weight: 600;
      color: #ffffff;
      padding: 1rem;
      border: none;
    }

    .table tbody tr {
      transition: all 0.2s ease;
      background: rgba(255, 255, 255, 0.05);
    }

    .table tbody tr:hover {
      background: rgba(255, 255, 255, 0.1);
      transform: scale(1.01);
    }

    .table tbody td {
      padding: 1rem;
      border: none;
      border-top: 1px solid rgba(255, 255, 255, 0.1);
    }

    /* Status badges */
    .status-badge {
      padding: 6px 15px;
      border-radius: 25px;
      font-size: 0.85rem;
      font-weight: 500;
      display: inline-flex;
      align-items: center;
      gap: 0.4rem;
    }

    .status-pending {
      background: rgba(255, 193, 7, 0.2);
      color: #ffc107;
      border: 1px solid rgba(255, 193, 7, 0.3);
    }

    .status-approved {
      background: rgba(25, 135, 84, 0.2);
      color: #20c997;
      border: 1px solid rgba(25, 135, 84, 0.3);
    }

    .status-rejected {
      background: rgba(220, 53, 69, 0.2);
      color: #dc3545;
      border: 1px solid rgba(220, 53, 69, 0.3);
    }

    /* Action buttons */
    .action-btn {
      width: 35px;
      height: 35px;
      display: inline-flex;
      align-items: center;
      justify-content: center;
      border-radius: 50%;
      border: 1px solid rgba(255, 255, 255, 0.2);
      background: rgba(255, 255, 255, 0.1);
      color: #ffffff;
      transition: all 0.3s ease;
      margin: 0 0.2rem;
    }

    .action-btn:hover {
      transform: translateY(-2px) scale(1.1);
      box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
    }

    .btn-outline-danger:hover {
      background: rgba(220, 53, 69, 0.2);
      border-color: #dc3545;
      color: #dc3545;
    }

    .btn-outline-success:hover {
      background: rgba(25, 135, 84, 0.2);
      border-color: #20c997;
      color: #20c997;
    }

    .btn-outline-secondary:hover {
      background: rgba(108, 117, 125, 0.2);
      border-color: #6c757d;
      color: #6c757d;
    }

    /* Badge counter */
    .badge {
      background: rgba(255, 255, 255, 0.2);
      color: #ffffff;
      padding: 0.5rem 1rem;
      border-radius: 50px;
      font-weight: 500;
      border: 1px solid rgba(255, 255, 255, 0.2);
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

    /* Loading animation */
    .loading-animation {
      opacity: 0;
      animation: slideUp 0.6s ease-out forwards;
    }

    /* Empty state */
    .empty-state {
      text-align: center;
      padding: 3rem 2rem;
      color: rgba(255, 255, 255, 0.7);
    }

    .empty-state i {
      font-size: 4rem;
      margin-bottom: 1rem;
      opacity: 0.5;
    }

    /* Responsive */
    @media (max-width: 768px) {
      .page-title {
        font-size: 2rem;
      }
      .page-subtitle {
        font-size: 1rem;
      }
      .card-body {
        padding: 1.5rem;
      }
      .table-responsive {
        border-radius: 12px;
      }
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
          <a class="nav-link text-white fw-bold" href="<%= ctx %>/home">
            <i class="bi bi-house-fill me-1"></i> Accueil
          </a>
        </li>
        <li class="nav-item">
          <a class="nav-link text-white fw-bold active" href="<%= ctx %>/credit">
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

  <!-- Page Header -->
  <div class="page-header">
    <div class="container">
      <h1 class="page-title">Gestion des crédits 💳</h1>
      <p class="page-subtitle">Gérez vos demandes de crédit en toute simplicité</p>

      <!-- Breadcrumb -->
      <nav aria-label="breadcrumb" class="d-flex justify-content-center">
        <ol class="breadcrumb">
          <li class="breadcrumb-item"><a href="<%= ctx %>/home">Accueil</a></li>
          <li class="breadcrumb-item active" aria-current="page">Demandes de crédit</li>
        </ol>
      </nav>
    </div>
  </div>

  <div class="container">
    <div class="row justify-content-center">
      <div class="col-xl-10">

        <!-- Carte pour nouvelle demande -->
        <div class="dashboard-card loading-animation">
          <div class="card-header d-flex align-items-center">
            <h5 class="card-title mb-0"><i class="bi bi-plus-circle me-2"></i>Nouvelle demande de crédit</h5>
          </div>
          <div class="card-body">
            <form action="${pageContext.request.contextPath}/credit" method="post">
              <input type="hidden" name="action" value="ajouter" />
              <div class="mb-4">
                <label for="montant" class="form-label">Montant demandé (DH)</label>
                <div class="input-group">
                  <span class="input-group-text"><i class="bi bi-currency-exchange"></i></span>
                  <input type="number" name="montant" id="montant" class="form-control"
                         placeholder="Entrez le montant" required step="0.01" min="1000">
                  <span class="input-group-text">.00</span>
                </div>
                <div class="form-text">Le montant minimum est de 1,000 DH</div>
              </div>
              <div class="d-grid">
                <button type="submit" class="btn btn-primary btn-lg">
                  <i class="bi bi-send-check me-2"></i>Soumettre la demande
                </button>
              </div>
            </form>
          </div>
        </div>

        <!-- Carte pour historique des demandes -->
        <div class="dashboard-card loading-animation">
          <div class="card-header d-flex justify-content-between align-items-center">
            <h5 class="card-title mb-0"><i class="bi bi-clock-history me-2"></i>Historique des demandes</h5>
            <span class="badge">
              ${demandes.size()} demande(s)
            </span>
          </div>
          <div class="card-body p-0">
            <div class="table-responsive">
              <table class="table table-hover align-middle mb-0">
                <thead>
                <tr>
                  <th class="text-center">ID</th>
                  <th>Montant</th>
                  <th>Date</th>
                  <th class="text-center">État</th>
                  <th class="text-center">Actions</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${demandes}" var="demande">
                  <tr>
                    <td class="text-center fw-semibold">#${demande.id}</td>
                    <td>
                      <span class="fw-semibold">${demande.montant} DH</span>
                    </td>
                    <td>
                      <small class="text-white-50">${demande.dateDemande}</small>
                    </td>
                    <td class="text-center">
                      <c:choose>
                        <c:when test="${demande.etat == 'EN_ATTENTE'}">
                          <span class="status-badge status-pending">
                            <i class="bi bi-hourglass-split"></i>En attente
                          </span>
                        </c:when>
                        <c:when test="${demande.etat == 'APPROUVEE'}">
                          <span class="status-badge status-approved">
                            <i class="bi bi-check-circle"></i>Approuvée
                          </span>
                        </c:when>
                        <c:when test="${demande.etat == 'REFUSEE'}">
                          <span class="status-badge status-rejected">
                            <i class="bi bi-x-circle"></i>Refusée
                          </span>
                        </c:when>
                      </c:choose>
                    </td>
                    <td class="text-center">
                      <c:if test="${demande.etat == 'EN_ATTENTE'}">
                        <form action="${pageContext.request.contextPath}/credit" method="post" class="d-inline">
                          <input type="hidden" name="action" value="supprimer"/>
                          <input type="hidden" name="id" value="${demande.id}"/>
                          <button class="btn btn-sm btn-outline-danger action-btn" type="submit"
                                  data-bs-toggle="tooltip" title="Annuler la demande">
                            <i class="bi bi-trash"></i>
                          </button>
                        </form>

                        <c:if test="${connectedUser.role == 'ADMIN'}">
                          <form action="${pageContext.request.contextPath}/credit" method="post" class="d-inline">
                            <input type="hidden" name="action" value="approuver"/>
                            <input type="hidden" name="id" value="${demande.id}"/>
                            <button class="btn btn-sm btn-outline-success action-btn" type="submit"
                                    data-bs-toggle="tooltip" title="Approuver">
                              <i class="bi bi-check-lg"></i>
                            </button>
                          </form>
                          <form action="${pageContext.request.contextPath}/credit" method="post" class="d-inline">
                            <input type="hidden" name="action" value="refuser"/>
                            <input type="hidden" name="id" value="${demande.id}"/>
                            <button class="btn btn-sm btn-outline-secondary action-btn" type="submit"
                                    data-bs-toggle="tooltip" title="Refuser">
                              <i class="bi bi-x-lg"></i>
                            </button>
                          </form>
                        </c:if>
                      </c:if>
                    </td>
                  </tr>
                </c:forEach>
                <c:if test="${empty demandes}">
                  <tr>
                    <td colspan="5" class="empty-state">
                      <i class="bi bi-info-circle"></i>
                      <p class="mt-2 mb-0">Aucune demande de crédit trouvée</p>
                      <small>Commencez par créer votre première demande de crédit</small>
                    </td>
                  </tr>
                </c:if>
                </tbody>
              </table>
            </div>
          </div>
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
        <small class="text-muted">
          <a href="#" class="text-decoration-none text-white-50 me-3">Conditions d'utilisation</a>
          <a href="#" class="text-decoration-none text-white-50">Politique de confidentialité</a>
        </small>
      </div>
    </div>
  </div>
</footer>

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
      }, (index + 1) * 200);
    });

    // Activer les tooltips Bootstrap
    var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
    var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
      return new bootstrap.Tooltip(tooltipTriggerEl);
    });

    // Animation des lignes du tableau
    const tableRows = document.querySelectorAll('tbody tr');
    tableRows.forEach((row, index) => {
      setTimeout(() => {
        row.style.opacity = '1';
        row.style.transform = 'translateX(0)';
      }, 800 + (index * 100));
    });
  });

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