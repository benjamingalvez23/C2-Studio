// ...existing code...
import 'package:c2studio/Menu.dart';
import 'package:c2studio/models/unidades.dart';
import 'package:flutter/material.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  int _currentIndex = 0;
  // ignore: unused_field
  late PageController _controller;

  // nuevos controles y llave de formulario
  late TextEditingController _nombreController;
  late TextEditingController _apellidoController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState(){
    super.initState();
    _controller = PageController(initialPage:0);
    _nombreController = TextEditingController();
    _apellidoController = TextEditingController();
  }

  @override
  void dispose(){
    _controller.dispose();
    _nombreController.dispose();
    _apellidoController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder
            (
              controller: _controller,
              itemCount: contexts.length,
              onPageChanged: (int index)
              {
                setState(()
                {
                  _currentIndex = index;
                });
              },
              itemBuilder: (_,i)
              {
                // Página 2 (índice 1): formulario para nombre y apellido
                if (i == 1) {
                  return SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.all(40),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            Text(contexts[i].tituloPresentacion,style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                            SizedBox(height: 20,),
                            Text(contexts[i].descripcionPresentacion,style: TextStyle(fontSize: 18,color: Colors.grey[700]),textAlign: TextAlign.center,),
                            SizedBox(height: 30,),
                            TextFormField(
                              controller: _nombreController,
                              decoration: InputDecoration(
                                labelText: 'Nombre',
                                border: OutlineInputBorder(),
                              ),
                              validator: (v) => (v == null || v.trim().isEmpty) ? 'Ingrese su nombre' : null,
                            ),
                            SizedBox(height: 16),
                            TextFormField(
                              controller: _apellidoController,
                              decoration: InputDecoration(
                                labelText: 'Apellido',
                                border: OutlineInputBorder(),
                              ),
                              validator: (v) => (v == null || v.trim().isEmpty) ? 'Ingrese su apellido' : null,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }

                // páginas normales
                return SingleChildScrollView(child: Padding(padding: EdgeInsets.all(40),
                child: Column(children: [
                  Text(contexts[i].tituloPresentacion,style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                  SizedBox(height: 20,),
                  Text(contexts[i].descripcionPresentacion,style: TextStyle(fontSize: 18,color: Colors.grey[700]),textAlign: TextAlign.center,),
                ]

                ),),);
                
              }
            )
          ),
          // ignore: avoid_unnecessary_containers
          Container(
            child: Row(
              children: List.generate(contexts.length, (index) => bullPage(index,context)),
            ),
          ),
          SizedBox(
            height: 60,
            child: MaterialButton(onPressed: () async {
              // si estamos en la última página -> ir a Menu (sin volver)
              if(_currentIndex == contexts.length -1)
              {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=> Menu()));
                return;
              }

              // si estamos en la página 2 (índice 1) validamos el formulario antes de avanzar
              if (_currentIndex == 1) {
                if (!(_formKey.currentState?.validate() ?? false)) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Complete los campos requeridos'))
                  );
                  return;
                }
                // aquí puedes guardar los valores en donde necesites
                // ignore: unused_local_variable
                String nombre = _nombreController.text.trim();
                // ignore: unused_local_variable
                String apellido = _apellidoController.text.trim();
                // ejemplo: print(nombre + ' ' + apellido);
              }

              _controller.nextPage(duration: Duration(seconds: 1), curve: Curves.easeInOut);


            },
            color: Colors.black,
            child: Text(_currentIndex==contexts.length-1? "Continuar":"Siguiente",style: TextStyle(fontSize: 18),) ,),
          )
        ],
      ),
    );
  }
  Container bullPage(int index, BuildContext context)
  {
    return Container(
      height: 10,
      width: _currentIndex == index ? 25 : 10,
      decoration: BoxDecoration(
        color: _currentIndex == index ? Colors.black : Colors.grey,
        borderRadius: BorderRadius.circular(20)
      ),
    );
  }
}