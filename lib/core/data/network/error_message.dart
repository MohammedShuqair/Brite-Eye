
/// A class representing an error message.
class ErrorMessage {
  /// The error message.
  String? message;

  /// Creates an instance of [ErrorMessage].
  ErrorMessage({
    this.message,
  });

  /// Creates an instance of [ErrorMessage] from a JSON map.
  ///
  /// [json] is the JSON map to be converted.
  /// Returns an instance of [ErrorMessage].
  factory ErrorMessage.fromJson(Map<String, dynamic> json) {
    return ErrorMessage(
      message: json.isEmpty ? null : json.values.join(", "),
    );
  }

  /// Converts the [ErrorMessage] instance to a JSON map.
  ///
  /// Returns a JSON map representing the [ErrorMessage].
  Map<String, dynamic> toJson() => {
        "message": message,
      };
}
