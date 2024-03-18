import 'dart:async';

import 'package:bloc_stream/client.dart';
import 'package:bloc_stream/client_repositorie.dart';
import 'package:bloc_stream/clients_events.dart';
import 'package:bloc_stream/clients_states.dart';

class ClientBloc {
  final _clientRepo = ClientRepositories();

  final StreamController<ClientEvent> _imputClientController =
      StreamController<ClientEvent>();
  final StreamController<ClientState> _outputClientController =
      StreamController<ClientState>();

  Sink<ClientEvent> get imputClient => _imputClientController.sink;
  Stream<ClientState> get stream => _outputClientController.stream;

  ClientBloc() {
    _imputClientController.stream.listen(_mapEventToState);
  }
  _mapEventToState(ClientEvent event) {
    List<Client>? clients = [];
    if (event is LoadClientEvent) {
      clients = _clientRepo.loadClients();
    } else if (event is AddClientEvent) {
      clients = _clientRepo.addClient(event.client!);
    } else if (event is RemoveClientEvent) {
      clients = _clientRepo.removeClient(event.client!);
    }
    _outputClientController.add(ClientSuccessState(clients: clients));
  }
}
