package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import service.UserService;

import java.io.IOException;

import entity.UserEntity;

/**
 * Servlet implementation class LoginServlet
 */
@WebServlet("/login")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private UserService userService = new UserService();

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public LoginServlet() {
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
		request.getRequestDispatcher("/views/login.jsp").forward(request, response);
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
			// Checkbox: trả về "on" hoặc nul
			String remember = request.getParameter("remember");

			UserEntity user = userService.login(username, password);

			// lưu session user đăng nhập
			HttpSession session = request.getSession();
			session.setAttribute("user", user);

			// xử lý cookie
			Cookie cookie = new Cookie("c_user", username);
			if (remember != null && remember.equals("on")) {
				cookie.setMaxAge(3 * 24 * 60 * 60);
			} else {
				cookie.setMaxAge(0);
			}
			cookie.setPath("/");

			// gửi cookie
			response.addCookie(cookie);
			response.sendRedirect(request.getContextPath() + "/home");

		} catch (RuntimeException e) {
			// TODO: handle exception
			request.setAttribute("message", e.getMessage());
			request.setAttribute("username", request.getParameter("username"));
			request.getRequestDispatcher("/views/login.jsp").forward(request, response);
		}
	}
}
