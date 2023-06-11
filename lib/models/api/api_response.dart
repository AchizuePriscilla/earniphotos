abstract class ApiResponse {}

class Success extends ApiResponse {
  final List<dynamic> data;

  Success(this.data);
}

class Failure extends ApiResponse {
  final String error;

  Failure(this.error);

  factory Failure.fromMap(Map<String, dynamic> json) {
    return Failure("Error has occured");
  }

  static String getErrorMessage(Object message) {
    if (message is List && message.isNotEmpty) {
      return message.first;
    }
    if (message is String) return message;
    return "Unknown error";
  }
}
