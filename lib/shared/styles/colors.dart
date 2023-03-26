import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';

const Color veryDarkBlue = Color.fromRGBO(15, 16, 21, 1);
const Color darkerBlue = Color.fromRGBO(19, 21, 27, 1);
const Color darkBlue = Color.fromRGBO(23, 24, 33, 1);
const Color primary = Color.fromARGB(255, 224, 70, 27);

final buttonColors = WindowButtonColors(
    iconNormal: const Color(0xFF805306),
    mouseOver: const Color(0xFFF6A00C),
    mouseDown: const Color(0xFF805306),
    iconMouseOver: const Color(0xFF805306),
    iconMouseDown: const Color(0xFFFFD500));

final closeButtonColors = WindowButtonColors(
    mouseOver: const Color(0xFFD32F2F),
    mouseDown: const Color(0xFFB71C1C),
    iconNormal: const Color(0xFF805306),
    iconMouseOver: Colors.white);

const borderColor = Color(0xFF805306);
