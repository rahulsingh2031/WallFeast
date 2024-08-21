// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_gallery.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetDailyGalleryCollection on Isar {
  IsarCollection<DailyGallery> get dailyGallerys => this.collection();
}

const DailyGallerySchema = CollectionSchema(
  name: r'DailyGallery',
  id: 271794427851464870,
  properties: {
    r'curatedImages': PropertySchema(
      id: 0,
      name: r'curatedImages',
      type: IsarType.objectList,
      target: r'GalleryImage',
    ),
    r'hashCode': PropertySchema(
      id: 1,
      name: r'hashCode',
      type: IsarType.long,
    ),
    r'initializeDateTime': PropertySchema(
      id: 2,
      name: r'initializeDateTime',
      type: IsarType.dateTime,
    ),
    r'randomDailyImages': PropertySchema(
      id: 3,
      name: r'randomDailyImages',
      type: IsarType.objectList,
      target: r'GalleryImage',
    )
  },
  estimateSize: _dailyGalleryEstimateSize,
  serialize: _dailyGallerySerialize,
  deserialize: _dailyGalleryDeserialize,
  deserializeProp: _dailyGalleryDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {r'GalleryImage': GalleryImageSchema},
  getId: _dailyGalleryGetId,
  getLinks: _dailyGalleryGetLinks,
  attach: _dailyGalleryAttach,
  version: '3.1.0+1',
);

int _dailyGalleryEstimateSize(
  DailyGallery object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.curatedImages.length * 3;
  {
    final offsets = allOffsets[GalleryImage]!;
    for (var i = 0; i < object.curatedImages.length; i++) {
      final value = object.curatedImages[i];
      bytesCount += GalleryImageSchema.estimateSize(value, offsets, allOffsets);
    }
  }
  bytesCount += 3 + object.randomDailyImages.length * 3;
  {
    final offsets = allOffsets[GalleryImage]!;
    for (var i = 0; i < object.randomDailyImages.length; i++) {
      final value = object.randomDailyImages[i];
      bytesCount += GalleryImageSchema.estimateSize(value, offsets, allOffsets);
    }
  }
  return bytesCount;
}

void _dailyGallerySerialize(
  DailyGallery object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeObjectList<GalleryImage>(
    offsets[0],
    allOffsets,
    GalleryImageSchema.serialize,
    object.curatedImages,
  );
  writer.writeLong(offsets[1], object.hashCode);
  writer.writeDateTime(offsets[2], object.initializeDateTime);
  writer.writeObjectList<GalleryImage>(
    offsets[3],
    allOffsets,
    GalleryImageSchema.serialize,
    object.randomDailyImages,
  );
}

DailyGallery _dailyGalleryDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = DailyGallery(
    curatedImages: reader.readObjectList<GalleryImage>(
          offsets[0],
          GalleryImageSchema.deserialize,
          allOffsets,
          GalleryImage(),
        ) ??
        [],
    initializeDateTime: reader.readDateTime(offsets[2]),
    randomDailyImages: reader.readObjectList<GalleryImage>(
          offsets[3],
          GalleryImageSchema.deserialize,
          allOffsets,
          GalleryImage(),
        ) ??
        [],
  );
  object.id = id;
  return object;
}

P _dailyGalleryDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readObjectList<GalleryImage>(
            offset,
            GalleryImageSchema.deserialize,
            allOffsets,
            GalleryImage(),
          ) ??
          []) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readDateTime(offset)) as P;
    case 3:
      return (reader.readObjectList<GalleryImage>(
            offset,
            GalleryImageSchema.deserialize,
            allOffsets,
            GalleryImage(),
          ) ??
          []) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _dailyGalleryGetId(DailyGallery object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _dailyGalleryGetLinks(DailyGallery object) {
  return [];
}

void _dailyGalleryAttach(
    IsarCollection<dynamic> col, Id id, DailyGallery object) {
  object.id = id;
}

extension DailyGalleryQueryWhereSort
    on QueryBuilder<DailyGallery, DailyGallery, QWhere> {
  QueryBuilder<DailyGallery, DailyGallery, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension DailyGalleryQueryWhere
    on QueryBuilder<DailyGallery, DailyGallery, QWhereClause> {
  QueryBuilder<DailyGallery, DailyGallery, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<DailyGallery, DailyGallery, QAfterWhereClause> idNotEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<DailyGallery, DailyGallery, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<DailyGallery, DailyGallery, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<DailyGallery, DailyGallery, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension DailyGalleryQueryFilter
    on QueryBuilder<DailyGallery, DailyGallery, QFilterCondition> {
  QueryBuilder<DailyGallery, DailyGallery, QAfterFilterCondition>
      curatedImagesLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'curatedImages',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<DailyGallery, DailyGallery, QAfterFilterCondition>
      curatedImagesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'curatedImages',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<DailyGallery, DailyGallery, QAfterFilterCondition>
      curatedImagesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'curatedImages',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<DailyGallery, DailyGallery, QAfterFilterCondition>
      curatedImagesLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'curatedImages',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<DailyGallery, DailyGallery, QAfterFilterCondition>
      curatedImagesLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'curatedImages',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<DailyGallery, DailyGallery, QAfterFilterCondition>
      curatedImagesLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'curatedImages',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<DailyGallery, DailyGallery, QAfterFilterCondition>
      hashCodeEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'hashCode',
        value: value,
      ));
    });
  }

  QueryBuilder<DailyGallery, DailyGallery, QAfterFilterCondition>
      hashCodeGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'hashCode',
        value: value,
      ));
    });
  }

  QueryBuilder<DailyGallery, DailyGallery, QAfterFilterCondition>
      hashCodeLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'hashCode',
        value: value,
      ));
    });
  }

  QueryBuilder<DailyGallery, DailyGallery, QAfterFilterCondition>
      hashCodeBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'hashCode',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<DailyGallery, DailyGallery, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<DailyGallery, DailyGallery, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<DailyGallery, DailyGallery, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<DailyGallery, DailyGallery, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<DailyGallery, DailyGallery, QAfterFilterCondition>
      initializeDateTimeEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'initializeDateTime',
        value: value,
      ));
    });
  }

  QueryBuilder<DailyGallery, DailyGallery, QAfterFilterCondition>
      initializeDateTimeGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'initializeDateTime',
        value: value,
      ));
    });
  }

  QueryBuilder<DailyGallery, DailyGallery, QAfterFilterCondition>
      initializeDateTimeLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'initializeDateTime',
        value: value,
      ));
    });
  }

  QueryBuilder<DailyGallery, DailyGallery, QAfterFilterCondition>
      initializeDateTimeBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'initializeDateTime',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<DailyGallery, DailyGallery, QAfterFilterCondition>
      randomDailyImagesLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'randomDailyImages',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<DailyGallery, DailyGallery, QAfterFilterCondition>
      randomDailyImagesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'randomDailyImages',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<DailyGallery, DailyGallery, QAfterFilterCondition>
      randomDailyImagesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'randomDailyImages',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<DailyGallery, DailyGallery, QAfterFilterCondition>
      randomDailyImagesLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'randomDailyImages',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<DailyGallery, DailyGallery, QAfterFilterCondition>
      randomDailyImagesLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'randomDailyImages',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<DailyGallery, DailyGallery, QAfterFilterCondition>
      randomDailyImagesLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'randomDailyImages',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }
}

extension DailyGalleryQueryObject
    on QueryBuilder<DailyGallery, DailyGallery, QFilterCondition> {
  QueryBuilder<DailyGallery, DailyGallery, QAfterFilterCondition>
      curatedImagesElement(FilterQuery<GalleryImage> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'curatedImages');
    });
  }

  QueryBuilder<DailyGallery, DailyGallery, QAfterFilterCondition>
      randomDailyImagesElement(FilterQuery<GalleryImage> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'randomDailyImages');
    });
  }
}

extension DailyGalleryQueryLinks
    on QueryBuilder<DailyGallery, DailyGallery, QFilterCondition> {}

extension DailyGalleryQuerySortBy
    on QueryBuilder<DailyGallery, DailyGallery, QSortBy> {
  QueryBuilder<DailyGallery, DailyGallery, QAfterSortBy> sortByHashCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hashCode', Sort.asc);
    });
  }

  QueryBuilder<DailyGallery, DailyGallery, QAfterSortBy> sortByHashCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hashCode', Sort.desc);
    });
  }

  QueryBuilder<DailyGallery, DailyGallery, QAfterSortBy>
      sortByInitializeDateTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'initializeDateTime', Sort.asc);
    });
  }

  QueryBuilder<DailyGallery, DailyGallery, QAfterSortBy>
      sortByInitializeDateTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'initializeDateTime', Sort.desc);
    });
  }
}

extension DailyGalleryQuerySortThenBy
    on QueryBuilder<DailyGallery, DailyGallery, QSortThenBy> {
  QueryBuilder<DailyGallery, DailyGallery, QAfterSortBy> thenByHashCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hashCode', Sort.asc);
    });
  }

  QueryBuilder<DailyGallery, DailyGallery, QAfterSortBy> thenByHashCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hashCode', Sort.desc);
    });
  }

  QueryBuilder<DailyGallery, DailyGallery, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<DailyGallery, DailyGallery, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<DailyGallery, DailyGallery, QAfterSortBy>
      thenByInitializeDateTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'initializeDateTime', Sort.asc);
    });
  }

  QueryBuilder<DailyGallery, DailyGallery, QAfterSortBy>
      thenByInitializeDateTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'initializeDateTime', Sort.desc);
    });
  }
}

extension DailyGalleryQueryWhereDistinct
    on QueryBuilder<DailyGallery, DailyGallery, QDistinct> {
  QueryBuilder<DailyGallery, DailyGallery, QDistinct> distinctByHashCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'hashCode');
    });
  }

  QueryBuilder<DailyGallery, DailyGallery, QDistinct>
      distinctByInitializeDateTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'initializeDateTime');
    });
  }
}

extension DailyGalleryQueryProperty
    on QueryBuilder<DailyGallery, DailyGallery, QQueryProperty> {
  QueryBuilder<DailyGallery, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<DailyGallery, List<GalleryImage>, QQueryOperations>
      curatedImagesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'curatedImages');
    });
  }

  QueryBuilder<DailyGallery, int, QQueryOperations> hashCodeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'hashCode');
    });
  }

  QueryBuilder<DailyGallery, DateTime, QQueryOperations>
      initializeDateTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'initializeDateTime');
    });
  }

  QueryBuilder<DailyGallery, List<GalleryImage>, QQueryOperations>
      randomDailyImagesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'randomDailyImages');
    });
  }
}
