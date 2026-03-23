<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c"   uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<c:set var="pageTitle"   value="Dashboard"   scope="request"/>
<c:set var="currentPage" value="dashboard"   scope="request"/>
<%@ include file="../layout/header.jsp" %>

<div class="page-header">
    <div>
        <h2>Receptionist Dashboard</h2>
        <p>Manage today's appointments and patient flow.</p>
    </div>
    <a href="/receptionist/appointments/add" class="btn btn-primary">＋ New Appointment</a>
</div>

<div class="stats-grid">
    <div class="stat-card teal">
        <div class="stat-icon">📅</div>
        <div class="stat-value">${todayCount}</div>
        <div class="stat-label">Today's Appointments</div>
    </div>
    <div class="stat-card green">
        <div class="stat-icon">🗓</div>
        <div class="stat-value">${scheduledCount}</div>
        <div class="stat-label">Scheduled</div>
    </div>
    <div class="stat-card gold">
        <div class="stat-icon">📋</div>
        <div class="stat-value">${totalCount}</div>
        <div class="stat-label">Total Appointments</div>
    </div>
</div>

<div class="card">
    <div style="display:flex;align-items:center;justify-content:space-between;margin-bottom:16px;">
        <span style="font-size:16px;font-weight:600;color:var(--text);">📅 Today's Appointments</span>
        <a href="/receptionist/appointments" style="font-size:13px;color:var(--teal);text-decoration:none;">View All →</a>
    </div>

    <div class="table-wrapper">
        <table>
            <thead>
                <tr>
                    <th>#</th>
                    <th>Patient</th>
                    <th>Doctor</th>
                    <th>Time</th>
                    <th>Status</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${empty todayAppointments}">
                        <tr><td colspan="6" style="text-align:center;color:var(--text-muted);padding:32px;">No appointments today. <a href="/receptionist/appointments/add" style="color:var(--teal);">Schedule one</a>.</td></tr>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="appt" items="${todayAppointments}">
                        <tr>
                            <td style="color:var(--text-muted)">#${appt.id}</td>
                            <td style="font-weight:600">${appt.patient.name}</td>
                            <td>${appt.doctor.name}</td>
                            <td>${appt.appointmentTime}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${appt.status == 'SCHEDULED'}"><span class="badge badge-scheduled">Scheduled</span></c:when>
                                    <c:when test="${appt.status == 'COMPLETED'}"><span class="badge badge-completed">Completed</span></c:when>
                                    <c:otherwise><span class="badge badge-cancelled">Cancelled</span></c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <div style="display:flex;gap:6px;flex-wrap:wrap;">
                                    <a href="/receptionist/appointments/status/${appt.id}/COMPLETED" class="btn btn-sm btn-primary"
                                       onclick="return confirm('Mark as Completed?')">✓ Done</a>
                                    <a href="/receptionist/appointments/status/${appt.id}/CANCELLED" class="btn btn-sm btn-danger"
                                       onclick="return confirm('Cancel this appointment?')">✕ Cancel</a>
                                </div>
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
