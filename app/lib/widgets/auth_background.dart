import 'package:flutter/material.dart';

class AuthBackground extends StatelessWidget {
  final Widget child;

  const AuthBackground({super.key, required this.child});
  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Colors.white,
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: [
          _Box(),
          _HeaderIcon(),
          this.child,
        ],
      ),
    );
  }

  SafeArea _HeaderIcon() {
    return SafeArea(
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.only(top: 30),
        child: Icon(
          Icons.person_pin,
          color: Colors.white,
          size: 100,
        ),
      ),
    );
  }
}

class _Box extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: size.height * 0.4,
      decoration: _BoxDecoration(),
      child: Stack(
        children: [
          Positioned(child: _Bubble(), top: 40, left: 30),
          Positioned(child: _Bubble(), top: 300, left: 300),
          Positioned(child: _Bubble(), bottom: 70, right: 200),
          Positioned(child: _Bubble(), top: 120, left: 300),
          Positioned(child: _Bubble(), bottom: 170, left: 160),
          Positioned(child: _Bubble(), top: 270, left: 80),
          Positioned(child: _Bubble(), top: 30, right: -10),
        ],
      ),
    );
  }

  // ignore: non_constant_identifier_names
  BoxDecoration _BoxDecoration() => const BoxDecoration(
          gradient: LinearGradient(colors: [
        Color.fromRGBO(17, 90, 133, 1),
        Color.fromRGBO(224, 192, 144, 1)
      ]));
}

class _Bubble extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Color.fromRGBO(255, 255, 255, 0.2),
        ));
  }
}
