#include "vector.h"


int main() 
{
    Vector<int> intVec{1,3,5,7,9};
    Vector<double> doubleVec{1.5,2.5,3.5,4.5};
    Vector<int> iv{intVec};
    Vector<double> dv{doubleVec};
    Vector<int> emptyVec = Vector<int>(0);
    
    cout << "intVec" << intVec << endl;         // "intVec(1, 3, 5, 7, 9)"
    cout << "iv" << iv << endl;                 // "iv(1, 3, 5, 7, 9)"
    cout << "doubleVec" << doubleVec << endl;   // "doubleVec(1.5, 2.5, 3.5, 4.5)"
    cout << "dv" << dv << endl;                 // "dv(1.5, 2.5, 3.5, 4.5)"
    cout << "emptyVec" << emptyVec << endl;     // "emptyVec()"
    cout << endl;

    cout << "intVec size is 5: " << intVec.size() << endl;              // 5
    cout << "emptyVec size is 0: " << emptyVec.size() << endl;            // 0
    cout << endl;

    cout << "doubleVec[2] is 3.5: " << doubleVec[2] << endl;
    doubleVec[3] = 99.9;
    cout << "doubleVec[3] is 99.9: " << doubleVec[3] << endl; 
    cout << endl;

    cout << "intVec * iv is 165: " << intVec * iv << endl;
    cout << "intVec * intVec is 165: " << intVec * intVec << endl;
    cout << "intVec * emptyVec is 0: " << intVec * emptyVec << endl;
    cout << endl;

    cout << "intVec + intVec is (2, 6, 10, 14, 18): " << intVec + intVec << endl;
    cout << "intVec + emptyVec is (1, 3, 5, 7, 9): " << intVec + emptyVec << endl;
    cout << endl;

    Vector<int> newIntVec = intVec;
    newIntVec[4] = 99;
    cout << "newIntVec is (1, 3, 5, 7, 99): " << newIntVec << endl;
    cout << "intVec is (1, 3, 5, 7, 9): " << intVec << endl;
    cout << endl;

    cout << "intVec == iv is true: " << (intVec == iv) << endl;
    cout << "intVec == newIntVec is false: " << (intVec == newIntVec) << endl;
    cout << "intVec == emptyVec is false: " << (intVec == emptyVec) << endl;
    cout << endl;
    
    cout << "intVec != iv is false: " << (intVec != iv) << endl;
    cout << "intVec != newIntVec is true: " << (intVec != newIntVec) << endl;
    cout << "intVec != emptyVec is true: " << (intVec != emptyVec) << endl;
    cout << endl;

    cout << "20 * dv is (30, 50, 70, 90): " << 20 * dv << endl;
    cout << "20 * emptyVec is (): " << 20 * emptyVec << endl;
    cout << endl;

    cout << "20 + intVec is (21, 23, 25, 27, 29): " << 20 + intVec << endl;
    cout << "20 + emptyVec is (): " << 20 + emptyVec << endl;
    cout << endl;

    return 0;
}
