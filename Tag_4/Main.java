package uml;

import java.text.*;
import java.util.*;

class Log {
	// Bitte diese Klasse auf dem UML-Diagramm vernachlässigen!
	// Die Vererbung von java.lang.Object, und die Object-Methoden
	// werden auch vernachlässigt, wie z.B. toString(), equals(), usw.
	static void className(Object o) {
		System.out.println('\n' + o.getClass().getName());
	}
}

//=====================================================

class A {
	void x() {
		Log.className(this);
	}
}

class B {
	void y(A a) {
		a.x();
	}
}

//=====================================================

class C {

	void r(D d) {
		d.g();
	}

	void f() {
		Log.className(this);
	}
}

class D {

	void s(C c) {
		c.f();
	}

	void g() {
		Log.className(this);
	}
}

//=====================================================
// 4 Diagramme:
//   1. E - F
//   2. E - G (Nutzfall #1, siehe unten)
//   3. E - G (Nutzfall #2, siehe unten)
//   4. E - H

class E {

	// Ein Java Date lässt sich ändern (engl. mutable).
	// Klass E ist unveränderbar (engl. immutable).

	private final Date d;

	E(String s) throws ParseException {
		d = new SimpleDateFormat("yyyy-MM-dd").parse(s);
	}

	E(long date) {
		d = new Date(date);
	}

	E deepCopy() {
		return new E(this.d.getTime());
	}

	public String toString() {
		return d.toString();
	}
}

class F {

	private List<E> list;

	List<E> getList() {
		return list;
	}

	void setList(List<E> arg) {
		list = arg;
	}

	void printList() {
		Log.className(this);
		System.out.println(list);
	}
}

class G {

	private final List<E> list;

	G(List<E> arg) {
		list = arg;
	}

	void printList() {
		Log.className(this);
		System.out.println(list);
	}
}

class H {

	private final List<E> list;

	H(List<E> arg) {
		list = new ArrayList<E>();
		for (E e : arg)
			list.add(e.deepCopy());
	}

	void printList() {
		Log.className(this);
		System.out.println(list);
	}
}

//=====================================================

class I {

	private J j;

	void setJ(J j) {
		this.j = j;
	}

	void print() {
		Log.className(j);
	}
}

class J {

	private I i;

	J(I i) {
		this.i = i;
		i.setJ(this);
	}
	
	void setI(I i) {
		this.i = i;
	}

	void print() {
		Log.className(i);
	}
}

//=====================================================
// 2 Diagramme:
//   1. K, L, M
//   2. K, L, M, N

class K {

	private L l;

	L getL() {
		return l;
	}

	void setL(L l) {
		this.l = l;
	}
}

class L {

	private final K k;
	private final M m;

	L(K k, M m) {
		this.k = k;
		this.m = m;
		k.setL(this);
		m.setL(this);
	}

	K getK() {
		return k;
	}

	void print() {
		Log.className(m);
	}
}

class M {

	private L l;

	void setL(L l) {
		this.l = l;
	}

	void print() {
		l.print();
	}
}

class N {

	private final L l;

	N(L l) {
		this.l = l;
	}

	void print() {
		K k = l.getK();
		Log.className(this);
		Log.className(k);
	}
}

//=====================================================

interface P {
	void printName();
}

class Q implements P {

	public void printName() {
		Log.className(this);
	}
}

class R implements P {

	public void printName() {
		Log.className(this);
	}
}

class S {
	private final Q q;
	private final R r;

	S(Q q, R r) {
		this.q = q;
		this.r = r;
	}

	void show() {
		Log.className(this);
		q.printName();
		r.printName();
	}
}

class T {
	private final P p1;
	private final P p2;

	T(P p1, P p2) {
		this.p1 = p1;
		this.p2 = p2;
	}

	void show() {
		Log.className(this);
		p1.printName();
		p2.printName();
	}
}

//=====================================================

class U {
	void f() {
		Log.className(this);
	}
}

class X {
	U g() {
		return new U();
	}
}

class Z {
	void h() {
		new X().g().f();
	}
}

class X2 {
	void g() {
		new U().f();
	}
}

class Z2 {
	void h() {
		new X2().g();
	}
}

//=====================================================
// Schreckliches Design
// Es ist nur für das UML-Diagramm gemeint.

class Artikel {

	private Warenkorb korb;

	private final String artikelName;

	Artikel(String name, Warenkorb korb) {
		artikelName = name;
		this.korb = korb;
	}

	void ausDemKorbHerausnehmen() {
		korb.remove(this);
		setKorb(null);
	}

	void setKorb(Warenkorb korb) {
		this.korb = korb;
	}

	public String toString() {
		return artikelName;
	}
}

class Warenkorb {

	private final Map<String, Artikel> korb;

	Warenkorb(String[] artikel) throws ParseException {
		korb = new TreeMap<String, Artikel>();
		for (String name : artikel)
			korb.put(name, new Artikel(name, this));
	}

	Artikel get(String name) {
		return korb.get(name);
	}
	
	void remove(Artikel a) {
		korb.remove(a.toString());
	}

	void print() {
		System.out.println(korb.values());
	}
}

//=====================================================

public class Main {

	static void beispiel(String klassen) {
		System.out.println("\n=====================================================");
		System.out.println("Klassen: " + klassen);
	}

	public static void main(String[] args) throws Throwable {

		{
			beispiel("A, B");

			A a = new A();
			B b = new B();
			b.y(a);
		}

		{
			beispiel("C, D");

			C c = new C();
			D d = new D();

			c.r(d);
			d.s(c);
		}

		{
			System.out.println("\n=====================================================");
			System.out.println("\nDates are mutable in Java:");

			Date datum = new SimpleDateFormat("yyyy-MM-dd hh:mm").parse("2022-06-01 09:42");
			System.out.println(datum);
			Date ref = datum;
			ref.setTime(0);
			System.out.println(datum);
		}

		{
			beispiel("E, F, G, H");

			List<E> arg = List.of(new E("1987-06-05"), new E("1960-02-20"));

			{
				F f = new F();
				f.setList(arg);
				f.printList();

				// E-G, Nutzfall #1:
				G g = new G(arg);
				g.printList();
			}

			// E-G, Nutzfall #2:
			G g2 = new G(List.of(new E("1970-01-01"), new E("1950-04-30")));
			g2.printList();

			H h = new H(arg);
			h.printList();
		}

		{
			beispiel("I, J");

			I i = new I();
			J j = new J(i);
			i.print();
			j.print();
		}

		{
			beispiel("K, L, M, N");

			// 1. Diagramm: K, L, M
			K k = new K();
			M m = new M();
			L l = new L(k, m);
			m.print();

			// 2. Diagramm: K, L, M, N
			N n = new N(l);
			n.print();
		}

		{
			beispiel("P, Q, R, S, T");

			Q q = new Q();
			R r = new R();
			S s = new S(q, r);
			s.show();

			P p1 = new Q();
			P p2 = new R();
			T t = new T(p1, p2);
			t.show();
		}

		{
			beispiel("U, X, Z, X2, Z2");

			Z w = new Z();
			w.h();

			Z2 w2 = new Z2();
			w2.h();
		}

		{
			beispiel("Artikel, Warenkorb");

			String[] artikel = { "Brot", "Milch" };
			Warenkorb wk = new Warenkorb(artikel);
			wk.print();
			Artikel brot = wk.get("Brot");
			brot.ausDemKorbHerausnehmen();
			wk.print();
		}

		System.out.println("Done!");
	}
}
