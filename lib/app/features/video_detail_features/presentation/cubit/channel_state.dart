part of 'channel_cubit.dart';

abstract class ChannelState extends Equatable {
  const ChannelState();

  @override
  List<Object?> get props => [];
}

class ChannelInitial extends ChannelState {
  const ChannelInitial();
}

class ChannelLoading extends ChannelState {
  const ChannelLoading();
}

class ChannelLoaded extends ChannelState {
  final ChannelEntity channel;

  const ChannelLoaded(this.channel);

  @override
  List<Object?> get props => [channel];
}

class ChannelError extends ChannelState {
  final String message;

  const ChannelError(this.message);

  @override
  List<Object?> get props => [message];
}
