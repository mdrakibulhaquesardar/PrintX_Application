import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import '/resources/themes/styles/color_styles.dart';
import 'package:nylo_framework/nylo_framework.dart';

/* Helpers
|--------------------------------------------------------------------------
| Add your helper methods here
|-------------------------------------------------------------------------- */

/// helper to find correct color from the [context].
class ThemeColor {
  static ColorStyles get(BuildContext context, {String? themeId}) =>
      nyColorStyle<ColorStyles>(context, themeId: themeId);

  static Color fromHex(String hexColor) => nyHexColor(hexColor);
}


// Clean up cache directories


Future<void> cleanUpCache() async {
  try {
    final directory = await getTemporaryDirectory();
    final cacheDir = Directory(directory.path);

    if (await cacheDir.exists()) {
      // Delete all files first
      await for (var entity in cacheDir.list(recursive: true)) {
        if (entity is File && entity.path.endsWith('.pdf')) {
          await entity.delete();
        }
      }

      // Delete empty directories
      await for (var entity in cacheDir.list(recursive: true)) {
        if (entity is Directory) {
          try {
            if (await entity.list().isEmpty) {
              await entity.delete();
            }
          } catch (e) {
            print('Error deleting folder: ${entity.path}, Error: $e');
          }
        }
      }
      print('Cache cleaned up successfully.');
    }


  } catch (e) {
    print('Error cleaning up cache: $e');
  }
}





