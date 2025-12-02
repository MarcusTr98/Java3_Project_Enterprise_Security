package entity;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class UserEntity {
	private int id;
	private String username, password, fullname, email, role;
	private boolean active; // true: Đang hoạt động, false: Bị khóa
	private LocalDateTime lastLogin;
}
