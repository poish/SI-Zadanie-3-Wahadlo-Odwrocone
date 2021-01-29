import controlP5.*;

ControlP5 cp5;
Textlabel genLabel;
Textlabel avgDevLabel;
Textlabel genTimeLabel;
Textlabel genCountLabel;

void initializeGUI(){
  cp5 = new ControlP5(this);
  
  genLabel = cp5.addTextlabel("label")
                    .setText("Generation :")
                    .setPosition(10,10)
                    .setColorValue(0xffffffff)
                    ;
  avgDevLabel = cp5.addTextlabel("label2")
                    .setText("Avg dev:")
                    .setPosition(10,25)
                    .setColorValue(0xffffffff)
                    ;
  genTimeLabel = cp5.addTextlabel("label3")
                    .setText("Generation Time : " + GenerationTime)
                    .setPosition(10,40)
                    .setColorValue(0xffffffff)
                    ;
}
void updateGUI(){
  genLabel.setText("Generation: " + GenerationCount);
  genTimeLabel.setText("Generation Time : " + floor(GenerationTime * 100.0)/100.00);
  avgDevLabel.setText("Average Deviation: " + pop.averageDev);
}
