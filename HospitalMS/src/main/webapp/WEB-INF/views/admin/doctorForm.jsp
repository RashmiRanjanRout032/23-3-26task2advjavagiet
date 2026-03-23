<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c"    uri="jakarta.tags.core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<c:set var="pageTitle" value="${pageTitle}" scope="request"/>
<c:set var="currentPage" value="doctors" scope="request"/>
<%@ include file="../layout/header.jsp" %>

<div class="page-header">
    <div>
        <h2>${pageTitle}</h2>
        <p><a href="/admin/doctors" style="color:var(--teal);text-decoration:none;">← Back to Doctors</a></p>
    </div>
</div>

<div class="card" style="max-width:820px;">
    <form:form modelAttribute="doctor" action="/admin/doctors/save" method="post">
        <form:hidden path="id"/>

        <div class="form-grid">
            <div class="form-group">
                <label class="form-label">Full Name *</label>
                <form:input path="name" cssClass="form-control" placeholder="Dr. John Smith"/>
                <form:errors path="name" cssClass="field-error"/>
            </div>
            <div class="form-group">
                <label class="form-label">Specialization *</label>
                <form:input path="specialization" cssClass="form-control" placeholder="e.g. Cardiology"/>
                <form:errors path="specialization" cssClass="field-error"/>
            </div>
            <div class="form-group">
                <label class="form-label">Qualification</label>
                <form:input path="qualification" cssClass="form-control" placeholder="e.g. MBBS, MD"/>
                <form:errors path="qualification" cssClass="field-error"/>
            </div>
            <div class="form-group">
                <label class="form-label">Experience (years)</label>
                <form:input path="experience" type="number" cssClass="form-control" placeholder="5"/>
                <form:errors path="experience" cssClass="field-error"/>
            </div>
            <div class="form-group">
                <label class="form-label">Phone</label>
                <form:input path="phone" cssClass="form-control" placeholder="+91 98765 43210"/>
                <form:errors path="phone" cssClass="field-error"/>
            </div>
            <div class="form-group">
                <label class="form-label">Email</label>
                <form:input path="email" type="email" cssClass="form-control" placeholder="doctor@hospital.com"/>
                <form:errors path="email" cssClass="field-error"/>
            </div>
            <div class="form-group">
                <label class="form-label">Status</label>
                <form:select path="status" cssClass="form-control">
                    <form:option value="ACTIVE">Active</form:option>
                    <form:option value="INACTIVE">Inactive</form:option>
                </form:select>
            </div>
        </div>

        <div style="display:flex;gap:12px;margin-top:8px;">
            <button type="submit" class="btn btn-primary">💾 Save Doctor</button>
            <a href="/admin/doctors" class="btn btn-warning">Cancel</a>
        </div>
    </form:form>
</div>

<%@ include file="../layout/footer.jsp" %>
