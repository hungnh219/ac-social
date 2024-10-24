import 'package:flutter/material.dart';

class AddCollectionIcon extends StatelessWidget {
  const AddCollectionIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          showModalBottomSheet<void>(
              isScrollControlled: true,
              context: context,
              builder: (BuildContext context) {
                return Container(
                    height: MediaQuery.of(context).size.height * 0.7,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(16),
                            topRight: Radius.circular(16)),
                        color: Colors.white),
                    // height: 400,
                    child: AddPostModal());
              });
        },
        icon: Icon(
          Icons.add_circle_outline,
          color: Colors.red,
        ));
  }
}

class AddPostModal extends StatelessWidget {
  const AddPostModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 24, 12, 0),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          // mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Row(
                children: [
                  Text(
                    'Save to collection',
                    style: TextStyle(fontSize: 12),
                  ),
                  Spacer(),
                  ElevatedButton(
                    onPressed: () {
                      showModalBottomSheet<void>(
                          isScrollControlled: true,
                          context: context,
                          builder: (BuildContext context) {
                            return NewCollectionModal();
                          });
                    },
                    child: Text(
                      'New collection',
                      style: TextStyle(fontSize: 12, color: Colors.white),
                    )
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(
                'Your collections',
                style: TextStyle(fontSize: 12),
              )
            ),

            GridView.builder(
              shrinkWrap: true,
              itemCount: 4,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
              ),
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Center(
                    child: Text(
                      'Item $index',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}

class NewCollectionModal extends StatelessWidget {
  const NewCollectionModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.65,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16), topRight: Radius.circular(16)),
          color: Colors.white),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 32, 24, 0),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.censter,
            // mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Collection name',
                ),
              ),

              SizedBox(height: 16,),

              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  width: double.infinity,
                  height: 52,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.teal
                  ),
                  child: Center(child: Text('Create collection')),),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
