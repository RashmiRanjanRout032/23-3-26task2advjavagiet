<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<c:set var="pageTitle" value="Dashboard" scope="request"/>
<c:set var="currentPage" value="dashboard" scope="request"/>
<%@ include file="../layout/header.jsp" %>

<div class="page-header">
    <div>
        <h2>Admin Dashboard</h2>
        <p>Welcome back! Here's what's happening in the hospital today.</p>
    </div>
</div>

<!-- Stat Cards -->
<div class="stats-grid">
    <div class="stat-card teal">
        <div class="stat-icon">👨‍⚕️</div>
        <div class="stat-value">${totalDoctors}</div>
        <div class="stat-label">Total Doctors</div>
    </div>
    <div class="stat-card green">
        <div class="stat-icon">✅</div>
        <div class="stat-value">${activeDoctors}</div>
        <div class="stat-label">Active Doctors</div>
    </div>
    <div class="stat-card gold">
        <div class="stat-icon">🧑‍🤝‍🧑</div>
        <div class="stat-value">${totalPatients}</div>
        <div class="stat-label">Total Patients</div>
    </div>
    <div class="stat-card teal">
        <div class="stat-icon">📅</div>
        <div class="stat-value">${todayAppointments}</div>
        <div class="stat-label">Today's Appointments</div>
    </div>
    <div class="stat-card green">
        <div class="stat-icon">🗓</div>
        <div class="stat-value">${scheduledAppointments}</div>
        <div class="stat-label">Scheduled</div>
    </div>
    <div class="stat-card gold">
        <div class="stat-icon">📋</div>
        <div class="stat-value">${totalAppointments}</div>
        <div class="stat-label">Total Appointments</div>
    </div>
</div>

<!-- Quick Actions -->
<div class="card" style="margin-bottom:24px;">
    <div style="font-size:13px;font-weight:700;color:var(--teal);letter-spacing:.8px;text-transform:uppercase;margin-bottom:16px;">Quick Actions</div>
    <div style="display:flex;flex-wrap:wrap;gap:12px;">
        <a href="/admin/doctors/add"  class="btn btn-primary">＋ Add Doctor</a>
        <a href="/admin/patients/add" class="btn btn-primary">＋ Add Patient</a>
        <a href="/admin/doctors"      class="btn btn-warning">View All Doctors</a>
        <a href="/admin/patients"     class="btn btn-warning">View All Patients</a>
    </div>
</div>

<!-- Recent Appointments -->
<div class="card">
    <div style="display:flex;align-items:center;justify-content:space-between;margin-bottom:16px;">
        <span style="font-size:16px;font-weight:600;color:var(--text);">Recent Appointments</span>
    </div>
    <div class="table-wrapper">
        <table>
            <thead>
                <tr>
                    <th>#</th>
                    <th>Patient</th>
                    <th>Doctor</th>
                    <th>Date</th>
                    <th>Time</th>
                    <th>Status</th>
                </tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${empty recentAppointments}">
                        <tr><td colspan="6" style="text-align:center;color:var(--text-muted);padding:32px;">No appointments found</td></tr>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="appt" items="${recentAppointments}">
                        <tr>
                            <td style="color:var(--text-muted)">#${appt.id}</td>
                            <td>${appt.patient.name}</td>
                            <td>${appt.doctor.name}</td>
                            <td><fmt:formatDate value="${appt.appointmentDate}" pattern="dd MMM yyyy" type="date"/></td>
                            <td>${appt.appointmentTime}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${appt.status == 'SCHEDULED'}"><span class="badge badge-scheduled">Scheduled</span></c:when>
                                    <c:when test="${appt.status == 'COMPLETED'}"><span class="badge badge-completed">Completed</span></c:when>
                                    <c:otherwise><span class="badge badge-cancelled">Cancelled</span></c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>
    </div>
</div>

<%@ include file="../layout/footer.jsp" %>
