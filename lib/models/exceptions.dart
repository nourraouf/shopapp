class httpExceptions implements Exception {
  final String exp;

  httpExceptions(this.exp);
  @override
  String toString() {
    return exp;
    // TODO: implement toString
    // return super.toString();
  }
}
