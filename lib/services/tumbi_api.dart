import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:wshopper/models/products.dart';

class ApiService {
  fetchProducts() async {
    const uri =
        "https://api.timbu.cloud/products?organization_id=0be4f74e21274345b295b0e3529ba741&reverse_sort=false&page=1&size=10&Appid=NTW30Q137POBT0M&Apikey=b0e83969b91f4137919058a346a755ee20240705112107180178";
    final url = Uri.parse(uri);
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final body = response.body;
      final json = jsonDecode(body)["items"] as List;
      final items = json.map((e) {
        return Product.fromMap(e);
      }).toList();
      return items;
    } else {
      throw Exception();
    }
  }
}
