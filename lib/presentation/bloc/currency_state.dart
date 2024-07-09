part of 'currency_bloc.dart';

@immutable
sealed class CurrencyState extends Equatable {
  @override
  List<Object?> get props => [];
}
final class CurrencyInitial extends CurrencyState { }

final class CurrencySuccess extends CurrencyState {
  final double? value;

  CurrencySuccess(this.value);

  @override
  List<Object?> get props => [value];
}