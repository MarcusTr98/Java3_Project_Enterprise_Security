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
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title><fmt:message key="title.login" /></title>
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

		<div class="text-end mb-3">
			<div class="btn-group shadow-sm">
				<a href="?lang=vi"
					class="btn btn-sm btn-outline-danger ${sessionScope.lang == 'vi' ? 'active' : ''}">Tiếng
					Việt</a> <a href="?lang=en"
					class="btn btn-sm btn-outline-primary ${sessionScope.lang == 'en' || empty sessionScope.lang ? 'active' : ''}">English</a>
			</div>
		</div>

		<div class="card mx-auto shadow-lg border-0 overflow-hidden"
			style="max-width: 960px;">
			<div class="row g-0">

				<c:url value="/img/login1.jpg" var="img" />
				<div class="col-md-6 d-none d-md-block bg-dark">
					<img src="${img}" class="img-fluid w-100 h-100 login-image"
						alt="Login Cover">
				</div>

				<div class="col-md-6 bg-white">
					<div class="card-body p-4 p-lg-5">

						<div class="text-center mb-4">
							<h2 class="fw-bold text-success">
								<fmt:message key="title.login" />
							</h2>
							<p class="text-muted small">
								<fmt:message key="login.wellcome" />
							</p>
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
							<c:if test="${not empty sessionScope.flash_message}">
								<div
									class="alert alert-warning alert-dismissible fade show d-flex align-items-center"
									role="alert">
									<i class="bi bi-person-fill-exclamation"></i>
									<div>${sessionScope.flash_message}</div>
									<button type="button" class="btn-close" data-bs-dismiss="alert"
										aria-label="Close"></button>
								</div>
								<c:remove var="flash_message" scope="session" />
							</c:if>
						</div>

						<form action="${pageContext.request.contextPath}/login"
							method="post">
							<div class="form-floating mb-3">
								<input type="text" class="form-control" id="username"
									name="username" placeholder="Username"> <label
									for="username"><fmt:message key="login.username" /></label>
							</div>

							<div class="form-floating mb-3">
								<input type="password" class="form-control" id="password"
									name="password" placeholder="Password"> <label
									for="password"><fmt:message key="login.password" /></label>
							</div>

							<div
								class="d-flex justify-content-between align-items-center mb-3">
								<div class="form-check">
									<input type="checkbox" class="form-check-input" id="remember"
										name="remember"> <label class="form-check-label small"
										for="remember"> <fmt:message key="login.remember" />
									</label>
								</div>
								<a href="#" class="small text-decoration-none"><fmt:message
										key="login.forgot" /></a>
							</div>

							<div class="d-grid gap-2 mb-4">
								<button type="submit"
									class="btn btn-primary btn-lg fw-bold shadow-sm">
									<fmt:message key="login.button" />
								</button>
							</div>

							<div class="text-center">
								<p class="text-muted small mb-0">
									<fmt:message key="login.question" />
								</p>
								<a href="${pageContext.request.contextPath}/register"
									class="btn btn-link text-decoration-none fw-bold"> <fmt:message
										key="register.button" /> <i class="bi bi-arrow-right-square"></i>
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