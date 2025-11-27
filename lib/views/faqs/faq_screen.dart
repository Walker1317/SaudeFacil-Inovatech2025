import 'package:flutter/material.dart';
import 'package:saude_facil_inovatech/models/faq.dart';

class FaqScreen extends StatefulWidget {
  const FaqScreen({super.key});

  @override
  State<FaqScreen> createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        image: DecorationImage(
          image: AssetImage('images/home_background.png'),
          fit: BoxFit.cover,
          opacity: 0.1
        )
      ),
      child: Scaffold(
        appBar: AppBar(),
        backgroundColor: Colors.transparent,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Text("Dúvidas Frequentes", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                  ),
                  Container(
                    height: 2,
                    color: Colors.grey[200],
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 20),
                itemCount: faqList.length,
                itemBuilder: (context, index){
                  final faq = faqList[index];
                  return Center(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: 1000
                      ),
                      child: Card(
                        margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                        color: Colors.white,
                        child: ExpansionTile(
                          childrenPadding: const EdgeInsets.all(20),
                          title: Text(faq.pergunta, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                          children: [
                            Text(faq.resposta, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300), textAlign: TextAlign.start,)
                          ],
                        ),
                      ),
                    ),
                  );
                }
              ),
            ),
          ],
        ),
      ),
    );
  }
}