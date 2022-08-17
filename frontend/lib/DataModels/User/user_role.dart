enum UserRole {
  user,
  admin,
  empty,
}

extension UserRoleExtension on UserRole {
  String get roleName {
    switch (this) {
      case UserRole.user:
        return "USER";
      case UserRole.admin:
        return "ADMIN";
      case UserRole.empty:
        return "EMPTY";
    }
  }

  static UserRole userRole(String roleString) {
    switch (roleString) {
      case "USER":
        return UserRole.user;
      case "ADMIN":
        return UserRole.admin;
    }
    return UserRole.empty;
  }
}
