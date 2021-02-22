import 'package:contactosapp/src/bloc/contactos_bloc.dart';
import 'package:contactosapp/src/bloc/provider.dart';
import 'package:contactosapp/src/models/contacto_model.dart';
import 'package:contactosapp/src/page/form_contacto.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {

  ContactosBloc _contactosBloc;

  void publicPrint() {

    print("Se pinto esto desde el padre");

  }

  void _crearNuevo() {

    Navigator.push( context, MaterialPageRoute(
      builder: ( BuildContext context ) => FormContactoPage()
    ));

  }

  void _verContacto( int id ) {

    Navigator.push( context, MaterialPageRoute(
      builder: ( BuildContext context ) => FormContactoPage(
        id: id
      )
    ));

  }

  @override
  Widget build(BuildContext context) {

    _contactosBloc = Provider.contactosBloc( context );
    _contactosBloc.getContactos();

  

    return Scaffold(
      appBar: AppBar(
        title: Text("Contactos"),
      ),
      body: _buildStreamListaContactos(),
      floatingActionButton: FloatingActionButton(
        child: Icon( Icons.playlist_add_rounded ),
        onPressed: () => _crearNuevo(),
      ),
    );
  }

  StreamBuilder<List<ContactoModel>> _buildStreamListaContactos() {

    return StreamBuilder(
      stream: _contactosBloc.contactosStream,
      builder: ( BuildContext context, AsyncSnapshot<List<ContactoModel>> snapshot ) {

        if ( !snapshot.hasData ) return Center(
          child: CircularProgressIndicator(),
        );

        final contactos = snapshot.data;

        return _buildListContactos( contactos, 
          onTap: ( int id ) => _verContacto( id )
        );

      },
    );

  }

  Widget _buildListContactos( List<ContactoModel> contactos, { Function(int) onTap } ) {
    return ListView.builder(
      itemCount: contactos.length,
      itemBuilder: ( BuildContext context, int index ) {
        return ListTile(
          leading: Icon( Icons.person, size: 40, ),
          title: Text(contactos[index].nombre != null ? contactos[index].nombre : "" ),
          subtitle: Text(contactos[index].numero != null ?  "Tel: " + contactos[index].numero : "" ),
          trailing: Icon( Icons.chevron_right ),
          onTap: () => onTap( contactos[index].id )
        );
      },
    );
  }

}