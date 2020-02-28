// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'statistics.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$StatisticsStore on _StatisticsStore, Store {
  final _$comparedAtom = Atom(name: '_StatisticsStore.compared');

  @override
  CompareLastMonth get compared {
    _$comparedAtom.context.enforceReadPolicy(_$comparedAtom);
    _$comparedAtom.reportObserved();
    return super.compared;
  }

  @override
  set compared(CompareLastMonth value) {
    _$comparedAtom.context.conditionallyRunInAction(() {
      super.compared = value;
      _$comparedAtom.reportChanged();
    }, _$comparedAtom, name: '${_$comparedAtom.name}_set');
  }

  final _$compareLastAsyncAction = AsyncAction('compareLast');

  @override
  Future<void> compareLast() {
    return _$compareLastAsyncAction.run(() => super.compareLast());
  }
}
