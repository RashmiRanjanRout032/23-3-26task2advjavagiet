<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="pageTitle" value="Patients" scope="request"/>
<c:set var="currentPage" value="patients" scope="request"/>
<%@ include file="../layout/header.jsp" %>

<div class="page-header">
    <div>
        <h2>Patients</h2>
        <p>Manage registered patients in the hospital.</p>
    </div>
    <a href="/admin/patients/add" class="btn btn-primary">＋ Add Patient</a>
</div>

<div class="card">
    <form class="search-bar" method="get" action="/admin/patients">
        <input type="text" name="search" placeholder="🔍  Search by name..." value="${search}"/>
        <button type="submit" class="btn btn-primary">Search</button>
        <c:if test="${not empty search}">
            <a href="/admin/patients" class="btn btn-warning">Clear</a>
        </c:if>
    </form>

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
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${empty patients}">
                        <tr><td colspan="7" style="text-align:center;color:var(--text-muted);padding:40px;">No patients found. <a href="/admin/patients/add" style="color:var(--teal);">Add one</a>.</td></tr>
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
                            <td>
                                <div style="display:flex;gap:6px;flex-wrap:wrap;">
                                    <a href="/admin/patients/view/${pat.id}"  class="btn btn-sm btn-primary">View</a>
                                    <a href="/admin/patients/edit/${pat.id}"  class="btn btn-sm btn-warning">Edit</a>
                                    <a href="/admin/patients/delete/${pat.id}" class="btn btn-sm btn-danger"
                                       onclick="return confirm('Delete ${pat.name}?')">Delete</a>
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
