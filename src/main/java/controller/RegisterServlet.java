package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import service.UserService;

import java.io.IOException;

/**
 * Servlet implementation class RegisterServlet
 */
@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	UserService userService = new UserService();

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public RegisterServlet() {
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
		request.getRequestDispatcher("/views/register.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		try {
			String username = request.getParameter("username");
			String password = request.getParameter("password");
			String confirmpassword = request.getParameter("confirmpassword");
			String fullname = request.getParameter("fullname");
			String email = request.getParameter("email");

			userService.register(username, password, confirmpassword, fullname, email);

			request.getSession().setAttribute("flash_message", "Đăng ký thành công! Mời đăng nhập!");
			response.sendRedirect(request.getContextPath() + "/login");

		} catch (RuntimeException e) {
			request.setAttribute("message", e.getMessage());
			request.setAttribute("username", request.getParameter("username"));
			request.setAttribute("fullname", request.getParameter("fullname"));
			request.setAttribute("email", request.getParameter("email"));
			request.getRequestDispatcher("/views/register.jsp").forward(request, response);

		}
	}

}
