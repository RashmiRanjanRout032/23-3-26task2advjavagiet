<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="pageTitle" value="Doctors" scope="request"/>
<c:set var="currentPage" value="doctors" scope="request"/>
<%@ include file="../layout/header.jsp" %>

<div class="page-header">
    <div>
        <h2>Doctors</h2>
        <p>Manage hospital doctors and their information.</p>
    </div>
    <a href="/admin/doctors/add" class="btn btn-primary">＋ Add Doctor</a>
</div>

<div class="card">
    <form class="search-bar" method="get" action="/admin/doctors">
        <input type="text" name="search" placeholder="🔍  Search by name..." value="${search}"/>
        <button type="submit" class="btn btn-primary">Search</button>
        <c:if test="${not empty search}">
            <a href="/admin/doctors" class="btn btn-warning">Clear</a>
        </c:if>
    </form>

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
                    <th>Status</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${empty doctors}">
                        <tr><td colspan="8" style="text-align:center;color:var(--text-muted);padding:40px;">No doctors found. <a href="/admin/doctors/add" style="color:var(--teal);">Add one</a>.</td></tr>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="doc" items="${doctors}">
                        <tr>
                            <td style="color:var(--text-muted)">${doc.id}</td>
                            <td style="font-weight:600">${doc.name}</td>
                            <td>${doc.specialization}</td>
                            <td>${doc.qualification}</td>
                            <td>${doc.experience} yrs</td>
                            <td>${doc.phone}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${doc.status == 'ACTIVE'}"><span class="badge badge-active">Active</span></c:when>
                                    <c:otherwise><span class="badge badge-inactive">Inactive</span></c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <div style="display:flex;gap:6px;flex-wrap:wrap;">
                                    <a href="/admin/doctors/view/${doc.id}"  class="btn btn-sm btn-primary">View</a>
                                    <a href="/admin/doctors/edit/${doc.id}"  class="btn btn-sm btn-warning">Edit</a>
                                    <a href="/admin/doctors/delete/${doc.id}" class="btn btn-sm btn-danger"
                                       onclick="return confirm('Delete Dr. ${doc.name}?')">Delete</a>
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
