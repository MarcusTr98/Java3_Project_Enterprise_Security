package service;

import java.util.List;

import org.mindrot.jbcrypt.BCrypt;

import dao.UserDAO;
import entity.UserEntity;

public class UserService {

	private UserDAO userDAO = new UserDAO();

	public UserEntity login(String username, String rawPassword) {
		UserEntity user = userDAO.findByUsername(username);
		if (user == null) {
			throw new RuntimeException("Tài khoản không tồn tại!");
		}
		if (!user.isActive()) {
			throw new RuntimeException("Tài khoản đã bị khóa, vui lòng liên lạc Admin!");
		}
		boolean isMatch = BCrypt.checkpw(rawPassword, user.getPassword());
		if (!isMatch) {
			throw new RuntimeException("Sai mật khẩu!");
		}
		userDAO.updateLastLogin(username);

		return user;
	}

	public UserEntity loginFromCookie(String username) {
		UserEntity user = userDAO.findByUsername(username);
		if (user != null && user.isActive()) {
			return user;
		}
		return null;
	}

	public void register(String username, String password, String confirmPassword, String fullname, String email) {
		if (!password.equals(confirmPassword)) {
			throw new RuntimeException("Mật khẩu xác nhận không khớp!");
		}
		UserEntity existUsername = userDAO.findByUsername(username);
		if (existUsername != null) {
			throw new RuntimeException("Tên đăng nhập đã tồn tại!");
		}

		String hash = BCrypt.hashpw(password, BCrypt.gensalt(12));

		UserEntity newUser = new UserEntity();
		newUser.setUsername(username);
		newUser.setPassword(hash);
		newUser.setFullname(fullname);
		newUser.setEmail(email);
		newUser.setRole("USER");
		newUser.setActive(true);

		userDAO.create(newUser);
	}

	public List<UserEntity> findAll() {
		return userDAO.findAll();
	}

	public UserEntity findByUsername(String username) {
		return userDAO.findByUsername(username);
	}

	public void update(UserEntity user) {
		boolean isDuplicate = userDAO.checkEmailExist(user.getEmail(), user.getUsername());

		if (isDuplicate) {
			throw new RuntimeException("Email " + user.getEmail() + " đã được sử dụng bởi người khác!");
		}
		userDAO.update(user);
	}

	public void remove(String username) {
		if ("marcus".equalsIgnoreCase(username)) {
			throw new RuntimeException("Không thể xóa SuperAdmin!");
		}
		userDAO.remove(username);
	}

}
