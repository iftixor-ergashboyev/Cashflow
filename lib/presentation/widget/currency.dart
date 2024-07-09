class CurrencyResponse {
  Meta? meta;
  Data? data;

  CurrencyResponse({this.meta, this.data});

  CurrencyResponse.fromJson(Map<String, dynamic> json) {
    meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.meta != null) {
      data['meta'] = this.meta!.toJson();
    }
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Meta {
  String? lastUpdatedAt;

  Meta({this.lastUpdatedAt});

  Meta.fromJson(Map<String, dynamic> json) {
    lastUpdatedAt = json['last_updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['last_updated_at'] = this.lastUpdatedAt;
    return data;
  }
}

class Data {
  Currency? currency;

  Data({this.currency});

  Data.fromJson(Map<String, dynamic> json) {
    currency = json['Currency'] != null
        ? new Currency.fromJson(json['Currency'])
        : null;
  }

  double? value() {
    return currency?.value;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.currency != null) {
      data['Currency'] = this.currency!.toJson();
    }
    return data;
  }
}

class Currency {
  String? code;
  double? value;

  Currency({this.code, this.value});

  Currency.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = code;
    data['value'] = value;
    return data;
  }
}