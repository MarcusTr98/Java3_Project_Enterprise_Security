package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import service.UserService;

import java.io.IOException;

/**
 * Servlet implementation class AdminUserDeleteServlet
 */
@WebServlet("/admin/users/delete")
public class AdminUserDeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private UserService userService = new UserService();

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public AdminUserDeleteServlet() {
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
		try {
			String username = request.getParameter("username");
			userService.remove(username);
			request.getSession().setAttribute("flash_message", "Xóa thành công user: " + username);
		} catch (Exception e) {
			// TODO: handle exception
			request.getSession().setAttribute("flash_message", "Lỗi xóa user: " + e.getMessage());
		}
		response.sendRedirect(request.getContextPath() + "/admin/users");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub

	}

}
