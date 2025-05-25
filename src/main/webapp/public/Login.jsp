<!DOCTYPE html>
<html lang="fr">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Bankati - Connexion</title>

  <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css/bootstrap.min.css">
  <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css/style.css">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">

  <style>
    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
    }

    body {
      font-family: 'Inter', sans-serif;
      height: 100vh;
      background: linear-gradient(135deg, rgba(0, 32, 96, 0.9), rgba(0, 64, 128, 0.8)),
      url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1000 1000"><defs><linearGradient id="bg" x1="0%" y1="0%" x2="100%" y2="100%"><stop offset="0%" style="stop-color:%23001f3f;stop-opacity:1" /><stop offset="100%" style="stop-color:%23003d7a;stop-opacity:1" /></linearGradient></defs><rect width="1000" height="1000" fill="url(%23bg)"/><g opacity="0.1"><circle cx="200" cy="200" r="100" fill="white"/><circle cx="800" cy="300" r="150" fill="white"/><circle cx="400" cy="700" r="80" fill="white"/><circle cx="700" cy="800" r="120" fill="white"/><rect x="100" y="500" width="200" height="100" rx="10" fill="white"/><rect x="600" y="100" width="250" height="120" rx="15" fill="white"/></g></svg>');
      background-size: cover;
      background-position: center;
      background-attachment: fixed;
      display: flex;
      align-items: center;
      justify-content: center;
      position: relative;
      overflow: hidden;
    }

    /* Particules flottantes */
    body::before {
      content: '';
      position: absolute;
      top: 0;
      left: 0;
      right: 0;
      bottom: 0;
      background-image:
              radial-gradient(circle at 20% 20%, rgba(255, 255, 255, 0.1) 1px, transparent 1px),
              radial-gradient(circle at 80% 30%, rgba(255, 255, 255, 0.08) 1px, transparent 1px),
              radial-gradient(circle at 40% 70%, rgba(255, 255, 255, 0.06) 1px, transparent 1px),
              radial-gradient(circle at 90% 80%, rgba(255, 255, 255, 0.1) 1px, transparent 1px);
      background-size: 200px 200px, 300px 300px, 250px 250px, 180px 180px;
      animation: float 20s infinite linear;
      pointer-events: none;
    }

    @keyframes float {
      0% { transform: translateY(0px) translateX(0px); }
      25% { transform: translateY(-10px) translateX(5px); }
      50% { transform: translateY(-5px) translateX(-5px); }
      75% { transform: translateY(-15px) translateX(3px); }
      100% { transform: translateY(0px) translateX(0px); }
    }

    .login-container {
      max-width: 500px;
      width: 95%;
      position: relative;
      z-index: 10;
    }

    .login-card {
      background: rgba(255, 255, 255, 0.95);
      backdrop-filter: blur(20px);
      border: 1px solid rgba(255, 255, 255, 0.2);
      border-radius: 20px;
      padding: 2rem 2.5rem;
      box-shadow:
              0 25px 50px rgba(0, 0, 0, 0.15),
              0 0 0 1px rgba(255, 255, 255, 0.1) inset;
      transform: translateY(0);
      transition: all 0.3s ease;
      animation: slideUp 0.8s ease-out;
    }

    @keyframes slideUp {
      from {
        opacity: 0;
        transform: translateY(30px);
      }
      to {
        opacity: 1;
        transform: translateY(0);
      }
    }

    .login-card:hover {
      transform: translateY(-5px);
      box-shadow:
              0 35px 70px rgba(0, 0, 0, 0.2),
              0 0 0 1px rgba(255, 255, 255, 0.15) inset;
    }

    .brand-header {
      text-align: center;
      margin-bottom: 2rem;
    }

    .brand-logo {
      width: 65px;
      height: 65px;
      background: linear-gradient(135deg, #0066cc, #003d7a);
      border-radius: 16px;
      display: flex;
      align-items: center;
      justify-content: center;
      margin: 0 auto 1rem;
      box-shadow: 0 8px 25px rgba(0, 102, 204, 0.3);
      animation: pulse 2s infinite;
    }

    @keyframes pulse {
      0%, 100% { transform: scale(1); }
      50% { transform: scale(1.05); }
    }

    .brand-logo i {
      font-size: 2rem;
      color: white;
    }

    .brand-title {
      font-size: 1.9rem;
      font-weight: 700;
      color: #002a5c;
      margin-bottom: 0.3rem;
      letter-spacing: -0.5px;
    }

    .brand-subtitle {
      color: #666;
      font-weight: 400;
      font-size: 0.9rem;
    }

    .form-group {
      margin-bottom: 1.2rem;
    }

    .input-wrapper {
      position: relative;
    }

    .input-group {
      position: relative;
      border-radius: 16px;
      overflow: hidden;
      background: #f8f9fa;
      border: 2px solid transparent;
      transition: all 0.3s ease;
    }

    .input-group:focus-within {
      background: white;
      border-color: #0066cc;
      box-shadow: 0 0 0 3px rgba(0, 102, 204, 0.1);
    }

    .input-group-text {
      background: transparent;
      border: none;
      padding: 1rem 1.2rem;
      color: #666;
    }

    .form-control {
      background: transparent;
      border: none;
      padding: 1rem 1.2rem 1rem 0;
      font-size: 1rem;
      color: #333;
      outline: none;
      box-shadow: none;
    }

    .form-control::placeholder {
      color: #999;
      font-weight: 400;
    }

    .form-control:focus {
      background: transparent;
      border: none;
      box-shadow: none;
      outline: none;
    }

    .error-message {
      color: #dc3545;
      font-size: 0.85rem;
      margin-top: 0.5rem;
      font-style: italic;
      display: block;
    }

    .global-message {
      background: linear-gradient(135deg, #fff5f5, #fed7d7);
      border: 1px solid #fc8181;
      color: #c53030;
      padding: 1rem;
      border-radius: 12px;
      margin-bottom: 1.5rem;
      font-size: 0.9rem;
      text-align: center;
    }

    .btn-login {
      width: 100%;
      background: linear-gradient(135deg, #0066cc, #0052a3);
      border: none;
      color: white;
      padding: 1rem;
      border-radius: 16px;
      font-size: 1.05rem;
      font-weight: 600;
      transition: all 0.3s ease;
      position: relative;
      overflow: hidden;
      margin-top: 0.5rem;
    }

    .btn-login::before {
      content: '';
      position: absolute;
      top: 0;
      left: -100%;
      width: 100%;
      height: 100%;
      background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
      transition: left 0.5s;
    }

    .btn-login:hover::before {
      left: 100%;
    }

    .btn-login:hover {
      background: linear-gradient(135deg, #0052a3, #003d7a);
      transform: translateY(-2px);
      box-shadow: 0 10px 25px rgba(0, 102, 204, 0.3);
    }

    .btn-login:active {
      transform: translateY(0);
    }

    /* Responsive */
    @media (max-width: 576px) {
      .login-card {
        padding: 2rem 1.5rem;
        margin: 1rem;
      }

      .brand-title {
        font-size: 1.8rem;
      }
    }

    /* Animation d'entrée pour les champs */
    .form-group {
      animation: fadeInUp 0.6s ease-out forwards;
      opacity: 0;
    }

    .form-group:nth-child(1) { animation-delay: 0.2s; }
    .form-group:nth-child(2) { animation-delay: 0.4s; }
    .form-group:nth-child(3) { animation-delay: 0.6s; }
    .form-group:nth-child(4) { animation-delay: 0.8s; }

    @keyframes fadeInUp {
      to {
        opacity: 1;
        transform: translateY(0);
      }
      from {
        opacity: 0;
        transform: translateY(20px);
      }
    }
  </style>
</head>
<body>
<div class="login-container">
  <div class="login-card">
    <div class="brand-header">
      <div class="brand-logo">
        <i class="bi bi-bank"></i>
      </div>
      <h1 class="brand-title">Bankati</h1>
      <p class="brand-subtitle">Votre banque digitale de confiance</p>
    </div>

    <form action="login" method="post" autocomplete="off">
      <% if (request.getAttribute("globalMessage") != null) { %>
      <div class="global-message">
        <%= request.getAttribute("globalMessage") %>
      </div>
      <% } %>

      <!-- Champ nom d'utilisateur -->
      <div class="form-group">
        <div class="input-wrapper">
          <div class="input-group">
                            <span class="input-group-text">
                                <i class="bi bi-person-fill"></i>
                            </span>
            <input type="text"
                   class="form-control"
                   name="lg"
                   placeholder="Nom d'utilisateur"
                   autocomplete="off">
          </div>
          <% if (request.getAttribute("usernameError") != null) { %>
          <span class="error-message">
                            <%= request.getAttribute("usernameError") %>
                        </span>
          <% } %>
        </div>
      </div>

      <!-- Champ mot de passe -->
      <div class="form-group">
        <div class="input-wrapper">
          <div class="input-group">
                            <span class="input-group-text">
                                <i class="bi bi-lock-fill"></i>
                            </span>
            <input type="password"
                   class="form-control"
                   name="pss"
                   placeholder="Mot de passe"
                   autocomplete="off">
          </div>
          <% if (request.getAttribute("passwordError") != null) { %>
          <span class="error-message">
                            <%= request.getAttribute("passwordError") %>
                        </span>
          <% } %>
        </div>
      </div>

      <!-- Bouton de connexion -->
      <div class="form-group">
        <button type="submit" class="btn btn-login">
          <i class="bi bi-box-arrow-in-right me-2"></i>
          Se connecter
        </button>
      </div>
    </form>
  </div>
</div>

<script>
  // Animation subtile au focus des champs
  document.querySelectorAll('.form-control').forEach(input => {
    input.addEventListener('focus', function() {
      this.closest('.input-group').style.transform = 'scale(1.02)';
    });

    input.addEventListener('blur', function() {
      this.closest('.input-group').style.transform = 'scale(1)';
    });
  });

  // Animation du bouton au clic
  document.querySelector('.btn-login').addEventListener('click', function(e) {
    const ripple = document.createElement('span');
    const rect = this.getBoundingClientRect();
    const size = Math.max(rect.width, rect.height);
    const x = e.clientX - rect.left - size / 2;
    const y = e.clientY - rect.top - size / 2;

    ripple.style.cssText = `
                position: absolute;
                width: ${size}px;
                height: ${size}px;
                left: ${x}px;
                top: ${y}px;
                background: rgba(255, 255, 255, 0.3);
                border-radius: 50%;
                transform: scale(0);
                animation: ripple 0.6s linear;
                pointer-events: none;
            `;

    this.appendChild(ripple);

    setTimeout(() => {
      ripple.remove();
    }, 600);
  });

  // Ajout du CSS pour l'animation ripple
  const style = document.createElement('style');
  style.textContent = `
            @keyframes ripple {
                to {
                    transform: scale(4);
                    opacity: 0;
                }
            }
        `;
  document.head.appendChild(style);
</script>
</body>
</html>