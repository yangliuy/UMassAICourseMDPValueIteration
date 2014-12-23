package edu.umass.lyang;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

/**Code for problem 1(Gridworld MDP) of Homework Six in AI course
 * Solve MDP with value iteration
 * @author Liu Yang & Yiming Peng
 * @mail lyang@cs.umass.edu 
 */

public class MDPValueIteration {

	static int numOfStates;
	
	static double [] Rs;
	
	static double [] Us;
	
	static double gamma = 1;
	
	static double minDelta = 0.00000001;
	
	static Map<Integer, Double[][]> actionTransMatrixMap = new HashMap<Integer, Double[][]>();
	//Key: 0-3 to denote four actions
	//value: a S*S matrix which the action specific transition matrix
	
	public static void main(String[] args) {
		String inputGWFile = "data/gw1.txt";
		initMDP(inputGWFile);
		double delta = 0.1;
		
		int iter = 0;
		while(delta > minDelta){
			delta = 0;
			for(int i = 0; i < numOfStates; i++){
				double oldU = Us[i];
				Us[i] = Rs[i] + gamma * computeMaxActionEU(i);
				if(Math.abs(Us[i] - oldU) > delta){
					delta = Math.abs(Us[i] - oldU);
				}
			}
			//break;
			System.out.println("Iter and delta: " + iter + " " + delta);
			iter++;
			//for debug
			//if(iter == 1000) break;
			for(int i = 0; i < numOfStates; i++){
				System.out.print(Us[i] + " ");
			}
			
			System.out.println();
		}
		
		System.out.println("When VI converge, the utility values are: ");
		for(int i = 0; i < numOfStates; i++){
			System.out.print(Us[i] + "\t");
		}
		
		//Compute best actions for all states
		int [] bestActions = new int [numOfStates];
		//0 left / 1 up / 2 right / 3 down
		for(int i = 0; i < numOfStates; i++){
			computeBestActions(bestActions, i);
		}
		
		System.out.println("\nBest actions for all states: ");
		for(int i = 0; i < numOfStates; i++){
			System.out.print(bestActions[i] + "\t");
		}
	}

	private static void computeBestActions(int[] bestActions, int startState) {
		// TODO Auto-generated method stub
			double maxEU = - Double.MAX_VALUE;
			for(int i = 0; i < 4; i++){
				Double [][] transMatrix = actionTransMatrixMap.get(i);
				double newEU = 0;
				for(int j = 0; j < numOfStates; j++){
					if(transMatrix[startState][j] == 0) continue;
					else {
						newEU += transMatrix[startState][j] * Us[j];
					}
				}
				if(newEU > maxEU) {
					maxEU = newEU;
					bestActions[startState] = i;
				}
			}
	}

	private static double computeMaxActionEU(int startState) {
		// TODO Auto-generated method stub
//		if(startState == 4 || startState == 6){
//			System.out.println("haha: startState = " + startState );
//		}
		
		double maxEU = - Double.MAX_VALUE;
		for(int i = 0; i < 4; i++){
			Double [][] transMatrix = actionTransMatrixMap.get(i);
			double newEU = 0;
			for(int j = 0; j < numOfStates; j++){
				if(transMatrix[startState][j] == 0) continue;
				else {
					newEU += transMatrix[startState][j] * Us[j];
				}
			}
			if(newEU > maxEU) {
				maxEU = newEU;
			}
		}
		//if(maxEU == 0){
			//System.out.println("haha! find maxEU = 0");
			//System.out.println("maxEU: " + maxEU);
		//}
		
		return maxEU;
	}

	private static void initMDP(String inputGWFile) {
		// TODO Auto-generated method stub
		ArrayList<String> lines = new ArrayList<String>();
		FileUtil.readLines(inputGWFile, lines);
		//read S
		numOfStates = Integer.parseInt(lines.get(0));
		Rs = new double[numOfStates];
		Us = new double[numOfStates];
		//read R
		for(int i = 1; i < numOfStates + 1; i++){
			Rs[i-1] = Double.parseDouble(lines.get(i));
		}
		
		//read transition matrix
		for(int actionNum = 0; actionNum < 4; actionNum++){
			Double[][] transMatrix = new Double[numOfStates][numOfStates];
			for(int i = 0; i < numOfStates; i++){
				int lineIndex = 1 + numOfStates + actionNum * numOfStates + i;
				String tokens [] = lines.get(lineIndex).split(",");
				for(int j = 0; j < tokens.length; j++){
					transMatrix[i][j] = Double.parseDouble(tokens[j]);
				}
			}
			actionTransMatrixMap.put(new Integer(actionNum), transMatrix);
		}
		
		//test
//		for(int i = 0 ; i < numOfStates; i++){
//			for(int j = 0; j < numOfStates; j++){
//				System.out.print(actionTransMatrixMap.get(3)[i][j] + " ");
//			}
//			System.out.println();
//		}
	}
	
}
