import 'dart:async';
import 'package:flutter/widgets.dart' as widgets;
import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;
import 'package:graphql_flutter/graphql_flutter.dart' as graphql_flutter;

class Variables$Query$SearchAvailability {
  factory Variables$Query$SearchAvailability({
    required String gymId,
    required String startTime,
    required String endTime,
    String? userId,
  }) =>
      Variables$Query$SearchAvailability._({
        r'gymId': gymId,
        r'startTime': startTime,
        r'endTime': endTime,
        if (userId != null) r'userId': userId,
      });

  Variables$Query$SearchAvailability._(this._$data);

  factory Variables$Query$SearchAvailability.fromJson(
      Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$gymId = data['gymId'];
    result$data['gymId'] = (l$gymId as String);
    final l$startTime = data['startTime'];
    result$data['startTime'] = (l$startTime as String);
    final l$endTime = data['endTime'];
    result$data['endTime'] = (l$endTime as String);
    if (data.containsKey('userId')) {
      final l$userId = data['userId'];
      result$data['userId'] = (l$userId as String?);
    }
    return Variables$Query$SearchAvailability._(result$data);
  }

  Map<String, dynamic> _$data;

  String get gymId => (_$data['gymId'] as String);

  String get startTime => (_$data['startTime'] as String);

  String get endTime => (_$data['endTime'] as String);

  String? get userId => (_$data['userId'] as String?);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$gymId = gymId;
    result$data['gymId'] = l$gymId;
    final l$startTime = startTime;
    result$data['startTime'] = l$startTime;
    final l$endTime = endTime;
    result$data['endTime'] = l$endTime;
    if (_$data.containsKey('userId')) {
      final l$userId = userId;
      result$data['userId'] = l$userId;
    }
    return result$data;
  }

  CopyWith$Variables$Query$SearchAvailability<
          Variables$Query$SearchAvailability>
      get copyWith => CopyWith$Variables$Query$SearchAvailability(
            this,
            (i) => i,
          );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Variables$Query$SearchAvailability) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$gymId = gymId;
    final lOther$gymId = other.gymId;
    if (l$gymId != lOther$gymId) {
      return false;
    }
    final l$startTime = startTime;
    final lOther$startTime = other.startTime;
    if (l$startTime != lOther$startTime) {
      return false;
    }
    final l$endTime = endTime;
    final lOther$endTime = other.endTime;
    if (l$endTime != lOther$endTime) {
      return false;
    }
    final l$userId = userId;
    final lOther$userId = other.userId;
    if (_$data.containsKey('userId') != other._$data.containsKey('userId')) {
      return false;
    }
    if (l$userId != lOther$userId) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$gymId = gymId;
    final l$startTime = startTime;
    final l$endTime = endTime;
    final l$userId = userId;
    return Object.hashAll([
      l$gymId,
      l$startTime,
      l$endTime,
      _$data.containsKey('userId') ? l$userId : const {},
    ]);
  }
}

abstract class CopyWith$Variables$Query$SearchAvailability<TRes> {
  factory CopyWith$Variables$Query$SearchAvailability(
    Variables$Query$SearchAvailability instance,
    TRes Function(Variables$Query$SearchAvailability) then,
  ) = _CopyWithImpl$Variables$Query$SearchAvailability;

  factory CopyWith$Variables$Query$SearchAvailability.stub(TRes res) =
      _CopyWithStubImpl$Variables$Query$SearchAvailability;

  TRes call({
    String? gymId,
    String? startTime,
    String? endTime,
    String? userId,
  });
}

class _CopyWithImpl$Variables$Query$SearchAvailability<TRes>
    implements CopyWith$Variables$Query$SearchAvailability<TRes> {
  _CopyWithImpl$Variables$Query$SearchAvailability(
    this._instance,
    this._then,
  );

  final Variables$Query$SearchAvailability _instance;

  final TRes Function(Variables$Query$SearchAvailability) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? gymId = _undefined,
    Object? startTime = _undefined,
    Object? endTime = _undefined,
    Object? userId = _undefined,
  }) =>
      _then(Variables$Query$SearchAvailability._({
        ..._instance._$data,
        if (gymId != _undefined && gymId != null) 'gymId': (gymId as String),
        if (startTime != _undefined && startTime != null)
          'startTime': (startTime as String),
        if (endTime != _undefined && endTime != null)
          'endTime': (endTime as String),
        if (userId != _undefined) 'userId': (userId as String?),
      }));
}

class _CopyWithStubImpl$Variables$Query$SearchAvailability<TRes>
    implements CopyWith$Variables$Query$SearchAvailability<TRes> {
  _CopyWithStubImpl$Variables$Query$SearchAvailability(this._res);

  TRes _res;

  call({
    String? gymId,
    String? startTime,
    String? endTime,
    String? userId,
  }) =>
      _res;
}

class Query$SearchAvailability {
  Query$SearchAvailability({
    this.availabilities,
    this.$__typename = 'Query',
  });

  factory Query$SearchAvailability.fromJson(Map<String, dynamic> json) {
    final l$availabilities = json['availabilities'];
    final l$$__typename = json['__typename'];
    return Query$SearchAvailability(
      availabilities: (l$availabilities as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : Query$SearchAvailability$availabilities.fromJson(
                  (e as Map<String, dynamic>)))
          .toList(),
      $__typename: (l$$__typename as String),
    );
  }

  final List<Query$SearchAvailability$availabilities?>? availabilities;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$availabilities = availabilities;
    _resultData['availabilities'] =
        l$availabilities?.map((e) => e?.toJson()).toList();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$availabilities = availabilities;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$availabilities == null
          ? null
          : Object.hashAll(l$availabilities.map((v) => v)),
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Query$SearchAvailability) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$availabilities = availabilities;
    final lOther$availabilities = other.availabilities;
    if (l$availabilities != null && lOther$availabilities != null) {
      if (l$availabilities.length != lOther$availabilities.length) {
        return false;
      }
      for (int i = 0; i < l$availabilities.length; i++) {
        final l$availabilities$entry = l$availabilities[i];
        final lOther$availabilities$entry = lOther$availabilities[i];
        if (l$availabilities$entry != lOther$availabilities$entry) {
          return false;
        }
      }
    } else if (l$availabilities != lOther$availabilities) {
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

extension UtilityExtension$Query$SearchAvailability
    on Query$SearchAvailability {
  CopyWith$Query$SearchAvailability<Query$SearchAvailability> get copyWith =>
      CopyWith$Query$SearchAvailability(
        this,
        (i) => i,
      );
}

abstract class CopyWith$Query$SearchAvailability<TRes> {
  factory CopyWith$Query$SearchAvailability(
    Query$SearchAvailability instance,
    TRes Function(Query$SearchAvailability) then,
  ) = _CopyWithImpl$Query$SearchAvailability;

  factory CopyWith$Query$SearchAvailability.stub(TRes res) =
      _CopyWithStubImpl$Query$SearchAvailability;

  TRes call({
    List<Query$SearchAvailability$availabilities?>? availabilities,
    String? $__typename,
  });
  TRes availabilities(
      Iterable<Query$SearchAvailability$availabilities?>? Function(
              Iterable<
                  CopyWith$Query$SearchAvailability$availabilities<
                      Query$SearchAvailability$availabilities>?>?)
          _fn);
}

class _CopyWithImpl$Query$SearchAvailability<TRes>
    implements CopyWith$Query$SearchAvailability<TRes> {
  _CopyWithImpl$Query$SearchAvailability(
    this._instance,
    this._then,
  );

  final Query$SearchAvailability _instance;

  final TRes Function(Query$SearchAvailability) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? availabilities = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Query$SearchAvailability(
        availabilities: availabilities == _undefined
            ? _instance.availabilities
            : (availabilities
                as List<Query$SearchAvailability$availabilities?>?),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));

  TRes availabilities(
          Iterable<Query$SearchAvailability$availabilities?>? Function(
                  Iterable<
                      CopyWith$Query$SearchAvailability$availabilities<
                          Query$SearchAvailability$availabilities>?>?)
              _fn) =>
      call(
          availabilities: _fn(_instance.availabilities?.map((e) => e == null
              ? null
              : CopyWith$Query$SearchAvailability$availabilities(
                  e,
                  (i) => i,
                )))?.toList());
}

class _CopyWithStubImpl$Query$SearchAvailability<TRes>
    implements CopyWith$Query$SearchAvailability<TRes> {
  _CopyWithStubImpl$Query$SearchAvailability(this._res);

  TRes _res;

  call({
    List<Query$SearchAvailability$availabilities?>? availabilities,
    String? $__typename,
  }) =>
      _res;

  availabilities(_fn) => _res;
}

const documentNodeQuerySearchAvailability = DocumentNode(definitions: [
  OperationDefinitionNode(
    type: OperationType.query,
    name: NameNode(value: 'SearchAvailability'),
    variableDefinitions: [
      VariableDefinitionNode(
        variable: VariableNode(name: NameNode(value: 'gymId')),
        type: NamedTypeNode(
          name: NameNode(value: 'ID'),
          isNonNull: true,
        ),
        defaultValue: DefaultValueNode(value: null),
        directives: [],
      ),
      VariableDefinitionNode(
        variable: VariableNode(name: NameNode(value: 'startTime')),
        type: NamedTypeNode(
          name: NameNode(value: 'String'),
          isNonNull: true,
        ),
        defaultValue: DefaultValueNode(value: null),
        directives: [],
      ),
      VariableDefinitionNode(
        variable: VariableNode(name: NameNode(value: 'endTime')),
        type: NamedTypeNode(
          name: NameNode(value: 'String'),
          isNonNull: true,
        ),
        defaultValue: DefaultValueNode(value: null),
        directives: [],
      ),
      VariableDefinitionNode(
        variable: VariableNode(name: NameNode(value: 'userId')),
        type: NamedTypeNode(
          name: NameNode(value: 'ID'),
          isNonNull: false,
        ),
        defaultValue: DefaultValueNode(value: null),
        directives: [],
      ),
    ],
    directives: [],
    selectionSet: SelectionSetNode(selections: [
      FieldNode(
        name: NameNode(value: 'availabilities'),
        alias: null,
        arguments: [
          ArgumentNode(
            name: NameNode(value: 'gym_id'),
            value: VariableNode(name: NameNode(value: 'gymId')),
          ),
          ArgumentNode(
            name: NameNode(value: 'start_time'),
            value: VariableNode(name: NameNode(value: 'startTime')),
          ),
          ArgumentNode(
            name: NameNode(value: 'end_time'),
            value: VariableNode(name: NameNode(value: 'endTime')),
          ),
          ArgumentNode(
            name: NameNode(value: 'user_id'),
            value: VariableNode(name: NameNode(value: 'userId')),
          ),
        ],
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
            name: NameNode(value: 'user_id'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
          FieldNode(
            name: NameNode(value: 'gym_id'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
          FieldNode(
            name: NameNode(value: 'start_time'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
          FieldNode(
            name: NameNode(value: 'end_time'),
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
Query$SearchAvailability _parserFn$Query$SearchAvailability(
        Map<String, dynamic> data) =>
    Query$SearchAvailability.fromJson(data);
typedef OnQueryComplete$Query$SearchAvailability = FutureOr<void> Function(
  Map<String, dynamic>?,
  Query$SearchAvailability?,
);

class Options$Query$SearchAvailability
    extends graphql.QueryOptions<Query$SearchAvailability> {
  Options$Query$SearchAvailability({
    String? operationName,
    required Variables$Query$SearchAvailability variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Query$SearchAvailability? typedOptimisticResult,
    Duration? pollInterval,
    graphql.Context? context,
    OnQueryComplete$Query$SearchAvailability? onComplete,
    graphql.OnQueryError? onError,
  })  : onCompleteWithParsed = onComplete,
        super(
          variables: variables.toJson(),
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
                    data == null
                        ? null
                        : _parserFn$Query$SearchAvailability(data),
                  ),
          onError: onError,
          document: documentNodeQuerySearchAvailability,
          parserFn: _parserFn$Query$SearchAvailability,
        );

  final OnQueryComplete$Query$SearchAvailability? onCompleteWithParsed;

  @override
  List<Object?> get properties => [
        ...super.onComplete == null
            ? super.properties
            : super.properties.where((property) => property != onComplete),
        onCompleteWithParsed,
      ];
}

class WatchOptions$Query$SearchAvailability
    extends graphql.WatchQueryOptions<Query$SearchAvailability> {
  WatchOptions$Query$SearchAvailability({
    String? operationName,
    required Variables$Query$SearchAvailability variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Query$SearchAvailability? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
          variables: variables.toJson(),
          operationName: operationName,
          fetchPolicy: fetchPolicy,
          errorPolicy: errorPolicy,
          cacheRereadPolicy: cacheRereadPolicy,
          optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
          context: context,
          document: documentNodeQuerySearchAvailability,
          pollInterval: pollInterval,
          eagerlyFetchResults: eagerlyFetchResults,
          carryForwardDataOnException: carryForwardDataOnException,
          fetchResults: fetchResults,
          parserFn: _parserFn$Query$SearchAvailability,
        );
}

class FetchMoreOptions$Query$SearchAvailability
    extends graphql.FetchMoreOptions {
  FetchMoreOptions$Query$SearchAvailability({
    required graphql.UpdateQuery updateQuery,
    required Variables$Query$SearchAvailability variables,
  }) : super(
          updateQuery: updateQuery,
          variables: variables.toJson(),
          document: documentNodeQuerySearchAvailability,
        );
}

extension ClientExtension$Query$SearchAvailability on graphql.GraphQLClient {
  Future<graphql.QueryResult<Query$SearchAvailability>>
      query$SearchAvailability(
              Options$Query$SearchAvailability options) async =>
          await this.query(options);
  graphql.ObservableQuery<Query$SearchAvailability>
      watchQuery$SearchAvailability(
              WatchOptions$Query$SearchAvailability options) =>
          this.watchQuery(options);
  void writeQuery$SearchAvailability({
    required Query$SearchAvailability data,
    required Variables$Query$SearchAvailability variables,
    bool broadcast = true,
  }) =>
      this.writeQuery(
        graphql.Request(
          operation:
              graphql.Operation(document: documentNodeQuerySearchAvailability),
          variables: variables.toJson(),
        ),
        data: data.toJson(),
        broadcast: broadcast,
      );
  Query$SearchAvailability? readQuery$SearchAvailability({
    required Variables$Query$SearchAvailability variables,
    bool optimistic = true,
  }) {
    final result = this.readQuery(
      graphql.Request(
        operation:
            graphql.Operation(document: documentNodeQuerySearchAvailability),
        variables: variables.toJson(),
      ),
      optimistic: optimistic,
    );
    return result == null ? null : Query$SearchAvailability.fromJson(result);
  }
}

graphql_flutter.QueryHookResult<Query$SearchAvailability>
    useQuery$SearchAvailability(Options$Query$SearchAvailability options) =>
        graphql_flutter.useQuery(options);
graphql.ObservableQuery<Query$SearchAvailability>
    useWatchQuery$SearchAvailability(
            WatchOptions$Query$SearchAvailability options) =>
        graphql_flutter.useWatchQuery(options);

class Query$SearchAvailability$Widget
    extends graphql_flutter.Query<Query$SearchAvailability> {
  Query$SearchAvailability$Widget({
    widgets.Key? key,
    required Options$Query$SearchAvailability options,
    required graphql_flutter.QueryBuilder<Query$SearchAvailability> builder,
  }) : super(
          key: key,
          options: options,
          builder: builder,
        );
}

class Query$SearchAvailability$availabilities {
  Query$SearchAvailability$availabilities({
    required this.id,
    required this.user_id,
    required this.gym_id,
    required this.start_time,
    required this.end_time,
    this.$__typename = 'Availability',
  });

  factory Query$SearchAvailability$availabilities.fromJson(
      Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$user_id = json['user_id'];
    final l$gym_id = json['gym_id'];
    final l$start_time = json['start_time'];
    final l$end_time = json['end_time'];
    final l$$__typename = json['__typename'];
    return Query$SearchAvailability$availabilities(
      id: (l$id as int),
      user_id: (l$user_id as int),
      gym_id: (l$gym_id as int),
      start_time: (l$start_time as String),
      end_time: (l$end_time as String),
      $__typename: (l$$__typename as String),
    );
  }

  final int id;

  final int user_id;

  final int gym_id;

  final String start_time;

  final String end_time;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$id = id;
    _resultData['id'] = l$id;
    final l$user_id = user_id;
    _resultData['user_id'] = l$user_id;
    final l$gym_id = gym_id;
    _resultData['gym_id'] = l$gym_id;
    final l$start_time = start_time;
    _resultData['start_time'] = l$start_time;
    final l$end_time = end_time;
    _resultData['end_time'] = l$end_time;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$user_id = user_id;
    final l$gym_id = gym_id;
    final l$start_time = start_time;
    final l$end_time = end_time;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$id,
      l$user_id,
      l$gym_id,
      l$start_time,
      l$end_time,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Query$SearchAvailability$availabilities) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
      return false;
    }
    final l$user_id = user_id;
    final lOther$user_id = other.user_id;
    if (l$user_id != lOther$user_id) {
      return false;
    }
    final l$gym_id = gym_id;
    final lOther$gym_id = other.gym_id;
    if (l$gym_id != lOther$gym_id) {
      return false;
    }
    final l$start_time = start_time;
    final lOther$start_time = other.start_time;
    if (l$start_time != lOther$start_time) {
      return false;
    }
    final l$end_time = end_time;
    final lOther$end_time = other.end_time;
    if (l$end_time != lOther$end_time) {
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

extension UtilityExtension$Query$SearchAvailability$availabilities
    on Query$SearchAvailability$availabilities {
  CopyWith$Query$SearchAvailability$availabilities<
          Query$SearchAvailability$availabilities>
      get copyWith => CopyWith$Query$SearchAvailability$availabilities(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Query$SearchAvailability$availabilities<TRes> {
  factory CopyWith$Query$SearchAvailability$availabilities(
    Query$SearchAvailability$availabilities instance,
    TRes Function(Query$SearchAvailability$availabilities) then,
  ) = _CopyWithImpl$Query$SearchAvailability$availabilities;

  factory CopyWith$Query$SearchAvailability$availabilities.stub(TRes res) =
      _CopyWithStubImpl$Query$SearchAvailability$availabilities;

  TRes call({
    int? id,
    int? user_id,
    int? gym_id,
    String? start_time,
    String? end_time,
    String? $__typename,
  });
}

class _CopyWithImpl$Query$SearchAvailability$availabilities<TRes>
    implements CopyWith$Query$SearchAvailability$availabilities<TRes> {
  _CopyWithImpl$Query$SearchAvailability$availabilities(
    this._instance,
    this._then,
  );

  final Query$SearchAvailability$availabilities _instance;

  final TRes Function(Query$SearchAvailability$availabilities) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? id = _undefined,
    Object? user_id = _undefined,
    Object? gym_id = _undefined,
    Object? start_time = _undefined,
    Object? end_time = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Query$SearchAvailability$availabilities(
        id: id == _undefined || id == null ? _instance.id : (id as int),
        user_id: user_id == _undefined || user_id == null
            ? _instance.user_id
            : (user_id as int),
        gym_id: gym_id == _undefined || gym_id == null
            ? _instance.gym_id
            : (gym_id as int),
        start_time: start_time == _undefined || start_time == null
            ? _instance.start_time
            : (start_time as String),
        end_time: end_time == _undefined || end_time == null
            ? _instance.end_time
            : (end_time as String),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));
}

class _CopyWithStubImpl$Query$SearchAvailability$availabilities<TRes>
    implements CopyWith$Query$SearchAvailability$availabilities<TRes> {
  _CopyWithStubImpl$Query$SearchAvailability$availabilities(this._res);

  TRes _res;

  call({
    int? id,
    int? user_id,
    int? gym_id,
    String? start_time,
    String? end_time,
    String? $__typename,
  }) =>
      _res;
}
