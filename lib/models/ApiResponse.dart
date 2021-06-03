class ApiResponse {
  final int status;
  final String description;
  final dynamic response;

  ApiResponse({this.status, this.description, this.response});

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      status: json['status'],
      description: json['description'],
      response: json['response'],
    );
  }
}