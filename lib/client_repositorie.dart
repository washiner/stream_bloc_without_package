import 'package:bloc_stream/client.dart';

class ClientRepositories {
  final List<Client> _clients = [];

  List<Client>? loadClients() {
    _clients.addAll([
      Client(nome: "José do Egito"),
      Client(nome: "Abigail Silva"),
      Client(nome: "Josafa Souza"),
      Client(nome: "Natanael Santos")
    ]);
    return _clients;
  }

  List<Client>? addClient(Client client) {
    _clients.add(client);
    return _clients;
  }

  List<Client>? removeClient(Client client) {
    _clients.remove(client);
    return _clients;
  }
}
