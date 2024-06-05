import 'package:flutter/material.dart';
import 'package:resources_relationnelles_flutter/main.dart';
import 'package:resources_relationnelles_flutter/pages/favorite/liste_favorites.dart';
import 'package:resources_relationnelles_flutter/pages/utilisateur/profil.dart';
import 'package:resources_relationnelles_flutter/pages/landing_page.dart';

class CustomSidebar extends StatelessWidget {

  const CustomSidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Color(0xFF008F77),
            ),
            child: Text(
              '(RE)SOURCES Relationnelles',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
          ListTile(
            title: const Text('Accueil'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LandingPage() ),
              );
            },
          ),
          ListTile(
            title: const Text('Ressources'),
            onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const MyApp()),
                          );
            },
          ),
            ListTile(
              title: const Text('Favoris'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ListerFavoriesPage()),
                );
              },
            ),
          ListTile(
            title: const Text('Profil'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfilePage()),
              );
            },
          ),
          ListTile(
            title: const Text('Déconnexion'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfilePage()),
              );
            },
          ),
        ],
      ),
    );
  }
}
