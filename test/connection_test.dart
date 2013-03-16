import 'package:objectory/objectory_console.dart';
import 'package:unittest/unittest.dart';

main(){
  test("Connection test",() {
    objectory = new ObjectoryDirectConnectionImpl("mongodb://localhost", _registerClasses, false);
  });
}

_registerClasses(){
  //  objectory.registerClass("Thing", () => new Thing()); 
}
