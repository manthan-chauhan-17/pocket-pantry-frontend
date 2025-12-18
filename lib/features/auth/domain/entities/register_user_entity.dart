class RegisterUserEntity {
  final int? statusCode;
  final String? message;
  final bool? success;
  final UserEntity? user;

  const RegisterUserEntity({
    this.statusCode,
    this.message,
    this.success,
    this.user,
  });
}

class UserEntity {
  final String? id;
  final String? name;
  final String? email;

  const UserEntity({this.id, this.name, this.email});
}
