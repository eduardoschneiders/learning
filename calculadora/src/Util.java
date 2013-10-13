import java.util.ArrayList;
import java.util.List;
import java.util.Random;

public class Util {
	public static List<Integer> generateIntegers(int count, int minValue, int maxValue){
		List<Integer> ints = new ArrayList<Integer>();
		int maximum = maxValue;
		int minimum = minValue;
		for (int j = 0; j < count; j++) {
			Random rn = new Random();
			int n = maximum - minimum + 1;
			int i = rn.nextInt() % n;
			int randomNum = minimum + i;
			if(randomNum < 0)
				randomNum = randomNum * -1;
			
			ints.add(randomNum);
		}
		
		return ints;
	}
	
}
