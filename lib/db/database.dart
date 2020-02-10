import 'dart:io';
import 'package:moor_ffi/moor_ffi.dart';
import 'package:path/path.dart' as p;
import 'package:moor/moor.dart';
import 'package:path_provider/path_provider.dart';

part 'database.g.dart';

class Words extends Table {
  TextColumn get strQuestion => text()();

  TextColumn get strAnswer => text()();

  BoolColumn get isMemorized => boolean().withDefault(Constant(false))();

  @override
  Set<Column> get primaryKey => {strQuestion};
}

@UseMoor(tables: [Words])
class MyDatabase extends _$MyDatabase {
  MyDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 2;

  //統合処理
  MigrationStrategy get migration => MigrationStrategy(onCreate: (Migrator m) {
        return m.createAll();
      }, onUpgrade: (Migrator m, int from, int to) async {
        if (from == 1) {
          await m.addColumn(words, words.isMemorized);
        }
      });

  //追加
  Future addWord(Word word) => into(words).insert(word);

  //すべて抽出
  Future<List<Word>> get allWord => select(words).get();

  //暗記済みの単語を除くものを抽出
  Future<List<Word>> get allWordsExcludedMemorized =>
      (select(words)..where((table) => table.isMemorized.equals(false))).get();

  //ソートのための並べ替え抽出
  Future<List<Word>> get allWordSorted => (select(words)
        ..orderBy([(table) => OrderingTerm(expression: table.isMemorized)]))
      .get();

  //更新
  Future updateWord(Word word) => update(words).replace(word);

  //削除
  Future deleteWord(Word word) =>
      (delete(words)..where((t) => t.strQuestion.equals(word.strQuestion)))
          .go();
}

LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'words.db'));
    return VmDatabase(file);
  });
}
