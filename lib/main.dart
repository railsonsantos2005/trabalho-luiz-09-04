import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class Person {
  String imagePath;
  String id;
  String name;
  String lastName;
  String number;
  String cpf;
  DateTime birthday;
  DateTime registeredAt;

  Person({
    required this.imagePath,
    required this.id,
    required this.name,
    required this.lastName,
    required this.number,
    required this.cpf,
    required this.birthday,
    required this.registeredAt,
  });

  static Person getExample() {
    return Person(
      imagePath: "assets/profile.png",
      id: "RAILSON_ID_01",
      name: "Railson",
      lastName: "Santos",
      number: "(86) 99967-9754",
      cpf: "123.456.789-00",
      birthday: DateTime.parse("2005-11-26"),
      registeredAt: DateTime.parse("2005-12-26"),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gerenciador de Contatos',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/list': (context) => PersonListScreen(),
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade900, Colors.blue.shade300],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.contacts, size: 100, color: Colors.white),
                SizedBox(height: 24),
                Text(
                  'Gerenciador de Contatos',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        blurRadius: 10,
                        color: Colors.black45,
                        offset: Offset(2, 2),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 12),
                Text(
                  'Gerencie seus contatos de forma prática e eficiente.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.white70),
                ),
                SizedBox(height: 32),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pushNamed(context, '/list');
                  },
                  icon: Icon(Icons.arrow_forward),
                  label: Text(
                    'Ver Lista de Pessoas',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.blue.shade900,
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 8,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PersonListScreen extends StatelessWidget {
  const PersonListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final person = Person.getExample();

    return Scaffold(
      appBar: AppBar(title: Text('Lista de Pessoas')),
      body: ListView(children: [PersonCard(person: person)]),
    );
  }
}

class PersonCard extends StatelessWidget {
  final Person person;

  const PersonCard({Key? key, required this.person}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(12),
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      shadowColor: Colors.blueAccent.withOpacity(0.4),
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade100, Colors.blue.shade50],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.asset(
                person.imagePath,
                height: 100,
                width: 100,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(Icons.person, size: 100, color: Colors.grey);
                },
              ),
            ),
            SizedBox(height: 12),
            Text(
              '${person.name} ${person.lastName}',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade900,
              ),
            ),
            SizedBox(height: 8),
            _buildInfoRow(Icons.badge, 'ID: ${person.id}'),
            _buildInfoRow(Icons.phone, 'Telefone: ${person.number}'),
            _buildInfoRow(Icons.credit_card, 'CPF: ${person.cpf}'),
            _buildInfoRow(
              Icons.cake,
              'Nascimento: ${_formatDate(person.birthday)}',
            ),
            _buildInfoRow(
              Icons.calendar_today,
              'Registrado em: ${_formatDate(person.registeredAt)}',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 6),
      child: Row(
        children: [
          Icon(icon, size: 18, color: Colors.blueGrey),
          SizedBox(width: 6),
          Expanded(child: Text(text, style: TextStyle(fontSize: 16))),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return "${date.day.toString().padLeft(2, '0')}/"
        "${date.month.toString().padLeft(2, '0')}/"
        "${date.year}";
  }
}
