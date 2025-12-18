class Util {
  static String? emailValidator(String? email) {
    if (email == null || email.isEmpty) {
      return 'This field is required!';
    }
    final emailRegex = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';

    if (!RegExp(emailRegex).hasMatch(email)) {
      return 'Please enter a valid email address!';
    }
    return null;
  }
}
