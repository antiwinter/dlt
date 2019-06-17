DLT_SCMD = '/dlt'
DLT_CurSpeaker = ''
DLT_Focus = ''
DLT_OnCombatLog = true
DLT_MsgPieceLen = 200
DLT_MsgLim = 3

BL_SEND = {
    ['0'] = 'a',
    ['1'] = 'c',
    ['2'] = 'i',
    ['3'] = 'm',
    ['4'] = 'l',
    ['5'] = 'ab',
    ['6'] = 'ag',
    ['7'] = 'bw',
    ['8'] = 'AB',
    ['9'] = 'AG',
    ['A'] = 'bo',
    ['B'] = 'ch',
    ['C'] = 'bf',
    ['D'] = 'BO',
    ['E'] = 'CH',
    ['F'] = 'BF'
}
function DLT_lmHear(a)
    if a == 'G' then
        return '0'
    elseif a == 'O' then
        return '1'
    elseif a == 'L' then
        return '2'
    elseif a == 'A' then
        return '3'
    elseif a == 'N' then
        return '4'
    elseif a == 'Ha' then
        return '5'
    elseif a == 'Gi' then
        return '6'
    elseif a == 'Mu' then
        return '7'
    elseif a == 'HA' then
        return '8'
    elseif a == 'GI' then
        return '9'
    elseif a == 'Ka' then
        return 'A'
    elseif a == 'No' then
        return 'B'
    elseif a == 'Ko' then
        return 'C'
    elseif a == 'KA' then
        return 'D'
    elseif a == 'NO' then
        return 'E'
    elseif a == 'KO' then
        return 'F'
    else
        return '0'
    end
end

function DLT_blHear(a)
    if a == 'Y' then
        return '0'
    elseif a == 'O' then
        return '1'
    elseif a == 'U' then
        return '2'
    elseif a == 'E' then
        return '3'
    elseif a == 'Ti' then
        return '4'
    elseif a == 'Me' then
        return '5'
    elseif a == 'TI' then
        return '6'
    elseif a == 'ME' then
        return '7'
    elseif a == 'Lo' then
        return '8'
    elseif a == 'Ve' then
        return '9'
    elseif a == 'An' then
        return 'A'
    elseif a == 'Se' then
        return 'B'
    elseif a == 'LO' then
        return 'C'
    elseif a == 'VE' then
        return 'D'
    elseif a == 'AN' then
        return 'E'
    elseif a == 'SE' then
        return 'F'
    else
        return '0'
    end
end

LM_SEND = {
    ['0'] = 'e',
    ['1'] = 'a',
    ['2'] = 'p',
    ['3'] = 'z',
    ['4'] = 'ba',
    ['5'] = 'ag',
    ['6'] = 'BA',
    ['7'] = 'AG',
    ['8'] = 'ac',
    ['9'] = 'am',
    ['A'] = 'ao',
    ['B'] = 'ap',
    ['C'] = 'AC',
    ['D'] = 'AM',
    ['E'] = 'AO',
    ['F'] = 'AP'
}

HEX_DEC = {
    ['0'] = 0,
    ['1'] = 1,
    ['2'] = 2,
    ['3'] = 3,
    ['4'] = 4,
    ['5'] = 5,
    ['6'] = 6,
    ['7'] = 7,
    ['8'] = 8,
    ['9'] = 9,
    ['A'] = 10,
    ['B'] = 11,
    ['C'] = 12,
    ['D'] = 13,
    ['E'] = 14,
    ['F'] = 15
}

DEC_HEX = {
    [0] = '0',
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    'A',
    'B',
    'C',
    'D',
    'E',
    'F'
}

function DLT_HexToDec(hs)
    local num
    num = HEX_DEC[string.sub(hs, 1, 1)] * 16 + HEX_DEC[string.sub(hs, 2, 2)]
    return num
end

function DLT_DecToHex(num)
    if num > 255 then return 'FF' end
    local lost = 0
    while num > 15 do
        num = num - 16
        lost = lost + 1
    end
    return DEC_HEX[lost] .. DEC_HEX[num]
end

DLT_BeginQueue = {
    str = '##',
    Push = function(self, a)
        self.str = self.str .. a
        if string.len(self.str) > 2 then
            self.str = string.sub(self.str, -2, -1)
        else
            self.str = self.str .. a
        end
    end
}

function DLT_BeginQueue:Refresh() self.str = '##' end

DLT_EndQueue = {
    str = '##',
    Push = function(self, a)
        self.str = self.str .. a
        if string.len(self.str) > 2 then
            self.str = string.sub(self.str, -2, -1)
        else
            self.str = self.str .. a
        end
    end
}

function DLT_EndQueue:Refresh() self.str = '##' end

DLT_Sentence = {str = ''}

function DLT_Sentence:Push(a) self.str = self.str .. a end

function DLT_Sentence:Clear() self.str = '' end

function DLT_Sentence:OutPut()
    if string.len(self.str) > 2 then
        local s = string.sub(self.str, 1, -3)
        ChatFrame1:AddMessage(
            '|c0000FF00[DLT] |r|c002571E2[' .. DLT_CurSpeaker .. '] ' .. DLT_SAY ..
                ' ' .. s .. '|r')
        if DLT_OnCombatLog then
            ChatFrame2:AddMessage('|c0000FF00[DLT] |r|c002571E2[' ..
                                      DLT_CurSpeaker .. '] ' .. DLT_SAY .. ' ' ..
                                      s .. '|r')
        end
        if (s == 'hi' or s == 'HI' or s == 'Hi') then
            DLT_SendMessage('yes?')
        end
    end
end

function DLT_OnLoad()
    DLTF = CreateFrame('Frame', 'DLTFRM')
    DLTF:SetScript('OnEvent', DLT_OnEvent)
    DLTF:RegisterEvent('CHAT_MSG_SAY')
    PreChatFrame_OnEvent = ChatFrame_OnEvent
    ChatFrame_OnEvent = test_OnEvent

    SlashCmdList['DLT'] = DLT_CommandCtrl
    SLASH_DLT1 = DLT_SCMD
    -- DLT_DEFAULTLANGUAGE=GetDefaultLanguage("player");
    DLT_WarnMsg(DLT_WELCOME)
end

function test_OnEvent()
    -- Recgonize�����ֿ��������ˡ���
    if (event == 'CHAT_MSG_SAY') then
        if (DLT_Recgonize(arg1, 'sd') or DLT_Recgonize(arg1, 'rc')) then
            -- ChatFrame1:AddMessage("IS DLT");
            return
        end
    end

    PreChatFrame_OnEvent(event)
end

function DLT_CommandCtrl(cmd)
    if cmd == '' or cmd == nil then
        DLT_WarnMsg(DLT_CMD_LIST)
        DLT_WarnMsg(' /dlt onclog   ' .. DLT_onclog)
        DLT_WarnMsg(' /dlt reset   ' .. DLT_reset)
        DLT_WarnMsg(' /dlt hi   ' .. DLT_hi)
    elseif cmd == 'onclog' then
        DLT_OnCombatLog = not DLT_OnCombatLog
        if DLT_OnCombatLog then
            DLT_WarnMsg(DLT_onclog_true)
        else
            DLT_WarnMsg(DLT_onclog_false)
        end
    elseif cmd == 'reset' then
        DLT_BeginQueue:Refresh()
        DLT_EndQueue:Refresh()
        DLT_Sentence:Clear()
        DLT_ToChar:Reset()
        DLT_CharReceiver:Reset()

        DLT_WarnMsg(DLT_reset_info)
    else
        DLT_SendMessage(cmd)
    end
end
function DLT_Normalize(msg)
    if not msg then return false end

    while string.sub(msg, 1, 1) == ' ' do
        if string.len(msg) == 1 then return false end
        msg = string.sub(msg, 2, -1)
    end

    local i = 1
    while i < string.len(msg) do
        if string.sub(msg, i, i) == ' ' then
            while (i < string.len(msg) and string.sub(msg, i + 1, i + 1) == ' ') do
                if string.len(msg) == i + 1 then
                    msg = string.sub(msg, 1, i)
                else
                    msg = string.sub(msg, 1, i) .. string.sub(msg, i + 2, -1)
                end
            end
        end
        i = i + 1
    end
    return msg
end

function DLT_Recgonize(msg, tp)
    if (not msg) then return end
    msg = DLT_Normalize(msg)
    local lt = string.len(msg)
    local l = GetDefaultLanguage('player')
    if tp == 'rc' then
        if l == DLT_LM_DEF_LG then
            if lt < 10 then return false end
            if (string.sub(msg, 1, 5) == 'L HA ' and string.sub(msg, -5, -1) ==
                'L GI ') then return true end
        elseif l == DLT_BL_DEF_LG then
            if lt < 10 then return false end
            if (string.sub(msg, 1, 5) == 'U Lo ' and string.sub(msg, -5, -1) ==
                'U Ve ') then return true end
        end
    elseif tp == 'sd' then
        if l == DLT_LM_DEF_LG then
            if lt < 10 then return false end
            if (string.sub(msg, 1, 5) == 'p ac ' and string.sub(msg, -5, -1) ==
                'p am ') then return true end
        elseif l == DLT_BL_DEF_LG then
            if lt < 10 then return false end
            if (string.sub(msg, 1, 5) == 'i AB ' and string.sub(msg, -5, -1) ==
                'i AG ') then return true end
        end
    end
    return false
end

function DLT_SecurityCheck(msg)
    if not msg then return end
    msg = DLT_Normalize(msg)
    local lt = string.len(msg)
    local l = GetDefaultLanguage('player')
    if l == DLT_LM_DEF_LG then
        if lt < 10 then return false end
        -- ChatFrame1:AddMessage(string.sub(msg,1,5).."**"..string.sub(msg,-5,-1).."**")

        -- �鿴Ϊʲô�����Ҳ���"L HA"�أ�ԭ�����˸��ո�...�ΰ�
        --[[if string.find(string.sub(msg,1,5),"L HA") then
			
			ChatFrame1:AddMessage("Find.") 
		else 
			ChatFrame1:AddMessage("Can't Find L HA")
		end]]
        if (string.find(string.sub(msg, 1, 5), 'L HA') and
            string.find(string.sub(msg, -5, -1), 'L GI')) then
            return string.sub(msg, 6, -6)
        end
    elseif l == DLT_BL_DEF_LG then
        if lt < 10 then return false end
        -- ChatFrame1:AddMessage(string.sub(msg,1,5).."**"..string.sub(msg,-5,-1).."**")
        --[[if string.find(string.sub(msg,1,5),"U Lo") then
			ChatFrame1:AddMessage("Find.") 
		else 
			ChatFrame1:AddMessage("Can't Find U Lo")
		end]]
        if (string.find(string.sub(msg, 1, 5), 'U Lo') and
            string.find(string.sub(msg, -5, -1), 'U Ve')) then
            return string.sub(msg, 6, -6)
        end
    end
    return false
end

function DLT_OnEvent()
    if event == 'CHAT_MSG_SAY' then
        --[[local l=string.len(arg1)
		local i
		for i=1,l do ChatFrame1:AddMessage(string.sub(arg1,i,i).."**"); end;]]
        -- ChatFrame1:AddMessage(arg1);
        if (DLT_CurSpeaker ~= '' and arg2 ~= DLT_CurSpeaker) then return end
        local rmsg = DLT_SecurityCheck(arg1)
        --[[if rmsg then ChatFrame1:AddMessage("Security Check Pass.")
		else ChatFrame1:AddMessage("Security Check Failed.")
		end]]
        if rmsg then
            local StrToPush = ''
            local i, s
            for i = 1, string.len(rmsg) do
                s = string.sub(rmsg, i, i)
                if (s == ' ') then
                    if StrToPush ~= '' then
                        -- ChatFrame1:AddMessage(StrToPush)
                        DLT_ToChar:Push(StrToPush, arg2)
                        StrToPush = ''
                    end
                else
                    StrToPush = StrToPush .. s
                end
            end
        end
        -- if (DLT_SecurityCheck(arg1,DLT_LM_DEF_LG) or DLT_SecurityCheck(arg1,DLT_BL_DEF_LG)) then
        --	return
        -- else
        --	PreChatFrame_OnEvent(event);
        -- end
    end
end

DLT_ToChar = {
    DB = '',
    Push = function(self, a, name)
        if GetDefaultLanguage('player') == DLT_LM_DEF_LG then
            self.DB = self.DB .. DLT_lmHear(a)
        elseif GetDefaultLanguage('player') == DLT_BL_DEF_LG then
            self.DB = self.DB .. DLT_blHear(a)
        end
        if string.len(self.DB) > 1 then
            DLT_CharReceiver:Push(string.char(DLT_HexToDec(self.DB)), name)
            -- ChatFrame1:AddMessage(string.char(DLT_HexToDec(self.DB)))
            self.DB = ''
        end
    end
}

function DLT_ToChar:Reset() self.DB = '' end

DLT_CharReceiver = {
    ToSentence = 0,
    Push = function(self, a, name)
        if self.ToSentence == 0 then
            DLT_BeginQueue:Push(a)
            if DLT_BeginQueue.str == '$D' then
                DLT_BeginQueue:Refresh()
                self.ToSentence = 1
                DLT_CurSpeaker = name
                DLT_Sentence:Clear()
            end
        else
            DLT_Sentence:Push(a)
            DLT_EndQueue:Push(a)
            if DLT_EndQueue.str == '\\D' then
                DLT_Sentence:OutPut()
                DLT_Sentence:Clear()
                DLT_CurSpeaker = ''
                self.ToSentence = 0
                DLT_EndQueue:Refresh()
            end
        end
    end
}

function DLT_CharReceiver:Reset() self.ToSentence = 0 end

function DLT_MsgConverter(s)
    local i, ds, ascds, hexds, ToSendStr
    ToSendStr = ''
    for i = 1, string.len(s) do
        ds = string.sub(s, i, i)
        ascds = string.byte(ds)
        hexds = DLT_DecToHex(ascds)
        if GetDefaultLanguage('player') == DLT_LM_DEF_LG then
            -- SendChatMessage(ToSendStr,"say");
            ToSendStr = ToSendStr .. LM_SEND[string.sub(hexds, 1, 1)] .. ' ' ..
                            LM_SEND[string.sub(hexds, 2, 2)] .. ' '
        elseif GetDefaultLanguage('player') == DLT_BL_DEF_LG then
            ToSendStr = ToSendStr .. BL_SEND[string.sub(hexds, 1, 1)] .. ' ' ..
                            BL_SEND[string.sub(hexds, 2, 2)] .. ' '
        end
    end

    return ToSendStr
end

function DLT_MsgTakeFirst(msg)
    local i
    local ststr = {}
    l = string.len(msg)
    if l <= DLT_MsgPieceLen then
        return msg, ''
    else
        for i = 1, l do
            if (i > DLT_MsgPieceLen - 5 and string.sub(msg, i, i) == ' ') then
                return string.sub(msg, 1, i), string.sub(msg, i + 1, -1)
            end
        end
    end
end

function DLT_MsgSplit(msg, n)
    local amount, str1, str2
    local ststr = {}
    amount = 0
    str2 = msg
    repeat
        str1, str2 = DLT_MsgTakeFirst(str2)
        amount = amount + 1
        ststr[amount] = str1
    until (str2 == '')

    if n <= amount then
        return DLT_MsgConverter('(') .. ststr[n] .. DLT_MsgConverter(')')
    else
        return false
    end
end

function DLT_SendMessage(msg)
    local StrToSend = DLT_MsgConverter('$D' .. msg .. '\\D')
    local l = string.len(StrToSend)
    local lg = GetDefaultLanguage('player')
    if l > DLT_MsgPieceLen * DLT_MsgLim then
        DLT_WarnMsg(DLT_WARN_WORDS_OVERFLOW)
        return
    else
        local n = 1
        while (DLT_MsgSplit(StrToSend, n)) do
            SendChatMessage(DLT_MsgSplit(StrToSend, n), 'say', lg)
            n = n + 1
        end
    end

    DLT_WarnMsg(DLT_YOU_SAY .. msg)
end

function DLT_WarnMsg(msg)
    ChatFrame1:AddMessage('|c0000FF00[DLT]|r |c002571E2' .. msg .. '|r')
    if DLT_OnCombatLog then
        ChatFrame2:AddMessage('|c0000FF00[DLT]|r |c002571E2' .. msg .. '|r')
    end
end
