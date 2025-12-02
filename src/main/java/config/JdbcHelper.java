package config;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class JdbcHelper {
	private static String driver = "com.microsoft.sqlserver.jdbc.SQLServerDriver";
	private static String dbUrl = "jdbc:sqlserver://localhost:1433;databaseName=UserManagementDB;encrypt=true;trustServerCertificate=true";
	private static String user = "sa";
	private static String pass = "123";

	static {
		try {
			Class.forName(driver);
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Lỗi tải Driver SQL Server. Kiểm tra lại thư viện!", e);
		}
	}

	public static Connection openConnection() throws SQLException {
		return DriverManager.getConnection(dbUrl, user, pass);
	}

	// Hàm thực thi (INSERT, UPDATE, DELETE)
	public static void executeUpdate(String sql, Object... args) {
		try (Connection conn = openConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
			for (int i = 0; i < args.length; i++) {
				stmt.setObject(i + 1, args[i]);
			}
			stmt.executeUpdate();
		} catch (SQLException e) {
			throw new RuntimeException("Lỗi thực thi Update: " + e.getMessage(), e);
		}
	}

	// Hàm truy vấn (SELECT)
	public static ResultSet executeQuery(String sql, Object... args) {
		try {
			Connection conn = openConnection();
			PreparedStatement stmt = conn.prepareStatement(sql);
			for (int i = 0; i < args.length; i++) {
				stmt.setObject(i + 1, args[i]);
			}
			return stmt.executeQuery();
		} catch (SQLException e) {
			throw new RuntimeException("Lỗi thực thi Query: " + e.getMessage(), e);
		}
	}
}
