	<%@ page language="java" contentType="text/html; charset=UTF-8"
		pageEncoding="UTF-8"%>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
	
	<fmt:setBundle basename="global" />
	
	<nav
		class="navbar navbar-expand-lg navbar-dark bg-dark shadow-sm sticky-top">
		<div class="container">
			<a class="navbar-brand fw-bold text-warning"
				href="${pageContext.request.contextPath}/home"> <i
				class="bi bi-code-slash me-2"></i>MARCUS SYSTEM
			</a>
	
			<button class="navbar-toggler" type="button" data-bs-toggle="collapse"
				data-bs-target="#navbarContent">
				<span class="navbar-toggler-icon"></span>
			</button>
	
			<div class="collapse navbar-collapse" id="navbarContent">
	
				<ul class="navbar-nav me-auto mb-2 mb-lg-0">
					<li class="nav-item"><a class="nav-link active"
						href="${pageContext.request.contextPath}/home"> <i
							class="bi bi-house-door-fill me-1"></i> <fmt:message
								key="nav.home" />
					</a></li>
	
					<c:if test="${sessionScope.user.role == 'ADMIN'}">
	
						<li class="nav-item"><a class="nav-link text-info"
							href="${pageContext.request.contextPath}/admin/dashboard"> <i
								class="bi bi-speedometer2 me-1"></i> <fmt:message
									key="title.admin" />
						</a></li>
					</c:if>
				</ul>
	
				<div class="d-flex align-items-center gap-2">
	
					<div class="dropdown me-2">
						<button class="btn btn-sm btn-secondary dropdown-toggle"
							type="button" data-bs-toggle="dropdown">
							<i class="bi bi-translate"></i>
						</button>
						<ul class="dropdown-menu dropdown-menu-dark dropdown-menu-end">
							<li><a
								class="dropdown-item ${sessionScope.lang == 'vi' ? 'active' : ''}"
								href="?lang=vi">Tiếng Việt</a></li>
							<li><a
								class="dropdown-item ${sessionScope.lang == 'en' ? 'active' : ''}"
								href="?lang=en">English</a></li>
						</ul>
					</div>
	
					<c:choose>
						<%-- CASE 1: ĐÃ ĐĂNG NHẬP --%>
						<c:when test="${not empty sessionScope.user}">
							<div class="dropdown">
								<c:url value="/img/avatar_1.jpg" var="img" />
	
								<a
									class="btn btn-outline-light dropdown-toggle d-flex align-items-center gap-2"
									href="#" role="button" data-bs-toggle="dropdown"> <img
									src="${img}" alt="avatar" width="24" height="24"
									class="rounded-circle"> <span>${sessionScope.user.fullname}</span>
								</a>
								<ul class="dropdown-menu dropdown-menu-end shadow">
									<li><a class="dropdown-item"
										href="${pageContext.request.contextPath}/profile"> <i
											class="bi bi-person-circle me-2"></i> <fmt:message
												key="nav.profile" />
									</a></li>
									<li><hr class="dropdown-divider"></li>
									<li><a class="dropdown-item text-danger"
										href="${pageContext.request.contextPath}/logout"> <i
											class="bi bi-box-arrow-right me-2"></i> <fmt:message
												key="btn.logout" />
									</a></li>
								</ul>
							</div>
						</c:when>
	
						<%-- CASE 2: CHƯA ĐĂNG NHẬP --%>
						<c:otherwise>
							<a href="${pageContext.request.contextPath}/login"
								class="btn btn-primary btn-sm fw-bold"> <i
								class="bi bi-box-arrow-in-right me-1"></i> <fmt:message
									key="btn.login" />
							</a>
							<a href="${pageContext.request.contextPath}/register"
								class="btn btn-outline-warning btn-sm"> <fmt:message
									key="btn.register" />
							</a>
						</c:otherwise>
					</c:choose>
				</div>
			</div>
		</div>
	</nav>
