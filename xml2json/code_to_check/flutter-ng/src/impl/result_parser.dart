abstract class ResultParser {
  const ResultParser();
  T parse<T>(Object result);
}

class DefaultResultParser implements ResultParser {
  const DefaultResultParser();

  @override
  T parse<T>(Object result) {
    assert(result is T);
    return result as T;
  }
}
