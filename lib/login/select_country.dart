import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class SelectCountry extends StatefulWidget {
  const SelectCountry({Key? key}) : super(key: key);

  @override
  State<SelectCountry> createState() => _SelectCountryState();
}

class _SelectCountryState extends State<SelectCountry> {
  List<dynamic>? dataRetrieved; // data decoded from the json file
  List<dynamic>? data; // data to display on the screen

  final _searchController = TextEditingController(); // input search value
  var searchValue = "";

  @override
  void initState() {
    _getData();
  }

  Future _getData() async {
    final String response =
        await rootBundle.loadString('assets/country_codes.json');
    dataRetrieved = await json.decode(response) as List<dynamic>;
    setState(() {
      data = dataRetrieved;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: CustomScrollView(
        slivers: [
          const CupertinoSliverNavigationBar(
            largeTitle: Text("Select Country"),
            previousPageTitle: "Edit Number",
          ),
          SliverToBoxAdapter(
            child: CupertinoSearchTextField(
              padding: EdgeInsets.all(15.0),
              onChanged: (value) {
                searchValue = value;
              },
              controller: _searchController,
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate((data != null)
                ? data!
                    // TODO implement working search function for JSON data
                    .where((e) => e['name']
                        .toString()
                        .toLowerCase()
                        .contains(searchValue.toLowerCase()))
                    .map((e) => CupertinoListTile(
                          onTap: () {
                            print(e['name']);
                            Navigator.pop(context, {"name": e['name'], "code" : e['dial_code']});
                          },
                          title: Text(e['name']),
                          trailing: Text(e['dial_code']),
                        ))
                    .toList()
                : [
                    Center(
                      child: Text("Loading"),
                    )
                  ]),
          )
        ],
      ),
    );
  }
}
