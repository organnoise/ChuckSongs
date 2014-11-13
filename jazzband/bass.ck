SinOsc vib => SinOsc bass => ADSR env => Chorus chor => JCRev rev => dac;
env => Delay d => d => rev;

SinOsc high => env=>  dac;

//parameters
0.1 => rev.mix;
0.8::second => d.max => d.delay;
0.1 => d.gain;
( 0.1::second, 0.2::second, 0.5,0.3::second ) => env.set;
0.1 => vib.freq;
0.2 => vib.gain;
2 => bass.sync;
0.4 => chor.modFreq;
0.2 => chor.modDepth;
0.4 => chor.mix;



//groove notes
[[48,43,41,46,46,43],
[48,48,43,43,41,41,46,46,43],
[51,51,57,53,53,55,57,60,49],
[48,48,55,51,51,53,55,58,46,51]] @=> int scale[][];

//groove timings
[[1.5,2.0,1.5,1.0,1.5,0.5],
[1.0,0.5,1.0,1.0,1.0,0.5,1.0,1.0,1.0],
[1.0,0.5,1.0,1.0,0.5,1.0,1.0,1.0,1.0],
[1.0,0.5,1.0,1.0,0.5,1.0,1.0,0.5,0.5,1.0]] @=> float timing[][];


fun void groove()
{
     // cycles through each groove from the groove array
    for( 0 => int line; line < scale.cap(); line++)
    {
        //set the volume of the bass for the groove
        Math.random2f(0.2,0.35) => float level;
        level => bass.gain;
        level/10 => high.gain;
       
        // repeat each groove either 4 or 8 times
        repeat (Math.random2(1,2)*2)
        {
        for ( 0 => int i; i < scale[line].cap(); i++)
            {
                
            Std.mtof(scale[line][i] ) => bass.freq;
            Std.mtof(scale[line][i] + 24) => high.freq;    
           // Math.random2f(0.05,0.5) => bass.modDepth;
            1 => env.keyOn;
            0.35::second*timing[line][i] => now;
            1 => env.keyOff;
            0.05::second*timing[line][i] => now;
                
            }
        }
    }
    
}

//loop
while( true )
{
   groove();
   
}   