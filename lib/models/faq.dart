
class FAQ {
  final String pergunta;
  final String resposta;

  FAQ({required this.pergunta, required this.resposta});
}

final List<FAQ> faqList = [
  FAQ(
    pergunta: "O que é o Saúde Fácil?",
    resposta: "É uma plataforma digital que oferece orientação rápida em casos de urgência e emergência, além de integração com o serviço 190.",
  ),
  FAQ(
    pergunta: "O Saúde Fácil substitui o SAMU?",
    resposta: "Não. Ele é um recurso complementar para agilizar a comunicação e fornecer primeiros socorros até a chegada da equipe profissional.",
  ),
  FAQ(
    pergunta: "Como funciona o chatbot?",
    resposta: "O chatbot faz perguntas para entender a situação, coleta dados essenciais e fornece protocolos de primeiros socorros.",
  ),
  FAQ(
    pergunta: "Preciso pagar para usar o Saúde Fácil?",
    resposta: "Não. O serviço é gratuito e acessível para qualquer pessoa com conexão à internet.",
  ),
  FAQ(
    pergunta: "O Saúde Fácil funciona sem internet?",
    resposta: "Não. É necessário estar conectado para que o sistema envie informações à central de emergência.",
  ),
  FAQ(
    pergunta: "Como o sistema obtém minha localização?",
    resposta: "Ele solicita permissão para acessar o GPS do seu dispositivo. Caso negado, você pode informar o endereço manualmente.",
  ),
  FAQ(
    pergunta: "Meus dados são seguros?",
    resposta: "Sim. Todas as informações são criptografadas e usadas apenas para atendimento emergencial.",
  ),
  FAQ(
    pergunta: "Posso usar o Saúde Fácil para consultas médicas?",
    resposta: "Não. O objetivo é orientar em situações críticas e acionar socorro, não substituir consultas médicas.",
  ),
  FAQ(
    pergunta: "O que fazer se a vítima não estiver respirando?",
    resposta: "O chatbot orientará sobre como iniciar compressões torácicas até a chegada da equipe.",
  ),
  FAQ(
    pergunta: "Posso usar o Saúde Fácil em qualquer cidade?",
    resposta: "Sim, desde que o serviço 190 esteja disponível na sua região.",
  ),
];
