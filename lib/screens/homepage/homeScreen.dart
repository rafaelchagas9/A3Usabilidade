import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:olimpiadas/models/esportes.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future<Esporte> getEsportesLista() async {
      var url = Uri.parse(
          "https://raw.githubusercontent.com/rafaelchagas9/JSON/main/esportes.json");
      var response = await http.get(url);
      var json = jsonDecode(response.body);
      var esportes = Esporte.fromJson(json);
      return esportes;
    }

    var esportes = getEsportesLista();

    return Scaffold(
      body: Center(
          child: FutureBuilder(
        future: getEsportesLista(),
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            var teste = snapshot.data?.esportes;
            return ListView.builder(
              itemCount: snapshot.data?.esportes?.length,
              itemBuilder: (context, index) {
                return Container(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Text(snapshot.data?.esportes![index].name as String),
                      const SizedBox(
                        height: 10,
                      ),
                      Stack(
                        children: [
                          CachedNetworkImage(
                            fit: BoxFit.fill,
                            imageUrl: snapshot.data?.esportes![index].imageUrl
                                as String,
                          ),
                          Positioned(
                            right: 0,
                            top: 0,
                            child: IconButton(
                              onPressed: (() {}),
                              icon: const Icon(Icons.favorite_border_outlined),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(snapshot.data?.esportes![index].descricao as String)
                    ],
                  ),
                );
              },
            );
          }
        },
      )),
    );
  }
}
