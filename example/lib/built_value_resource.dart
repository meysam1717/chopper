library resource;

import 'dart:async';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:chopper/chopper.dart';

part 'built_value_resource.g.dart';
part 'built_value_resource.chopper.dart';

abstract class Resource implements Built<Resource, ResourceBuilder> {
  String get id;
  String get name;

  static Serializer<Resource> get serializer => _$resourceSerializer;

  factory Resource([updates(ResourceBuilder b)]) = _$Resource;
  Resource._();
}

abstract class ResourceError
    implements Built<ResourceError, ResourceErrorBuilder> {
  String get type;
  String get message;

  static Serializer<ResourceError> get serializer => _$resourceErrorSerializer;

  factory ResourceError([updates(ResourceErrorBuilder b)]) = _$ResourceError;
  ResourceError._();
}

@ChopperApi(baseUrl: "/resources")
abstract class MyService extends ChopperService {
  static MyService create([ChopperClient? client]) => _$MyService(client);

  @Get(path: "/{id}/")
  Future<Response> getResource(@Path() String id);

  @Get(path: "/list")
  Future<Response<BuiltList<Resource>>> getBuiltListResources();

  @Get(path: "/", headers: const {"foo": "bar"})
  Future<Response<Resource>> getTypedResource();

  @Post()
  Future<Response<Resource>> newResource(@Body() Resource resource,
      {@Header() String? name});
}
