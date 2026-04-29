import 'package:flutter/material.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List products = [];

  @override
  void initState() {
    super.initState();
    products = [
      {"name": "Produit 1", "price": 100},
      {"name": "Produit 2", "price": 200},
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Produits")),

      // 🔹 Drawer
      drawer: Drawer(
        child: ListView(
          children: const [
            DrawerHeader(child: Text("Menu")),
            ListTile(title: Text("Accueil")),
            ListTile(title: Text("Carte")),
          ],
        ),
      ),

      // 🔹 Liste
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          var p = products[index];

          return Card(
            child: ListTile(
              title: Text(p["name"]),
              subtitle: Text("Prix: ${p["price"]}"),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(icon: Icon(Icons.edit), onPressed: () {}),
                  IconButton(icon: Icon(Icons.delete), onPressed: () {}),
                ],
              ),
            ),
          );
        },
      ),

      // 🔹 Bouton ajouter
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => Home()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}