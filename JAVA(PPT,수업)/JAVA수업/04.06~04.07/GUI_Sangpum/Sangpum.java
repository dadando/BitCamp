import java.util.Scanner;

public class Sangpum {
	String code, irum;
	int su, dan, price;
	String grade;
	static int total_price = 0;
	
	public Sangpum() {
	}
	
	void input()
	{
		Scanner scan = new Scanner(System.in);
		System.out.print("상품코드 입력 => ");
		code = scan.next();
		System.out.print("상품명 입력 => ");
		irum = scan.next();
		System.out.print("수량 입력 => ");
		su = scan.nextInt();
		System.out.print("단가 입력 => ");
		dan = scan.nextInt();
	}
	
	void update()
	{
		Scanner scan = new Scanner(System.in);
		System.out.print("\n수량 입력 => ");
		su = scan.nextInt();
		System.out.print("단가 입력 => ");
		dan = scan.nextInt();
		process();
	}
	
	void process()
	{
		price = su * dan;
		
		if (su >= 100)
			grade = "우수";
		else if (su >= 70)
			grade = "보통";
		else
			grade = "분발";
	}
	
	void output()
	{
		System.out.printf("%6s %6s      %4d  %7d %8d   %2s\n",
				code, irum, su, dan, price, grade);
	}
	
	static int print_total_price()
	{
		return total_price;
	}
}
