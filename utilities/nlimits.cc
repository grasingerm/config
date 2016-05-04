#include <iostream>
#include <limits>

using namespace std;

int main() {
  cout << "Min value for short:    " << numeric_limits<short>::min() << '\n';
  cout << "Max value for short:    " << numeric_limits<short>::max() << '\n';
  cout << "Min value for int:      " << numeric_limits<int>::min() << '\n';
  cout << "Max value for int:      " << numeric_limits<int>::max() << '\n';
  cout << "Min value for long:     " << numeric_limits<long>::min() << '\n';
  cout << "Max value for long:     " << numeric_limits<long>::max() << '\n';
  cout << "Min value for ushort:   " << numeric_limits<unsigned short>::min() 
       << '\n';
  cout << "Max value for ushort:   " << numeric_limits<unsigned short>::max() 
       << '\n';
  cout << "Min value for unsigned: " << numeric_limits<unsigned>::min() << '\n';
  cout << "Max value for unsigned: " << numeric_limits<unsigned>::max() << '\n';
  cout << "Min value for ulong:    " << numeric_limits<unsigned long>::min() 
       << '\n';
  cout << "Max value for ulong:    " << numeric_limits<unsigned long>::max() 
       << '\n';
  cout << "Min value for double:   " << numeric_limits<double>::min() << '\n';
  cout << "Max value for double:   " << numeric_limits<double>::max() << '\n';

  return 0;
}
