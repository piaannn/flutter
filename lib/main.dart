import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class Coffee {
  final String name;
  final String imageUrl;

  Coffee(this.name, this.imageUrl);
}

class MyApp extends StatelessWidget {
  final List<Coffee> coffeeList = [
    Coffee('Kopi Arabika', 'assets/arabika.png'),
    Coffee('Kopi Robusta', 'assets/robusta.jpg'),
    // Tambahkan kopi lainnya dengan gambar
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Toko Kopi',
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
      home: HomePage(coffeeList: coffeeList),
      routes: {
        '/category': (context) => CategoryPage(coffeeList: coffeeList),
        '/detail': (context) => DetailPage(),
      },
    );
  }
}

class HomePage extends StatelessWidget {
  final List<Coffee> coffeeList;

  HomePage({required this.coffeeList});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Toko Kopi'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Selamat datang di Toko Kopi!'),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/category');
              },
              child: Text('Lihat Kategori'),
            ),
          ],
        ),
      ),
    );
  }
}

class CategoryPage extends StatelessWidget {
  final List<Coffee> coffeeList;

  CategoryPage({required this.coffeeList});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kategori Kopi'),
      ),
      body: ListView.builder(
        itemCount: coffeeList.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(coffeeList[index].name),
            onTap: () {
              Navigator.pushNamed(context, '/detail',
                  arguments: coffeeList[index]);
            },
          );
        },
      ),
    );
  }
}

class DetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Coffee coffee = ModalRoute.of(context)!.settings.arguments as Coffee;

    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Kopi'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Detail untuk kategori: ${coffee.name}'),
            Image.asset(coffee.imageUrl, width: 300, height: 200),
            // Tampilkan informasi rinci tentang kategori kopi di sini
          ],
        ),
      ),
    );
  }
}
