import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutScreen extends StatelessWidget {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Sobre'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage('assets/images/wesley.jpg'),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 16),
                width: 300,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      'Logo quando entrei na UFABC eu gostava de ficar calculando quanto ficaria meu CR dos próximos quadrimestres, imaginando os vários Wesleys '
                      'de vários universos que tiravam vários As, Bs, CR 4 e tal... O problema é que aparentemente eu estava no pior universo, então parei de ficar '
                      'fazendo isso. Eu já tinha feito um aplicativo desse há uns anos atrás para minha namorada calcular as notas dela, mas era muito feio, '
                      'então juntando isso com o fato de eu ter conhecido outras pessoas também fazem essas contas na calculadora (que tristeza Robert), acho que esse '
                      'App vai ajudar bastante :)',
                      softWrap: true,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey[700],
                      ),
                    ),
                    Text(
                      '- Wesley',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    IconButton(
                      iconSize: 50,
                      icon: Icon(
                        LineIcons.github,
                        color: Colors.black,
                      ),
                      onPressed: () async {
                        const url = 'https://github.com/wxnn08';
                        if (await canLaunch(url)) {
                          await launch(url);
                        } else {
                          throw 'Could not launch $url';
                        }
                      },
                    ),
                    IconButton(
                      iconSize: 50,
                      icon: Icon(
                        LineIcons.youtube_square,
                        color: Colors.red,
                      ),
                      onPressed: () {
                        final snackBar = SnackBar(
                          content: Text('O canal está sendo criado!'),
                          action: SnackBarAction(
                            label: 'OK',
                            onPressed: () {},
                          ),
                        );
                        print('Cheguei aqui');
                        _scaffoldKey.currentState.showSnackBar(snackBar);
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
