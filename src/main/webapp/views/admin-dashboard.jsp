<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Admin-Dashboard</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
</head>

<body class="d-flex flex-column min-vh-100 bg-light">

	<jsp:include page="header.jsp" />

	<main class="container flex-grow-1 py-5">
		<div class="row">
			<div class="col-md-12">
				<div class="card shadow border-0">
					<div class="card-header bg-primary text-white">
						<h4 class="mb-0">
							<i class="bi bi-shield-lock-fill"></i> KHU VỰC QUẢN TRỊ VIÊN
						</h4>
					</div>
					<div class="card-body p-5 text-center">
						<c:url value="/img/avatar_1.jpg" var="img" />
						<img src="${img}" class="rounded-circle" alt="Admin" width="100"
							class="mb-3">

						<h2 class="text-success">
							Xin chào sếp: <span class="fw-bold text-dark">${sessionScope.user.fullname}</span>
						</h2>

						<p class="lead text-muted">
							Bạn đang đăng nhập với quyền: <span
								class="badge ${sessionScope.user.role ? 'bg-danger' : 'bg-info'}">
								${sessionScope.user.role} </span>
						</p>

						<hr>

						<div class="d-grid gap-2 d-sm-flex justify-content-sm-center">
							<a class="btn btn-outline-primary btn-lg px-4 gap-3"
								href="${pageContext.request.contextPath}/admin/users"> Quản
								lý User </a>
							<button type="button"
								class="btn btn-outline-secondary btn-lg px-4">Xem Báo
								Cáo</button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</main>

	<jsp:include page="footer.jsp" />

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>