<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c"    uri="jakarta.tags.core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<c:set var="pageTitle" value="${pageTitle}" scope="request"/>
<c:set var="currentPage" value="patients" scope="request"/>
<%@ include file="../layout/header.jsp" %>

<div class="page-header">
    <div>
        <h2>${pageTitle}</h2>
        <p><a href="/admin/patients" style="color:var(--teal);text-decoration:none;">← Back to Patients</a></p>
    </div>
</div>

<div class="card" style="max-width:820px;">
    <form:form modelAttribute="patient" action="/admin/patients/save" method="post">
        <form:hidden path="id"/>

        <div class="form-grid">
            <div class="form-group">
                <label class="form-label">Full Name *</label>
                <form:input path="name" cssClass="form-control" placeholder="Patient full name"/>
                <form:errors path="name" cssClass="field-error"/>
            </div>
            <div class="form-group">
                <label class="form-label">Age</label>
                <form:input path="age" type="number" cssClass="form-control" placeholder="Age"/>
                <form:errors path="age" cssClass="field-error"/>
            </div>
            <div class="form-group">
                <label class="form-label">Gender</label>
                <form:select path="gender" cssClass="form-control">
                    <form:option value="">— Select —</form:option>
                    <form:option value="MALE">Male</form:option>
                    <form:option value="FEMALE">Female</form:option>
                    <form:option value="OTHER">Other</form:option>
                </form:select>
            </div>
            <div class="form-group">
                <label class="form-label">Blood Group</label>
                <form:select path="bloodGroup" cssClass="form-control">
                    <form:option value="">— Select —</form:option>
                    <form:option value="A+">A+</form:option>
                    <form:option value="A-">A-</form:option>
                    <form:option value="B+">B+</form:option>
                    <form:option value="B-">B-</form:option>
                    <form:option value="O+">O+</form:option>
                    <form:option value="O-">O-</form:option>
                    <form:option value="AB+">AB+</form:option>
                    <form:option value="AB-">AB-</form:option>
                </form:select>
            </div>
            <div class="form-group">
                <label class="form-label">Phone</label>
                <form:input path="phone" cssClass="form-control" placeholder="+91 98765 43210"/>
            </div>
            <div class="form-group">
                <label class="form-label">Email</label>
                <form:input path="email" type="email" cssClass="form-control" placeholder="patient@email.com"/>
                <form:errors path="email" cssClass="field-error"/>
            </div>
            <div class="form-group full">
                <label class="form-label">Address</label>
                <form:textarea path="address" cssClass="form-control" placeholder="Full address" rows="2"/>
            </div>
            <div class="form-group full">
                <label class="form-label">Medical History</label>
                <form:textarea path="medicalHistory" cssClass="form-control" placeholder="Known conditions, allergies, past surgeries..." rows="3"/>
            </div>
        </div>

        <div style="display:flex;gap:12px;margin-top:8px;">
            <button type="submit" class="btn btn-primary">💾 Save Patient</button>
            <a href="/admin/patients" class="btn btn-warning">Cancel</a>
        </div>
    </form:form>
</div>

<%@ include file="../layout/footer.jsp" %>
