/// A class containing the API endpoints for the application.
class Endpoint {
  /// The base URL for the API.
  static const String baseUrl = "http://api.elwfaq.coach/api/";

  /// The endpoint for user login.
  static const String login = "${baseUrl}login";

  /// The endpoint for user registration.
  static const String register = "${baseUrl}register";

  static const String getCurrentUser = "${baseUrl}users/[id]";

  static const String child = "${baseUrl}children";

  static const String users = "${baseUrl}users";
}
