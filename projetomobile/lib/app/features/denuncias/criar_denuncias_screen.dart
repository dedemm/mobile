import 'package:flutter/material.dart';
import 'package:projetomobile/app/features/denuncias/criar_denuncias_viewmodel.dart';

class CriarDenunciasScreen extends StatefulWidget {
  final CriarDenunciasViewmodel criarDenunciasViewmodel;

  const CriarDenunciasScreen({super.key, required this.criarDenunciasViewmodel});

  @override
  State<CriarDenunciasScreen> createState() => _CriarDenunciasScreenState();
}

class _CriarDenunciasScreenState extends State<CriarDenunciasScreen> {
  @override
  void initState() {
    widget.criarDenunciasViewmodel.addListener(onSave);
    super.initState();
  }

  @override
  void dispose() {
    widget.criarDenunciasViewmodel.removeListener(onSave);
    super.dispose();
  }

  void onSave(){
    if (widget.criarDenunciasViewmodel.feedback.isNotEmpty){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(widget.criarDenunciasViewmodel.feedback))
      );
    }
  }

  Widget build(BuildContext context) {
    final vm = widget.criarDenunciasViewmodel;
    return ListenableBuilder(
      listenable: vm,
      builder: (context, child) {
        return Scaffold(
          appBar: AppBar(
            leading: Icon(Icons.add_shopping_cart),
            centerTitle: true,
            title: (vm.isLoading)
                ? Row(
                    mainAxisAlignment: .center,
                    children: [
                      SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text('Loading'),
                      ),
                    ],
                  )
                : Text('Listinha'),
          ),
          body: Column(
            children: [
              TextField(
                onChanged: (value) => vm.feedback = value,
                decoration: const InputDecoration(
                  labelText: 'Feedback',
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  // Simulate saving the feedback
                  vm.feedback = 'Denúncia salva com sucesso!';
                },
                child: const Text('Salvar Denúncia'),
              ),
            ],
          ),
        );
      },
    );
  }
}