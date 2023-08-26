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