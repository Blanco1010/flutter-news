import 'package:flutter/material.dart';
import 'package:newsapp/src/models/news_models.dart';
import 'package:newsapp/src/theme/tema.dart';
import 'package:url_launcher/url_launcher.dart';

class ListaNoticias extends StatelessWidget {
  final List<Article> noticias;

  const ListaNoticias(this.noticias);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: this.noticias.length,
      itemBuilder: (BuildContext context, int index) {
        return _Noticia(
          article: this.noticias[index],
          index: index,
        );
      },
    );
  }
}

class _Noticia extends StatelessWidget {
  final Article article;
  final int index;

  const _Noticia({@required this.article, @required this.index});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _TarjetaTopBar(article: this.article, index: index),
        _TarjetaTitulo(article: this.article),
        _TarjetaImagen(article: this.article),
        _TarjetaBody(article: this.article),
        _TarjetaBotones(
          article: this.article,
        ),
        SizedBox(height: 10),
        Divider(color: Colors.white)
      ],
    );
  }
}

class _TarjetaBotones extends StatelessWidget {
  final Article article;

  const _TarjetaBotones({@required this.article});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          RawMaterialButton(
            onPressed: () {},
            fillColor: colorTab1,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Icon(Icons.star_border),
          ),
          SizedBox(width: 20),
          RawMaterialButton(
            onPressed: () async {
              if (await canLaunch(article.url)) {
                await launch(article.url);
              } else {
                throw 'Could not launch ${article.url}';
              }
            },
            fillColor: Colors.blue,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Icon(Icons.more),
          )
        ],
      ),
    );
  }
}

class _TarjetaBody extends StatelessWidget {
  final Article article;

  const _TarjetaBody({this.article});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      margin: EdgeInsets.only(top: 10),
      child: Text((article.description != null) ? article.description : ''),
    );
  }
}

class _TarjetaImagen extends StatelessWidget {
  final Article article;

  const _TarjetaImagen({@required this.article});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(50), bottomRight: Radius.circular(50)),
      child: Container(
          child: (article.urlToImage != null)
              ? FadeInImage(
                  placeholder: AssetImage('assets/img/giphy.gif'),
                  image: NetworkImage(article.urlToImage),
                  fit: BoxFit.cover,
                )
              : Image(
                  image: AssetImage('assets/img/no-image.png'),
                )),
    );
  }
}

class _TarjetaTitulo extends StatelessWidget {
  final Article article;

  const _TarjetaTitulo({@required this.article});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      margin: EdgeInsets.only(bottom: 10),
      child: Text(
        article.title,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
      ),
    );
  }
}

class _TarjetaTopBar extends StatelessWidget {
  final Article article;
  final int index;

  const _TarjetaTopBar({@required this.article, @required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      margin: EdgeInsets.only(bottom: 15, top: 15),
      child: Row(
        children: <Widget>[
          Text('${index + 1}', style: TextStyle(color: colorTab1)),
          SizedBox(width: 15),
          Expanded(child: Text('${article.author}')),
        ],
      ),
    );
  }
}
