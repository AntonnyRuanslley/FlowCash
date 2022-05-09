import 'dart:convert';

import '../components/transactions_file.dart';
import 'package:cas/data/urls.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class CategorysList extends StatefulWidget {
  const CategorysList({Key? key}) : super(key: key);

  @override
  State<CategorysList> createState() => _CategorysListState();
}

class _CategorysListState extends State<CategorysList> {
  List _categories = [];
  Future<String>? getCategories;

  Future<String> _getCategories() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var url = Uri.parse(urls['categories']!);
    var answer = await http.get(
      url,
      headers: {
        "Authorization": "Bearer ${sharedPreferences.getString('token')}",
      },
    );
    if (answer.statusCode == 200) {
      print(answer.statusCode);
      setState(() {
        _categories = jsonDecode(answer.body)['data'];
      });
      return "Sucesso";
    } else {
      print(answer.statusCode);
      return "Erro";
    }
  }

  _refresh() {
    setState(() {});
  }

  initState() {
    getCategories = _getCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final sizeScreen = MediaQuery.of(context).size.height;

    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      backgroundColor: Theme.of(context).colorScheme.primary,
      title: Text(
        "Selecione a categoria",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.secondary,
        ),
      ),
      content: SingleChildScrollView(
        child: SizedBox(
          height: sizeScreen * 0.6,
          child: FutureBuilder<String>(
            future: getCategories,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(
                      color: Theme.of(context).colorScheme.primary),
                );
              }
              if (snapshot.hasError) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Text('Erro: ${snapshot.error}'),
                  ),
                );
              }
              return _categories.isEmpty
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: sizeScreen * 0.01),
                          child: Container(
                            height: sizeScreen * 0.25,
                            child: const Image(
                              image: AssetImage(
                                'assets/images/vazio.png',
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Container(
                          child: Text(
                            'Sem transações!',
                            style: TextStyle(
                              fontSize: sizeScreen * 0.05,
                              color: Colors.black,
                            ),
                          ),
                        )
                      ],
                    )
                  : ListView.builder(
                      itemCount: _categories.length,
                      itemBuilder: (ctx, i) {
                        return TextButton(
                          onPressed: () {},
                          child: Text(
                            _categories[i]['name'],
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.secondary,
                                fontSize: sizeScreen * 0.03),
                          ),
                        );
                      },
                    );
            },
          ),
        ),
      ),
    );
  }
}
