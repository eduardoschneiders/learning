
public class People {
	private String name;
	private double gradeG1;
	private double gradeG2;
	
	public People(String name, double gradeG1, double gradeG2){
		this.name = name;
		this.gradeG1 = gradeG1;
		this.gradeG2 = gradeG2;
	}
	
	public static void averageCalc(){
		
	}
	
	public String toString() {
		
		String valor =  "Name: " + this.name + "\n";
		valor =  valor + "Grade1: " + this.gradeG1 + "\n";
		valor =  valor + "Grade2: " + this.gradeG2 + "\n";
		
		return valor;
	}
	
}
