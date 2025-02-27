unit WMFile;

interface
uses
  SysUtils, Classes, WIL, UIB, Grobal2;

const
  OBJECTSCOUNT = 39;
  TILECOUNT = 10;
  SMTILECOUNT = 10;
  MIR3COUNT = 75;
  MONSCOUNT = 75;
  NPCSCOUNT = 1;
  WEAPONCOUNT = 3;
  HUMCOUNT = 3;
  HUMEFFECTCOUNT = 3;
  ITEMCOUNT = 1;
  HAIRCOUNT = 1;
  NEWMAPDIRHARD = '2K_';
  DATADIRNAME = '.\Resource\Data\';
  WAVDIRNAME = '.\Resource\Wav\';

  OLDMAPDIRNAME = '.\Map\';
  MAPDIRNAME = '.\Resource\Map\';
  RESOURCEDIRNAME = '.\Resource\';

  GETMISSIONDESCFILE = DATADIRNAME + 'MissionDesc.dat';
  GETSTDITEMSDESCFILE = DATADIRNAME + 'StditemsDesc.dat';
  GETMAGICDESCFILE = DATADIRNAME + 'MagicDesc.dat';
  GETMAPDESCFILE = DATADIRNAME + 'MapDesc.dat';
  GETMAKEMAGICFILE = DATADIRNAME + 'MakeMagic.dat';
  GETBADAPPSFILE = DATADIRNAME + 'Quests.dat';//should be banned apps but i called it quests to confuse ppl

 { SHOPHINTFILE = RESOURCEDIRNAME + 'ShopHint.dat';
  MAPDESCFILE = RESOURCEDIRNAME + 'MapDesc.dat';
  GOODSFILE = RESOURCEDIRNAME + 'Goods.dat';
  MAGICFILE = RESOURCEDIRNAME + 'Magic.Dat';
  MAPEFFECTFILE = RESOURCEDIRNAME + 'MapEffect.dat'; }

  GOODSFILE = 1;
  MAGICFILE = 2;
  MAPDESCFILE = 3;
  MAPEFFECTFILE = 4;
  SHOPHINTFILE = 5;
  MISSIONFILE = 6;

  MAINIMAGEFILE = 'Data\Prguse.wil';
  MAINIMAGEFILE2 = 'Data\Prguse2.wil';
  MAINIMAGEFILE3 = 'Data\Prguse3.wil';
  MAINIMAGEFILE99 = DATADIRNAME + 'Prguse.pak';

  FACEFILE = DATADIRNAME + 'Face.pak';

  MUSICFILE = DATADIRNAME + 'Audio.pak';
  SETTINGFILE = DATADIRNAME + 'Setting.pak';

  ENVIRONMENT = DATADIRNAME + 'Environment.pak';
  MINMAPIMAGEFILE2 = DATADIRNAME + 'MiniMap.pak';
  MOBMAGICIMAGEFILE = DATADIRNAME + 'MobMagic.pak';

  HUMCOSIMAGESFILE = 'Data\cbohum.wis';
  HUMCOSIMAGESFILE2 = 'Data\cbohum3.wis';
  HUMCOSWINGIMAGESFILE = 'Data\cboHumEffect.wis';
  HUMCOSWINGIMAGESFILE2 = 'Data\cboHumEffect2.wil';
  HAIRCOSIMGIMAGESFILE = 'Data\cbohair.wis';
  MAGICCOSIMAGESFILE = 'Data\cboEffect.wis';
  WEAPONCOSIMAGESFILE = 'Data\cboweapon.wis';
  WEAPONCOSIMAGESFILE2 = 'Data\cboweapon3.wil';

  CHRSELIMAGEFILE = DATADIRNAME + 'ChrSel.pak';
  OCHRSELIMAGEFILE = 'Data\ChrSel.wil';
  MINMAPIMAGEFILE = 'Data\mmap.wil';
  ANITILEFILE = 'Data\AniTiles1.wil';
  MONNEWKULOUFILE = 'Data\Mon-kulou.wil';
  UI1FILE = 'Data\ui1.wil';
  UI3FILE = 'Data\ui3.wil';
  //UI3FILE = 'Data\UI3.wzl';

  MYTITLESIMAGEFILE = DATADIRNAME + 'Tiles.pak';
  MYSMLTITLESIMAGEFILE = DATADIRNAME + 'SmTiles.pak';
  //HUMWINGIMAGESFILE = 'Data\HumEffect.wil';
  HUMHORSEWINGIMAGESFILE = DATADIRNAME + 'HumEffectHorse.pak';

  MAGICONIMAGESFILE = DATADIRNAME + 'MagIcon.pak';
  DEFMAGICONIMAGESFILE = 'Data\MagIcon.wil';
  DEFMAGICONIMAGESFILE2 = 'Data\MagIcon2.wil';
  HAIRIMGIMAGESFILE = DATADIRNAME + 'Hair.pak';
  MAGICIMAGESFILE = 'Data\Magic.wil';
  MAGIC2IMAGESFILE = 'Data\Magic2.wil';
  MAGIC3IMAGESFILE = 'Data\Magic3.wil';
  MAGIC4IMAGESFILE = 'Data\Magic4.wil';
  MAGIC5IMAGESFILE = 'Data\Magic5.wil';
  MAGIC6IMAGESFILE = 'Data\Magic6.wil';
  MAGIC7IMAGESFILE = 'Data\Magic7-16.wil';
  MAGIC8IMAGESFILE = 'Data\Magic8-16.wil';
  MAGIC9IMAGESFILE = 'Data\Magic9.wil';
  MAGIC10IMAGESFILE = 'Data\Magic10.wil';
  MAGIC99IMAGESFILE = DATADIRNAME + 'Magic.pak';

  DRAGONIMAGEFILE = 'Data\Dragon.wil';
  EFFECTIMAGEFILE = 'Data\Effect.wil';
  NPC2FILE = 'Data\Npc2.wil';
  EFFECTITEMFILE = DATADIRNAME + 'ItemEffect.pak';
  HUMHORSEFILE = DATADIRNAME + 'HumHorse.pak';
  RIDEFILE = DATADIRNAME + 'Horse.pak';
  MYHUMEFFECTFILE = DATADIRNAME + 'HumEffect.pak';
  HUMKILLERFILE = 'Data\hum_ck.wil';
  WEAPONKILLERLFILE = 'Data\wep_ck_l.wil';
  WEAPONKILLERRFILE = 'Data\wep_ck_r.wil';
  HAIRKILLERFILE = 'Data\hair_ck.wil';
  MAGICKILLERFILE = 'Data\magic_ck.wil';
  HUMRANGERFILE = 'Data\hum_gjs.wil';
  WEAPONRANGERFILE = 'Data\weapon_gjs.wil';
  HAIRRANGERFILE = 'Data\hair_gjs.wil';

  //ChiliPepper - New Login and Character Select WZL files
  CHARSELECT2IMAGESFILE = 'Data\ChrSel2.wil';
  LOGINEFFECTIMAGESFILE = 'Data\Effect_Login.wil';

  Images_Begin = 0;
  Images_Prguse = Images_Begin;
  Images_Prguse2 = 1;
  Images_Prguse3 = 2;
  Images_PrguseEx = 3;
  Images_ChrSel = 4;
  Images_mmap = 5;
  Images_MagIcon = 6;
  Images_Magic = 7;
  Images_Magic2 = 8;
  Images_Magic3 = 9;
  Images_Magic4 = 10;
  Images_Magic5 = 11;
  Images_Magic6 = 12;
  Images_Magic7 = 13;
  Images_Magic8 = 14;
  Images_Magic9 = 15;
  Images_Magic99 = 16;
  Images_Dragon = 17;
  Images_Face = 18;
  Images_Effect = 19;
  Images_mmap2 = 20;
 // Images_Music = 20;
  //Images_Setting = 21;
  //Images_UIB = 19;
  Images_TilesBegin = Images_mmap2 + 1;
  Images_TilesEnd = Images_TilesBegin + TileCount;
  Images_SMTilesBegin = Images_TilesEnd + 1;
  Images_SMTilesEnd = Images_SMTilesBegin + SMTileCount;
  Images_Mir3ObjectsBegin = Images_SMTilesEnd + 1;
  Images_Mir3ObjectsEnd = Images_Mir3ObjectsBegin + Mir3Count;
  Images_AniTiles = Images_Mir3ObjectsEnd + 1;
  Images_ItemEffect = Images_AniTiles + 1;

  Images_Hair = Images_ItemEffect + 1; //24

  Images_HumHorse = Images_Hair + 1; //25

  Images_Ride = Images_HumHorse + 1; //26

  Images_HumHorseEffect = Images_Ride + 1; //27

  Images_cboHum = Images_HumHorseEffect + 1; //28
  Images_cboHum2 = Images_cboHum + 1; //29
  Images_cboHumEffect = Images_cboHum2 + 1;  //30
  Images_cboHumEffect2 = Images_cboHumEffect + 1; //31
  Images_cboHair = Images_cboHumEffect2 + 1; //32
  Images_cboEffect = Images_cboHair + 1; //33
  Images_cboWeapon = Images_cboEffect + 1; //34
  Images_cboWeapon2 = Images_cboWeapon + 1; //35

  Images_StateItemBegin = Images_cboWeapon2 + 1; //36
  Images_StateItemEnd = Images_StateItemBegin + ITEMCOUNT; //37

  Images_ItemsBegin = Images_StateItemEnd + 1; //38
  Images_ItemsEnd = Images_ItemsBegin + ITEMCOUNT; //39

  Images_DnItemsBegin = Images_ItemsEnd + 1; //40
  Images_DnItemsEnd = Images_DnItemsBegin + ITEMCOUNT; //41

  Images_HumBegin = Images_DnItemsEnd + 1; //42
  Images_HumEnd = Images_HumBegin + HUMCOUNT; //43

  Images_HumEffectBegin = Images_HumEnd + 1; //44
  Images_HumEffectEnd = Images_HumEffectBegin + 1{HUMEFFECTCOUNT}; //45

  Images_NpcBegin = Images_HumEffectEnd + 1; //46
  Images_NpcEnd = Images_NpcBegin + NPCSCOUNT; //47

  Images_WeaponBegin = Images_NpcEnd + 1; //48
  Images_WeaponEnd = Images_WeaponBegin + WEAPONCOUNT; //51

  Images_MonBegin = Images_WeaponEnd + 1; //52
  Images_MonEnd = Images_MonBegin + MONSCOUNT; //123

  Images_ObjectBegin = Images_MonEnd + 1; //124
  Images_ObjectEnd = Images_ObjectBegin + OBJECTSCOUNT; //163

  Images_MyHumEffect = Images_ObjectEnd + 1;
  Images_Magic10 = Images_MyHumEffect + 1;
  Images_Npc2 = Images_Magic10 + 1;
  Images_Kulou = Images_Npc2 + 1;
  Images_OChrSel = Images_Kulou + 1;
  Images_UI1 = Images_OChrSel + 1;
  Images_UI3 = Images_UI1 + 1;
  Images_DefMagIcon = Images_UI3 + 1;
  Images_DefMagIcon2 = Images_DefMagIcon + 1;

  Images_ChrSel2 = Images_DefMagIcon2 + 1; //177
  Images_LoginEffect = Images_ChrSel2 + 1; //178
  Images_HumKiller = Images_LoginEffect + 1;
  Images_HumRanger = Images_HumKiller + 1;
  Images_WeaponKillerL = Images_HumRanger + 1;
  Images_WeaponKillerR = Images_WeaponKillerL + 1;
  Images_HairKiller = Images_WeaponKillerR + 1;
  Images_WeaponRanger = Images_HairKiller + 1;
  Images_HairRanger = Images_WeaponRanger + 1;
  Images_MagicKiller = Images_HairRanger + 1;

  Images_END = Images_MagicKiller; //196
var
  g_WBagItemFiles: array[0..ITEMCOUNT] of string = (
    'Data\Items.wil',
    DATADIRNAME + 'Items.pak'
    );

  g_WStateItemFiles: array[0..ITEMCOUNT] of string = (
    'Data\StateItem.wil',
    DATADIRNAME + 'StateItem.pak'
    );

  g_WDnItemFiles: array[0..ITEMCOUNT] of string = (
    'Data\DnItems.wil',
    DATADIRNAME + 'DnItems.pak'
    );

  g_WNpcFiles: array[0..NPCSCOUNT] of string = (
    'Data\Npc.wil',
    DATADIRNAME + 'Npc.pak'
    );

  g_WHumFiles: array[0..HUMCOUNT] of string = (
    'Data\Hum.wil',
    'Data\Hum2.wil',
    'Data\Hum3.wil',
    DATADIRNAME + 'Hum.pak'
    );

  g_WHumEffectFiles: array[0..HUMEFFECTCOUNT - 1] of string = (
    'Data\HumEffect.wil',
    'Data\HumEffect2.wil',
    'Data\HumEffect3.wil'
    );

  g_WWeaponFiles: array[0..WEAPONCOUNT] of string = (
    'Data\Weapon.wil',
    'Data\Weapon2.wis',
    'Data\Weapon3.wil',
    DATADIRNAME + 'Weapon.pak'
    );
  g_WTilesFiles: array[0..TileCount] of string = (
    'Data\Tiles.wil',
    'Data\Tiles2.wil',
    'Data\Tiles3.wil',
    'Data\Tiles4.wil',
    'Data\Tiles5.wil',
    'Data\Tiles6.wil',
    'Data\Tiles7.wil',
    'Data\Tiles8.wil',
    'Data\Tiles9.wil',
    'Data\Tiles10.wil',
    DATADIRNAME  +  'Tiles.pak'
  );

  g_WSMTilesFiles: array[0..SMTileCount] of string = (
    'Data\SmTiles.wil',
    'Data\SmTiles2.wil',
    'Data\SmTiles3.wil',
    'Data\SmTiles4.wil',
    'Data\SmTiles5.wil',
    'Data\SmTiles6.wil',
    'Data\SmTiles7.wil',
    'Data\SmTiles8.wil',
    'Data\SmTiles9.wil',
    'Data\SmTiles10.wil',
    DATADIRNAME + 'SmTiles.pak'
  );


  g_WObjectFiles: array[0..OBJECTSCOUNT] of string = (
    'Data\Objects.wil',
    'Data\Objects2.wil',
    'Data\Objects3.wil',
    'Data\Objects4.wil',
    'Data\Objects5.wil',
    'Data\Objects6.wil',
    'Data\Objects7.wil',
    'Data\Objects8.wil',
    'Data\Objects9.wil',
    'Data\Objects10.wil',
    'Data\Objects11.wil',
    'Data\Objects12.wil',
    'Data\Objects13.wil',
    'Data\Objects14.wil',
    'Data\Objects15.wil',
    'Data\Objects16.wil',
    'Data\Objects17.wil',
    'Data\Objects18.wil',
    'Data\Objects19.wil',
    'Data\Objects20.wil',  {19}
    'Data\Objects21.wil',
    'Data\Objects22.wil',
    'Data\Objects23.wil',
    'Data\Objects24.wil',
    'Data\Objects25.wil',
    'Data\Objects26.wil',
    'Data\Objects27.wil',
    'Data\Objects28.wil',
    'Data\Objects29.wil',
    'Data\Objects30.wil',  {29}
    DATADIRNAME + 'Objects1.pak',{20}
    DATADIRNAME + 'Objects2.pak',
    DATADIRNAME + 'Objects3.pak',
    DATADIRNAME + 'Objects4.pak',
    DATADIRNAME + 'Objects5.pak',
    DATADIRNAME + 'Objects6.pak',
    DATADIRNAME + 'Objects7.pak',
    DATADIRNAME + 'Objects8.pak',
    DATADIRNAME + 'Objects9.pak',
    DATADIRNAME + 'Objects10.pak'
    );


  g_WMonFiles: array[0..MONSCOUNT] of string = (
    '',
    'Data\Mon1.wil',
    'Data\Mon2.wil',
    'Data\Mon3.wil',
    'Data\Mon4.wil',
    'Data\Mon5.wil',
    'Data\Mon6.wil',
    'Data\Mon7.wil',
    'Data\Mon8.wil',
    'Data\Mon9.wil',
    'Data\Mon10.wil',
    'Data\Mon11.wil',
    'Data\Mon12.wil',
    'Data\Mon13.wil',
    'Data\Mon14.wil',
    'Data\Mon15.wil',
    'Data\Mon16.wil',
    'Data\Mon17.wil',
    'Data\Mon18.wil',
    'Data\Mon19.wil',
    'Data\Mon20.wil',
    'Data\Mon21.wil',
    'Data\Mon22.wil',
    'Data\Mon23.wil',
    'Data\Mon24.wil',
    'Data\Mon25.wil',
    'Data\Mon26.wil',
    'Data\Mon27.wil',
    'Data\Mon28.wil',
    'Data\Mon29.wil',
    'Data\Mon30.wil',
    'Data\Mon31.wil',
    'Data\Mon32.wil',
    'Data\Mon33.wil',
    'Data\Mon34.wil',
    'Data\Mon35.wil',
    'Data\Mon36.wil',
    'Data\Mon37.wil',
    'Data\Mon38.wil',
    'Data\Mon39.wil',
    'Data\Mon40.wil',
    'Data\Mon41.wil',
    'Data\Mon42.wil',
    'Data\Mon43.wil',
    'Data\Mon44.wil',
    'Data\Mon45.wil',
    'Data\Mon46.wil',
    'Data\Mon47.wil',
    'Data\Mon48.wil',
    'Data\Mon49.wil',
    'Data\Mon50.wil',
    DATADIRNAME + 'Mon1.pak',
    DATADIRNAME + 'Mon2.pak',
    DATADIRNAME + 'Mon3.pak',
    DATADIRNAME + 'Mon4.pak',
    DATADIRNAME + 'Mon5.pak',
    DATADIRNAME + 'Mon6.pak',
    DATADIRNAME + 'Mon7.pak',
    DATADIRNAME + 'Mon8.pak',
    DATADIRNAME + 'Mon9.pak',
    DATADIRNAME + 'Mon10.pak',
    DATADIRNAME + 'Mon11.pak',
    DATADIRNAME + 'Mon12.pak',
    DATADIRNAME + 'Mon13.pak',
    DATADIRNAME + 'Mon14.pak',
    DATADIRNAME + 'Mon15.pak',
    DATADIRNAME + 'Mon16.pak',
    DATADIRNAME + 'Mon17.pak',
    DATADIRNAME + 'Mon18.pak',
    DATADIRNAME + 'Mon19.pak',
    DATADIRNAME + 'Mon20.pak',
    DATADIRNAME + 'Mon21.pak',
    DATADIRNAME + 'Mon22.pak',
    DATADIRNAME + 'Mon23.pak',
    DATADIRNAME + 'Mon24.pak',
    DATADIRNAME + 'Mon25.pak'
    );

var

  g_WUIBImages: TUIBImages;
  g_ClientImages: array[Images_Begin..Images_End] of TWMImages;
  g_WMainImages: TWMImages;
  g_WMain2Images: TWMImages;
  g_WMain3Images: TWMImages;
  g_WMain99Images: TWMImages;
  g_WEnvironmentImages: TWMImages;
  g_WMobMagicImages: TWMImages;
  g_WChrSelImages: TWMImages;
  g_WOChrSelImages: TWMImages;
  g_WMMapImages: TWMImages;
  g_WMyMMapImages: TWMImages;
  g_WUI1Images: TWMImages;
  g_WUI3Images: TWMImages;

  //g_WHumWingImages: TWMImages;
  g_WHumHorseWingImages: TWMImages;
  g_WFaceImages: TWMImages;
  g_WHairImgImages: TWMImages;

  g_WMagIconImages: TWMImages;
  g_WDefMagIconImages: TWMImages;
  g_WDefMagIcon2Images: TWMImages;

  g_WMagicImages: TWMImages;
  g_WMagic2Images: TWMImages;
  g_WMagic3Images: TWMImages;
  g_WMagic4Images: TWMImages;
  g_WMagic5Images: TWMImages;
  g_WMagic6Images: TWMImages;
  g_WMagic7Images: TWMImages;
  g_WMagic8Images: TWMImages;
  g_WMagic9Images: TWMImages;
  g_WMagic10Images: TWMImages;
  g_WMagic99Images: TWMImages;

  g_WMusicImages: TWMImages;
  g_WSettingImages: TWMImages;

  g_WEffectImages: TWMImages;
  g_WItemEffectImages: TWMImages;
  g_WDragonImages: TWMImages;

  g_WHumHorseImages: TWMImages;
  g_WRideImages: TWMImages;

  g_WcboHumImages: TWMImages;
  g_WcboHum2Images: TWMImages;
  g_WcboHumEffectImages: TWMImages;
  g_WcboHumEffect2Images: TWMImages;
  g_WcboHairImages: TWMImages;
  g_WcboEffectImages: TWMImages;
  g_WcboWeaponImages: TWMImages;
  g_WcboWeapon2Images: TWMImages;

  g_WKuLouImages: TWMImages;

  g_WObjects: array[0..OBJECTSCOUNT] of TWMImages;
  g_WTiles: array[0..TILECOUNT] of TWMImages;
  g_WSMTiles: array[0..SMTILECOUNT] OF TWMImages;
  g_WMir3MapObjects: array[0..MIR3COUNT] of TWMImages;
  g_WAniTiles: TWMImages;
  g_WMons: array[0..MONSCOUNT] of TWMImages;
  g_WNpcs: array[0..NPCSCOUNT] of TWMImages;
  g_WNpc2: TWMImages;
  g_WWeapons: array[0..WEAPONCOUNT] of TWMImages;
  g_WHums: array[0..HUMCOUNT] of TWMImages;
  g_WHumEffects: array[0..HUMEFFECTCOUNT - 1] of TWMImages;
  g_WMyHumEffect: TWMImages;
  g_WHumKiller: TWMImages;
  g_WHumRanger: TWMImages;
  g_WWeaponKillerL: TWMImages;
  g_WWeaponKillerR: TWMImages;
  g_WHairKiller: TWMImages;
  g_WWeaponRanger: TWMImages;
  g_WHairRanger: TWMImages;
  g_wMagicKiller: TWMImages;

  g_WBagItems: array[0..ITEMCOUNT] of TWMImages;
  g_WStateItems: array[0..ITEMCOUNT] of TWMImages;
  g_WDnItems: array[0..ITEMCOUNT] of TWMImages;

//  g_WHairs: array[0..HAIRCOUNT] of TWMImages;

  g_ChrSel2Images: TWMImages;
  g_LoginEffectImages: TWMImages;

procedure LoadWMImagesLib(aowner: TComponent);
procedure InitWMImagesLib(password: string);
procedure InitWMImagesLibEx();
procedure UnLoadWMImagesLib();
procedure UnLoadWMImagesLibEx();

implementation

uses windows;

procedure RefClientImages();
var
  i: Integer;
begin
  for I := Low(g_ClientImages) to High(g_ClientImages) do begin
    g_ClientImages[I] := nil;
    case I of
      Images_Prguse: g_ClientImages[I] := g_WMainImages;
      Images_Prguse2: g_ClientImages[I] := g_WMain2Images;
      Images_Prguse3: g_ClientImages[I] := g_WMain3Images;
      Images_PrguseEx: g_ClientImages[I] := g_WMain99Images;
      Images_TilesBegin .. Images_TilesEnd:
        g_ClientImages[I] := g_WTiles[I - Images_TilesBegin];
      Images_SMTilesBegin .. Images_SMTilesEnd:
        g_ClientImages[I] := g_WSMTiles[I - Images_SMTilesBegin];
      Images_Mir3ObjectsBegin .. Images_Mir3ObjectsEnd:
        g_ClientImages[I] := g_WMir3MapObjects[I - Images_Mir3ObjectsBegin];
      Images_AniTiles: g_ClientImages[I] := g_WAniTiles;
      Images_ChrSel: g_ClientImages[I] := g_WChrSelImages;
      Images_OChrSel: g_ClientImages[I] := g_WOChrSelImages;
      Images_mmap: g_ClientImages[I] := g_WMMapImages;
      Images_mmap2: g_ClientImages[I] := g_WMyMMapImages;
      Images_UI1: g_ClientImages[I] := g_WUI1Images;
      Images_UI3: g_ClientImages[I] := g_WUI3Images;
      Images_HumHorseEffect: g_ClientImages[I] := g_WHumHorseWingImages;
      Images_Face: g_ClientImages[I] := g_WFaceImages;
      Images_MagIcon: g_ClientImages[I] := g_WMagIconImages;
      Images_DefMagIcon: g_ClientImages[I] := g_WDefMagIconImages;
      Images_DefMagIcon2: g_ClientImages[I] := g_WDefMagIcon2Images;
      Images_Hair: g_ClientImages[I] := g_WHairImgImages;
      Images_Magic: g_ClientImages[I] := g_WMagicImages;
      Images_Magic2: g_ClientImages[I] := g_WMagic2Images;
      Images_Magic3: g_ClientImages[I] := g_WMagic3Images;
      Images_Magic4: g_ClientImages[I] := g_WMagic4Images;
      Images_Magic5: g_ClientImages[I] := g_WMagic5Images;
      Images_Magic6: g_ClientImages[I] := g_WMagic6Images;
      Images_Magic7: g_ClientImages[I] := g_WMagic7Images;
      Images_Magic8: g_ClientImages[I] := g_WMagic8Images;
      Images_Magic9: g_ClientImages[I] := g_WMagic9Images;
      Images_Magic10: g_ClientImages[I] := g_WMagic10Images;
      Images_Magic99: g_ClientImages[I] := g_WMagic99Images;
      Images_Dragon: g_ClientImages[I] := g_WDragonImages;
      Images_Effect: g_ClientImages[I] := g_WEffectImages;
      //Images_Music: g_ClientImages[I] := g_WEffectImages;
      //IMages_Setting: g_ClientImages[i] := g_WSettingImages;
      Images_ItemEffect: g_ClientImages[I] := g_WItemEffectImages;
      Images_HumHorse: g_ClientImages[I] := g_WHumHorseImages;
      Images_Ride: g_ClientImages[I] := g_WRideImages;
      Images_cboHum: g_ClientImages[I] := g_WcboHumImages;
      Images_cboHum2: g_ClientImages[I] := g_WcboHum2Images;
      Images_cboHumEffect: g_ClientImages[I] := g_WcboHumEffectImages;
      Images_cboHumEffect2: g_ClientImages[I] := g_WcboHumEffect2Images;
      Images_cboHair: g_ClientImages[I] := g_WcboHairImages;
      Images_cboEffect: g_ClientImages[I] := g_WcboEffectImages;
      Images_cboWeapon: g_ClientImages[I] := g_WcboWeaponImages;
      Images_cboWeapon2: g_ClientImages[I] := g_WcboWeapon2Images;
      Images_KuLou: g_ClientImages[I] := g_WKuLouImages;

      Images_ChrSel2: g_ClientImages[I] := g_ChrSel2Images;
      Images_LoginEffect: g_ClientImages[I] := g_LoginEffectImages;


      Images_StateItemBegin..Images_StateItemEnd: begin
          g_ClientImages[I] := g_WStateItems[I - Images_StateItemBegin];
        end;

      Images_ItemsBegin..Images_ItemsEnd: begin
          g_ClientImages[I] := g_WBagItems[I - Images_ItemsBegin];
        end;

      Images_DnItemsBegin..Images_DnItemsEnd: begin
          g_ClientImages[I] := g_WDnItems[I - Images_DnItemsBegin];
        end;

      Images_HumBegin..Images_HumEnd: begin
          g_ClientImages[I] := g_WHums[I - Images_HumBegin];
        end;
      Images_HumEffectBegin..Images_HumEffectEnd: begin
          g_ClientImages[I] := g_WHumEffects[I - Images_HumEffectBegin];
        end;
      Images_MyHumEffect: g_ClientImages[I] := g_WMyHumEffect;

      Images_NpcBegin..Images_NpcEnd: begin
          g_ClientImages[I] := g_WNpcs[I - Images_NpcBegin];
        end;
      Images_Npc2: g_ClientImages[I] := g_WNpc2;

      Images_WeaponBegin..Images_WeaponEnd: begin
          g_ClientImages[I] := g_WWeapons[I - Images_WeaponBegin];
        end;

      Images_MonBegin..Images_MonEnd: begin
          g_ClientImages[I] := g_WMons[I - Images_MonBegin];
        end;

      Images_ObjectBegin..Images_ObjectEnd: begin
          g_ClientImages[I] := g_WObjects[I - Images_ObjectBegin];
        end;

      Images_HumKiller: g_ClientImages[I] := g_WHumKiller;
      Images_HumRanger: g_ClientImages[I] := g_WHumRanger;
      Images_WeaponKillerL: g_ClientImages[I] := g_WWeaponKillerL;
      Images_WeaponKillerR: g_ClientImages[I] := g_WWeaponKillerR;
      Images_HairKiller: g_ClientImages[I] := g_WHairKiller;
      Images_WeaponRanger: g_ClientImages[I] := g_WWeaponRanger;
      Images_HairRanger: g_ClientImages[I] := g_WHairRanger;
      Images_MagicKiller: g_ClientImages[I] := g_WMagicKiller;
    end;
  end;
end;

procedure LoadWMImagesLib(aowner: TComponent);
var
  i: Integer;
begin
  g_WUIBImages := TUIBImages.Create;
  g_WMainImages := CreateWMImages(t_wmM2Def);
  g_WMain2Images := CreateWMImages(t_wmM2Def);
  g_WMain3Images := CreateWMImages(t_wmM2Def);
  g_WMain99Images := CreateWMImages(t_wmMyImage);
  g_WEnvironmentImages := CreateWMImages(t_wmMyImage);
  g_WMobMagicImages := CreateWMImages(t_wmMyImage);
  g_WChrSelImages := CreateWMImages(t_wmMyImage);
  g_WOChrSelImages := CreateWMImages(t_wmM2Def);
  g_WMMapImages := CreateWMImages(t_wmM2Def);
  g_WMyMMapImages := CreateWMImages(t_wmMyImage);
  for I := Low(g_WTiles) to High(g_WTiles)-1  do
    g_WTiles[i] := CreateWMImages(t_wmM2Def);
  g_WTiles[High(g_WTiles)] := CreateWMImages(t_wmMyImage); //last file is the .pak
  for I := Low(g_WSMTiles) to High(g_WSMTiles)-1  do
    g_WSMTiles[i] := CreateWMImages(t_wmM2Def);
  g_WSMTiles[High(g_WSMTiles)] := CreateWMImages(t_wmMyImage); //last file is the .pak
  for I := Low(g_WMir3MapObjects) to High(g_WMir3MapObjects)  do
    g_WMir3MapObjects[i] := CreateWMImages(t_wmM3Def);
  g_WAniTiles := CreateWMImages(t_wmM2Def);
  //g_WHumWingImages := CreateWMImages(t_wmM2Def);
  g_WHumHorseWingImages := CreateWMImages(t_wmMyImage);
  g_WFaceImages := CreateWMImages(t_wmMyImage);
  g_WHairImgImages := CreateWMImages(t_wmMyImage);
  g_WMagIconImages := CreateWMImages(t_wmMyImage);
  g_WDefMagIconImages := CreateWMImages(t_wmM2Def);
  g_WDefMagIcon2Images := CreateWMImages(t_wmM2Def);
  g_WMagicImages := CreateWMImages(t_wmM2Def);
  g_WMagic2Images := CreateWMImages(t_wmM2Def);
  g_WMagic3Images := CreateWMImages(t_wmM2Def);
  g_WMagic4Images := CreateWMImages(t_wmM2Def);
  g_WMagic5Images := CreateWMImages(t_wmM2Def);
  g_WMagic6Images := CreateWMImages(t_wmM2Def);
  g_WMagic7Images := CreateWMImages(t_wmM2Def);
  g_WMagic8Images := CreateWMImages(t_wmM2Def);
  g_WMagic9Images := CreateWMImages(t_wmM2Def);
  g_WMagic10Images := CreateWMImages(t_wmM2Def);
  g_WMagic99Images := CreateWMImages(t_wmMyImage);

  g_WDragonImages := CreateWMImages(t_wmM2Def);
  g_WEffectImages := CreateWMImages(t_wmM2Def);
  g_WUI1Images := CreateWMImages(t_wmM2Def);
  g_WUI3Images := CreateWMImages(t_wmM2Def);

  g_WMusicImages := CreateWMImages(t_wmMyImage);
  g_WSettingImages := CreateWMImages(t_wmMyImage);

  g_WItemEffectImages := CreateWMImages(t_wmMyImage);

  g_WHumHorseImages := CreateWMImages(t_wmMyImage);
  g_WRideImages := CreateWMImages(t_wmMyImage);
  g_WKuLouImages := CreateWMImages(t_wmM2Def); 

  g_WcboHumImages := CreateWMImages(t_wmM2wis);
  g_WcboHum2Images := CreateWMImages(t_wmM2wis);
  g_WcboHumEffectImages := CreateWMImages(t_wmM2wis);
  g_WcboHumEffect2Images := CreateWMImages(t_wmM2Def);
  g_WcboHairImages := CreateWMImages(t_wmM2wis);
  g_WcboEffectImages := CreateWMImages(t_wmM2wis);
  g_WcboWeaponImages := CreateWMImages(t_wmM2wis);
  g_WcboWeapon2Images := CreateWMImages(t_wmM2Def);

  g_ChrSel2Images := CreateWMImages(t_wmM2Def);
  g_LoginEffectImages := CreateWMImages(t_wmM2Def);

  for i := Low(g_WObjects) to High(g_WObjects) do begin
    if i >= 30 then g_WObjects[i] := CreateWMImages(t_wmMyImage)
    else g_WObjects[i] := CreateWMImages(t_wmM2Def);
  end;
  for i := Low(g_WMons) to High(g_WMons) do begin
    if i >= 51 then g_WMons[i] := CreateWMImages(t_wmMyImage)
    else g_WMons[i] := CreateWMImages(t_wmM2Def);
  end;
  for i := Low(g_WNpcs) to High(g_WNpcs) do begin
    if i >= 1 then g_WNpcs[i] := CreateWMImages(t_wmMyImage)
    else g_WNpcs[i] := CreateWMImages(t_wmM2Def);
  end;
  g_WNpc2 := CreateWMImages(t_wmM2Def);
   
  for i := Low(g_WWeapons) to High(g_WWeapons) do begin
    case I of
      0: g_WWeapons[i] := CreateWMImages(t_wmM2Def);
      1: g_WWeapons[i] := CreateWMImages(t_wmM2wis);
      2: g_WWeapons[i] := CreateWMImages(t_wmM2Def);
      3: g_WWeapons[i] := CreateWMImages(t_wmMyImage);
    end;
  end;
  for i := Low(g_WHums) to High(g_WHums) do begin
    if i >= 3 then g_WHums[i] := CreateWMImages(t_wmMyImage)
    else g_WHums[i] := CreateWMImages(t_wmM2Def);
  end;
  for i := Low(g_WHumEffects) to High(g_WHumEffects) do begin
    g_WHumEffects[i] := CreateWMImages(t_wmM2Def);
  end;
  g_WMyHumEffect := CreateWMImages(t_wmMyImage);
  for i := Low(g_WBagItems) to High(g_WBagItems) do begin
    if i >= 1 then begin
      g_WBagItems[i] := CreateWMImages(t_wmMyImage);
      g_WStateItems[i] := CreateWMImages(t_wmMyImage);
      g_WDnItems[i] := CreateWMImages(t_wmMyImage);
    end else begin
      g_WBagItems[i] := CreateWMImages(t_wmM2Def);
      g_WStateItems[i] := CreateWMImages(t_wmM2Def);
      g_WDnItems[i] := CreateWMImages(t_wmM2Def);
    end;
  end;
  g_WHumKiller := CreateWMImages(t_wmM2Def);
  g_WHumRanger := CreateWMImages(t_wmM2Def);
  g_WWeaponKillerL := CreateWMImages(t_wmM2Def);
  g_WWeaponKillerR := CreateWMImages(t_wmM2Def);
  g_WHairKiller := CreateWMImages(t_wmM2Def);
  g_WWeaponRanger := CreateWMImages(t_wmM2Def);
  g_WHairRanger := CreateWMImages(t_wmM2Def);
  g_WMagicKiller := CreateWMImages(t_wmM2Def);
  RefClientImages();
end;

procedure InitWMImagesLibEx();
{var
  i: Integer;      }
begin
 {
  g_WMainImages.DXDraw := DDxDraw;
  g_WMainImages.DDraw := DDxDraw.DDraw;

  g_WMain2Images.DXDraw := DDxDraw;
  g_WMain2Images.DDraw := DDxDraw.DDraw;

  g_WMain3Images.DXDraw := DDxDraw;
  g_WMain3Images.DDraw := DDxDraw.DDraw;

  g_WMain99Images.DXDraw := DDxDraw;
  g_WMain99Images.DDraw := DDxDraw.DDraw;

  g_WChrSelImages.DXDraw := DDxDraw;
  g_WChrSelImages.DDraw := DDxDraw.DDraw;

  g_WMMapImages.DXDraw := DDxDraw;
  g_WMMapImages.DDraw := DDxDraw.DDraw;

  g_WTilesImages.DXDraw := DDxDraw;
  g_WTilesImages.DDraw := DDxDraw.DDraw;

  g_WSmTilesImages.DXDraw := DDxDraw;
  g_WSmTilesImages.DDraw := DDxDraw.DDraw;

  g_WHumWingImages.DXDraw := DDxDraw;
  g_WHumWingImages.DDraw := DDxDraw.DDraw;

  g_WHumHorseWingImages.DXDraw := DDxDraw;
  g_WHumHorseWingImages.DDraw := DDxDraw.DDraw;

  g_WFaceImages.DxDraw := DDxDraw;
  g_WFaceImages.DDraw := DDxDraw.DDraw;

  g_WHairImgImages.DXDraw := DDxDraw;
  g_WHairImgImages.DDraw := DDxDraw.DDraw;

  g_WMagIconImages.DXDraw := DDxDraw;
  g_WMagIconImages.DDraw := DDxDraw.DDraw;

  g_WMagicImages.DXDraw := DDxDraw;
  g_WMagicImages.DDraw := DDxDraw.DDraw;

  g_WMagic2Images.DXDraw := DDxDraw;
  g_WMagic2Images.DDraw := DDxDraw.DDraw;

  g_WMagic3Images.DXDraw := DDxDraw;
  g_WMagic3Images.DDraw := DDxDraw.DDraw;

  g_WMagic4Images.DXDraw := DDxDraw;
  g_WMagic4Images.DDraw := DDxDraw.DDraw;

  g_WMagic5Images.DXDraw := DDxDraw;
  g_WMagic5Images.DDraw := DDxDraw.DDraw;

  g_WMagic6Images.DXDraw := DDxDraw;
  g_WMagic6Images.DDraw := DDxDraw.DDraw;

  g_WMagic99Images.DXDraw := DDxDraw;
  g_WMagic99Images.DDraw := DDxDraw.DDraw;

  g_WDragonImages.DXDraw := DDxDraw;
  g_WDragonImages.DDraw := DDxDraw.DDraw;

  g_WEffectImages.DXDraw := DDxDraw;
  g_WEffectImages.DDraw := DDxDraw.DDraw;

  g_WItemEffectImages.DXDraw := DDxDraw;
  g_WItemEffectImages.DDraw := DDxDraw.DDraw;

  g_WHumHorseImages.DXDraw := DDxDraw;
  g_WHumHorseImages.DDraw := DDxDraw.DDraw;

  g_WRideImages.DXDraw := DDxDraw;
  g_WRideImages.DDraw := DDxDraw.DDraw;

  g_WcboHumImages.DXDraw := DDxDraw;
  g_WcboHumImages.DDraw := DDxDraw.DDraw;

  g_WcboHumEffectImages.DXDraw := DDxDraw;
  g_WcboHumEffectImages.DDraw := DDxDraw.DDraw;

  g_WcboHairImages.DXDraw := DDxDraw;
  g_WcboHairImages.DDraw := DDxDraw.DDraw;

  g_WcboEffectImages.DXDraw := DDxDraw;
  g_WcboEffectImages.DDraw := DDxDraw.DDraw;

  g_WcboWeaponImages.DXDraw := DDxDraw;
  g_WcboWeaponImages.DDraw := DDxDraw.DDraw;

  for i := Low(g_WObjects) to High(g_WObjects) do begin
    g_WObjects[i].DXDraw := DDxDraw;
    g_WObjects[i].DDraw := DDxDraw.DDraw;
  end;
  for i := Low(g_WMons) to High(g_WMons) do begin
    g_WMons[i].DXDraw := DDxDraw;
    g_WMons[i].DDraw := DDxDraw.DDraw;
  end;
  for i := Low(g_WNpcs) to High(g_WNpcs) do begin
    g_WNpcs[i].DXDraw := DDxDraw;
    g_WNpcs[i].DDraw := DDxDraw.DDraw;
  end;
  for i := Low(g_WWeapons) to High(g_WWeapons) do begin
    g_WWeapons[i].DXDraw := DDxDraw;
    g_WWeapons[i].DDraw := DDxDraw.DDraw;
  end;
  for i := Low(g_WHums) to High(g_WHums) do begin
    g_WHums[i].DXDraw := DDxDraw;
    g_WHums[i].DDraw := DDxDraw.DDraw;
  end;
  for i := Low(g_WBagItems) to High(g_WBagItems) do begin
    g_WBagItems[i].DXDraw := DDxDraw;
    g_WBagItems[i].DDraw := DDxDraw.DDraw;

    g_WStateItems[i].DXDraw := DDxDraw;
    g_WStateItems[i].DDraw := DDxDraw.DDraw;

    g_WDnItems[i].DXDraw := DDxDraw;
    g_WDnItems[i].DDraw := DDxDraw.DDraw;
  end;       }
end;

procedure InitWMImagesLib(password: string);
   procedure InitializeImage(var AWMImages: TWMImages);
   var
     sFileName, sPassword: string;
     vLibType: TLibType;
   begin

     if (not AWMImages.Initialize()) and (AWMImages.FileName <> '') then begin
       //mir2: if the .wil file is not found, try reading .wzl instead
       if (AWMImages.WILType in [t_wmM2Def, t_wmM2wis]) then
       begin
         sFileName := ChangeFileExt(AWMImages.FileName, '.wzl');
         //DebugOutStr(sFileName);
         vLibType := AWMImages.LibType;
         sPassword := AWMImages.Password;
         AWMImages.Finalize;
         AWMImages.Free;
         AWMImages := CreateWMImages(t_wmM2Zip);
         AWMImages.FileName := sFileName;
         AWMImages.LibType := vLibType;
         AWMImages.Password := sPassword;
         AWMImages.Initialize();
       end;
       //mir3: if the .wil file is not found, try reading the .miz instead
       if (AWMImages.WILType = t_wmM3Def) then
       begin
         sFileName := ChangeFileExt(AWMImages.FileName, '.MIZ');
         //DebugOutStr(sFileName);
         vLibType := AWMImages.LibType;
         sPassword := AWMImages.Password;
         AWMImages.Finalize;
         AWMImages.Free;
         AWMImages := CreateWMImages(t_wmM3Zip);
         AWMImages.FileName := sFileName;
         AWMImages.LibType := vLibType;
         AWMImages.Password := sPassword;
         AWMImages.Initialize();
       end;
     end;
   end;
var
  i: Integer;
  sMapState: array[0..4] of string;
//  List: TStringList;
begin
{$IF Var_Free = 1}
  password := '';
{$IFEND}
  g_WUIBImages.Initialize;
  
  g_WMainImages.FileName := MAINIMAGEFILE;
  g_WMainImages.LibType := ltUseCache;
  g_WMainImages.Password := password;
  InitializeImage(g_WMainImages);

  g_WMain2Images.FileName := MAINIMAGEFILE2;
  g_WMain2Images.LibType := ltUseCache;
  g_WMain2Images.Password := password;
  InitializeImage(g_WMain2Images);

  g_WMain3Images.FileName := MAINIMAGEFILE3;
  g_WMain3Images.LibType := ltUseCache;
  g_WMain3Images.Password := password;
  InitializeImage(g_WMain3Images);

  g_WMain99Images.FileName := MAINIMAGEFILE99;
  g_WMain99Images.LibType := ltUseCache;
  g_WMain99Images.Password := password;
  InitializeImage(g_WMain99Images);

  g_WEnvironmentImages.FileName := ENVIRONMENT;
  g_WEnvironmentImages.LibType := ltUseCache;
  g_WEnvironmentImages.Password := password;
  InitializeImage(g_WEnvironmentImages);

  g_WMobMagicImages.FileName := MOBMAGICIMAGEFILE;
  g_WMobMagicImages.LibType := ltUseCache;
  g_WMobMagicImages.Password := password;
  InitializeImage(g_WMobMagicImages);

  g_WChrSelImages.FileName := CHRSELIMAGEFILE;
  g_WChrSelImages.LibType := ltUseCache;
  g_WChrSelImages.Password := password;
  InitializeImage(g_WChrSelImages);

  g_WOChrSelImages.FileName := OCHRSELIMAGEFILE;
  g_WOChrSelImages.LibType := ltUseCache;
  g_WOChrSelImages.Password := password;
  InitializeImage(g_WOChrSelImages);

  g_WMMapImages.FileName := MINMAPIMAGEFILE;
  g_WMMapImages.LibType := ltUseCache;
  g_WMMapImages.Password := password;
  InitializeImage(g_WMMapImages);

  g_WMyMMapImages.FileName := MINMAPIMAGEFILE2;
  g_WMyMMapImages.LibType := ltUseCache;
  g_WMyMMapImages.Password := password;
  InitializeImage(g_WMyMMapImages);

  g_WAniTiles.FileName := ANITILEFILE;
  g_WAniTiles.LibType := ltUseCache;
  g_WAniTiles.Password := password;
  InitializeImage(g_WAniTiles);

  for i := Low(g_WTiles) to High(g_WTiles) do begin
    g_WTiles[i].FileName := g_WTilesFiles[i];
    g_WTiles[i].LibType := ltUseCache;
    g_WTiles[i].Password := password;
    InitializeImage(g_WTiles[i]);
  end;

  for i := Low(g_WSMTiles) to High(g_WSMTiles) do begin
    g_WSMTiles[i].FileName := g_WSmTilesFiles[i];
    g_WSMTiles[i].LibType := ltUseCache;
    g_WSMTiles[i].Password := password;
    InitializeImage(g_WSMTiles[i]);
  end;
  //annoying mir3 map system
  sMapState[0] := '';
  sMapState[1] := 'wood';
  sMapState[2] := 'sand';
  sMapState[3] := 'snow';
  sMapState[4] := 'forest';
  for I := 0 to High(sMapState) do begin
    g_WMir3MapObjects[0+(i*15)].FileName := '.\Resource\Mir3\Tilesc' + sMapState[i] + '.wil';
    g_WMir3MapObjects[1+(i*15)].FileName := '.\Resource\Mir3\Tiles30c' + sMapState[i] + '.wil';
    g_WMir3MapObjects[2+(i*15)].FileName := '.\Resource\Mir3\Tiles5c' + sMapState[i] + '.wil';
    g_WMir3MapObjects[3+(i*15)].FileName := '.\Resource\Mir3\Smtilesc' + sMapState[i] + '.wil';
    g_WMir3MapObjects[4+(i*15)].FileName := '.\Resource\Mir3\Housesc' + sMapState[i] + '.wil';
    g_WMir3MapObjects[5+(i*15)].FileName := '.\Resource\Mir3\Cliffsc' + sMapState[i] + '.wil';
    g_WMir3MapObjects[6+(i*15)].FileName := '.\Resource\Mir3\Dungeonsc' + sMapState[i] + '.wil';
    g_WMir3MapObjects[7+(i*15)].FileName := '.\Resource\Mir3\Innersc' + sMapState[i] + '.wil';
    g_WMir3MapObjects[8+(i*15)].FileName := '.\Resource\Mir3\Furnituresc' + sMapState[i] + '.wil';
    g_WMir3MapObjects[9+(i*15)].FileName := '.\Resource\Mir3\Wallsc' + sMapState[i] + '.wil';
    g_WMir3MapObjects[10+(i*15)].FileName := '.\Resource\Mir3\SmObjectsc' + sMapState[i] + '.wil';
    g_WMir3MapObjects[11+(i*15)].FileName := '.\Resource\Mir3\Animationsc' + sMapState[i] + '.wil';
    g_WMir3MapObjects[12+(i*15)].FileName := '.\Resource\Mir3\Object1c' + sMapState[i] + '.wil';
    g_WMir3MapObjects[13+(i*15)].FileName := '.\Resource\Mir3\Object2c' + sMapState[i] + '.wil';
  end;

  for i := low(g_WMir3MapObjects) to High(g_WMir3MapObjects) do begin
    g_WMir3MapObjects[i].LibType := ltUseCache;
    g_WMir3MapObjects[i].Password := password;
    InitializeImage(g_WMir3MapObjects[i]);
  end;
  //end of annoying mir3 map system

  g_WUI1Images.FileName := UI1FILE;
  g_WUI1Images.LibType := ltUseCache;
  g_WUI1Images.Password := password;
  InitializeImage(g_WUI1Images);

  g_WUI3Images.FileName := UI3FILE;
  g_WUI3Images.LibType := ltUseCache;
  g_WUI3Images.Password := password;
  InitializeImage(g_WUI3Images);

  g_ChrSel2Images.FileName := CHARSELECT2IMAGESFILE;
  g_ChrSel2Images.LibType := ltUseCache;
  g_ChrSel2Images.Password := password;
  InitializeImage(g_ChrSel2Images);

  g_LoginEffectImages.FileName := LOGINEFFECTIMAGESFILE;
  g_LoginEffectImages.LibType := ltUseCache;
  g_LoginEffectImages.Password := password;
  InitializeImage(g_LoginEffectImages);


  {g_WHumWingImages.FileName := HUMWINGIMAGESFILE;
  g_WHumWingImages.LibType := ltUseCache;
  g_WHumWingImages.ChangeAlpha := True;
  g_WHumWingImages);   }

  g_WHumHorseWingImages.FileName := HUMHORSEWINGIMAGESFILE;
  g_WHumHorseWingImages.LibType := ltUseCache;
  g_WHumHorseWingImages.Password := password;
  InitializeImage(g_WHumHorseWingImages);

  g_WFaceImages.FileName := FACEFILE;
  g_WFaceImages.LibType := ltUseCache;
  g_WFaceImages.Password := password;
  InitializeImage(g_WFaceImages);

  g_WHairImgImages.FileName := HAIRIMGIMAGESFILE;
  g_WHairImgImages.LibType := ltUseCache;
  g_WHairImgImages.Password := password;
  InitializeImage(g_WHairImgImages);

  g_WMagIconImages.FileName := MAGICONIMAGESFILE;
  g_WMagIconImages.LibType := ltUseCache;
  g_WMagIconImages.Password := password;
  InitializeImage(g_WMagIconImages);

  g_WDefMagIconImages.FileName := DEFMAGICONIMAGESFILE;
  g_WDefMagIconImages.LibType := ltUseCache;
  g_WDefMagIconImages.Password := password;
  InitializeImage(g_WDefMagIconImages);

  g_WDefMagIcon2Images.FileName := DEFMAGICONIMAGESFILE2;
  g_WDefMagIcon2Images.LibType := ltUseCache;
  g_WDefMagIcon2Images.Password := password;
  InitializeImage(g_WDefMagIcon2Images);

  g_WMagicImages.FileName := MAGICIMAGESFILE;
  g_WMagicImages.LibType := ltUseCache;
  g_WMagicImages.Password := password;
 // g_WMagicImages.ChangeAlpha := True;
  InitializeImage(g_WMagicImages);

  g_WMagic2Images.FileName := MAGIC2IMAGESFILE;
  g_WMagic2Images.LibType := ltUseCache;
  g_WMagic2Images.Password := password;
 // g_WMagic2Images.ChangeAlpha := True;
  InitializeImage(g_WMagic2Images);

  g_WMagic3Images.FileName := MAGIC3IMAGESFILE;
  g_WMagic3Images.LibType := ltUseCache;
  g_WMagic3Images.Password := password;
 // g_WMagic3Images.ChangeAlpha := True;
  InitializeImage(g_WMagic3Images);

  g_WMagic4Images.FileName := MAGIC4IMAGESFILE;
  g_WMagic4Images.LibType := ltUseCache;
  g_WMagic4Images.Password := password;
//  g_WMagic4Images.ChangeAlpha := True;
  InitializeImage(g_WMagic4Images);

  g_WMagic5Images.FileName := MAGIC5IMAGESFILE;
  g_WMagic5Images.LibType := ltUseCache;
  g_WMagic5Images.Password := password;
 // g_WMagic5Images.ChangeAlpha := True;
  InitializeImage(g_WMagic5Images);

  g_WMagic6Images.FileName := MAGIC6IMAGESFILE;
  g_WMagic6Images.LibType := ltUseCache;
  g_WMagic6Images.Password := password;
 // g_WMagic6Images.ChangeAlpha := True;
  InitializeImage(g_WMagic6Images);

  g_WMagic7Images.FileName := MAGIC7IMAGESFILE;
  g_WMagic7Images.LibType := ltUseCache;
  g_WMagic7Images.Password := password;
 // g_WMagic7Images.ChangeAlpha := True;
  InitializeImage(g_WMagic7Images);

  g_WMagic8Images.FileName := MAGIC8IMAGESFILE;
  g_WMagic8Images.LibType := ltUseCache;
  g_WMagic8Images.Password := password;
 // g_WMagic8Images.ChangeAlpha := True;
  InitializeImage(g_WMagic8Images);

  g_WMagic9Images.FileName := MAGIC9IMAGESFILE;
  g_WMagic9Images.LibType := ltUseCache;
  g_WMagic9Images.Password := password;
 // g_WMagic9Images.ChangeAlpha := True;
  InitializeImage(g_WMagic9Images);

  g_WMagic10Images.FileName := MAGIC10IMAGESFILE;
  g_WMagic10Images.LibType := ltUseCache;
  g_WMagic10Images.Password := password;
 // g_WMagic9Images.ChangeAlpha := True;
  InitializeImage(g_WMagic10Images);

  g_WMagic99Images.FileName := MAGIC99IMAGESFILE;
  g_WMagic99Images.LibType := ltUseCache;
  g_WMagic99Images.Password := password;
  InitializeImage(g_WMagic99Images);

  g_WKuLouImages.FileName := MONNEWKULOUFILE;
  g_WKuLouImages.LibType := ltUseCache;
  g_WKuLouImages.Password := password;
  InitializeImage(g_WKuLouImages);

  g_WDragonImages.FileName := DRAGONIMAGEFILE;
  g_WDragonImages.LibType := ltUseCache;
  g_WDragonImages.Password := password;
  InitializeImage(g_WDragonImages);

  g_WEffectImages.FileName := EFFECTIMAGEFILE;
  g_WEffectImages.LibType := ltUseCache;
  g_WEffectImages.Password := password;
  InitializeImage(g_WEffectImages);

  g_WItemEffectImages.FileName := EFFECTITEMFILE;
  g_WItemEffectImages.LibType := ltUseCache;
  g_WItemEffectImages.Password := password;
  InitializeImage(g_WItemEffectImages);

  g_WHumHorseImages.FileName := HUMHORSEFILE;
  g_WHumHorseImages.LibType := ltUseCache;
  g_WHumHorseImages.Password := password;
  InitializeImage(g_WHumHorseImages);

  g_WRideImages.FileName := RIDEFILE;
  g_WRideImages.LibType := ltUseCache;
  g_WRideImages.Password := password;
  InitializeImage(g_WRideImages);

  g_WcboHumImages.FileName := HUMCOSIMAGESFILE;
  g_WcboHumImages.LibType := ltUseCache;
  g_WcboHumImages.Password := password;
  InitializeImage(g_WcboHumImages);

  g_WcboHum2Images.FileName := HUMCOSIMAGESFILE2;
  g_WcboHum2Images.LibType := ltUseCache;
  g_WcboHum2Images.Password := password;
  InitializeImage(g_WcboHum2Images);

  g_WcboHumEffectImages.FileName := HUMCOSWINGIMAGESFILE;
  g_WcboHumEffectImages.LibType := ltUseCache;
  g_WcboHumEffectImages.Password := password;
  //g_WcboHumEffectImages.ChangeAlpha := True;
  InitializeImage(g_WcboHumEffectImages);

  g_WcboHumEffect2Images.FileName := HUMCOSWINGIMAGESFILE2;
  g_WcboHumEffect2Images.LibType := ltUseCache;
  g_WcboHumEffect2Images.Password := password;
  //g_WcboHumEffect2Images.ChangeAlpha := True;
  InitializeImage(g_WcboHumEffect2Images);

  g_WcboHairImages.FileName := HAIRCOSIMGIMAGESFILE;
  g_WcboHairImages.LibType := ltUseCache;
  g_WcboHairImages.Password := password;
  InitializeImage(g_WcboHairImages);


  g_WcboEffectImages.FileName := MAGICCOSIMAGESFILE;
  g_WcboEffectImages.LibType := ltUseCache;
  g_WcboEffectImages.Password := password;
  //g_WcboEffectImages.ChangeAlpha := True;
  InitializeImage(g_WcboEffectImages);

  g_WcboWeaponImages.FileName := WEAPONCOSIMAGESFILE;
  g_WcboWeaponImages.LibType := ltUseCache;
  g_WcboWeaponImages.Password := password;
  InitializeImage(g_WcboWeaponImages);

  g_WcboWeapon2Images.FileName := WEAPONCOSIMAGESFILE2;
  g_WcboWeapon2Images.LibType := ltUseCache;
  g_WcboWeapon2Images.Password := password;
  InitializeImage(g_WcboWeapon2Images);

  for i := Low(g_WObjects) to High(g_WObjects) do begin
    g_WObjects[i].FileName := g_WObjectFiles[i];
    g_WObjects[i].LibType := ltUseCache;
    g_WObjects[i].Password := password;
    InitializeImage(g_WObjects[i]);
  end;
  for i := Low(g_WMons) to High(g_WMons) do begin
    g_WMons[i].FileName := g_WMonFiles[i];
    g_WMons[i].LibType := ltUseCache;
    g_WMons[i].Password := password;
    InitializeImage(g_WMons[i]);
  end;

  for i := Low(g_WNpcs) to High(g_WNpcs) do begin
    g_WNpcs[i].FileName := g_WNpcFiles[i];
    g_WNpcs[i].LibType := ltUseCache;
    g_WNpcs[i].Password := password;
    InitializeImage(g_WNpcs[i]);
  end;

  g_WNpc2.FileName := NPC2FILE;
  g_WNpc2.LibType := ltUseCache;
  g_WNpc2.Password := password;
  InitializeImage(g_WNpc2);


  for i := Low(g_WWeapons) to High(g_WWeapons) do begin
    g_WWeapons[i].FileName := g_WWeaponFiles[i];
    g_WWeapons[i].LibType := ltUseCache;
    g_WWeapons[i].Password := password;
    InitializeImage(g_WWeapons[i]);
  end;

  for i := Low(g_WHums) to High(g_WHums) do begin
    g_WHums[i].FileName := g_WHumFiles[i];
    g_WHums[i].LibType := ltUseCache;
    g_WHums[i].Password := password;
    InitializeImage(g_WHums[i]);
  end;

  for i := Low(g_WHumEffects) to High(g_WHumEffects) do begin
    g_WHumEffects[i].FileName := g_WHumEffectFiles[i];
    g_WHumEffects[i].LibType := ltUseCache;
    g_WHumEffects[i].Password := password;
    InitializeImage(g_WHumEffects[i]);
  end;

  g_WMyHumEffect.FileName := MYHUMEFFECTFILE;
  g_WMyHumEffect.LibType := ltUseCache;
  g_WMyHumEffect.Password := password;
  InitializeImage(g_WMyHumEffect);


  for i := Low(g_WBagItems) to High(g_WBagItems) do begin
    g_WBagItems[i].FileName := g_WBagItemFiles[i];
    g_WBagItems[i].LibType := ltUseCache;
    g_WBagItems[i].Password := password;
    InitializeImage(g_WBagItems[i]);

    g_WStateItems[i].FileName := g_WStateItemFiles[i];
    g_WStateItems[i].LibType := ltUseCache;
    g_WStateItems[i].Password := password;
    InitializeImage(g_WStateItems[i]);

    g_WDnItems[i].FileName := g_WDnItemFiles[i];
    g_WDnItems[i].LibType := ltUseCache;
    g_WDnItems[i].Password := password;
    InitializeImage(g_WDnItems[i]);
  end;

  g_WHumKiller.FileName := HUMKILLERFILE;
  g_WHumKiller.LibType := ltUseCache;
  g_WHumKiller.Password := password;
  InitializeImage(g_WHumKiller);

  g_WHairKiller.FileName := HAIRKILLERFILE;
  g_WHairKiller.LibType := ltUseCache;
  g_WHairKiller.Password := password;
  InitializeImage(g_WHairKiller);

  g_WMagicKiller.FileName := MAGICKILLERFILE;
  g_WMagicKiller.LibType := ltUseCache;
  g_WMagicKiller.Password := password;
  InitializeImage(g_WMagicKiller);

  g_WWeaponKillerL.FileName := WEAPONKILLERLFILE;
  g_WWeaponKillerL.LibType := ltUseCache;
  g_WWeaponKillerL.Password := password;
  InitializeImage(g_WWeaponKillerL);

  g_WWeaponKillerR.FileName := WEAPONKILLERRFILE;
  g_WWeaponKillerR.LibType := ltUseCache;
  g_WWeaponKillerR.Password := password;
  InitializeImage(g_WWeaponKillerR);

  g_WHumRanger.FileName := HUMRANGERFILE;
  g_WHumRanger.LibType := ltUseCache;
  g_WHumRanger.Password := password;
  InitializeImage(g_WHumRanger);

  g_WWeaponRanger.FileName := WEAPONRANGERFILE;
  g_WWeaponRanger.LibType := ltUseCache;
  g_WWeaponRanger.Password := password;
  InitializeImage(g_WWeaponRanger);

  g_WHairRanger.FileName := HAIRRANGERFILE;
  g_WHairRanger.LibType := ltUseCache;
  g_WHairRanger.Password := password;
  InitializeImage(g_WHairRanger);

  RefClientImages();
  {List := TStringList.Create;
  for I := Low(g_ClientImages) to High(g_ClientImages) do begin
    List.Add(ExtractFileName(g_ClientImages[I].FileName) + #9 + IntToStr(I));
  end;
  List.SaveToFile('Files.txt');
  List.Free;    }
end;

procedure UnLoadWMImagesLibEx();
{var
  i: Integer;     }
begin
  {for I := Low(g_ClientImages) to High(g_ClientImages) do begin
    if g_ClientImages[i] <> nil then begin
      g_ClientImages[i].FreeTexture;
    end;
  end;   }
end;

procedure UnLoadWMImagesLib();
var
  i: Integer;
begin
  g_WUIBImages.Finalize;
  g_WUIBImages.Free;
  g_WUIBImages := nil;
  
  for I := Low(g_ClientImages) to High(g_ClientImages) do begin
    if g_ClientImages[i] <> nil then begin
      g_ClientImages[i].Finalize;
      g_ClientImages[i].Free;
      g_ClientImages[i] := nil;
    end;
  end;
end;

initialization
  begin
    FillChar(g_ClientImages, SizeOf(g_ClientImages), #0);
  end;

finalization
  begin
  end;

end.


