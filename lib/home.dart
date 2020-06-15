import 'dart:math';

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController controllerNumero = TextEditingController();

  String resultado = "Chute um número";
  int random = 0;
  int tentativas = 0;

  void generateRandom() {
    int max = 100;
    int min = 1;

    Random rnd = new Random();
    this.setState(() {
      random = min + rnd.nextInt(max - min);
    });

    setState(() {
      resultado = "Chute um número";
      tentativas = 0;
    });
  }

  void validateNumber() {
    if (controllerNumero.text == "") {
      setState(() {
        resultado = "Digite um número primeiro!";
      });
    } else {
      int numero = int.tryParse(controllerNumero.text);

      if (numero == random) {
        setState(() {
          resultado = "Você acertou!! foram $tentativas tentativas";
        });
      } else if (numero < random) {
        setState(() {
          resultado = "Número menor que o gerado!";
          tentativas++;
        });
      } else {
        setState(() {
          resultado = "Número maior que o gerado!";
          tentativas++;
        });
      }

      controllerNumero.text = "";
    }
  }

  void initState() {
    super.initState();
    generateRandom();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Adivinhe o número'),
          centerTitle: true,
        ),
        body: Container(
            padding: EdgeInsets.all(16),
            child: GestureDetector(
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                },
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                          padding: EdgeInsets.only(bottom: 32),
                          child: Text(
                            resultado,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.deepPurple),
                          )),
                      Padding(
                          padding: EdgeInsets.only(bottom: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text('Digite um número:'),
                              TextField(
                                keyboardType: TextInputType.number,
                                controller: controllerNumero,
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          )),
                      Padding(
                          padding: EdgeInsets.only(bottom: 16),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                  child: Padding(
                                      padding: EdgeInsets.only(right: 5),
                                      child: RaisedButton(
                                        onPressed: validateNumber,
                                        child: Text('Enviar',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16)),
                                        color: Colors.deepPurple,
                                      ))),
                              Expanded(
                                  child: Padding(
                                      padding: EdgeInsets.only(left: 5),
                                      child: RaisedButton(
                                        onPressed: generateRandom,
                                        child: Text('Novo',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16)),
                                        color: Colors.deepPurple,
                                      )))
                            ],
                          )),
                    ]))));
  }
}
