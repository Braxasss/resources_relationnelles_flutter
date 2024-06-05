import 'package:flutter/material.dart';
import 'package:resources_relationnelles_flutter/widgets/custom_appbar.dart';
import 'package:resources_relationnelles_flutter/widgets/custom_sidebar.dart';
import 'package:resources_relationnelles_flutter/widgets/prelogin.dart';
import 'package:resources_relationnelles_flutter/widgets/stats_widget.dart';



class LandingPage extends StatelessWidget {
  
  const LandingPage({super.key});
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(
          title: Text('Bienvenue sur (RE)SOURCES Relationnelles'),
      ),
      drawer: CustomSidebar(),
      body: ContainerExample()
    );
  }
  
}
class ContainerExample extends StatelessWidget {
  const ContainerExample({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Landing Page',
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Que souhaitez-vous consulter aujourd\'hui ?',),
        ),
        body: Padding(
          padding: const EdgeInsets.all(120.2), // Add margin around the grid
          child: GridView.count(
            crossAxisCount: 2, // Number of columns
            crossAxisSpacing: 200, // Spacing between columns
            mainAxisSpacing: 200, // Spacing between rows
            children: <Widget>[
              const PreLogin(),
              const StatsWidget(),
              Container(
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(10),
                ), child: const Align(
                  alignment: Alignment.topCenter, 
                  child: Text(
                    'Consulter les ressources',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}