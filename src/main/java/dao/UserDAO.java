package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import entity.UserEntity;
import config.JdbcHelper;

public class UserDAO {

	public UserEntity findByUsername(String username) {
		String sql = "SELECT * FROM Users WHERE username = ?";
		try (Connection conn = JdbcHelper.openConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
			stmt.setString(1, username);
			ResultSet rs = stmt.executeQuery();

			if (rs.next()) {
				UserEntity user = new UserEntity();
				user.setId(rs.getInt("Id"));
				user.setUsername(rs.getString("Username"));
				user.setPassword(rs.getString("Password")); // Lấy chuỗi hash về
				user.setFullname(rs.getString("Fullname"));
				user.setEmail(rs.getString("Email"));
				user.setRole(rs.getString("Role"));
				user.setActive(rs.getBoolean("IsActive"));
				// timestamp của SQL
				Timestamp time = rs.getTimestamp("LastLogin");
				if (time != null) {
					user.setLastLogin(time.toLocalDateTime());
				}
				return user;
			}
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("Lỗi DAO find by username: " + e);
		}
		return null;
	}

	public void updateLastLogin(String username) {
		String sql = " UPDATE Users SET LastLogin = GETDATE() WHERE Username=?";
		try {
			JdbcHelper.executeUpdate(sql, username);
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("Lỗi DAO update last login: " + e);
		}
	}

	public void create(UserEntity user) {
		String sql = "INSERT INTO Users (username, password, fullname, email, role) VALUES (?,?,?,?,?) ";
		try {
			JdbcHelper.executeUpdate(sql, user.getUsername(), user.getPassword(), user.getFullname(), user.getEmail(),
					user.getRole());
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("Lỗi create user: " + e);
			throw new RuntimeException("Lỗi DAO create user: " + e.getMessage());
		}
	}

	public void update(UserEntity user) {
		String sql = "UPDATE Users SET Fullname=?, Email=?, Role=?, IsActive=? WHERE Username=?";
		try {
			JdbcHelper.executeUpdate(sql, user.getFullname(), user.getEmail(), user.getRole(), user.isActive(),
					user.getUsername());
		} catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException("Lỗi cập nhật user: " + e.getMessage());
		}
	}

	public List<UserEntity> findAll() {
		List<UserEntity> list = new ArrayList<>();
		String sql = "SELECT * FROM Users";
		try (ResultSet rs = JdbcHelper.executeQuery(sql)) {
			while (rs.next()) {
				UserEntity user = new UserEntity();
				user.setId(rs.getInt("Id"));
				user.setUsername(rs.getString("Username"));
				user.setFullname(rs.getString("Fullname"));
				user.setEmail(rs.getString("Email"));
				user.setRole(rs.getString("Role"));
				user.setActive(rs.getBoolean("IsActive"));
				Timestamp time = rs.getTimestamp("LastLogin");
				if (time != null) {
					user.setLastLogin(time.toLocalDateTime());
				}
				list.add(user);
			}
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("Lỗi DAO find all: " + e);
		}
		return list;
	}

	public void remove(String username) {
		String sql = "DELETE FROM Users WHERE username=?";
		try {
			JdbcHelper.executeUpdate(sql, username);
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("Lỗi DAO remove user: " + e);
		}
	}

	public boolean checkEmailExist(String email, String currentUsername) {
		String sql = "SELECT TOP 1 1 FROM Users WHERE Email = ? AND Username != ?";
		try (var rs = JdbcHelper.executeQuery(sql, email, currentUsername)) {
			return rs.next();
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	public void changePassword(String username, String newHash) {
		String sql = "UPDATE Users SET Password=? WHERE Username=?";
		JdbcHelper.executeUpdate(sql, newHash, username);
	}
}
