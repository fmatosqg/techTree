library serializers;

import 'package:androidArchitecture/domain/model/OptionModel.dart';
import 'package:androidArchitecture/domain/model/TreeModel.dart';
import 'package:androidArchitecture/domain/model/SectionModel.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:built_collection/built_collection.dart';

part 'serializers.g.dart';

@SerializersFor([
  SectionModel,
  OptionModel,
  TreeModel,
])
final Serializers serializers =
    (_$serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();
