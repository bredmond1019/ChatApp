import 'dart:async';
import 'package:flutter/widgets.dart' as widgets;
import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;
import 'package:graphql_flutter/graphql_flutter.dart' as graphql_flutter;

class Query$FetchUsers {
  Query$FetchUsers({
    required this.users,
    this.$__typename = 'Query',
  });

  factory Query$FetchUsers.fromJson(Map<String, dynamic> json) {
    final l$users = json['users'];
    final l$$__typename = json['__typename'];
    return Query$FetchUsers(
      users: (l$users as List<dynamic>)
          .map((e) =>
              Query$FetchUsers$users.fromJson((e as Map<String, dynamic>)))
          .toList(),
      $__typename: (l$$__typename as String),
    );
  }

  final List<Query$FetchUsers$users> users;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$users = users;
    _resultData['users'] = l$users.map((e) => e.toJson()).toList();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$users = users;
    final l$$__typename = $__typename;
    return Object.hashAll([
      Object.hashAll(l$users.map((v) => v)),
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Query$FetchUsers) || runtimeType != other.runtimeType) {
      return false;
    }
    final l$users = users;
    final lOther$users = other.users;
    if (l$users.length != lOther$users.length) {
      return false;
    }
    for (int i = 0; i < l$users.length; i++) {
      final l$users$entry = l$users[i];
      final lOther$users$entry = lOther$users[i];
      if (l$users$entry != lOther$users$entry) {
        return false;
      }
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$FetchUsers on Query$FetchUsers {
  CopyWith$Query$FetchUsers<Query$FetchUsers> get copyWith =>
      CopyWith$Query$FetchUsers(
        this,
        (i) => i,
      );
}

abstract class CopyWith$Query$FetchUsers<TRes> {
  factory CopyWith$Query$FetchUsers(
    Query$FetchUsers instance,
    TRes Function(Query$FetchUsers) then,
  ) = _CopyWithImpl$Query$FetchUsers;

  factory CopyWith$Query$FetchUsers.stub(TRes res) =
      _CopyWithStubImpl$Query$FetchUsers;

  TRes call({
    List<Query$FetchUsers$users>? users,
    String? $__typename,
  });
  TRes users(
      Iterable<Query$FetchUsers$users> Function(
              Iterable<CopyWith$Query$FetchUsers$users<Query$FetchUsers$users>>)
          _fn);
}

class _CopyWithImpl$Query$FetchUsers<TRes>
    implements CopyWith$Query$FetchUsers<TRes> {
  _CopyWithImpl$Query$FetchUsers(
    this._instance,
    this._then,
  );

  final Query$FetchUsers _instance;

  final TRes Function(Query$FetchUsers) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? users = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Query$FetchUsers(
        users: users == _undefined || users == null
            ? _instance.users
            : (users as List<Query$FetchUsers$users>),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));

  TRes users(
          Iterable<Query$FetchUsers$users> Function(
                  Iterable<
                      CopyWith$Query$FetchUsers$users<Query$FetchUsers$users>>)
              _fn) =>
      call(
          users: _fn(_instance.users.map((e) => CopyWith$Query$FetchUsers$users(
                e,
                (i) => i,
              ))).toList());
}

class _CopyWithStubImpl$Query$FetchUsers<TRes>
    implements CopyWith$Query$FetchUsers<TRes> {
  _CopyWithStubImpl$Query$FetchUsers(this._res);

  TRes _res;

  call({
    List<Query$FetchUsers$users>? users,
    String? $__typename,
  }) =>
      _res;

  users(_fn) => _res;
}

const documentNodeQueryFetchUsers = DocumentNode(definitions: [
  OperationDefinitionNode(
    type: OperationType.query,
    name: NameNode(value: 'FetchUsers'),
    variableDefinitions: [],
    directives: [],
    selectionSet: SelectionSetNode(selections: [
      FieldNode(
        name: NameNode(value: 'users'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: SelectionSetNode(selections: [
          FieldNode(
            name: NameNode(value: 'id'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
          FieldNode(
            name: NameNode(value: 'name'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
          FieldNode(
            name: NameNode(value: 'email'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
          FieldNode(
            name: NameNode(value: '__typename'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
        ]),
      ),
      FieldNode(
        name: NameNode(value: '__typename'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
    ]),
  ),
]);
Query$FetchUsers _parserFn$Query$FetchUsers(Map<String, dynamic> data) =>
    Query$FetchUsers.fromJson(data);
typedef OnQueryComplete$Query$FetchUsers = FutureOr<void> Function(
  Map<String, dynamic>?,
  Query$FetchUsers?,
);

class Options$Query$FetchUsers extends graphql.QueryOptions<Query$FetchUsers> {
  Options$Query$FetchUsers({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Query$FetchUsers? typedOptimisticResult,
    Duration? pollInterval,
    graphql.Context? context,
    OnQueryComplete$Query$FetchUsers? onComplete,
    graphql.OnQueryError? onError,
  })  : onCompleteWithParsed = onComplete,
        super(
          operationName: operationName,
          fetchPolicy: fetchPolicy,
          errorPolicy: errorPolicy,
          cacheRereadPolicy: cacheRereadPolicy,
          optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
          pollInterval: pollInterval,
          context: context,
          onComplete: onComplete == null
              ? null
              : (data) => onComplete(
                    data,
                    data == null ? null : _parserFn$Query$FetchUsers(data),
                  ),
          onError: onError,
          document: documentNodeQueryFetchUsers,
          parserFn: _parserFn$Query$FetchUsers,
        );

  final OnQueryComplete$Query$FetchUsers? onCompleteWithParsed;

  @override
  List<Object?> get properties => [
        ...super.onComplete == null
            ? super.properties
            : super.properties.where((property) => property != onComplete),
        onCompleteWithParsed,
      ];
}

class WatchOptions$Query$FetchUsers
    extends graphql.WatchQueryOptions<Query$FetchUsers> {
  WatchOptions$Query$FetchUsers({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Query$FetchUsers? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
          operationName: operationName,
          fetchPolicy: fetchPolicy,
          errorPolicy: errorPolicy,
          cacheRereadPolicy: cacheRereadPolicy,
          optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
          context: context,
          document: documentNodeQueryFetchUsers,
          pollInterval: pollInterval,
          eagerlyFetchResults: eagerlyFetchResults,
          carryForwardDataOnException: carryForwardDataOnException,
          fetchResults: fetchResults,
          parserFn: _parserFn$Query$FetchUsers,
        );
}

class FetchMoreOptions$Query$FetchUsers extends graphql.FetchMoreOptions {
  FetchMoreOptions$Query$FetchUsers({required graphql.UpdateQuery updateQuery})
      : super(
          updateQuery: updateQuery,
          document: documentNodeQueryFetchUsers,
        );
}

extension ClientExtension$Query$FetchUsers on graphql.GraphQLClient {
  Future<graphql.QueryResult<Query$FetchUsers>> query$FetchUsers(
          [Options$Query$FetchUsers? options]) async =>
      await this.query(options ?? Options$Query$FetchUsers());
  graphql.ObservableQuery<Query$FetchUsers> watchQuery$FetchUsers(
          [WatchOptions$Query$FetchUsers? options]) =>
      this.watchQuery(options ?? WatchOptions$Query$FetchUsers());
  void writeQuery$FetchUsers({
    required Query$FetchUsers data,
    bool broadcast = true,
  }) =>
      this.writeQuery(
        graphql.Request(
            operation:
                graphql.Operation(document: documentNodeQueryFetchUsers)),
        data: data.toJson(),
        broadcast: broadcast,
      );
  Query$FetchUsers? readQuery$FetchUsers({bool optimistic = true}) {
    final result = this.readQuery(
      graphql.Request(
          operation: graphql.Operation(document: documentNodeQueryFetchUsers)),
      optimistic: optimistic,
    );
    return result == null ? null : Query$FetchUsers.fromJson(result);
  }
}

graphql_flutter.QueryHookResult<Query$FetchUsers> useQuery$FetchUsers(
        [Options$Query$FetchUsers? options]) =>
    graphql_flutter.useQuery(options ?? Options$Query$FetchUsers());
graphql.ObservableQuery<Query$FetchUsers> useWatchQuery$FetchUsers(
        [WatchOptions$Query$FetchUsers? options]) =>
    graphql_flutter.useWatchQuery(options ?? WatchOptions$Query$FetchUsers());

class Query$FetchUsers$Widget extends graphql_flutter.Query<Query$FetchUsers> {
  Query$FetchUsers$Widget({
    widgets.Key? key,
    Options$Query$FetchUsers? options,
    required graphql_flutter.QueryBuilder<Query$FetchUsers> builder,
  }) : super(
          key: key,
          options: options ?? Options$Query$FetchUsers(),
          builder: builder,
        );
}

class Query$FetchUsers$users {
  Query$FetchUsers$users({
    required this.id,
    required this.name,
    required this.email,
    this.$__typename = 'User',
  });

  factory Query$FetchUsers$users.fromJson(Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$name = json['name'];
    final l$email = json['email'];
    final l$$__typename = json['__typename'];
    return Query$FetchUsers$users(
      id: (l$id as int),
      name: (l$name as String),
      email: (l$email as String),
      $__typename: (l$$__typename as String),
    );
  }

  final int id;

  final String name;

  final String email;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$id = id;
    _resultData['id'] = l$id;
    final l$name = name;
    _resultData['name'] = l$name;
    final l$email = email;
    _resultData['email'] = l$email;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$name = name;
    final l$email = email;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$id,
      l$name,
      l$email,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Query$FetchUsers$users) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
      return false;
    }
    final l$name = name;
    final lOther$name = other.name;
    if (l$name != lOther$name) {
      return false;
    }
    final l$email = email;
    final lOther$email = other.email;
    if (l$email != lOther$email) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$FetchUsers$users on Query$FetchUsers$users {
  CopyWith$Query$FetchUsers$users<Query$FetchUsers$users> get copyWith =>
      CopyWith$Query$FetchUsers$users(
        this,
        (i) => i,
      );
}

abstract class CopyWith$Query$FetchUsers$users<TRes> {
  factory CopyWith$Query$FetchUsers$users(
    Query$FetchUsers$users instance,
    TRes Function(Query$FetchUsers$users) then,
  ) = _CopyWithImpl$Query$FetchUsers$users;

  factory CopyWith$Query$FetchUsers$users.stub(TRes res) =
      _CopyWithStubImpl$Query$FetchUsers$users;

  TRes call({
    int? id,
    String? name,
    String? email,
    String? $__typename,
  });
}

class _CopyWithImpl$Query$FetchUsers$users<TRes>
    implements CopyWith$Query$FetchUsers$users<TRes> {
  _CopyWithImpl$Query$FetchUsers$users(
    this._instance,
    this._then,
  );

  final Query$FetchUsers$users _instance;

  final TRes Function(Query$FetchUsers$users) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? id = _undefined,
    Object? name = _undefined,
    Object? email = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Query$FetchUsers$users(
        id: id == _undefined || id == null ? _instance.id : (id as int),
        name: name == _undefined || name == null
            ? _instance.name
            : (name as String),
        email: email == _undefined || email == null
            ? _instance.email
            : (email as String),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));
}

class _CopyWithStubImpl$Query$FetchUsers$users<TRes>
    implements CopyWith$Query$FetchUsers$users<TRes> {
  _CopyWithStubImpl$Query$FetchUsers$users(this._res);

  TRes _res;

  call({
    int? id,
    String? name,
    String? email,
    String? $__typename,
  }) =>
      _res;
}
