import 'package:flutter_v2ray/url/url.dart';

class VlessURL extends V2RayURL {
  VlessURL({required super.url}) {
    if (!url.startsWith('vless://')) {
      throw ArgumentError('url is invalid');
    }
    final temp = Uri.tryParse(url);
    if (temp == null) {
      throw ArgumentError('url is invalid');
    }
    uri = temp;
    var sni = super.populateTransportSettings(
      transport: uri.queryParameters["type"] ?? "tls",
      headerType: uri.queryParameters["headerType"],
      host: uri.queryParameters["host"],
      path: uri.queryParameters["path"],
      seed: uri.queryParameters["seed"],
      quicSecurity: uri.queryParameters["quicSecurity"],
      key: uri.queryParameters["key"],
      mode: uri.queryParameters["mode"],
      serviceName: uri.queryParameters["serviceName"],
    );
    super.populateTlsSettings(
      streamSecurity: uri.queryParameters["security"] ?? "",
      allowInsecure: allowInsecure,
      sni: uri.queryParameters["sni"] ?? sni,
      // sni: uri.queryParameters["sni"] ?? "yahoo.com",
      fingerprint: uri.queryParameters["fp"] ??
          streamSetting['tlsSettings']?['fingerprint'],
      alpns: uri.queryParameters["alpn"],
      publicKey: uri.queryParameters["pbk"] ?? "",
      shortId: uri.queryParameters["sid"] ?? "",
      spiderX: uri.queryParameters["spx"] ?? "",
    );
  }

  @override
  String get address => uri.host;

  @override
  int get port => uri.hasPort ? uri.port : super.port;

  @override
  String get remark => Uri.decodeFull(uri.fragment.replaceAll('+', '%20'));

  late final Uri uri;

  @override
  Map<String, dynamic> get outbound1 => {
        "tag": "proxy",
        "protocol": "vless",
        "settings": {
          "vnext": [
            {
              "address": address,
              "port": port,
              "users": [
                {
                  "id": uri.userInfo,
                  "alterId": null,
                  "security": uri.queryParameters["security"] ?? "tls",
                  "level": level,
                  "encryption": uri.queryParameters["encryption"] ?? "none",
                  "flow": uri.queryParameters["flow"] ?? "xtls-rprx-vision",
                }
              ]
            }
          ],
          "servers": null,
          "response": null,
          "network": null,
          "address": null,
          "port": null,
          "domainStrategy": null,
          "redirect": null,
          "userLevel": null,
          "inboundTag": null,
          "secretKey": null,
          "peers": null
        },
        "streamSettings": streamSetting,
        "proxySettings": null,
        "sendThrough": null,
        "mux": {
          "enabled": false,
          "concurrency": 8,
        },
      };
}
