import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseSqLite {
  Future<Database> openConnection() async {
    var databasePath = await getDatabasesPath();
    final databaseFinalPath = join(databasePath, 'db_cep');

    return await openDatabase(
      databaseFinalPath,
      version: 1,
      onCreate: (db, version) {
        print('Criando db');
        final batch = db.batch();
        batch.execute(
            'create table historico (cep TEXT, logradouro TEXT, complemento TEXT, bairro TEXT, localidade TEXT, uf TEXT)');
        batch.commit();
      },
    );
  }
}
