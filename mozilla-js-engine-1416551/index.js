class A {}
class B extends A {
  constructor() {
    try {
      return;
    } catch (e) {
      try {
        return;
      } catch (e) {

      }
    }
  }
}

try {
  new B;
} catch (e) {
  print("Caught: " + e);
}
