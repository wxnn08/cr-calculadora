import 'dart:math';
import 'package:calculadora_cr/model/disciplina.dart';
import 'package:flutter/material.dart';
import 'package:calculadora_cr/model/meu_cr.dart';

class CalcCrScreen extends StatefulWidget {
  MeuCR cr = new MeuCR(0, 0, 0, 0);
  CalcCrScreen(this.cr);

  @override
  _CalcCrScreenState createState() => _CalcCrScreenState();
}

class _CalcCrScreenState extends State<CalcCrScreen> {
  List<Disciplina> _disciplinas = new List<Disciplina>();
  double _proxCr = 0.0;
  var _ddConceito = new List<String>();
  var _ddCreditos = new List<String>();
  var conceitos = <String>['A', 'B', 'C', 'D', 'F', 'O'];
  Map<String, int> conceitosValor = Map<String, int>();
  var creditos = <String>['1', '2', '3', '4', '5', '6', '7', '8', '9'];
  TextEditingController _controllerNome = new TextEditingController();

  @override
  void initState() {
    _proxCr = widget.cr.crAtual;
    _disciplinas.clear();
    for (int i = 0; i < conceitos.length; i++) {
      conceitosValor[conceitos[i]] = max(0, 4 - i);
    }
    super.initState();
  }

  void attCr() {
    double novoCr = widget.cr.crAtual * widget.cr.credTotal;
    int credSoma = 0;
    for (var disciplina in _disciplinas) {
      credSoma += disciplina.creditos;
      novoCr += (conceitosValor[disciplina.conceito] * disciplina.creditos);
    }
    novoCr = novoCr / (credSoma + widget.cr.credTotal);
    setState(() {
      _proxCr = novoCr;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora CR'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                top: 16.0,
                bottom: 16.0,
                left: 8.0,
                right: 8.0,
              ),
              child: Column(
                children: <Widget>[
                  Card(
                    color: Theme.of(context).primaryColorDark,
                    elevation: 5,
                    shape: StadiumBorder(),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'CR: ' + _proxCr.toStringAsFixed(2),
                              style: TextStyle(
                                fontSize: 48,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Card(
                    color: Colors.grey[400],
                    elevation: 5,
                    shape: StadiumBorder(),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'CR: ' + widget.cr.crAtual.toStringAsFixed(2),
                              style: TextStyle(
                                fontSize: 48,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // Container(
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //     children: <Widget>[
                  //       Text(
                  //         'CR Atual: ' + widget.cr.crAtual.toString(),
                  //         style: TextStyle(
                  //           fontSize: 16,
                  //         ),
                  //       ),
                  //       Text(
                  //         'Créditos totais: ' + widget.cr.credTotal.toString(),
                  //         style: TextStyle(
                  //           fontSize: 16,
                  //         ),
                  //       )
                  //     ],
                  //   ),
                  // ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 16.0,
                    ),
                    child: Row(
                      children: <Widget>[
                        Flexible(
                          flex: 3,
                          child: TextField(
                            controller: _controllerNome,
                            keyboardType: TextInputType.text,
                            textCapitalization: TextCapitalization.sentences,
                            decoration: InputDecoration(
                              border: UnderlineInputBorder(),
                              hintText: 'Disciplina',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: double.maxFinite,
                    child: RaisedButton(
                      child: Text('ADICIONAR DISCIPLINA'),
                      onPressed: () {
                        if (_controllerNome.text.trim().isEmpty) {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Ops...'),
                                content:
                                    Text('Você esqueceu de colocar um nome!'),
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
                          _ddConceito.add(null);
                          _ddCreditos.add(null);
                          setState(() {
                            _disciplinas
                                .add(Disciplina(_controllerNome.text, 0, 'F'));
                            _controllerNome.clear();
                          });
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: ListView.separated(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: _disciplinas.length,
                separatorBuilder: (context, index) {
                  return Divider(
                    color: Colors.black,
                  );
                },
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(
                      _disciplinas[index].nome,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Row(
                      children: <Widget>[
                        DropdownButton<String>(
                          value: _ddCreditos[index],
                          elevation: 16,
                          hint: Text('Créditos'),
                          onChanged: (String value) {
                            setState(() {
                              _ddCreditos[index] = value;
                              _disciplinas[index].creditos = int.parse(value);
                              attCr();
                            });
                          },
                          items: creditos
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                        DropdownButton<String>(
                          value: _ddConceito[index],
                          elevation: 16,
                          hint: Text('Conceito'),
                          onChanged: (String value) {
                            setState(() {
                              _ddConceito[index] = value;
                              _disciplinas[index].conceito = value;
                              attCr();
                            });
                          },
                          items: conceitos
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                    trailing: FlatButton(
                      onPressed: () {
                        setState(() {
                          _disciplinas.removeAt(index);
                          attCr();
                        });
                      },
                      child: Icon(
                        Icons.remove,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
