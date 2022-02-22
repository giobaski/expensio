class CustomException implements Exception {
  String msg;
  CustomException(
      this.msg
      );
}

class NotFoundException implements Exception {
  String msg;
  NotFoundException(
      this.msg
      );
}