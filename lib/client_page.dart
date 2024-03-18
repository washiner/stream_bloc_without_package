import 'dart:math';

import 'package:bloc_stream/client.dart';
import 'package:bloc_stream/client_bloc.dart';
import 'package:bloc_stream/clients_events.dart';
import 'package:bloc_stream/clients_states.dart';
import 'package:flutter/material.dart';

class ClientPage extends StatefulWidget {
  const ClientPage({Key? key}) : super(key: key);

  @override
  State<ClientPage> createState() => _ClientPageState();
}

class _ClientPageState extends State<ClientPage> {
  late final ClientBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = ClientBloc();
    bloc.imputClient.add(LoadClientEvent());
  }

  @override
  void dispose() {
    bloc.imputClient.close();
    super.dispose();
  }

  String randomName() {
    final rand = Random();
    return ["Shiro Takeuchi", "Mel Takeuchi", "Papai Takeuchi"]
        .elementAt(rand.nextInt(3));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Clientes"),
        actions: [
          IconButton(
              icon: const Icon(Icons.person_add),
              onPressed: () {
                bloc.imputClient
                    .add(AddClientEvent(client: Client(nome: randomName())));
              })
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 24),
        child: StreamBuilder<ClientState>(
            stream: bloc.stream,
            builder: (context, AsyncSnapshot<ClientState> snapshot) {
              final clientsList = snapshot.data?.clients ?? [];
              return ListView.separated(
                itemCount: clientsList.length,
                itemBuilder: (context, index) => ListTile(
                  leading: CircleAvatar(
                    child: ClipRRect(
                      child: Text(clientsList[index].nome.substring(0, 1)),
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  title: Text(clientsList[index].nome),
                  trailing: IconButton(
                    icon: Icon(Icons.remove),
                    onPressed: () {
                      bloc.imputClient
                          .add(RemoveClientEvent(client: clientsList[index]));
                    },
                  ),
                ),
                separatorBuilder: (_, __) => Divider(),
              );
            }),
      ),
    );
  }
}
