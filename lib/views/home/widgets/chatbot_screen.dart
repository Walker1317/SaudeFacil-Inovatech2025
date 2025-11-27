import 'dart:math';

import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:saude_facil_inovatech/models/message.dart';

class ChatbotScreen extends StatefulWidget {
  const ChatbotScreen({super.key});

  @override
  State<ChatbotScreen> createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen> {
  List<Message> messages = [
    Message(
      content: "Olá, este é o atendimento de emergência do Saúde Fácil. Sua ajuda está a caminho, por favor me conte mais detalhes do ocorrido...",
      isMe: false,
      date: DateTime.now()
    ),
  ];
  final controller = TextEditingController();
  bool isEditing = false;
  final ScrollController _scrollController = ScrollController();

  
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      constraints: BoxConstraints(
        maxWidth: 800
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Text("Chat em tempo real", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
          ),
          Container(
            height: 2,
            color: Colors.grey[200],
          ),
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: isEditing ? messages.length + 1 : messages.length,
              padding: const EdgeInsets.all(20),
              itemBuilder: (context, index){
                Message? message;
                try{
                  message = messages[index];
                } catch (e){
                  null;
                }
                return Align(
                  alignment: message == null || !message.isMe ? Alignment.centerLeft : Alignment.centerRight,
                  child: message == null ?
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      child: Text("...", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                    )
                  ):
                  Column(
                    crossAxisAlignment: message.isMe ?  CrossAxisAlignment.end : CrossAxisAlignment.start,
                    children: [
                      Card(
                        elevation: 0,
                        margin: EdgeInsets.only(
                          right: message.isMe ? 0 : 100,
                          left: message.isMe ? 100 : 0,
                        ),
                        color: message.isMe ? Theme.of(context).primaryColor.withOpacity(0.5) : Theme.of(context).primaryColor.withOpacity(0.1),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if(!message.isMe)
                              Text("Atendimento", style: TextStyle(fontWeight: FontWeight.bold),),
                              Text(message.content),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 10,),
                      Text(
                        "${message.date.hour}:${message.date.minute.toString().padLeft(2, '0')}",
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      )
                    ],
                  ),
                );
              }
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    onSubmitted: (value) => sendMessage(),
                    textCapitalization: TextCapitalization.sentences,
                    decoration: InputDecoration(
                      hintText: "Digite sua mensagem...",
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Theme.of(context).primaryColor,
                        )
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10,),
                FloatingActionButton(
                  onPressed: ()=> sendMessage(),
                  child: Icon(Iconsax.send_2),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  sendMessage() async {
    if(controller.text.isNotEmpty){
      setState(() {
        messages.add(Message(
          content: controller.text,
          isMe: true,
          date: DateTime.now()
        ));
        controller.clear();
        scroll();
      });
      await Future.delayed(const Duration(seconds: 1));
      setState(() {
        isEditing = true;
        scroll();
      });
      await Future.delayed(const Duration(seconds: 3));
      setState(() {
        isEditing = false;
        final random = Random();
        messages.add(Message(
          content: respostas[random.nextInt(messages.length)],
          isMe: false,
          date: DateTime.now()
        ));
        scroll();
      });
    }
  }

  scroll(){
    WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }
}

List<String> respostas = 
[
  "Estamos acionando a equipe de emergência, mantenha a calma.",
  "Por favor, verifique se a vítima está consciente e respirando.",
  "Se houver sangramento, pressione o local com um pano limpo.",
  "Equipe a caminho, permaneça no local e siga nossas orientações.",
  "Evite movimentar a vítima, isso pode agravar a situação.",
  "Se possível, mantenha a vítima aquecida até a chegada do socorro.",
  "Estamos localizando sua posição, aguarde um momento.",
  "Caso a vítima não esteja respirando, inicie compressões torácicas.",
  "Não desligue o telefone, precisamos continuar acompanhando.",
  "Se houver risco no ambiente, afaste-se para um local seguro.",
  "Informe se há sinais de dor no peito ou dificuldade para falar.",
  "Estamos priorizando sua ocorrência, a equipe já foi acionada.",
  "Se a vítima estiver engasgada, tente realizar a manobra de Heimlich.",
  "Evite dar líquidos ou alimentos à vítima.",
  "Continue nos informando qualquer mudança no estado da vítima.",
  "Verifique se há objetos obstruindo a boca ou vias respiratórias da vítima.",
  "Se a vítima estiver inconsciente, mantenha a cabeça levemente inclinada para trás.",
  "Evite aglomeração ao redor da vítima, isso pode dificultar o atendimento.",
  "Se houver fratura aparente, não tente movimentar o membro.",
  "Caso haja queimaduras, não aplique pomadas ou cremes, apenas proteja com pano limpo.",
  "Informe se há sinais de convulsão ou movimentos involuntários.",
  "Se a vítima estiver com dificuldade para respirar, afaste roupas apertadas.",
  "Estamos enviando orientações para manter a vítima estável até a chegada da equipe.",
  "Evite oferecer medicamentos sem orientação médica.",
  "Se houver risco de incêndio ou explosão, afaste-se imediatamente e leve a vítima.",
  "Informe se há perda de consciência súbita ou fala arrastada.",
  "Caso a vítima esteja com dor intensa no peito, mantenha-a sentada e calma.",
  "Se houver sangramento nasal, incline a cabeça levemente para frente e pressione o nariz.",
  "Estamos priorizando sua ocorrência, mantenha o telefone disponível.",
  "Se houver sinais de choque (pele fria, suada), mantenha a vítima deitada com pernas elevadas."
];