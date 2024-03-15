import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:vb_performance/constants/colors.dart';
import 'package:vb_performance/widgets/custom_text.dart';

class MenuSection extends StatefulWidget {
  const MenuSection({super.key});

  @override
  State<MenuSection> createState() => _MenuSectionState();
}

class _MenuSectionState extends State<MenuSection> {

  String currentRoute = "";

  void initialisation() {
    final location = GoRouterState.of(context).uri.toString();
    final listString = location.split("/");
    setState(() {
      currentRoute = listString[2];
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    initialisation();
    var width = MediaQuery.of(context).size.width;
    return Material(
      elevation: 5,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
          color: Color(0xFFFAF1D4),
          borderRadius: BorderRadius.only(bottomRight: Radius.circular(50))
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomText(text: "Menu",fontSize: 20,),
            const SizedBox(height: 20,),
            ButtonMenu(
              libelle: "Accueil",
              subRoute: "accueil",
              currentRoute: currentRoute,
              icon: Icons.home,
              routeDirection: "/espace/accueil",
            ),
            const SizedBox(height: 15,),
            ButtonMenu(
              libelle: "Mes Evaluations",
              subRoute: "mes-evaluations",
              currentRoute: currentRoute,
              icon: Icons.sticky_note_2,
              routeDirection: "/espace/mes-evaluations",
            ),
            const SizedBox(height: 15,),
            ButtonMenu(
              libelle: "Ma Team",
              subRoute: "ma-team",
              currentRoute: currentRoute,
              icon: Icons.groups,
              routeDirection: "/espace/ma-team",
            ),
            const SizedBox(height: 15,),
            ButtonMenu(
              libelle: "Mon Profil",
              subRoute: "mon-profil",
              currentRoute: currentRoute,
              icon: Icons.person,
              routeDirection: "/espace/mon-profil",
            ),
            const SizedBox(height: 15,),
            ButtonMenu(
              libelle: "Administration",
              subRoute: "administration",
              currentRoute: currentRoute,
              icon: Icons.settings,
              routeDirection: "/espace/administration",
            ),
            const SizedBox(height: 15,),
            Expanded(child: Container()),
            const LogoutButton(),
            const SizedBox(height: 40,),
          ],
        ),
      ),
    );
  }
}


class LogoutButton extends StatefulWidget {
  const LogoutButton({super.key});

  @override
  State<LogoutButton> createState() => _LogoutButtonState();
}

class _LogoutButtonState extends State<LogoutButton> {

  bool isHovering = false;

  @override
  Widget build(BuildContext context) {
    return  Row(
      children: [
        const SizedBox(width: 10,),
        InkWell(
          onHover: (value){
            setState(() {
              isHovering = value;
            });
          },
          onTap: () async {
            afficherDialogueDeDeconnexion(context);
          },
          child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isHovering ? const Color(0xFFE5EBF0) :Colors.transparent,
              ),
              child: const Icon(Icons.logout,color: Colors.red,size: 30,)),
        ),
        const SizedBox(width: 20,),
        const CustomText(text: 'Déconnexion')
      ],
    );
  }

  void afficherDialogueDeDeconnexion(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const AlertDialog(
          title: Text("Déconnexion"),
          content: ContentAlertDeconnexion(),
        );
      },
    );
  }
}



class ContentAlertDeconnexion extends StatefulWidget {
  const ContentAlertDeconnexion({super.key});

  @override
  State<ContentAlertDeconnexion> createState() => _ContentAlertDeconnexionState();
}

class _ContentAlertDeconnexionState extends State<ContentAlertDeconnexion> {

  bool isDeconnected = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text("Êtes-vous sûr de vouloir vous déconnecter ?"),
        SizedBox(height: 20,),
        isDeconnected ? CircularProgressIndicator() : Container(),
        SizedBox(height: 20,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Ferme le dialogue
              },
              child: Text("Annuler"),
            ),
            TextButton(
              onPressed: ()  async {
                setState(() {
                  isDeconnected = true;
                });
                const storage =  FlutterSecureStorage();
                await storage.deleteAll();
                context.go("/login");
              },
              child: Text("Se déconnecter",style: TextStyle(color: Colors.red),),
            ),
          ],
        )
      ],
    );
  }
}



class ButtonMenu extends StatefulWidget {
  final String libelle;
  final String subRoute;
  final String? routeDirection;
  final String currentRoute;
  final IconData icon;
  final bool?  isExtended;
  const ButtonMenu({super.key, required this.libelle, required this.subRoute, required this.icon, this.isExtended, required this.currentRoute, required this.routeDirection});

  @override
  State<ButtonMenu> createState() => _ButtonMenuState();
}

class _ButtonMenuState extends State<ButtonMenu> {

  bool isHovering = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        if (widget.routeDirection != null ) {
          context.go("${widget.routeDirection}");
        }
        //context.go("/espace/${widget.subRoute}");
      },
      onHover: (value){
        setState(() {
          isHovering = value;
        });
      },
      child: Container(
        height: 40,
        width: double.infinity,
        decoration: widget.subRoute == widget.currentRoute ?  BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: primaryColor.withOpacity(0.3),
          border: const Border(left: BorderSide(color: primaryBoldColor,width: 4))
        ) : isHovering ? BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          color: const Color(0xFFE5EBF0)
        ) : null ,
        child: Row(
          children: [
            const SizedBox(width: 10,),
            Icon(widget.icon,color: widget.subRoute == widget.currentRoute ? primaryBoldColor : Colors.black,),
            const SizedBox(width: 10,),
            CustomText(text: widget.libelle,isBold: true,color: widget.subRoute == widget.currentRoute ? primaryBoldColor  : Colors.black,fontSize: 16,)
          ],
        ),
      ),
    );
  }
}


