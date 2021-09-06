import 'package:commitment_tracker/common/api/cryptography_helper.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter/material.dart';

class CryptographyScreen extends StatefulWidget {
  const CryptographyScreen({Key key}) : super(key: key);

  @override
  _CryptographyScreenState createState() => _CryptographyScreenState();
}

class _CryptographyScreenState extends State<CryptographyScreen> {
  TextEditingController tec = TextEditingController();
  var encryptedText, plainText;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextField(
              controller: tec,
            ),
          ),
          Column(
            children: [
              Text(
                "PLAIN TEXT",
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.blue[400],
                  fontWeight: FontWeight.w600,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(plainText == null ? "" : plainText),
              ),
            ],
          ),
          Column(
            children: [
              Text(
                "ENCRYPTED TEXT",
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.blue[400],
                  fontWeight: FontWeight.w600,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(encryptedText == null
                    ? ""
                    : encryptedText is encrypt.Encrypted
                        ? encryptedText.base64
                        : encryptedText),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  plainText = tec.text;
                  setState(() {
                    encryptedText = CryptographyHelper.encryptAES(plainText);
                  });
                  tec.clear();
                },
                child: Text("Encrypt"),
              ),
              SizedBox(
                width: 15,
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    encryptedText = CryptographyHelper.decryptAES(encryptedText);
                    print("Type: " + encryptedText.runtimeType.toString());
                  });
                },
                child: Text("Decrypt"),
              )
            ],
          ),
        ],
      ),
    );
  }
}
