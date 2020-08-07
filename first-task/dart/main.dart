import 'dart:math';

void main() {
  List<int> A = generateNewList(1000, 2, 500, false);
  List<int> B = generateNewList(100, 2, 500, false);
  List<int> C = generateNewList(10, 0, 9, true);
  print("A is $A");
  print("B is $B");
  print("C is $C");

  var result = makeResult(A, B, C);
  print("result: $result");
}

List<int> generateNewList(int count, int min, int max, bool unique){
  if(unique == true && count > max - min + 1){
    throw new Exception('count can\'t be bigger than difference of max and min values when unique is true');
  }

  List<int> result = new List();
  for (var i = 0; i < count; i++) {
    int item = randomNumber(min, max);
    if (unique == true && result.contains(item)) {
      i--;
    } else {
      result.add(item);
    }
  }
  return result;
}

int randomNumber(int min, int max){
  var rnd = new Random();
  return min + rnd.nextInt(max - min + 1);
}

List<int> makeResult(List<int> A, List<int> B, List<int> C){
  List<int> result = new List();
  for (var item in A) {
    if(B.contains(item) && !C.contains(item) && !result.contains(item)){
      result.add(item);
    }
  }
  return result;
}