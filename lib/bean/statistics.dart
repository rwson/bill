import 'package:json_annotation/json_annotation.dart';

part 'statistics.g.dart';

@JsonSerializable()
class CompareLastMonth {
  final bool limitSetted;
  final String limit;
  final double percent;
  final String totalPay;
  final String totalIncome;
  final String totalPayCompare;
  final String totalIncomeCompare;

  CompareLastMonth(this.limitSetted, this.limit, this.percent, this.totalPay, this.totalIncome, this.totalPayCompare, this.totalIncomeCompare);

  factory CompareLastMonth.fromJson(Map<String, dynamic> json) =>
      _$CompareLastMonthFromJson(json);

  Map<String, dynamic> toJson() => _$CompareLastMonthToJson(this);
}