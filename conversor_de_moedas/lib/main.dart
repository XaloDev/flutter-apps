import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

const request = 'https://api.hgbrasil.com/finance?key=596734ae';

void main() async {
  runApp(MaterialApp(
    home: Home(),
    theme: ThemeData(hintColor: Colors.green, primaryColor: Colors.white),
  ));
}

Future<Map> getData() async {
  http.Response response = await http.get(request);
  return json.decode(response.body);
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final realController = TextEditingController();
  final dolarController = TextEditingController();
  final euroController = TextEditingController();
  final libraController = TextEditingController();
  final bitcoinController = TextEditingController();

  double dolar;
  double euro;
  double libraesterlina;
  double bitcoin;

  void _realChanged(String text){
    if(text.isEmpty) {
      _clearAll();
      return;
    }
    double real = double.parse(text);
    dolarController.text = (real/dolar).toStringAsFixed(2);
    euroController.text = (real/euro).toStringAsFixed(2);
    bitcoinController.text = (real/ bitcoin).toStringAsFixed(5);
    libraController.text = (real / libraesterlina).toStringAsFixed(2);

  }
  void _dolarChanged(String text){
    if(text.isEmpty) {
      _clearAll();
      return;
    }
    double dolar = double.parse(text);
    realController.text = (dolar* this.dolar).toStringAsFixed(2);
    euroController.text = (dolar* this.dolar / euro).toStringAsFixed(2);
    bitcoinController.text = (dolar* this.dolar / bitcoin).toStringAsFixed(5);
    libraController.text = (dolar* this.dolar / libraesterlina).toStringAsFixed(2);

  }
  void _euroChanged(String text){
    if(text.isEmpty) {
      _clearAll();
      return;
    }
    double euro = double.parse(text);
    realController.text = (euro * this.euro).toStringAsFixed(2);
    dolarController.text = (euro * this.euro / dolar).toStringAsFixed(2);
    bitcoinController.text = (euro * this.euro / bitcoin).toStringAsFixed(5);
    libraController.text = (euro * this.euro / libraesterlina).toStringAsFixed(2);
  }
  void _libraesterlinaChanged(String text){
    if(text.isEmpty) {
      _clearAll();
      return;
    }
    double libraesterlina = double.parse(text);
    realController.text = (libraesterlina * this.libraesterlina).toStringAsFixed(2);
    dolarController.text = (libraesterlina * this.libraesterlina / dolar).toStringAsFixed(2);
    euroController.text = (libraesterlina * this.libraesterlina / euro).toStringAsFixed(2);
    bitcoinController.text = (libraesterlina * this.libraesterlina / bitcoin).toStringAsFixed(5);

  }
  void _bitcoinChanged(String text){
    if(text.isEmpty) {
      _clearAll();
      return;
    }
    double bitcoin = double.parse(text);
    realController.text = (bitcoin * this.bitcoin).toStringAsFixed(2);
    dolarController.text = (bitcoin * this.bitcoin / dolar).toStringAsFixed(2);
    euroController.text = (bitcoin * this.bitcoin / euro).toStringAsFixed(2);
    libraController.text = (bitcoin * this.bitcoin / libraesterlina).toStringAsFixed(2);
  }

  void _clearAll(){
    realController.text = "";
    dolarController.text = "";
    euroController.text = "";
    libraController.text = "";
    bitcoinController.text = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Conversor de moedas \$\$'),
        backgroundColor: Colors.green,
        centerTitle: true,
      ),
      body: FutureBuilder<Map>(
        future: getData(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Center(
                child: Text(
                  'Carregando Dados...',
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 25,
                  ),
                  textAlign: TextAlign.center,
                ),
              );
            default:
              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    'Erro ao Carregar Dados :c',
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 25,
                    ),
                    textAlign: TextAlign.center,
                  ),
                );
              } else {
                dolar = snapshot.data['results']['currencies']['USD']['buy'];
                euro = snapshot.data['results']['currencies']['EUR']['buy'];
                libraesterlina = snapshot.data['results']['currencies']['GBP']['buy'];
                bitcoin = snapshot.data['results']['currencies']['BTC']['buy'];
                return SingleChildScrollView(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Icon(
                        Icons.monetization_on,
                        size: 150,
                        color: Colors.green,
                      ),
                      buildTextField('Reais', 'R\$',realController,_realChanged),
                      Divider(),
                      buildTextField('Dólares', 'US\$',dolarController,_dolarChanged),
                      Divider(),
                      buildTextField('Euros', '€',euroController,_euroChanged),
                      Divider(),
                      buildTextField('Libra Esterlina', '£'	, libraController, _libraesterlinaChanged),
                      Divider(),
                      buildTextField('Bitcoin', '฿'	, bitcoinController, _bitcoinChanged),


                    ],
                  ),
                );
              }
          }
        },
      ),
    );
  }
}

Widget buildTextField(String label, String prefix, TextEditingController controlador, Function funcao){
  return TextField(
    controller: controlador,
    decoration: InputDecoration(
      labelText: label,
      labelStyle:
      TextStyle(color: Colors.green, fontSize: 25.0),
      border: OutlineInputBorder(),
      prefixText: prefix,
    ),
    style: TextStyle(
      color: Colors.green,
      fontSize: 25,
    ),
    onChanged: funcao,
    keyboardType: TextInputType.numberWithOptions(decimal: true),
  );
}
