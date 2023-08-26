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

class Table {
    int no;
    String productId;
    String productName;
    String productDescription;
    String productValue;
    String productType;
    String productPhoto;

    Table({
        required this.no,
        required this.productId,
        required this.productName,
        required this.productDescription,
        required this.productValue,
        required this.productType,
        required this.productPhoto,
    });

    factory Table.fromJson(Map<String, dynamic> json) => Table(
        no: json["NO"],
        productId: json["productId"],
        productName: json["productName"],
        productDescription: json["productDescription"],
        productValue: json["productValue"],
        productType: json["productType"],
        productPhoto: json["productPhoto"],
    );

    Map<String, dynamic> toJson() => {
        "NO": no,
        "productId": productId,
        "productName": productName,
        "productDescription": productDescription,
        "productValue": productValue,
        "productType": productType,
        "productPhoto": productPhoto,
    };
}

class Table1 {
    int totalPage;

    Table1({
        required this.totalPage,
    });

    factory Table1.fromJson(Map<String, dynamic> json) => Table1(
        totalPage: json["totalPage"],
    );

    Map<String, dynamic> toJson() => {
        "totalPage": totalPage,
    };
}