unit SoundUtil;

interface

uses
  SysUtils, Classes, Bass, HGESounds, 
  Grobal2, HUtil32, WMFile, WIL;

type
  TBGMState = (bgmPlay, bgmStop, bgmPause);

var
  CurVolume: integer;
  MusicStream: TMemoryStream;
  MusicHS: HSTREAM;

procedure LoadSoundList(flname: string);
procedure LoadBGMusicList(flname: string);
procedure InitializeSound();
procedure PlaySound(idx: integer);
procedure PlaySoundEx(wavname: string); overload;
procedure PlaySoundEx(idx: integer); overload;
procedure PlayBGM(wavname: string); overload;
procedure PlayBGM(idx: integer); overload;
procedure ChangeBGMState(BGMState: TBGMState);
procedure ClearBGM();
procedure ClearBGMEx();
//procedure PlayMp3(wavname: string; boFlag: Boolean; boBGSound: Boolean = False);
procedure SilenceSound;
procedure ItemClickSound(std: TStdItem);
procedure ItemUseSound(stdmode: TStdMode);
procedure PlayMapMusic(boFlag: Boolean);

type
  SoundInfo = record
    Idx: integer;
    Name: string;
  end;

const
  //bmg_intro = 'wav\log-in-long2.wav';
  //bmg_select = 'wav\sellect-loop2.wav';
  //bmg_field = 'wav\Field2.wav';
  //bmg_gameover = 'wav\game over2.wav';
  bmg_Login = 50;
  bmg_SelChr = 50;
  bmg_enter = 53;
  bmg_LoginDoor = 50;
  bmg_Alive = 60;
  bmg_Camera = 61;
  bmg_Repair = 62;
  bmg_NewEMail = 63;
  bmg_intro = 'wav\Log-in-long2.wav';
  bmg_select = 'wav\sellect-loop2.wav';
  bmg_field = 'wav\Field2.wav';
  bmg_gameover = 'wav\game over2.wav';
  bmg_HeroLogin = 'wav\HeroLogin.wav';
  bmg_HeroLogout = 'wav\HeroLogout.wav';
  bmg_newysound = 'wav\newysound-mix.wav';
  bmg_Openbox = 'wav\Openbox.wav';
  bmg_SelectBoxFlash = 'wav\SelectBoxFlash.wav';
  bmg_Field2 = 'wav\Field2.wav';
  bmg_splitshadow = 'wav\splitshadow.wav'; //分身
  bmg_longswordhit = 'wav\longsword-hit.wav'; //开天斩
  bmg_heroshield = 'wav\hero-shield.wav'; //护体神盾
  bmg_powerup = 'wav\powerup.wav'; //人物升级
  bmg_LONGFIREHITMan = 'wav\M56-0.wav';
  bmg_LONGFIREHITwoMan = 'wav\M56-3.wav';
  bmg_SKILL_74_0 = 'wav\M58-0.wav';
  bmg_SKILL_74_3 = 'wav\M58-3.wav';
  bmg_SKILL_48_0 = 'wav\M57-0.wav';
  bmg_warpower_up = 'wav\warpower-up.wav';
  bmg_ItemLevel = 54;
  bmg_ItemLevel_OK = 55;
  bmg_ItemLevel_Fail = 'wav\M100-2.wav';
  bmg_cboZs1_start_m = 'wav\cboZs1_start_m.wav';
  bmg_cboZs1_start_w = 'wav\cboZs1_start_w.wav';
  bmg_cboZs2_start = 'wav\cboZs2_start.wav';
  bmg_cboZs3_start_m = 'wav\cboZs3_start_m.wav';
  bmg_cboZs3_start_w = 'wav\cboZs3_start_w.wav';
  bmg_cboZs4_start = 'wav\cboZs4_start.wav';
  bmp_warpower_up = 'wav\warpower-up.wav';

  s_walk_ground_l = 1;
  s_walk_ground_r = 2;
  s_run_ground_l = 3;
  s_run_ground_r = 4;
  s_walk_stone_l = 5;
  s_walk_stone_r = 6;
  s_run_stone_l = 7;
  s_run_stone_r = 8;
  s_walk_lawn_l = 9;
  s_walk_lawn_r = 10;
  s_run_lawn_l = 11;
  s_run_lawn_r = 12;
  s_walk_rough_l = 13;
  s_walk_rough_r = 14;
  s_run_rough_l = 15;
  s_run_rough_r = 16;
  s_walk_wood_l = 17;
  s_walk_wood_r = 18;
  s_run_wood_l = 19;
  s_run_wood_r = 20;
  s_walk_cave_l = 21;
  s_walk_cave_r = 22;
  s_run_cave_l = 23;
  s_run_cave_r = 24;
  s_walk_room_l = 25;
  s_walk_room_r = 26;
  s_run_room_l = 27;
  s_run_room_r = 28;
  s_walk_water_l = 29;
  s_walk_water_r = 30;
  s_run_water_l = 31;
  s_run_water_r = 32;
  s_horsewalk = 10000056;
  //s_horserun = 10000004;


  s_hit_short = 50;
  s_hit_wooden = 51;
  s_hit_sword = 52;
  s_hit_do = 53;
  s_hit_axe = 54;
  s_hit_club = 55;
  s_hit_long = 56;
  s_hit_fist = 57;

  s_struck_short = 60;
  s_struck_wooden = 61;
  s_struck_sword = 62;
  s_struck_do = 63;
  s_struck_axe = 64;
  s_struck_club = 65;

  s_struck_body_sword = 70;
  s_struck_body_axe = 71;
  s_struck_body_longstick = 72;
  s_struck_body_fist = 73;

  s_struck_armor_sword = 80;
  s_struck_armor_axe = 81;
  s_struck_armor_longstick = 82;
  s_struck_armor_fist = 83;

  //s_powerup_man         = 80;
  //s_powerup_woman       = 81;
  //s_die_man             = 82;
  //s_die_woman           = 83;
  //s_struck_man          = 84;
  //s_struck_woman        = 85;
  //s_firehit             = 86;

  //s_struck_magic        = 90;
  s_strike_stone = 91;
  s_drop_stonepiece = 92;

  s_rock_door_open = 100;
  s_intro_theme = 102;
  s_meltstone = 101;
  s_main_theme = 102;
  s_norm_button_click = 103;
  s_rock_button_click = 104;
  s_glass_button_click = 105;
  s_money = 106;
  s_eat_drug = 107;
  s_click_drug = 108;
  s_spacemove_out = 109;
  s_spacemove_in = 110;

  s_click_weapon = 111;
  s_click_armor = 112;
  s_click_ring = 113;
  s_click_armring = 114;
  s_click_necklace = 115;
  s_click_helmet = 116;
  s_click_grobes = 117;
  s_itmclick = 118;

  s_yedo_man = 130;
  s_yedo_woman = 131;
  s_longhit = 132;
  s_widehit = 133;
  s_rush_l = 134;
  s_rush_r = 135;
  s_firehit_ready = 136;
  s_firehit = 137;

  s_man_struck = 138;
  s_wom_struck = 139;
  s_man_die = 144;
  s_wom_die = 145;



implementation

uses
  ClMain, MShare, GameSetup;

var
  OldBGName: string = '';
  OldBGIndex: Integer = -1;

procedure LoadSoundList(flname: string);
var
  i, k, idx, n: integer;
  strlist: TStringList;
  str, data: string;
begin
  if FileExists(flname) then begin
    strlist := TStringList.Create;
    strlist.LoadFromFile(flname);
    idx := 0;
    for i := 0 to strlist.Count - 1 do begin
      str := strlist[i];
      if str <> '' then begin
        if str[1] = ';' then
          continue;
        str := Trim(GetValidStr3(str, data, [':', ' ', #9]));
        n := StrToIntDef(data, 0);
        if n > idx then begin
          for k := 0 to n - g_SoundList.Count - 1 do
            g_SoundList.Add('');
          g_SoundList.Add(str);
          idx := n;
        end;
      end;
    end;
    strlist.Free;

  end;
end;

procedure LoadBGMusicList(flname: string);
var
  strlist: TStringList;
  str, sIdxName, sFileName: string;
  i, Idx, n, k, nid: Integer;
  MemoryStream: TMemoryStream;
begin
  BGMusicList.Clear;
  MemoryStream := g_WMusicImages.GetDataStream(0, dtData);
  if MemoryStream <> nil then begin
    strlist := TStringList.Create;
    strlist.LoadFromStream(MemoryStream);
    Idx := 0;
    for i := 0 to strlist.Count - 1 do begin
      str := strlist[i];
      if (str = '') or (str[1] = ';') then
        continue;
      str := GetValidStr3(str, sIdxName, [':', ' ', #9]);
      str := GetValidStr3(str, sFileName, [':', ' ', #9]);
      n := StrToIntDef(sIdxName, 0);
      nid := StrToIntDef(Trim(sFileName), 0);
      if n > idx then begin
        for k := 0 to n - BGMusicList.Count - 1 do
          BGMusicList.Add('');
        BGMusicList.AddObject('', TObject(nid));
        idx := n;
      end;
    end;
    strlist.Free;
    MemoryStream.Free;
  end;
end;

procedure InitializeSound();
var
  i: Integer;
begin
  while g_SoundList.Count < 12000 do
    g_SoundList.Add('');
    {$REGION 'Spell Sounds'}
    g_SoundList[10340] := 'wav\M40-0.wav'; //Purification
    g_SoundList[10342] := 'wav\M40-1.wav';

    g_SoundList[10360] := 'wav\M1-1.wav'; //ParaBall
    g_SoundList[10361] := 'wav\M39-1.wav';
    g_SoundList[10362] := 'wav\M39-3.wav';

    g_SoundList[10380] := 'wav\M6-1.wav'; //MassPoison
    g_SoundList[10382] := 'wav\M19-3.wav';

    g_SoundList[10390] := 'wav\M1-1.wav'; //????
    g_SoundList[10391] := 'wav\M1-2.wav';
    g_SoundList[10392] := 'wav\M1-3.wav';

    g_SoundList[10420] := 'wav\M44-0.wav'; //BladeAvalanche
    g_SoundList[10421] := '';
    g_SoundList[10422] := '';

    g_SoundList[10440] := 'wav\M39-0.wav'; //FrostCrunch
    g_SoundList[10441] := 'wav\M39-1.wav';
    g_SoundList[10442] := 'wav\M39-2.wav';
    g_SoundList[10443] := 'wav\M39-3.wav';

    g_SoundList[10470] := 'wav\M45-0.wav'; //FlameField
    g_SoundList[10471] := '';
    g_SoundList[10472] := '';

    g_SoundList[10480] := 'wav\M37-1.wav'; //EnergyRepulsor
    g_SoundList[10481] := '';
    g_SoundList[10482] := '';

    g_SoundList[10500] := 'wav\M36-1.wav'; //UltimateEnhancer
    g_SoundList[10501] := '';
    g_SoundList[10502] := '';

    g_SoundList[10520] := 'wav\M13-1.wav'; //Curse
    g_SoundList[10521] := 'wav\M49-1.wav';
    g_SoundList[10522] := 'wav\M46-1.wav';

    g_SoundList[10530] := 'wav\M48-0.wav'; //Vampirism
    g_SoundList[10531] := '';
    g_SoundList[10532] := 'wav\M48-2.wav';

    g_SoundList[10550] := 'wav\M47-0.wav'; //Entrapment
    g_SoundList[10551] := '';
    g_SoundList[10552] := 'wav\M47-2.wav';
    g_SoundList[10555] := 'wav\M47-5.wav';

    g_SoundList[10570] := 'wav\M58-0.wav'; //MeteorStrike
    g_SoundList[10571] := '';
    g_SoundList[10572] := 'wav\M58-3.wav';

    g_SoundList[10580] := g_SoundList[10310]; //ProtectShield
    g_SoundList[10581] := g_SoundList[10311];
    g_SoundList[10582] := g_SoundList[10312];

    g_SoundList[10590] := ''; //CrossHalfMoon
    g_SoundList[10591] := '';
    g_SoundList[10592] := '';

    g_SoundList.Objects[10600] := TObject(100); //Resurrect
    g_SoundList[10601] := '';
    g_SoundList.Objects[10602] := TObject(102);

    g_SoundList[10610] := 'wav\M42-0.wav'; //????
    g_SoundList[10611] := '';
    g_SoundList[10612] := 'wav\M42-2.wav';

    g_SoundList[10620] := 'wav\M41-0.wav'; //????
    g_SoundList[10621] := '';
    g_SoundList[10622] := '';

    g_SoundList[10630] := 'wav\M13-3.wav'; //GeoTeleport
    g_SoundList[10631] := '';
    g_SoundList[10632] := '';

    g_SoundList[10650] := 'wav\M41-0.wav'; //SummonHolyDeva
    g_SoundList[10651] := '';
    g_SoundList[10652] := '';

    g_SoundList[10660] := g_SoundList[10570]; //Blizzard
    g_SoundList[10661] := g_SoundList[10571];
    g_SoundList[10662] := g_SoundList[10572];

    g_SoundList[10670] := g_SoundList[10130]; //ChainSoulFireBall
    g_SoundList[10671] := g_SoundList[10131];
    g_SoundList[10672] := g_SoundList[10132];

    g_SoundList[10700] := 'wav\M46-1.wav'; //ThunderClap
    g_SoundList[10702] := 'wav\M52-2.wav';

    g_SoundList[10710] := 'wav\旋风.wav'; //Hyperthermia
    g_SoundList[10712] := 'wav\xsws_pbec.wav';

    g_SoundList[10720] := 'wav\M49-2.wav'; //SoulSteal
    g_SoundList[10722] := 'wav\M28-3.wav';

    g_SoundList[10760] := 'wav\M49-0.wav'; //Hallucination
    g_SoundList[10762] := 'wav\M49-2.wav';

    g_SoundList[11140] := 'wav\cboFs1_start.wav';
    g_SoundList[11142] := 'wav\cboFs1_target.wav';
    g_SoundList[11150] := 'wav\cboFs2_start.wav';
    g_SoundList[11152] := 'wav\cboFs2_target.wav';
    g_SoundList[11160] := 'wav\cboFs3_start.wav';
    g_SoundList[11162] := 'wav\cboFs3_target.wav';
    g_SoundList[11170] := 'wav\cboFs4_start.wav';
    g_SoundList[11171] := '';
    g_SoundList[11172] := '';

    g_SoundList[11180] := 'wav\cboDs1_start.wav';
    g_SoundList[11182] := 'wav\cboDs1_target.wav';
    g_SoundList[11190] := 'wav\cboDs2_start.wav';
    g_SoundList[11192] := 'wav\cboDs2_target.wav';
    g_SoundList[11200] := 'wav\cboDs3_start.wav';
    g_SoundList[11202] := 'wav\cboDs3_target.wav';
    g_SoundList[11210] := 'wav\cboDs4_start.wav';
    g_SoundList[11212] := 'wav\cboDs4_target.wav';

    g_SoundList[11230] := 'wav\M56-0.wav';
    g_SoundList[11231] := 'wav\M56-3.wav';
    g_SoundList[11240] := 'wav\xsws_tsgj.wav';
    g_SoundList[11242] := 'wav\xsws_pbec.wav';
    g_SoundList.Objects[11232] := TObject(107);
    {$ENDREGION}
    {$REGION 'Monster Sounds'}
    //Mon28.wzl
    {Appr 290-294} //New shinsus
    for I := 0 to 15 do begin
      g_SoundList[2900 + I] := g_SoundList[1900 + I];
      g_SoundList[2920 + I] := g_SoundList[1900 + I];
      g_SoundList[2940 + I] := g_SoundList[1900 + I];
    end;

    //Mon31.wzl
    {Appr 300}
    g_SoundList[3201] := g_SoundList[2311];
    g_SoundList[3203] := g_SoundList[2313];
    g_SoundList[3204] := g_SoundList[2314];
    g_SoundList[3205] := g_SoundList[2315];
    {Appr 301}
    g_SoundList[3211] := g_SoundList[2321];
    g_SoundList[3213] := g_SoundList[2323];
    g_SoundList[3214] := g_SoundList[2324];
    g_SoundList[3215] := g_SoundList[2325];
    {Appr 302}
    g_SoundList[3221] := g_SoundList[2331];
    g_SoundList[3223] := g_SoundList[2333];
    g_SoundList[3224] := g_SoundList[2334];
    g_SoundList[3225] := g_SoundList[2335];
    {Appr 303}
    g_SoundList[3231] := g_SoundList[2341];
    g_SoundList[3233] := g_SoundList[2343];
    g_SoundList[3234] := g_SoundList[2344];
    g_SoundList[3235] := g_SoundList[2345];
    {Appr 304}
    g_SoundList[3241] := g_SoundList[2351];
    g_SoundList[3243] := g_SoundList[2353];
    g_SoundList[3244] := g_SoundList[2354];
    g_SoundList[3245] := g_SoundList[2355];

    //Mon32 & {false 33}.wzl

    {Appr 310}
    g_SoundList[3300] := 'wav\3400-0.wav';
    g_SoundList[3302] := 'wav\3400-2.wav';
    g_SoundList[3305] := 'wav\3400-5.wav';

    {Appr 311}
    g_SoundList[3312] := 'wav\3410-2.wav';
    g_SoundList[3315] := 'wav\640-5.wav';

    {Appr 312}
    g_SoundList[3325] := 'wav\3490-5.wav';

    {Appr 313}
    g_SoundList[3332] := 'wav\2100-2.wav';
    g_SoundList[3335] := 'wav\3490-5.wav';

    {Appr 314}
    g_SoundList[3345] := 'wav\3490-5.wav';

    {Appr 315}
    g_SoundList[3352] := 'wav\2140-2.wav';
    g_SoundList[3355] := 'wav\3490-5.wav';
    g_SoundList[3357] := 'wav\2140-2.wav';

    {Appr 316}
    g_SoundList[3362] := 'wav\3460-2.wav';
    g_SoundList[3364] := 'wav\3460-7.wav';
    g_SoundList[3365] := 'wav\3460-5.wav';

    {Appr 317}
    g_SoundList[3370] := 'wav\3470-0.wav';
    g_SoundList[3372] := 'wav\3470-2.wav';
    g_SoundList[3375] := 'wav\3470-5.wav';

    {Appr 318}
    g_SoundList[3382] := 'wav\3480-2.wav';
    g_SoundList[3385] := 'wav\3490-5.wav';
    g_SoundList[3387] := 'wav\3480-7.wav';

    {Appr 319}
    g_SoundList[3392] := 'wav\3490-2.wav';
    g_SoundList[3395] := 'wav\3490-5.wav';
    g_SoundList[3397] := 'wav\3490-7.wav';

    {Appr 320}
    g_SoundList[3402] := 'wav\3500-2.wav';
    g_SoundList[3405] := 'wav\3500-5.wav';

    {Appr 321}
    g_SoundList[3412] := 'wav\3510-2.wav';
    g_SoundList[3418] := 'wav\3510-2.wav';
    g_SoundList[3415] := 'wav\3530-5.wav'; //death

    {Appr 322}
    g_SoundList[3420] := 'wav\3520-0.wav';
    g_SoundList[3421] := 'wav\3520-1.wav';
    g_SoundList[3422] := 'wav\3520-2.wav'; //SM_HIT
    g_SoundList[3425] := 'wav\3520-5.wav'; //death
    g_SoundList[3427] := 'wav\3520-7.wav'; //SM_HIT_2
    g_SoundList[3428] := 'wav\3520-8.wav'; //SM_HIT_3
    g_SoundList[3429] := 'wav\3520-9.wav'; //SM_HIT_3

    {Appr 323}
    g_SoundList[3430] := 'wav\3530-7.wav'; //walk
    g_SoundList[3432] := 'wav\3530-2.wav'; //SM_HIT
    g_SoundList[3435] := 'wav\3530-5.wav'; //death
    g_SoundList[3438] := 'wav\huoliankuangwu.wav'; //SM_HIT_3
    g_SoundList[3439] := 'wav\longsword-hit.wav'; //SM_HIT_4

    //Mon34.wzl

    {Appr 335}
    g_SoundList[3551] := g_SoundList[1901];
    g_SoundList[3552] := g_SoundList[902];
    g_SoundList[3554] := 'wav\3460-7.wav';
    g_SoundList[3555] := g_SoundList[905];
    {Appr 336}
    g_SoundList[3561] := g_SoundList[1901];
    g_SoundList[3562] := g_SoundList[902];
    g_SoundList[3564] := 'wav\3460-7.wav';
    g_SoundList[3565] := g_SoundList[905];

    //Sabuk Gates and walls
    g_SoundList[9224] := 'wav\9210-4.wav';
    g_SoundList[9234] := 'wav\9210-4.wav';
    for I := 0 to 9 do begin
      g_SoundList[9240 + I] := g_SoundList[9210 + I];
      g_SoundList[9250 + I] := g_SoundList[9220 + I];
      g_SoundList[9260 + I] := g_SoundList[9230 + I];
    end;

    //the monsters.pak sounds?
    {for I := 5200 to 7199 do begin
      g_SoundList.Objects[I] := TObject(I);
    end;  }
    {$ENDREGION}
end;


procedure PlaySound(idx: integer);
var
  MemoryStream: TMemoryStream;
begin
  //10000033  BGMusicList
  if not g_boCanSound then exit;
  
  if (g_Sound <> nil) and g_boSound and (g_btSoundVolume > 0) then begin
    //Mob Pak Sounds - this is temporary(chilipepper)
    if (idx >= 5200) and (Idx <= 7799) then begin
      PlaySoundEx(idx - 4200);
      exit;
    end;
    if idx >= 10000000 then begin
      dec(idx, 10000000);
      if (idx > 0) and (idx < BGMusicList.Count) and (g_WMusicImages.boInitialize) then begin
        if BGMusicList.Objects[idx] <> nil then begin
          MemoryStream := g_WMusicImages.GetDataStream(Integer(BGMusicList.Objects[idx]), dtWav);
          if MemoryStream <> nil then begin
            Try
              try
                MemoryStream.Position := 0;
                g_Sound.EffectStream(MemoryStream, FALSE, FALSE);
              except
              end;
            Finally
              MemoryStream.Free;
            End;
          end;
        end;
      end;
    end else begin
      if (idx >= 0) and (idx < g_SoundList.Count) then begin
        if g_SoundList[idx] <> '' then begin
          if FileExists(g_SoundList[idx]) then
          try
            g_Sound.EffectFile(g_SoundList[idx], FALSE, FALSE);
          except
          end;
        end else
        if g_SoundList.Objects[idx] <> nil then begin
          PlaySound(10000000 + Integer(g_SoundList.Objects[idx]));
        end;
      end;
    end;
  end;
end;

procedure PlaySoundEx(wavname: string);
begin
  if not g_boCanSound then exit;
  if (g_Sound <> nil) and g_boSound and (g_btSoundVolume > 0) then begin
    if wavname <> '' then
      if FileExists(wavname) then begin
        try
          g_Sound.EffectFile(wavname, False, FALSE);
        except
        end;
      end;
  end;
end;

procedure PlaySoundEx(idx: integer);
var
  MemoryStream: TMemoryStream;
begin
  if not g_boCanSound then exit;
  if (g_Sound <> nil) and g_boSound and (g_btSoundVolume > 0) and g_WMusicImages.boInitialize then begin
    MemoryStream := g_WMusicImages.GetDataStream(idx, dtWav);
    if MemoryStream <> nil then begin
      Try
        try
          MemoryStream.Position := 0;
          g_Sound.EffectStream(MemoryStream, False, FALSE);
        except
        end;
      Finally
        MemoryStream.Free;
      End;
    end;
  end;
end;

procedure PlayMapMusic(boFlag: Boolean);
begin
  ClearBGM;
  if (g_nAreaStateValue = OT_FREEPKAREA) and (BGMusicList.Count > 6) then begin
    PlayBGM(Integer(BGMusicList.Objects[6]));
  end else
  if (g_nMapMusic >= 0) and (g_nMapMusic < BGMusicList.Count) then begin
    PlayBGM(Integer(BGMusicList.Objects[g_nMapMusic]));
  end;
end;

procedure PlayBGM(wavname: string);
begin
  if (not g_boBGSound) or (g_btMP3Volume <= 0) then exit;
  if (OldBGName = wavname) and (MusicHS > 0) then begin
    if BASS_ChannelIsActive(MusicHS) <> BASS_ACTIVE_PLAYING then
      BASS_ChannelPlay(MusicHS, False);
      BASS_ChannelSetAttribute(MusicHS, BASS_ATTRIB_VOL, g_btMP3Volume / 100);
    exit;
  end;
  ClearBGMEx;
  Try
    MusicHS := BASS_StreamCreateFile(False, PAnsiChar(wavname), 0, 0, BASS_SAMPLE_LOOP);
    if MusicHS < BASS_ERROR_ENDED then begin
      BASS_StreamFree(MusicHS);
      MusicHS := 0;
      exit;
    end;
    OldBGName := wavname;
    BASS_ChannelPlay(MusicHS, True);
    BASS_ChannelSetAttribute(MusicHS, BASS_ATTRIB_VOL, g_btMP3Volume / 100);
  Except
  End;
end;

procedure PlayBGM(idx: integer);
begin
  if (not g_boBGSound) or (not g_WMusicImages.boInitialize) or (g_btMP3Volume <= 0) then exit;
  if (OldBGIndex = idx) and (MusicHS > 0) then begin
    if BASS_ChannelIsActive(MusicHS) <> BASS_ACTIVE_PLAYING then
      BASS_ChannelPlay(MusicHS, False);
      BASS_ChannelSetAttribute(MusicHS, BASS_ATTRIB_VOL, g_btMP3Volume / 100);
    exit;
  end;
  ClearBGMEx;
  Try
    MusicStream := g_WMusicImages.GetDataStream(idx, dtMusic);
    if MusicStream <> nil then begin
      MusicHS := BASS_StreamCreateFile(True, MusicStream.Memory, 0, MusicStream.Size, BASS_SAMPLE_LOOP);
      if MusicHS < BASS_ERROR_ENDED then begin
        BASS_StreamFree(MusicHS);
        MusicHS := 0;
        FreeAndNil(MusicStream);
        exit;
      end;
      OldBGIndex := idx;
      BASS_ChannelPlay(MusicHS, True);
      BASS_ChannelSetAttribute(MusicHS, BASS_ATTRIB_VOL, g_btMP3Volume / 100);
    end;
  Except
  End;
end;

procedure ChangeBGMState(BGMState: TBGMState);
begin
  if MusicHS >= BASS_ERROR_ENDED then begin
    case BGMState of
      bgmPlay: BASS_ChannelPlay(MusicHS, False);
      bgmStop: BASS_ChannelStop(MusicHS);
      bgmPause: BASS_ChannelPause(MusicHS);
    end;
    BASS_ChannelSetAttribute(MusicHS, BASS_ATTRIB_VOL, g_btMP3Volume / 100);
  end;
end;

procedure SilenceSound;
begin
  if g_Sound <> nil then begin
    g_Sound.Clear;
  end;
end;

procedure ClearBGM();
begin
  ChangeBGMState(bgmStop);
end;

procedure ClearBGMEx();
begin
  OldBGName := '';
  OldBGIndex := -1;
  BASS_StreamFree(MusicHS);
  MusicHS := 0;
  if MusicStream <> nil then MusicStream.Free;
  MusicStream := nil;
end;

procedure ItemClickSound(std: TStdItem);
begin
  case std.StdMode of
    tm_Drug: PlaySound(s_click_drug);
    //ts_Open: PlaySound(s_click_drug);
    tm_Weapon, tm_Nail: PlaySound(s_click_weapon);
    tm_Dress, tm_Saddle: PlaySound(s_click_armor);
    tm_Ring: PlaySound(s_click_ring);
    tm_ArmRing: begin
        if (pos('手镯', std.Name) > 0) or (pos('手套', std.Name) > 0) then
          PlaySound(s_click_grobes)
        else
          PlaySound(s_click_armring);
      end;
    tm_Necklace, tm_Bell: PlaySound(s_click_necklace);
    tm_Helmet: PlaySound(s_click_helmet);
  else
    PlaySound(s_itmclick);
  end;
end;

procedure ItemUseSound(stdmode: TStdMode);
begin
  case stdmode of
    tm_Drug: PlaySound(s_click_drug);
    tm_Restrict: PlaySound(s_eat_drug);
  else
    ;
  end;
end;

end.

