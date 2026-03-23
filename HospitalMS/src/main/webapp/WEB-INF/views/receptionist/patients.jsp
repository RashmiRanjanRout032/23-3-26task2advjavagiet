<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="pageTitle"   value="Patients Directory" scope="request"/>
<c:set var="currentPage" value="rec-patients"        scope="request"/>
<%@ include file="../layout/header.jsp" %>

<div class="page-header">
    <div>
        <h2>Patients Directory</h2>
        <p>Browse registered patients.</p>
    </div>
</div>

<div class="card">
    <div class="table-wrapper">
        <table>
            <thead>
                <tr>
                    <th>#</th>
                    <th>Name</th>
                    <th>Age</th>
                    <th>Gender</th>
                    <th>Blood Group</th>
                    <th>Phone</th>
                </tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${empty patients}">
                        <tr><td colspan="6" style="text-align:center;color:var(--text-muted);padding:40px;">No patients registered yet.</td></tr>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="pat" items="${patients}">
                        <tr>
                            <td style="color:var(--text-muted)">${pat.id}</td>
                            <td style="font-weight:600">${pat.name}</td>
                            <td>${pat.age}</td>
                            <td>${pat.gender}</td>
                            <td><span style="color:var(--gold);font-weight:600">${pat.bloodGroup}</span></td>
                            <td>${pat.phone}</td>
                        </tr>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>
    </div>
</div>

<%@ include file="../layout/footer.jsp" %>
