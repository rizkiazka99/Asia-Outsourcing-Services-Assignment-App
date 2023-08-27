class InsertSalesResponse {
    bool success;
    String message;

    InsertSalesResponse({
        required this.success,
        required this.message,
    });

    factory InsertSalesResponse.fromJson(Map<String, dynamic> json) => InsertSalesResponse(
        success: json["success"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
    };
}