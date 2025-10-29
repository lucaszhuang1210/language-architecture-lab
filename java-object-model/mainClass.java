abstract class Shape {
    String name;

    Shape(String newName) { // java is camelCase
        this.name = newName;
    }

    abstract void print();
    abstract void draw();
    abstract double area();
}

class Circle extends Shape {
    int radius;
    static double PI = Math.PI;

    Circle(String newName, int newRadius) {
        super(newName);
        this.radius = newRadius;
    }

    void print() {
        String output = "%s(%d) : %.2f%n";
        System.out.printf(output, this.name, this.radius, this.area());
    }

    void draw() {
        System.out.print(
            "   ***   \n" +
            " *     * \n" +
            " *     * \n" +
            "   ***   \n"
        );
    }

    double area() {
        return PI * radius * radius;
    }
}

class Triangle extends Shape {
    int base;
    int height;

    Triangle(String newName, int newBase, int newHeight) {
        super(newName);
        this.base = newBase;
        this.height = newHeight;
    }

    void print() {
        String output = "%s(%d, %d) : %.2f%n";
        System.out.printf(output, this.name, this.base, this.height, this.area());
    }

    void draw() {
        System.out.print(
            "    *    \n" +
            "  *   *  \n" +
            " *     * \n" +
            "* * * * *\n"
        );
    }

    double area() {
        return base * height / 2.0;
    }
}

class Square extends Shape {
    int length;

    Square(String name, int length) {
        super(name);
        this.length = length;
    }

    void print() {
        String output = "%s(%d) : %.2f%n";
        System.out.printf(output, this.name, this.length, this.area());
    }

    void draw() {
        System.out.print(
            "* * * * *\n" +
            "*       *\n" +
            "*       *\n" +
            "* * * * *\n"
        );
    }

    double area() {
        return length * length;
    }
}

class Rectangle extends Square {
    int width;

    Rectangle(String name, int length, int width) {
        super(name, length);
        this.width = width;
    }

    void print() {
        String output = "%s(%d, %d) : %.2f%n";
        System.out.printf(output, this.name, super.length, this.width, this.area());
    }

    void draw() {
        System.out.print(
            "*********\n" +
            "*       *\n" +
            "*       *\n" +
            "*********\n"
        );
    }

    double area() {
        return super.length * width;
    } 

}

class Picture {
    ListNode head;

    class ListNode {
        Shape shape;
        ListNode next;

        ListNode(Shape shape, ListNode next) {
            this.shape = shape;
            this.next = next;
        }
    }

    Picture() {
        this.head = null;
    }

    void add(Shape shape) {
        this.head = new ListNode(shape, head);
    }

    void printAll() {
        for (ListNode p = this.head; p != null; p = p.next) {
            p.shape.print();
        }
    }

    void drawAll() {
        for (ListNode p = this.head; p != null; p = p.next) {
            p.shape.draw();
        }
    }

    double totalArea() {
        double total = 0.0;

        for (ListNode p = this.head; p != null; p = p.next) {
            total += p.shape.area();
        }

        return total;
    }
}

public class mainClass {
    public static void main(String[] args) {
        if (args.length < 2) { 
            System.out.println("Error: Need 2 arguments!"); 
            return;
        }

        int arg1 = Integer.parseInt(args[0]);
        int arg2 = Integer.parseInt(args[1]);

        Picture myCanvas = new Picture();
        myCanvas.add(new Triangle("FirstTriangle", arg1, arg2));
        myCanvas.add(new Triangle("SecondTriangle", arg1-1, arg2-1));

        myCanvas.add(new Circle("FirstCircle", arg1));
        myCanvas.add(new Circle("SecondCircle", arg1-1));

        myCanvas.add(new Square("FirstSquare", arg1));
        myCanvas.add(new Square("SecondSquare", arg1-1));

        myCanvas.add(new Rectangle("FirstRectangle", arg1, arg2));
        myCanvas.add(new Rectangle("SecondRectangle", arg1-1, arg2-1));


        myCanvas.printAll();
        myCanvas.drawAll();
        System.out.println("Total : " + myCanvas.totalArea());
    }
}