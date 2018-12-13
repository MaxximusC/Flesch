import java.io.IOException;
import java.io.FileNotFoundException;
import java.io.File;
import java.util.Scanner;
import static java.lang.System.*;
String s = "Ooga booga, Harambe. Wakanda!";
String s2 = "I wish I may. I wish I might? I wish I had free time tonight!";
String [] words = s.split("[\\,!\\s]+");
String vowels = "aeiouAEIOU";
float totalWords = 0;
float totalSyllables = 0;
float totalVowels = 0;
float totalSentences = 0;
float score = 0;
float ease = 0;
// Below is for button functionality.
boolean buttonPressed = false;
void setup() {
  size(1000, 1000);
  System.out.println(readabilityTest());
  noStroke();
}

void draw() {
  background(155);
  if (buttonPressed == false) {
    fill(255, 0, 0);
    rect(300, 400, 400, 200);
    fill(0);
    textSize(25);
    text("Mystery Button", 415, 500);
  }
  if (mousePressed) {
    if (mouseX < 700 && mouseX > 300 && mouseY < 600 && mouseY > 400) {
      fill(255, 100, 100);
      rect(300, 400, 400, 200);
      buttonPressed = true;
      noLoop();
      fill(155);
      rect(300, 400, 400, 200);
    }
  }
  if(buttonPressed){
    textSize(40);
    fill(0);
    text("My own essay/letter that I wrote to Juliet from\nRomeo and Juliet back in my freshman year.\nHow complex of a writer was I, hm?", 20, 50);
    text(readabilityTest(), 40, 250);
  }
}

float countWords(String str) {
  String string = str;
  String [] words = string.split("[\\,.!?;:\\- ]+");
  return words.length;
}
float countSentence(String str) {
  float count = 0;
  String[] sentence = str.split("[\\.!?]+");
  for (int i = 0; i < sentence.length; i++) {
    count++;
  }
  return count;
}
float countVowels(String str) {
  String string = str;
  float vowels = 0;
  char a = 'a';
  char e = 'e';
  char i = 'i';
  char o = 'o';
  char u = 'u';
  for (int k = 0; k < string.length(); k++) {
    if (s.charAt(k) == 'a' || string.charAt(k) == 'A') {
      vowels++;
    }
    if (s.charAt(k) == 'e' || string.charAt(k) == 'E') {
      vowels++;
    }
    if (s.charAt(k) == 'i' || string.charAt(k) == 'I') {
      vowels++;
    }
    if (s.charAt(k) == 'o' || string.charAt(k) == 'O') {
      vowels++;
    }
    if (s.charAt(k) == 'u' || string.charAt(k) == 'U') {
      vowels++;
    }
  }
  return vowels;
}
float countSyllables(String word) {
  float count = 0;
  boolean newSyll = true;
  char[] wordArray = word.toCharArray();
  for (int i = 0; i < wordArray.length; i++) {
    if (i == wordArray.length-1 && wordArray[i] == 'e' && newSyll && count > 0) {
      count--;
    }
    if (newSyll && vowels.indexOf(wordArray[i]) >= 0) {
      newSyll = false;
      count++;
    } else if (vowels.indexOf(wordArray[i]) < 0) {
      newSyll = true;
    }
  }

  return count;
}

String readabilityTest() {
  String [] theFile = loadStrings("Desktop/Dear Juliet");
  String allFile = join(theFile, " ");
  totalSentences += countSentence(allFile);
  try {
    Scanner file = new Scanner(new File("Desktop/Dear Juliet"));
    while (file.hasNext()) {
      testHelper(file.next());
    }
  } 
  catch (FileNotFoundException e) {
  }
  return "" + (int)totalSentences + " sentences in total, " + (int)totalWords + " words, " + (int)totalVowels + "\nvowels, and " + (int)totalSyllables + " syllables.\nThe grade level is " + score + ".\nThe reading ease level is " + ease + ".";
}

void testHelper (String string) {
  totalWords += countWords(string);
  totalSyllables += countSyllables(string);
  totalVowels += countVowels(string);
  score = (0.39 * (totalWords/totalSentences)) + (11.8 * (totalSyllables/totalWords)) - 15.59; //Online says it's 5.1
  ease = 206.835 - (1.015 * (totalWords/totalSentences)) - (84.6 * (totalSyllables/totalWords)); //Online says it's 80.9
}
