import 'package:flutter/cupertino.dart';
import 'package:messaging_app/login/login.dart';
import 'package:messaging_app/login/select_country.dart';

class EditNumber extends StatefulWidget {
  const EditNumber({super.key});

  @override
  State<EditNumber> createState() => _EditNumberState();
}

class _EditNumberState extends State<EditNumber> {
  var _enterPhoneNumber = TextEditingController();
  Map<String, dynamic> data = {"name": "Select a country", "code": "+"};
  late Map<String, dynamic> dataResult;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text("Edit Number"),
        previousPageTitle: "Back",
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                image: AssetImage(
                'assets/images/speech_bubble.png'
                ),
                width: 30.0,
                height: 30.0,
              ),
              Text(
                "Verification : one step",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF08C187).withOpacity(0.7),
                  fontSize: 40,
                ),
              ),
            ],
          ),
          Text(
            "Enter your phone number",
            style: TextStyle(
              color: CupertinoColors.systemGrey.withOpacity(0.7),
              fontSize: 30,
            ),
          ),
          CupertinoListTile(
            onTap: () async {
              dataResult = await Navigator.push(context, CupertinoPageRoute(builder: (context) => SelectCountry()));
              setState(() {
                if (dataResult != null) {
                  data = dataResult;
                }
              });
            },
            title: Text(data['name'], style: TextStyle(color: Color(0xFF08C187))),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text(
                  data['code'],
                  style: TextStyle(
                      fontSize: 25, color: CupertinoColors.secondaryLabel),
                ),
                Expanded(
                  child: CupertinoTextField(
                    padding: const EdgeInsets.all(20.0),
                    placeholder: "Enter your phone number",
                    controller: _enterPhoneNumber,
                    keyboardType: TextInputType.number,
                    style: TextStyle(
                      fontSize: 25,
                      color: CupertinoColors.secondaryLabel,
                    ),
                )),
              ],
            ),
          ),
          Text(
            "Verification code will be sent shortly",
            style: TextStyle(
              color: CupertinoColors.systemGrey,
              fontSize: 15,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 40.0),
            child: CupertinoButton.filled(
                child: Text("Request code"), 
                onPressed: () {
                  Navigator.push(
                    context, 
                    CupertinoPageRoute
                    (builder: ((context) => VerifyNumber(
                      number: data['code']! + _enterPhoneNumber.text,
                    )))
                  );
                }
            ),
          )
        ],
      ),
    );
  }
}
