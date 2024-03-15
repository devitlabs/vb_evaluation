import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../../../constants/colors.dart';
import '../../../models/collaborateur_model.dart';
import '../../../widgets/custom_text.dart';
import 'admin_collaborateur_controller.dart';
import 'collaborateur_data_source.dart';

class WidgetTousCollaborateur extends StatefulWidget {
  const WidgetTousCollaborateur({super.key});

  @override
  State<WidgetTousCollaborateur> createState() => _WidgetTousCollaborateurState();
}

class _WidgetTousCollaborateurState extends State<WidgetTousCollaborateur> {

  final AdminCollaborateurController adminCollaborateurController = Get.put(AdminCollaborateurController());
  int _rowsPerPage = 20;
  int _isLoaded = 0;
  static const double dataPagerHeight = 60;
  CollaborateurDataSource collaborateurDataSource = CollaborateurDataSource(collaborateurs: []);

  double columnMargin = 5;

  TextEditingController _emailController = TextEditingController();

  List<CollaborateurModel> collaborateurs = [];


  void rechercheCollaborateur(String filter) async {
    adminCollaborateurController.filterCollaborateurs(filter);
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
      setState(() {
        collaborateurs = adminCollaborateurController.filteredCollaborateurs;
        collaborateurDataSource = CollaborateurDataSource(collaborateurs: collaborateurs);
      });
    }
  }

  void initialisation() async {
    setState(() {
      _isLoaded = 0;
    });
    adminCollaborateurController.getAllCollaborateurs();
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
      setState(() {
        _isLoaded = 1;
        collaborateurs = adminCollaborateurController.filteredCollaborateurs;
        collaborateurDataSource = CollaborateurDataSource(collaborateurs: collaborateurs);
      });
    }
  }

  @override
  void initState() {
    initialisation();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.clear();
    super.dispose();
  }


  Widget _buildDataPager() {
    return SfDataPagerTheme(
      data: SfDataPagerThemeData(
        brightness: Brightness.light,
        selectedItemColor: primaryColor,
      ),
      child: SfDataPager(
        delegate: collaborateurDataSource,
        availableRowsPerPage: const <int>[20, 30, 40],
        pageCount: 10 / _rowsPerPage,
        onRowsPerPageChanged: (int? rowsPerPage) {
          setState(() {
            _rowsPerPage = rowsPerPage!;
          });
        },
      ),
    );
  }

  Widget _buildLayoutBuilder() {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraint) {
          if (_isLoaded == 0 ) {
            return _loadingWidget();
          }
          if (_isLoaded != 1) {
            return refreshWidget();
          }
          return Column(
            children: <Widget>[
              SizedBox(
                  height: constraint.maxHeight - dataPagerHeight,
                  width: constraint.maxWidth,
                  child: _tableauWidget()),
              Container(
                height: dataPagerHeight,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                        top: BorderSide(
                            width: .5,
                            color: Theme.of(context)
                                .colorScheme
                                .onSurface
                                .withOpacity(0.12)))),
                child: Align(child: _buildDataPager()),
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return  Column(
        children: [
          SizedBox(
            height: 40,
            child: Row(
              children: [
                SizedBox(
                  width: 400,
                  height: 40,
                  child: TextFormField(
                    onFieldSubmitted: (value){
                      rechercheCollaborateur(value);
                    },
                    decoration: const InputDecoration(
                      hintText: "Nom du collaborateur",
                      labelText: "Recherche",
                      contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 2, color: secondaryColor),
                      ),
                    ),
                  ),
                ),
                Expanded(child: Container()),
                const SizedBox(width: 20,),
                refreshWidget(),
                const SizedBox(width: 20,),
                OutlinedButton(
                    style: OutlinedButton.styleFrom(backgroundColor: secondaryColor,foregroundColor: Colors.white),onPressed: () async {
                  _showAddCollaborateurDialog(context);
                },
                    child: const SizedBox(height: 40,child: Center(child: CustomText(text: "Ajouter un collaborateur",)))
                )
              ],
            ),
          ),
          SizedBox(height: 10,),
          Expanded(child: _isLoaded == 0 ? _loadingWidget() : _isLoaded == 1 ? _buildLayoutBuilder() : refreshWidget())
        ],
      );
  }

  Widget _loadingWidget() {
    return const Center(child: SizedBox(height: 50,width: 50,child: CircularProgressIndicator()));
  }

  Widget refreshWidget() {
    return Center(
      child: IconButton(
        icon: const Icon(Icons.refresh),
        onPressed: (){
          initialisation();
        },
      ),
    );
  }

  Widget _tableauWidget() {
    return SfDataGridTheme(
      data: SfDataGridThemeData(
        rowHoverColor: Color(0xFFFAF1D4),
        brightness: Brightness.light,
        headerHoverColor: Colors.white.withOpacity(0.3),
        headerColor: primaryColor,
      ),
      child: SfDataGrid(
        headerRowHeight: 40,
        columnWidthMode: ColumnWidthMode.fill,
        showVerticalScrollbar: true,
        isScrollbarAlwaysShown: true,
        source: collaborateurDataSource,
        columns: [
          GridColumn(
              width: 100,
              columnName: 'matricule',
              label: Container(
                  padding: EdgeInsets.symmetric(horizontal: columnMargin),
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    'Matricule',
                    style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,maxLines: 2,
                  ))
          ),
          GridColumn(
              columnName: 'nom',
              width: 150,
              label: Container(
                  padding: EdgeInsets.symmetric(horizontal: columnMargin),
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    'Nom',
                    style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                  ))),
          GridColumn(
              width: 180,
              columnName: 'prenoms',
              label: Container(
                  padding: EdgeInsets.symmetric(horizontal: columnMargin),
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    'Prénom(s)',
                    style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                  ))),
          GridColumn(
              columnName: 'email',
              label: Container(
                  padding: EdgeInsets.symmetric(horizontal: columnMargin),
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    'Email',
                    style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                  ))),
          GridColumn(
              width: 150,
              columnName: 'statutProfil',
              label: Container(
                  padding: EdgeInsets.symmetric(horizontal: columnMargin),
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    "Etat du profil",
                    style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                  ))),
          GridColumn(
              width: 130,
              columnName: 'dateentreevb',
              label: Container(
                  padding: EdgeInsets.symmetric(horizontal: columnMargin),
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    "Date entrée",
                    style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                  ))),
          GridColumn(
              width: 130,
              columnName: 'actions',
              label: Container(
                  padding: EdgeInsets.symmetric(horizontal: columnMargin),
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    "Actions",
                    style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                  )))
        ],
      ),
    );
  }

  Future<void> _showAddCollaborateurDialog(BuildContext context) async {
    final _formKey = GlobalKey<FormState>();
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Ajouter un collaborateur"),
          content: Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Form(
              key: _formKey,
              child: SizedBox(
                width: 400,
                child: TextFormField(
                  controller: _emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty || !GetUtils.isEmail(value) || !value.contains("versusbank.com")) {
                      return "L'adresse email renseignée est incorrecte.";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 2, color: secondaryColor),
                    ),
                    hintText: "Entrez votre email",
                    labelText: "Adresse email",
                  ),
                ),
              ),
            ),
          ),
          actionsAlignment: MainAxisAlignment.spaceBetween,
          actions: <Widget>[
            TextButton(
              child: Text("Annuler"),
              onPressed: () {
                _emailController.clear();
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                  backgroundColor: Colors.blue,
                foregroundColor: Colors.white
              ),
              child: Text("Ajouter"),
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  final result = await adminCollaborateurController.addCollaborateur(
                      collaborateurModel: CollaborateurModel(email: _emailController.text,estbloque: true)
                  );
                  if (result) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(backgroundColor: Colors.green,content: Text('Collaborateur ${_emailController.text} ajouté avec succès')),
                    );
                    initialisation();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(backgroundColor: Colors.red,content: Text('Echec')),
                    );
                  }
                  _emailController.clear();
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }
}
