// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'statistics.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CompareLastMonth _$CompareLastMonthFromJson(Map<String, dynamic> json) {
  return CompareLastMonth(
    json['limitSetted'] as bool,
    json['limit'] as int,
    (json['percent'] as num)?.toDouble(),
    (json['totalPay'] as num)?.toDouble(),
    (json['totalIncome'] as num)?.toDouble(),
    (json['totalPayCompare'] as num)?.toDouble(),
    (json['totalIncomeCompare'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$CompareLastMonthToJson(CompareLastMonth instance) =>
    <String, dynamic>{
      'limitSetted': instance.limitSetted,
      'limit': instance.limit,
      'percent': instance.percent,
      'totalPay': instance.totalPay,
      'totalIncome': instance.totalIncome,
      'totalPayCompare': instance.totalPayCompare,
      'totalIncomeCompare': instance.totalIncomeCompare,
    };

YearlyAmount _$YearlyAmountFromJson(Map<String, dynamic> json) {
  return YearlyAmount(
    (json['totalPay'] as num)?.toDouble(),
    (json['totalIncome'] as num)?.toDouble(),
    (json['totalRemain'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$YearlyAmountToJson(YearlyAmount instance) =>
    <String, dynamic>{
      'totalPay': instance.totalPay,
      'totalIncome': instance.totalIncome,
      'totalRemain': instance.totalRemain,
    };

MonthliAmount _$MonthliAmountFromJson(Map<String, dynamic> json) {
  return MonthliAmount(
    json['billMonth'] as String,
    (json['totalPay'] as num)?.toDouble(),
    (json['totalIncome'] as num)?.toDouble(),
    (json['totalRemain'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$MonthliAmountToJson(MonthliAmount instance) =>
    <String, dynamic>{
      'billMonth': instance.billMonth,
      'totalPay': instance.totalPay,
      'totalIncome': instance.totalIncome,
      'totalRemain': instance.totalRemain,
    };

YearlyAnalyze _$YearlyAnalyzeFromJson(Map<String, dynamic> json) {
  return YearlyAnalyze(
    json['yearlyAmounts'] == null
        ? null
        : YearlyAmount.fromJson(json['yearlyAmounts'] as Map<String, dynamic>),
    (json['monthlyAmounts'] as List)
        ?.map((e) => e == null
            ? null
            : MonthliAmount.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$YearlyAnalyzeToJson(YearlyAnalyze instance) =>
    <String, dynamic>{
      'yearlyAmounts': instance.yearlyAmounts,
      'monthlyAmounts': instance.monthlyAmounts,
    };

BillAmountsRow _$BillAmountsRowFromJson(Map<String, dynamic> json) {
  return BillAmountsRow(
    (json['totalAmount'] as num)?.toDouble(),
    json['category'] as String,
  );
}

Map<String, dynamic> _$BillAmountsRowToJson(BillAmountsRow instance) =>
    <String, dynamic>{
      'totalAmount': instance.totalAmount,
      'category': instance.category,
    };

DayAmountsRow _$DayAmountsRowFromJson(Map<String, dynamic> json) {
  return DayAmountsRow(
    (json['totalAmount'] as num)?.toDouble(),
    json['billDate'] as String,
  );
}

Map<String, dynamic> _$DayAmountsRowToJson(DayAmountsRow instance) =>
    <String, dynamic>{
      'totalAmount': instance.totalAmount,
      'billDate': instance.billDate,
    };

MonthAnalysis _$MonthAnalysisFromJson(Map<String, dynamic> json) {
  return MonthAnalysis(
    (json['monthDayAmount'] as List)
        ?.map((e) => e == null
            ? null
            : DayAmountsRow.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$MonthAnalysisToJson(MonthAnalysis instance) =>
    <String, dynamic>{
      'monthDayAmount': instance.monthDayAmount,
    };
