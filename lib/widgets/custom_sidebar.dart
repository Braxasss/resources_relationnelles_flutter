import 'package:flutter/material.dart';
import 'package:resources_relationnelles_flutter/main.dart';
import 'package:resources_relationnelles_flutter/pages/favorite/liste_favorites.dart';
import 'package:resources_relationnelles_flutter/pages/utilisateur/profil.dart';
import 'package:resources_relationnelles_flutter/pages/landing_page.dart';
import 'package:resources_relationnelles_flutter/services/get_user.dart';

class CustomSidebar extends StatelessWidget {
  const CustomSidebar({super.key});

  dynamic getUser() async {
    return await fetchUtilisateurByToken();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getUser(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        var user = snapshot.data;
        if (user == null) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else {
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
                      MaterialPageRoute(builder: (context) => const LandingPage()),
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
                if (user != false)
                  ListTile(
                    title: const Text('Favoris'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const ListerFavoriesPage()),
                      );
                    },
                  ),
                if (user != false)
                ListTile(
                  title: const Text('Profil'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ProfilePage()),
                    );
                  },
                ),
                if (user != false)
                ListTile(
                  title: const Text('Déconnexion'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ProfilePage()),
                    );
                  },
                ),
                if (user == false)
                ListTile(
                  title: const Text('Se connecter'),
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
      },
    );
  }
}
