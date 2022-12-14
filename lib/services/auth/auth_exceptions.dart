abstract class AuthUserException implements Exception {}

// login exceptions
class UserNotFoundAuthException implements AuthUserException {}

class WrongPasswordAuthException implements AuthUserException {}

// register exceptions

class WeakPasswordAuthException implements AuthUserException {}

class EmailAlreadyInUseAuthException implements AuthUserException {}

class InvalidEmailAuthException implements AuthUserException {}

// generic exceptions

class GenericAuthException implements AuthUserException {}

class UserNotLoggedInAuthException implements AuthUserException {}

class UserRequiresRecentLogin implements AuthUserException {}
