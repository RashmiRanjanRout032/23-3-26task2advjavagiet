<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Hospital MS — Login</title>
    <link href="https://fonts.googleapis.com/css2?family=DM+Serif+Display&family=DM+Sans:wght@300;400;500;600&display=swap" rel="stylesheet"/>
    <style>
        *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }

        :root {
            --navy: #0a1628;
            --navy-mid: #112240;
            --teal: #0fb8a9;
            --teal-dark: #0a9689;
            --gold: #f5a623;
            --text: #e8edf5;
            --text-muted: #8a9bb8;
            --card-bg: rgba(17,34,64,0.85);
            --border: rgba(15,184,169,0.2);
        }

        body {
            min-height: 100vh;
            background: var(--navy);
            display: flex;
            align-items: center;
            justify-content: center;
            font-family: 'DM Sans', sans-serif;
            overflow: hidden;
            position: relative;
        }

        /* Animated background */
        body::before {
            content: '';
            position: fixed;
            inset: 0;
            background:
                radial-gradient(ellipse 80% 60% at 20% 20%, rgba(15,184,169,0.12) 0%, transparent 60%),
                radial-gradient(ellipse 60% 80% at 80% 80%, rgba(245,166,35,0.06) 0%, transparent 60%);
            pointer-events: none;
        }

        /* Grid lines decoration */
        body::after {
            content: '';
            position: fixed;
            inset: 0;
            background-image:
                linear-gradient(rgba(15,184,169,0.04) 1px, transparent 1px),
                linear-gradient(90deg, rgba(15,184,169,0.04) 1px, transparent 1px);
            background-size: 60px 60px;
            pointer-events: none;
        }

        .login-wrapper {
            position: relative;
            z-index: 10;
            width: 100%;
            max-width: 420px;
            padding: 20px;
        }

        .brand {
            text-align: center;
            margin-bottom: 36px;
        }

        .brand-icon {
            width: 64px;
            height: 64px;
            background: linear-gradient(135deg, var(--teal), var(--teal-dark));
            border-radius: 18px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            font-size: 30px;
            margin-bottom: 16px;
            box-shadow: 0 8px 32px rgba(15,184,169,0.35);
            animation: pulse 3s ease-in-out infinite;
        }

        @keyframes pulse {
            0%, 100% { box-shadow: 0 8px 32px rgba(15,184,169,0.35); }
            50%       { box-shadow: 0 8px 48px rgba(15,184,169,0.55); }
        }

        .brand h1 {
            font-family: 'DM Serif Display', serif;
            font-size: 28px;
            color: var(--text);
            letter-spacing: -0.5px;
        }

        .brand p {
            font-size: 13px;
            color: var(--text-muted);
            margin-top: 4px;
            letter-spacing: 0.5px;
        }

        .card {
            background: var(--card-bg);
            border: 1px solid var(--border);
            border-radius: 20px;
            padding: 36px 32px;
            backdrop-filter: blur(20px);
            box-shadow: 0 24px 64px rgba(0,0,0,0.4);
        }

        .card h2 {
            font-family: 'DM Serif Display', serif;
            font-size: 22px;
            color: var(--text);
            margin-bottom: 6px;
        }

        .card .subtitle {
            font-size: 13px;
            color: var(--text-muted);
            margin-bottom: 28px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        label {
            display: block;
            font-size: 12px;
            font-weight: 600;
            color: var(--teal);
            letter-spacing: 0.8px;
            text-transform: uppercase;
            margin-bottom: 8px;
        }

        input[type="text"], input[type="password"] {
            width: 100%;
            background: rgba(255,255,255,0.04);
            border: 1px solid var(--border);
            border-radius: 10px;
            padding: 12px 16px;
            color: var(--text);
            font-family: 'DM Sans', sans-serif;
            font-size: 15px;
            transition: border-color 0.2s, box-shadow 0.2s;
            outline: none;
        }

        input[type="text"]:focus, input[type="password"]:focus {
            border-color: var(--teal);
            box-shadow: 0 0 0 3px rgba(15,184,169,0.15);
        }

        input::placeholder { color: rgba(138,155,184,0.5); }

        .btn-login {
            width: 100%;
            background: linear-gradient(135deg, var(--teal), var(--teal-dark));
            color: #fff;
            border: none;
            border-radius: 10px;
            padding: 14px;
            font-family: 'DM Sans', sans-serif;
            font-size: 15px;
            font-weight: 600;
            cursor: pointer;
            transition: transform 0.15s, box-shadow 0.15s;
            margin-top: 8px;
            letter-spacing: 0.3px;
        }

        .btn-login:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 24px rgba(15,184,169,0.4);
        }

        .btn-login:active { transform: translateY(0); }

        .alert {
            border-radius: 10px;
            padding: 12px 16px;
            font-size: 13px;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .alert-error {
            background: rgba(239,68,68,0.12);
            border: 1px solid rgba(239,68,68,0.3);
            color: #f87171;
        }

        .alert-success {
            background: rgba(15,184,169,0.1);
            border: 1px solid rgba(15,184,169,0.3);
            color: var(--teal);
        }

        .demo-creds {
            margin-top: 24px;
            padding: 16px;
            background: rgba(255,255,255,0.03);
            border: 1px dashed rgba(138,155,184,0.2);
            border-radius: 10px;
        }

        .demo-creds p {
            font-size: 11px;
            color: var(--text-muted);
            margin-bottom: 8px;
            text-transform: uppercase;
            letter-spacing: 0.6px;
            font-weight: 600;
        }

        .cred-row {
            display: flex;
            justify-content: space-between;
            font-size: 12px;
            color: var(--text-muted);
            padding: 3px 0;
        }

        .cred-row span:last-child {
            color: var(--gold);
            font-family: 'DM Mono', monospace;
            font-weight: 500;
        }
    </style>
</head>
<body>

<div class="login-wrapper">
    <div class="brand">
        <div class="brand-icon">🏥</div>
        <h1>MediCare HMS</h1>
        <p>Hospital Management System</p>
    </div>

    <div class="card">
        <h2>Welcome back</h2>
        <p class="subtitle">Sign in to your account to continue</p>

        <% if ("true".equals(request.getParameter("error"))) { %>
        <div class="alert alert-error">
            ⚠️ Invalid username or password. Please try again.
        </div>
        <% } %>

        <% if ("true".equals(request.getParameter("logout"))) { %>
        <div class="alert alert-success">
            ✓ You have been logged out successfully.
        </div>
        <% } %>

        <form action="/login" method="post">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>

            <div class="form-group">
                <label>Username</label>
                <input type="text" name="username" placeholder="Enter your username" required autofocus/>
            </div>

            <div class="form-group">
                <label>Password</label>
                <input type="password" name="password" placeholder="Enter your password" required/>
            </div>

            <button type="submit" class="btn-login">Sign In →</button>
        </form>

        <div class="demo-creds">
            <p>Demo Credentials</p>
            <div class="cred-row"><span>Admin</span><span>admin / admin123</span></div>
            <div class="cred-row"><span>Receptionist</span><span>receptionist / recep123</span></div>
        </div>
    </div>
</div>

</body>
</html>
