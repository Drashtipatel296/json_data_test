import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:json_data_test/data_model.dart';
import 'package:provider/provider.dart';
import 'data_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => DataProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    DataProvider providerT = Provider.of<DataProvider>(context, listen: true);
    DataProvider providerF = Provider.of<DataProvider>(context, listen: false);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          elevation: 5,
          shadowColor: Colors.grey,
          title: const Text(
            'JSON Data',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: FutureBuilder<String>(
          future: rootBundle.loadString('assets/data.json'),
          builder: (context, snapshot) {
            if (snapshot.data != null) {
              Map data = jsonDecode(snapshot.data!);
              DataModel dataModel = DataModel.fromJson(data);
              providerF.convert(data);
              return Expanded(
                child: SizedBox(
                  height: 2000,
                  child: ListView(
                    children: [
                      ListTile(
                        title: Column(
                          children: [
                            Text('Total: ${providerT.dataModel!.total}'),
                            Text('Skips: ${providerT.dataModel!.skip}'),
                            Text('Limit: ${providerT.dataModel!.limit}'),
                          ],
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemExtent: 90,
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemCount: providerT.dataModel!.posts!.length,
                          itemBuilder: (context, index) => ListTile(
                            leading: Column(
                              children: [
                                Text('${providerT.dataModel!.posts![index].id}'),
                                Text('${providerT.dataModel!.posts![index].userId}'),
                              ],
                            ),
                            title: Text(
                              overflow: TextOverflow.ellipsis,
                              providerT.dataModel!.posts![index].title.toString(),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  overflow: TextOverflow.ellipsis,
                                  providerT.dataModel!.posts![index].body
                                      .toString(),
                                ),
                                Text(
                                  overflow: TextOverflow.ellipsis,
                                  '# ${providerT.dataModel!.posts![index].tags!.join(', ')}',
                                ),
                              ],
                            ),
                            trailing: Column(
                              children: [
                                Text(
                                  overflow: TextOverflow.ellipsis,
                                  'L: ${providerT.dataModel!.posts![index].reactions!.likes.toString()}',
                                ),
                                Text(
                                  overflow: TextOverflow.ellipsis,
                                  'D: ${providerT.dataModel!.posts![index].reactions!.dislikes.toString()}',
                                ),
                                Text(
                                  overflow: TextOverflow.ellipsis,
                                  'V: ${providerT.dataModel!.posts![index].views.toString()}',
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}
