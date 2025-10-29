import 'package:flutter/material.dart';

AppBar globalAppBar(){
  return AppBar(
    toolbarHeight: 120,
    title: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "Saúde Fácil",
          style: TextStyle(
            fontSize: 42,
            color: Colors.white,
          ),
        ),
        Text(
          "atendimento online",
          style: TextStyle(fontSize: 24),
        ),
      ],
    ),
    actions: [
      menuButton(onPressed: (){}, title: "Orientações"),
      menuButton(onPressed: (){}, title: "Menu"),
      menuButton(onPressed: (){}, title: "Serviços"),
      menuButton(onPressed: (){}, title: "Notícias"),
    ],
  );
}

Widget menuButton({required void Function()? onPressed, required String title}){
  return Container(
    height: 50,
    margin: const EdgeInsets.only(right: 10),
    child: ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(20)
        ),
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        
      ),
      child: Text(title, style: TextStyle(fontSize: 18),)
    ),
  );
}