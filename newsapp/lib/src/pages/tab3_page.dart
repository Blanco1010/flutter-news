import 'package:flutter/material.dart';
import 'package:newsapp/src/models/category_models.dart';
import 'package:newsapp/src/services/news_service.dart';
import 'package:newsapp/src/theme/tema.dart';
import 'package:newsapp/src/widgets/lista_noticias.dart';
import 'package:provider/provider.dart';

class Tabs3Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final newService = Provider.of<NewsService>(context);

    return SafeArea(
        child: Scaffold(
            body: Column(
      children: [
        _ListaCategorias(),
        Expanded(
          child: (newService.getArticulosCategoriaSeleccionada.length == 0)
              ? Center(child: CircularProgressIndicator())
              : ListaNoticias(newService.getArticulosCategoriaSeleccionada),
        )
      ],
    )));
  }
}

class _ListaCategorias extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final category = Provider.of<NewsService>(context).category;

    return Container(
      width: double.infinity,
      height: 80,
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: category.length,
        itemBuilder: (BuildContext context, int index) {
          final cName = category[index].name;

          return Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              children: <Widget>[
                _CategoryButton(category: category[index]),
                SizedBox(height: 5),
                Text('${cName[0].toUpperCase()}${cName.substring(1)}')
              ],
            ),
          );
        },
      ),
    );
  }
}

class _CategoryButton extends StatelessWidget {
  final Category category;

  const _CategoryButton({this.category});

  @override
  Widget build(BuildContext context) {
    final newsService = Provider.of<NewsService>(context);

    return GestureDetector(
      onTap: () {
        final newsService = Provider.of<NewsService>(context, listen: false);
        newsService.selectedCategory = category.name;
      },
      child: Container(
        width: 40,
        height: 40,
        margin: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: (newsService.selectedCategory != category.name)
                ? Colors.white
                : colorTab2),
        child: Icon(
          category.icon,
          color: (newsService.selectedCategory != category.name)
              ? colorTab2
              : Colors.white,
        ),
      ),
    );
  }
}
