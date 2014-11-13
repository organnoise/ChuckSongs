// score.ck

//chuck file paths
me.dir() + "/lead.ck" => string leadPath;
me.dir() + "/drums.ck" => string drumsPath;
me.dir() + "/hihat.ck" => string hihatPath;
me.dir() + "/bass.ck" => string bassPath;

Machine.add(bassPath) => int bass;
3.2::second => now;
Machine.add(drumsPath) => int drums;
3.2::second => now;

Machine.add(hihatPath) => int hihat;
Machine.add(leadPath) => int lead;

38.4 ::second => now;

Machine.remove(bass);
Machine.remove(drums);
Machine.remove(hihat);
Machine.remove(lead);

