class Transaction {
  int? id;
  String? message;
  String? pointableType;
  int? pointableId;
  dynamic? amount;
  dynamic? current;
  int? locked;
  String? createdAt;
  String? updatedAt;

  Transaction({
    this.id,
    this.message,
    this.pointableType,
    this.pointableId,
    this.amount,
    this.current,
    this.locked,
    this.createdAt,
    this.updatedAt,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'],
      message: json['message'],
      pointableType: json['pointable_type'],
      pointableId: json['pointable_id'],
      amount: json['amount'],
      current: json['current'],
      locked: json['locked'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'message': message,
      'pointable_type': pointableType,
      'pointable_id': pointableId,
      'amount': amount,
      'current': current,
      'locked': locked,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
