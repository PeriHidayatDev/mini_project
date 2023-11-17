import 'dart:convert';

import 'package:rempah_apps/models/open_ai_model.dart';
import 'package:rempah_apps/models/usage_model.dart';
import 'package:rempah_apps/constants/open_ai.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class RecommendationService {
  static Future<GPTData> getRecommendation({
    required String barang,
    required String budget,
  }) async {
    late GPTData gptData = GPTData(
      id: "",
      object: "",
      created: 0,
      model: "",
      choices: [],
      usage: UsageData(
        promptToken: 0,
        completionToken: 0,
        totalTokens: 0,
      ),
    );

    try {
      var url = Uri.parse("https://api.openai.com/v1/completions");

      Map<String, String> headers = {
        "Content-Type": "application/json",
        "Charset": "utf-8",
        "Authorization": "Bearer $apiKey",
      };

      final formatCurrency = NumberFormat.currency(
        locale: 'id_ID',
        symbol: 'Rp. ',
        decimalDigits: 0,
      );

      String barang = formatCurrency.format(int.parse(budget));

      String promptData =
          "Kamu adalah seorang yang ahli di bidang rempah rempah, berikan saya 7 rekomendasi  dengan rempah rempah tertinggi selama 7 hari kedepan cantumkan hari,bulan,tanggal dan tahun dari $barang dengan harga perkilo ";

      final data = jsonEncode({
        "model": "text-davinci-003",
        "prompt": promptData,
        "max_tokens": 200,
        "temperature": 0.7,
        "top_p": 1,
        "frequency_penalty": 0,
        "presence_penalty": 0,
      });

      var response = await http.post(
        url,
        headers: headers,
        body: data,
      );

      if (response.statusCode == 200) {
        gptData = gptDataFromJson(response.body);
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      print(e);
    }

    return gptData;
  }
}
