import 'package:flutter/material.dart';
import 'package:newsapp/src/services/news_service.dart';
import 'package:newsapp/src/widgets/lista_noticias.dart';
import 'package:provider/provider.dart';

class Tab2Page extends StatefulWidget {
  @override
  _Tab2PageState createState() => _Tab2PageState();
}

//AutomaticKeepAliveClientMixin
//es para evitar que se pierda los datos cuando cambia el prodiver

class _Tab2PageState extends State<Tab2Page>
    with AutomaticKeepAliveClientMixin {
  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    final headlines = Provider.of<NewsService>(context).headlines;
//ListaNoticias(newService.headlines),
    return Scaffold(
      body: (headlines.length == 0)
          ? Center(child: CircularProgressIndicator())
          : ListaNoticias(headlines),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
