import 'package:biblioteca_app/model/detalles.dart';
import 'package:biblioteca_app/model/libros.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TiposRepository {
  Future<List<dynamic>> obtenirTipos() async {
     /// Obté la llista de províncies
    try {
      // Nota: Per a que funcione en web cal afegir al web/manifest.json la línia "permissions": ["http://*/", "https://*/"],
      String url =
          "http://localhost:8080/api/biblioteca/tipos";
      var data = await http.get(Uri.parse(url));
      if (data.statusCode == 200) {
        String body = utf8.decode(data.bodyBytes);
        final bodyJSON = jsonDecode(body);
        return bodyJSON;
      } else {
        return [];
      }
    } catch (except) {
      debugPrint(except.toString());
      return [];
    }
  }

  Future<List<Libros>> getLibros(String tipo) async {
    String infoUrl =
        'http://localhost:8080/api/biblioteca/libros/$tipo';
    try {
      var infoResponse = await http.get(Uri.parse(infoUrl));

      if (infoResponse.statusCode == 200) {
        //print('Respuesta exitosa: ${infoResponse.body}');
        List<Map<String, dynamic>> infoJSON = List<Map<String, dynamic>>.from(
            jsonDecode(utf8.decode(infoResponse.bodyBytes)));
        List<Libros> libros =
            infoJSON.map((libros) => Libros.fromJSON(libros)).toList();

        return libros;
      } else if (infoResponse.statusCode == 404) {
        return []; // Devuelve una lista vacía en caso de error
      }
    } catch (error) {
      print('Error en la solicitud de Libros: $error');
      throw Exception('Error en la solicitud de comarcas: $error');
    }

    return []; // Devuelve una lista vacía por defecto
  }

  //  Future<List<Detalles>> getDetalls(String titulo) async {
  //   String infoUrl =
  //       'http://localhost:8080/api/biblioteca/detalles/$titulo';
  //   try {
  //     var infoResponse = await http.get(Uri.parse(infoUrl));

  //     if (infoResponse.statusCode == 200) {
  //       //print('Respuesta exitosa: ${infoResponse.body}');
  //       List<Map<String, dynamic>> infoJSON = List<Map<String, dynamic>>.from(
  //           jsonDecode(utf8.decode(infoResponse.bodyBytes)));
  //       List<Detalles> detalles =
  //           infoJSON.map((detalles) => Detalles.fromJSON(detalles)).toList();

  //       return detalles;
  //     } else if (infoResponse.statusCode == 404) {
  //       return []; // Devuelve una lista vacía en caso de error
  //     }
  //   } catch (error) {
  //     print('Error en la solicitud de Libros: $error');
  //     throw Exception('Error en la solicitud de comarcas: $error');
  //   }

  //   return []; // Devuelve una lista vacía por defecto
  // }

  Future<Detalles?> getDetalls(String titulo) async {
    String url =
        'http://localhost:8080/api/biblioteca/detalles/$titulo';

    try {
      var response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        debugPrint("11111111111111");
        Map<String, dynamic> bodyJSON =
            jsonDecode(utf8.decode(response.bodyBytes));
        Detalles detallsLibro = Detalles.fromJSON(bodyJSON);
        debugPrint(detallsLibro.toString());
        return detallsLibro;
      } else if (response.statusCode == 404) {
        return null; // Retorna null en caso de que no se encuentre la comarca
      }
    } catch (error) {
      throw Exception('Error en la solicitud: $error');
    }

    // También puedes retornar null aquí si prefieres
    return null;
  }
}
