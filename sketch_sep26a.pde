
/* Example 1: Algae from Wikipedia 

String start   = "A";
String rules   = "A -> AB, B -> A";

void l_sys_setup(){
  l_sys_env.put("chosed_font", loadFont("CourierNew-12.vlw"));
}

void l_sys_round(String cur){
  textFont((PFont)l_sys_env.get("chosed_font")); 
  textAlign(CENTER);
  text(cur, canvas_width/2, start_y);
  delay(2000);
  start_y = start_y + 14;
}

void l_sys(char c){
}  */


/* Example 2: Cantor Dust from Wikipedia */

String start   = "A";
String rules   = "A -> ABA, B -> BBB";

void l_sys_setup(){
  noStroke();
}

void l_sys_round(String cur){
 
  float scale_factor = (canvas_width - (start_x * 2.0)) / cur.length();
  float scaled_start_x = start_x / scale_factor;
  if (scale_factor < 0.05) return;

  scale( scale_factor , 1.0 ); 
  beginShape(QUAD_STRIP);
  for(int x=0; x < cur.length(); x++){
    if(cur.charAt(x) == 'A'){
      fill(#000000);
    }else{
      fill(#FF0000);
    }
    vertex(scaled_start_x + x, start_y);
    vertex(scaled_start_x + x, start_y + 4);
    vertex(scaled_start_x + x + 1, start_y);
    vertex(scaled_start_x + x + 1, start_y + 4 );
  }
  endShape();
 
  delay(2000);
  start_y = start_y + 6;
}

void l_sys(char c){
} 



int canvas_width  = 400;
int canvas_height = 300;
boolean debug = false;

String current; 
int start_x, start_y;
HashMap decoded_rules;
HashMap l_sys_env;

void setup(){
 size(canvas_width,canvas_height);
 current = start;
 start_x = 10;
 start_y = 10;
 
 l_sys_env = new HashMap();
 decoded_rules = new HashMap();
 String [] rules_splitted = rules.split(",");
 for(int x=0; x < rules_splitted.length; x ++){
   String [] rule_token = rules_splitted[x].split("->");
   decoded_rules.put(rule_token[0].trim(),rule_token[1].trim());
   if(debug) println("{ " + rule_token[0].trim() + " --> " + rule_token[1].trim() + " }");
 }
 
 l_sys_setup();
}

void draw(){
  String future = "";
  if (debug) println(current);
  l_sys_round(current);
  for(int x=0; x < current.length(); x ++){
      l_sys(current.charAt(x));
      future = future + (String)decoded_rules.get(new String("" + current.charAt(x)));
  }
  current = future;
}




