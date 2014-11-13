SndBuf kick => Pan2 drumsMaster => Pan2 master => dac;
SndBuf snare => drumsMaster;
SndBuf hihat => drumsMaster;

master.gain(.5);

fun string load ( SndBuf buffer, string filename )
{
    me.dir() + "/audio/" + filename => buffer.read;
    buffer.samples() => buffer.pos;
    return <<< "Loaded ", filename  >>>;
}

load( kick, "kick_01.wav" );
load( snare, "snare_01.wav" );
load( hihat, "hihat_01.wav" );

[2,0,0,0,2,0,0,0,1,0,2,0,0,0,0,0,0,0,0,0,1,0,1,0  ] @=> int kickP[];

[0,0,1,0,0,0,1,0,0,0,0,0,2,0,0,0,1,0,0,0,1,0,1,0
   ] @=> int snareP[];

[1,0,0,0,1,0,1,0,0,0,1,0,1,0,0,0,1,0,1,0,0,0,1,0  ] @=> int hihatP[];


.120*0.15::second => dur oneShuffle; // every first 16th, longer
.90*0.15::second => dur twoShuffle; // every second 16th, shorter

int counter; // global variable

fun void count()
{ 
    while( true )
    {
        oneShuffle => now; // every first 16th, longer
        counter++;
        twoShuffle  => now; // every second 16th, shorter
        counter++;
    }
}

fun void play(SndBuf buffer, int array[], float gain)
{
    while( true )
    {
        if( array[counter % array.cap()] == 2 ) // passing array and using .cap 
        {                                       // does away with a need for a beat integer
            gain => buffer.gain; // Number 2 in array? Full gain
            0 => buffer.pos;
        }
        else if( array[counter % array.cap()] == 1 )
        {
            gain/4 => buffer.gain; // Number 2 in array? Quarter of full gain
            0 => buffer.pos;
        }
        if( counter % 2 == 0 )
        {
            oneShuffle => now; // every first 16th, longer
        }
        else
        {
            twoShuffle => now; // every second 16th, shorter
        }
    }
}

fun void playHiHats(float gain) // made a different function for hats since I 
{                               // change the sample start on the lighter notes.
    while( true )
    {
        if( hihatP[counter % hihatP.cap()] == 2 )
        {
            hihat.gain(gain);
            0 => hihat.pos;
        }
        else if( hihatP[counter % hihatP.cap()] == 1 )
        {
            hihat.gain(gain/4);
            1200 => hihat.pos;
        }
        if( counter % 2 == 0 )
        {
            oneShuffle => now;
        }
        else
        {
            twoShuffle => now;
        }
    }
}



spork~ count(); // generate counter
spork~ play(kick, kickP, .8); // SndBuf, array, gain
spork~ play(snare, snareP, .8); // SndBuf, array, gain
spork~ playHiHats(.35); // just gain on this one
while( true ) 1::second => now; //parent
