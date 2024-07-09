import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
part 'currency_event.dart';
part 'currency_state.dart';

const baseUrl = "https://api.currencyapi.com/v3/latest";
const apiKey = "cur_live_gSfAfeZnuSYmjyUGhgTskPnlqGfHEjYroDrK1VDx";

class CurrencyBloc extends Bloc<CurrencyEvent, CurrencyState> {
  CurrencyBloc() : super(CurrencyInitial()) {
    on<CurrencyEvent>((event, emit) async {
      if(event is OnGenerate) {
        final response =
        await http.get(Uri.parse("$baseUrl?base_currency=${event.from}&currencies=${event.to}&apikey=$apiKey"));
        final map = jsonDecode(response.body).toString();
        final startIndex = map.indexOf('value'); // {name: data, meta, RUB: {value}
        final value = map.substring(startIndex + 6, map.length - 3);
        emit(CurrencySuccess(double.tryParse(value)));
      }
    });
  }
}