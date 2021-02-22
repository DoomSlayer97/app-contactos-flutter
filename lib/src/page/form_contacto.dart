import 'package:contactosapp/src/bloc/contactos_bloc.dart';
import 'package:contactosapp/src/bloc/provider.dart';
import 'package:contactosapp/src/models/contacto_model.dart';
import 'package:contactosapp/src/page/home_page.dart';
import 'package:flutter/material.dart';

class FormContactoPage extends StatefulWidget {

  final int id;

  FormContactoPage({Key key, this.id}) : super(key: key);

  @override
  _FormContactoPageState createState() => _FormContactoPageState();
}

class _FormContactoPageState extends State<FormContactoPage> {

  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  ContactoModel _contactoModel = new ContactoModel();

  ContactosBloc _contactosBloc;
  
  void _agregarContacto() {

    _formKey.currentState.save();

    _contactosBloc.agregarContacto( _contactoModel );

    Navigator.pop( context );

  }

  void _eliminarContacto() {

    _contactosBloc.eliminarContacto( widget.id );

    Navigator.pop( context );

  }

  void _actualizarContacto() {

    _formKey.currentState.save();

    _contactosBloc.actualizarContacto( _contactoModel, widget.id );

    Navigator.pop( context );

  }

  @override
  Widget build(BuildContext context) {

    _contactosBloc = Provider.contactosBloc( context );

    

    //obtener datos del contacto
    if ( widget.id != null )
      _contactosBloc.getContacto( widget.id );


    return Scaffold(
      appBar: AppBar(
        title: Text( widget.id == null ? "Nuevo contacto" : "Ver contacto" ),
        actions: _listaAcciones(),
      ),
      body: _crearPrincipal() ,
    );
  }

  List<Widget> _listaAcciones() {

    if ( widget.id == null ) return <Widget> [
      IconButton(
        icon: Icon( Icons.person_add ),
        onPressed: () => _agregarContacto(),
      )
    ];

    return <Widget> [
      IconButton(
        icon: Icon( Icons.delete, color: Colors.red ),
        onPressed: () => _eliminarContacto()
      ),
      IconButton(
        icon: Icon( Icons.save ),
        onPressed: () => _actualizarContacto()
      ),
    ];

  }

  Widget _crearPrincipal() {
    
    if ( widget.id == null ) return _crearFormulario();

    _contactosBloc.getContacto( widget.id );

    return _streamBuilderFormulario();

  }

  StreamBuilder<ContactoModel> _streamBuilderFormulario() {
    return StreamBuilder(
      stream: _contactosBloc.contactoStream,
      builder: ( BuildContext context, AsyncSnapshot<ContactoModel> snapshot ) {

        if ( !snapshot.hasData ) return Center(
          child: CircularProgressIndicator(),
        );

        _contactoModel = snapshot.data;

        return _crearFormulario();

      },
    );
  }

  Widget _crearFormulario() {
    return SingleChildScrollView(
      child: Column(
        children: [

          Form(
            key: _formKey,
            child: Container(
              margin: EdgeInsets.only(
                left: 25.0,
                right: 25.0,
                top: 20.0  
              ),
              child: Column(
                children: [

                  Row(
                    children: [
                      Icon( Icons.person ),
                      SizedBox(width: 20,),
                      Text("Datos del contacto",
                        style: TextStyle(
                          fontSize: 20
                        )
                      )                        
                    ]
                  ),

                  SizedBox(height: 25),

                  _buildTextField(
                    valor: _contactoModel.nombre,
                    textoLabel: "Nombre contacto",
                    icon: Icon( Icons.person ),
                    onChange: ( value ) => _contactoModel.nombre = value
                  ),
                  
                  _buildTextField(
                    valor: _contactoModel.numero,
                    textoLabel: "Numero",
                    icon: Icon( Icons.phone ),
                    onChange: ( value ) => _contactoModel.numero = value
                  ),

                  SizedBox(height: 5),

                  Row(
                    children: [
                      Icon( Icons.person ),
                      SizedBox(width: 20,),
                      Text("Otros",
                        style: TextStyle(
                          fontSize: 20
                        )
                      )
                    ]
                  ),

                  SizedBox(height: 25),

                  _buildTextField(
                    valor: _contactoModel.alias,
                    textoLabel: "Alias",
                    icon: Icon( Icons.person ),
                    onChange: ( value ) => _contactoModel.alias = value
                  ),

                  _buildTextField(
                    valor: _contactoModel.empresa,
                    textoLabel: "Empresa",
                    icon: Icon( Icons.settings_ethernet ),
                    onChange: ( value ) => _contactoModel.empresa = value
                  ),
                 

                ],
              ),
            ),
          )

        ],
      ),
    );
  }

  Widget _buildTextField({ String valor, String textoLabel, Icon icon, Function(String) onChange }) {
    return Container(
      margin: EdgeInsets.only(
        bottom: 15.0
      ),
      child: TextFormField(
        initialValue: valor,
        onChanged: ( value ) => onChange( value ),
        decoration: InputDecoration(
          labelText: textoLabel,
          border: InputBorder.none,
          filled: true,
          icon: icon
        ),
      ),
    );
  }
}