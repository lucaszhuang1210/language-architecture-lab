#ifndef VECTOR_H
#define VECTOR_H
#include <iostream>
using namespace std;

template <typename T>

class Vector {
 private:
    size_t sz;
    T* buf;

 public:
    Vector(size_t sz)
    : sz(sz), buf(new T[sz]) {}


    Vector(initializer_list<T> L)
    : sz(L.size()), buf(new T[sz]) {
        copy(L.begin(), L.end(), buf);
    }

    
    ~Vector() {
        delete[] buf;
    }


    Vector(const Vector & v) 
    : sz(v.sz), buf(new T[v.sz]) {
        copy(v.buf, v.buf + v.sz, buf);
    }


    size_t size() const {
        return sz;
    }

    bool in_range(const int i) const {
        return i >= 0 && i < sz;
    }
    
    T & operator [] (const int i) {
        if (!in_range(i)) {
            throw out_of_range("Index out of range");
        }
        return *(buf + i);
    }
    
    
    T operator [] (const int i) const {
        if (!in_range(i)) {
            throw out_of_range("Index out of range");
        }
        return *(buf + i);
    }


    T operator * (const Vector & v) const {
        T dot_product = 0;
        for (int i = 0; i < sz; ++i) {
            if (!(*this).in_range(i) || !v.in_range(i)) {
                return dot_product;
            }
            dot_product += (*this)[i] * v[i];   
        }
        return dot_product;
    }


    Vector operator + (const Vector & v) const {
        size_t new_sz = max(sz, v.sz);
        Vector result = Vector(new_sz);
        for (int i = 0; i < new_sz; ++i) {
            if (!(*this).in_range(i)) {
                result[i] = v[i];
            } else if (!v.in_range(i)) {
                result[i] = (*this)[i];
            } else {
                result[i] = (*this)[i] + v[i];   
            }
        }
        return result;
    }


    const Vector & operator = (const Vector & v) {
        if (this != &v) {
            Vector temp(v);
            swap(buf, temp.buf);
            swap(sz, temp.sz);
        }
        return *this;
    }


    bool operator == (const Vector & v) const {
        if (sz != v.sz) {
            return false;
        }
        for (int i = 0; i < sz; ++i) {
            if ((*this)[i] != v[i]) {
                return false;
            }
        }
        return true;
    }


    bool operator != (const Vector & v) const {
        return !(*this == v);
    }


    inline friend Vector operator * (const int scale, const Vector & v) {
        Vector result = Vector(v.sz);
        for (int i = 0; i < v.sz; ++i) {
            result[i] = v[i] * scale;
        }
        return result;
    }
    

    inline friend Vector operator + (const int adder, const Vector & v) {
        Vector result = Vector(v.sz);
        for (int i = 0; i < v.sz; ++i) {
            result[i] = v[i] + adder;
        }
        return result;
    }
    

    inline friend ostream& operator << (ostream & o, const Vector & v) {
        const T* ptr = v.buf;
        const T* end = ptr + v.sz;

        o << '(';
        if (v.sz > 0) {
            for (; ptr < end - 1; ++ptr) {
                o << *ptr << ", ";
            }
            o << *ptr;
        }
        o << ')';

        return o; 
    }

};
#endif
