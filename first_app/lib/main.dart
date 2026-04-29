import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:  MyHomePage(),
    );
  }
}

/// Main page (Stateful to manage form and dropdown)
class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  /// Controller to get the value from the text field
  final TextEditingController _controller = TextEditingController();

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
              child: Column(
                children: [

                  /// Text field
                  /// You will add validators yourself
                  TextFormField(
                    controller: _controller,
                    decoration: InputDecoration(
                      labelText: "Name",
                      border: OutlineInputBorder(),
                    ),
                  ),

                  SizedBox(height: 10),

                  /// Email field (example)
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: "Email",
                      border: OutlineInputBorder(),
                    ),
                  ),

                  SizedBox(height: 10),

                  /// Submit button (no validation here)
                  ElevatedButton(
                    onPressed: () {
                      showMessage("Form submitted");
                    },
                    child: Text("Submit"),
                  ),
                ],
              ),
            ),

            SizedBox(height: 20),

            /// ================= DROPDOWN =================

            /// DropdownButtonFormField = dropdown list
            /// Allows selecting a value from multiple options
            DropdownButtonFormField<String>(
              value: selectedValue,
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
                  selectedValue = value;
                });
                showMessage("Selected: $value");
              },
            ),
          ],
        ),
      ),
    );
  }
}