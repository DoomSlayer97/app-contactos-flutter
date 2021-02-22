

import 'package:contactosapp/src/bloc/contactos_bloc.dart';
import 'package:flutter/material.dart';

class Provider extends InheritedWidget {
  
  static Provider instancia;

  final _contactosBloc = ContactosBloc();

  factory Provider({ Key key, Widget child }) {

    if ( instancia == null ) {
      instancia = new Provider.__internal( key: key, child: child );
    }

    return instancia;

  }

  Provider.__internal({ Key key, Widget child })
    : super( key: key, child: child );

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static ContactosBloc contactosBloc ( BuildContext context )
    => context.dependOnInheritedWidgetOfExactType<Provider>()._contactosBloc;


}