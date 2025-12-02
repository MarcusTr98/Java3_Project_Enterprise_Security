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
 * Servlet implementation class AdminUserDetailServlet
 */
@WebServlet("/admin/users/detail")
public class AdminUserDetailServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private UserService userService = new UserService();

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public AdminUserDetailServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		String username = request.getParameter("username");
		UserEntity userToView = userService.findByUsername(username);

		if (userToView != null) {
			request.setAttribute("is_admin_view", true);
			request.setAttribute("user", userToView);
			request.getRequestDispatcher("/views/profile.jsp").forward(request, response);
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

	}

}
