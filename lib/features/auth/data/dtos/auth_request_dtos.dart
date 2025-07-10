// lib/features/auth/data/dtos/auth_request_dtos.dart

class LoginRequestDto {
  final String emailOrUsername;
  final String password;

  const LoginRequestDto({
    required this.emailOrUsername,
    required this.password,
  });

  Map<String, dynamic> toJson() => {
    'emailOrUsername': emailOrUsername,
    'password': password,
  };
}

class RegisterRequestDto {
  final String username;
  final String email;
  final String password;

  const RegisterRequestDto({
    required this.username,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() => {
    'username': username,
    'email': email,
    'password': password,
  };
}

class GoogleTokenRequestDto {
  final String googleToken;
  final GoogleUserInfoDto userInfo;

  const GoogleTokenRequestDto({
    required this.googleToken,
    required this.userInfo,
  });

  Map<String, dynamic> toJson() => {
    'googleToken': googleToken,
    'userInfo': userInfo.toJson(),
  };
}

class GoogleUserInfoDto {
  final String email;
  final String name;
  final String id;

  const GoogleUserInfoDto({
    required this.email,
    required this.name,
    required this.id,
  });

  Map<String, dynamic> toJson() => {
    'email': email,
    'name': name,
    'id': id,
  };
}

class RefreshTokenRequestDto {
  final String refreshToken;

  const RefreshTokenRequestDto({
    required this.refreshToken,
  });

  Map<String, dynamic> toJson() => {
    'refreshToken': refreshToken,
  };
}

class ChangePasswordRequestDto {
  final String currentPassword;
  final String newPassword;

  const ChangePasswordRequestDto({
    required this.currentPassword,
    required this.newPassword,
  });

  Map<String, dynamic> toJson() => {
    'currentPassword': currentPassword,
    'newPassword': newPassword,
  };
}

class VerifyEmailRequestDto {
  final String token;

  const VerifyEmailRequestDto({
    required this.token,
  });

  Map<String, dynamic> toJson() => {
    'token': token,
  };
}