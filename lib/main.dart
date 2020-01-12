import 'package:flutter/material.dart';

void main() {
  runApp(Home());
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController _pesoController = TextEditingController();
  TextEditingController _alturaController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _resultado = "Informe seus dados!";

  void _resetFields() {
    _pesoController.text = '';
    _alturaController.text = '';
    setState(() {
      _resultado = 'Informe seus dados!';
      _formKey = GlobalKey<FormState>();
    });
  }

  void _calculate() {
    setState(() {
      double peso = double.parse(_pesoController.text);
      double altura = double.parse(_alturaController.text) / 100;
      double resultado = peso / (altura * altura);

      String resultadoStr = resultado.toStringAsPrecision(4);

      if (resultado < 18.6) {
        _resultado = 'Abaixo do peso - IMC: $resultadoStr ';
      } else if (resultado >= 18.6 && resultado <= 24.9) {
        _resultado = 'Peso ideal - IMC: $resultadoStr';
      } else if (resultado >= 24.9 && resultado <= 29.9) {
        _resultado = 'Levemente acima do peso - IMC: $resultadoStr';
      } else if (resultado >= 29.9 && resultado <= 34.9) {
        _resultado = 'Obesidade Grau I - IMC: $resultadoStr';
      } else if (resultado >= 34.9 && resultado <= 39.9) {
        _resultado = 'Obesidade Grau II - IMC: $resultadoStr';
      } else if (resultado > 39.9) {
        _resultado = 'Obesidade Grau III - IMC: $resultadoStr';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora de IMC',
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('Calculadora IMC'),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                _resetFields();
              },
            )
          ],
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Icon(Icons.person_outline,
                    size: 120.0, color: Colors.deepPurple),
                TextFormField(
                  validator: (String value) {
                    return value.isEmpty ? 'Informe o peso!' : null;
                  },
                  keyboardType: TextInputType.number,
                  controller: _pesoController,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.deepPurple, fontSize: 25),
                  decoration: InputDecoration(
                      labelText: 'Peso(Kg)',
                      labelStyle: TextStyle(color: Colors.deepPurple)),
                ),
                TextFormField(
                  validator: (String value) {
                    return value.isEmpty ? 'Informe a altura' : null;
                  },
                  keyboardType: TextInputType.number,
                  controller: _alturaController,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.deepPurple, fontSize: 25),
                  decoration: InputDecoration(
                      labelText: 'Altura(cm)',
                      labelStyle: TextStyle(color: Colors.deepPurple)),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20, bottom: 20),
                  child: Container(
                    height: 50,
                    child: RaisedButton(
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          _calculate();
                        }
                      },
                      color: Colors.deepPurple,
                      child: Text(
                        'Calcular',
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      ),
                    ),
                  ),
                ),
                Text(
                  _resultado,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.deepPurple, fontSize: 25),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
