// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'permissions_notifier.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$PermissionsNotifierState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String errorText) error,
    required TResult Function() granted,
    required TResult Function() notGranted,
    required TResult Function() grantedSetupComplete,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String errorText)? error,
    TResult Function()? granted,
    TResult Function()? notGranted,
    TResult Function()? grantedSetupComplete,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String errorText)? error,
    TResult Function()? granted,
    TResult Function()? notGranted,
    TResult Function()? grantedSetupComplete,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ErrorText value) error,
    required TResult Function(_Granted value) granted,
    required TResult Function(_NotGranted value) notGranted,
    required TResult Function(_GrantedSetupComplete value) grantedSetupComplete,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_ErrorText value)? error,
    TResult Function(_Granted value)? granted,
    TResult Function(_NotGranted value)? notGranted,
    TResult Function(_GrantedSetupComplete value)? grantedSetupComplete,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ErrorText value)? error,
    TResult Function(_Granted value)? granted,
    TResult Function(_NotGranted value)? notGranted,
    TResult Function(_GrantedSetupComplete value)? grantedSetupComplete,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PermissionsNotifierStateCopyWith<$Res> {
  factory $PermissionsNotifierStateCopyWith(PermissionsNotifierState value,
          $Res Function(PermissionsNotifierState) then) =
      _$PermissionsNotifierStateCopyWithImpl<$Res>;
}

/// @nodoc
class _$PermissionsNotifierStateCopyWithImpl<$Res>
    implements $PermissionsNotifierStateCopyWith<$Res> {
  _$PermissionsNotifierStateCopyWithImpl(this._value, this._then);

  final PermissionsNotifierState _value;
  // ignore: unused_field
  final $Res Function(PermissionsNotifierState) _then;
}

/// @nodoc
abstract class _$$_ErrorTextCopyWith<$Res> {
  factory _$$_ErrorTextCopyWith(
          _$_ErrorText value, $Res Function(_$_ErrorText) then) =
      __$$_ErrorTextCopyWithImpl<$Res>;
  $Res call({String errorText});
}

/// @nodoc
class __$$_ErrorTextCopyWithImpl<$Res>
    extends _$PermissionsNotifierStateCopyWithImpl<$Res>
    implements _$$_ErrorTextCopyWith<$Res> {
  __$$_ErrorTextCopyWithImpl(
      _$_ErrorText _value, $Res Function(_$_ErrorText) _then)
      : super(_value, (v) => _then(v as _$_ErrorText));

  @override
  _$_ErrorText get _value => super._value as _$_ErrorText;

  @override
  $Res call({
    Object? errorText = freezed,
  }) {
    return _then(_$_ErrorText(
      errorText == freezed
          ? _value.errorText
          : errorText // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_ErrorText implements _ErrorText {
  const _$_ErrorText(this.errorText);

  @override
  final String errorText;

  @override
  String toString() {
    return 'PermissionsNotifierState.error(errorText: $errorText)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ErrorText &&
            const DeepCollectionEquality().equals(other.errorText, errorText));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(errorText));

  @JsonKey(ignore: true)
  @override
  _$$_ErrorTextCopyWith<_$_ErrorText> get copyWith =>
      __$$_ErrorTextCopyWithImpl<_$_ErrorText>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String errorText) error,
    required TResult Function() granted,
    required TResult Function() notGranted,
    required TResult Function() grantedSetupComplete,
  }) {
    return error(errorText);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String errorText)? error,
    TResult Function()? granted,
    TResult Function()? notGranted,
    TResult Function()? grantedSetupComplete,
  }) {
    return error?.call(errorText);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String errorText)? error,
    TResult Function()? granted,
    TResult Function()? notGranted,
    TResult Function()? grantedSetupComplete,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(errorText);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ErrorText value) error,
    required TResult Function(_Granted value) granted,
    required TResult Function(_NotGranted value) notGranted,
    required TResult Function(_GrantedSetupComplete value) grantedSetupComplete,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_ErrorText value)? error,
    TResult Function(_Granted value)? granted,
    TResult Function(_NotGranted value)? notGranted,
    TResult Function(_GrantedSetupComplete value)? grantedSetupComplete,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ErrorText value)? error,
    TResult Function(_Granted value)? granted,
    TResult Function(_NotGranted value)? notGranted,
    TResult Function(_GrantedSetupComplete value)? grantedSetupComplete,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _ErrorText implements PermissionsNotifierState {
  const factory _ErrorText(final String errorText) = _$_ErrorText;

  String get errorText => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  _$$_ErrorTextCopyWith<_$_ErrorText> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_GrantedCopyWith<$Res> {
  factory _$$_GrantedCopyWith(
          _$_Granted value, $Res Function(_$_Granted) then) =
      __$$_GrantedCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_GrantedCopyWithImpl<$Res>
    extends _$PermissionsNotifierStateCopyWithImpl<$Res>
    implements _$$_GrantedCopyWith<$Res> {
  __$$_GrantedCopyWithImpl(_$_Granted _value, $Res Function(_$_Granted) _then)
      : super(_value, (v) => _then(v as _$_Granted));

  @override
  _$_Granted get _value => super._value as _$_Granted;
}

/// @nodoc

class _$_Granted implements _Granted {
  const _$_Granted();

  @override
  String toString() {
    return 'PermissionsNotifierState.granted()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$_Granted);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String errorText) error,
    required TResult Function() granted,
    required TResult Function() notGranted,
    required TResult Function() grantedSetupComplete,
  }) {
    return granted();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String errorText)? error,
    TResult Function()? granted,
    TResult Function()? notGranted,
    TResult Function()? grantedSetupComplete,
  }) {
    return granted?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String errorText)? error,
    TResult Function()? granted,
    TResult Function()? notGranted,
    TResult Function()? grantedSetupComplete,
    required TResult orElse(),
  }) {
    if (granted != null) {
      return granted();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ErrorText value) error,
    required TResult Function(_Granted value) granted,
    required TResult Function(_NotGranted value) notGranted,
    required TResult Function(_GrantedSetupComplete value) grantedSetupComplete,
  }) {
    return granted(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_ErrorText value)? error,
    TResult Function(_Granted value)? granted,
    TResult Function(_NotGranted value)? notGranted,
    TResult Function(_GrantedSetupComplete value)? grantedSetupComplete,
  }) {
    return granted?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ErrorText value)? error,
    TResult Function(_Granted value)? granted,
    TResult Function(_NotGranted value)? notGranted,
    TResult Function(_GrantedSetupComplete value)? grantedSetupComplete,
    required TResult orElse(),
  }) {
    if (granted != null) {
      return granted(this);
    }
    return orElse();
  }
}

abstract class _Granted implements PermissionsNotifierState {
  const factory _Granted() = _$_Granted;
}

/// @nodoc
abstract class _$$_NotGrantedCopyWith<$Res> {
  factory _$$_NotGrantedCopyWith(
          _$_NotGranted value, $Res Function(_$_NotGranted) then) =
      __$$_NotGrantedCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_NotGrantedCopyWithImpl<$Res>
    extends _$PermissionsNotifierStateCopyWithImpl<$Res>
    implements _$$_NotGrantedCopyWith<$Res> {
  __$$_NotGrantedCopyWithImpl(
      _$_NotGranted _value, $Res Function(_$_NotGranted) _then)
      : super(_value, (v) => _then(v as _$_NotGranted));

  @override
  _$_NotGranted get _value => super._value as _$_NotGranted;
}

/// @nodoc

class _$_NotGranted implements _NotGranted {
  const _$_NotGranted();

  @override
  String toString() {
    return 'PermissionsNotifierState.notGranted()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$_NotGranted);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String errorText) error,
    required TResult Function() granted,
    required TResult Function() notGranted,
    required TResult Function() grantedSetupComplete,
  }) {
    return notGranted();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String errorText)? error,
    TResult Function()? granted,
    TResult Function()? notGranted,
    TResult Function()? grantedSetupComplete,
  }) {
    return notGranted?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String errorText)? error,
    TResult Function()? granted,
    TResult Function()? notGranted,
    TResult Function()? grantedSetupComplete,
    required TResult orElse(),
  }) {
    if (notGranted != null) {
      return notGranted();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ErrorText value) error,
    required TResult Function(_Granted value) granted,
    required TResult Function(_NotGranted value) notGranted,
    required TResult Function(_GrantedSetupComplete value) grantedSetupComplete,
  }) {
    return notGranted(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_ErrorText value)? error,
    TResult Function(_Granted value)? granted,
    TResult Function(_NotGranted value)? notGranted,
    TResult Function(_GrantedSetupComplete value)? grantedSetupComplete,
  }) {
    return notGranted?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ErrorText value)? error,
    TResult Function(_Granted value)? granted,
    TResult Function(_NotGranted value)? notGranted,
    TResult Function(_GrantedSetupComplete value)? grantedSetupComplete,
    required TResult orElse(),
  }) {
    if (notGranted != null) {
      return notGranted(this);
    }
    return orElse();
  }
}

abstract class _NotGranted implements PermissionsNotifierState {
  const factory _NotGranted() = _$_NotGranted;
}

/// @nodoc
abstract class _$$_GrantedSetupCompleteCopyWith<$Res> {
  factory _$$_GrantedSetupCompleteCopyWith(_$_GrantedSetupComplete value,
          $Res Function(_$_GrantedSetupComplete) then) =
      __$$_GrantedSetupCompleteCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_GrantedSetupCompleteCopyWithImpl<$Res>
    extends _$PermissionsNotifierStateCopyWithImpl<$Res>
    implements _$$_GrantedSetupCompleteCopyWith<$Res> {
  __$$_GrantedSetupCompleteCopyWithImpl(_$_GrantedSetupComplete _value,
      $Res Function(_$_GrantedSetupComplete) _then)
      : super(_value, (v) => _then(v as _$_GrantedSetupComplete));

  @override
  _$_GrantedSetupComplete get _value => super._value as _$_GrantedSetupComplete;
}

/// @nodoc

class _$_GrantedSetupComplete implements _GrantedSetupComplete {
  const _$_GrantedSetupComplete();

  @override
  String toString() {
    return 'PermissionsNotifierState.grantedSetupComplete()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$_GrantedSetupComplete);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String errorText) error,
    required TResult Function() granted,
    required TResult Function() notGranted,
    required TResult Function() grantedSetupComplete,
  }) {
    return grantedSetupComplete();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String errorText)? error,
    TResult Function()? granted,
    TResult Function()? notGranted,
    TResult Function()? grantedSetupComplete,
  }) {
    return grantedSetupComplete?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String errorText)? error,
    TResult Function()? granted,
    TResult Function()? notGranted,
    TResult Function()? grantedSetupComplete,
    required TResult orElse(),
  }) {
    if (grantedSetupComplete != null) {
      return grantedSetupComplete();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ErrorText value) error,
    required TResult Function(_Granted value) granted,
    required TResult Function(_NotGranted value) notGranted,
    required TResult Function(_GrantedSetupComplete value) grantedSetupComplete,
  }) {
    return grantedSetupComplete(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_ErrorText value)? error,
    TResult Function(_Granted value)? granted,
    TResult Function(_NotGranted value)? notGranted,
    TResult Function(_GrantedSetupComplete value)? grantedSetupComplete,
  }) {
    return grantedSetupComplete?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ErrorText value)? error,
    TResult Function(_Granted value)? granted,
    TResult Function(_NotGranted value)? notGranted,
    TResult Function(_GrantedSetupComplete value)? grantedSetupComplete,
    required TResult orElse(),
  }) {
    if (grantedSetupComplete != null) {
      return grantedSetupComplete(this);
    }
    return orElse();
  }
}

abstract class _GrantedSetupComplete implements PermissionsNotifierState {
  const factory _GrantedSetupComplete() = _$_GrantedSetupComplete;
}
