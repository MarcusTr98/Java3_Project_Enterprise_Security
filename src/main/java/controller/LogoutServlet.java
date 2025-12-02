package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Servlet implementation class LogoutServlet
 */
@WebServlet("/logout")
public class LogoutServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public LogoutServlet() {
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
		// 1. 1. XÓA COOKIE (Phải khớp path với lúc tạo)
		// Tạo một cookie có cùng tên "c_user" nhưng thời hạn là 0 giây
		Cookie cookie = new Cookie("c_user", "");
		cookie.setMaxAge(0);
		cookie.setPath("/");
		response.addCookie(cookie);

		// 2. XÓA SESSION
		if (request.getSession() != null) {
			request.getSession().invalidate();
		}

		request.getSession().setAttribute("flash_message", "Đã đăng xuất thành công!");
		response.sendRedirect(request.getContextPath() + "/login");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
	}

}
