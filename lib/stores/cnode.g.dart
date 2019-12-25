// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cnode.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CNodeStore on _CNodeStore, Store {
  final _$nodesAtom = Atom(name: '_CNodeStore.nodes');

  @override
  CNodeBean get nodes {
    _$nodesAtom.context.enforceReadPolicy(_$nodesAtom);
    _$nodesAtom.reportObserved();
    return super.nodes;
  }

  @override
  set nodes(CNodeBean value) {
    _$nodesAtom.context.conditionallyRunInAction(() {
      super.nodes = value;
      _$nodesAtom.reportChanged();
    }, _$nodesAtom, name: '${_$nodesAtom.name}_set');
  }

  final _$countAtom = Atom(name: '_CNodeStore.count');

  @override
  int get count {
    _$countAtom.context.enforceReadPolicy(_$countAtom);
    _$countAtom.reportObserved();
    return super.count;
  }

  @override
  set count(int value) {
    _$countAtom.context.conditionallyRunInAction(() {
      super.count = value;
      _$countAtom.reportChanged();
    }, _$countAtom, name: '${_$countAtom.name}_set');
  }

  final _$getTopicsAsyncAction = AsyncAction('getTopics');

  @override
  Future getTopics() {
    return _$getTopicsAsyncAction.run(() => super.getTopics());
  }
}
