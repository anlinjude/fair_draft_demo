class Friend {
  int? id;
  String? mobile;
  dynamic? amount;
  dynamic? locked;
  String? createdAt;
  dynamic? walletPoint;
  dynamic? lockedPoint;
  String? name;

  Friend({
    this.id,
    this.mobile,
    this.amount,
    this.locked,
    this.createdAt,
    this.walletPoint,
    this.lockedPoint,
    this.name
  });

  factory Friend.fromJson(Map<String, dynamic> json) {
    return Friend(
      id: json['id'],
      mobile: json['mobile'],
      amount: json['amount'],
      locked: json['locked'],
      createdAt: json['created_at'],
      walletPoint: json['wallet_point'],
      lockedPoint: json['locked_point'],
      name: json["name"]
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'mobile': mobile,
      'amount': amount,
      'locked': locked,
      'created_at': createdAt,
      'wallet_point': walletPoint,
      'locked_point': lockedPoint,
    };
  }
}
