import 'package:asiaoutsourcingservices_assignmentapp/modules/model/models/table1_response.dart';
import 'table_response.dart';

class ProductsResponse {
    bool success;
    String message;
    Data data;

    ProductsResponse({
        required this.success,
        required this.message,
        required this.data,
    });

    factory ProductsResponse.fromJson(Map<String, dynamic> json) => ProductsResponse(
        success: json["success"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data.toJson(),
    };
}

class Data {
    List<Table> table;
    List<Table1> table1;

    Data({
        required this.table,
        required this.table1,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        table: List<Table>.from(json["Table"].map((x) => Table.fromJson(x))),
        table1: List<Table1>.from(json["Table1"].map((x) => Table1.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "Table": List<dynamic>.from(table.map((x) => x.toJson())),
        "Table1": List<dynamic>.from(table1.map((x) => x.toJson())),
    };
}