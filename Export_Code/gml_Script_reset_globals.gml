i = 100
repeat (100)
{
    i -= 1
    global.metdead[i] = 0
}
i = 400
repeat (400)
{
    i -= 1
    global.event[i] = 0
}
i = 350
repeat (350)
{
    i -= 1
    global.item[i] = 0
}
global.item[1] = 1
i = 0
repeat (96)
{
    j = 0
    repeat (96)
    {
        global.dmap[i, j] = 0
        j += 1
    }
    i += 1
}
global.lavastate = 0
global.etanks = 0
global.mtanks = 0
global.stanks = 0
global.ptanks = 0
global.monstersleft = 0
syncedDifficulty = 1
syncedELM = 0
global.seed = 0
global.rando = 1
scr_default_global_items()