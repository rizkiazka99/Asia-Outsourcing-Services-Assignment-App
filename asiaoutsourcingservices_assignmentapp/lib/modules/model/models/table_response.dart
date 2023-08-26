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