class Input$NewUserInput {
  factory Input$NewUserInput({
    required String name,
    required String email,
    required String password,
  }) =>
      Input$NewUserInput._({
        r'name': name,
        r'email': email,
        r'password': password,
      });

  Input$NewUserInput._(this._$data);

  factory Input$NewUserInput.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$name = data['name'];
    result$data['name'] = (l$name as String);
    final l$email = data['email'];
    result$data['email'] = (l$email as String);
    final l$password = data['password'];
    result$data['password'] = (l$password as String);
    return Input$NewUserInput._(result$data);
  }

  Map<String, dynamic> _$data;

  String get name => (_$data['name'] as String);

  String get email => (_$data['email'] as String);

  String get password => (_$data['password'] as String);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$name = name;
    result$data['name'] = l$name;
    final l$email = email;
    result$data['email'] = l$email;
    final l$password = password;
    result$data['password'] = l$password;
    return result$data;
  }

  CopyWith$Input$NewUserInput<Input$NewUserInput> get copyWith =>
      CopyWith$Input$NewUserInput(
        this,
        (i) => i,
      );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Input$NewUserInput) || runtimeType != other.runtimeType) {
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
    final l$password = password;
    final lOther$password = other.password;
    if (l$password != lOther$password) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$name = name;
    final l$email = email;
    final l$password = password;
    return Object.hashAll([
      l$name,
      l$email,
      l$password,
    ]);
  }
}

abstract class CopyWith$Input$NewUserInput<TRes> {
  factory CopyWith$Input$NewUserInput(
    Input$NewUserInput instance,
    TRes Function(Input$NewUserInput) then,
  ) = _CopyWithImpl$Input$NewUserInput;

  factory CopyWith$Input$NewUserInput.stub(TRes res) =
      _CopyWithStubImpl$Input$NewUserInput;

  TRes call({
    String? name,
    String? email,
    String? password,
  });
}

class _CopyWithImpl$Input$NewUserInput<TRes>
    implements CopyWith$Input$NewUserInput<TRes> {
  _CopyWithImpl$Input$NewUserInput(
    this._instance,
    this._then,
  );

  final Input$NewUserInput _instance;

  final TRes Function(Input$NewUserInput) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? name = _undefined,
    Object? email = _undefined,
    Object? password = _undefined,
  }) =>
      _then(Input$NewUserInput._({
        ..._instance._$data,
        if (name != _undefined && name != null) 'name': (name as String),
        if (email != _undefined && email != null) 'email': (email as String),
        if (password != _undefined && password != null)
          'password': (password as String),
      }));
}

class _CopyWithStubImpl$Input$NewUserInput<TRes>
    implements CopyWith$Input$NewUserInput<TRes> {
  _CopyWithStubImpl$Input$NewUserInput(this._res);

  TRes _res;

  call({
    String? name,
    String? email,
    String? password,
  }) =>
      _res;
}
