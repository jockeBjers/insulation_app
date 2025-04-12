// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'project.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Project _$ProjectFromJson(Map<String, dynamic> json) {
  return _Project.fromJson(json);
}

/// @nodoc
mixin _$Project {
  @JsonKey(includeIfNull: false)
  String? get id => throw _privateConstructorUsedError;
  String get projectNumber => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  DateTime get date => throw _privateConstructorUsedError;
  @JsonKey(includeIfNull: false)
  String? get organizationId => throw _privateConstructorUsedError;
  List<InsulatedPipe> get pipes => throw _privateConstructorUsedError;
  @JsonKey(includeIfNull: false)
  String? get address => throw _privateConstructorUsedError;
  @JsonKey(includeIfNull: false)
  String? get contactPerson => throw _privateConstructorUsedError;
  @JsonKey(includeIfNull: false)
  String? get contactNumber => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ProjectCopyWith<Project> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProjectCopyWith<$Res> {
  factory $ProjectCopyWith(Project value, $Res Function(Project) then) =
      _$ProjectCopyWithImpl<$Res, Project>;
  @useResult
  $Res call(
      {@JsonKey(includeIfNull: false) String? id,
      String projectNumber,
      String name,
      DateTime date,
      @JsonKey(includeIfNull: false) String? organizationId,
      List<InsulatedPipe> pipes,
      @JsonKey(includeIfNull: false) String? address,
      @JsonKey(includeIfNull: false) String? contactPerson,
      @JsonKey(includeIfNull: false) String? contactNumber});
}

/// @nodoc
class _$ProjectCopyWithImpl<$Res, $Val extends Project>
    implements $ProjectCopyWith<$Res> {
  _$ProjectCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? projectNumber = null,
    Object? name = null,
    Object? date = null,
    Object? organizationId = freezed,
    Object? pipes = null,
    Object? address = freezed,
    Object? contactPerson = freezed,
    Object? contactNumber = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      projectNumber: null == projectNumber
          ? _value.projectNumber
          : projectNumber // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      organizationId: freezed == organizationId
          ? _value.organizationId
          : organizationId // ignore: cast_nullable_to_non_nullable
              as String?,
      pipes: null == pipes
          ? _value.pipes
          : pipes // ignore: cast_nullable_to_non_nullable
              as List<InsulatedPipe>,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      contactPerson: freezed == contactPerson
          ? _value.contactPerson
          : contactPerson // ignore: cast_nullable_to_non_nullable
              as String?,
      contactNumber: freezed == contactNumber
          ? _value.contactNumber
          : contactNumber // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProjectImplCopyWith<$Res> implements $ProjectCopyWith<$Res> {
  factory _$$ProjectImplCopyWith(
          _$ProjectImpl value, $Res Function(_$ProjectImpl) then) =
      __$$ProjectImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(includeIfNull: false) String? id,
      String projectNumber,
      String name,
      DateTime date,
      @JsonKey(includeIfNull: false) String? organizationId,
      List<InsulatedPipe> pipes,
      @JsonKey(includeIfNull: false) String? address,
      @JsonKey(includeIfNull: false) String? contactPerson,
      @JsonKey(includeIfNull: false) String? contactNumber});
}

/// @nodoc
class __$$ProjectImplCopyWithImpl<$Res>
    extends _$ProjectCopyWithImpl<$Res, _$ProjectImpl>
    implements _$$ProjectImplCopyWith<$Res> {
  __$$ProjectImplCopyWithImpl(
      _$ProjectImpl _value, $Res Function(_$ProjectImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? projectNumber = null,
    Object? name = null,
    Object? date = null,
    Object? organizationId = freezed,
    Object? pipes = null,
    Object? address = freezed,
    Object? contactPerson = freezed,
    Object? contactNumber = freezed,
  }) {
    return _then(_$ProjectImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      projectNumber: null == projectNumber
          ? _value.projectNumber
          : projectNumber // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      organizationId: freezed == organizationId
          ? _value.organizationId
          : organizationId // ignore: cast_nullable_to_non_nullable
              as String?,
      pipes: null == pipes
          ? _value._pipes
          : pipes // ignore: cast_nullable_to_non_nullable
              as List<InsulatedPipe>,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      contactPerson: freezed == contactPerson
          ? _value.contactPerson
          : contactPerson // ignore: cast_nullable_to_non_nullable
              as String?,
      contactNumber: freezed == contactNumber
          ? _value.contactNumber
          : contactNumber // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ProjectImpl extends _Project {
  const _$ProjectImpl(
      {@JsonKey(includeIfNull: false) this.id,
      required this.projectNumber,
      required this.name,
      required this.date,
      @JsonKey(includeIfNull: false) this.organizationId,
      required final List<InsulatedPipe> pipes,
      @JsonKey(includeIfNull: false) this.address,
      @JsonKey(includeIfNull: false) this.contactPerson,
      @JsonKey(includeIfNull: false) this.contactNumber})
      : _pipes = pipes,
        super._();

  factory _$ProjectImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProjectImplFromJson(json);

  @override
  @JsonKey(includeIfNull: false)
  final String? id;
  @override
  final String projectNumber;
  @override
  final String name;
  @override
  final DateTime date;
  @override
  @JsonKey(includeIfNull: false)
  final String? organizationId;
  final List<InsulatedPipe> _pipes;
  @override
  List<InsulatedPipe> get pipes {
    if (_pipes is EqualUnmodifiableListView) return _pipes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_pipes);
  }

  @override
  @JsonKey(includeIfNull: false)
  final String? address;
  @override
  @JsonKey(includeIfNull: false)
  final String? contactPerson;
  @override
  @JsonKey(includeIfNull: false)
  final String? contactNumber;

  @override
  String toString() {
    return 'Project(id: $id, projectNumber: $projectNumber, name: $name, date: $date, organizationId: $organizationId, pipes: $pipes, address: $address, contactPerson: $contactPerson, contactNumber: $contactNumber)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProjectImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.projectNumber, projectNumber) ||
                other.projectNumber == projectNumber) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.organizationId, organizationId) ||
                other.organizationId == organizationId) &&
            const DeepCollectionEquality().equals(other._pipes, _pipes) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.contactPerson, contactPerson) ||
                other.contactPerson == contactPerson) &&
            (identical(other.contactNumber, contactNumber) ||
                other.contactNumber == contactNumber));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      projectNumber,
      name,
      date,
      organizationId,
      const DeepCollectionEquality().hash(_pipes),
      address,
      contactPerson,
      contactNumber);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ProjectImplCopyWith<_$ProjectImpl> get copyWith =>
      __$$ProjectImplCopyWithImpl<_$ProjectImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProjectImplToJson(
      this,
    );
  }
}

abstract class _Project extends Project {
  const factory _Project(
          {@JsonKey(includeIfNull: false) final String? id,
          required final String projectNumber,
          required final String name,
          required final DateTime date,
          @JsonKey(includeIfNull: false) final String? organizationId,
          required final List<InsulatedPipe> pipes,
          @JsonKey(includeIfNull: false) final String? address,
          @JsonKey(includeIfNull: false) final String? contactPerson,
          @JsonKey(includeIfNull: false) final String? contactNumber}) =
      _$ProjectImpl;
  const _Project._() : super._();

  factory _Project.fromJson(Map<String, dynamic> json) = _$ProjectImpl.fromJson;

  @override
  @JsonKey(includeIfNull: false)
  String? get id;
  @override
  String get projectNumber;
  @override
  String get name;
  @override
  DateTime get date;
  @override
  @JsonKey(includeIfNull: false)
  String? get organizationId;
  @override
  List<InsulatedPipe> get pipes;
  @override
  @JsonKey(includeIfNull: false)
  String? get address;
  @override
  @JsonKey(includeIfNull: false)
  String? get contactPerson;
  @override
  @JsonKey(includeIfNull: false)
  String? get contactNumber;
  @override
  @JsonKey(ignore: true)
  _$$ProjectImplCopyWith<_$ProjectImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
