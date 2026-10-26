sealed class AsyncState<T> {
  const AsyncState();
}

final class Loading<T> extends AsyncState<T> {
  const Loading();
}

final class Content<T> extends AsyncState<T> {
  const Content(this.values);
  final List<T> values;
}

final class Failure<T> extends AsyncState<T> {
  const Failure(this.message);
  final String message;
}
