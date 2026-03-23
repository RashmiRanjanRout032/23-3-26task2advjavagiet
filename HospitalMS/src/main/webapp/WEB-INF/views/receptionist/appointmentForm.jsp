<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c"    uri="jakarta.tags.core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<c:set var="pageTitle"   value="${pageTitle}"   scope="request"/>
<c:set var="currentPage" value="appointments"   scope="request"/>
<%@ include file="../layout/header.jsp" %>

<div class="page-header">
    <div>
        <h2>${pageTitle}</h2>
        <p><a href="/receptionist/appointments" style="color:var(--teal);text-decoration:none;">← Back to Appointments</a></p>
    </div>
</div>

<div class="card" style="max-width:720px;">
    <form:form modelAttribute="appointment" action="/receptionist/appointments/save" method="post">
        <form:hidden path="id"/>

        <div class="form-grid">
            <div class="form-group">
                <label class="form-label">Patient *</label>
                <form:select path="patient.id" cssClass="form-control">
                    <form:option value="">— Select Patient —</form:option>
                    <c:forEach var="pat" items="${patients}">
                        <form:option value="${pat.id}">${pat.name} (${pat.phone})</form:option>
                    </c:forEach>
                </form:select>
                <form:errors path="patient" cssClass="field-error"/>
            </div>

            <div class="form-group">
                <label class="form-label">Doctor *</label>
                <form:select path="doctor.id" cssClass="form-control">
                    <form:option value="">— Select Doctor —</form:option>
                    <c:forEach var="doc" items="${doctors}">
                        <form:option value="${doc.id}">${doc.name} — ${doc.specialization}</form:option>
                    </c:forEach>
                </form:select>
                <form:errors path="doctor" cssClass="field-error"/>
            </div>

            <div class="form-group">
                <label class="form-label">Appointment Date *</label>
                <form:input path="appointmentDate" type="date" cssClass="form-control"/>
                <form:errors path="appointmentDate" cssClass="field-error"/>
            </div>

            <div class="form-group">
                <label class="form-label">Appointment Time *</label>
                <form:input path="appointmentTime" type="time" cssClass="form-control"/>
                <form:errors path="appointmentTime" cssClass="field-error"/>
            </div>

            <div class="form-group">
                <label class="form-label">Status</label>
                <form:select path="status" cssClass="form-control">
                    <form:option value="SCHEDULED">Scheduled</form:option>
                    <form:option value="COMPLETED">Completed</form:option>
                    <form:option value="CANCELLED">Cancelled</form:option>
                </form:select>
            </div>

            <div class="form-group full">
                <label class="form-label">Notes</label>
                <form:textarea path="notes" cssClass="form-control" rows="3" placeholder="Additional notes or reason for visit..."/>
            </div>
        </div>

        <div style="display:flex;gap:12px;margin-top:8px;">
            <button type="submit" class="btn btn-primary">💾 Save Appointment</button>
            <a href="/receptionist/appointments" class="btn btn-warning">Cancel</a>
        </div>
    </form:form>
</div>

<%@ include file="../layout/footer.jsp" %>
