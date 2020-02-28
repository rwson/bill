// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'statistics.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CompareLastMonth _$CompareLastMonthFromJson(Map<String, dynamic> json) {
  return CompareLastMonth(
    json['limitSetted'] as bool,
    json['limit'] as String,
    (json['percent'] as num)?.toDouble(),
    json['totalPay'] as String,
    json['totalIncome'] as String,
    json['totalPayCompare'] as String,
    json['totalIncomeCompare'] as String,
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
