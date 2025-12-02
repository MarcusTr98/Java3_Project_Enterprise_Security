package filter;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import service.UserService;

import java.io.IOException;

import entity.UserEntity;

/**
 * Servlet Filter implementation class AuthFilter
 */
@WebFilter("/*")
public class AuthFilter extends HttpFilter implements Filter {
	private UserService userService = new UserService();

	/**
	 * @see HttpFilter#HttpFilter()
	 */
	public AuthFilter() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see Filter#destroy()
	 */
	public void destroy() {
		// TODO Auto-generated method stub
	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		// TODO Auto-generated method stub
		// place your code here

		HttpServletRequest req = (HttpServletRequest) request;
		HttpServletResponse resp = (HttpServletResponse) response;

		String uri = req.getRequestURI();

		// 1.Công khai, cho qua luôn
		if (uri.contains("/login") || uri.contains("/register") || uri.contains("/img")) {
			chain.doFilter(req, resp);
			return;
		}

		// 2. Authentication
		HttpSession session = req.getSession();
		UserEntity user = (UserEntity) session.getAttribute("user");

		// Nếu Session không có, thử tìm trong Cookie (Auto Login)
		if (user == null) {
			String usernameInCookie = null;
			Cookie[] cookies = req.getCookies();
			if (cookies != null) {
				for (Cookie c : cookies) {
					if (c.getName().equals("c_user")) {
						usernameInCookie = c.getValue();
						break;
					}
				}
			}
			// Nếu tìm thấy cookie, gọi Service nạp lại user
			if (usernameInCookie != null) {
				UserEntity userFromCookie = userService.loginFromCookie(usernameInCookie);
				if (userFromCookie != null) {
					user = userFromCookie;
					session.setAttribute("user", user);
				}
			}
		}

		// 3. Kiểm tra Login
		if (user == null) {
			session.setAttribute("flash_message", "Vui lòng đăng nhập để tiếp tục!");
			resp.sendRedirect(req.getContextPath() + "/login");
			return;
		}

		// 4. Authorization
//		if (uri.contains("/dashboard") && user.getRole().equals("USER")) {
//			resp.sendRedirect(req.getContextPath() + "/home");
//			return;
//		}

		// 4. Authorization - Filter Admin
		// Kiểm tra xem URI có bắt đầu bằng /admin không
		if (uri.startsWith(req.getContextPath() + "/admin")) {
			if (user == null || !user.getRole().equals("ADMIN")) {
				session.setAttribute("flash_message", "Bạn không có quyền truy cập vào khu vực Quản trị!");
				resp.sendRedirect(req.getContextPath() + "/home");
				return;
			}
		}

		// 5. Cho qua
		chain.doFilter(req, resp);

	}

	/**
	 * @see Filter#init(FilterConfig)
	 */
	public void init(FilterConfig fConfig) throws ServletException {
		// TODO Auto-generated method stub
	}

}
