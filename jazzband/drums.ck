//drums.ck


//sound chain
Gain master => dac;
SndBuf kick => master;
SndBuf hihat => NRev hi => master;
SndBuf snare => NRev snr => master;
SndBuf snare2 => master;


.6 => master.gain;
.05 => snr.mix;
.05 => hi.mix;

//load samples
me.dir(-1) + "/audio/kick_01.wav" => kick.read;
me.dir(-1) + "/audio/hihat_01.wav" => hihat.read;
me.dir(-1) + "/audio/snare_01.wav" => snare.read;
me.dir(-1) + "/audio/snare_01.wav" => snare2.read;

kick.samples() => kick.pos;
hihat.samples() => hihat.pos;
snare.samples() => snare.pos;
snare2.samples() => snare2.pos;


while( true )
{
    //snare settings
    Math.random2f(0.2,0.8) => snare.gain;
    Math.random2f(0.8,1.0) => snare.rate;
    (Math.random2(1,2) * 0.2) :: second => now;
    0 => snare.pos;
    
    //kick settings
    Math.random2f(0.4,0.8) => kick.gain;
    Math.random2f(0.6,1.0) => kick.rate;
    (Math.random2(1,3) * 0.2) :: second => now;
    0 => kick.pos;
    
    
}