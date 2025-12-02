<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<fmt:setBundle basename="global" />

<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>List User</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
</head>

<body class="d-flex flex-column min-vh-100 bg-light">
	<jsp:include page="header.jsp" />
	<main class="container flex-grow-1 py-5">
		<nav aria-label="breadcrumb" class="mb-4">
			<ol class="breadcrumb">
				<li class="breadcrumb-item"><a
					href="${pageContext.request.contextPath}/home">Home</a></li>
				<li class="breadcrumb-item"><a
					href="${pageContext.request.contextPath}/admin/dashboard">Amin
						Dashboard</a></li>
				<li class="breadcrumb-item active" aria-current="page">List Users</li>

			</ol>
		</nav>

		<h2 class="text-success">List User</h2>
		<table class="table table-bordered table-hover mt-4">
			<thead>
				<tr>
					<th>No.</th>
					<th>ID</th>
					<th>User name</th>
					<th>Full name</th>
					<th>Email</th>
					<th>Role</th>
					<th>Active</th>
					<th>Last Login</th>
					<th>Activity</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="u" items="${list}" varStatus="i">
					<tr>
						<td>${i.count}</td>
						<td>${u.id}</td>
						<td>${u.username}</td>
						<td>${u.fullname}</td>
						<td>${u.email}</td>
						<td>${u.role}</td>
						<td>${u.active == true ? 'Đang hoạt động' : 'Đã bị khóa'}</td>
						<td>${u.lastLogin}</td>
						<th><a class="btn btn-sm btn-outline-danger"
							onclick="return confirm('Bạn có chắc muốn xóa ${u.username}?')"
							href="${pageContext.request.contextPath}/admin/users/delete?username=${u.username}">Delete</a>
							<a class="btn btn-sm btn-outline-warning"
							href="${pageContext.request.contextPath}/admin/users/edit?username=${u.username}">Edit</a>
							<a class="btn btn-sm btn-outline-primary"
							href="${pageContext.request.contextPath}/admin/users/detail?username=${u.username}">View Detail</a>
						</th>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</main>

	<jsp:include page="footer.jsp" />

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
