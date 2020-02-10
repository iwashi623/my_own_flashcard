// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class Word extends DataClass implements Insertable<Word> {
  final String strQuestion;
  final String strAnswer;
  final bool isMemorized;
  Word(
      {@required this.strQuestion,
      @required this.strAnswer,
      @required this.isMemorized});
  factory Word.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    final boolType = db.typeSystem.forDartType<bool>();
    return Word(
      strQuestion: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}str_question']),
      strAnswer: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}str_answer']),
      isMemorized: boolType
          .mapFromDatabaseResponse(data['${effectivePrefix}is_memorized']),
    );
  }
  factory Word.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Word(
      strQuestion: serializer.fromJson<String>(json['strQuestion']),
      strAnswer: serializer.fromJson<String>(json['strAnswer']),
      isMemorized: serializer.fromJson<bool>(json['isMemorized']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'strQuestion': serializer.toJson<String>(strQuestion),
      'strAnswer': serializer.toJson<String>(strAnswer),
      'isMemorized': serializer.toJson<bool>(isMemorized),
    };
  }

  @override
  WordsCompanion createCompanion(bool nullToAbsent) {
    return WordsCompanion(
      strQuestion: strQuestion == null && nullToAbsent
          ? const Value.absent()
          : Value(strQuestion),
      strAnswer: strAnswer == null && nullToAbsent
          ? const Value.absent()
          : Value(strAnswer),
      isMemorized: isMemorized == null && nullToAbsent
          ? const Value.absent()
          : Value(isMemorized),
    );
  }

  Word copyWith({String strQuestion, String strAnswer, bool isMemorized}) =>
      Word(
        strQuestion: strQuestion ?? this.strQuestion,
        strAnswer: strAnswer ?? this.strAnswer,
        isMemorized: isMemorized ?? this.isMemorized,
      );
  @override
  String toString() {
    return (StringBuffer('Word(')
          ..write('strQuestion: $strQuestion, ')
          ..write('strAnswer: $strAnswer, ')
          ..write('isMemorized: $isMemorized')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      strQuestion.hashCode, $mrjc(strAnswer.hashCode, isMemorized.hashCode)));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Word &&
          other.strQuestion == this.strQuestion &&
          other.strAnswer == this.strAnswer &&
          other.isMemorized == this.isMemorized);
}

class WordsCompanion extends UpdateCompanion<Word> {
  final Value<String> strQuestion;
  final Value<String> strAnswer;
  final Value<bool> isMemorized;
  const WordsCompanion({
    this.strQuestion = const Value.absent(),
    this.strAnswer = const Value.absent(),
    this.isMemorized = const Value.absent(),
  });
  WordsCompanion.insert({
    @required String strQuestion,
    @required String strAnswer,
    this.isMemorized = const Value.absent(),
  })  : strQuestion = Value(strQuestion),
        strAnswer = Value(strAnswer);
  WordsCompanion copyWith(
      {Value<String> strQuestion,
      Value<String> strAnswer,
      Value<bool> isMemorized}) {
    return WordsCompanion(
      strQuestion: strQuestion ?? this.strQuestion,
      strAnswer: strAnswer ?? this.strAnswer,
      isMemorized: isMemorized ?? this.isMemorized,
    );
  }
}

class $WordsTable extends Words with TableInfo<$WordsTable, Word> {
  final GeneratedDatabase _db;
  final String _alias;
  $WordsTable(this._db, [this._alias]);
  final VerificationMeta _strQuestionMeta =
      const VerificationMeta('strQuestion');
  GeneratedTextColumn _strQuestion;
  @override
  GeneratedTextColumn get strQuestion =>
      _strQuestion ??= _constructStrQuestion();
  GeneratedTextColumn _constructStrQuestion() {
    return GeneratedTextColumn(
      'str_question',
      $tableName,
      false,
    );
  }

  final VerificationMeta _strAnswerMeta = const VerificationMeta('strAnswer');
  GeneratedTextColumn _strAnswer;
  @override
  GeneratedTextColumn get strAnswer => _strAnswer ??= _constructStrAnswer();
  GeneratedTextColumn _constructStrAnswer() {
    return GeneratedTextColumn(
      'str_answer',
      $tableName,
      false,
    );
  }

  final VerificationMeta _isMemorizedMeta =
      const VerificationMeta('isMemorized');
  GeneratedBoolColumn _isMemorized;
  @override
  GeneratedBoolColumn get isMemorized =>
      _isMemorized ??= _constructIsMemorized();
  GeneratedBoolColumn _constructIsMemorized() {
    return GeneratedBoolColumn('is_memorized', $tableName, false,
        defaultValue: Constant(false));
  }

  @override
  List<GeneratedColumn> get $columns => [strQuestion, strAnswer, isMemorized];
  @override
  $WordsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'words';
  @override
  final String actualTableName = 'words';
  @override
  VerificationContext validateIntegrity(WordsCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.strQuestion.present) {
      context.handle(_strQuestionMeta,
          strQuestion.isAcceptableValue(d.strQuestion.value, _strQuestionMeta));
    } else if (isInserting) {
      context.missing(_strQuestionMeta);
    }
    if (d.strAnswer.present) {
      context.handle(_strAnswerMeta,
          strAnswer.isAcceptableValue(d.strAnswer.value, _strAnswerMeta));
    } else if (isInserting) {
      context.missing(_strAnswerMeta);
    }
    if (d.isMemorized.present) {
      context.handle(_isMemorizedMeta,
          isMemorized.isAcceptableValue(d.isMemorized.value, _isMemorizedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {strQuestion};
  @override
  Word map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Word.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(WordsCompanion d) {
    final map = <String, Variable>{};
    if (d.strQuestion.present) {
      map['str_question'] = Variable<String, StringType>(d.strQuestion.value);
    }
    if (d.strAnswer.present) {
      map['str_answer'] = Variable<String, StringType>(d.strAnswer.value);
    }
    if (d.isMemorized.present) {
      map['is_memorized'] = Variable<bool, BoolType>(d.isMemorized.value);
    }
    return map;
  }

  @override
  $WordsTable createAlias(String alias) {
    return $WordsTable(_db, alias);
  }
}

abstract class _$MyDatabase extends GeneratedDatabase {
  _$MyDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  $WordsTable _words;
  $WordsTable get words => _words ??= $WordsTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [words];
}
