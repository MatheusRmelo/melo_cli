abstract class Response {}

class Success extends Response {}

class ErrorResponse extends Response {
  String error;

  ErrorResponse(this.error);
}
