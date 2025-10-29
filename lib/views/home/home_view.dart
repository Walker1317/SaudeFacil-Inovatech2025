import 'package:flutter/material.dart';
import 'package:saude_facil_inovatech/widgets/components/appbar.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: globalAppBar(),
      body: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  opacity: 0.3,
                  fit: BoxFit.cover,
                  image: AssetImage("images/home_background.png")
                ),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.support_agent_outlined, size: 120,),
                    Container(
                      margin: const EdgeInsets.all(20),
                      child: ElevatedButton(
                        onPressed: (){},
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.smart_toy, color: Colors.blue, size: 40,),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20),
                                child: Text(
                                  "Iniciar Atendimento Virtual",
                                  style: TextStyle(fontSize: 32),
                                ),
                              ),
                              Icon(Icons.smart_toy, color: Colors.blue, size: 40,),
                            ],
                          ),
                        )
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            color: Color(0xFF32DAD7),
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Unidades de Saúde:", style: TextStyle(fontSize: 32),),
                        Text(
                          "Av. Mário Ypiranga - Adrianópolis 📍",
                          style: TextStyle(
                            fontSize: 24,
                            color: Color(0xFF00078C)
                          ),
                        ),
                      ],
                    ),
                  )
                ),
                verticalDivider(),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Text("Sobre Nós", style: TextStyle(fontSize: 26),),
                        Divider(),
                        Text("Termos de uso", style: TextStyle(fontSize: 26),),
                        Divider(),
                        Text("Política de Privacidade", style: TextStyle(fontSize: 26),),
                      ],
                    ),
                  )
                ),
                verticalDivider(),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Contatos: 📞", style: TextStyle(fontSize: 26),),
                      ],
                    ),
                  )
                ),
                verticalDivider(),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("E-mail: 📧", style: TextStyle(fontSize: 26),),
                      ],
                    ),
                  )
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  Widget verticalDivider(){
    return Container(
      width: 1,
      height: 160,
      color: Colors.black,
    );
  }
}