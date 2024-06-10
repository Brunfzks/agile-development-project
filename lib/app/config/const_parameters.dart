class ConstParameters {
  static getUrlBase({bool isProtected = false}) {
    if (isProtected) {
      return 'http://localhost:8080/protected/';
    }
    return 'http://localhost:8080/';
  }

  static const double constPadding = 16;
}
