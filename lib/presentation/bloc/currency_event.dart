part of 'currency_bloc.dart';

@immutable
sealed class CurrencyEvent extends Equatable {
  const CurrencyEvent();
  @override
  List<Object?> get props => [];
}

final class OnGenerate extends CurrencyEvent {
  final String from;
  final String to;
  const OnGenerate(this.from, this.to);

  @override
  List<Object?> get props => [from, to];
}