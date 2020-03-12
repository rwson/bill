import 'package:json_annotation/json_annotation.dart';

part 'analysis.g.dart';

@JsonSerializable()
class BillAmountsRow {
  final String totalAmount;
  final String category;

  BillAmountsRow(this.totalAmount, this.category);

  factory BillAmountsRow.fromJson(Map<String, dynamic> json) =>
      _$BillAmountsRowFromJson(json);

  Map<String, dynamic> toJson() => _$BillAmountsRowToJson(this);
}

@JsonSerializable()
class Analysis {
  final String billDate;
  final String totalPay;
  final String totalIncome;
  final List<BillAmountsRow> billAmounts;

  Analysis(this.billDate, this.totalPay, this.totalIncome, this.billAmounts);

  factory Analysis.fromJson(Map<String, dynamic> json) =>
      _$AnalysisFromJson(json);

  Map<String, dynamic> toJson() => _$AnalysisToJson(this);
}
