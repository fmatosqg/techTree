import 'package:built_value/serializer.dart';
import 'package:built_value/built_value.dart';

part 'SectionModel.g.dart';

/// Model for the json that represents a section in the tree
///
abstract class SectionModel
    implements Built<SectionModel, SectionModelBuilder> {
  SectionModel._();
  factory SectionModel([void Function(SectionModelBuilder) updates]) =
      _$SectionModel;

  static Serializer<SectionModel> get serializer => _$sectionModelSerializer;

  @nullable
  String get id;

  @nullable
  String get name;
}
