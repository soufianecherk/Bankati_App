<%@ page contentType="text/html;charset=UTF-8" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
	var ctx = request.getContextPath();
	var connectedUser = (ma.bankati.model.users.User) session.getAttribute("connectedUser");
	var appName = (String) application.getAttribute("AppName");
%>

<!DOCTYPE html>
<html lang="fr">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Utilisateurs - <%=appName%> Admin</title>
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

		/* Container principal */
		.main-container {
			position: relative;
			z-index: 10;
		}

		/* Titre de page */
		.page-title {
			font-size: 2.5rem;
			font-weight: 700;
			color: #ffffff;
			text-shadow: 0 2px 10px rgba(0, 0, 0, 0.3);
			margin-bottom: 2rem;
			text-align: center;
		}

		/* Cards glassmorphism */
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

		/* Table glassmorphism */
		.glass-table {
			background: rgba(255, 255, 255, 0.1);
			backdrop-filter: blur(20px);
			border: 1px solid rgba(255, 255, 255, 0.15);
			border-radius: 20px;
			overflow: hidden;
			box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
			margin-bottom: 2rem;
		}

		.glass-table thead {
			background: rgba(255, 255, 255, 0.15);
		}

		.glass-table th {
			color: #ffffff !important;
			font-weight: 600;
			padding: 16px;
			border: none;
			text-transform: uppercase;
			font-size: 0.85rem;
			letter-spacing: 0.5px;
			text-shadow: 0 1px 5px rgba(0, 0, 0, 0.3);
		}

		.glass-table td {
			color: #ffffff !important;
			padding: 16px;
			border: none;
			border-bottom: 1px solid rgba(255, 255, 255, 0.1);
			vertical-align: middle;
			font-weight: 500;
		}

		.glass-table tbody tr {
			transition: all 0.3s ease;
		}

		.glass-table tbody tr:hover {
			background: rgba(255, 255, 255, 0.1);
			transform: translateY(-2px);
		}

		/* Boutons d'action */
		.action-btn {
			border: none;
			border-radius: 12px;
			padding: 8px 12px;
			transition: all 0.3s ease;
			font-weight: 500;
			margin: 0 2px;
			position: relative;
			overflow: hidden;
			color: white !important;
			text-decoration: none;
			display: inline-block;
		}

		.action-btn:hover {
			transform: translateY(-2px);
			box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
			color: white !important;
		}

		.btn-edit {
			background: linear-gradient(135deg, #ffc107, #ff8f00);
		}

		.btn-delete {
			background: linear-gradient(135deg, #dc3545, #b02a37);
		}

		/* Formulaire */
		.form-container {
			background: rgba(255, 255, 255, 0.1);
			backdrop-filter: blur(20px);
			border: 1px solid rgba(255, 255, 255, 0.15);
			border-radius: 20px;
			padding: 30px;
			box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
		}

		.form-title {
			color: #ffffff;
			font-weight: 600;
			text-align: center;
			margin-bottom: 25px;
			font-size: 1.4rem;
			text-shadow: 0 1px 5px rgba(0, 0, 0, 0.3);
		}

		.form-group {
			margin-bottom: 20px;
		}

		.input-group {
			background: rgba(255, 255, 255, 0.9);
			border-radius: 12px;
			overflow: hidden;
			border: 1px solid rgba(255, 255, 255, 0.3);
			transition: all 0.3s ease;
		}

		.input-group:focus-within {
			border-color: rgba(255, 255, 255, 0.5);
			box-shadow: 0 0 20px rgba(255, 255, 255, 0.2);
			transform: translateY(-1px);
		}

		.input-group-text {
			background: rgba(0, 102, 204, 0.1) !important;
			border: none;
			color: #0066cc;
		}

		.form-control, .form-select {
			border: none;
			background: transparent;
			font-weight: 500;
			padding: 12px 16px;
			color: #333;
		}

		.form-control:focus, .form-select:focus {
			border: none;
			box-shadow: none;
			background: transparent;
		}

		/* Badge pour le rôle */
		.role-badge {
			padding: 6px 12px;
			border-radius: 20px;
			font-size: 0.8rem;
			font-weight: 600;
			text-transform: uppercase;
		}

		.role-admin {
			background: linear-gradient(135deg, #dc3545, #b02a37);
			color: white;
		}

		.role-user {
			background: linear-gradient(135deg, #17a2b8, #138496);
			color: white;
		}

		/* Boutons */
		.btn-outline-light {
			background: rgba(255, 255, 255, 0.1);
			border-color: rgba(255, 255, 255, 0.2);
			border-radius: 12px;
			font-weight: 500;
			color: #ffffff !important;
		}

		.btn-outline-light:hover {
			background: rgba(255, 255, 255, 0.2);
			border-color: rgba(255, 255, 255, 0.3);
			color: #ffffff !important;
		}

		.btn-submit {
			background: linear-gradient(135deg, #28a745, #20c997);
			border: none;
			border-radius: 12px;
			padding: 12px 30px;
			font-weight: 600;
			color: white;
			transition: all 0.3s ease;
		}

		.btn-submit:hover {
			transform: translateY(-2px);
			box-shadow: 0 8px 25px rgba(40, 167, 69, 0.4);
			color: white;
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

		/* Textes */
		.text-muted {
			color: rgba(255, 255, 255, 0.6) !important;
		}

		.card-title {
			color: #ffffff !important;
			font-weight: 600;
		}

		/* Responsive */
		@media (max-width: 768px) {
			.page-title {
				font-size: 2rem;
			}
			.glass-table {
				font-size: 0.9rem;
			}
			.glass-table th,
			.glass-table td {
				padding: 12px 8px;
			}
		}
	</style>
</head>

<body class="Optima">

<!-- NAVBAR IDENTIQUE À HOME.JSP -->
<nav class="navbar navbar-expand-lg navbar-dark shadow">
	<div class="container-fluid">
		<!-- Logo & Brand -->
		<a class="navbar-brand d-flex align-items-center" href="<%= ctx %>/home">
			<img src="<%= ctx %>/assets/img/logoBlue.png" alt="Logo" width="40" height="40" class="d-inline-block align-text-top me-2">
			<strong class="text-white"><%=appName%> - Admin</strong>
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
					<a class="nav-link text-white fw-bold active" href="<%= ctx %>/users">
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
	<!-- Titre de page -->
	<div class="row mb-4">
		<div class="col-12">
			<h1 class="page-title">
				<i class="bi bi-people-fill me-2"></i>
				Gestion des Utilisateurs
			</h1>
		</div>
	</div>

	<!-- TABLE DES UTILISATEURS -->
	<div class="row mb-4">
		<div class="col-12">
			<div class="dashboard-card">
				<div class="card-body p-0">
					<div class="glass-table">
						<table class="table table-hover mb-0">
							<thead>
							<tr>
								<th class="text-center">
									<i class="bi bi-person me-1"></i>
									Nom
								</th>
								<th class="text-center">
									<i class="bi bi-person-badge me-1"></i>
									Prénom
								</th>
								<th class="text-center">
									<i class="bi bi-person-circle me-1"></i>
									Login
								</th>
								<th class="text-center">
									<i class="bi bi-shield-lock me-1"></i>
									Rôle
								</th>
								<th class="text-center">
									<i class="bi bi-gear me-1"></i>
									Actions
								</th>
							</tr>
							</thead>
							<tbody>
							<c:forEach items="${users}" var="user">
								<tr>
									<td class="text-center fw-bold">${user.lastName}</td>
									<td class="text-center fw-bold">${user.firstName}</td>
									<td class="text-center">${user.username}</td>
									<td class="text-center">
                                        <span class="role-badge ${user.role == 'ADMIN' ? 'role-admin' : 'role-user'}">
												${user.role}
										</span>
									</td>
									<td class="text-center">
										<a href="${pageContext.request.contextPath}/users/edit?id=${user.id}"
										   class="action-btn btn-edit">
											<i class="bi bi-pencil-fill"></i>
										</a>
										<a href="${pageContext.request.contextPath}/users/delete?id=${user.id}"
										   class="action-btn btn-delete">
											<i class="bi bi-trash-fill"></i>
										</a>
									</td>
								</tr>
							</c:forEach>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
	</div>

	<!-- FORMULAIRE -->
	<div class="row">
		<div class="col-12">
			<div class="dashboard-card">
				<div class="card-body">
					<div class="form-container">
						<h2 class="form-title">
							<c:choose>
								<c:when test="${not empty user}">
									<i class="bi bi-pencil-square me-2"></i>
									Modifier un utilisateur
								</c:when>
								<c:otherwise>
									<i class="bi bi-person-plus me-2"></i>
									Ajouter un nouveau utilisateur
								</c:otherwise>
							</c:choose>
						</h2>

						<!-- Bouton visible uniquement si on est en modification -->
						<c:if test="${not empty user}">
							<div class="text-center mb-4">
								<a href="${pageContext.request.contextPath}/users" class="btn btn-outline-light fw-bold">
									<i class="bi bi-person-plus-fill me-1"></i> Ajouter un nouvel utilisateur
								</a>
							</div>
						</c:if>

						<form action="${pageContext.request.contextPath}/users/save" method="post">
							<input type="hidden" name="id" value="${user.id}"/>

							<!-- Prénom -->
							<div class="form-group">
								<div class="input-group">
                                    <span class="input-group-text">
                                        <i class="bi bi-person-badge"></i>
                                    </span>
									<input type="text" class="form-control fw-bold" name="firstName"
										   placeholder="Prénom" value="${user.firstName}" required/>
								</div>
							</div>

							<!-- Nom -->
							<div class="form-group">
								<div class="input-group">
                                    <span class="input-group-text">
                                        <i class="bi bi-person"></i>
                                    </span>
									<input type="text" class="form-control fw-bold" name="lastName"
										   placeholder="Nom" value="${user.lastName}" required/>
								</div>
							</div>

							<!-- Nom d'utilisateur -->
							<div class="form-group">
								<div class="input-group">
                                    <span class="input-group-text">
                                        <i class="bi bi-person-circle"></i>
                                    </span>
									<input type="text" class="form-control fw-bold" name="username"
										   placeholder="Nom d'utilisateur" value="${user.username}" required/>
								</div>
							</div>

							<!-- Mot de passe -->
							<div class="form-group">
								<div class="input-group">
                                    <span class="input-group-text">
                                        <i class="bi bi-lock-fill"></i>
                                    </span>
									<input type="password" class="form-control fw-bold" name="password"
										   placeholder="Mot de passe" value="${user.password}" required/>
								</div>
							</div>

							<!-- Rôle -->
							<div class="form-group">
								<div class="input-group">
                                    <span class="input-group-text">
                                        <i class="bi bi-shield-lock"></i>
                                    </span>
									<select name="role" class="form-select fw-bold" required>
										<option value="ADMIN" ${user.role == 'ADMIN' ? 'selected' : ''}>ADMIN</option>
										<option value="USER"  ${user.role == 'USER'  ? 'selected' : ''}>USER</option>
									</select>
								</div>
							</div>

							<!-- Bouton Enregistrer -->
							<div class="text-center mt-4">
								<button type="submit" class="btn-submit">
									<i class="bi bi-save me-2"></i> Enregistrer
								</button>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<!-- FOOTER IDENTIQUE À HOME.JSP -->
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

		// Animation d'entrée progressive des lignes du tableau
		const rows = document.querySelectorAll('.glass-table tbody tr');
		rows.forEach((row, index) => {
			row.style.opacity = '0';
			row.style.transform = 'translateY(20px)';
			setTimeout(() => {
				row.style.transition = 'all 0.5s ease';
				row.style.opacity = '1';
				row.style.transform = 'translateY(0)';
			}, 500 + (index * 100));
		});

		// Animation des boutons d'action
		const actionBtns = document.querySelectorAll('.action-btn');
		actionBtns.forEach(btn => {
			btn.addEventListener('mouseenter', function() {
				const icon = this.querySelector('i');
				icon.style.transform = 'scale(1.2) rotate(5deg)';
				icon.style.transition = 'transform 0.3s ease';
			});

			btn.addEventListener('mouseleave', function() {
				const icon = this.querySelector('i');
				icon.style.transform = 'scale(1) rotate(0deg)';
			});
		});

		// Animation des champs de formulaire
		const inputs = document.querySelectorAll('.form-control, .form-select');
		inputs.forEach(input => {
			input.addEventListener('focus', function() {
				this.parentElement.style.transform = 'scale(1.02)';
			});

			input.addEventListener('blur', function() {
				this.parentElement.style.transform = 'scale(1)';
			});
		});
	});
</script>

</body>
</html>