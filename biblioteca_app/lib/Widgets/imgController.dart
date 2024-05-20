import 'dart:io';

import 'package:flutter/material.dart';

class ImgController extends StatelessWidget {
  final String imagePath;

  const ImgController({Key? key, required this.imagePath}) : super(key: key);

 @override
  Widget build(BuildContext context) {
    return Container(
      child: _buildImage(),
    );
  }

  Widget _buildImage() {
    // Verificar si la ruta es una URL
    if (imagePath.startsWith('http') || imagePath.startsWith('https')) {
      return Image.network(
        imagePath,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Center(child: CircularProgressIndicator(
            value: loadingProgress.expectedTotalBytes != null
                ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                : null,
          ));
        },
        errorBuilder: (context, error, stackTrace) => const Text('Failed to load the image'),
      );
    } else if (File(imagePath).existsSync()) {
      // Si el archivo existe en el sistema de archivos del dispositivo
      return Image.file(
        File(imagePath),
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => const Text('Failed to load the image'),
      );
    } else {
      // Si se asume que es un asset
      return Image.asset(
        imagePath,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => const Text('Failed to load the image'),
      );
    }
  }
}
