import 'package:http/http.dart' as http;


Future _postData (url) async{

  http.Response response = await http.post(url);
  return response.body;
}