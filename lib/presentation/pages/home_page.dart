import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../bloc/currency_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Currency _currency1 = CurrencyService().getAll()[0];
  Currency _currency2 = CurrencyService().getAll()[0];
  final _edit = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(30),
                  bottomLeft: Radius.circular(30),
                )),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: SafeArea(
                child: Column(
                  children: [
                    ListTile(
                      leading: Image.asset(
                        'assets/images/img.png',
                        color: Colors.white,
                        height: 60,
                        width: 60,
                      ),
                      title: Text(
                        "1 350 \$",
                        style: TextStyle(color: Colors.white),
                      ),
                      subtitle: const Text(
                        "Fresh rates",
                        style:
                        TextStyle(color: Colors.greenAccent, fontSize: 12),
                      ),
                    ),
                    const Gap(20),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "from",
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                        Text(
                          "to",
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                        Text(
                          "",
                          style: TextStyle(
                              color: Colors.greenAccent, fontSize: 12),
                        ),
                      ],
                    ),
                    const Gap(10),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 45,
                            child: ElevatedButton(
                                onPressed: () => _showCurrency(1),
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.circular(10))),
                                child: Text(
                                  CurrencyUtils.currencyToEmoji(_currency1),
                                  style: TextStyle(
                                    fontSize: 25,
                                  ),
                                )),
                          ),
                        ),
                        IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.currency_exchange,
                              color: Colors.white,
                            )),
                        Expanded(
                          child: SizedBox(
                            height: 45,
                            child: ElevatedButton(
                                onPressed: () {
                                  _showCurrency(2);
                                  setState(() {});
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.circular(10))),
                                child: Text(
                                  CurrencyUtils.currencyToEmoji(_currency2),
                                  style: TextStyle(
                                    fontSize: 25,
                                  ),
                                )),
                          ),
                        ),
                      ],
                    ),
                    const Gap(20),
                    Container(
                      height: 45,
                      // padding: const EdgeInsets.symmetric(
                      //     horizontal: 6, vertical: 0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white12,
                      ),
                      child: TextField(
                        controller: _edit,
                        style: const TextStyle(color: Colors.white, fontSize: 22),
                        textAlign: TextAlign.center,
                        cursorColor: Colors.white,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        decoration: const InputDecoration(
                            contentPadding: EdgeInsets.all(8),
                            border: InputBorder.none,
                            hintText: "0",
                            hintStyle: TextStyle(color: Colors.white12)),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const Expanded(child: Text("")),
                    Expanded(
                        child: BlocBuilder<CurrencyBloc, CurrencyState>(
                          builder: (context, state) {
                            if(state is CurrencySuccess) {
                              print('state');
                              return TweenAnimationBuilder<double>(
                                  tween: Tween(begin: 0.0, end: state.value ?? 0),
                                  duration: const Duration(milliseconds: 1500),
                                  builder: (context, value, child) {
                                    final finalResult = value * double.parse(_edit.text);
                                    return Text(
                                      finalResult.toStringAsFixed(1),
                                      style: const TextStyle(
                                          fontSize: 50, fontWeight: FontWeight.bold),
                                    );
                                  });
                            } else {
                              return const Text(
                                "0.0",
                                style: TextStyle(
                                    fontSize: 50, fontWeight: FontWeight.bold),
                              );
                            }
                          },
                        )),
                    Expanded(
                      child: Center(
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 55,
                          //  height: 55,
                          child: ElevatedButton(
                            onPressed: () {
                              BlocProvider.of<CurrencyBloc>(context).add(OnGenerate(_currency1.code, _currency2.code));
                              setState(() {

                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                              Theme.of(context).colorScheme.primary,
                            ),
                            child: const Text(
                              "Generate",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ))
        ],
      ),
    );
  }

  _showCurrency(int id) {
    showCurrencyPicker(
      context: context,
      showFlag: true,
      showSearchField: true,
      showCurrencyName: true,
      showCurrencyCode: true,
      onSelect: (Currency currency) {
        if (id == 1) {
          _currency1 = currency;
        } else {
          _currency2 = currency;
        }
        setState(() {});
      },
    );
  }
}