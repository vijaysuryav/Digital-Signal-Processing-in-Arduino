float x[100];
float y[100];
float fod[100];
int n=100;

void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);  
  pinMode(A1, INPUT);
}

void loop() {
  // put your main code here, to run repeatedly:
  float p[20];
  float posi[20];
  float systolic[10];
  float diff[10];
  float feature1;
  float bpm;
  double sum;
  for (int i=0;i<n;i++)
  {
    x[i] = analogRead(A1);
    delay(10);
  }
  int L1=5;
    for (int i=0;i<n;i++)
  {
    sum=0;
    for (int k=0;k<L1;k++)
    {
      sum=sum + x[i-k];
    }
    y[i]=sum/L1;
  }
  for(int j=1;j<n;j++)
  {
    fod[j]=y[j]-y[j-1];
  }
  fod[0]=fod[1];
  int L2=9;
    for(int i=0;i<n;i++)
  {
    sum=0;
    for(int j=0;j<L2;j++)
    {
      sum=sum+fod[i-j];
    }
    y[i]=sum/L2;  
  }
  int count=0;
  sum=0;
  for(int i=0;i<n;i++)
  {
    if(y[i]>=0&&y[i+1]<0)
    {
      p[count]=x[i];
      posi[count]=i;
      sum=sum+p[count];
      count++;
    }
  }
  
  float threshold=sum/count;
  count--;     //no. of all peaks
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
      diff[i]=systolic[i+1]-systolic[i];
      sum=sum+diff[i];
  }

  feature1=sum /(count2-1);
  bpm= (feature1*60)/100;    //Sampling frequency=100 HZ
  
  Serial.print("Beats per minute = ");
  Serial.println(bpm);

    for(int i=0;i<n;i++)
  {
//    Serial.print(x[i]-500);
//    Serial.print(' ');
//    Serial.print(fod[i]);
//    Serial.print(' ');
//    Serial.println(y[i]);
  }
  //delay(2000);
}
