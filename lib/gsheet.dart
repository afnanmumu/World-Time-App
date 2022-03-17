import 'package:connection_with_google_sheet/sheetcol.dart';
import 'package:gsheets/gsheets.dart';

class SheetsFlutter{
  static String _sheetId="1vYDeAvd2GHj8NfUbIpAniSksTjMbEQZR7qmhusTTelw";
  static const _sheetCredentials=r'''
  {
  "type": "service_account",
  "project_id": "studymate-343709",
  "private_key_id": "4e983f095d6f2bbfc898b96828202cff25336379",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQCV6gAffgi3ev90\nFDsC1Phjzwdif9bH1TpRnIqTi0RekL/dITmYFBUctKT/TbR3hn4ufaC8Fq7iE0UM\n2OogpHHb3kiYct1a17AnRp8wf9ZJkVUN6nqP4HWP0kfWrBDJ7iHVIH0At+hK1ccP\nYgxULKegE470Uj78rfHeniwb2NQs7kwAMPp2xJmKq0lxfBqhJdKo7SmyTOM7SIVy\n/4RY9SgjO1lzDxqBg7EcuAv4vvCKLXQbc/30R8SrN789sx/5puKEuMjgVyxQK8As\nW/rikUCRnsUrHTLr+EowiWNQxINfSejiGbW4fiz95H2E/mrpZ3yP2ckq6ele38lq\npMNAfOLtAgMBAAECggEAA6COG4pKHbOye0AuDqsmeLZpSv8lgYpC3KH5UbPnQJPS\nAJYC4GTD/1Yjk9sbyF85ra2edk6PhqrJWz6NqPfcRWHtxw/TE+qaDtPiRXh3r9So\nsSsrh1BP/TMs8nW7+5bGZ3NfcuVVj9H3p1ig9xG+2zGoniK19sPNUVc/C/bFaMeF\nwFU1d4BJNIo7WHEW6NG8It+X57innLwu69sBv63Q0g/lBm9z0gGASAKCykgh2qKQ\n2bKj+WjUg9lNrxtd21JM9bq/tBrXdHkxyz/1leFroMBq+3VTAvvuRmR2gGqThXFq\nqHuJ1/K3chZpbf1AVDnJ/oo+hFmAB0qHu4lte8dQpQKBgQDIsu4AqqazADqNBpjE\nmoHLZ1RNVT51WiOPYa4TnZ1H8MLHhBVqx+uk4p2m/uwGzxNAt9VfHaPI0+25fusv\nxXYNIUg2EB/V/IX26gFZ7QstyNantBm5G8nbuygMoqo0AvHT53KpK0nC/1Wj4yMD\nSnfFD5EiDiXfyG0kdChSHJEFFwKBgQC/OMOuSYvyWr4/rBiOfjjjlgX6/Mw8d8DC\nLu2fcMWGWFlllxJK6JOkcTCZQ54LWWnSsa4sGIrPcPYlUozNDxYmRKaIxgLG25aR\nKmRlW4DFbHsYKDtr/JahUNP7iUfLS2b49SGyECemaCq5RzrEpP+cUzOn0t/aUU/7\nwZ0NAqRimwKBgBpKXiUWNboTGJhquc5fUwtbIM70kLb8tNXOfOgy6GyJHGrYYZnY\nUIUL7oz2reKCc8oxirDoCBGBuY1oE9TxL/KuXnA+kn0MlFvw8XZfN+yqd3wGeqwl\n+L5g+PEWyecAT79rfTit4/64RfavBWIj+iaFUIS+h7WV4r44vSNsfI7HAoGALRyS\nJXraVimMOm86N9uVRjOtY4HiGN3TjrwNeRDcuI39QRc7zIpD0oaVhYLLNTg52+fp\nBCQiE0A+AZ4Q84t8mTiW5St5mjpRshuDJdpJbcni3FcZdadYTeRIrk27rz0xpMgH\n0/81q29lrOId/ihC2TlTtWLtRo7qRKVvjJMz/sMCgYAxpL4ohvCb9lmifu1t1/MJ\ncugGURr/LVECYElYIpijLzbxvO9rIsDmtx2P+71QYYAkM56x4Sbf8IzPP7Ap//Ow\ndh3d40iiesD6vtT3nGpnUyUKKE1O/m95Bk5p4vyZJxqgp1yc5MZBg20ygydnmBrs\n1Vv2YfQzk7EzufEUIKKRVg==\n-----END PRIVATE KEY-----\n",
  "client_email": "attendance@studymate-343709.iam.gserviceaccount.com",
  "client_id": "117022804493257122519",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/attendance%40studymate-343709.iam.gserviceaccount.com"
  }
''';
  static Worksheet? _userSheet;
  static final _gsheets=GSheets(_sheetCredentials);
  static Future init() async{
    try{
      final spreadsheet= await _gsheets.spreadsheet(_sheetId);
      _userSheet = await _getWorksheet(spreadsheet, title: "attendance");
      final firstRow = SheetColumn.getColumns();
      _userSheet?.values.insertRow(1, firstRow);
    } catch(e){
      print(e);
    }
  }
  static Future<Worksheet?> _getWorksheet(
      Spreadsheet spreadsheet, {
        required String title,}
      ) async {
    try {
      return await spreadsheet.addWorksheet(title);
    } catch (e) {
      return spreadsheet.worksheetByTitle(title);
    }
  }
  static Future insert(Map<String,dynamic>rowList) async {
      _userSheet!.values.map.appendRow(rowList);
  }
}