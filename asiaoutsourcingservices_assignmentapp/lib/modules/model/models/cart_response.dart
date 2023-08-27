class Cart {
  final int? id;
  final String productId;
  final String productName;
  final String productPhoto;
  final String productValue;
  final String productSize;
  int quantity;
  final String createdAt;

  Cart({
    this.id,
    required this.productId, 
    required this.productName,
    required this.productPhoto,
    required this.productValue, 
    required this.productSize, 
    required this.quantity,
    required this.createdAt
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic> {
      "id": id,
      "productId": productId,
      "productName": productName,
      "productPhoto": productPhoto,
      "productValue": productValue,
      "productSize": productSize,
      "quantity": quantity,
      "createdAt": createdAt
    };
  }
}