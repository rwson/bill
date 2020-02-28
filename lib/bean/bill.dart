import 'package:json_annotation/json_annotation.dart';

part 'bill.g.dart';

@JsonSerializable()
class BillRow {
  final int id;
  final String category;
  final String amount;
  final String billDate;
  final String recordType;
  final String payMethod;
  final String billType;
  final String remark;

  BillRow(this.id, this.category, this.amount, this.billDate, this.billType, this.recordType, this.payMethod, this.remark);

  factory BillRow.fromJson(Map<String, dynamic> json) =>
      _$BillRowFromJson(json);

  Map<String, dynamic> toJson() => _$BillRowToJson(this);
}

@JsonSerializable()
class BillItem {
  final String billDate;
  final String totalPay;
  final String totalIncome;
  final List<BillRow> bills;

  BillItem(this.billDate, this.totalPay, this.totalIncome, this.bills);

  factory BillItem.fromJson(Map<String, dynamic> json) =>
      _$BillItemFromJson(json);

  Map<String, dynamic> toJson() => _$BillItemToJson(this);
}
