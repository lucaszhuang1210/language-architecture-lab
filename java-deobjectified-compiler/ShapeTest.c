#include <iostream>
#include <string>
using namespace std;

#include <malloc.h>

// =====================
// Method Pointer Types
// =====================
typedef double (*double_method_type)(void*);
typedef void (*void_method_type)(void*);

// =====================
// Virtual Table
// =====================
typedef union {
    double_method_type double_method;
    void_method_type void_method;
} VirtualTableEntry;

typedef VirtualTableEntry* VTableType;

#define PRINT_INDEX 0
#define DRAW_INDEX 1
#define AREA_INDEX 2


// ====================================================================================
// ====================================================================================


// =====================
// Class Shape
// =====================
struct Shape {
    VTableType VPointer;
    string name;
};

Shape* Shape_Shape(Shape* _this, string name) {
    _this->name = name;
    return _this;
};

// =====================
// Class Circle
// =====================
#define PI 3.14159

struct Circle {
    VTableType VPointer;
    string name;
    int radius;
};

void Circle_print(Circle* _this) {
    cout << _this->name << "(" << _this->radius << ") : " << _this->VPointer[AREA_INDEX].double_method(_this) << endl;
}

void Circle_draw(Circle* _this) {
    cout << 
            "   ***   \n"
            " *     * \n"
            " *     * \n"
            "   ***   \n" << endl;
}

double Circle_area(Circle* _this) {
    return PI * _this->radius * _this->radius;
}

VirtualTableEntry Circle_VTable [] = {
    {.void_method = (void_method_type)Circle_print},
    {.void_method = (void_method_type)Circle_draw},
    {.double_method = (double_method_type)Circle_area}
};

Circle* Circle_Circle(Circle* _this, string name, int radius) {
    Shape_Shape((Shape*)_this, name);
    _this->VPointer = Circle_VTable;
    _this->radius = radius;
    return _this;
}

// =====================
// Class Triangle
// =====================
struct Triangle {
    VTableType VPointer;
    string name;
    int base;
    int height;
};

void Triangle_print(Triangle* _this) {
    cout << _this->name << "(" << _this->base << ", " << _this->height << ") : " << _this->VPointer[AREA_INDEX].double_method(_this) << endl;
}

void Triangle_draw(Triangle* _this) {
    cout << "    *    \n" 
            "  *   *  \n" 
            " *     * \n" 
            "* * * * *\n" << endl;
}

double Triangle_area(Triangle* _this) {
    return _this->base * _this->height / 2.0;
}

VirtualTableEntry Triangle_VTable [] = {
    {.void_method = (void_method_type)Triangle_print},
    {.void_method = (void_method_type)Triangle_draw},
    {.double_method = (double_method_type)Triangle_area}
};

Triangle* Triangle_Triangle(Triangle* _this, string name, int base, int height) {
    Shape_Shape((Shape*)_this, name);
    _this->VPointer = Triangle_VTable;
    _this->base = base;
    _this->height = height;
    return _this;
}

// =====================
// Class Square
// =====================
struct Square {
    VTableType VPointer;
    string name;
    int length;
};

void Square_print(Square* _this) {
    cout << _this->name << "(" << _this->length << ") : " << _this->VPointer[AREA_INDEX].double_method(_this) << endl;
}

void Square_draw(Square* _this) {
    cout << "* * * * *\n"
            "*       *\n"
            "*       *\n"
            "* * * * *\n" << endl;
}

double Square_area(Square* _this) {
    return _this->length * _this->length;
}

VirtualTableEntry Square_VTable [] = {
    {.void_method = (void_method_type)Square_print},
    {.void_method = (void_method_type)Square_draw},
    {.double_method = (double_method_type)Square_area}
}; 

Square* Square_Square(Square* _this, string name, int length) {
    Shape_Shape((Shape*)_this, name);
    _this->VPointer = Square_VTable;
    _this->length = length;
    return _this;
}

// =====================
// Class Rectangle
// =====================
struct Rectangle {
    VTableType VPointer;
    string name;
    int length;
    int width;
};

void Rectangle_print(Rectangle* _this) {
    cout << _this->name << "(" << _this->length << ", " << _this->width << ") : " << _this->VPointer[AREA_INDEX].double_method(_this) << endl;
}

void Rectangle_draw(Rectangle* _this) {
    cout << "*********\n" 
            "*       *\n"
            "*       *\n"
            "*********\n" << endl;
}

double Rectangle_area(Rectangle* _this) {
    return _this->length * _this->width;
}

VirtualTableEntry Rectangle_VTable [] = {
    {.void_method = (void_method_type)Rectangle_print},
    {.void_method = (void_method_type)Rectangle_draw},
    {.double_method = (double_method_type)Rectangle_area}
};

Rectangle* Rectangle_Rectangle(Rectangle* _this, string name, int length, int width) {
    Square_Square((Square*)_this, name, length);
    _this->VPointer = Rectangle_VTable;
    _this->width = width;
    return _this;
}


// ====================================================================================
// ====================================================================================


// =====================
// Picture Functions
// =====================
void Picture_printAll(Shape* shapes[], int size) {
    for (int i = 0; i < size; i++) {
        shapes[i]->VPointer[PRINT_INDEX].void_method(shapes[i]);
    }
}

void Picture_drawAll(Shape* shapes[], int size) {
    for (int i = 0; i < size; i++) {
        shapes[i]->VPointer[DRAW_INDEX].void_method(shapes[i]);
    }
}

double Picture_totalArea(Shape* shapes[], int size) {
    double total = 0.0;
    for (int i = 0; i < size; i++) {
        total += shapes[i]->VPointer[AREA_INDEX].double_method(shapes[i]);
    }
    return total;
}


// ====================================================================================
// ====================================================================================


// =====================
// Class Main
// =====================
int main(int argc, char *argv[]) {
    if (argc < 3) {
        cout << "Please provide 2 integers as arguments." << endl;
        return 1;
    }

    int arg1 = atoi(argv[1]);
    int arg2 = atoi(argv[2]);

    Shape* shapes[] = {
        (Shape*)Triangle_Triangle((Triangle*)malloc(sizeof(Triangle)), "FirstTriangle", arg1, arg2),
        (Shape*)Triangle_Triangle((Triangle*)malloc(sizeof(Triangle)), "SecondTriangle", arg1-1, arg2-1),
        (Shape*)Circle_Circle((Circle*)malloc(sizeof(Circle)), "FirstCircle", arg1),
        (Shape*)Circle_Circle((Circle*)malloc(sizeof(Circle)), "SecondCircle", arg1-1),
        (Shape*)Square_Square((Square*)malloc(sizeof(Square)), "FirstSquare", arg1),
        (Shape*)Square_Square((Square*)malloc(sizeof(Square)), "SecondSquare", arg1-1),
        (Shape*)Rectangle_Rectangle((Rectangle*)malloc(sizeof(Rectangle)), "FirstRectangle", arg1, arg2),
        (Shape*)Rectangle_Rectangle((Rectangle*)malloc(sizeof(Rectangle)), "SecondRectangle", arg1-1, arg2-1)
    };

    Picture_printAll(shapes, 8);
    Picture_drawAll(shapes, 8);
    cout << "Total : " << Picture_totalArea(shapes, 8) << endl;
}