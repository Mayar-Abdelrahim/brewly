import 'package:material_ui/material_ui.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Brewly'),
      ),
      body: const Center(
        child: Text('Welcome to Brewly!'),
      ),
    );
  }
}