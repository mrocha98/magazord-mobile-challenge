abstract interface class UseCase<ReturnType, Params> {
  ReturnType call(Params params);
}
