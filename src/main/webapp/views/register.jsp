<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<fmt:setBundle basename="global" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title><fmt:message key="title.register" /></title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
<style>
.login-image {
	object-fit: cover;
	object-position: center;
	min-height: 100%;
}
</style>
</head>
<body class="bg-light">
	<div class="container py-5">

		<div class="card mx-auto shadow-lg border-0 overflow-hidden"
			style="max-width: 1000px;">
			<div class="row g-0">

				<c:url value="/img/register1.jpg" var="img" />
				<div class="col-md-6 d-none d-md-block bg-dark">
					<img src="${img }" class="img-fluid w-100 h-100 login-image"
						alt="Registrer Cover">
				</div>

				<div class="col-md-6 bg-white">
					<div class="card-body p-4">
						<div class="text-center mb-4">
							<h2 class="fw-bold text-success">
								<fmt:message key="title.register" />
							</h2>
						</div>

						<div class="mb-3">
							<c:if test="${not empty message}">
								<div
									class="alert alert-danger alert-dismissible fade show d-flex align-items-center"
									role="alert">
									<i class="bi bi-person-fill-x"></i>
									<div>${message}</div>
									<button type="button" class="btn-close" data-bs-dismiss="alert"
										aria-label="Close"></button>
								</div>
							</c:if>
						</div>

						<form action="${pageContext.request.contextPath}/register"
							method="post" class="m-3">

							<div class="form-floating mb-3">
								<input type="text" class="form-control" id="username"
									name="username" value="${username }"> <label
									for="username"><fmt:message key="register.username" /></label>
							</div>

							<div class="form-floating mb-3">
								<input type="password" class="form-control" id="password"
									name="password"> <label for="password"><fmt:message
										key="register.password" /></label>
							</div>

							<div class="form-floating mb-3">
								<input type="password" class="form-control" id="confirmpassword"
									name="confirmpassword"> <label for="confirmpassword"><fmt:message
										key="register.confirmpassword" /></label>
							</div>

							<div class="form-floating mb-3">
								<input type="text" class="form-control" id="fullname"
									name="fullname" value="${fullname }"> <label
									for="fullname"><fmt:message key="register.fullname" /></label>
							</div>

							<div class="form-floating mb-3">
								<input type="email" class="form-control" id="email" name="email"
									value="${email }"> <label for="email"><fmt:message
										key="register.email" /></label>
							</div>

							<div class="d-grid gap-2 mb-4">
								<button type="submit" class="btn btn-success fw-bold shadow-sm">
									<fmt:message key="register.button" />
								</button>
							</div>

							<div class="text-center">
								<a class="btn btn-link text-decoration-none fw-bold"
									href="${pageContext.request.contextPath}/login"> <i
									class="bi bi-arrow-left-square"></i> <fmt:message
										key="login.button" />
								</a>
							</div>

						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>