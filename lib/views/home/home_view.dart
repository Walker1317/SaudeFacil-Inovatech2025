import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:ionicons/ionicons.dart';
import 'package:saude_facil_inovatech/models/emergency_request.dart';
import 'package:saude_facil_inovatech/views/faqs/faq_screen.dart';
import 'package:saude_facil_inovatech/views/home/request_view.dart';
import 'package:saude_facil_inovatech/views/home/widgets/chatbot_screen.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  EmergencyRequest? request;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 900;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        image: DecorationImage(
          image: AssetImage('images/home_background.png'),
          fit: BoxFit.cover,
          opacity: 0.2
        )
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Image.asset(
            "images/logo.png",
            height: 60,
          ),
          actions: [
            if(request != null)
            Container(
              margin: const EdgeInsets.only(right: 10),
              child: ElevatedButton.icon(
                onPressed: (){
                  showDialog(
                    context: context,
                    builder: (context)=> AlertDialog(
                      title: Text("Tem certeza?"),
                      content: Text("Deseja mesmo encerrar este atendimento?"),
                      actions: [
                        TextButton(
                          onPressed: ()=> Navigator.pop(context),
                          child: Text("Cancelar", style: TextStyle(color: Colors.grey),)
                        ),
                        TextButton(
                          onPressed: (){
                            Navigator.pop(context);
                            setState(() {
                              request = null;
                            });
                          },
                          child: Text("Encerrar Chamado", style: TextStyle(color: Colors.redAccent[700]),)
                        ),
                      ],
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(100),
                    side: BorderSide(
                      color: Colors.redAccent[700]!,
                      width: 2
                    )
                  )
                ),
                icon: Icon(Icons.logout_outlined, color: Colors.redAccent[700],),
                label: Text("Encerrar Chamado", style: TextStyle(color: Colors.redAccent[700], fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
        body: request != null ?
        RequestView(request: request!):
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 200,
                width: 200,
                child: PulsatingCircleIconButton(
                  onTap: loading ? (){} : () async {
                    final permission = await Geolocator.requestPermission();
                    if(permission.name == "whileInUse"){
                      showModalBottomSheet(
                        // ignore: use_build_context_synchronously
                        context: context,
                        isDismissible: false,
                        backgroundColor: Colors.white,
                        builder: (context){
                          return Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Icon(
                                    Icons.emergency_outlined,
                                    color: Theme.of(context).primaryColor,
                                    size: 40,
                                  ),
                                ),
                                const SizedBox(height: 10,),
                                Text(
                                  "Acionando 190",
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                                ),
                                Text(
                                  "Estamos te Localizando...",
                                  style: TextStyle(color: Colors.grey, fontSize: 12),
                                ),
                                const SizedBox(height: 10,),
                                const LinearProgressIndicator(),
                              ],
                            ),
                          );
                        }
                      );
                      await Future.delayed(const Duration(seconds: 3));
                      final position = await Geolocator.getCurrentPosition();
                      final address = await getAddressFromLatLng(position.latitude, position.longitude);
                      Navigator.pop(context);
                      setState(() {
                        request = EmergencyRequest(
                          id: generateUuidV4(),
                          address: address,
                          lat: position.latitude,
                          lgn: position.longitude,
                          date: DateTime.now(),
                        );
                        loading = false;
                      });
                    } else {
                      showDialog(
                        // ignore: use_build_context_synchronously
                        context: context,
                        builder: (context){
                          return AlertDialog(
                            title: Text(
                              "Localização necessária",
                              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.redAccent[700]),
                            ),
                            content: Text("Para enviar ajuda rapidamente, precisamos da sua localização. Sem isso, o tempo de resposta pode ser maior."),
                            actions: [
                              FilledButton(
                                onPressed: ()=> Navigator.pop(context),
                                child: Text("OK")
                              )
                            ],
                          );
                        }
                      );
                    }
                  },
                  icon: Icon(Icons.emergency_outlined, color: Colors.white, size: 60,)
                ),
              ),
              const SizedBox(height: 60,),
              SizedBox(
                height: 60,
                child: ElevatedButton.icon(
                  onPressed: (){
                    showDialog(
                      context: context,
                      builder: (context)=> Scaffold(
                        backgroundColor: Colors.white,
                        appBar: AppBar(),
                        body: Center(child: ChatbotScreen()),
                      )
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.circular(100),
                      side: BorderSide(
                        color: Theme.of(context).primaryColor,
                        width: 3
                      )
                    )
                  ),
                  icon: Icon(Ionicons.chatbox_ellipses_outline, size: 30, color: Theme.of(context).primaryColor,),
                  label: Text("Iniciar Atendimento via Chat", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Theme.of(context).primaryColor),)
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: request != null ? null:
        isMobile ?
        Container(
          height: 100,
          margin: const EdgeInsets.only(bottom: 10),
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              const SizedBox(width: 10,),
              SizedBox(
                width: MediaQuery.of(context).size.width / 1.2,
                child: Card(
                  child: ListTile(
                    onTap: (){
                      showDialog(context: context, builder: (context)=> const FaqScreen());
                    },
                    leading: Icon(Ionicons.chatbox_ellipses_outline, size: 30, color: Theme.of(context).primaryColor,),
                    title: Text("Dúvidas Frequentes", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                    subtitle: Text("Respostas rápidas para suas perguntas."),
                  )
                ),
              ),
              const SizedBox(width: 10,),
              SizedBox(
                width: MediaQuery.of(context).size.width / 1.2,
                child: Card(
                  child: ListTile(
                    leading: Icon(Ionicons.information_circle_outline, size: 30, color: Theme.of(context).primaryColor,),
                    title: Text("Sobre o Saúde Fácil", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                    subtitle: Text("Saiba quem somos e o nosso objetivo."),
                  )
                ),
              ),
              const SizedBox(width: 10,),
              SizedBox(
                width: MediaQuery.of(context).size.width / 1.2,
                child: Card(
                  child: ListTile(
                    leading: Icon(Ionicons.phone_portrait_outline, size: 30, color: Theme.of(context).primaryColor,),
                    title: Text("Baixar APP", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                    subtitle: Text("Obtenha o Saúde Fácil em poucos cliques."),
                  )
                ),
              ),
            ],
          ),
        ):
        Column(
          mainAxisSize: MainAxisSize.min,
          children: bottom()
        ),
      ),
    );
  }

  List<Widget> bottom(){
    return [
      Container(
        margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
        constraints: BoxConstraints(
          maxWidth: 1000,
        ),
        child: Row(
          children: [
            Flexible(
              child: Card(
                child: ListTile(
                  onTap: (){
                    showDialog(context: context, builder: (context)=> const FaqScreen());
                  },
                  leading: Icon(Ionicons.chatbox_ellipses_outline, size: 30, color: Theme.of(context).primaryColor,),
                  title: Text("Dúvidas Frequentes", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                  subtitle: Text("Respostas rápidas para suas perguntas."),
                )
              ),
            ),
            Flexible(
              child: Card(
                child: ListTile(
                  leading: Icon(Ionicons.information_circle_outline, size: 30, color: Theme.of(context).primaryColor,),
                  title: Text("Sobre o Saúde Fácil", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                  subtitle: Text("Saiba quem somos e o nosso objetivo."),
                )
              ),
            ),
            Flexible(
              child: Card(
                child: ListTile(
                  leading: Icon(Ionicons.phone_portrait_outline, size: 30, color: Theme.of(context).primaryColor,),
                  title: Text("Baixar APP", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                  subtitle: Text("Obtenha o Saúde Fácil em poucos cliques."),
                )
              ),
            ),
          ],
        ),
      ),
    ];
  }

  Widget verticalDivider(){
    return Container(
      width: 1,
      height: 160,
      color: Colors.black,
    );
  }
}



class PulsatingCircleIconButton extends StatefulWidget {
  const PulsatingCircleIconButton({
    super.key,
    required this.onTap,
    required this.icon,
  });

  final GestureTapCallback onTap;
  final Icon icon;

  @override
  // ignore: library_private_types_in_public_api
  _PulsatingCircleIconButtonState createState() => _PulsatingCircleIconButtonState();
}

class _PulsatingCircleIconButtonState extends State<PulsatingCircleIconButton> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation _animation;

  @override
  void initState() {
    _animationController = AnimationController(vsync: this, duration: Duration(seconds: 2));
    _animation = Tween(begin: 0.0, end: 12.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
    _animationController.repeat(reverse: true);
    super.initState();
  }

  @override
  void dispose() {
    _animationController.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    Color color = Colors.redAccent[700]!;

    return InkWell(
      borderRadius: BorderRadius.circular(100),
      onTap: widget.onTap,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, _) {
          return Ink(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
              /*border: Border.all(
                width: 2,
                color: color
              ),*/
              boxShadow: [
                for (int i = 1; i <= 2; i++)
                  BoxShadow(
                    // ignore: deprecated_member_use
                    color: color.withOpacity(_animationController.value / 2),
                    spreadRadius: _animation.value * i,
                  )
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                widget.icon,
                const SizedBox(height: 10,),
                Text("Acionar 190", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: Colors.white),)
              ],
            ),
          );
        },
      ),
    );
  }
}


String generateUuidV4() {
  final random = Random.secure();

  String generateHex(int length) {
    return List.generate(length, (_) => random.nextInt(16).toRadixString(16))
        .join();
  }

  // Estrutura do UUID v4: 8-4-4-4-12
  final part1 = generateHex(8);
  final part2 = generateHex(4);
  final part3 = '4${generateHex(3)}'; // versão 4
  final part4 = '${(random.nextInt(4) + 8).toRadixString(16)}${generateHex(3)}'; // variante
  final part5 = generateHex(12);

  return '$part1-$part2-$part3-$part4-$part5';
}


Future<String> getAddressFromLatLng(double latitude, double longitude) async {
  const apiKey = 'AIzaSyBIQf5Qtyfo_H5xW3ek-kH7Un2ZUITJGNQ';
  final url = Uri.parse(
    'https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude,$longitude&key=$apiKey',
  );

  String result = "";

  final response = await http.get(url);

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);

    if (data['status'] == 'OK') {
      final results = data['results'] as List;
      if (results.isNotEmpty) {
        final address = results[0]['formatted_address'];
        debugPrint('Endereço: $address');
        result = address;
      } else {
        debugPrint('Nenhum endereço encontrado.');
      }
    } else {
      debugPrint('Erro na API: ${data['status']}');
    }
  } else {
    debugPrint('Falha na requisição: ${response.statusCode}');
  }
  return result;
}

