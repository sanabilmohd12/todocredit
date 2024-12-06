// ignore_for_file: public_member_api_docs, sort_constructors_first

class Todomodel {
  final String id;
  final String title;
  final num amount;
  final bool isCredited; 
  Todomodel({
    required this.id,
    required this.title,
    required this.amount,
    required this.isCredited,
  });

  Todomodel copyWith({
    String? id,
    String? title,
    num? amount,
    bool? isCredited,
  }) {
    return Todomodel(
      id: id ?? this.id,
      title: title ?? this.title,
      amount: amount ?? this.amount,
      isCredited: isCredited ?? this.isCredited,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'amount': amount,
      'isCredited': isCredited,
    };
  }

  factory Todomodel.fromMap(Map<String, dynamic> map) {
    return Todomodel(
      id: map['id'] as String,
      title: map['title'] as String,
      amount: map['amount'] as num,
      isCredited: map['isCredited'] as bool,
    );
  }

}
