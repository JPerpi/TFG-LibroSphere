import 'package:biblioteca_app/model/detalles.dart';
import 'package:biblioteca_app/model/libros.dart';
import 'package:biblioteca_app/model/tipos.dart';
import 'package:biblioteca_app/repository/TiposRepository.dart';
import 'package:flutter/foundation.dart';

class ProviderLibros with ChangeNotifier {
  // Referència al repositori
  final _tiposRepository = TiposRepository();

  // Propietats per emmagatzemar l'estat al Provider
  String? _tipoActual;
  List<dynamic>? llistaLibros;
  String? _nomLibroActual;
  Libros? libroActual;
  List<Tipos>? tipos;
  Detalles? detallesLibroActual;
  List<Detalles>? llistaDetalles;
  String? _tituloActual;


  ProviderLibros() {
    // En el moment que creem el provider
    // caldrà carregar la llista de províncies
    _carregaTipos();
    
  }

  /* Mètodes Accessors */
  set tipoActual(String tipo) {
    // Actualitzem la província actual
    if (_tipoActual == null || _tipoActual != tipo) {
      llistaLibros =
          null; // Amb això fem que aparega l'indicador de progrés en lloc de les comarques anteriors
      _tipoActual = tipo;
      // Carreguem la llista de comarques de la província
      _carregaLibros(tipo);
    }
  }

set tituloActual(String titulo) {
    // Actualitzem la província actual
    if (_tituloActual == null || _tituloActual != titulo) {
      llistaDetalles =null; // Amb això fem que aparega l'indicador de progrés en lloc de les comarques anteriors
      _tituloActual = titulo;
      // Carreguem la llista de comarques de la província
      _carregaDetalls(titulo);
    }
  }

  String get nomLibroActual {
    return _nomLibroActual!;
  }

  set nomLibroActual(String titulo) {
    // Actualitzem la comarca actual
    debugPrint(titulo);
    if (_nomLibroActual == null || _nomLibroActual != titulo) {
      _nomLibroActual = titulo;
      libroActual = null;
      // Carreguem la informació de la comarca
    }
  }
  

  /* Altres mètodes */

  void _carregaTipos() async {
    // Obtenim les províncies de del mètode corresponent del repositori

    List<dynamic> jsonTipos =
        await _tiposRepository.obtenirTipos();
    //  El mapegem a una llista de províncies
    tipos = List<Tipos>.from(
        jsonTipos.map((tipo) => Tipos.fromJSON(tipo)));

    notifyListeners();
  }

  void _carregaLibros(String tipo) async {
    // Carreguem la llista de comarques
    List<Libros> jsonLibros =
        await _tiposRepository.getLibros(tipo);
    // Actualitzem l'estat
    llistaLibros = jsonLibros;
    // I notifiquem a tots els listeners que estiguen pendents del Provider
    notifyListeners();
  }

  void _carregaDetalls(String titulo) async {
    // Obtenim la informació sobre la comarca a través del repositori,
    // l'afegim a la propietat infoComarca i actualitzem el nom de la
    // comarca actual.
    // debugPrint("11111111111111");
    detallesLibroActual = await _tiposRepository.getDetalls(titulo);
    debugPrint(detallesLibroActual.toString());
    // List<Detalles> jsonDetalles =
    //     await _tiposRepository.getDetalls(titulo);
    // // Actualitzem l'estat
    // llistaLibros = jsonDetalles;

    // Notifiquem als consumidors d'aquest provider
    notifyListeners();
  }
}
