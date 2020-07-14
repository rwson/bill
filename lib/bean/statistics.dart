import 'package:json_annotation/json_annotation.dart';

part 'statistics.g.dart';

@JsonSerializable()
class CompareLastMonth {
  final bool limitSetted;
  final int limit;
  final double percent;
  final double totalPay;
  final double totalIncome;
  final double totalPayCompare;
  final double totalIncomeCompare;

  CompareLastMonth(this.limitSetted, this.limit, this.percent, this.totalPay, this.totalIncome, this.totalPayCompare, this.totalIncomeCompare);

  factory CompareLastMonth.fromJson(Map<String, dynamic> json) =>
      _$CompareLastMonthFromJson(json);

  Map<String, dynamic> toJson() => _$CompareLastMonthToJson(this);
}

@JsonSerializable()
class YearlyAmount {
  final double totalPay;
  final double totalIncome;
  final double totalRemain;

  YearlyAmount(this.totalPay, this.totalIncome, this.totalRemain);

  factory YearlyAmount.fromJson(Map<String, dynamic> json) =>
      _$YearlyAmountFromJson(json);

  Map<String, dynamic> toJson() => _$YearlyAmountToJson(this);
}

@JsonSerializable()
class MonthliAmount {
  final String billMonth;
  final double totalPay;
  final double totalIncome;
  final double totalRemain;

  MonthliAmount(this.billMonth, this.totalPay, this.totalIncome, this.totalRemain);

  factory MonthliAmount.fromJson(Map<String, dynamic> json) =>
      _$MonthliAmountFromJson(json);

  Map<String, dynamic> toJson() => _$MonthliAmountToJson(this);
}

@JsonSerializable()
class YearlyAnalyze {
  final YearlyAmount yearlyAmounts;
  final List<MonthliAmount> monthlyAmounts;

  YearlyAnalyze(this.yearlyAmounts, this.monthlyAmounts);

  factory YearlyAnalyze.fromJson(Map<String, dynamic> json) =>
      _$YearlyAnalyzeFromJson(json);

  Map<String, dynamic> toJson() => _$YearlyAnalyzeToJson(this);
}

@JsonSerializable()
class BillAmountsRow {
  final double totalAmount;
  final String category;

  BillAmountsRow(this.totalAmount, this.category);

  factory BillAmountsRow.fromJson(Map<String, dynamic> json) =>
      _$BillAmountsRowFromJson(json);

  Map<String, dynamic> toJson() => _$BillAmountsRowToJson(this);
}

@JsonSerializable()
class DayAmountsRow {
  final double totalAmount;
  final String billDate;

  DayAmountsRow(this.totalAmount, this.billDate);

  factory DayAmountsRow.fromJson(Map<String, dynamic> json) =>
      _$DayAmountsRowFromJson(json);

  Map<String, dynamic> toJson() => _$DayAmountsRowToJson(this);
}

@JsonSerializable()
class MonthAnalysis {
  // final List<BillAmountsRow> monthRanks;
  final List<DayAmountsRow> monthDayAmount;

  MonthAnalysis(this.monthDayAmount);

  factory MonthAnalysis.fromJson(Map<String, dynamic> json) =>
      _$MonthAnalysisFromJson(json);

  Map<String, dynamic> toJson() => _$MonthAnalysisToJson(this);
}
