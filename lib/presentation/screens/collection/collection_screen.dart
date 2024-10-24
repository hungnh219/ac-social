import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:social_app/service_locator.dart';

import '../../../domain/repository/collection/collection_repository.dart';

class CollectionScreen extends StatelessWidget {
  const CollectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: FutureBuilder(
          future: serviceLocator.get<CollectionRepository>().getCollections(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return Column(
                children: [
                  const Text('Collections'),
                  snapshot.data == null
                      ? const Text('No data')
                      :
                  Expanded(
                    child: ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(snapshot.data![index].name),
                          subtitle: Text(snapshot.data![index].thumbnail),
                        );
                      },
                    ),
                  ),
                ],
              );
            }
          },
        ),
      )
    );
  }
}