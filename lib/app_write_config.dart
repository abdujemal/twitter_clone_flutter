import 'package:appwrite/appwrite.dart';

Client client = Client();

  initAppWrite(){
    client
        .setEndpoint('https://cloud.appwrite.io/v1')
        .setProject('645cc35e33c4d1275cb2');
        // .setSelfSigned(status: true);

  }


