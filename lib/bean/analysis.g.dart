// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'analysis.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BillAmountsRow _$BillAmountsRowFromJson(Map<String, dynamic> json) {
  return BillAmountsRow(
    json['totalAmount'] as String,
    json['category'] as String,
  );
}

Map<String, dynamic> _$BillAmountsRowToJson(BillAmountsRow instance) =>
    <String, dynamic>{
      'totalAmount': instance.totalAmount,
      'category': instance.category,
    };

Analysis _$AnalysisFromJson(Map<String, dynamic> json) {
  return Analysis(
    json['billDate'] as String,
    json['totalPay'] as String,
    json['totalIncome'] as String,
    (json['billAmounts'] as List)
        ?.map((e) => e == null
            ? null
            : BillAmountsRow.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$AnalysisToJson(Analysis instance) => <String, dynamic>{
      'billDate': instance.billDate,
      'totalPay': instance.totalPay,
      'totalIncome': instance.totalIncome,
      'billAmounts': instance.billAmounts,
    };
