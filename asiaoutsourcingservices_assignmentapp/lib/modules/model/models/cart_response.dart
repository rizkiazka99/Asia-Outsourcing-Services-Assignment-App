class Cart {
  final String productId;
  final String productName;
  final String productValue;
  final String productSize;
  final int quantity;
  final String createdAt;

  Cart({
    required this.productId, 
    required this.productName, 
    required this.productValue, 
    required this.productSize, 
    required this.quantity,
    required this.createdAt
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic> {
      "productId": productId,
      "productName": productName,
      "productValue": productValue,
      "productSize": productSize,
      "quantity": quantity,
      "createdAt": createdAt
    };
  }
}