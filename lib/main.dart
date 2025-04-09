import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

// === App com Rotas ===
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App gov.br',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        scaffoldBackgroundColor: Colors.grey[100],
        cardTheme: CardTheme(
          color: Colors.white,
          shadowColor: Colors.grey.withOpacity(0.2),
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        textTheme: TextTheme(bodyLarge: TextStyle(fontSize: 16)),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/lista': (context) => ListaScreen(),
      },
    );
  }
}

// === Tela Inicial ===
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tela Inicial')),
      body: Center(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            backgroundColor: Colors.indigo,
          ),
          onPressed: () {
            Navigator.pushNamed(context, '/lista');
          },
          child: Text(
            'Ir para Lista de Pessoas',
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
        ),
      ),
    );
  }
}

// === Tela da Lista com Widget personalizado ===
class ListaScreen extends StatelessWidget {
  final List<Person> pessoas = [
    Person(
      imagePath: 'https://i.imgur.com/QCNbOAo.png',
      id: '1',
      name: 'Beatriz',
      lastName: 'Silva',
      number: '+5581912345678',
      cpf: '123.456.789-00',
      birthday: DateTime(1990, 3, 15),
      registeredAt: DateTime.now(),
    ),
    Person(
      imagePath: 'https://i.imgur.com/QCNbOAo.png',
      id: '2',
      name: 'Marcos',
      lastName: 'Souza',
      number: '+5581999999999',
      cpf: '987.654.321-00',
      birthday: DateTime(1988, 7, 22),
      registeredAt: DateTime.now().subtract(Duration(days: 20)),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Lista de Pessoas')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView.separated(
          itemCount: pessoas.length,
          separatorBuilder: (context, index) => SizedBox(height: 12),
          itemBuilder: (context, index) {
            return PersonCard(person: pessoas[index]);
          },
        ),
      ),
    );
  }
}

// === Widget Exemplo: Card personalizado ===
class PersonCard extends StatelessWidget {
  final Person person;

  const PersonCard({Key? key, required this.person}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.network(
                person.imagePath,
                width: 70,
                height: 70,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${person.name} ${person.lastName}',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 6),
                  _buildInfoText('CPF', person.cpf),
                  _buildInfoText('Telefone', person.number),
                  _buildInfoText('Nascimento', _formatDate(person.birthday)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoText(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Text('$label: $value', style: TextStyle(color: Colors.grey[700])),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/'
        '${date.month.toString().padLeft(2, '0')}/'
        '${date.year}';
  }
}

// === Classe Exemplo ===
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
}
