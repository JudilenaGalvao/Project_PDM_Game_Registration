import 'package:flutter/material.dart';

class TelaSobre extends StatelessWidget {
  const TelaSobre({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Sobre os desenvolvedores',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: const SobreBody(),
    );
  }
}

class SobreBody extends StatelessWidget {
  const SobreBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[300],
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 16),
          _buildInfo('Nome:', 'Judilena Galvão', 15),
          _buildInfo('Idade:', '20', 15),
          _buildInfo('Nome:', 'Arimatéia Souza', 15),
          _buildInfo('Idade:', '23', 15),
          _buildInfo('Universidade:', 'UFRN', 15),
          _buildInfo('Curso:', 'Análise e Desenvolvimento de Sistemas', 15),
          _buildInfo('Data de entrega do projeto:', '02/12/2023', 15),
        ],
      ),
    );
  }

  Widget _buildInfo(String label, String value, double fontSize) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              value,
              style: TextStyle(fontSize: fontSize),
            ),
          ),
        ],
      ),
    );
  }
}
