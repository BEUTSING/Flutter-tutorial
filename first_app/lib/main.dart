import 'package:flutter/material.dart';
import 'package:first_app/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:  Home(),
    );
  }
}

/// Main page (Stateful to manage form and dropdown)
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  /// Controller to get the value from the text field
  final TextEditingController _controllername = TextEditingController();
  final TextEditingController _controlleremail = TextEditingController();
final _formKey = GlobalKey<FormState>();  // EN: Used to validate the form  


@override
 void dispose(){
  _controllername.dispose();
  _controlleremail.dispose();
  super.dispose();
 }

  /// Selected value in the dropdown
  String? selectedValue;

  /// Function to display a message (SnackBar)
  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
 appBar: AppBar(
        title: Text("Flutter Example"),
      ),
      /// Drawer (side menu)
      drawer: Drawer(
        child: ListView(
          children: [

            /// Drawer header
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text(
                "Menu",
                style: TextStyle(color: Colors.white, fontSize: 24),

              ),
            ),

            /// Menu item (ListTile)
            /// ListTile = clickable row with title + icon
            ListTile(
              leading: Icon(Icons.home),
              title: Text("Home"),
              onTap: () {
                showMessage("Home clicked");
              },
            ),

            ListTile(
              leading: Icon(Icons.settings),
              title: Text("Settings"),
              onTap: () {
                showMessage("Settings clicked");
              },
            ),
          ],
        ),
      ),

     


      /// Main content
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [

            /// ================= BUTTONS =================

            /// ElevatedButton (raised button)
            /// Used for primary actions
            ElevatedButton(
              onPressed: () {
                showMessage("ElevatedButton clicked");
              },
              child: Text("ElevatedButton"),
            ),

            /// TextButton (flat button without background)
            /// Used for secondary actions
            TextButton(
              onPressed: () {
                showMessage("TextButton clicked");
              },
              child: Text("TextButton"),
            ),

            /// OutlinedButton (button with border)
            /// Alternative between Elevated and TextButton
            OutlinedButton(
              onPressed: () {
                showMessage("OutlinedButton clicked");
              },
              child: Text("OutlinedButton"),
            ),

            /// IconButton (button with icon only)
            IconButton(
              icon: Icon(Icons.thumb_up),
              onPressed: () {
                showMessage("IconButton clicked");
              },
            ),

            /// FloatingActionButton (usually used at bottom right)
            FloatingActionButton(
              onPressed: () {
                showMessage("FloatingActionButton clicked");
              },
              child: Icon(Icons.add),
            ),

            SizedBox(height: 20),

            /// ================= FORM =================

            /// Form = container for input fields
            Form(
              key: _formKey,
              child: Column(
                children: [

                  /// Text field
                  /// You will add validators yourself
                  TextFormField(
                    controller: _controllername,
                    decoration: InputDecoration(
                      labelText: "Name",
                      border: OutlineInputBorder(),
                    ),
                     validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter name";
                      }
                      return null;
                    },      
                                      
                  ),

                  SizedBox(height: 10),
                  // Contrôleur pour stocker le texte sélectionné dans le champ
TextEditingController _controllerDate = TextEditingController();

// Champ de formulaire pour sélectionner une date
TextFormField(
  controller: _controllerDate, // Texte affiché dans le champ
  decoration: InputDecoration(
    labelText: "Date de naissance", // Titre du champ
    border: OutlineInputBorder(),   // Bordure autour du champ
    suffixIcon: Icon(Icons.calendar_today), // Icône calendrier à droite
  ),
  readOnly: true, // On ne peut pas taper dans le champ, seulement sélectionner via calendrier
  onTap: () async {
    // Ouvre le sélecteur de date
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),       // Date par défaut affichée
      firstDate: DateTime(1900),         // Limite inférieure du calendrier
      lastDate: DateTime(2100),          // Limite supérieure du calendrier
    );

    if (pickedDate != null) {
      // Formate la date sélectionnée en texte "jour/mois/année"
      String formattedDate = "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";

      // Met à jour le champ avec la date sélectionnée
      setState(() {
        _controllerDate.text = formattedDate;
      });
    }
  },
  validator: (value) {
    // Vérifie que l'utilisateur a bien sélectionné une date
    if (value == null || value.isEmpty) {
      return "Veuillez sélectionner une date";
    }
    return null; // Pas d'erreur si tout va bien
  },
),
// Variable pour stocker l'image choisie
File? _image;

// Fonction pour sélectionner une image depuis la galerie
Future<void> pickImage() async {
  final ImagePicker picker = ImagePicker(); // Initialise le sélecteur d'image
  final XFile? image = await picker.pickImage(source: ImageSource.gallery); // Ouvre la galerie

  if (image != null) {
    // Convertit le fichier choisi en File pour l'afficher
    setState(() {
      _image = File(image.path); // Stocke l'image dans la variable _image
    });
  }
}

// Widget pour afficher l'image ou un message si aucune n'est choisie
Column(
  children: [
    _image == null
        ? Text("Aucune image sélectionnée") // Affiche ce texte si aucune image
        : Image.file(_image!, height: 150), // Sinon affiche l'image choisie
    ElevatedButton(
      onPressed: pickImage, // Lance la fonction pour choisir une image
      child: Text("Choisir une image"), // Texte du bouton
    ),
  ],
),
                DropdownButtonFormField<String>(
                  value:selectedvalue,
                  hint: Text("choose an option"),
                  items:["value 1","value 2","value 3"].map((value){
                    return DropdownMenuItem(
                      value:value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged:(value){
                    setState(() {
                      selectedValue=value;
                    });
                    showMessage("Selected: $value");
                  },
                   validator: (value) {
                      if (value == null) {
                        return "Please select an option";
                      }
                      return null;
                    },
                ),

                  SizedBox(height: 10),

                  /// Email field (example)
                  TextFormField(
                    controller: _controlleremail,
                    decoration: InputDecoration(
                      labelText: "Email",
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter email";
                      }
                      return null;
                    },
                  ),
                   /// ================= DROPDOWN =================

            /// DropdownButtonFormField = dropdown list
            /// Allows selecting a value from multiple options
            DropdownButtonFormField<String>(
              value: selectedValue2,
              hint: Text("Choose an option"),
              items: ["Option 1", "Option 2", "Option 3"]
                  .map((value) {
                return DropdownMenuItem(
                  value: value,
                  child: Text(value),
                );
              }).toList(),

              /// When the user selects a value
              onChanged: (value) {
                setState(() {
                  selectedValue2 = value;
                });
                showMessage("Selected: $value");
              },
               validator: (value) {
                  if (value == null) {
                    return "Please select an option";
                  }
                  return null;
                },
            ),

                  SizedBox(height: 10),

                  /// Submit button (no validation here)
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                          String name = _controllername.text;
                          String email = _controlleremail.text;
                          String dropdown = selectedValue!;
                          String dropdown2 = selectedValue2!;

                          showMessage("Name: $name, Email: $email, Option: $dropdown, Option 2: $dropdown2");
                        }
                      },    
                    child: Text("Submit"),
                  ),
                ],
              ),
            ),

            SizedBox(height: 20),
            TextButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Home()),
                );
              },
              icon: Icon(Icons.home),
              label: Text("Accueil"),
            )
          ],
        ),
      ),
    );
  }
}