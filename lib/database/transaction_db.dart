import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

import '../models/transactions.dart';

class TransactionDB {
  //DB Services
  String dbName;

  TransactionDB({required this.dbName});

  Future<Database> openDatabase() async {
    var appDir = await getApplicationDocumentsDirectory();
    String dbLocation = join(appDir.path, dbName);
    DatabaseFactory dbFactory = databaseFactoryIo;
    Database db = await dbFactory.openDatabase(dbLocation);
    return db;
  }

  Future<int> insertData(Transactions statement) async {
    //create db client obj
    var db = await openDatabase();

    //create store
    var store = intMapStoreFactory.store("expense");

    //json
    var keyID = store.add(db, {
      "id": statement.id,
      "name": statement.name,
      "number": statement.number,
      "type": statement.type,
      "checkIn": statement.checkIn,
      "checkOut": statement.checkOut
    });
    db.close();
    return keyID;
  }

  Future<List<Transactions>> loadAllData() async {
    //create db client obj
    var db = await openDatabase();

    //create store
    var store = intMapStoreFactory.store("expense");
    var snapshot = await store.find(db,
        finder: Finder(sortOrders: [SortOrder(Field.key, false)]));
    List<Transactions> transactionList = [];
    for (var record in snapshot) {
      int id = record.key;
      String name = record['name'].toString();
      String number = record['number'].toString();
      String type = record['type'].toString();
      String checkIn = record['checkIn'].toString();
      String checkOut = record['checkOut'].toString();
      // print(record['title']);
      transactionList.add(Transactions(
          id: id,
          name: name,
          number: number,
          type: type,
          checkIn: checkIn,
          checkOut: checkOut));
    }
    db.close();
    return transactionList;
  }

  //my CRUD update code
  Future updateData(Transactions statement) async {
    //create db client obj
    var db = await openDatabase();

    //create store
    var store = intMapStoreFactory.store("expense");
    print("item id ${statement.id}");

    //filter with 'id'
    final finder = Finder(filter: Filter.byKey(statement.id));
    var updateResult =
        await store.update(db, statement.toMap(), finder: finder);
    print("$updateResult row(s) updated.");
    db.close();
  }

  //my CRUD update code
  Future deleteData(Transactions statement) async {
    //create db client obj
    var db = await openDatabase();

    //create store
    var store = intMapStoreFactory.store("expense");
    print("Statement id is ${statement.id}");

    //filter with 'id'
    final finder = Finder(filter: Filter.byKey(statement.id));

    var deleteResult = await store.delete(db, finder: finder);
    print("$deleteResult row(s) deleted.");
    db.close();
  }

  Future<Transactions?> loadSingleRow(int rowId) async {
    //create db client obj
    var db = await openDatabase();

    //create store
    var store = intMapStoreFactory.store("expense");

    //Filter store by field 'id'
    var snapshot =
        await store.find(db, finder: Finder(filter: Filter.byKey(rowId)));

    Transactions? transaction;

    int id = int.parse(snapshot.first['id'].toString());
    String name = snapshot.first['name'].toString();
    String number = snapshot.first['number'].toString();
    String type = snapshot.first['type'].toString();
    String checkIn = snapshot.first['checkIn'].toString();
    String checkOut = snapshot.first['checkOut'].toString();
    // print(record['name']);
    transaction = Transactions(
        id: id,
        name: name,
        number: number,
        type: type,
        checkIn: checkIn,
        checkOut: checkOut);

    db.close();
    return transaction;
  }
}
