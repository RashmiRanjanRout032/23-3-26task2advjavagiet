<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="pageTitle"   value="Doctors Directory" scope="request"/>
<c:set var="currentPage" value="rec-doctors"       scope="request"/>
<%@ include file="../layout/header.jsp" %>

<div class="page-header">
    <div>
        <h2>Doctors Directory</h2>
        <p>View active doctors available for appointments.</p>
    </div>
</div>

<div class="card">
    <div class="table-wrapper">
        <table>
            <thead>
                <tr>
                    <th>#</th>
                    <th>Name</th>
                    <th>Specialization</th>
                    <th>Qualification</th>
                    <th>Experience</th>
                    <th>Phone</th>
                    <th>Email</th>
                </tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${empty doctors}">
                        <tr><td colspan="7" style="text-align:center;color:var(--text-muted);padding:40px;">No active doctors found.</td></tr>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="doc" items="${doctors}">
                        <tr>
                            <td style="color:var(--text-muted)">${doc.id}</td>
                            <td style="font-weight:600">${doc.name}</td>
                            <td><span style="color:var(--teal)">${doc.specialization}</span></td>
                            <td>${doc.qualification}</td>
                            <td>${doc.experience} yrs</td>
                            <td>${doc.phone}</td>
                            <td>${doc.email}</td>
                        </tr>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>
    </div>
</div>

<%@ include file="../layout/footer.jsp" %>
