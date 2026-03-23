<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>${pageTitle} — MediCare HMS</title>
    <link href="https://fonts.googleapis.com/css2?family=DM+Serif+Display&family=DM+Sans:ital,wght@0,300;0,400;0,500;0,600;1,400&display=swap" rel="stylesheet"/>
    <style>
        *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }

        :root {
            --navy:       #0a1628;
            --navy-mid:   #112240;
            --navy-light: #1a3a5c;
            --teal:       #0fb8a9;
            --teal-dark:  #0a9689;
            --gold:       #f5a623;
            --red:        #ef4444;
            --green:      #10b981;
            --yellow:     #f59e0b;
            --text:       #e8edf5;
            --text-muted: #8a9bb8;
            --sidebar-w:  260px;
            --header-h:   64px;
            --border:     rgba(15,184,169,0.15);
            --card-bg:    rgba(17,34,64,0.7);
        }

        body {
            background: var(--navy);
            color: var(--text);
            font-family: 'DM Sans', sans-serif;
            display: flex;
            min-height: 100vh;
        }

        /* ── Sidebar ── */
        .sidebar {
            position: fixed;
            top: 0; left: 0;
            width: var(--sidebar-w);
            height: 100vh;
            background: var(--navy-mid);
            border-right: 1px solid var(--border);
            display: flex;
            flex-direction: column;
            z-index: 100;
            overflow-y: auto;
        }

        .sidebar-brand {
            padding: 24px 20px 20px;
            border-bottom: 1px solid var(--border);
        }

        .sidebar-brand .brand-icon {
            width: 44px; height: 44px;
            background: linear-gradient(135deg, var(--teal), var(--teal-dark));
            border-radius: 12px;
            display: flex; align-items: center; justify-content: center;
            font-size: 22px;
            margin-bottom: 10px;
        }

        .sidebar-brand h2 {
            font-family: 'DM Serif Display', serif;
            font-size: 18px;
            color: var(--text);
        }

        .sidebar-brand p {
            font-size: 11px;
            color: var(--text-muted);
            margin-top: 2px;
            letter-spacing: 0.4px;
        }

        .sidebar-role {
            margin: 16px 20px;
            padding: 8px 12px;
            background: rgba(15,184,169,0.08);
            border: 1px solid var(--border);
            border-radius: 8px;
            font-size: 11px;
            color: var(--teal);
            font-weight: 600;
            letter-spacing: 0.8px;
            text-transform: uppercase;
        }

        .sidebar-section {
            padding: 8px 12px 4px;
            font-size: 10px;
            color: var(--text-muted);
            text-transform: uppercase;
            letter-spacing: 1px;
            font-weight: 600;
            margin-top: 8px;
        }

        .sidebar nav a {
            display: flex;
            align-items: center;
            gap: 10px;
            padding: 10px 20px;
            color: var(--text-muted);
            text-decoration: none;
            font-size: 14px;
            font-weight: 500;
            border-left: 3px solid transparent;
            transition: all 0.15s;
        }

        .sidebar nav a:hover {
            color: var(--text);
            background: rgba(255,255,255,0.04);
            border-left-color: rgba(15,184,169,0.4);
        }

        .sidebar nav a.active {
            color: var(--teal);
            background: rgba(15,184,169,0.08);
            border-left-color: var(--teal);
        }

        .sidebar nav a .icon { font-size: 16px; width: 20px; text-align: center; }

        .sidebar-footer {
            margin-top: auto;
            padding: 16px 20px;
            border-top: 1px solid var(--border);
        }

        .user-info {
            display: flex;
            align-items: center;
            gap: 10px;
            margin-bottom: 12px;
        }

        .avatar {
            width: 36px; height: 36px;
            background: linear-gradient(135deg, var(--teal), var(--teal-dark));
            border-radius: 50%;
            display: flex; align-items: center; justify-content: center;
            font-size: 14px; font-weight: 700;
            color: #fff;
            flex-shrink: 0;
        }

        .user-info .name { font-size: 13px; font-weight: 600; color: var(--text); }
        .user-info .role-badge { font-size: 11px; color: var(--text-muted); }

        .btn-logout {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 6px;
            width: 100%;
            padding: 9px;
            background: rgba(239,68,68,0.1);
            border: 1px solid rgba(239,68,68,0.25);
            border-radius: 8px;
            color: #f87171;
            text-decoration: none;
            font-size: 13px;
            font-weight: 500;
            transition: all 0.15s;
        }

        .btn-logout:hover {
            background: rgba(239,68,68,0.18);
            border-color: rgba(239,68,68,0.5);
        }

        /* ── Main ── */
        .main-content {
            margin-left: var(--sidebar-w);
            flex: 1;
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }

        .topbar {
            height: var(--header-h);
            background: rgba(17,34,64,0.8);
            border-bottom: 1px solid var(--border);
            display: flex;
            align-items: center;
            padding: 0 28px;
            gap: 16px;
            backdrop-filter: blur(10px);
            position: sticky;
            top: 0;
            z-index: 50;
        }

        .topbar h1 {
            font-family: 'DM Serif Display', serif;
            font-size: 20px;
            color: var(--text);
            flex: 1;
        }

        .topbar .date {
            font-size: 12px;
            color: var(--text-muted);
        }

        /* ── Page body ── */
        .page-body {
            padding: 28px;
            flex: 1;
        }

        /* ── Cards ── */
        .card {
            background: var(--card-bg);
            border: 1px solid var(--border);
            border-radius: 16px;
            padding: 24px;
            backdrop-filter: blur(10px);
        }

        /* ── Stat Cards ── */
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
            gap: 16px;
            margin-bottom: 24px;
        }

        .stat-card {
            background: var(--card-bg);
            border: 1px solid var(--border);
            border-radius: 14px;
            padding: 20px;
            position: relative;
            overflow: hidden;
            transition: transform 0.2s;
        }

        .stat-card:hover { transform: translateY(-2px); }

        .stat-card::before {
            content: '';
            position: absolute;
            top: 0; right: 0;
            width: 80px; height: 80px;
            border-radius: 0 14px 0 80px;
            opacity: 0.08;
        }

        .stat-card.teal::before  { background: var(--teal); }
        .stat-card.gold::before  { background: var(--gold); }
        .stat-card.green::before { background: var(--green); }
        .stat-card.red::before   { background: var(--red); }

        .stat-icon {
            font-size: 24px;
            margin-bottom: 12px;
        }

        .stat-value {
            font-family: 'DM Serif Display', serif;
            font-size: 32px;
            color: var(--text);
            line-height: 1;
        }

        .stat-label {
            font-size: 12px;
            color: var(--text-muted);
            margin-top: 4px;
            font-weight: 500;
        }

        /* ── Buttons ── */
        .btn {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            padding: 9px 18px;
            border-radius: 8px;
            font-family: 'DM Sans', sans-serif;
            font-size: 13px;
            font-weight: 600;
            cursor: pointer;
            text-decoration: none;
            border: none;
            transition: all 0.15s;
            letter-spacing: 0.2px;
        }

        .btn-primary {
            background: linear-gradient(135deg, var(--teal), var(--teal-dark));
            color: #fff;
        }

        .btn-primary:hover { box-shadow: 0 4px 16px rgba(15,184,169,0.4); transform: translateY(-1px); }

        .btn-warning {
            background: rgba(245,166,35,0.12);
            border: 1px solid rgba(245,166,35,0.3);
            color: var(--gold);
        }

        .btn-warning:hover { background: rgba(245,166,35,0.2); }

        .btn-danger {
            background: rgba(239,68,68,0.1);
            border: 1px solid rgba(239,68,68,0.3);
            color: #f87171;
        }

        .btn-danger:hover { background: rgba(239,68,68,0.18); }

        .btn-sm { padding: 5px 12px; font-size: 12px; }

        /* ── Table ── */
        .table-wrapper {
            overflow-x: auto;
            border-radius: 12px;
            border: 1px solid var(--border);
        }

        table {
            width: 100%;
            border-collapse: collapse;
            font-size: 14px;
        }

        thead th {
            background: rgba(15,184,169,0.08);
            color: var(--teal);
            font-size: 11px;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.8px;
            padding: 13px 16px;
            text-align: left;
            border-bottom: 1px solid var(--border);
            white-space: nowrap;
        }

        tbody tr {
            border-bottom: 1px solid rgba(255,255,255,0.04);
            transition: background 0.1s;
        }

        tbody tr:last-child { border-bottom: none; }
        tbody tr:hover { background: rgba(255,255,255,0.03); }

        tbody td {
            padding: 12px 16px;
            color: var(--text);
            vertical-align: middle;
        }

        /* ── Badges ── */
        .badge {
            display: inline-block;
            padding: 3px 10px;
            border-radius: 20px;
            font-size: 11px;
            font-weight: 700;
            letter-spacing: 0.4px;
            text-transform: uppercase;
        }

        .badge-active    { background: rgba(16,185,129,0.12); color: var(--green); border: 1px solid rgba(16,185,129,0.3); }
        .badge-inactive  { background: rgba(239,68,68,0.1);   color: #f87171;      border: 1px solid rgba(239,68,68,0.3); }
        .badge-scheduled { background: rgba(15,184,169,0.1);  color: var(--teal);  border: 1px solid var(--border); }
        .badge-completed { background: rgba(16,185,129,0.12); color: var(--green); border: 1px solid rgba(16,185,129,0.3); }
        .badge-cancelled { background: rgba(239,68,68,0.1);   color: #f87171;      border: 1px solid rgba(239,68,68,0.3); }

        /* ── Forms ── */
        .form-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 20px; }
        .form-grid.single { grid-template-columns: 1fr; }
        .form-group { margin-bottom: 20px; }
        .form-group.full { grid-column: 1 / -1; }

        .form-label {
            display: block;
            font-size: 11px;
            font-weight: 700;
            color: var(--teal);
            letter-spacing: 0.8px;
            text-transform: uppercase;
            margin-bottom: 8px;
        }

        .form-control {
            width: 100%;
            background: rgba(255,255,255,0.04);
            border: 1px solid var(--border);
            border-radius: 8px;
            padding: 10px 14px;
            color: var(--text);
            font-family: 'DM Sans', sans-serif;
            font-size: 14px;
            outline: none;
            transition: border-color 0.2s, box-shadow 0.2s;
        }

        .form-control:focus {
            border-color: var(--teal);
            box-shadow: 0 0 0 3px rgba(15,184,169,0.12);
        }

        .form-control option { background: var(--navy-mid); }
        textarea.form-control { resize: vertical; min-height: 90px; }

        .field-error {
            font-size: 12px;
            color: #f87171;
            margin-top: 4px;
        }

        /* ── Alerts ── */
        .alert {
            padding: 12px 16px;
            border-radius: 10px;
            font-size: 13px;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .alert-success { background: rgba(16,185,129,0.1); border: 1px solid rgba(16,185,129,0.3); color: var(--green); }
        .alert-error   { background: rgba(239,68,68,0.1);  border: 1px solid rgba(239,68,68,0.3);  color: #f87171; }

        /* ── Page header ── */
        .page-header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 24px;
        }

        .page-header h2 {
            font-family: 'DM Serif Display', serif;
            font-size: 26px;
            color: var(--text);
        }

        .page-header p { font-size: 13px; color: var(--text-muted); margin-top: 2px; }

        /* ── Search bar ── */
        .search-bar {
            display: flex;
            gap: 10px;
            margin-bottom: 20px;
        }

        .search-bar input {
            flex: 1;
            background: rgba(255,255,255,0.04);
            border: 1px solid var(--border);
            border-radius: 8px;
            padding: 9px 14px;
            color: var(--text);
            font-family: 'DM Sans', sans-serif;
            font-size: 14px;
            outline: none;
        }

        .search-bar input:focus { border-color: var(--teal); }

        /* ── Responsive ── */
        @media (max-width: 768px) {
            .sidebar { transform: translateX(-100%); }
            .main-content { margin-left: 0; }
            .form-grid { grid-template-columns: 1fr; }
            .stats-grid { grid-template-columns: 1fr 1fr; }
        }
    </style>
</head>
<body>

<%-- Sidebar --%>
<aside class="sidebar">
    <div class="sidebar-brand">
        <div class="brand-icon">🏥</div>
        <h2>MediCare HMS</h2>
        <p>Hospital Management System</p>
    </div>

    <sec:authorize access="hasRole('ADMIN')">
        <div class="sidebar-role">⚡ Admin Panel</div>
        <div class="sidebar-section">Overview</div>
        <nav>
            <a href="/admin/dashboard" class="${currentPage == 'dashboard' ? 'active' : ''}">
                <span class="icon">📊</span> Dashboard
            </a>
        </nav>
        <div class="sidebar-section">Management</div>
        <nav>
            <a href="/admin/doctors" class="${currentPage == 'doctors' ? 'active' : ''}">
                <span class="icon">👨‍⚕️</span> Doctors
            </a>
            <a href="/admin/patients" class="${currentPage == 'patients' ? 'active' : ''}">
                <span class="icon">🧑‍🤝‍🧑</span> Patients
            </a>
        </nav>
    </sec:authorize>

    <sec:authorize access="hasRole('RECEPTIONIST')">
        <div class="sidebar-role">🗂 Receptionist</div>
        <div class="sidebar-section">Overview</div>
        <nav>
            <a href="/receptionist/dashboard" class="${currentPage == 'dashboard' ? 'active' : ''}">
                <span class="icon">📊</span> Dashboard
            </a>
        </nav>
        <div class="sidebar-section">Appointments</div>
        <nav>
            <a href="/receptionist/appointments" class="${currentPage == 'appointments' ? 'active' : ''}">
                <span class="icon">📅</span> Appointments
            </a>
        </nav>
        <div class="sidebar-section">Directory</div>
        <nav>
            <a href="/receptionist/doctors" class="${currentPage == 'rec-doctors' ? 'active' : ''}">
                <span class="icon">👨‍⚕️</span> Doctors
            </a>
            <a href="/receptionist/patients" class="${currentPage == 'rec-patients' ? 'active' : ''}">
                <span class="icon">🧑‍🤝‍🧑</span> Patients
            </a>
        </nav>
    </sec:authorize>

    <div class="sidebar-footer">
        <div class="user-info">
            <div class="avatar"><sec:authentication property="name" var="username"/>${username.substring(0,1).toUpperCase()}</div>
            <div>
                <div class="name"><sec:authentication property="name"/></div>
                <div class="role-badge">
                    <sec:authorize access="hasRole('ADMIN')">Administrator</sec:authorize>
                    <sec:authorize access="hasRole('RECEPTIONIST')">Receptionist</sec:authorize>
                </div>
            </div>
        </div>
        <a href="/logout" class="btn-logout">🚪 Sign Out</a>
    </div>
</aside>

<%-- Main Content --%>
<div class="main-content">
    <div class="topbar">
        <h1>${pageTitle}</h1>
        <span class="date" id="topbarDate"></span>
    </div>

    <div class="page-body">

        <c:if test="${not empty successMsg}">
            <div class="alert alert-success">✓ ${successMsg}</div>
        </c:if>
        <c:if test="${not empty errorMsg}">
            <div class="alert alert-error">⚠ ${errorMsg}</div>
        </c:if>
