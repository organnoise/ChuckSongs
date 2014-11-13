SinOsc vib => SinOsc lead => ADSR env => JCRev rev => dac;
env => Delay d => d => rev;

0.1 => rev.mix;
0.8::second => d.max => d.delay;
0.5 => d.gain;
( 0.5::second, 0.1::second, 0.6,0.5::second ) => env.set;
0.2 => lead.gain;
0.8 => vib.freq;
8.0 => vib.gain;
2 => lead.sync;


//scale
[41,43,48,50,51,53,60,63] @=> int scale[];

while( true )
{
    (Math.random2(1,5) * 0.4)::second => now;
    
    if ( Math.random2(0,3) > 1)
    {
        Math.random2(0,scale.cap()-1) => int note;
        Math.mtof(24+ scale[note]) => lead.freq;
        Math.random2f(0.1,0.2) => lead.gain;
        1 => env.keyOn;
    }
    else
    {
        1 => env.keyOff;
    }
}



