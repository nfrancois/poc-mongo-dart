import 'package:objectory/objectory_console.dart';
import 'package:unittest/unittest.dart';

main(){
  test("Connection test",() {
    objectory = new ObjectoryDirectConnectionImpl("mongodb://localhost", _registerClasses, false);
  });
}

class Thing extends PersistentObject {
  
  Thing();
  
  int get name => getProperty("name");
  set name(int value) => setProperty("name", value);
  
  String toString() => "Thing[Thing=$name]";
  
}

_registerClasses(){
  objectory.registerClass("Thing", () => new Thing()); 
}
