import 'package:calculadora_cr/screens/about_screen.dart';
import 'package:calculadora_cr/screens/calc_cr_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:calculadora_cr/model/meu_cr.dart';
import 'package:line_icons/line_icons.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double _sliderCrValue = 0.0;
  TextEditingController _controllerAprovados = new TextEditingController();
  TextEditingController _controllerReprovadosFreq = new TextEditingController();
  TextEditingController _controllerReprovados = new TextEditingController();

  @override
  void dispose() {
    _controllerAprovados.dispose();
    _controllerReprovados.dispose();
    _controllerReprovadosFreq.dispose();
    super.dispose();
  }

  bool textFieldsAreOk() {
    return _controllerAprovados.text.trim().length > 0 &&
        _controllerReprovados.text.trim().length > 0 &&
        _controllerReprovadosFreq.text.trim().length > 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CR Simulator'),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              LineIcons.question_circle,
              size: 30,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AboutScreen()),
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.arrow_forward),
        onPressed: () {
          if (!textFieldsAreOk()) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Ops...'),
                  content: Text('Você deixou algum campo em branco!'),
                  actions: <Widget>[
                    FlatButton(
                      child: Text('Ok'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              },
            );
          } else {
            var cr = MeuCR(
              _sliderCrValue,
              int.parse(_controllerAprovados.text.trim()),
              int.parse(_controllerReprovadosFreq.text.trim()),
              int.parse(_controllerReprovados.text.trim()),
            );
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CalcCrScreen(cr)),
            );
          }
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Text(
                'Meu CR',
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
            ),
            Text(
              _sliderCrValue.toStringAsFixed(2),
              style: TextStyle(
                fontSize: 50,
              ),
            ),
            Slider(
              min: 0,
              max: 4,
              divisions: 400,
              onChanged: (double value) {
                setState(() {
                  _sliderCrValue = value;
                });
              },
              value: _sliderCrValue,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                keyboardType: TextInputType.numberWithOptions(
                  signed: false,
                  decimal: false,
                ),
                controller: _controllerAprovados,
                decoration: InputDecoration(
                  labelText: 'Créditos aprovados',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                keyboardType: TextInputType.numberWithOptions(
                  signed: false,
                  decimal: false,
                ),
                controller: _controllerReprovadosFreq,
                decoration: InputDecoration(
                  labelText: 'Créditos reprovados freq.',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                keyboardType: TextInputType.numberWithOptions(
                  signed: false,
                  decimal: false,
                ),
                controller: _controllerReprovados,
                decoration: InputDecoration(
                  labelText: 'Créditos reprovados',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
