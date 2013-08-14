
public class Number {
	double number1;
	double number2;
	
	public Number(double number1, double number2){
		this.number1 = number1;
		this.number2 = number2;
	}
	
	public double whoIsLower(){

		if (this.number1 < this.number2)
			return this.number1;
		else
			return  this.number2;
	}

}
