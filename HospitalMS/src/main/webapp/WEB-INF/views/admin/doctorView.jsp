<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="pageTitle" value="Doctor Details" scope="request"/>
<c:set var="currentPage" value="doctors" scope="request"/>
<%@ include file="../layout/header.jsp" %>

<div class="page-header">
    <div>
        <h2>Doctor Details</h2>
        <p><a href="/admin/doctors" style="color:var(--teal);text-decoration:none;">← Back to Doctors</a></p>
    </div>
    <div style="display:flex;gap:10px;">
        <a href="/admin/doctors/edit/${doctor.id}" class="btn btn-warning">✏ Edit</a>
        <a href="/admin/doctors/delete/${doctor.id}" class="btn btn-danger"
           onclick="return confirm('Delete this doctor?')">🗑 Delete</a>
    </div>
</div>

<div class="card" style="max-width:700px;">
    <div style="display:flex;align-items:center;gap:20px;margin-bottom:28px;padding-bottom:24px;border-bottom:1px solid var(--border);">
        <div style="width:72px;height:72px;background:linear-gradient(135deg,var(--teal),var(--teal-dark));border-radius:50%;display:flex;align-items:center;justify-content:center;font-size:32px;flex-shrink:0;">👨‍⚕️</div>
        <div>
            <div style="font-family:'DM Serif Display',serif;font-size:22px;color:var(--text);">${doctor.name}</div>
            <div style="color:var(--teal);font-size:14px;margin-top:2px;">${doctor.specialization}</div>
            <div style="margin-top:6px;">
                <c:choose>
                    <c:when test="${doctor.status == 'ACTIVE'}"><span class="badge badge-active">Active</span></c:when>
                    <c:otherwise><span class="badge badge-inactive">Inactive</span></c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>

    <div style="display:grid;grid-template-columns:1fr 1fr;gap:20px;">
        <div>
            <div style="font-size:11px;color:var(--teal);font-weight:700;text-transform:uppercase;letter-spacing:.8px;margin-bottom:4px;">Qualification</div>
            <div style="color:var(--text)">${not empty doctor.qualification ? doctor.qualification : '—'}</div>
        </div>
        <div>
            <div style="font-size:11px;color:var(--teal);font-weight:700;text-transform:uppercase;letter-spacing:.8px;margin-bottom:4px;">Experience</div>
            <div style="color:var(--text)">${not empty doctor.experience ? doctor.experience.concat(' years') : '—'}</div>
        </div>
        <div>
            <div style="font-size:11px;color:var(--teal);font-weight:700;text-transform:uppercase;letter-spacing:.8px;margin-bottom:4px;">Phone</div>
            <div style="color:var(--text)">${not empty doctor.phone ? doctor.phone : '—'}</div>
        </div>
        <div>
            <div style="font-size:11px;color:var(--teal);font-weight:700;text-transform:uppercase;letter-spacing:.8px;margin-bottom:4px;">Email</div>
            <div style="color:var(--text)">${not empty doctor.email ? doctor.email : '—'}</div>
        </div>
    </div>
</div>

<%@ include file="../layout/footer.jsp" %>
