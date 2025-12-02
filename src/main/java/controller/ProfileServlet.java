package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import service.UserService;

import java.io.IOException;

import entity.UserEntity;

/**
 * Servlet implementation class ProfileServlet
 */
@WebServlet("/profile")
public class ProfileServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private UserService userService = new UserService();

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public ProfileServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession();
		// Lấy User đang đăng nhập từ Session
		UserEntity userInSession = (UserEntity) session.getAttribute("user");

		if (userInSession == null) {
			// Đây là trường hợp hiếm gặp nếu AuthFilter hoạt động đúng, nhưng vẫn nên xử lý
			session.setAttribute("flash_message", "Vui lòng đăng nhập để xem hồ sơ!");
			response.sendRedirect(request.getContextPath() + "/login");
			return;
		}

		// Dữ liệu này dùng cho ${requestScope.user} trong JSP
		request.setAttribute("user", userInSession);
		request.getRequestDispatcher("/views/profile.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession();
		UserEntity userInSession = (UserEntity) session.getAttribute("user");

		if (userInSession == null) {
			response.sendRedirect(request.getContextPath() + "/logout");
			return;
		}

		try {
			String fullname = request.getParameter("fullname");
			String email = request.getParameter("email");

			// Lấy các giá trị không đổi từ Session (để tránh bị người dùng sửa qua form)
			String username = userInSession.getUsername();
			String role = userInSession.getRole();
			boolean isActive = userInSession.isActive();

			UserEntity updatedUser = new UserEntity();
			updatedUser.setUsername(username);
			updatedUser.setFullname(fullname);
			updatedUser.setEmail(email);
			updatedUser.setRole(role);
			updatedUser.setActive(isActive);

			userService.update(updatedUser);
			session.setAttribute("user", updatedUser);
			request.setAttribute("message", "Cập nhật hồ sơ cá nhân thành công!");

		} catch (RuntimeException e) {
			request.setAttribute("message", "Lỗi cập nhật: " + e.getMessage());
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("message", "Đã xảy ra lỗi hệ thống khi cập nhật!");
		}
		request.getRequestDispatcher("/views/profile.jsp").forward(request, response);
	}
}
