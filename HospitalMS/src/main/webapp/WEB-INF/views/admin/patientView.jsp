<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="pageTitle" value="Patient Details" scope="request"/>
<c:set var="currentPage" value="patients" scope="request"/>
<%@ include file="../layout/header.jsp" %>

<div class="page-header">
    <div>
        <h2>Patient Details</h2>
        <p><a href="/admin/patients" style="color:var(--teal);text-decoration:none;">← Back to Patients</a></p>
    </div>
    <div style="display:flex;gap:10px;">
        <a href="/admin/patients/edit/${patient.id}" class="btn btn-warning">✏ Edit</a>
        <a href="/admin/patients/delete/${patient.id}" class="btn btn-danger"
           onclick="return confirm('Delete this patient?')">🗑 Delete</a>
    </div>
</div>

<div class="card" style="max-width:700px;">
    <div style="display:flex;align-items:center;gap:20px;margin-bottom:28px;padding-bottom:24px;border-bottom:1px solid var(--border);">
        <div style="width:72px;height:72px;background:linear-gradient(135deg,var(--gold),#d97706);border-radius:50%;display:flex;align-items:center;justify-content:center;font-size:32px;flex-shrink:0;">🧑‍🤝‍🧑</div>
        <div>
            <div style="font-family:'DM Serif Display',serif;font-size:22px;color:var(--text);">${patient.name}</div>
            <div style="color:var(--text-muted);font-size:14px;margin-top:2px;">${patient.gender} · ${patient.age} years</div>
            <div style="margin-top:6px;"><span style="color:var(--gold);font-weight:700;font-size:14px;">${patient.bloodGroup}</span></div>
        </div>
    </div>

    <div style="display:grid;grid-template-columns:1fr 1fr;gap:20px;">
        <div>
            <div style="font-size:11px;color:var(--teal);font-weight:700;text-transform:uppercase;letter-spacing:.8px;margin-bottom:4px;">Phone</div>
            <div style="color:var(--text)">${not empty patient.phone ? patient.phone : '—'}</div>
        </div>
        <div>
            <div style="font-size:11px;color:var(--teal);font-weight:700;text-transform:uppercase;letter-spacing:.8px;margin-bottom:4px;">Email</div>
            <div style="color:var(--text)">${not empty patient.email ? patient.email : '—'}</div>
        </div>
        <div style="grid-column:1/-1;">
            <div style="font-size:11px;color:var(--teal);font-weight:700;text-transform:uppercase;letter-spacing:.8px;margin-bottom:4px;">Address</div>
            <div style="color:var(--text)">${not empty patient.address ? patient.address : '—'}</div>
        </div>
        <div style="grid-column:1/-1;">
            <div style="font-size:11px;color:var(--teal);font-weight:700;text-transform:uppercase;letter-spacing:.8px;margin-bottom:4px;">Medical History</div>
            <div style="color:var(--text);line-height:1.6">${not empty patient.medicalHistory ? patient.medicalHistory : '—'}</div>
        </div>
    </div>
</div>

<%@ include file="../layout/footer.jsp" %>
