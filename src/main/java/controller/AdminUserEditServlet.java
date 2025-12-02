package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import service.UserService;

import java.io.IOException;

import entity.UserEntity;

/**
 * Servlet implementation class AdminUserEditServlet
 */
@WebServlet("/admin/users/edit")
public class AdminUserEditServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private UserService userService = new UserService();

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public AdminUserEditServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String username = request.getParameter("username");
		UserEntity user = userService.findByUsername(username);

		if (user != null) {
			request.setAttribute("user", user); // Đẩy sang JSP
			request.getRequestDispatcher("/views/edit-user.jsp").forward(request, response);
		} else {
			request.getSession().setAttribute("flash_message", "Không tìm thấy user: " + username);
			response.sendRedirect(request.getContextPath() + "/admin/users");
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		String username = request.getParameter("username");
		String fullname = request.getParameter("fullname");
		String email = request.getParameter("email");
		String role = request.getParameter("role");
		boolean active = Boolean.parseBoolean(request.getParameter("active"));

		try {
			UserEntity user = new UserEntity();
			user.setUsername(username);
			user.setFullname(fullname);
			user.setEmail(email);
			user.setRole(role);
			user.setActive(active);

			userService.update(user);

			request.getSession().setAttribute("flash_message", "Cập nhật thành công cho user: " + username);
			response.sendRedirect(request.getContextPath() + "/admin/users");

		} catch (Exception e) {
			UserEntity user = userService.findByUsername(username);
			request.setAttribute("user", user);
			request.setAttribute("message", "Lỗi: " + e.getMessage());
			request.getRequestDispatcher("/views/edit-user.jsp").forward(request, response);
		}
	}

}
