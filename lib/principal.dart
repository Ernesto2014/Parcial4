import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

class Principal extends StatefulWidget {
  const Principal({super.key});

  @override
  State<Principal> createState() => _PrincipalState();
}

class _PrincipalState extends State<Principal> {
  // text fields' controllers
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _cedulaController = TextEditingController();
  final TextEditingController _apellidoController = TextEditingController();
  final TextEditingController _fechaNacimientoController = TextEditingController();
  final TextEditingController _sexoController = TextEditingController();
  final TextEditingController _tipoController = TextEditingController();
  final TextEditingController _usuarioController = TextEditingController();
  final TextEditingController _reservaController = TextEditingController();

  final CollectionReference _clientes =
      FirebaseFirestore.instance.collection('clientes');
//insertar cliente
  Future<void> _create([DocumentSnapshot? documentSnapshot]) async {
    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _nombreController,
                  decoration: const InputDecoration(labelText: 'Nombre'),
                ),
                TextField(
                  controller: _apellidoController,
                  decoration: const InputDecoration(labelText: 'Apellido'),
                ),
                TextField(
                  controller: _fechaNacimientoController,
                  decoration: const InputDecoration(labelText: 'Fecha Nacimiento'),
                ),
                TextField(
                  controller: _sexoController,
                  decoration: const InputDecoration(labelText: 'Sexo'),
                ),
                TextField(
                  controller: _tipoController,
                  decoration: const InputDecoration(labelText: 'Tipo'),
                ),
                TextField(
                  controller: _usuarioController,
                  decoration: const InputDecoration(labelText: 'Usuario'),
                ),
                TextField(
                  controller: _reservaController,
                  decoration: const InputDecoration(labelText: 'Reserva'),
                ),
                TextField(
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  controller: _cedulaController,
                  decoration: const InputDecoration(
                    labelText: 'Cedula',
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  child: const Text('Crear'),
                  onPressed: () async {
                    final String nombre = _nombreController.text;
                    final String apellido = _apellidoController.text;
                    final String fechaNacimiento = _fechaNacimientoController.text;
                    final String sexo = _sexoController.text;
                    final String tipo  = _tipoController.text;
                    final String usuario = _usuarioController.text;
                    final String reserva = _reservaController.text;
                    final double? cedula =
                        double.tryParse(_cedulaController.text);
                    if (cedula != null) {
                      await _clientes
                          .add({"nombre": nombre, "apellido": apellido,"cedula": cedula, "fechaNacimiento": fechaNacimiento,
                          "sexo": sexo, "tipo": tipo, "usuario": usuario, "reserva": reserva});

                      _nombreController.text = '';
                      _apellidoController.text = '';
                      _cedulaController.text = '';
                      _fechaNacimientoController.text = '';
                      _sexoController.text = '';
                      _tipoController.text = '';
                      _usuarioController.text = '';
                      _reservaController.text = '';
                      Navigator.of(context).pop();
                    }
                  },
                )
              ],
            ),
          );
        });
  }
//actualizar cliente

  Future<void> _update([DocumentSnapshot? documentSnapshot]) async {
    if (documentSnapshot != null) {
      _nombreController.text = documentSnapshot['nombre'].toString();
      _apellidoController.text = documentSnapshot['apellido'].toString();
      _cedulaController.text = documentSnapshot['cedula'].toString();
      _fechaNacimientoController.text = documentSnapshot['fechaNacimiento'].toString();
      _sexoController.text = documentSnapshot['sexo'].toString();
      _tipoController.text = documentSnapshot['tipo'].toString();
      _usuarioController.text = documentSnapshot['usuario'].toString();
      _reservaController.text = documentSnapshot['reserva'].toString();
    }

    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _nombreController,
                  decoration: const InputDecoration(labelText: 'Nombre'),
                ),
                TextField(
                  controller: _apellidoController,
                  decoration: const InputDecoration(labelText: 'Apellido'),
                ),
                TextField(
                  controller: _fechaNacimientoController,
                  decoration: const InputDecoration(labelText: 'Fecha nacimiento'),
                ),
                TextField(
                  controller: _sexoController,
                  decoration: const InputDecoration(labelText: 'Sexo'),
                ),
                TextField(
                  controller: _tipoController,
                  decoration: const InputDecoration(labelText: 'Tipo'),
                ),
                TextField(
                  controller: _usuarioController,
                  decoration: const InputDecoration(labelText: 'Usuario'),
                ),
                TextField(
                  controller: _reservaController,
                  decoration: const InputDecoration(labelText: 'Reserva'),
                ),
                TextField(
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  controller: _cedulaController,
                  decoration: const InputDecoration(
                    labelText: 'Cedula',
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  child: const Text('Update'),
                  onPressed: () async {
                    final String nombre = _nombreController.text;
                    final String apellido = _apellidoController.text;
                    final String fechaNacimiento = _fechaNacimientoController.text;
                    final String sexo = _sexoController.text;
                    final String tipo  = _tipoController.text;
                    final String usuario = _usuarioController.text;
                    final String reserva = _reservaController.text;
                    final double? cedula=
                        double.tryParse(_cedulaController.text);
                    if (cedula != null) {
                      await _clientes
                          .doc(documentSnapshot!.id)
                          .update({"nombre": nombre, "apellido": apellido,"cedula": cedula, "fechaNacimiento": fechaNacimiento,
                          "sexo": sexo, "tipo": tipo, "usuario": usuario, "reserva": reserva});
                      _nombreController.text = '';
                      _apellidoController.text = '';
                      _cedulaController.text = '';
                      _fechaNacimientoController.text = '';
                      _sexoController.text = '';
                      _tipoController.text = '';
                      _usuarioController.text = '';
                      _reservaController.text = '';
                      Navigator.of(context).pop();
                    }
                  },
                )
              ],
            ),
          );
        });
  }

//borrar cliente
  Future<void> _delete(String productId) async {
    await _clientes.doc(productId).delete();

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('El cliente fue eliminado correctamente')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Center(child: Text('Parcial4 Firebase')),
        ),
        body: StreamBuilder(
          stream: _clientes.snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
            if (streamSnapshot.hasData) {
              return ListView.builder(
                itemCount: streamSnapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final DocumentSnapshot documentSnapshot =
                      streamSnapshot.data!.docs[index];
                  return Card(
                    margin: const EdgeInsets.all(10),
                    child: ListTile(
                      title: Text("Nombre: "+documentSnapshot['nombre'].toString()+" "+ documentSnapshot['apellido'].toString()),
                      subtitle: Text("Cedula: "+documentSnapshot['cedula'].toString()),
                      trailing: SizedBox(
                        width: 100,
                        child: Row(
                          children: [
                            IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: () => _update(documentSnapshot)),
                            IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () => _delete(documentSnapshot.id)),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }

            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
// agregar cliente
        floatingActionButton: FloatingActionButton(
          onPressed: () => _create(),
          child: const Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat);
  }
}
