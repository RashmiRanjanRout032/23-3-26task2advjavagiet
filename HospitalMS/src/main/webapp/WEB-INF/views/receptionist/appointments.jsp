<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c"   uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<c:set var="pageTitle"   value="Appointments"   scope="request"/>
<c:set var="currentPage" value="appointments"   scope="request"/>
<%@ include file="../layout/header.jsp" %>

<div class="page-header">
    <div>
        <h2>Appointments</h2>
        <p>View and manage all patient appointments.</p>
    </div>
    <a href="/receptionist/appointments/add" class="btn btn-primary">＋ New Appointment</a>
</div>

<div class="card">
    <form class="search-bar" method="get" action="/receptionist/appointments" style="margin-bottom:20px;">
        <input type="date" name="date" value="${filterDate}" style="background:rgba(255,255,255,0.04);border:1px solid var(--border);border-radius:8px;padding:9px 14px;color:var(--text);font-family:'DM Sans',sans-serif;font-size:14px;outline:none;"/>
        <button type="submit" class="btn btn-primary">Filter by Date</button>
        <c:if test="${not empty filterDate}">
            <a href="/receptionist/appointments" class="btn btn-warning">Clear</a>
        </c:if>
    </form>

    <div class="table-wrapper">
        <table>
            <thead>
                <tr>
                    <th>#</th>
                    <th>Patient</th>
                    <th>Doctor</th>
                    <th>Specialization</th>
                    <th>Date</th>
                    <th>Time</th>
                    <th>Status</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${empty appointments}">
                        <tr><td colspan="8" style="text-align:center;color:var(--text-muted);padding:40px;">No appointments found. <a href="/receptionist/appointments/add" style="color:var(--teal);">Schedule one</a>.</td></tr>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="appt" items="${appointments}">
                        <tr>
                            <td style="color:var(--text-muted)">#${appt.id}</td>
                            <td style="font-weight:600">${appt.patient.name}</td>
                            <td>${appt.doctor.name}</td>
                            <td style="color:var(--text-muted)">${appt.doctor.specialization}</td>
                            <td>${appt.appointmentDate}</td>
                            <td>${appt.appointmentTime}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${appt.status == 'SCHEDULED'}"><span class="badge badge-scheduled">Scheduled</span></c:when>
                                    <c:when test="${appt.status == 'COMPLETED'}"><span class="badge badge-completed">Completed</span></c:when>
                                    <c:otherwise><span class="badge badge-cancelled">Cancelled</span></c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <div style="display:flex;gap:5px;flex-wrap:wrap;">
                                    <a href="/receptionist/appointments/edit/${appt.id}" class="btn btn-sm btn-warning">Edit</a>
                                    <c:if test="${appt.status == 'SCHEDULED'}">
                                        <a href="/receptionist/appointments/status/${appt.id}/COMPLETED" class="btn btn-sm btn-primary"
                                           onclick="return confirm('Mark as completed?')">✓</a>
                                        <a href="/receptionist/appointments/status/${appt.id}/CANCELLED" class="btn btn-sm btn-danger"
                                           onclick="return confirm('Cancel?')">✕</a>
                                    </c:if>
                                    <a href="/receptionist/appointments/delete/${appt.id}" class="btn btn-sm btn-danger"
                                       onclick="return confirm('Delete appointment #${appt.id}?')">🗑</a>
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
