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
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">
  <style>
    :root {
      --primary-color: #4361ee;
      --secondary-color: #3f37c9;
      --success-color: #4cc9f0;
      --light-bg: #f8f9fa;
      --dark-bg: #212529;
    }

    body {
      font-family: 'Poppins', sans-serif;
      background-color: #f5f7fa;
      color: #333;
    }

    .navbar {
      box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
      background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
    }

    .card {
      border: none;
      border-radius: 10px;
      box-shadow: 0 4px 20px rgba(0, 0, 0, 0.05);
      transition: transform 0.3s ease, box-shadow 0.3s ease;
    }

    .card:hover {
      transform: translateY(-5px);
      box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
    }

    .card-header {
      background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
      color: white;
      border-radius: 10px 10px 0 0 !important;
    }

    .btn-primary {
      background-color: var(--primary-color);
      border-color: var(--primary-color);
    }

    .btn-primary:hover {
      background-color: var(--secondary-color);
      border-color: var(--secondary-color);
    }

    .table {
      border-collapse: separate;
      border-spacing: 0;
    }

    .table thead th {
      background-color: #f1f5fd;
      border-bottom: 2px solid #e0e6ed;
      font-weight: 600;
    }

    .table tbody tr {
      transition: all 0.2s ease;
    }

    .table tbody tr:hover {
      background-color: #f8fafd;
      transform: scale(1.01);
    }

    .badge {
      padding: 6px 10px;
      font-weight: 500;
      font-size: 0.85rem;
      border-radius: 50px;
    }

    .input-group-text {
      background-color: #e9ecef;
    }

    footer {
      background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
      box-shadow: 0 -2px 10px rgba(0, 0, 0, 0.1);
    }

    .status-badge {
      padding: 5px 12px;
      border-radius: 20px;
      font-size: 0.8rem;
      font-weight: 500;
    }

    .status-pending {
      background-color: #fff3cd;
      color: #856404;
    }

    .status-approved {
      background-color: #d4edda;
      color: #155724;
    }

    .status-rejected {
      background-color: #f8d7da;
      color: #721c24;
    }

    .action-btn {
      width: 32px;
      height: 32px;
      display: inline-flex;
      align-items: center;
      justify-content: center;
      border-radius: 50%;
    }

    .logo-text {
      font-weight: 700;
      letter-spacing: 0.5px;
    }
  </style>
</head>
<body>

<!-- Barre de navigation améliorée -->
<nav class="navbar navbar-expand-lg navbar-dark sticky-top">
  <div class="container">
    <a class="navbar-brand d-flex align-items-center" href="<%= ctx %>/home">
      <img src="<%= ctx %>/assets/img/logoBlue.png" alt="Logo" width="35" class="me-2">
      <span class="logo-text">Bankati</span>
    </a>

    <div class="d-flex align-items-center">
      <div class="dropdown">
        <button class="btn btn-outline-light dropdown-toggle d-flex align-items-center" type="button"
                id="userDropdown" data-bs-toggle="dropdown" aria-expanded="false">
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

<!-- Contenu principal -->
<div class="container py-4">
  <div class="row mb-4">
    <div class="col-12">
      <h3 class="fw-bold text-dark mb-0">Gestion des crédits</h3>
      <nav aria-label="breadcrumb">
        <ol class="breadcrumb">
          <li class="breadcrumb-item"><a href="<%= ctx %>/home" class="text-decoration-none">Accueil</a></li>
          <li class="breadcrumb-item active" aria-current="page">Demandes de crédit</li>
        </ol>
      </nav>
    </div>
  </div>

  <div class="row">
    <div class="col-lg-8 mx-auto">
      <!-- Carte pour nouvelle demande -->
      <div class="card mb-4">
        <div class="card-header py-3">
          <h5 class="mb-0 fw-bold"><i class="bi bi-plus-circle me-2"></i>Nouvelle demande de crédit</h5>
        </div>
        <div class="card-body">
          <form action="${pageContext.request.contextPath}/credit" method="post">
            <input type="hidden" name="action" value="ajouter" />
            <div class="mb-3">
              <label for="montant" class="form-label fw-semibold">Montant demandé (DH)</label>
              <div class="input-group">
                <span class="input-group-text bg-light"><i class="bi bi-currency-exchange"></i></span>
                <input type="number" name="montant" id="montant" class="form-control"
                       placeholder="Entrez le montant" required step="0.01" min="1000">
                <span class="input-group-text bg-light">.00</span>
              </div>
              <div class="form-text">Le montant minimum est de 1,000 DH</div>
            </div>
            <div class="d-grid">
              <button type="submit" class="btn btn-primary fw-semibold py-2">
                <i class="bi bi-send-check me-2"></i>Soumettre la demande
              </button>
            </div>
          </form>
        </div>
      </div>

      <!-- Carte pour historique des demandes -->
      <div class="card">
        <div class="card-header py-3 d-flex justify-content-between align-items-center">
          <h5 class="mb-0 fw-bold"><i class="bi bi-clock-history me-2"></i>Historique des demandes</h5>
          <span class="badge bg-light text-dark fs-6">
                        ${demandes.size()} demande(s)
                    </span>
        </div>
        <div class="card-body p-0">
          <div class="table-responsive">
            <table class="table table-hover align-middle mb-0">
              <thead class="table-light">
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
                    <small class="text-muted">${demande.dateDemande}</small>
                  </td>
                  <td class="text-center">
                    <c:choose>
                      <c:when test="${demande.etat == 'EN_ATTENTE'}">
                                                    <span class="status-badge status-pending">
                                                        <i class="bi bi-hourglass-split me-1"></i>En attente
                                                    </span>
                      </c:when>
                      <c:when test="${demande.etat == 'APPROUVEE'}">
                                                    <span class="status-badge status-approved">
                                                        <i class="bi bi-check-circle me-1"></i>Approuvée
                                                    </span>
                      </c:when>
                      <c:when test="${demande.etat == 'REFUSEE'}">
                                                    <span class="status-badge status-rejected">
                                                        <i class="bi bi-x-circle me-1"></i>Refusée
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
                        <form action="${pageContext.request.contextPath}/credit" method="post" class="d-inline ms-1">
                          <input type="hidden" name="action" value="approuver"/>
                          <input type="hidden" name="id" value="${demande.id}"/>
                          <button class="btn btn-sm btn-outline-success action-btn" type="submit"
                                  data-bs-toggle="tooltip" title="Approuver">
                            <i class="bi bi-check-lg"></i>
                          </button>
                        </form>
                        <form action="${pageContext.request.contextPath}/credit" method="post" class="d-inline ms-1">
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
                  <td colspan="5" class="text-center py-4 text-muted">
                    <i class="bi bi-info-circle fs-4"></i>
                    <p class="mt-2 mb-0">Aucune demande de crédit trouvée</p>
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

<!-- Pied de page -->
<footer class="mt-5 py-3">
  <div class="container">
    <div class="row">
      <div class="col-md-6 text-center text-md-start">
        <small>&copy; 2025 <strong>Bankati</strong>. Tous droits réservés.</small>
      </div>
      <div class="col-md-6 text-center text-md-end">
        <small class="text-white-50">
          <a href="#" class="text-decoration-none text-white me-2">Conditions d'utilisation</a>
          <a href="#" class="text-decoration-none text-white">Politique de confidentialité</a>
        </small>
      </div>
    </div>
  </div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
  // Activer les tooltips Bootstrap
  document.addEventListener('DOMContentLoaded', function() {
    var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
    var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
      return new bootstrap.Tooltip(tooltipTriggerEl);
    });
  });
</script>
</body>
</html>