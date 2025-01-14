var type_event, ip, findIP, findKickIP, ban, size, type, alignment, bufferSize, findsocket, i, arrList, socket, socketID, ID, arr, seed, _buffer, bufferSizePacket, clientID, sockets, preferredID, findID, clientX, clientY, clientSprite, clientImage, clientA1, clientA1X, clientA1Y, clientA2, clientA2X, clientA2Y, clientA2A, clientMirror, clientArmmsl, clientRoom, clientName, clientBlend, clientFXTimer, clientRoomPrev, clientState, clientMapX, clientMapY, playerHealth, missiles, smissiles, pbombs, ping, packetID, name, _queenHealth, phase, state, monstersLeft, monstersArea, item, itemArr, f, metdead, metdeadArr, event, eventArr, tileCount, tileX, tileY, tileData, itemstaken, maxmissiles, maxsmissiles, maxpbombs, maxhealth, etanks, mtanks, stanks, ptanks, gametime, findTime, findReset, playerhealth, syncDiff, syncELM, receivedItem, receivedEvent, receivedMetdead, j, receiveddmap, dir, sprX, sprY, charge, sax, currentWeapon, missileX, missileY, velX, velY, icemissiles;
type_event = ds_map_find_value(async_load, "type")
ip = ds_map_find_value(async_load, "ip")
findIP = ds_list_find_index(banList, ip)
findKickIP = ds_list_find_index(kickList, ip)
banSocket = ds_map_find_value(async_load, "id")
if (findIP >= 0 || findKickIP >= 0)
{
    ban = 0
    if (findIP >= 0)
        ban = 1
    buffer_delete(buffer)
    size = 1024
    type = buffer_grow
    alignment = 1
    buffer = buffer_create(size, type, alignment)
    buffer_seek(buffer, buffer_seek_start, 0)
    buffer_write(buffer, buffer_u8, 250)
    buffer_write(buffer, buffer_u8, ban)
    bufferSize = buffer_tell(buffer)
    buffer_seek(buffer, buffer_seek_start, 0)
    buffer_write(buffer, buffer_s32, bufferSize)
    buffer_write(buffer, buffer_u8, 250)
    buffer_write(buffer, buffer_u8, ban)
    network_send_packet(banSocket, buffer, buffer_tell(buffer))
    findsocket = ds_list_find_index(socketList, banSocket)
    if (findsocket >= 0)
        ds_list_delete(socketList, findsocket)
    findsocket = ds_list_find_index(playerList, banSocket)
    if (findsocket >= 0)
    {
        for (i = 0; i < ds_list_size(idList); i++)
        {
            arrList = ds_list_find_value(idList, i)
            if (arrList[0, 1] == banSocket)
                ds_list_delete(idList, i)
        }
        ds_list_delete(playerList, findsocket)
        if (ds_list_size(playerList) == 0)
        {
            with (oReset)
                alarm[10] = 1800
        }
    }
    if (findKickIP >= 0)
        ds_list_delete(kickList, findKickIP)
    exit
}
switch type_event
{
    case 1:
        socket = ds_map_find_value(async_load, "socket")
        socketID = ds_map_find_value(async_load, "id")
        findsocket = ds_list_find_index(socketList, socket)
        ds_list_add(socketList, socket)
        if (ds_list_size(idList) > 0)
        {
            ID = irandom_range(1, 16)
            for (i = 0; i < ds_list_size(idList); i++)
            {
                arrList = ds_list_find_value(idList, i)
                if (ID == arrList[0, 0])
                {
                    ID = irandom_range(1, 16)
                    i = -1
                }
            }
        }
        else
            ID = irandom_range(1, 16)
        buffer_delete(buffer)
        size = 1024
        type = buffer_grow
        alignment = 1
        buffer = buffer_create(size, type, alignment)
        buffer_seek(buffer, buffer_seek_start, 0)
        buffer_write(buffer, buffer_u8, 0)
        buffer_write(buffer, buffer_u8, ID)
        bufferSize = buffer_tell(buffer)
        buffer_seek(buffer, buffer_seek_start, 0)
        buffer_write(buffer, buffer_s32, bufferSize)
        buffer_write(buffer, buffer_u8, 0)
        buffer_write(buffer, buffer_u8, ID)
        network_send_packet(socket, buffer, buffer_tell(buffer))
        arr[0, 0] = ID
        arr[0, 1] = socket
        arr[0, 3] = ip
        ds_list_add(idList, arr)
        if (global.seed != 0)
        {
            buffer_delete(buffer)
            size = 1024
            type = buffer_grow
            alignment = 1
            buffer = buffer_create(size, type, alignment)
            buffer_seek(buffer, buffer_seek_start, 0)
            buffer_write(buffer, buffer_u8, 4)
            buffer_write(buffer, buffer_f64, global.seed)
            buffer_write(buffer, buffer_u8, 100)
            buffer_write(buffer, buffer_s16, oControl.mod_bombs)
            buffer_write(buffer, buffer_s16, oControl.mod_spider)
            buffer_write(buffer, buffer_s16, oControl.mod_jumpball)
            buffer_write(buffer, buffer_s16, oControl.mod_hijump)
            buffer_write(buffer, buffer_s16, oControl.mod_varia)
            buffer_write(buffer, buffer_s16, oControl.mod_spacejump)
            buffer_write(buffer, buffer_s16, oControl.mod_speedbooster)
            buffer_write(buffer, buffer_s16, oControl.mod_screwattack)
            buffer_write(buffer, buffer_s16, oControl.mod_gravity)
            buffer_write(buffer, buffer_s16, oControl.mod_charge)
            buffer_write(buffer, buffer_s16, oControl.mod_ice)
            buffer_write(buffer, buffer_s16, oControl.mod_wave)
            buffer_write(buffer, buffer_s16, oControl.mod_spazer)
            buffer_write(buffer, buffer_s16, oControl.mod_plasma)
            buffer_write(buffer, buffer_s16, oControl.mod_52)
            buffer_write(buffer, buffer_s16, oControl.mod_53)
            buffer_write(buffer, buffer_s16, oControl.mod_54)
            buffer_write(buffer, buffer_s16, oControl.mod_55)
            buffer_write(buffer, buffer_s16, oControl.mod_56)
            buffer_write(buffer, buffer_s16, oControl.mod_57)
            buffer_write(buffer, buffer_s16, oControl.mod_60)
            buffer_write(buffer, buffer_s16, oControl.mod_100)
            buffer_write(buffer, buffer_s16, oControl.mod_101)
            buffer_write(buffer, buffer_s16, oControl.mod_102)
            buffer_write(buffer, buffer_s16, oControl.mod_104)
            buffer_write(buffer, buffer_s16, oControl.mod_105)
            buffer_write(buffer, buffer_s16, oControl.mod_106)
            buffer_write(buffer, buffer_s16, oControl.mod_107)
            buffer_write(buffer, buffer_s16, oControl.mod_109)
            buffer_write(buffer, buffer_s16, oControl.mod_111)
            buffer_write(buffer, buffer_s16, oControl.mod_150)
            buffer_write(buffer, buffer_s16, oControl.mod_151)
            buffer_write(buffer, buffer_s16, oControl.mod_152)
            buffer_write(buffer, buffer_s16, oControl.mod_153)
            buffer_write(buffer, buffer_s16, oControl.mod_154)
            buffer_write(buffer, buffer_s16, oControl.mod_155)
            buffer_write(buffer, buffer_s16, oControl.mod_156)
            buffer_write(buffer, buffer_s16, oControl.mod_159)
            buffer_write(buffer, buffer_s16, oControl.mod_161)
            buffer_write(buffer, buffer_s16, oControl.mod_163)
            buffer_write(buffer, buffer_s16, oControl.mod_202)
            buffer_write(buffer, buffer_s16, oControl.mod_203)
            buffer_write(buffer, buffer_s16, oControl.mod_204)
            buffer_write(buffer, buffer_s16, oControl.mod_205)
            buffer_write(buffer, buffer_s16, oControl.mod_208)
            buffer_write(buffer, buffer_s16, oControl.mod_210)
            buffer_write(buffer, buffer_s16, oControl.mod_211)
            buffer_write(buffer, buffer_s16, oControl.mod_214)
            buffer_write(buffer, buffer_s16, oControl.mod_250)
            buffer_write(buffer, buffer_s16, oControl.mod_252)
            buffer_write(buffer, buffer_s16, oControl.mod_255)
            buffer_write(buffer, buffer_s16, oControl.mod_257)
            buffer_write(buffer, buffer_s16, oControl.mod_259)
            buffer_write(buffer, buffer_s16, oControl.mod_303)
            buffer_write(buffer, buffer_s16, oControl.mod_304)
            buffer_write(buffer, buffer_s16, oControl.mod_307)
            buffer_write(buffer, buffer_s16, oControl.mod_308)
            buffer_write(buffer, buffer_s16, oControl.mod_309)
            buffer_write(buffer, buffer_s16, oControl.mod_51)
            buffer_write(buffer, buffer_s16, oControl.mod_110)
            buffer_write(buffer, buffer_s16, oControl.mod_162)
            buffer_write(buffer, buffer_s16, oControl.mod_206)
            buffer_write(buffer, buffer_s16, oControl.mod_207)
            buffer_write(buffer, buffer_s16, oControl.mod_209)
            buffer_write(buffer, buffer_s16, oControl.mod_215)
            buffer_write(buffer, buffer_s16, oControl.mod_256)
            buffer_write(buffer, buffer_s16, oControl.mod_300)
            buffer_write(buffer, buffer_s16, oControl.mod_305)
            buffer_write(buffer, buffer_s16, oControl.mod_50)
            buffer_write(buffer, buffer_s16, oControl.mod_103)
            buffer_write(buffer, buffer_s16, oControl.mod_108)
            buffer_write(buffer, buffer_s16, oControl.mod_157)
            buffer_write(buffer, buffer_s16, oControl.mod_158)
            buffer_write(buffer, buffer_s16, oControl.mod_200)
            buffer_write(buffer, buffer_s16, oControl.mod_201)
            buffer_write(buffer, buffer_s16, oControl.mod_251)
            buffer_write(buffer, buffer_s16, oControl.mod_254)
            buffer_write(buffer, buffer_s16, oControl.mod_306)
            buffer_write(buffer, buffer_s16, oControl.mod_58)
            buffer_write(buffer, buffer_s16, oControl.mod_59)
            buffer_write(buffer, buffer_s16, oControl.mod_112)
            buffer_write(buffer, buffer_s16, oControl.mod_160)
            buffer_write(buffer, buffer_s16, oControl.mod_212)
            buffer_write(buffer, buffer_s16, oControl.mod_213)
            buffer_write(buffer, buffer_s16, oControl.mod_253)
            buffer_write(buffer, buffer_s16, oControl.mod_258)
            buffer_write(buffer, buffer_s16, oControl.mod_301)
            buffer_write(buffer, buffer_s16, oControl.mod_302)
            bufferSize = buffer_tell(buffer)
            buffer_seek(buffer, buffer_seek_start, 0)
            buffer_write(buffer, buffer_s32, bufferSize)
            buffer_write(buffer, buffer_u8, 4)
            buffer_write(buffer, buffer_f64, global.seed)
            buffer_write(buffer, buffer_u8, 100)
            buffer_write(buffer, buffer_s16, oControl.mod_bombs)
            buffer_write(buffer, buffer_s16, oControl.mod_spider)
            buffer_write(buffer, buffer_s16, oControl.mod_jumpball)
            buffer_write(buffer, buffer_s16, oControl.mod_hijump)
            buffer_write(buffer, buffer_s16, oControl.mod_varia)
            buffer_write(buffer, buffer_s16, oControl.mod_spacejump)
            buffer_write(buffer, buffer_s16, oControl.mod_speedbooster)
            buffer_write(buffer, buffer_s16, oControl.mod_screwattack)
            buffer_write(buffer, buffer_s16, oControl.mod_gravity)
            buffer_write(buffer, buffer_s16, oControl.mod_charge)
            buffer_write(buffer, buffer_s16, oControl.mod_ice)
            buffer_write(buffer, buffer_s16, oControl.mod_wave)
            buffer_write(buffer, buffer_s16, oControl.mod_spazer)
            buffer_write(buffer, buffer_s16, oControl.mod_plasma)
            buffer_write(buffer, buffer_s16, oControl.mod_52)
            buffer_write(buffer, buffer_s16, oControl.mod_53)
            buffer_write(buffer, buffer_s16, oControl.mod_54)
            buffer_write(buffer, buffer_s16, oControl.mod_55)
            buffer_write(buffer, buffer_s16, oControl.mod_56)
            buffer_write(buffer, buffer_s16, oControl.mod_57)
            buffer_write(buffer, buffer_s16, oControl.mod_60)
            buffer_write(buffer, buffer_s16, oControl.mod_100)
            buffer_write(buffer, buffer_s16, oControl.mod_101)
            buffer_write(buffer, buffer_s16, oControl.mod_102)
            buffer_write(buffer, buffer_s16, oControl.mod_104)
            buffer_write(buffer, buffer_s16, oControl.mod_105)
            buffer_write(buffer, buffer_s16, oControl.mod_106)
            buffer_write(buffer, buffer_s16, oControl.mod_107)
            buffer_write(buffer, buffer_s16, oControl.mod_109)
            buffer_write(buffer, buffer_s16, oControl.mod_111)
            buffer_write(buffer, buffer_s16, oControl.mod_150)
            buffer_write(buffer, buffer_s16, oControl.mod_151)
            buffer_write(buffer, buffer_s16, oControl.mod_152)
            buffer_write(buffer, buffer_s16, oControl.mod_153)
            buffer_write(buffer, buffer_s16, oControl.mod_154)
            buffer_write(buffer, buffer_s16, oControl.mod_155)
            buffer_write(buffer, buffer_s16, oControl.mod_156)
            buffer_write(buffer, buffer_s16, oControl.mod_159)
            buffer_write(buffer, buffer_s16, oControl.mod_161)
            buffer_write(buffer, buffer_s16, oControl.mod_163)
            buffer_write(buffer, buffer_s16, oControl.mod_202)
            buffer_write(buffer, buffer_s16, oControl.mod_203)
            buffer_write(buffer, buffer_s16, oControl.mod_204)
            buffer_write(buffer, buffer_s16, oControl.mod_205)
            buffer_write(buffer, buffer_s16, oControl.mod_208)
            buffer_write(buffer, buffer_s16, oControl.mod_210)
            buffer_write(buffer, buffer_s16, oControl.mod_211)
            buffer_write(buffer, buffer_s16, oControl.mod_214)
            buffer_write(buffer, buffer_s16, oControl.mod_250)
            buffer_write(buffer, buffer_s16, oControl.mod_252)
            buffer_write(buffer, buffer_s16, oControl.mod_255)
            buffer_write(buffer, buffer_s16, oControl.mod_257)
            buffer_write(buffer, buffer_s16, oControl.mod_259)
            buffer_write(buffer, buffer_s16, oControl.mod_303)
            buffer_write(buffer, buffer_s16, oControl.mod_304)
            buffer_write(buffer, buffer_s16, oControl.mod_307)
            buffer_write(buffer, buffer_s16, oControl.mod_308)
            buffer_write(buffer, buffer_s16, oControl.mod_309)
            buffer_write(buffer, buffer_s16, oControl.mod_51)
            buffer_write(buffer, buffer_s16, oControl.mod_110)
            buffer_write(buffer, buffer_s16, oControl.mod_162)
            buffer_write(buffer, buffer_s16, oControl.mod_206)
            buffer_write(buffer, buffer_s16, oControl.mod_207)
            buffer_write(buffer, buffer_s16, oControl.mod_209)
            buffer_write(buffer, buffer_s16, oControl.mod_215)
            buffer_write(buffer, buffer_s16, oControl.mod_256)
            buffer_write(buffer, buffer_s16, oControl.mod_300)
            buffer_write(buffer, buffer_s16, oControl.mod_305)
            buffer_write(buffer, buffer_s16, oControl.mod_50)
            buffer_write(buffer, buffer_s16, oControl.mod_103)
            buffer_write(buffer, buffer_s16, oControl.mod_108)
            buffer_write(buffer, buffer_s16, oControl.mod_157)
            buffer_write(buffer, buffer_s16, oControl.mod_158)
            buffer_write(buffer, buffer_s16, oControl.mod_200)
            buffer_write(buffer, buffer_s16, oControl.mod_201)
            buffer_write(buffer, buffer_s16, oControl.mod_251)
            buffer_write(buffer, buffer_s16, oControl.mod_254)
            buffer_write(buffer, buffer_s16, oControl.mod_306)
            buffer_write(buffer, buffer_s16, oControl.mod_58)
            buffer_write(buffer, buffer_s16, oControl.mod_59)
            buffer_write(buffer, buffer_s16, oControl.mod_112)
            buffer_write(buffer, buffer_s16, oControl.mod_160)
            buffer_write(buffer, buffer_s16, oControl.mod_212)
            buffer_write(buffer, buffer_s16, oControl.mod_213)
            buffer_write(buffer, buffer_s16, oControl.mod_253)
            buffer_write(buffer, buffer_s16, oControl.mod_258)
            buffer_write(buffer, buffer_s16, oControl.mod_301)
            buffer_write(buffer, buffer_s16, oControl.mod_302)
            network_send_packet(socket, buffer, buffer_tell(buffer))
        }
        alarm[0] = 5
        alarm[2] = 30
        alarm[5] = 30
        break
    case 2:
        socket = ds_map_find_value(async_load, "socket")
        findsocket = ds_list_find_index(socketList, socket)
        if (findsocket >= 0)
            ds_list_delete(socketList, findsocket)
        findsocket = ds_list_find_index(playerList, socket)
        if (findsocket >= 0)
        {
            for (i = 0; i < ds_list_size(idList); i++)
            {
                arrList = ds_list_find_value(idList, i)
                if (arrList[0, 1] == socket)
                    ds_list_delete(idList, i)
            }
            ds_list_delete(playerList, findsocket)
            if (ds_list_size(playerList) == 0)
            {
                with (oReset)
                    alarm[10] = 1800
            }
        }
        break
    case 3:
        _buffer = ds_map_find_value(async_load, "buffer")
        socket = ds_map_find_value(async_load, "id")
        bufferSize = buffer_get_size(_buffer)
        buffer_seek(_buffer, buffer_seek_start, 0)
        bufferSizePacket = buffer_read(_buffer, buffer_s32)
        if (!is_real(bufferSizePacket))
            exit
        if ((bufferSizePacket + 4) != bufferSize)
            exit
        msgid = buffer_read(_buffer, buffer_u8)
        switch msgid
        {
            case 254:
                clientID = buffer_read(_buffer, buffer_u8)
                for (i = 0; i < ds_list_size(idList); i++)
                {
                    arrList = ds_list_find_value(idList, i)
                    if (arrList[0, 0] == clientID)
                        ds_list_delete(idList, i)
                }
                sockets = ds_list_size(playerList)
                buffer_delete(buffer)
                size = 1024
                type = buffer_grow
                alignment = 1
                buffer = buffer_create(size, type, alignment)
                buffer_seek(buffer, buffer_seek_start, 0)
                buffer_write(buffer, buffer_u8, 254)
                buffer_write(buffer, buffer_u8, clientID)
                bufferSize = buffer_tell(buffer)
                buffer_seek(buffer, buffer_seek_start, 0)
                buffer_write(buffer, buffer_s32, bufferSize)
                buffer_write(buffer, buffer_u8, 254)
                buffer_write(buffer, buffer_u8, clientID)
                for (i = 0; i < sockets; i++)
                    network_send_packet(ds_list_find_value(playerList, i), buffer, buffer_tell(buffer))
                break
            case 200:
                clientID = buffer_read(_buffer, buffer_u8)
                preferredID = buffer_read(_buffer, buffer_u8)
                tempList = ds_list_create()
                if (ds_list_size(idList) > 0)
                {
                    for (i = 0; i < ds_list_size(idList); i++)
                    {
                        arrList = ds_list_find_value(idList, i)
                        ds_list_add(tempList, arrList[0, 0])
                    }
                }
                findID = ds_list_find_index(tempList, preferredID)
                if (ds_list_size(idList) > 0)
                {
                    for (i = 0; i < ds_list_size(idList); i++)
                    {
                        arrList = ds_list_find_value(idList, i)
                        if (clientID == arrList[0, 0])
                        {
                            if (preferredID >= 1 && preferredID <= 16)
                            {
                                if (findID == -1)
                                {
                                    arrList[0, 0] = preferredID
                                    ds_list_set(idList, i, arrList)
                                    sockets = ds_list_size(playerList)
                                    buffer_delete(buffer)
                                    size = 1024
                                    type = buffer_grow
                                    alignment = 1
                                    buffer = buffer_create(size, type, alignment)
                                    buffer_seek(buffer, buffer_seek_start, 0)
                                    buffer_write(buffer, buffer_u8, 102)
                                    buffer_write(buffer, buffer_string, strict_compress(ds_list_write(idList)))
                                    bufferSize = buffer_tell(buffer)
                                    buffer_seek(buffer, buffer_seek_start, 0)
                                    buffer_write(buffer, buffer_s32, bufferSize)
                                    buffer_write(buffer, buffer_u8, 102)
                                    buffer_write(buffer, buffer_string, strict_compress(ds_list_write(idList)))
                                    for (i = 0; i < sockets; i++)
                                        network_send_packet(ds_list_find_value(playerList, i), buffer, buffer_tell(buffer))
                                    buffer_delete(buffer)
                                    size = 1024
                                    type = buffer_grow
                                    alignment = 1
                                    buffer = buffer_create(size, type, alignment)
                                    buffer_seek(buffer, buffer_seek_start, 0)
                                    buffer_write(buffer, buffer_u8, 200)
                                    bufferSize = buffer_tell(buffer)
                                    buffer_seek(buffer, buffer_seek_start, 0)
                                    buffer_write(buffer, buffer_s32, bufferSize)
                                    buffer_write(buffer, buffer_u8, 200)
                                    network_send_packet(socket, buffer, buffer_tell(buffer))
                                }
                            }
                        }
                    }
                }
                ds_list_destroy(tempList)
                break
            case 100:
                clientID = buffer_read(_buffer, buffer_u8)
                clientX = buffer_read(_buffer, buffer_s16)
                clientY = buffer_read(_buffer, buffer_s16)
                clientSprite = buffer_read(_buffer, buffer_s16)
                clientImage = buffer_read(_buffer, buffer_s16)
                clientA1 = buffer_read(_buffer, buffer_s16)
                clientA1X = buffer_read(_buffer, buffer_s16)
                clientA1Y = buffer_read(_buffer, buffer_s16)
                clientA2 = buffer_read(_buffer, buffer_s16)
                clientA2X = buffer_read(_buffer, buffer_s16)
                clientA2Y = buffer_read(_buffer, buffer_s16)
                clientA2A = buffer_read(_buffer, buffer_s16)
                clientMirror = buffer_read(_buffer, buffer_s16)
                clientArmmsl = buffer_read(_buffer, buffer_s16)
                clientRoom = buffer_read(_buffer, buffer_s16)
                clientName = buffer_read(_buffer, buffer_string)
                clientBlend = buffer_read(_buffer, buffer_s16)
                clientFXTimer = buffer_read(_buffer, buffer_s8)
                clientRoomPrev = buffer_read(_buffer, buffer_s16)
                clientState = buffer_read(_buffer, buffer_u8)
                sockets = ds_list_size(playerList)
                buffer_delete(buffer)
                size = 1024
                type = buffer_grow
                alignment = 1
                buffer = buffer_create(size, type, alignment)
                buffer_seek(buffer, buffer_seek_start, 0)
                buffer_write(buffer, buffer_u8, 100)
                buffer_write(buffer, buffer_u8, clientID)
                buffer_write(buffer, buffer_s16, clientX)
                buffer_write(buffer, buffer_s16, clientY)
                buffer_write(buffer, buffer_s16, clientSprite)
                buffer_write(buffer, buffer_s16, clientImage)
                buffer_write(buffer, buffer_s16, clientA1)
                buffer_write(buffer, buffer_s16, clientA1X)
                buffer_write(buffer, buffer_s16, clientA1Y)
                buffer_write(buffer, buffer_s16, clientA2)
                buffer_write(buffer, buffer_s16, clientA2X)
                buffer_write(buffer, buffer_s16, clientA2Y)
                buffer_write(buffer, buffer_s16, clientA2A)
                buffer_write(buffer, buffer_s16, clientMirror)
                buffer_write(buffer, buffer_s16, clientArmmsl)
                buffer_write(buffer, buffer_s16, clientRoom)
                buffer_write(buffer, buffer_string, clientName)
                buffer_write(buffer, buffer_s16, clientBlend)
                buffer_write(buffer, buffer_s8, clientFXTimer)
                buffer_write(buffer, buffer_s16, clientRoomPrev)
                buffer_write(buffer, buffer_u8, clientState)
                bufferSize = buffer_tell(buffer)
                buffer_seek(buffer, buffer_seek_start, 0)
                buffer_write(buffer, buffer_s32, bufferSize)
                buffer_write(buffer, buffer_u8, 100)
                buffer_write(buffer, buffer_u8, clientID)
                buffer_write(buffer, buffer_s16, clientX)
                buffer_write(buffer, buffer_s16, clientY)
                buffer_write(buffer, buffer_s16, clientSprite)
                buffer_write(buffer, buffer_s16, clientImage)
                buffer_write(buffer, buffer_s16, clientA1)
                buffer_write(buffer, buffer_s16, clientA1X)
                buffer_write(buffer, buffer_s16, clientA1Y)
                buffer_write(buffer, buffer_s16, clientA2)
                buffer_write(buffer, buffer_s16, clientA2X)
                buffer_write(buffer, buffer_s16, clientA2Y)
                buffer_write(buffer, buffer_s16, clientA2A)
                buffer_write(buffer, buffer_s16, clientMirror)
                buffer_write(buffer, buffer_s16, clientArmmsl)
                buffer_write(buffer, buffer_s16, clientRoom)
                buffer_write(buffer, buffer_string, clientName)
                buffer_write(buffer, buffer_s16, clientBlend)
                buffer_write(buffer, buffer_s8, clientFXTimer)
                buffer_write(buffer, buffer_s16, clientRoomPrev)
                buffer_write(buffer, buffer_u8, clientState)
                for (i = 0; i < sockets; i++)
                {
                    if (ds_list_find_value(playerList, i) != socket)
                        network_send_packet(ds_list_find_value(playerList, i), buffer, buffer_tell(buffer))
                }
                break
            case 101:
                clientID = buffer_read(_buffer, buffer_u8)
                clientRoom = buffer_read(_buffer, buffer_s16)
                clientMapX = buffer_read(_buffer, buffer_s16)
                clientMapY = buffer_read(_buffer, buffer_s16)
                sockets = ds_list_size(playerList)
                if (!global.mapPlayerIconSync)
                {
                    clientMapX = 3
                    clientMapY = 3
                }
                buffer_delete(buffer)
                size = 1024
                type = buffer_grow
                alignment = 1
                buffer = buffer_create(size, type, alignment)
                buffer_seek(buffer, buffer_seek_start, 0)
                buffer_write(buffer, buffer_u8, 101)
                buffer_write(buffer, buffer_u8, clientID)
                buffer_write(buffer, buffer_s16, clientRoom)
                buffer_write(buffer, buffer_s16, clientMapX)
                buffer_write(buffer, buffer_s16, clientMapY)
                bufferSize = buffer_tell(buffer)
                buffer_seek(buffer, buffer_seek_start, 0)
                buffer_write(buffer, buffer_s32, bufferSize)
                buffer_write(buffer, buffer_u8, 101)
                buffer_write(buffer, buffer_u8, clientID)
                buffer_write(buffer, buffer_s16, clientRoom)
                buffer_write(buffer, buffer_s16, clientMapX)
                buffer_write(buffer, buffer_s16, clientMapY)
                for (i = 0; i < sockets; i++)
                {
                    if (ds_list_find_value(playerList, i) != socket)
                        network_send_packet(ds_list_find_value(playerList, i), buffer, buffer_tell(buffer))
                }
                break
            case 102:
                playerHealth = buffer_read(_buffer, buffer_s16)
                missiles = buffer_read(_buffer, buffer_s16)
                smissiles = buffer_read(_buffer, buffer_u8)
                pbombs = buffer_read(_buffer, buffer_u8)
                clientID = buffer_read(_buffer, buffer_u8)
                sockets = ds_list_size(playerList)
                buffer_delete(buffer)
                size = 1024
                type = buffer_grow
                alignment = 1
                buffer = buffer_create(size, type, alignment)
                buffer_seek(buffer, buffer_seek_start, 0)
                buffer_write(buffer, buffer_u8, 104)
                buffer_write(buffer, buffer_s16, playerHealth)
                buffer_write(buffer, buffer_s16, missiles)
                buffer_write(buffer, buffer_u8, smissiles)
                buffer_write(buffer, buffer_u8, pbombs)
                buffer_write(buffer, buffer_u8, clientID)
                bufferSize = buffer_tell(buffer)
                buffer_seek(buffer, buffer_seek_start, 0)
                buffer_write(buffer, buffer_s32, bufferSize)
                buffer_write(buffer, buffer_u8, 104)
                buffer_write(buffer, buffer_s16, playerHealth)
                buffer_write(buffer, buffer_s16, missiles)
                buffer_write(buffer, buffer_u8, smissiles)
                buffer_write(buffer, buffer_u8, pbombs)
                buffer_write(buffer, buffer_u8, clientID)
                for (i = 0; i < sockets; i++)
                {
                    if (ds_list_find_value(playerList, i) != socket)
                        network_send_packet(ds_list_find_value(playerList, i), buffer, buffer_tell(buffer))
                }
                break
            case 103:
                ping = buffer_read(_buffer, buffer_u32)
                buffer_delete(buffer)
                size = 1024
                type = buffer_grow
                alignment = 1
                buffer = buffer_create(size, type, alignment)
                buffer_seek(buffer, buffer_seek_start, 0)
                buffer_write(buffer, buffer_u8, 105)
                buffer_write(buffer, buffer_u32, ping)
                bufferSize = buffer_tell(buffer)
                buffer_seek(buffer, buffer_seek_start, 0)
                buffer_write(buffer, buffer_s32, bufferSize)
                buffer_write(buffer, buffer_u8, 105)
                buffer_write(buffer, buffer_u32, ping)
                network_send_packet(socket, buffer, buffer_tell(buffer))
                break
            case 0:
                ds_grid_read(vars, strict_decompress(buffer_read(_buffer, buffer_string)))
                clientID = buffer_read(_buffer, buffer_u8)
                packetID = buffer_read(_buffer, buffer_u32)
                buffer_delete(buffer)
                size = 1024
                type = buffer_grow
                alignment = 1
                buffer = buffer_create(size, type, alignment)
                buffer_seek(buffer, buffer_seek_start, 0)
                buffer_write(buffer, buffer_u8, 1)
                buffer_write(buffer, buffer_string, strict_compress(ds_grid_write(vars)))
                buffer_write(buffer, buffer_u8, clientID)
                buffer_write(buffer, buffer_u32, packetID)
                bufferSize = buffer_tell(buffer)
                buffer_seek(buffer, buffer_seek_start, 0)
                buffer_write(buffer, buffer_s32, bufferSize)
                buffer_write(buffer, buffer_u8, 1)
                buffer_write(buffer, buffer_string, strict_compress(ds_grid_write(vars)))
                buffer_write(buffer, buffer_u8, clientID)
                buffer_write(buffer, buffer_u32, packetID)
                sockets = ds_list_size(playerList)
                for (i = 0; i < sockets; i++)
                {
                    if (ds_list_find_value(playerList, i) != socket)
                    {
                        if (global.itemSync && global.itemToggleSync)
                            network_send_packet(ds_list_find_value(playerList, i), buffer, buffer_tell(buffer))
                    }
                    else
                    {
                        size = 1024
                        type = buffer_grow
                        alignment = 1
                        socketBuffer = buffer_create(size, type, alignment)
                        buffer_seek(socketBuffer, buffer_seek_start, 0)
                        buffer_write(socketBuffer, buffer_u8, 2)
                        buffer_write(socketBuffer, buffer_string, strict_compress(ds_grid_write(vars)))
                        buffer_write(socketBuffer, buffer_u8, clientID)
                        bufferSize = buffer_tell(socketBuffer)
                        buffer_seek(socketBuffer, buffer_seek_start, 0)
                        buffer_write(socketBuffer, buffer_s32, bufferSize)
                        buffer_write(socketBuffer, buffer_u8, 2)
                        buffer_write(socketBuffer, buffer_string, strict_compress(ds_grid_write(vars)))
                        buffer_write(socketBuffer, buffer_u8, clientID)
                        network_send_packet(ds_list_find_value(playerList, i), socketBuffer, buffer_tell(socketBuffer))
                        buffer_delete(socketBuffer)
                    }
                }
                break
            case 1:
                name = buffer_read(_buffer, buffer_string)
                findsocket = ds_list_find_index(playerList, socket)
                if (findsocket < 0)
                {
                    ds_list_add(playerList, socket)
                    if (ds_list_size(playerList) > 0 && oReset.alarm[10] > 0)
                        oReset.alarm[10] = -1
                }
                if (ds_list_size(idList) > 0)
                {
                    for (i = 0; i < ds_list_size(idList); i++)
                    {
                        arrList = ds_list_find_value(idList, i)
                        if (arrList[0, 1] == socket)
                        {
                            arrList[0, 2] = name
                            ds_list_set(idList, i, arrList)
                        }
                    }
                }
                break
            case 2:
                _queenHealth = buffer_read(_buffer, buffer_s32)
                sockets = ds_list_size(playerList)
                clientID = buffer_read(_buffer, buffer_u8)
                phase = buffer_read(_buffer, buffer_s8)
                state = buffer_read(_buffer, buffer_s8)
                if (queenHealth != _queenHealth)
                    queenHealth = _queenHealth
                if (queenPhase != phase)
                    queenPhase = phase
                if (queenState != state)
                    queenState = state
                buffer_delete(buffer)
                size = 1024
                type = buffer_grow
                alignment = 1
                buffer = buffer_create(size, type, alignment)
                buffer_seek(buffer, buffer_seek_start, 0)
                buffer_write(buffer, buffer_u8, 3)
                buffer_write(buffer, buffer_s32, queenHealth)
                buffer_write(buffer, buffer_u8, clientID)
                buffer_write(buffer, buffer_s8, queenPhase)
                buffer_write(buffer, buffer_s8, queenState)
                bufferSize = buffer_tell(buffer)
                buffer_seek(buffer, buffer_seek_start, 0)
                buffer_write(buffer, buffer_s32, bufferSize)
                buffer_write(buffer, buffer_u8, 3)
                buffer_write(buffer, buffer_s32, queenHealth)
                buffer_write(buffer, buffer_u8, clientID)
                buffer_write(buffer, buffer_s8, queenPhase)
                buffer_write(buffer, buffer_s8, queenState)
                sockets = ds_list_size(playerList)
                for (i = 0; i < sockets; i++)
                    network_send_packet(ds_list_find_value(playerList, i), buffer, buffer_tell(buffer))
                break
            case 3:
                seed = buffer_read(_buffer, buffer_f64)
                clientID = buffer_read(_buffer, buffer_u8)
                global.seed = seed
                sockets = ds_list_size(playerList)
                buffer_delete(buffer)
                size = 1024
                type = buffer_grow
                alignment = 1
                buffer = buffer_create(size, type, alignment)
                buffer_seek(buffer, buffer_seek_start, 0)
                buffer_write(buffer, buffer_u8, 4)
                buffer_write(buffer, buffer_f64, seed)
                buffer_write(buffer, buffer_u8, clientID)
                buffer_write(buffer, buffer_s16, oControl.mod_bombs)
                buffer_write(buffer, buffer_s16, oControl.mod_spider)
                buffer_write(buffer, buffer_s16, oControl.mod_jumpball)
                buffer_write(buffer, buffer_s16, oControl.mod_hijump)
                buffer_write(buffer, buffer_s16, oControl.mod_varia)
                buffer_write(buffer, buffer_s16, oControl.mod_spacejump)
                buffer_write(buffer, buffer_s16, oControl.mod_speedbooster)
                buffer_write(buffer, buffer_s16, oControl.mod_screwattack)
                buffer_write(buffer, buffer_s16, oControl.mod_gravity)
                buffer_write(buffer, buffer_s16, oControl.mod_charge)
                buffer_write(buffer, buffer_s16, oControl.mod_ice)
                buffer_write(buffer, buffer_s16, oControl.mod_wave)
                buffer_write(buffer, buffer_s16, oControl.mod_spazer)
                buffer_write(buffer, buffer_s16, oControl.mod_plasma)
                buffer_write(buffer, buffer_s16, oControl.mod_52)
                buffer_write(buffer, buffer_s16, oControl.mod_53)
                buffer_write(buffer, buffer_s16, oControl.mod_54)
                buffer_write(buffer, buffer_s16, oControl.mod_55)
                buffer_write(buffer, buffer_s16, oControl.mod_56)
                buffer_write(buffer, buffer_s16, oControl.mod_57)
                buffer_write(buffer, buffer_s16, oControl.mod_60)
                buffer_write(buffer, buffer_s16, oControl.mod_100)
                buffer_write(buffer, buffer_s16, oControl.mod_101)
                buffer_write(buffer, buffer_s16, oControl.mod_102)
                buffer_write(buffer, buffer_s16, oControl.mod_104)
                buffer_write(buffer, buffer_s16, oControl.mod_105)
                buffer_write(buffer, buffer_s16, oControl.mod_106)
                buffer_write(buffer, buffer_s16, oControl.mod_107)
                buffer_write(buffer, buffer_s16, oControl.mod_109)
                buffer_write(buffer, buffer_s16, oControl.mod_111)
                buffer_write(buffer, buffer_s16, oControl.mod_150)
                buffer_write(buffer, buffer_s16, oControl.mod_151)
                buffer_write(buffer, buffer_s16, oControl.mod_152)
                buffer_write(buffer, buffer_s16, oControl.mod_153)
                buffer_write(buffer, buffer_s16, oControl.mod_154)
                buffer_write(buffer, buffer_s16, oControl.mod_155)
                buffer_write(buffer, buffer_s16, oControl.mod_156)
                buffer_write(buffer, buffer_s16, oControl.mod_159)
                buffer_write(buffer, buffer_s16, oControl.mod_161)
                buffer_write(buffer, buffer_s16, oControl.mod_163)
                buffer_write(buffer, buffer_s16, oControl.mod_202)
                buffer_write(buffer, buffer_s16, oControl.mod_203)
                buffer_write(buffer, buffer_s16, oControl.mod_204)
                buffer_write(buffer, buffer_s16, oControl.mod_205)
                buffer_write(buffer, buffer_s16, oControl.mod_208)
                buffer_write(buffer, buffer_s16, oControl.mod_210)
                buffer_write(buffer, buffer_s16, oControl.mod_211)
                buffer_write(buffer, buffer_s16, oControl.mod_214)
                buffer_write(buffer, buffer_s16, oControl.mod_250)
                buffer_write(buffer, buffer_s16, oControl.mod_252)
                buffer_write(buffer, buffer_s16, oControl.mod_255)
                buffer_write(buffer, buffer_s16, oControl.mod_257)
                buffer_write(buffer, buffer_s16, oControl.mod_259)
                buffer_write(buffer, buffer_s16, oControl.mod_303)
                buffer_write(buffer, buffer_s16, oControl.mod_304)
                buffer_write(buffer, buffer_s16, oControl.mod_307)
                buffer_write(buffer, buffer_s16, oControl.mod_308)
                buffer_write(buffer, buffer_s16, oControl.mod_309)
                buffer_write(buffer, buffer_s16, oControl.mod_51)
                buffer_write(buffer, buffer_s16, oControl.mod_110)
                buffer_write(buffer, buffer_s16, oControl.mod_162)
                buffer_write(buffer, buffer_s16, oControl.mod_206)
                buffer_write(buffer, buffer_s16, oControl.mod_207)
                buffer_write(buffer, buffer_s16, oControl.mod_209)
                buffer_write(buffer, buffer_s16, oControl.mod_215)
                buffer_write(buffer, buffer_s16, oControl.mod_256)
                buffer_write(buffer, buffer_s16, oControl.mod_300)
                buffer_write(buffer, buffer_s16, oControl.mod_305)
                buffer_write(buffer, buffer_s16, oControl.mod_50)
                buffer_write(buffer, buffer_s16, oControl.mod_103)
                buffer_write(buffer, buffer_s16, oControl.mod_108)
                buffer_write(buffer, buffer_s16, oControl.mod_157)
                buffer_write(buffer, buffer_s16, oControl.mod_158)
                buffer_write(buffer, buffer_s16, oControl.mod_200)
                buffer_write(buffer, buffer_s16, oControl.mod_201)
                buffer_write(buffer, buffer_s16, oControl.mod_251)
                buffer_write(buffer, buffer_s16, oControl.mod_254)
                buffer_write(buffer, buffer_s16, oControl.mod_306)
                buffer_write(buffer, buffer_s16, oControl.mod_58)
                buffer_write(buffer, buffer_s16, oControl.mod_59)
                buffer_write(buffer, buffer_s16, oControl.mod_112)
                buffer_write(buffer, buffer_s16, oControl.mod_160)
                buffer_write(buffer, buffer_s16, oControl.mod_212)
                buffer_write(buffer, buffer_s16, oControl.mod_213)
                buffer_write(buffer, buffer_s16, oControl.mod_253)
                buffer_write(buffer, buffer_s16, oControl.mod_258)
                buffer_write(buffer, buffer_s16, oControl.mod_301)
                buffer_write(buffer, buffer_s16, oControl.mod_302)
                bufferSize = buffer_tell(buffer)
                buffer_seek(buffer, buffer_seek_start, 0)
                buffer_write(buffer, buffer_s32, bufferSize)
                buffer_write(buffer, buffer_u8, 4)
                buffer_write(buffer, buffer_f64, seed)
                buffer_write(buffer, buffer_u8, clientID)
                buffer_write(buffer, buffer_s16, oControl.mod_bombs)
                buffer_write(buffer, buffer_s16, oControl.mod_spider)
                buffer_write(buffer, buffer_s16, oControl.mod_jumpball)
                buffer_write(buffer, buffer_s16, oControl.mod_hijump)
                buffer_write(buffer, buffer_s16, oControl.mod_varia)
                buffer_write(buffer, buffer_s16, oControl.mod_spacejump)
                buffer_write(buffer, buffer_s16, oControl.mod_speedbooster)
                buffer_write(buffer, buffer_s16, oControl.mod_screwattack)
                buffer_write(buffer, buffer_s16, oControl.mod_gravity)
                buffer_write(buffer, buffer_s16, oControl.mod_charge)
                buffer_write(buffer, buffer_s16, oControl.mod_ice)
                buffer_write(buffer, buffer_s16, oControl.mod_wave)
                buffer_write(buffer, buffer_s16, oControl.mod_spazer)
                buffer_write(buffer, buffer_s16, oControl.mod_plasma)
                buffer_write(buffer, buffer_s16, oControl.mod_52)
                buffer_write(buffer, buffer_s16, oControl.mod_53)
                buffer_write(buffer, buffer_s16, oControl.mod_54)
                buffer_write(buffer, buffer_s16, oControl.mod_55)
                buffer_write(buffer, buffer_s16, oControl.mod_56)
                buffer_write(buffer, buffer_s16, oControl.mod_57)
                buffer_write(buffer, buffer_s16, oControl.mod_60)
                buffer_write(buffer, buffer_s16, oControl.mod_100)
                buffer_write(buffer, buffer_s16, oControl.mod_101)
                buffer_write(buffer, buffer_s16, oControl.mod_102)
                buffer_write(buffer, buffer_s16, oControl.mod_104)
                buffer_write(buffer, buffer_s16, oControl.mod_105)
                buffer_write(buffer, buffer_s16, oControl.mod_106)
                buffer_write(buffer, buffer_s16, oControl.mod_107)
                buffer_write(buffer, buffer_s16, oControl.mod_109)
                buffer_write(buffer, buffer_s16, oControl.mod_111)
                buffer_write(buffer, buffer_s16, oControl.mod_150)
                buffer_write(buffer, buffer_s16, oControl.mod_151)
                buffer_write(buffer, buffer_s16, oControl.mod_152)
                buffer_write(buffer, buffer_s16, oControl.mod_153)
                buffer_write(buffer, buffer_s16, oControl.mod_154)
                buffer_write(buffer, buffer_s16, oControl.mod_155)
                buffer_write(buffer, buffer_s16, oControl.mod_156)
                buffer_write(buffer, buffer_s16, oControl.mod_159)
                buffer_write(buffer, buffer_s16, oControl.mod_161)
                buffer_write(buffer, buffer_s16, oControl.mod_163)
                buffer_write(buffer, buffer_s16, oControl.mod_202)
                buffer_write(buffer, buffer_s16, oControl.mod_203)
                buffer_write(buffer, buffer_s16, oControl.mod_204)
                buffer_write(buffer, buffer_s16, oControl.mod_205)
                buffer_write(buffer, buffer_s16, oControl.mod_208)
                buffer_write(buffer, buffer_s16, oControl.mod_210)
                buffer_write(buffer, buffer_s16, oControl.mod_211)
                buffer_write(buffer, buffer_s16, oControl.mod_214)
                buffer_write(buffer, buffer_s16, oControl.mod_250)
                buffer_write(buffer, buffer_s16, oControl.mod_252)
                buffer_write(buffer, buffer_s16, oControl.mod_255)
                buffer_write(buffer, buffer_s16, oControl.mod_257)
                buffer_write(buffer, buffer_s16, oControl.mod_259)
                buffer_write(buffer, buffer_s16, oControl.mod_303)
                buffer_write(buffer, buffer_s16, oControl.mod_304)
                buffer_write(buffer, buffer_s16, oControl.mod_307)
                buffer_write(buffer, buffer_s16, oControl.mod_308)
                buffer_write(buffer, buffer_s16, oControl.mod_309)
                buffer_write(buffer, buffer_s16, oControl.mod_51)
                buffer_write(buffer, buffer_s16, oControl.mod_110)
                buffer_write(buffer, buffer_s16, oControl.mod_162)
                buffer_write(buffer, buffer_s16, oControl.mod_206)
                buffer_write(buffer, buffer_s16, oControl.mod_207)
                buffer_write(buffer, buffer_s16, oControl.mod_209)
                buffer_write(buffer, buffer_s16, oControl.mod_215)
                buffer_write(buffer, buffer_s16, oControl.mod_256)
                buffer_write(buffer, buffer_s16, oControl.mod_300)
                buffer_write(buffer, buffer_s16, oControl.mod_305)
                buffer_write(buffer, buffer_s16, oControl.mod_50)
                buffer_write(buffer, buffer_s16, oControl.mod_103)
                buffer_write(buffer, buffer_s16, oControl.mod_108)
                buffer_write(buffer, buffer_s16, oControl.mod_157)
                buffer_write(buffer, buffer_s16, oControl.mod_158)
                buffer_write(buffer, buffer_s16, oControl.mod_200)
                buffer_write(buffer, buffer_s16, oControl.mod_201)
                buffer_write(buffer, buffer_s16, oControl.mod_251)
                buffer_write(buffer, buffer_s16, oControl.mod_254)
                buffer_write(buffer, buffer_s16, oControl.mod_306)
                buffer_write(buffer, buffer_s16, oControl.mod_58)
                buffer_write(buffer, buffer_s16, oControl.mod_59)
                buffer_write(buffer, buffer_s16, oControl.mod_112)
                buffer_write(buffer, buffer_s16, oControl.mod_160)
                buffer_write(buffer, buffer_s16, oControl.mod_212)
                buffer_write(buffer, buffer_s16, oControl.mod_213)
                buffer_write(buffer, buffer_s16, oControl.mod_253)
                buffer_write(buffer, buffer_s16, oControl.mod_258)
                buffer_write(buffer, buffer_s16, oControl.mod_301)
                buffer_write(buffer, buffer_s16, oControl.mod_302)
                for (i = 0; i < sockets; i++)
                    network_send_packet(ds_list_find_value(playerList, i), buffer, buffer_tell(buffer))
                break
            case 4:
                monstersLeft = buffer_read(_buffer, buffer_s8)
                clientID = buffer_read(_buffer, buffer_u8)
                sockets = ds_list_size(playerList)
                global.monstersleft = monstersLeft
                buffer_delete(buffer)
                size = 1024
                type = buffer_grow
                alignment = 1
                buffer = buffer_create(size, type, alignment)
                buffer_seek(buffer, buffer_seek_start, 0)
                buffer_write(buffer, buffer_u8, 5)
                buffer_write(buffer, buffer_s8, monstersLeft)
                buffer_write(buffer, buffer_u8, clientID)
                bufferSize = buffer_tell(buffer)
                buffer_seek(buffer, buffer_seek_start, 0)
                buffer_write(buffer, buffer_s32, bufferSize)
                buffer_write(buffer, buffer_u8, 5)
                buffer_write(buffer, buffer_s8, monstersLeft)
                buffer_write(buffer, buffer_u8, clientID)
                if global.metroidSync
                {
                    for (i = 0; i < sockets; i++)
                        network_send_packet(ds_list_find_value(playerList, i), buffer, buffer_tell(buffer))
                }
                else
                    network_send_packet(socket, buffer, buffer_tell(buffer))
                break
            case 5:
                monstersArea = buffer_read(_buffer, buffer_s8)
                clientID = buffer_read(_buffer, buffer_u8)
                sockets = ds_list_size(playerList)
                buffer_delete(buffer)
                size = 1024
                type = buffer_grow
                alignment = 1
                buffer = buffer_create(size, type, alignment)
                buffer_seek(buffer, buffer_seek_start, 0)
                buffer_write(buffer, buffer_u8, 6)
                buffer_write(buffer, buffer_s8, monstersArea)
                buffer_write(buffer, buffer_u8, clientID)
                bufferSize = buffer_tell(buffer)
                buffer_seek(buffer, buffer_seek_start, 0)
                buffer_write(buffer, buffer_s32, bufferSize)
                buffer_write(buffer, buffer_u8, 6)
                buffer_write(buffer, buffer_s8, monstersArea)
                buffer_write(buffer, buffer_u8, clientID)
                if global.metroidSync
                {
                    for (i = 0; i < sockets; i++)
                        network_send_packet(ds_list_find_value(playerList, i), buffer, buffer_tell(buffer))
                }
                else
                    network_send_packet(socket, buffer, buffer_tell(buffer))
                break
            case 6:
                item = ds_list_create()
                ds_list_read(item, strict_decompress(buffer_read(_buffer, buffer_string)))
                clientID = buffer_read(_buffer, buffer_u8)
                sockets = ds_list_size(playerList)
                itemArr = ds_list_find_value(item, 0)
                if is_array(itemArr)
                {
                    for (i = 0; i < array_length_1d(global.item); i++)
                    {
                        for (f = 0; f < array_height_2d(itemArr); f++)
                        {
                            if (i == itemArr[f, 1])
                            {
                                if (global.item[i] != itemArr[f, 0] && itemArr[f, 0] == 1)
                                    global.item[i] = itemArr[f, 0]
                            }
                        }
                    }
                }
                buffer_delete(buffer)
                size = 1024
                type = buffer_grow
                alignment = 1
                buffer = buffer_create(size, type, alignment)
                buffer_seek(buffer, buffer_seek_start, 0)
                buffer_write(buffer, buffer_u8, 7)
                buffer_write(buffer, buffer_string, strict_compress(ds_list_write(item)))
                buffer_write(buffer, buffer_u8, clientID)
                bufferSize = buffer_tell(buffer)
                buffer_seek(buffer, buffer_seek_start, 0)
                buffer_write(buffer, buffer_s32, bufferSize)
                buffer_write(buffer, buffer_u8, 7)
                buffer_write(buffer, buffer_string, strict_compress(ds_list_write(item)))
                buffer_write(buffer, buffer_u8, clientID)
                if global.itemSync
                {
                    for (i = 0; i < sockets; i++)
                        network_send_packet(ds_list_find_value(playerList, i), buffer, buffer_tell(buffer))
                }
                else
                    network_send_packet(socket, buffer, buffer_tell(buffer))
                ds_list_destroy(item)
                break
            case 7:
                metdead = ds_list_create()
                ds_list_read(metdead, strict_decompress(buffer_read(_buffer, buffer_string)))
                clientID = buffer_read(_buffer, buffer_u8)
                sockets = ds_list_size(playerList)
                metdeadArr = ds_list_find_value(metdead, 0)
                if is_array(metdeadArr)
                {
                    for (i = 0; i < array_length_1d(global.metdead); i++)
                    {
                        for (f = 0; f < array_height_2d(metdeadArr); f++)
                        {
                            if (i == metdeadArr[f, 1])
                            {
                                if (global.metdead[i] != metdeadArr[f, 0] && metdeadArr[f, 0] == 1)
                                    global.metdead[i] = metdeadArr[f, 0]
                            }
                        }
                    }
                }
                buffer_delete(buffer)
                size = 1024
                type = buffer_grow
                alignment = 1
                buffer = buffer_create(size, type, alignment)
                buffer_seek(buffer, buffer_seek_start, 0)
                buffer_write(buffer, buffer_u8, 8)
                buffer_write(buffer, buffer_string, strict_compress(ds_list_write(metdead)))
                buffer_write(buffer, buffer_u8, clientID)
                bufferSize = buffer_tell(buffer)
                buffer_seek(buffer, buffer_seek_start, 0)
                buffer_write(buffer, buffer_s32, bufferSize)
                buffer_write(buffer, buffer_u8, 8)
                buffer_write(buffer, buffer_string, strict_compress(ds_list_write(metdead)))
                buffer_write(buffer, buffer_u8, clientID)
                if global.metroidSync
                {
                    for (i = 0; i < sockets; i++)
                        network_send_packet(ds_list_find_value(playerList, i), buffer, buffer_tell(buffer))
                }
                else
                    network_send_packet(socket, buffer, buffer_tell(buffer))
                ds_list_destroy(metdead)
                break
            case 8:
                event = ds_list_create()
                ds_list_read(event, strict_decompress(buffer_read(_buffer, buffer_string)))
                clientID = buffer_read(_buffer, buffer_u8)
                sockets = ds_list_size(playerList)
                eventArr = ds_list_find_value(event, 0)
                if is_array(eventArr)
                {
                    for (i = 0; i < array_length_1d(global.event); i++)
                    {
                        for (f = 0; f < array_height_2d(eventArr); f++)
                        {
                            if (i == eventArr[f, 1] && eventArr[f, 1] != 102)
                            {
                                if (global.event[i] < eventArr[f, 0] && eventArr[f, 0] > 0)
                                    global.event[i] = eventArr[f, 0]
                            }
                        }
                    }
                }
                buffer_delete(buffer)
                size = 1024
                type = buffer_grow
                alignment = 1
                buffer = buffer_create(size, type, alignment)
                buffer_seek(buffer, buffer_seek_start, 0)
                buffer_write(buffer, buffer_u8, 9)
                buffer_write(buffer, buffer_string, strict_compress(ds_list_write(event)))
                buffer_write(buffer, buffer_u8, clientID)
                bufferSize = buffer_tell(buffer)
                buffer_seek(buffer, buffer_seek_start, 0)
                buffer_write(buffer, buffer_s32, bufferSize)
                buffer_write(buffer, buffer_u8, 9)
                buffer_write(buffer, buffer_string, strict_compress(ds_list_write(event)))
                buffer_write(buffer, buffer_u8, clientID)
                if global.eventSync
                {
                    for (i = 0; i < sockets; i++)
                        network_send_packet(ds_list_find_value(playerList, i), buffer, buffer_tell(buffer))
                }
                else
                    network_send_packet(socket, buffer, buffer_tell(buffer))
                ds_list_destroy(event)
                break
            case 9:
                tileCount = buffer_read(_buffer, buffer_u16)
                if (tileCount > 0)
                {
                    buffer_delete(buffer)
                    size = 1024
                    type = buffer_grow
                    alignment = 1
                    buffer = buffer_create(size, type, alignment)
                    buffer_seek(buffer, buffer_seek_start, 0)
                    buffer_write(buffer, buffer_s32, bufferSizePacket)
                    buffer_write(buffer, buffer_u8, 10)
                    buffer_write(buffer, buffer_u16, tileCount)
                    for (i = 0; i < tileCount; i++)
                    {
                        tileX = buffer_read(_buffer, buffer_u8)
                        tileY = buffer_read(_buffer, buffer_u8)
                        tileData = buffer_read(_buffer, buffer_u8)
                        buffer_write(buffer, buffer_u8, tileX)
                        buffer_write(buffer, buffer_u8, tileY)
                        buffer_write(buffer, buffer_u8, tileData)
                        if (tileData > global.dmap[tileX, tileY])
                            global.dmap[tileX, tileY] = tileData
                        else if (tileData < global.dmap[tileX, tileY])
                        {
                            if (global.dmap[tileX, tileY] == 10 && tileData == 1)
                                global.dmap[tileX, tileY] = tileData
                        }
                    }
                    clientID = buffer_read(_buffer, buffer_u8)
                    buffer_write(buffer, buffer_u8, clientID)
                    sockets = ds_list_size(playerList)
                    if global.mapSync
                    {
                        for (i = 0; i < sockets; i++)
                            network_send_packet(ds_list_find_value(playerList, i), buffer, buffer_tell(buffer))
                    }
                    else
                        network_send_packet(socket, buffer, buffer_tell(buffer))
                }
                if (alarm[5] < 120 && alarm[5] > 1)
                {
                    alarm[5] += 120
                    show_debug_message("dmap alarm incremented")
                }
                break
            case 10:
                itemstaken = buffer_read(_buffer, buffer_u8)
                clientID = buffer_read(_buffer, buffer_u8)
                sockets = ds_list_size(playerList)
                buffer_delete(buffer)
                size = 1024
                type = buffer_grow
                alignment = 1
                buffer = buffer_create(size, type, alignment)
                buffer_seek(buffer, buffer_seek_start, 0)
                buffer_write(buffer, buffer_u8, 11)
                buffer_write(buffer, buffer_u8, itemstaken)
                buffer_write(buffer, buffer_u8, clientID)
                bufferSize = buffer_tell(buffer)
                buffer_seek(buffer, buffer_seek_start, 0)
                buffer_write(buffer, buffer_s32, bufferSize)
                buffer_write(buffer, buffer_u8, 11)
                buffer_write(buffer, buffer_u8, itemstaken)
                buffer_write(buffer, buffer_u8, clientID)
                if global.itemSync
                {
                    for (i = 0; i < sockets; i++)
                        network_send_packet(ds_list_find_value(playerList, i), buffer, buffer_tell(buffer))
                }
                else
                    network_send_packet(socket, buffer, buffer_tell(buffer))
                break
            case 11:
                maxmissiles = buffer_read(_buffer, buffer_u16)
                clientID = buffer_read(_buffer, buffer_u8)
                sockets = ds_list_size(playerList)
                buffer_delete(buffer)
                size = 1024
                type = buffer_grow
                alignment = 1
                buffer = buffer_create(size, type, alignment)
                buffer_seek(buffer, buffer_seek_start, 0)
                buffer_write(buffer, buffer_u8, 12)
                buffer_write(buffer, buffer_u16, maxmissiles)
                buffer_write(buffer, buffer_u8, clientID)
                bufferSize = buffer_tell(buffer)
                buffer_seek(buffer, buffer_seek_start, 0)
                buffer_write(buffer, buffer_s32, bufferSize)
                buffer_write(buffer, buffer_u8, 12)
                buffer_write(buffer, buffer_u16, maxmissiles)
                buffer_write(buffer, buffer_u8, clientID)
                if global.itemSync
                {
                    for (i = 0; i < sockets; i++)
                        network_send_packet(ds_list_find_value(playerList, i), buffer, buffer_tell(buffer))
                }
                else
                    network_send_packet(socket, buffer, buffer_tell(buffer))
                break
            case 12:
                maxsmissiles = buffer_read(_buffer, buffer_u8)
                clientID = buffer_read(_buffer, buffer_u8)
                sockets = ds_list_size(playerList)
                buffer_delete(buffer)
                size = 1024
                type = buffer_grow
                alignment = 1
                buffer = buffer_create(size, type, alignment)
                buffer_seek(buffer, buffer_seek_start, 0)
                buffer_write(buffer, buffer_u8, 13)
                buffer_write(buffer, buffer_u8, maxsmissiles)
                buffer_write(buffer, buffer_u8, clientID)
                bufferSize = buffer_tell(buffer)
                buffer_seek(buffer, buffer_seek_start, 0)
                buffer_write(buffer, buffer_s32, bufferSize)
                buffer_write(buffer, buffer_u8, 13)
                buffer_write(buffer, buffer_u8, maxsmissiles)
                buffer_write(buffer, buffer_u8, clientID)
                if global.itemSync
                {
                    for (i = 0; i < sockets; i++)
                        network_send_packet(ds_list_find_value(playerList, i), buffer, buffer_tell(buffer))
                }
                else
                    network_send_packet(socket, buffer, buffer_tell(buffer))
                break
            case 13:
                maxpbombs = buffer_read(_buffer, buffer_u8)
                clientID = buffer_read(_buffer, buffer_u8)
                sockets = ds_list_size(playerList)
                buffer_delete(buffer)
                size = 1024
                type = buffer_grow
                alignment = 1
                buffer = buffer_create(size, type, alignment)
                buffer_seek(buffer, buffer_seek_start, 0)
                buffer_write(buffer, buffer_u8, 14)
                buffer_write(buffer, buffer_u8, maxpbombs)
                buffer_write(buffer, buffer_u8, clientID)
                bufferSize = buffer_tell(buffer)
                buffer_seek(buffer, buffer_seek_start, 0)
                buffer_write(buffer, buffer_s32, bufferSize)
                buffer_write(buffer, buffer_u8, 14)
                buffer_write(buffer, buffer_u8, maxpbombs)
                buffer_write(buffer, buffer_u8, clientID)
                if global.itemSync
                {
                    for (i = 0; i < sockets; i++)
                        network_send_packet(ds_list_find_value(playerList, i), buffer, buffer_tell(buffer))
                }
                else
                    network_send_packet(socket, buffer, buffer_tell(buffer))
                break
            case 14:
                maxhealth = buffer_read(_buffer, buffer_u16)
                clientID = buffer_read(_buffer, buffer_u8)
                sockets = ds_list_size(playerList)
                buffer_delete(buffer)
                size = 1024
                type = buffer_grow
                alignment = 1
                buffer = buffer_create(size, type, alignment)
                buffer_seek(buffer, buffer_seek_start, 0)
                buffer_write(buffer, buffer_u8, 15)
                buffer_write(buffer, buffer_u16, maxhealth)
                buffer_write(buffer, buffer_u8, clientID)
                bufferSize = buffer_tell(buffer)
                buffer_seek(buffer, buffer_seek_start, 0)
                buffer_write(buffer, buffer_s32, bufferSize)
                buffer_write(buffer, buffer_u8, 15)
                buffer_write(buffer, buffer_u16, maxhealth)
                buffer_write(buffer, buffer_u8, clientID)
                if global.itemSync
                {
                    for (i = 0; i < sockets; i++)
                        network_send_packet(ds_list_find_value(playerList, i), buffer, buffer_tell(buffer))
                }
                else
                    network_send_packet(socket, buffer, buffer_tell(buffer))
                break
            case 15:
                etanks = buffer_read(_buffer, buffer_u8)
                clientID = buffer_read(_buffer, buffer_u8)
                sockets = ds_list_size(playerList)
                buffer_delete(buffer)
                size = 1024
                type = buffer_grow
                alignment = 1
                buffer = buffer_create(size, type, alignment)
                buffer_seek(buffer, buffer_seek_start, 0)
                buffer_write(buffer, buffer_u8, 16)
                buffer_write(buffer, buffer_u8, etanks)
                buffer_write(buffer, buffer_u8, clientID)
                bufferSize = buffer_tell(buffer)
                buffer_seek(buffer, buffer_seek_start, 0)
                buffer_write(buffer, buffer_s32, bufferSize)
                buffer_write(buffer, buffer_u8, 16)
                buffer_write(buffer, buffer_u8, etanks)
                buffer_write(buffer, buffer_u8, clientID)
                if global.itemSync
                {
                    for (i = 0; i < sockets; i++)
                        network_send_packet(ds_list_find_value(playerList, i), buffer, buffer_tell(buffer))
                }
                else
                    network_send_packet(socket, buffer, buffer_tell(buffer))
                break
            case 16:
                mtanks = buffer_read(_buffer, buffer_u8)
                clientID = buffer_read(_buffer, buffer_u8)
                sockets = ds_list_size(playerList)
                buffer_delete(buffer)
                size = 1024
                type = buffer_grow
                alignment = 1
                buffer = buffer_create(size, type, alignment)
                buffer_seek(buffer, buffer_seek_start, 0)
                buffer_write(buffer, buffer_u8, 17)
                buffer_write(buffer, buffer_u8, mtanks)
                buffer_write(buffer, buffer_u8, clientID)
                bufferSize = buffer_tell(buffer)
                buffer_seek(buffer, buffer_seek_start, 0)
                buffer_write(buffer, buffer_s32, bufferSize)
                buffer_write(buffer, buffer_u8, 17)
                buffer_write(buffer, buffer_u8, mtanks)
                buffer_write(buffer, buffer_u8, clientID)
                if global.itemSync
                {
                    for (i = 0; i < sockets; i++)
                        network_send_packet(ds_list_find_value(playerList, i), buffer, buffer_tell(buffer))
                }
                else
                    network_send_packet(socket, buffer, buffer_tell(buffer))
                break
            case 17:
                stanks = buffer_read(_buffer, buffer_u8)
                clientID = buffer_read(_buffer, buffer_u8)
                sockets = ds_list_size(playerList)
                buffer_delete(buffer)
                size = 1024
                type = buffer_grow
                alignment = 1
                buffer = buffer_create(size, type, alignment)
                buffer_seek(buffer, buffer_seek_start, 0)
                buffer_write(buffer, buffer_u8, 18)
                buffer_write(buffer, buffer_u8, stanks)
                buffer_write(buffer, buffer_u8, clientID)
                bufferSize = buffer_tell(buffer)
                buffer_seek(buffer, buffer_seek_start, 0)
                buffer_write(buffer, buffer_s32, bufferSize)
                buffer_write(buffer, buffer_u8, 18)
                buffer_write(buffer, buffer_u8, stanks)
                buffer_write(buffer, buffer_u8, clientID)
                if global.itemSync
                {
                    for (i = 0; i < sockets; i++)
                        network_send_packet(ds_list_find_value(playerList, i), buffer, buffer_tell(buffer))
                }
                else
                    network_send_packet(socket, buffer, buffer_tell(buffer))
                break
            case 18:
                ptanks = buffer_read(_buffer, buffer_u8)
                clientID = buffer_read(_buffer, buffer_u8)
                sockets = ds_list_size(playerList)
                buffer_delete(buffer)
                size = 1024
                type = buffer_grow
                alignment = 1
                buffer = buffer_create(size, type, alignment)
                buffer_seek(buffer, buffer_seek_start, 0)
                buffer_write(buffer, buffer_u8, 19)
                buffer_write(buffer, buffer_u8, ptanks)
                buffer_write(buffer, buffer_u8, clientID)
                bufferSize = buffer_tell(buffer)
                buffer_seek(buffer, buffer_seek_start, 0)
                buffer_write(buffer, buffer_s32, bufferSize)
                buffer_write(buffer, buffer_u8, 19)
                buffer_write(buffer, buffer_u8, ptanks)
                buffer_write(buffer, buffer_u8, clientID)
                if global.itemSync
                {
                    for (i = 0; i < sockets; i++)
                        network_send_packet(ds_list_find_value(playerList, i), buffer, buffer_tell(buffer))
                }
                else
                    network_send_packet(socket, buffer, buffer_tell(buffer))
                break
            case 19:
                gametime = buffer_read(_buffer, buffer_s32)
                clientID = buffer_read(_buffer, buffer_u8)
                if (ds_list_size(timeList) > 0)
                {
                    findTime = ds_list_find_index(timeList, gametime)
                    if (findTime == -1)
                        ds_list_add(timeList, gametime)
                }
                else
                    ds_list_add(timeList, gametime)
                break
            case 20:
                clientID = buffer_read(_buffer, buffer_u8)
                if (ds_list_size(resetList) > 0)
                {
                    findReset = ds_list_find_index(resetList, clientID)
                    if (findReset == -1)
                        ds_list_add(resetList, clientID)
                }
                else
                    ds_list_add(resetList, clientID)
                break
            case 21:
                clientID = buffer_read(_buffer, buffer_u8)
                dir = buffer_read(_buffer, buffer_s16)
                sprX = buffer_read(_buffer, buffer_s16)
                sprY = buffer_read(_buffer, buffer_s16)
                charge = buffer_read(_buffer, buffer_u8)
                sockets = ds_list_size(playerList)
                buffer_delete(buffer)
                size = 1024
                type = buffer_grow
                alignment = 1
                buffer = buffer_create(size, type, alignment)
                buffer_seek(buffer, buffer_seek_start, 0)
                buffer_write(buffer, buffer_u8, 21)
                buffer_write(buffer, buffer_u8, clientID)
                buffer_write(buffer, buffer_s16, dir)
                buffer_write(buffer, buffer_s16, sprX)
                buffer_write(buffer, buffer_s16, sprY)
                buffer_write(buffer, buffer_u8, charge)
                bufferSize = buffer_tell(buffer)
                buffer_seek(buffer, buffer_seek_start, 0)
                buffer_write(buffer, buffer_s32, bufferSize)
                buffer_write(buffer, buffer_u8, 21)
                buffer_write(buffer, buffer_u8, clientID)
                buffer_write(buffer, buffer_s16, dir)
                buffer_write(buffer, buffer_s16, sprX)
                buffer_write(buffer, buffer_s16, sprY)
                buffer_write(buffer, buffer_u8, charge)
                for (i = 0; i < sockets; i++)
                    network_send_packet(ds_list_find_value(playerList, i), buffer, buffer_tell(buffer))
                break
            case 23:
                clientID = buffer_read(_buffer, buffer_u8)
                currentWeapon = buffer_read(_buffer, buffer_u8)
                dir = buffer_read(_buffer, buffer_s16)
                missileX = buffer_read(_buffer, buffer_s16)
                missileY = buffer_read(_buffer, buffer_s16)
                sockets = ds_list_size(playerList)
                buffer_delete(buffer)
                size = 1024
                type = buffer_grow
                alignment = 1
                buffer = buffer_create(size, type, alignment)
                buffer_seek(buffer, buffer_seek_start, 0)
                buffer_write(buffer, buffer_u8, 23)
                buffer_write(buffer, buffer_u8, clientID)
                buffer_write(buffer, buffer_u8, currentWeapon)
                buffer_write(buffer, buffer_s16, dir)
                buffer_write(buffer, buffer_s16, missileX)
                buffer_write(buffer, buffer_s16, missileY)
                bufferSize = buffer_tell(buffer)
                buffer_seek(buffer, buffer_seek_start, 0)
                buffer_write(buffer, buffer_s32, bufferSize)
                buffer_write(buffer, buffer_u8, 23)
                buffer_write(buffer, buffer_u8, clientID)
                buffer_write(buffer, buffer_u8, currentWeapon)
                buffer_write(buffer, buffer_s16, dir)
                buffer_write(buffer, buffer_s16, missileX)
                buffer_write(buffer, buffer_s16, missileY)
                for (i = 0; i < sockets; i++)
                    network_send_packet(ds_list_find_value(playerList, i), buffer, buffer_tell(buffer))
                break
            case 25:
                playerhealth = buffer_read(_buffer, buffer_s16)
                clientID = buffer_read(_buffer, buffer_u8)
                sockets = ds_list_size(playerList)
                buffer_delete(buffer)
                size = 1024
                type = buffer_grow
                alignment = 1
                buffer = buffer_create(size, type, alignment)
                buffer_seek(buffer, buffer_seek_start, 0)
                buffer_write(buffer, buffer_u8, 25)
                buffer_write(buffer, buffer_s16, playerhealth)
                buffer_write(buffer, buffer_u8, clientID)
                bufferSize = buffer_tell(buffer)
                buffer_seek(buffer, buffer_seek_start, 0)
                buffer_write(buffer, buffer_s32, bufferSize)
                buffer_write(buffer, buffer_u8, 25)
                buffer_write(buffer, buffer_s16, playerhealth)
                buffer_write(buffer, buffer_u8, clientID)
                if global.healthSync
                {
                    for (i = 0; i < sockets; i++)
                        network_send_packet(ds_list_find_value(playerList, i), buffer, buffer_tell(buffer))
                }
                else
                    network_send_packet(socket, buffer, buffer_tell(buffer))
                break
            case 26:
                missiles = buffer_read(_buffer, buffer_s16)
                clientID = buffer_read(_buffer, buffer_u8)
                sockets = ds_list_size(playerList)
                buffer_delete(buffer)
                size = 1024
                type = buffer_grow
                alignment = 1
                buffer = buffer_create(size, type, alignment)
                buffer_seek(buffer, buffer_seek_start, 0)
                buffer_write(buffer, buffer_u8, 26)
                buffer_write(buffer, buffer_s16, missiles)
                buffer_write(buffer, buffer_u8, clientID)
                bufferSize = buffer_tell(buffer)
                buffer_seek(buffer, buffer_seek_start, 0)
                buffer_write(buffer, buffer_s32, bufferSize)
                buffer_write(buffer, buffer_u8, 26)
                buffer_write(buffer, buffer_s16, missiles)
                buffer_write(buffer, buffer_u8, clientID)
                if global.ammoSync
                {
                    for (i = 0; i < sockets; i++)
                        network_send_packet(ds_list_find_value(playerList, i), buffer, buffer_tell(buffer))
                }
                else
                    network_send_packet(socket, buffer, buffer_tell(buffer))
                break
            case 27:
                smissiles = buffer_read(_buffer, buffer_s16)
                clientID = buffer_read(_buffer, buffer_u8)
                sockets = ds_list_size(playerList)
                buffer_delete(buffer)
                size = 1024
                type = buffer_grow
                alignment = 1
                buffer = buffer_create(size, type, alignment)
                buffer_seek(buffer, buffer_seek_start, 0)
                buffer_write(buffer, buffer_u8, 27)
                buffer_write(buffer, buffer_s16, smissiles)
                buffer_write(buffer, buffer_u8, clientID)
                bufferSize = buffer_tell(buffer)
                buffer_seek(buffer, buffer_seek_start, 0)
                buffer_write(buffer, buffer_s32, bufferSize)
                buffer_write(buffer, buffer_u8, 27)
                buffer_write(buffer, buffer_s16, smissiles)
                buffer_write(buffer, buffer_u8, clientID)
                if global.ammoSync
                {
                    for (i = 0; i < sockets; i++)
                        network_send_packet(ds_list_find_value(playerList, i), buffer, buffer_tell(buffer))
                }
                else
                    network_send_packet(socket, buffer, buffer_tell(buffer))
                break
            case 28:
                pbombs = buffer_read(_buffer, buffer_s16)
                clientID = buffer_read(_buffer, buffer_u8)
                sockets = ds_list_size(playerList)
                buffer_delete(buffer)
                size = 1024
                type = buffer_grow
                alignment = 1
                buffer = buffer_create(size, type, alignment)
                buffer_seek(buffer, buffer_seek_start, 0)
                buffer_write(buffer, buffer_u8, 28)
                buffer_write(buffer, buffer_s16, pbombs)
                buffer_write(buffer, buffer_u8, clientID)
                bufferSize = buffer_tell(buffer)
                buffer_seek(buffer, buffer_seek_start, 0)
                buffer_write(buffer, buffer_s32, bufferSize)
                buffer_write(buffer, buffer_u8, 28)
                buffer_write(buffer, buffer_s16, pbombs)
                buffer_write(buffer, buffer_u8, clientID)
                if global.ammoSync
                {
                    for (i = 0; i < sockets; i++)
                        network_send_packet(ds_list_find_value(playerList, i), buffer, buffer_tell(buffer))
                }
                else
                    network_send_packet(socket, buffer, buffer_tell(buffer))
                break
            case 29:
                syncDiff = buffer_read(_buffer, buffer_u8)
                sockets = ds_list_size(playerList)
                if (syncedDifficulty != syncDiff)
                    syncedDifficulty = syncDiff
                buffer_delete(buffer)
                size = 1024
                type = buffer_grow
                alignment = 1
                buffer = buffer_create(size, type, alignment)
                buffer_seek(buffer, buffer_seek_start, 0)
                buffer_write(buffer, buffer_u8, 29)
                buffer_write(buffer, buffer_u8, syncDiff)
                bufferSize = buffer_tell(buffer)
                buffer_seek(buffer, buffer_seek_start, 0)
                buffer_write(buffer, buffer_s32, bufferSize)
                buffer_write(buffer, buffer_u8, 29)
                buffer_write(buffer, buffer_u8, syncDiff)
                for (i = 0; i < sockets; i++)
                    network_send_packet(ds_list_find_value(playerList, i), buffer, buffer_tell(buffer))
                break
            case 30:
                syncELM = buffer_read(_buffer, buffer_u8)
                sockets = ds_list_size(playerList)
                if (syncedELM != syncELM)
                    syncedELM = syncELM
                buffer_delete(buffer)
                size = 1024
                type = buffer_grow
                alignment = 1
                buffer = buffer_create(size, type, alignment)
                buffer_seek(buffer, buffer_seek_start, 0)
                buffer_write(buffer, buffer_u8, 30)
                buffer_write(buffer, buffer_u8, syncELM)
                bufferSize = buffer_tell(buffer)
                buffer_seek(buffer, buffer_seek_start, 0)
                buffer_write(buffer, buffer_s32, bufferSize)
                buffer_write(buffer, buffer_u8, 30)
                buffer_write(buffer, buffer_u8, syncELM)
                for (i = 0; i < sockets; i++)
                    network_send_packet(ds_list_find_value(playerList, i), buffer, buffer_tell(buffer))
                break
            case 50:
                if (bufferSize < 350)
                    exit
                show_debug_message("item")
                for (i = 0; i < array_length_1d(global.item); i++)
                {
                    receivedItem = buffer_read(_buffer, buffer_u8)
                    if (receivedItem == 1 && global.item[i] == 0)
                        global.item[i] = receivedItem
                }
                alarm[2] = 30
                break
            case 51:
                if (bufferSize < 400)
                    exit
                show_debug_message("event")
                for (i = 0; i < array_length_1d(global.event); i++)
                {
                    if (i < 350)
                    {
                        receivedEvent = buffer_read(_buffer, buffer_u8)
                        if (floor(receivedEvent) > floor(global.event[i]))
                            global.event[i] = receivedEvent
                    }
                }
                alarm[2] = 30
                break
            case 52:
                if (bufferSize < 100)
                    exit
                show_debug_message("metdead")
                for (i = 0; i < array_length_1d(global.metdead); i++)
                {
                    receivedMetdead = buffer_read(_buffer, buffer_u8)
                    if (receivedMetdead > global.metdead[i])
                        global.metdead[i] = receivedMetdead
                }
                alarm[2] = 30
                break
            case 53:
                if (bufferSize < 9216)
                    exit
                show_debug_message("dmap")
                for (i = 0; i < array_height_2d(global.dmap); i++)
                {
                    for (j = 0; j < array_length_2d(global.dmap, i); j++)
                    {
                        receiveddmap = buffer_read(_buffer, buffer_u8)
                        if (receiveddmap > global.dmap[i, j])
                            global.dmap[i, j] = receiveddmap
                        else if (receiveddmap == 1 && global.dmap[i, j])
                            global.dmap[i, j] = receiveddmap
                    }
                }
                alarm[5] = 30
                break
        }

        break
}

