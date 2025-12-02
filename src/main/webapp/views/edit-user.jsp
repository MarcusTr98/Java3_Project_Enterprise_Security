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
<title>Chỉnh sửa thành viên</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
<style>
.profile-header-img {
	width: 120px;
	height: 120px;
	object-fit: cover;
	border: 4px solid #fff;
	box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.15);
}
</style>
</head>

<body class="d-flex flex-column min-vh-100 bg-light">

	<jsp:include page="header.jsp" />

	<main class="container flex-grow-1 py-5">

		<nav aria-label="breadcrumb" class="mb-4">
			<ol class="breadcrumb">
				<li class="breadcrumb-item"><a
					href="${pageContext.request.contextPath}/admin/dashboard">Admin Dashboard</a></li>
				<li class="breadcrumb-item"><a
					href="${pageContext.request.contextPath}/admin/users">List Users</a></li>
				<li class="breadcrumb-item active" aria-current="page">Chỉnh
					sửa: ${user.username}</li>
			</ol>
		</nav>

		<div class="row">

			<div class="col-md-4 mb-4">
				<div class="card border-0 shadow-sm text-center h-100">
					<div class="card-body py-5">
						<c:url value="/img/avatar_1.jpg" var="img" />
						<img src="${img}" alt="Avatar"
							class="rounded-circle profile-header-img mb-3">

						<h4 class="fw-bold mb-1">${user.fullname}</h4>
						<p class="text-muted mb-3">@${user.username}</p>

						<div class="badge bg-${user.active ? 'success' : 'danger'} mb-3">
							${user.active ? 'Active' : 'Banned'}</div>

						<div class="d-grid px-3">
							<button class="btn btn-sm btn-outline-warning">
								<i class="bi bi-arrow-counterclockwise"></i> Reset Mật khẩu
							</button>
						</div>
					</div>
				</div>
			</div>

			<!-- Cột Phải: Form Chỉnh Sửa -->
			<div class="col-md-8">
				<div class="card border-0 shadow-sm h-100">
					<div class="card-header bg-white border-bottom-0 pt-4 ps-4">
						<h4 class="card-title fw-bold text-warning">
							<i class="bi bi-pencil-square me-2"></i>Cập nhật thông tin
						</h4>
					</div>
					<div class="card-body p-4">

						<!-- Thông báo lỗi/thành công -->
						<c:if test="${not empty message}">
							<div class="alert alert-danger alert-dismissible fade show"
								role="alert">
								${message}
								<button type="button" class="btn-close" data-bs-dismiss="alert"></button>
							</div>
						</c:if>

						<form
							action="${pageContext.request.contextPath}/admin/users/edit"
							method="post">

							<div class="mb-3 row">
								<label class="col-sm-3 col-form-label text-muted">Tài
									khoản</label>
								<div class="col-sm-9">
									<input type="text" readonly
										class="form-control-plaintext fw-bold" name="username"
										value="${user.username}">
								</div>
							</div>

							<div class="mb-3 row">
								<label class="col-sm-3 col-form-label">Họ và tên</label>
								<div class="col-sm-9">
									<input type="text" class="form-control" name="fullname"
										value="${user.fullname}" required>
								</div>
							</div>

							<div class="mb-3 row">
								<label class="col-sm-3 col-form-label">Email</label>
								<div class="col-sm-9">
									<input type="email" class="form-control" name="email"
										value="${user.email}" required>
								</div>
							</div>

							<hr class="my-4">

							<div class="row mb-3">
								<div class="col-md-6">
									<label class="form-label fw-bold text-danger">Phân
										quyền</label> <select name="role" class="form-select border-danger">
										<option value="USER" ${user.role == 'USER' ? 'selected' : ''}>Nhân
											viên (User)</option>
										<option value="ADMIN"
											${user.role == 'ADMIN' ? 'selected' : ''}>Quản trị
											(Admin)</option>
									</select>
								</div>

								<div class="col-md-6">
									<label class="form-label fw-bold text-danger">Trạng
										thái</label> <select name="isActive" class="form-select border-danger">
										<option value="true" ${user.active ? 'selected' : ''}>Cho
											phép hoạt động</option>
										<option value="false" ${!user.active ? 'selected' : ''}>Khóa
											tài khoản</option>
									</select>
								</div>
							</div>

							<!-- Buttons -->
							<div class="d-grid gap-2 d-md-flex justify-content-md-end mt-4">
								<!-- Nút Hủy quay về danh sách -->
								<a href="${pageContext.request.contextPath}/admin/users"
									class="btn btn-outline-dark me-md-2"> Quay lại danh sách </a>
								<button type="submit" class="btn btn-warning px-4 fw-bold" onclick="return confirm('Bạn có chắc muốn sửa ${u.username}?')">
									<i class="bi bi-check-circle-fill me-1"></i> Xác nhận sửa
								</button>
							</div>

						</form>
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