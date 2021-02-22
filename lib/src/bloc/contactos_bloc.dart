import 'package:contactosapp/src/database/db_provider.dart';
import 'package:contactosapp/src/models/contacto_model.dart';
import 'package:rxdart/rxdart.dart';

class ContactosBloc {

  List<ContactoModel> _contactos = new List<ContactoModel>();
  ContactoModel currentContacto = new ContactoModel();

  DBProvider _dbProvider = DBProvider.db;

  final _contactosController = new BehaviorSubject<List<ContactoModel>>();
  final _contactoController = new BehaviorSubject<ContactoModel>();

  Stream<List<ContactoModel>> get contactosStream => _contactosController.stream;
  Stream<ContactoModel> get contactoStream => _contactoController.stream;

  void dispose() {

    _contactosController?.close();
    _contactoController?.close();

  }

  void getContacto( int id ) async {

    currentContacto = await _dbProvider.getContacto( id );

    _contactoController.sink.add( currentContacto );

  }

  void getContactos() async {

    _contactos = await _dbProvider.getContactos();

    _contactosController.sink.add( _contactos );

  }

  void agregarContacto( ContactoModel contactoModel ) async {

    final guardado = await _dbProvider.agregarContacto( contactoModel );

    getContactos();

  }

  void eliminarContacto( int id ) async {

    final eliminado = await _dbProvider.eliminarContacto( id );

    getContactos();

  }

  void actualizarContacto( ContactoModel contactoModel, int id ) async {

    final actualizado = await _dbProvider.actualizarContacto( contactoModel, id );

    getContactos();

  }

  void vaciarContactos( ) async {

    await _dbProvider.vaciarContactos();

  }
  

}
