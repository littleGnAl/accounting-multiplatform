class Accounting {
  final int id;
  final double amount;
  final DateTime createTime;
  final String tagName;
  final String remarks;

  Accounting(
      {this.id, this.amount, this.createTime, this.tagName, this.remarks});

  factory Accounting.fromMap(Map<String, dynamic> json) => Accounting(
      id: json["id"],
      amount: json["amount"],
      createTime: DateTime.fromMillisecondsSinceEpoch(json["createTime"]),
      tagName: json["tag_name"],
      remarks: json["remarks"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "amount": amount,
        "createTime": createTime.millisecondsSinceEpoch,
        "tag_name": tagName,
        "remarks": remarks
      };

  Map<String, dynamic> toInsertJson() => {
        "amount": amount,
        "createTime": createTime.millisecondsSinceEpoch,
        "tag_name": tagName,
        "remarks": remarks
      };

  List toInsertArgs() =>
      [amount, createTime.millisecondsSinceEpoch, tagName, remarks];

  @override
  String toString() {
    return 'Accounting{id: $id, amount: $amount, createTime: $createTime,'
        ' tagName: $tagName, remarks: $remarks}';
  }
}
