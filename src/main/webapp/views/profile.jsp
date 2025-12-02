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
<title>Hồ sơ cá nhân</title>
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
					href="${pageContext.request.contextPath}/home">Home</a></li>
				<%-- Chỉ hiển thị link List User nếu là Admin đang xem/sửa --%>
				<c:if test="${sessionScope.user.role == 'ADMIN'}">
					<li class="breadcrumb-item"><a
						href="${pageContext.request.contextPath}/admin/users">List
							User</a></li>
				</c:if>
				<li class="breadcrumb-item active" aria-current="page">Hồ sơ
					người dùng</li>
			</ol>
		</nav>

		<div class="row">

			<%-- KHỐI 1: Ảnh đại diện & Nút đổi Ảnh/MK --%>
			<div class="col-md-4 mb-4">
				<div class="card border-0 shadow-sm text-center h-100">
					<div class="card-body py-5">

						<c:url value="/img/avatar_1.jpg" var="img" />
						<img src="${img}" alt="Avatar"
							class="rounded-circle profile-header-img mb-3">

						<h4 class="fw-bold mb-1">${user.fullname}</h4>
						<p class="text-muted mb-3">@${user.username}</p>

						<%-- Kiểm tra xem có phải user đang đăng nhập tự xem profile không --%>
						<c:set var="currentUser" value="${sessionScope.user}" />
						<c:set var="displayedUser" value="${requestScope.user}" />

						<div class="d-flex justify-content-center gap-2">
							<%-- CHỈ HIỂN THỊ NÚT ĐỔI ẢNH/MK KHI USER ĐANG TỰ XEM PROFILE CỦA MÌNH --%>
							<c:if test="${currentUser.username == displayedUser.username}">
								<button class="btn btn-sm btn-outline-primary">
									<i class="bi bi-camera-fill"></i> Đổi ảnh
								</button>
								<button class="btn btn-sm btn-outline-danger">
									<i class="bi bi-key-fill"></i> Đổi mật khẩu
								</button>
							</c:if>
						</div>
					</div>
				</div>
			</div>

			<%-- KHỐI 2: Chi tiết thông tin & Form --%>
			<div class="col-md-8">
				<div class="card border-0 shadow-sm h-100">
					<div class="card-header bg-white border-bottom-0 pt-4 ps-4">
						<h4 class="card-title fw-bold text-primary">
							<i class="bi bi-person-lines-fill me-2"></i>Thông tin chi tiết
						</h4>
					</div>
					<div class="card-body p-4">

						<c:if test="${not empty message}">
							<div
								class="alert alert-${message.contains('thành công') ? 'success' : 'danger'} alert-dismissible fade show"
								role="alert">
								${message}
								<button type="button" class="btn-close" data-bs-dismiss="alert"></button>
							</div>
						</c:if>

						<%-- BẮT ĐẦU KHỐI FORM / VIEW: Nếu is_admin_view trống (User đang tự xem/sửa) --%>
						<c:if test="${empty requestScope.is_admin_view}">
							<form action="${pageContext.request.contextPath}/profile"
								method="post">
						</c:if>

						<%-- Nếu is_admin_view KHÔNG trống (Admin đang xem detail) --%>
						<c:if test="${not empty requestScope.is_admin_view}">
							<div>
						</c:if>

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
								<%-- Input chỉ cho chỉnh sửa khi không phải Admin xem detail --%>
								<input type="text"
									class="form-control ${empty requestScope.is_admin_view ? '' : 'form-control-plaintext'}"
									name="fullname" value="${user.fullname}"
									${empty requestScope.is_admin_view ? 'required' : 'readonly'}>
							</div>
						</div>
						<div class="mb-3 row">
							<label class="col-sm-3 col-form-label">Email</label>
							<div class="col-sm-9">
								<%-- Input chỉ cho chỉnh sửa khi không phải Admin xem detail --%>
								<input type="email"
									class="form-control ${empty requestScope.is_admin_view ? '' : 'form-control-plaintext'}"
									name="email" value="${user.email}"
									${empty requestScope.is_admin_view ? 'required' : 'readonly'}>
							</div>
						</div>
						<hr class="my-4">
						<div class="row mb-3">
							<div class="col-md-6">
								<label class="form-label fw-bold">Chức vụ</label>
								<%-- PHẦN PHÂN QUYỀN/TRẠNG THÁI: Chỉ cho phép Select khi User tự chỉnh sửa (empty is_admin_view) --%>
								<c:if test="${empty requestScope.is_admin_view}">
									<c:choose>
										<%-- ADMIN tự sửa/ xem profile có thể sửa role/active của chính mình --%>
										<c:when test="${sessionScope.user.role == 'ADMIN'}">
											<select name="role" class="form-select">
												<option value="USER"
													${user.role == 'USER' ? 'selected' : ''}>Nhân viên</option>
												<option value="ADMIN"
													${user.role == 'ADMIN' ? 'selected' : ''}>Quản lý</option>
											</select>
										</c:when>
										<c:otherwise>
											<%-- User thường chỉ thấy read-only --%>
											<input type="text" class="form-control bg-light"
												value="${user.role}" disabled>
											<input type="hidden" name="role" value="${user.role}">
										</c:otherwise>
									</c:choose>
								</c:if>

								<%-- Nếu là ADMIN đang xem detail (VIEW CHỈ ĐỌC) --%>
								<c:if test="${not empty requestScope.is_admin_view}">
									<p class="form-control-plaintext fw-bold">${user.role}</p>
								</c:if>
							</div>
							<div class="col-md-6">
								<label class="form-label fw-bold">Trạng thái</label>
								<%-- PHẦN TRẠNG THÁI: Chỉ cho phép Select khi User tự chỉnh sửa (empty is_admin_view) --%>
								<c:if test="${empty requestScope.is_admin_view}">
									<c:choose>
										<c:when test="${sessionScope.user.role == 'ADMIN'}">
											<select name="isActive" class="form-select">
												<option value="true" ${user.active ? 'selected' : ''}>Hoạt
													động</option>
												<option value="false" ${!user.active ? 'selected' : ''}>Đang
													khóa</option>
											</select>
										</c:when>
										<c:otherwise>
											<input type="text" class="form-control bg-light"
												value="${user.active ? 'Hoạt động' : 'Bị khóa'}" disabled>
											<input type="hidden" name="isActive" value="${user.active}">
										</c:otherwise>
									</c:choose>
								</c:if>

								<%-- Nếu là ADMIN đang xem detail (VIEW CHỈ ĐỌC) --%>
								<c:if test="${not empty requestScope.is_admin_view}">
									<p class="form-control-plaintext fw-bold">${user.active ? 'Hoạt động' : 'Bị khóa'}</p>
								</c:if>
							</div>
						</div>


						<%-- KHỐI NÚT CHỨC NĂNG --%>
						<div class="d-grid gap-2 d-md-flex justify-content-md-end mt-4">

							<%-- NÚT LƯU THAY ĐỔI: Chỉ hiển thị khi User đang tự xem/sửa (empty is_admin_view) --%>
							<c:if test="${empty requestScope.is_admin_view}">
								<a href="${pageContext.request.contextPath}/home"
									class="btn btn-light me-md-2">Hủy bỏ</a>
								<button type="submit" class="btn btn-primary px-4">
									<i class="bi bi-save me-1"></i> Lưu thay đổi
								</button>
							</c:if>

							<%-- NÚT QUAY LẠI DANH SÁCH: Chỉ hiển thị khi Admin đang xem detail user khác --%>
							<c:if test="${not empty requestScope.is_admin_view}">
								<a href="${pageContext.request.contextPath}/admin/users"
									class="btn btn-outline-dark me-md-2"> Quay lại danh sách </a>
							</c:if>
						</div>

						<%-- KẾT THÚC KHỐI FORM / VIEW CHỈ ĐỌC --%>
						<c:if test="${empty requestScope.is_admin_view}">
							</form>
						</c:if>
						<c:if test="${not empty requestScope.is_admin_view}">
					</div>
					</c:if>
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