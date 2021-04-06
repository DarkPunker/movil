import 'package:flutter/material.dart';
import 'package:movil/src/models/product_,model.dart';
import 'package:movil/src/providers/products_provider.dart';
import 'package:movil/src/widget/drawer_menu.dart';

class ProductsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final products = new ProductsProvider();
    return Scaffold(
      appBar: AppBar(
        title: Text('Productos'),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.search,
              semanticLabel: 'search',
            ),
            onPressed: () {
              print('Search button');
            },
          ),
          IconButton(
            icon: Icon(
              Icons.tune,
              semanticLabel: 'filter',
            ),
            onPressed: () {
              print('Filter button');
            },
          ),
        ],
      ),
      drawer: MenuDrawer(),
      body: new FutureBuilder<List<Product>>(
        future: products.getProducts(),
        builder: (context, AsyncSnapshot<List> snapshot) {
          if (snapshot.hasData) {
            return new Padding(
              padding: new EdgeInsets.all(16.0),
              child: GridView.builder(
                  itemCount: snapshot.data.length,
                  gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemBuilder: (BuildContext context, int index) {
                    return _cardProducts(context, snapshot.data[index]);
                  }),
            );
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
      resizeToAvoidBottomInset: false,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => Navigator.pushNamed(context, 'NewProduct'),
      ),
    );
  }

  Widget _cardProducts(BuildContext context, Product data) {
    final ThemeData theme = Theme.of(context);
    //final String peso ="$";
    return GestureDetector(
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AspectRatio(
              aspectRatio: 18 / 8,
              child: FadeInImage(
                image: NetworkImage('https://image.freepik.com/foto-gratis/vista-frontal-cerrada-agua-limon-bebida-fresca-fresca-limones-rodajas-dentro-vasos-transparentes_140725-18030.jpg'),
                placeholder: AssetImage('assets/images/not-found-image.png'),
                fit: BoxFit.fitWidth,
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '${data.code} ${data.name}',
                      style: theme.textTheme.headline6,
                      maxLines: 1,
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      data.description,
                      style: theme.textTheme.subtitle2,
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      '${String.fromCharCodes(new Runes('\u0024'))} ${data.value.toString()}',
                      style: theme.textTheme.subtitle2,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      onDoubleTap: () =>
          Navigator.pushNamed(context, 'NewProduct', arguments: data),
    );
  }
}
