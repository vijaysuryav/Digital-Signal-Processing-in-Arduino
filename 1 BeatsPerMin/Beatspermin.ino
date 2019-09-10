//This code takes a PPG signal sampled at 100Hz as input 
// and processes it, i.e, passes it through smoothening and HPF filters
// and extracts information about its systolic peaks
// in order to output the beats/minute

float x[150]={-45.19873153,-33.31577851,-21.63417854,-18.32757855,-11.77102734,-12.18053882,0.833038648,-11.92466206,-14.43186379,-7.953472985,-5.057025214,-28.77100036,-35.32083537,-34.74942509,-35.54930207,-42.68615316,-53.11911688,-65.13324034,-57.8096602,-67.30225654,-56.46566857,-81.77520643,-71.64822563,-62.90277354,-78.21227439,-78.36054942,-81.50892194,-77.69276681,-77.6502708,-74.94006422,-84.19271363,-65.74398021,-29.12332315,40.85207266,116.9744919,200.5959302,277.5240656,268.7345345,217.7686409,174.4743629,118.2966987,94.43840735,68.89756218,57.57689668,40.26055153,22.54327712,6.004949034,-8.141731296,-3.725887313,3.99542677,0.568941859,5.367425864,15.28052435,23.67479465,10.11689028,26.51943881,24.51401681,9.657060705,11.80645113,15.93139709,17.37789361,1.879179247,-0.635738569,-17.78462626,-34.82740399,-22.51536937,-36.52957365,-22.98900703,-23.05577445,-45.83431806,-37.19817334,-41.96160161,-64.23027583,-56.51722374,-58.5731467,-59.31935079,-60.41900056,-62.79102871,-64.31544226,-51.90481883,5.902966348,54.26674423,144.6018693,231.6936302,238.078891,225.0714427,197.7759106,138.1115021,99.65743941,72.05045184,54.87657401,29.0334825,3.154771175,-19.41061527,-22.36514681,-31.98728762,-41.69741095,-41.55669478,-48.18278001,-29.53372899,-46.32141329,-22.42500829,-15.56702659,-29.31826161,-23.38262025,-25.73156557,-40.77493679,-42.42140571,-48.20012974,-67.44670561,-61.66851835,-66.56745879,-81.30617337,-89.57240015,-104.4756323,-98.24950424,-115.7104214,-96.9982648,-110.5218068,-117.2125599,-125.4662067,-144.9252427,-137.5748716,-127.7082331,-112.6578146,-115.5965948,-74.31821408,-13.23726667,73.1028944,160.6177688,193.7645258,207.958753,152.1573119,122.1161134,89.71337781,42.88488719,41.44225578,20.9019145,5.836404788,-0.249313089,-7.004701161,-16.63600881,-31.2032373,-26.69679925,-18.23262388,-25.03692826,-13.32467447,3.527655657,16.72111637,39.30674081};
float y[150];
float fod[150];
int n=150;

void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);  
}

void loop() {
  // put your main code here, to run repeatedly:
  float p[30];
  float posi[30];
  float systolic[20];
  float diff[20];
  float feature1;
  float bpm;
  float sum;

  int L1=5;
  for(int i=0;i<n;i++) // moving average 
  {
    sum=0;
    for(int j=0;j<L1;j++)
    {
      sum=sum+x[i-j];
    }
    y[i]=sum/L1;  
  }
  
    for(int i=0;i<n;i++)
  {
    fod[i]=y[i]-y[i-1];  // first order derivative
  }
  
  int L2=9;
    for(int i=0;i<n;i++)
  {
    sum=0;
    for(int j=0;j<L2;j++)
    {
      sum=sum+fod[i-j];  // moving average
    }
    y[i]=sum/L2;  
  }

  int count=0;
  sum=0;
  for(int i=0;i<n;i++)
  {
    if(y[i]>=0&&y[i+1]<0) // peak detection
    {
      p[count]=x[i];
      posi[count]=i;
      sum=sum+p[count];
      count++;
    }
  }
  count--;     //no. of all peaks
  float threshold=sum/count; // threshold value filtering
  
  int count2=0;
  
  for(int i=0;i<count;i++)
  {
    if(p[i]>threshold)
    {
      systolic[count2]=posi[i];
      count2++;
    }
  }
  count2--;      //number of systolic peaks

  sum=0;
  for(int i=0;i<count2-1;i++)
  {
      diff[i]=systolic[i+1]-systolic[i];  // no of samples between peaks
      sum=sum+diff[i];
  }

  feature1=sum /(count2-1);  // avg number of samples between peaks 
  bpm= (feature1*60)/50;    //Sampling frequency=50 HZ
  Serial.print("Beats per minute = ");
  Serial.println(bpm);
  Serial.print(' ');
  for(int i=0;i<n;i++)
  {
    Serial.print(x[i]);
    Serial.print(' ');
    Serial.print(fod[i]);
    Serial.print(' ');
    Serial.println(y[i]);
  }
  delay(60000);
}
