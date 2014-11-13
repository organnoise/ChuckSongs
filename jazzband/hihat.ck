//drums.ck


//sound chain
Gain master => dac;
SndBuf hihat => NRev hi => master;


.6 => master.gain;
.05 => hi.mix;

//load samples
me.dir(-1) + "/audio/hihat_01.wav" => hihat.read;

hihat.samples() => hihat.pos;

while( true )
{
    
    
    //hihat settings
    if ( Math.random2(0,5) > 1)
    {
        repeat (20) 
        {
        Math.random2f(0.05,0.2) => hihat.gain;
        Math.random2f(1.0,1.1) => hihat.rate;
        .4 :: second => now;
        0 => hihat.pos;
        }
    }   
    else
    {
        3.2 :: second => now;
    }
    
    
    
    
}