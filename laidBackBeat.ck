<<< "Week 3 :Laid Back Beat" >>>;

//sequencer

//sound chain
Gain master => dac;
SndBuf kick => master;
SndBuf hihat => NRev hi => master;
SndBuf snare => NRev snr => master;
SndBuf snare2 => master;
SndBuf pad => NRev pd => master;
SinOsc bass => master;
.6 => master.gain;
.1 => snr.mix;
.6 => pd.mix;
.1 => hi.mix;

//load samples
me.dir() + "/audio/kick_01.wav" => kick.read;
me.dir() + "/audio/hihat_01.wav" => hihat.read;
me.dir() + "/audio/snare_01.wav" => snare.read;
me.dir() + "/audio/snare_01.wav" => snare2.read;
me.dir() + "/audio/stereo_fx_03.wav" => pad.read;
//set all playheads to 0

kick.samples() => kick.pos;
hihat.samples() => hihat.pos;
snare.samples() => snare.pos;
snare2.samples() => snare2.pos;
pad.samples() => pad.pos;

//counter variable

0 => int counter;
0 => int i;
0 => int bassOn;
0.6 => float masGain;
while( true )
{
    
    // Stop song after  120 beats
    if ( counter == 121)
    {
        
        <<< "The End ">>>;
        break;
    }
    
    
    //intro without kick, after counter reaches 30 kick
    //is in the mix
    masGain => master.gain;
    
     0 => kick. gain;
    .6 => kick.rate;
    
    0.3 => snare.gain;
    
    .6 => pad.gain;
    
    // bassOn listens to the kick drum to set the SinOsc's freq
    // to either a 0 or a frequency
    
     0 => bassOn;
    
    
    if ( counter > 30) 
    {
        .8 => kick.gain;
        .8 => snare.gain;
    }
    
    //Begin fade out after 60 beats
    if ( counter > 60)
    {
        (masGain - .01) => masGain; 
        
        
    }
    
    
     
   counter % 8 => int beat;
    
    //KICK standard on 0 and 3
    if ( beat == 0 || beat == 3)
    {
        0 => kick.pos;
        1 => bassOn;
    }
    //KICK random on 7 and 5
    if ( beat == 7 || beat == 5 )
    {
        Math.random2(0,1) => int kickOnOff;
        
        if (kickOnOff == 1)
        {
            0 => kick.pos;
            
            1 => bassOn;
          
           
        }
        
       
    }
    
    
    
    //SNARE
     if ( (beat == 2) || (beat == 6) )
    {
        0 => snare.pos;
        
    }
    
    //SNARE 2 ghosty notes
    
    if ( (counter % 2)  && (beat != 7) )
    {
        0 => snare2.pos;
        .3 => snare2.gain;
        Math.random2f(1.5, 1.7) => snare2.rate;
    }
    
    
    //HIHAT
    
    //If beat 7 randomly decide whether to play or not 
    
     if ( (beat == 7) )
    {
     Math.random2(1,0) => int onOff1;
     
     if( onOff1 == 0)
     {
         hihat.samples() => hihat.pos;
     }
     else if (onOff1 == 1)
     {
        0 => hihat.pos;
       .05 => hihat.gain; 
     }
 }
 
    
    
    // If not beat 7 hold the standard groove
    else if ( (counter % 1 )== 0)
    {
         0 => hihat.pos;
        Math.random2f(.05,.06) => hihat.gain;
        // HIHAT PITCH
        Math.random2f(1.5,1.7) => hihat.rate;  
     
    
    }
    


    
    // PAD, "i" determines the chord to play by changing the
    //sample rate
    
        
        if ( i == 0)
        {
            .75 => pad.rate;
            0 => pad.pos;
            
            if ( bassOn == 1)
            {
            100 => bass.freq;
            .3 => bass.gain;
            }
            else 
            {
             0 => bass.freq;   
            }
            
        }
        
        else if ( i == 1)
        {
            .8 => pad.rate;
            550 => pad.pos;
            
            if ( bassOn == 1)
            {
            95 => bass.freq;
            .3 => bass.gain;
            }
            else 
            {
             0 => bass.freq;   
            }
        }
        
       
        else if ( i == 2)
        {
            1 => pad.rate;
            1880 => pad.pos;
            
            if ( bassOn == 1)
            {
            68 => bass.freq;
            .3 => bass.gain;
            }
            else 
            {
             0 => bass.freq;   
            }
        }
        
        else if ( i == 3)
        {
            .75 => pad.rate;
           4500 => pad.pos;
            
            if ( bassOn == 1)
            {
            100 => bass.freq;
            .3 => bass.gain;
            }
            else 
            {
             0 => bass.freq;   
            }
            
        }
        
        if (beat == 7)
        {
            i++;
        }
        
        
        
        if ( (beat == 7) && (i == 3))
        {
            0 => i;
        }
        
        
        
    
    
    
    
    
    <<< "Counter: ", counter, "Beat: ", beat, "Mix Volume: ", masGain >>>;
   counter++;
   450::ms => now;
} 