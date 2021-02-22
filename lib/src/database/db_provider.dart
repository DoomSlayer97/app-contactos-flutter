import 'package:contactosapp/src/bloc/contactos_bloc.dart';
import 'package:contactosapp/src/models/contacto_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import "package:path/path.dart";
import 'dart:io';

class DBProvider {

  static Database _database;
  static final DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database> get database async {
    
    if ( _database != null ) return _database;

    _database = await initDB();

    return _database;

  }

  Future<Database> initDB() async {

    Directory documentDirectory = await getApplicationDocumentsDirectory();

    final path = join( documentDirectory.path, "contactos2.db" );

    return await openDatabase(
      path,
      version: 10,
      onCreate: ( Database db, int version ) async {

        await db.execute('''
          create table contactos(
            id integer primary key,
            nombre text,
            alias text,
            empresa text,
            numero text
          )
        ''');

      }
    );

  }

  Future<int> eliminarContacto( id ) async {

    final db = await database;

    final res = await db.delete( "contactos", where: " id = ? ", whereArgs: [ id ] );

    return res;

  }

  Future<int> vaciarContactos() async {

    final db = await database;
    
    final res = await db.delete( "contactos" );

    return res;

  }

  Future<ContactoModel> getContacto( int id ) async {

    final db = await database;
    
    final res = await db.query("contactos", where: " id = ? ", whereArgs: [ id ]);

    ContactoModel contacto = ContactoModel.fromJson( res.first );

    return contacto;

  }

  Future<List<ContactoModel>> getContactos() async {

    final db = await database;

    final res = await db.query("contactos");

    List<ContactoModel> contactos = new List<ContactoModel>();

    res.forEach( (item) {
      
      contactos.add( ContactoModel.fromJson( item ) );

    });

    return contactos;

  }

  Future<int> agregarContacto( ContactoModel contactoModel ) async { 

    final db = await database;
    
    final res = await db.insert( "contactos", contactoModel.toJson() );

    return res;

  }

  Future<int> actualizarContacto( ContactoModel contactoModel, int id ) async {

    final db = await database;
    
    final res = await db.update( "contactos", contactoModel.toJson(), 
      where: " id = ? ",
      whereArgs: [ id ]
    );

    return res;

  }


}