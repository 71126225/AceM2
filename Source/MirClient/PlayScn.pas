unit PlayScn;

interface

uses
  Windows, SysUtils, Classes, Graphics, Controls, Forms, HGE,
  HGETextures, IntroScn, Grobal2, cliUtil, HGEBase, Dialogs,
  Actor, HerbActor, AxeMon, SoundUtil, clEvent, WIL, DirectXGraphics, AxeMon2, AxeMon3,
  StdCtrls, ClFunc, magiceff, ExtCtrls, MShare, Share, MNShare, HGECanvas, HGEImages;

const
  //   MAPSURFACEWIDTH = 800;
  //   MAPSURFACEHEIGHT = 445;

  LONGHEIGHT_IMAGE = 35 {35};

  AAX = 16;
  SOFFX = 0;
  SOFFY = 0;
  LMX = 30;
  LMY = 26;

  MAXLIGHT = 5;

  HEALTHBAR_BLACK = 0;
  HEALTHBAR_RED = 1;

const
  //DRAWLISTCOUNT = 24;
  DRAWLISTCOUNT = 40;

type
  PShoftInt = ^shortint;
  TLightEffect = record
    Width: Integer;
    Height: Integer;
    PFog: PByte;
  end;
  TLightMapInfo = record
    ShiftX: Integer;
    ShiftY: Integer;
    light: Integer;
    bright: Integer;
  end;

  TDrawList = record
    ItemList: TList;
    ActorList: TList;
    DeathActorList: TList;
    ShopActorList: TList;
    MagicEffList: TList;
    ClEvent: TList;
  end;

  TPlayScene = class(TScene)
    m_MapSurface: TDXRenderTargetTexture;
    m_ObjSurface: TDXRenderTargetTexture; //0x0C
    m_MagSurface: TDXRenderTargetTexture; //0x0C
    m_LightSurface: TDXRenderTargetTexture;
    m_lighttemptick: longword;
    m_LightTempCount: byte;
//    m_MissionSurface: TDirectDrawSurface;
    m_HealthBarSurface: TDXImageTexture;
    m_boPlayChange: Boolean;
    m_dwPlayChangeTick: LongWord;


  private

    m_nMoveStepCount: Integer;
    m_dwAniTime: LongWord;
    m_nAniCount: Integer;
    m_nDefXX: Integer;
    m_nDefYY: Integer;
    m_MainSoundTimer: TTimer;
    level_of_light: Integer;
    depth_of_dark: Integer;
    level_of_light_tick: Integer;
    //procedure EdChatKeyPress(Sender: TObject; var Key: Char);
    procedure SoundOnTimer(Sender: TObject);
    //procedure ClearDropItem();
  public
    m_dwMoveTime: LongWord;
    MemoLog: TMemo;
    m_DrawArray: array[0..DRAWLISTCOUNT] of TDrawList;
    m_DrawIndex: LongWord;
    m_DrawOutsideList: TList;
    m_ActorList: TList;
    m_MagicList: TList;
    //    m_GroundEffectList: TList; //¹Ù´Ú¿¡ ±ò¸®´Â ¸¶¹ý ¸®½ºÆ®
    m_EffectList: TList; //¸¶¹ýÈ¿°ú ¸®½ºÆ®
    m_FlyList: TList; //³¯¾Æ´Ù´Ï´Â °Í (´øÁøµµ³¢, Ã¢, È­»ì)
    m_dwBlinkTime: LongWord;
    m_boViewBlink: Boolean;
//    LightSurface: ITarget;
    RectCanvas: TDXCanvas;
    HGE: IHGE;
    Images: THGEimages;

    constructor Create;
    destructor Destroy; override;
    function Initialize: Boolean; override;
    procedure Finalize; override;
    procedure Lost;
    procedure Recovered;
    procedure OpenScene; override;
    procedure CloseScene; override;
    procedure OpeningScene; override;
    //procedure DrawMiniMap(Surface: TDirectDrawSurface);
    procedure DrawTileMap(Sender: TObject);
    procedure PlayScene(MSurface: TDirectDrawSurface); override;
    procedure BeginScene();
    procedure PlaySurface(Sender: TObject);
    procedure MagicSurface(Sender: TObject);
    procedure LightSurface(Sender: TObject);
    procedure MagicLightSurface();
    procedure DrawCastingLight();
    procedure DrawMobMagicLight(user_object: TActor);
    procedure MapLightSurface(Sender: TObject);
    procedure AddActorLight(tx, ty, bx, by, loop_count: Integer; colour_of_light: string; actor: TActor; pulse_effect: Boolean);
    procedure AddShieldLight(tx, ty, bx, by, loop_count: Integer; colour_of_light: string; actor: TActor; pulse_effect: Boolean);
    procedure AddMapLight(tx, ty, light: Integer);

    procedure PlayDrawScreen();
    procedure PlayDrawCenterMsg();
    function CanDrawTileMap(): Boolean;
    function ButchAnimal(X, Y: Integer): TActor;

    function FindActor(id: Integer): TActor; overload;
    function FindActor(sname: string): TActor; overload;
    function FindNpcActor(id: Integer): TNpcActor;
    function FindActorXY(X, Y: Integer): TActor;
    function IsValidActor(Actor: TActor): Boolean;
    function NewActor(chrid: Integer; cx, cy, cdir: Word; cfeature, cstate: Integer; btSIdx: Integer = -1; btWuXin: Integer = -1): TActor;
    procedure SetMissionList(Actor: TNPCActor);
    procedure RefMissionList;
    procedure RefMissionInfo;
    procedure ClearMissionList(Actor: TActor);
    procedure SetMissionInfo(Actor: TNPCActor);
    procedure SetOperateHint(sHint: string);
    //procedure RefMissionHint;
    procedure ActorDied(Actor: TObject); //Á×Àº actor´Â ¸Ç À§·Î
    procedure SetActorDrawLevel(Actor: TObject; Level: Integer);
    procedure ClearActors;
    function DeleteActor(id: Integer): TActor;
    procedure DelActor(Actor: TObject);
    procedure SetEditChar(sMsg: string);
    procedure ClearGroup();
    procedure SetActorGroup(Actor: TActor);
    procedure SetMembersGroup(GroupMember: pTGroupMember; boGroup: Boolean);
      overload;
    procedure SetMembersGroup(GroupMembers: TList); overload;
    //procedure SetGroupNameColor(Actor: TActor; Color:Byte);
    procedure SendMsg(ident, chrid, X, Y, cdir, Feature, State: Integer; str: string; btSIdx: Integer = -1; btWuXin: Integer = -1);

    procedure NewMagic(aowner: TActor;
      magid, magnumb, cx, cy, tx, ty, targetcode: Integer;
      mtype: TMagicType;
      Recusion: Boolean;
      anitime: Integer;
      var bofly: Boolean);
    procedure DelMagic(magid: Integer);
    function NewFlyObject(aowner: TActor; cx, cy, tx, ty, targetcode: Integer;
      mtype: TMagicType): TMagicEff;
    //function  NewStaticMagic (aowner: TActor; tx, ty, targetcode, effnum: integer);

    procedure ScreenXYfromMCXY(cx, cy: Integer; var sx, sy: Integer);
    procedure CXYfromMouseXY(mx, my: Integer; var ccx, ccy: Integer);
    function GetCharacter(X, Y, wantsel: Integer; var nowsel: Integer; liveonly:
      Boolean): TActor;
    function GetAttackFocusCharacter(X, Y, wantsel: Integer; var nowsel:
      Integer; liveonly: Boolean): TActor;
    function IsSelectMyself(X, Y: Integer): Boolean;
    function GetDropItems(X, Y: Integer; var inames: string; var MaxWidth: Integer): pTDropItem;
    function GetXYDropItems(nX, nY: Integer): pTDropItem;
    procedure GetXYDropItemsList(nX, nY: Integer; var ItemList: TList);
    function CanHorseRun(sx, sy, ex, ey: Integer): Boolean;
    function CanHorseRunEx(sx, sy, ex, ey: Integer): Boolean;
    function CanRun(sx, sy, ex, ey: Integer): Boolean;
    function CanLeap(sx, sy, ex, ey: Integer): Boolean;
    function CanRunEx(sx, sy, ex, ey: Integer): Boolean;
    function CanWalk(mx, my: Integer): Boolean;
    function CanWalkEx(mx, my: Integer): Boolean;
    function CanWalkEx2(mx, my: Integer): Boolean;
    function CrashMan(mx, my: Integer): Boolean; //»ç¶÷³¢¸® °ãÄ¡´Â°¡?
    function CanFly(mx, my: Integer): Boolean;
    procedure RefreshScene;
    procedure CleanObjects;
    function CrashManEx(mx, my: Integer): Boolean;
    function CrashManEx2(mx, my: Integer): Boolean;
  end;

implementation

uses
  ClMain, FState2, FState, GameSetup, WMFile, Hutil32, NpcActor, EDcodeEx, MMSystem;

constructor TPlayScene.Create;
//var
//  nX, nY: Integer;v
var
  i: Integer;
begin
  m_MapSurface := nil;
  m_ObjSurface := nil;
  m_MagSurface := nil;
  m_LightSurface := nil;
  m_LightTempTick := FrmMain.m_CurrentTick;
  m_LightTempCount := 0;
  //m_MissionSurface := nil;
  m_HealthBarSurface := nil;
  //m_boCanShowMissionHint := False;
  //m_boShowMissionChange := False;
  //m_MsgList := TList.Create;
  m_ActorList := TList.Create;
  m_MagicList := TList.Create;
  //m_GroundEffectList := TList.Create;
  m_EffectList := TList.Create;
  m_FlyList := TList.Create;
  m_dwBlinkTime := FrmMain.m_CurrentTick;
  m_boViewBlink := FALSE;

  for i := Low(m_DrawArray) to High(m_DrawArray) do begin
    m_DrawArray[i].ItemList := TList.Create;
    m_DrawArray[i].ActorList := TList.Create;
    m_DrawArray[i].ShopActorList := TList.Create;
    m_DrawArray[i].DeathActorList := TList.Create;
    m_DrawArray[i].MagicEffList := TList.Create;
    m_DrawArray[i].ClEvent := TList.Create;
  end;
  m_DrawOutsideList := TList.Create;

  m_DrawIndex := 0;

  MemoLog := TMemo.Create(frmMain.Owner);
  with MemoLog do begin
    Parent := frmMain;
    BorderStyle := bsNone;
    Visible := FALSE;
    // Visible := True;
    Ctl3D := True;
    Left := 0;
    Top := 250;
    Width := 300;
    Height := 150;
  end;
  //2004/05/17

  m_dwMoveTime := FrmMain.m_CurrentTick;
  m_dwAniTime := FrmMain.m_CurrentTick;
  m_nAniCount := 0;
  m_nMoveStepCount := 0;
  m_MainSoundTimer := TTimer.Create(frmMain.Owner);
  with m_MainSoundTimer do begin
    OnTimer := SoundOnTimer;
    Interval := 1;
    Enabled := FALSE;
  end;
  level_of_light := 0;
  depth_of_dark := 70;
end;

destructor TPlayScene.Destroy;
var
  i: Integer;
begin
  //m_MsgList.Free;
  m_ActorList.Free;
  m_MagicList.Free;
  //m_GroundEffectList.Free;
  m_EffectList.Free;
  m_FlyList.Free;
  for i := Low(m_DrawArray) to High(m_DrawArray) do begin
    m_DrawArray[i].ItemList.Free;
    m_DrawArray[i].ActorList.Free;
    m_DrawArray[i].ShopActorList.Free;
    m_DrawArray[i].DeathActorList.Free;
    m_DrawArray[i].MagicEffList.Free;
    m_DrawArray[i].ClEvent.Free;
  end;
  m_DrawOutsideList.Free;
  inherited Destroy;
end;

procedure TPlayScene.SoundOnTimer(Sender: TObject);
begin
  SoundUtil.PlaySound(s_main_theme);
  m_MainSoundTimer.Interval := 46 * 1000;
end;


function TPlayScene.Initialize: Boolean;
var
  DXAccessInfo: TDXAccessInfo;
  Y, X: Integer;
  WriteBuffer: PWord;
begin
  Result := False;
  //¸üÐÂ
  m_MapSurface := TDXRenderTargetTexture.Create(g_DXCanvas);
  m_MapSurface.Size := Point(DEFMAXSCREENWIDTH + UNITX * 10, DEFMAXSCREENHEIGHT + UNITY * 10);
  m_MapSurface.Active := True;
  if not m_MapSurface.Active then
    exit;

  m_ObjSurface := TDXRenderTargetTexture.Create(g_DXCanvas);
  m_ObjSurface.Size := Point(DEFMAXSCREENWIDTH, DEFMAXSCREENHEIGHT);
  m_ObjSurface.Active := True;
  if not m_ObjSurface.Active then
    exit;

  m_MagSurface := TDXRenderTargetTexture.Create(g_DXCanvas);
  m_MagSurface.Size := Point(DEFMAXSCREENWIDTH, DEFMAXSCREENHEIGHT);
  m_MagSurface.Active := True;
  if not m_MagSurface.Active then
    exit;

  m_LightSurface := TDXRenderTargetTexture.Create(g_DXCanvas);
  m_LightSurface.Size := Point(DEFMAXSCREENWIDTH, DEFMAXSCREENHEIGHT);
  m_LightSurface.Active := True;
  if not m_LightSurface.Active then
    exit;

  m_HealthBarSurface := MakeDXImageTexture(30, 6, WILFMT_R5G6B5, g_DXCanvas);

  if m_HealthBarSurface = nil then exit;

  if m_HealthBarSurface.Lock(lfWriteOnly, DXAccessInfo) then begin
    Try
      for Y := 0 to m_HealthBarSurface.Size.Y - 1 do begin
        WriteBuffer := PWord(Integer(DXAccessInfo.Bits) + (DXAccessInfo.Pitch * Y));
        for X := 0 to m_HealthBarSurface.Size.X - 1 do begin
          case Y of
            0: WriteBuffer^ := 63488;
            1: WriteBuffer^ := 38912;
            2: WriteBuffer^ := 831;
            3: WriteBuffer^ := 31;
            4: WriteBuffer^ := 19705;
            5: WriteBuffer^ := 12944;  
          end;
          Inc(WriteBuffer);
        end;
      end;
    Finally
      m_HealthBarSurface.Unlock;
    End;
  end;
  Result := True;
end;

procedure TPlayScene.Finalize;
begin
  if m_MapSurface <> nil then
    m_MapSurface.Free;
  if m_ObjSurface <> nil then
    m_ObjSurface.Free;
  if m_MagSurface <> nil then
    m_MagSurface.Free;
  if m_LightSurface <> nil then
    m_LightSurface.Free;
  {if m_MissionSurface <> nil then
    m_MissionSurface.Free;  }
  if m_HealthBarSurface <> nil then
    m_HealthBarSurface.Free;
  m_MapSurface := nil;
  m_ObjSurface := nil;
  m_MagSurface := nil;
  m_LightSurface := nil;
  //m_MissionSurface := nil;

  m_HealthBarSurface := nil;
end;

procedure TPlayScene.OpenScene;
begin
  //g_WMainImages.ClearCache;
  //FrmDlg.ViewBottomBox(True);
  //FrmDlg2.DWndHint.Visible := True;
  //EdChat.Visible := TRUE;
  //EdChat.SetFocus;
  ClMain.HGE.Gfx_Restore(g_FScreenWidth, g_FScreenHeight, 16);
  SetImeMode(frmMain.Handle, LocalLanguage);
  FrmDlg.DBottom.Visible := True;
  FrmDlg2.DWndHint.Visible := True;

if g_nInterface = 2 then begin
  FrmDlg.DBottom3.Visible := True;
  FrmDlg.DBottom4.Visible := True;
  FrmDlg.DTopCharStatus.Visible := True;
  FrmDlg.DScrollBgTopMini.Visible := True;
  FrmDlg.DScrollBgBottomMini.Visible := True;
  FrmDlg.DScrollBgMiddleMini.Visible := True;

  FrmDlg.DChatImgBgLeftTopMini.Visible := True;
  FrmDlg.DChatImgBgLeftBottomMini.Visible := True;
  FrmDlg.DChatImgBgLeftMidleMini.Visible := True;

  FrmDlg.DChatImgBgTopMini.Visible := True;
  FrmDlg.DChatImgBgBottomMini.Visible := True;
  FrmDlg.DMiniMapFrame.Visible := True;
  FrmDlg.DTopCharAvatar.Visible := True;
end;

end;

procedure TPlayScene.CloseScene;
begin
  FrmDlg.DBottom.Visible := False;
  FrmDlg.DTop.Visible := False;
  FrmDlg2.DWndHint.Visible := False;
  FrmDlg.DWndSay.Visible := False;
  DScreen.ClearSysMsg;
  ClearBGM;

if g_nInterface = 2 then begin
  FrmDlg.DBottom3.Visible := False;
  FrmDlg.DBottom4.Visible := False;
  FrmDlg.DTopCharStatus.Visible := False;
  FrmDlg.DScrollBgTopMini.Visible := False;
  FrmDlg.DScrollBgBottomMini.Visible := False;
  FrmDlg.DScrollBgMiddleMini.Visible := False;

  FrmDlg.DChatImgBgLeftTopMini.Visible := False;
  FrmDlg.DChatImgBgLeftBottomMini.Visible := False;
  FrmDlg.DChatImgBgLeftMidleMini.Visible := False;

  FrmDlg.DChatImgBgTopMini.Visible := False;
  FrmDlg.DChatImgBgBottomMini.Visible := False;
  FrmDlg.DMiniMapFrame.Visible := False;
end;

end;

procedure TPlayScene.OpeningScene;
begin
end;

procedure TPlayScene.Recovered;
begin
  if m_MapSurface <> nil then
    m_MapSurface.Recovered;
  if m_ObjSurface <> nil then
    m_ObjSurface.Recovered;
  if m_MagSurface <> nil then
    m_MagSurface.Recovered;
  if m_LightSurface <> nil then
    m_LightSurface.Recovered;
end;

procedure TPlayScene.RefreshScene;
var
  i: Integer;
begin
  Map.m_OldClientRect.Left := -1;
  for i := 0 to m_ActorList.count - 1 do
    TActor(m_ActorList[i]).LoadSurface;
end;

procedure TPlayScene.ClearActors; //·Î±×¾Æ¿ô¸¸ »ç¿ë
var
  i: Integer;
begin
  for i := 0 to m_ActorList.count - 1 do begin
    if TActor(m_ActorList[i]).m_Group <> nil then begin
      TActor(m_ActorList[i]).m_Group.isScreen := nil;
      TActor(m_ActorList[i]).m_Group := nil;
    end;
    ClearMissionList(TActor(m_ActorList[i]));
    TActor(m_ActorList[i]).Free;
  end;
  m_ActorList.Clear;
  g_MySelf := nil;
  g_TargetCret := nil;
  g_FocusCret := nil;
  g_MagicTarget := nil;
  g_NPCTarget := nil;
  g_MagicLockTarget := nil;

  //¸¶¹ýµµ ÃÊ±âÈ­ ÇØ¾ßÇÔ.
  for i := 0 to m_EffectList.count - 1 do
    TMagicEff(m_EffectList[i]).Free;
  m_EffectList.Clear;
end;

procedure TPlayScene.CleanObjects;
var
  i: Integer;
begin
  for i := m_ActorList.count - 1 downto 0 do begin
    if TActor(m_ActorList[i]) <> g_MySelf then begin
      if TActor(m_ActorList[i]).m_Group <> nil then begin
        TActor(m_ActorList[i]).m_Group.isScreen := nil;
        TActor(m_ActorList[i]).m_Group := nil;
      end;
      ClearMissionList(TActor(m_ActorList[i]));
      TActor(m_ActorList[i]).Free;
      m_ActorList.Delete(i);
    end;
  end;
  //m_MsgList.Clear;
  g_TargetCret := nil;
  g_FocusCret := nil;
  g_MagicTarget := nil;
  g_NPCTarget := nil;
  g_MagicLockTarget := nil;
  //
  {for i := 0 to m_GroundEffectList.count - 1 do
    TMagicEff(m_GroundEffectList[i]).Free;
  m_GroundEffectList.Clear;      }
  for i := 0 to m_EffectList.count - 1 do
    TMagicEff(m_EffectList[i]).Free;
  m_EffectList.Clear;
  for i := 0 to m_FlyList.Count - 1 do begin
    TMagicEff(m_FlyList[i]).Free
  end;
  m_FlyList.Clear;
end;

{---------------------- Draw Map -----------------------}

procedure TPlayScene.DrawTileMap(Sender: TObject);
var
  i, j, nY, nX, nImgNumber: Integer;
  dsurface: TDirectDrawSurface;
  aX,aY: integer;
begin
  //drawingbottomline := g_FScreenHeight;
  with Map do
    if (m_ClientRect.Left = m_OldClientRect.Left) and (m_ClientRect.Top = m_OldClientRect.Top) then
      Exit;

  Map.m_OldClientRect := Map.m_ClientRect;
  //m_MapSurface.Fill(0);    
  if not g_boDrawTileMap then
    Exit;
 
  with Map.m_ClientRect do begin
    if g_FScreenHeight = 768 then nY := -UNITY * 1
    else nY := -UNITY * 4;

    for j := (Top - Map.m_nBlockTop - 1) to (Bottom - Map.m_nBlockTop + 1) do begin
      if g_FScreenWidth = 1024 then nX := AAX + 28 - UNITX * 2
      else nX := AAX + 14 - UNITX * 4;
      for i := (Left - Map.m_nBlockLeft - 2) to (Right - Map.m_nBlockLeft + 1) do begin
        if (i >= 0) and (i < LOGICALMAPUNIT * 3) and (j >= 0) and (j < LOGICALMAPUNIT * 3) then begin
          nImgNumber := (Map.m_MArr[i, j].BkImg and $7FFF);
          if nImgNumber > 0 then begin
            if (i mod 2 = 0) and (j mod 2 = 0) then begin
              nImgNumber := nImgNumber - 1;
             { if (nImgNumber > 24980) and (g_WMyTilesImages.boInitialize) then dsurface := g_WMyTilesImages.Images[nImgNumber - 24981]
              else      }
              if (Map.m_Marr[i,j].BkIndex > 99) then begin
                if(Map.m_MArr[i,j].BkIndex - 100) in [low(g_WMir3MapObjects) .. high(g_WMir3MapObjects)] then
                  dsurface := g_WMir3MapObjects[Map.m_MArr[i,j].BkIndex -100].Images[nImgNumber]
                else
                  dsurface := g_WMir3MapObjects[0].Images[nImgNumber];
              end else begin
                if (Map.m_MArr[i,j].BkIndex in [low(g_WTiles) ..high(g_WTiles)]) then //safety check to prevent errors
                  dsurface := g_WTiles[Map.m_MArr[i,j].BkIndex].Images[nImgNumber]
                else
                  dsurface := g_WTiles[0].Images[nImgNumber];
              end;
              if dsurface <> nil then
                m_MapSurface.Draw(nX, nY, dsurface.ClientRect, dsurface, FALSE);
            end;
          end;
        end;
        Inc(nX, UNITX);
      end;
      Inc(nY, UNITY);
    end;
  end;
  with Map.m_ClientRect do begin
    if g_FScreenHeight = 768 then nY := -UNITY * 1
    else nY := -UNITY * 4;
    for j := (Top - Map.m_nBlockTop - 1) to (Bottom - Map.m_nBlockTop + 1) + LONGHEIGHT_IMAGE do begin
      if g_FScreenWidth = 1024 then nX := AAX + 28 - UNITX * 2
      else nX := AAX + 14 - UNITX * 4;
      for i := (Left - Map.m_nBlockLeft - 2) to (Right - Map.m_nBlockLeft + 1) do begin

        if (i >= 0) and (i < LOGICALMAPUNIT * 3) and (j >= 0) {and (j < LOGICALMAPUNIT * 3)} then begin
          aX:=0;
          aY:=0;
          nImgNumber := Map.m_MArr[i, j].MidImg;
          if nImgNumber > 0 then begin
            nImgNumber := nImgNumber - 1;
            if (Map.m_MArr[i,j].MidIndex < 100) then begin
            { dont draw mir3 at this stage!
              if (Map.m_MArr[i,j].MidIndex - 100) in [low(g_WMir3MapObjects) .. high(g_WMir3MapObjects)] then
                dsurface := g_WMir3MapObjects[Map.m_MArr[i,j].MidIndex - 100].getCachedImage(nImgNumber, aX, aY)
              else
                dsurface := g_WMir3MapObjects[0].getCachedImage(nImgNumber, aX, aY);
              if dsurface <> nil then
                m_MapSurface.Draw(nX + (UNITX div 2) + aX, nY + UNITY + aY - dsurface.Height, dsurface.ClientRect, dsurface, true);
            end else begin
            }
              if (Map.m_MArr[i,j].MidIndex in [low(g_WSMTiles)..high(g_WSMTiles)]) then
                dsurface := g_WSmTiles[Map.m_MArr[i,j].MidIndex].Images[nImgNumber]
              else
                dsurface := g_WSmTiles[0].Images[nImgNumber];
              if dsurface <> nil then
                m_MapSurface.Draw(nX + aX, nY + aY, dsurface.ClientRect, dsurface, true);
            end;

          end;
        end;
        Inc(nX, UNITX);
      end;
      Inc(nY, UNITY);
    end;
  end;
end;


{----------------------- Æ÷±×, ¶óÀÌÆ® Ã³¸® -----------------------}
(*
procedure TPlayScene.LoadFog; //¶óÀÌÆ® µ¥ÀÌÅ¸ ÀÐ±â
var
  i, fhandle, w, h, prevsize: Integer;
  cheat: Boolean;
begin
  prevsize := 0; //Á¶ÀÛ Ã¼Å©
  cheat := FALSE;
  for i := 0 to MAXLIGHT do begin
    if FileExists(LightFiles[i]) then begin
      fhandle := FileOpen(LightFiles[i], fmOpenRead or fmShareDenyNone);
      FileRead(fhandle, w, sizeof(Integer));
      FileRead(fhandle, h, sizeof(Integer));
      m_Lights[i].Width := w;
      m_Lights[i].Height := h;
      m_Lights[i].PFog := AllocMem(w * h + 8);
      if prevsize < w * h then begin
        FileRead(fhandle, m_Lights[i].PFog^, w * h);
      end
      else
        cheat := True;
      prevsize := w * h;
      FileClose(fhandle);
    end;
  end;
  if cheat then
    for i := 0 to MAXLIGHT do begin
      if m_Lights[i].PFog <> nil then
        SafeFillChar(m_Lights[i].PFog^, m_Lights[i].Width * m_Lights[i].Height + 8,
          #0);
    end;
end;
     *)
{
procedure TPlayScene.ClearDropItem;
var
  i: Integer;
  DropItem: pTDropItem;
begin
  for i := g_DropedItemList.count - 1 downto 0 do begin
    DropItem := g_DropedItemList.Items[i];
    if DropItem = nil then begin
      g_DropedItemList.Delete(i);
      continue;
    end;
    if (abs(DropItem.X - g_MySelf.m_nCurrX) > 20) and (abs(DropItem.Y - g_MySelf.m_nCurrY) > 20) then begin
      DisopseDropItem(DropItem, 0);
      g_DropedItemList.Delete(i);
    end;
  end;
end;   }

procedure TPlayScene.BeginScene();
  function CheckOverlappedObject(myrc, obrc: TRect): Boolean;
  begin
    if (obrc.Right > myrc.Left) and (obrc.Left < myrc.Right) and
      (obrc.Bottom > myrc.Top) and (obrc.Top < myrc.Bottom) then
      Result := True
    else
      Result := FALSE;
  end;

var
  i: Integer;
  movetick: Boolean;
  Actor: TActor;
  meff: TMagicEff;
  //  msgstr: string;
  boChange: Boolean;
begin
  if g_MySelf = nil then
    exit;

  g_boDoFastFadeOut := FALSE;
  m_boPlayChange := False;

  movetick := FALSE;
 if ((FrmMain.m_CurrentTick - m_dwMoveTime) >= 99) then begin  //determines how fast objects get to move (run , walk etc )
    m_dwMoveTime := FrmMain.m_CurrentTick;
    movetick := True;
    Inc(m_nMoveStepCount);
    if m_nMoveStepCount > 1 then
      m_nMoveStepCount := 0;
  end;
  if FrmMain.m_CurrentTick - m_dwAniTime >= 50 then begin
    m_dwAniTime := FrmMain.m_CurrentTick;
    Inc(m_nAniCount);
    if m_nAniCount > 100000 then
      m_nAniCount := 0;
  end;

  try
    i := 0;
    while True do begin //Frame
      if i >= m_ActorList.count then
        break;
      Actor := m_ActorList[i];
      if movetick or Actor.m_boNoCheckSpeed then
        Actor.m_boLockEndFrame := FALSE;
      if not Actor.m_boLockEndFrame then begin
        Actor.ProcMsg;
        if movetick or Actor.m_boNoCheckSpeed then
          if Actor.Move(m_nMoveStepCount, boChange) then begin
            m_boPlayChange := m_boPlayChange or boChange;
            Inc(i);
            continue;
          end;
        Actor.Run;
        //m_boPlayChange := Actor.Run or m_boPlayChange; //
        if Actor <> g_MySelf then
          Actor.ProcHurryMsg;
      end;
      if Actor = g_MySelf then
        Actor.ProcHurryMsg;
      //
      if Actor.m_nWaitForRecogId <> 0 then begin
        if Actor.IsIdle then begin
          DelChangeFace(Actor.m_nWaitForRecogId);
          NewActor(Actor.m_nWaitForRecogId, Actor.m_nCurrX, Actor.m_nCurrY,
            Actor.m_btDir, Actor.m_nWaitForFeature, Actor.m_nWaitForStatus);
          Actor.m_nWaitForRecogId := 0;
          Actor.m_boDelActor := True;
        end;
      end;
      if Actor.m_boDelActor then begin
        //actor.Free;
        ClearMissionList(Actor);
        g_FreeActorList.Add(Actor);
        m_ActorList.Delete(i);
        if g_TargetCret = Actor then
          g_TargetCret := nil;
        if g_FocusCret = Actor then
          g_FocusCret := nil;
        if g_MagicTarget = Actor then
          g_MagicTarget := nil;
        if g_NPCTarget = Actor then
          g_NPCTarget := nil;
        if g_MagicLockTarget = Actor then
          g_MagicLockTarget := nil;
      end
      else
        Inc(i);
    end;
  except
    DebugOutStr('101');
  end;

  m_boPlayChange := m_boPlayChange or (FrmMain.m_CurrentTick > m_dwPlayChangeTick);

  try
    i := 0;
    while True do begin
      if i >= m_EffectList.count then
        break;
      meff := m_EffectList[i];
      if meff.m_boActive then begin
        if not meff.Run then begin //¸¶¹ýÈ¿°ú
          meff.Free;
          m_EffectList.Delete(i);
          continue;
        end;
      end;
      Inc(i);
    end;
    i := 0;
    while True do begin
      if i >= m_FlyList.count then
        break;
      meff := m_FlyList[i];
      if meff.m_boActive then begin
        if not meff.Run then begin //µµ³¢,È­»ìµî ³¯¾Æ°¡´Â°Í
          meff.Free;
          m_FlyList.Delete(i);
          continue;
        end;
      end;
      Inc(i);
    end;
    EventMan.Execute;
  except
    DebugOutStr('102');
  end;

  //if not g_boCanDraw then Exit;

  try
    with Map.m_ClientRect do begin
      Left := g_MySelf.m_nRx - 13;
      Top := g_MySelf.m_nRy - 15;
      Right := g_MySelf.m_nRx + 13;
      Bottom := g_MySelf.m_nRy + 13;
    end;


    Map.UpdateMapPos(g_MySelf.m_nRx, g_MySelf.m_nRy);

    //m_ObjSurface.Fill(0);   //¸üÐÂ

    //DrawTileMap;

  except
    DebugOutStr('104');
  end;

end;

procedure TPlayScene.PlayDrawCenterMsg();
var
  CenterMsg: pTCenterMsg;
  I, nHeight, n: Integer;
  sShowStr: string;
begin
  for I := g_CenterMsgList.Count - 1 downto 0 do begin
    CenterMsg := g_CenterMsgList[I];
    if FrmMain.m_CurrentTick >= CenterMsg.nTime then begin
      FrmMain.SendClientMessage(CM_CENTERMSG_CLICK, CenterMsg.nID, 0, 0, 0, '');
      Dispose(CenterMsg);
      g_CenterMsgList.Delete(I);
    end;
  end;
  //nHeight := g_FScreenHeight div 2;
  //nHeight := _MIN(5, g_CenterMsgList.Count) * 20 div 2 - 20 + nHeight;
  //NameTexture.
  n := 0;
  nHeight := g_FScreenHeight - 220;
  for I := g_CenterMsgList.Count - 1 downto 0 do begin
    if n >= 5 then break;
    CenterMsg := g_CenterMsgList[I];
    sShowStr := Format(CenterMsg.sMsgStr, [_MAX(1, (CenterMsg.nTime - FrmMain.m_CurrentTick) div 1000)]);
    g_DXCanvas.TextOut((g_FScreenWidth - g_DXCanvas.TextWidth(sShowStr)) div 2, nHeight - n * 18, CenterMsg.nFColor, sShowStr);
    Inc(n);
  end;
end;

procedure TPlayScene.PlayDrawScreen;
  procedure NameTextOut(Actor: TActor; Surface: TDirectDrawSurface; X, Y, fcolor, bcolor: Integer; namestr: string);
  var
    i, row: Integer;
    nstr: string;
  begin
    row := 0;
    //if g_boUseWuXin and (Actor.m_btWuXin in [1..5]) then begin
      //g_DXCanvas.TextOut(X - 12, Y - 6, GetWuXinColor(Actor.m_btWuXin), '[' + GetWuXinName(Actor.m_btWuXin) + ']');
    //  row := 1;
    //end;
    for i := 0 to 10 do begin
      if namestr = '' then break;
      namestr := GetValidStr3(namestr, nstr, ['\']);
      if (row = 0) and (namestr <> '') then row := -1;
      g_DXCanvas.TextOut(X - g_DXCanvas.TextWidth(nstr) div 2, Y + row * 6, fcolor, nstr);
      Inc(row, 2);
    end;
  end;

const
  MissionIconPlace: array[0..9] of Integer = (0, 1, 2, 3, 4, 5, 4, 3, 2, 1);
var
  i, k, ax, nx: Integer;
  Actor: TActor;
  uname: string;
  d: TDirectDrawSurface;
  rc: TRect;
  infoMsg: string;
  NameTexture: TDXImageTexture;
  r: Real;
  boGrouped: Boolean;
begin
  {if CurrentScene <> nil then
    CurrentScene.PlayScene(MSurface);

  if (g_MySelf = nil) or (not g_boCanDraw) or (not PlayScene.m_boPlayChange) then Exit;  }

  //if CurrentScene = PlayScene then begin
    //with m_ObjSurface do begin
      //¸Ó¸®À§¿¡ Ã¼·Â Ç¥½Ã ÇØ¾ß ÇÏ´Â °Íµé
      //with PlayScene do begin

  NameTexture := GetTempSurface(WILFMT_A4R4G4B4);
  if NameTexture <> nil then begin
    NameTexture.Clear;
    if g_FBTime > 0 then begin
      NameTexture.TextOutEx(40, 3, g_sFBTime, clLime);
    end;
    if g_FBExitTime > 0 then begin
      NameTexture.TextOutEx(319, 136, g_sFBExitTime, clYellow);
    end else
    if g_FBFailTime > 0 then begin
      NameTexture.TextOutEx(160, 136, g_sFBFailTime, clYellow);
    end;
    m_ObjSurface.Draw(0, 0, NameTexture.ClientRect, NameTexture, fxBlend);
  end;
  k := 0;
  while True do begin
    if K > m_ActorList.Count then
      break;
    if K = m_ActorList.Count then
      Actor := g_MySelf
    else begin
      Actor := m_ActorList[k];
      if (Actor = g_MySelf) or
        (abs(g_MySelf.m_nCurrX - actor.m_nCurrX) > MAXLEFT2) or
        (g_MySelf.m_nCurrY - actor.m_nCurrY > MAXTOP2) or
        (Actor.m_nSayX = 0) or
        (g_MySelf.m_nCurrY - actor.m_nCurrY < (MAXTOP3 + 4)) then begin
        Inc(k);
        Continue;
      end;
    end;

    if (actor.m_btRace = 0) and (actor.m_btHorse <> 0) then
      actor.m_nShowY := 22
    else
      actor.m_nShowY := 6;
    //Actor.m_boOpenHealth := True; //ÏÔÊ¾ÑªÌõ
    ax := 800;

    {if g_SetupInfo.boShowName and (g_FocusCret <> actor) and (Actor.m_UserNameSurface <> nil) then begin
      if actor = g_MySelf then begin
        if not g_boSelectMyself then begin
          m_ObjSurface.Draw(actor.m_nSayX - Actor.m_UserNameSurface.Width div 2,
            actor.m_nSayY + 30 - 1,
            Actor.m_UserNameSurface.ClientRect,
            Actor.m_UserNameSurface, Actor.m_NameColor or $FF000000, fxBlend);
        end;
      end
      else begin
        m_ObjSurface.Draw(actor.m_nSayX - Actor.m_UserNameSurface.Width div 2,
          actor.m_nSayY + 30 - 1,
          Actor.m_UserNameSurface.ClientRect,
          Actor.m_UserNameSurface, Actor.m_NameColor or $FF000000, fxBlend);
      end;
    end;      }

    if (actor.m_btRace = 0) and (actor.m_boShop) and (not Actor.m_boDeath) then begin
      if Actor.m_UserShopSurface <> nil then begin
        Inc(actor.m_nShowY, Actor.m_UserShopSurface.Height);
        DrawWindow(m_ObjSurface, Actor.m_nSayX - Actor.m_UserShopSurface.Width div 2,
          Actor.m_nSayY - actor.m_nShowY - 1, Actor.m_UserShopSurface);
      end;
    end else begin
      //i initialise an variable so i can reveal myself but not reveal others on group on heal as they have already a life bar.
     if (Actor <> g_myself) and (Actor.m_Group <> nil) then boGrouped := true else boGrouped := false;

     if actor.m_boOpenHealth or actor.m_noInstanceOpenHealth and not boGrouped then begin
       //ripman auto rev on hit and on revelation
      if actor.m_boOpenHealth and (not actor.m_boDeath)  then
       begin
         if not actor.m_boShowHealthBarRev and (actor.m_btRace <> RCC_USERHUMAN) and actor.m_boAttack then
          begin
            if FrmMain.m_CurrentTick - actor.m_dwOpenHealthStart > actor.m_dwOpenHealthTime then begin
              actor.m_boOpenHealth := FALSE;
              actor.m_boAttack := FALSE;
            end;
          end;
       end;

      //ripman auto rev on healing only on human
      if not (actor.m_btRace = RC_MONSTER) and actor.m_noInstanceOpenHealth and (not actor.m_boDeath) then begin
        if actor.m_noInstanceOpenHealth then begin
          if FrmMain.m_CurrentTick - actor.m_dwOpenHealthStart > actor.m_dwOpenHealthTime then actor.m_noInstanceOpenHealth := FALSE;
        end;
      end;

        //dscreen.addsysmsg('rev mob', clRed);
      if (not Actor.m_boDeath) then begin
        Inc(actor.m_nShowY, 4);
        d := g_WMain3Images.Images[HEALTHBAR_BLACK];
        if d <> nil then begin
          ax := Actor.m_nSayX - d.Width div 2;
          m_ObjSurface.Draw(ax, Actor.m_nSayY - actor.m_nShowY, d.ClientRect, d, True);
        end;
        d := m_HealthBarSurface;
        if d <> nil then begin
          rc := d.ClientRect;
          if actor.m_btRaceServer = RC_NPC then begin
            rc.Top := 4;
            rc.Bottom := 6;
          end else begin
            rc.Top := 0;
            rc.Bottom := 2;
          end;
          if Actor.m_Abil.MaxHP > 0 then
            rc.Right := Round((rc.Right - rc.Left) / Actor.m_Abil.MaxHP * Actor.m_Abil.HP);
          m_ObjSurface.Draw(Actor.m_nSayX - d.Width div 2, Actor.m_nSayY - actor.m_nShowY + 1, rc, d, True);
        end;
      end;
    end;
      //

      if (Actor.m_Abil.MaxHP > 1) and (not Actor.m_boDeath) and (Actor <> g_myself) and (Actor.m_boShowHealthBar) then begin   //flag in group
        Inc(actor.m_nShowY, 4);
        infoMsg := '         '; //Used to position Group Flag Icon above player head
        nx := actor.m_nSayX - g_DXCanvas.TextWidth(infoMsg) div 2;
        g_DXCanvas.TextOut(nx, actor.m_nSayY - actor.m_nShowY, clWhite, infoMsg);
        if Actor.m_Group <> nil then begin
          d := g_WMain3Images.Images[HEALTHBAR_BLACK];
          if d <> nil then begin
            ax := Actor.m_nSayX - d.Width div 2 + 1;
            m_ObjSurface.Draw(ax - 1, Actor.m_nSayY - actor.m_nShowY, d.ClientRect, d, True);
          end;
            d := g_WMain99Images.Images[178];
            if d <> nil then begin
            rc := d.ClientRect;
            if Actor.m_Abil.HP > 0 then
              r := Actor.m_Abil.MaxHP / Actor.m_Abil.HP
            else
              r := 0;

            if r > 0 then
              rc.Right := Round((rc.Right - 40) / r)
            else
              rc.Right := 0;

            rc.Bottom := rc.Bottom;
            m_ObjSurface.Draw(Actor.m_nSayX - d.Width div 2 + 20, Actor.m_nSayY - actor.m_nShowY + 1, rc, d, TRUE);
          end;
        end;
      end;

      if (not Actor.m_boDeath) and (Actor.m_btStrengthenIdx in [1..10]) then begin
        nx := 1015 + Actor.m_btStrengthenIdx * 15 + (FrmMain.m_CurrentTick - Actor.m_dwStrengthenTick) div 100 mod 15;
        d := g_WMain99Images.Images[nx];
        if d <> nil then begin
          Inc(actor.m_nShowY, 30);
          m_ObjSurface.Draw(Actor.m_nSayX - d.Width div 2, Actor.m_nSayY - actor.m_nShowY, d.ClientRect, d, True);
          Inc(actor.m_nShowY, -15);
        end;
      end;

      {if (Actor = g_MySelf) and g_boAutoMoveing then begin
        d := g_WMain99Images.Images[940 + FrmMain.m_CurrentTick div 50 mod 15];
        if d <> nil then begin
          Inc(actor.m_nShowY, d.Height);
          m_ObjSurface.Draw(Actor.m_nSayX - d.Width div 2,
            actor.m_nSayY - actor.m_nShowY ,
            d.ClientRect,
            d, True);
        end;
      end;     }

      for i := Low(TIconInfos) to High(TIconInfos) do
      begin
        if (actor.m_IconInfo[i].btFrame = 0){ or (actor.m_IconInfo[i].wIndex < Low(g_ClientImages))} or (actor.m_IconInfo[i].wIndex > High(g_ClientImages)) then
          Continue;
        if FrmMain.m_CurrentTick - actor.m_IconInfoShow[i].dwFrameTick >= (actor.m_IconInfo[i].wFrameTime * 10) then
        begin
          actor.m_IconInfoShow[i].dwFrameTick := FrmMain.m_CurrentTick;
          if (actor.m_IconInfoShow[i].dwCurrentFrame < actor.m_IconInfo[i].wStart) or (Integer(actor.m_IconInfoShow[i].dwCurrentFrame) >= actor.m_IconInfo[i].wStart + actor.m_IconInfo[i].btFrame - 1) then
            actor.m_IconInfoShow[i].dwCurrentFrame := actor.m_IconInfo[i].wStart
          else
            actor.m_IconInfoShow[i].dwCurrentFrame := actor.m_IconInfoShow[i].dwCurrentFrame + 1;
        end;

        d := g_ClientImages[actor.m_IconInfo[i].wIndex].Images[actor.m_IconInfoShow[i].dwCurrentFrame];
        if d <> nil then
        begin
          m_ObjSurface.Draw(Actor.m_nSayX - actor.m_IconInfo[i].nX,
            actor.m_nSayY - actor.m_nShowY - d.Height + 2 - actor.m_IconInfo[i].nY,
            d.ClientRect, d, True);
          {Inc(actor.m_nShowY, d.Height + 2);
          m_ObjSurface.Draw(Actor.m_nSayX - d.Width div 2 + actor.m_IconInfo[i].nX,
            actor.m_nSayY - actor.m_nShowY - actor.m_IconInfo[i].nY,
            d.ClientRect, d, True);}
        end;
      end;

      if (actor.m_btRace = 50) then begin
        with Actor as TNPCActor do begin
          if m_MissionStatus <> NPCMS_None then begin
            d := nil;
            if FrmMain.m_CurrentTick > m_dwMissionIconTick then begin
              m_dwMissionIconTick := FrmMain.m_CurrentTick + 100;
              Inc(m_dwMissionIconIdx);
            end;
            if m_dwMissionIconIdx > 9 then m_dwMissionIconIdx := 0;
            case m_MissionStatus of
              NPCMS_Accept: d := g_WMain99Images.Images[667];
              NPCMS_Complete: d := g_WMain99Images.Images[668];
              NPCMS_Atelic: d := g_WMain99Images.Images[669];
            end;
            if d <> nil then begin
              Inc(actor.m_nShowY, d.Height + 5);
              m_ObjSurface.Draw(Actor.m_nSayX - d.Width div 2,
                actor.m_nSayY - actor.m_nShowY - MissionIconPlace[m_dwMissionIconIdx],
                d.ClientRect, d, True);
              d := g_WMain99Images.Images[1990 + m_dwMissionIconIdx];
              if d <> nil then begin
                DrawBlend(m_ObjSurface,  Actor.m_nSayX - d.Width div 2,
                  actor.m_nSayY - actor.m_nShowY - 32, d, 1);
              end;
            end;
          end;
        end;
      end;
    end;
    Actor.DrawStruck(m_ObjSurface);
    Inc(k);
  end;
  //end;

  //if (m_MissionSurface <> nil) and (m_boCanShowMissionHint) then
    //m_ObjSurface.Draw(MISSIONHINTX, MISSIONHINTY, m_MissionSurface.ClientRect, m_MissionSurface, True);

  //SetBkMode(Canvas.Handle, TRANSPARENT);
  if (g_FocusCret <> nil) and IsValidActor(g_FocusCret) then begin
    if (g_FocusCret.m_btRace = RCC_MERCHANT) then begin
      if (g_FocusCret.m_sDescUserName <> '') then begin
        g_DXCanvas.TextOut(g_FocusCret.m_nSayX - g_FocusCret.m_DescNameWidth div 2, g_FocusCret.m_nSayY + 24,
          g_FocusCret.m_NameColor, g_FocusCret.m_sDescUserName);
        g_DXCanvas.TextOut(g_FocusCret.m_nSayX - g_FocusCret.m_NameWidth div 2, g_FocusCret.m_nSayY + 36,
          clWhite, g_FocusCret.m_UserName);
      end else
        g_DXCanvas.TextOut(g_FocusCret.m_nSayX - g_FocusCret.m_NameWidth div 2, g_FocusCret.m_nSayY + 30,
          g_FocusCret.m_NameColor, g_FocusCret.m_UserName);
    end else begin
      uname := g_FocusCret.m_sDescUserName + '\' + g_FocusCret.m_UserName;

      NameTextOut(g_FocusCret, m_ObjSurface,
        g_FocusCret.m_nSayX,
        g_FocusCret.m_nSayY + 30,
        g_FocusCret.m_NameColor, clBlack,
        uname);
    end;
  end;
  if g_boSelectMyself and (g_MySelf <> nil) then begin
    uname := g_MySelf.m_sDescUserName + '\' + g_MySelf.m_UserName;
    NameTextOut(g_MySelf, m_ObjSurface,
      g_MySelf.m_nSayX,
      g_MySelf.m_nSayY + 30,
      g_MySelf.m_NameColor, clBlack,
      uname);
  end;
  //end;
//end
end;

procedure TPlayScene.PlayScene(MSurface: TDirectDrawSurface);
begin
end;

procedure TPlayScene.PlaySurface(Sender: TObject);
  function CheckOverlappedObject(myrc, obrc: TRect): Boolean;
  begin
    if (obrc.Right > myrc.Left) and (obrc.Left < myrc.Right) and
      (obrc.Bottom > myrc.Top) and (obrc.Top < myrc.Bottom) then
      Result := True
    else
      Result := FALSE;
  end;

  procedure NameTextOut(Actor: TActor; Surface: TDirectDrawSurface; X, Y, fcolor: Integer; namestr: string; boShow: Boolean);
  var
    i, row: Integer;
    nstr: string;
  begin
    row := 0;
    //if g_boUseWuXin and boShow and (Actor.m_btWuXin in [1..5]) then begin
    //  Surface.TextOutEx(X - 12, Y - 6, '[' + GetWuXinName(Actor.m_btWuXin) + ']', GetWuXinColor(Actor.m_btWuXin));
    //  row := 1;
    //end;
    for i := 0 to 10 do begin
      if namestr = '' then break;
      namestr := GetValidStr3(namestr, nstr, ['\']);
      if (row = 0) and (namestr <> '') then row := -1;
      Surface.TextOutEx(X - g_DXCanvas.TextWidth(nstr) div 2, Y + row * 6, nstr, fcolor);
      Inc(row, 2);
    end;
  end;

const
  DropItemColor: array[Boolean] of LongWord = ($F0C8A0, $FF);

var
  i, j, k, ii, n, M, mmm, ix, iy, line, defx, defy, wunit, fridx, ani, anitick,anioffset,
    ax,
    ay, idx, drawingbottomline: Integer;
  dsurface, d: TDirectDrawSurface;
  blend, movetick: Boolean;
  //myrc, obrc: TRect;
  DropItem: pTDropItem;
  evn: TClEvent;
  Actor: TActor;
  meff: TMagicEff;
  msgstr: string;
  //ShowItem: pTShowItem;
  nFColor, nBColor: Integer;
  TestTick1: LongWord;
  NameTexture, HintTexture: TDXImageTexture;
  nIndex: Integer;
  origm,orign:integer;
  nImgNumber: integer;
begin
  LastForm := lf_Play;
  drawingbottomline := g_FScreenHeight;
   m_ObjSurface.Draw(0, 0,
    Rect(UNITX * 4 + g_MySelf.m_nShiftX,
    UNITY * 5 + g_MySelf.m_nShiftY,
    UNITX * 4 + g_MySelf.m_nShiftX + g_FScreenWidth,
    UNITY * 5 + g_MySelf.m_nShiftY + g_FScreenHeight),
    m_MapSurface,
    FALSE);

   //defx := -UNITX * 3 - g_MySelf.m_nShiftX + AAX + 14;
   if g_FScreenWidth = 1024 then defx := -UNITX * 4 - g_MySelf.m_nShiftX + AAX + 28
   else defx := -UNITX * 6 - g_MySelf.m_nShiftX + AAX + 14;

   if g_FScreenHeight = 768 then defy := -UNITY * 4 - g_MySelf.m_nShiftY
   else defy := -UNITY * 7 - g_MySelf.m_nShiftY;



  m_nDefXX := defx;
  m_nDefYY := defy;
  //  aaa := FrmMain.m_CurrentTick;
  nIndex := 0;
  try
    m := defy - UNITY;

    for i := Low(m_DrawArray) to High(m_DrawArray) do begin
      m_DrawArray[i].ItemList.Clear;
      m_DrawArray[i].ActorList.Clear;
      m_DrawArray[i].ShopActorList.Clear;
      m_DrawArray[i].DeathActorList.Clear;
      m_DrawArray[i].MagicEffList.Clear;
      m_DrawArray[i].ClEvent.Clear;
    end;
    nIndex := 1;
    m_DrawOutsideList.Clear;

    for i := EventMan.EventList.Count - 1 downto 0 do begin
      evn := TClEvent(EventMan.EventList[i]);
      if (abs(evn.m_nX - g_MySelf.m_nCurrX) > 15) and (abs(evn.m_nY - g_MySelf.m_nCurrY) > 15) and (not evn.m_boClient)
        then begin
        evn.Free;
        EventMan.EventList.Delete(i);
        break;
      end
      else begin
        k := evn.m_nY - Map.m_nBlockTop - (Map.m_ClientRect.Top - Map.m_nBlockTop);
        if (k >= 0) and (k <= DRAWLISTCOUNT) then begin
          m_DrawArray[k].ClEvent.Add(evn);
        end;
      end;
    end;
    nIndex := 2;
    for i := g_DropedItemList.Count - 1 downto 0 do begin
      DropItem := PTDropItem(g_DropedItemList[i]);
      if (abs(DropItem.X - g_MySelf.m_nCurrX) > 20) and (abs(DropItem.Y - g_MySelf.m_nCurrY) > 20) then begin
        DisopseDropItem(DropItem, 0);
        g_DropedItemList.Delete(i);
      end
      else if (abs(g_MySelf.m_nCurrX - DropItem.X) > MAXLEFT2) or
        (g_MySelf.m_nCurrY - DropItem.Y > MAXTOP2) or
        (g_MySelf.m_nCurrY - DropItem.Y < MAXTOP3) then
        Continue;
      k := DropItem.Y - Map.m_nBlockTop - (Map.m_ClientRect.Top - Map.m_nBlockTop);
      if (k >= 0) and (k <= DRAWLISTCOUNT) then begin
        m_DrawArray[k].ItemList.Add(DropItem);
      end;
    end;
    nIndex := 3;
    for i := 0 to m_ActorList.Count - 1 do begin
      Actor := TActor(m_ActorList[i]);
      if (abs(g_MySelf.m_nCurrX - actor.m_nCurrX) > MAXLEFT2) or
        (g_MySelf.m_nCurrY - actor.m_nCurrY > MAXTOP2) or
        (g_MySelf.m_nCurrY - actor.m_nCurrY < MAXTOP3) then
        Continue;
      k := Actor.m_nRy - Map.m_nBlockTop - (Map.m_ClientRect.Top - Map.m_nBlockTop) - actor.m_nDownDrawLevel;
      if (k >= 0) and (k <= DRAWLISTCOUNT) then begin
        if Actor.m_boOutside then
            m_DrawOutsideList.Add(Actor);
        if Actor.m_boDeath then begin
          m_DrawArray[k].DeathActorList.Add(Actor);
        end
        else begin
          m_DrawArray[k].ActorList.Add(Actor);
          if (Actor.m_boShop) and (Actor.m_btRace = 0) and (Actor.m_boShopLeft) and (K > 0) then begin
            m_DrawArray[k - 1].ShopActorList.Add(Actor);
          end;
        end;
      end;
    end;
    nIndex := 4;
    for i := 0 to m_FlyList.Count - 1 do begin
      meff := TMagicEff(m_FlyList[i]);
      k := meff.Ry - Map.m_nBlockTop - (Map.m_ClientRect.Top - Map.m_nBlockTop);
      if (k >= 0) and (k <= DRAWLISTCOUNT) then begin
        m_DrawArray[k].MagicEffList.Add(meff);
      end;
    end;
    nIndex := 5;
    {$region 'anitile rendering'}
    //draw anitiles here since they animate
    origm:=m;
    orign:=n;
    for j := (Map.m_ClientRect.Top - Map.m_nBlockTop) to (Map.m_ClientRect.Bottom - Map.m_nBlockTop + LONGHEIGHT_IMAGE) do begin
      if j < 0 then begin
        Inc(m, UNITY);
        continue;
      end;
      n := defx - UNITX * 2;
      for i := (Map.m_ClientRect.Left - Map.m_nBlockLeft - 2) to (Map.m_ClientRect.Right - Map.m_nBlockLeft + 2) do
        begin
        if (i >= 0) and (i < LOGICALMAPUNIT * 3) and (j >= 0) and (j < LOGICALMAPUNIT * 3) then begin
          nImgNumber := Map.m_MArr[i, j].AniTileImg;
          ani := Map.m_MArr[i,j].AniTileFrame;
          if (nImgNumber > 0) and (ani > 0) then begin
            nImgNumber := nImgNumber-1;
            //anitick := Map.m_MArr[i, j].AniTileTick;
            anitick:=1;//temp

            anioffset := Map.m_MArr[i,j].AniTileTiles xor $2000;

              inc(nImgNumber, anioffset * ((m_nAniCount mod (ani + (ani * anitick))) div (1 + anitick)));
            dsurface := g_WAniTiles.Images[nImgNumber];
            if dsurface <> nil then begin
              mmm := m + UNITY - DSurface.Height;
              m_ObjSurface.Draw(n, mmm, dsurface.ClientRect, dsurface, true);
            end;
          end;
        end;
         Inc(n, UNITX);
      end;
      Inc(m, UNITY);
    end;
    {$endregion}
    {$region 'rendering the tiles that sneaked into object layer'}
    m:=origm;
    n:=orign;
    for j := (Map.m_ClientRect.Top - Map.m_nBlockTop) to (Map.m_ClientRect.Bottom - Map.m_nBlockTop + LONGHEIGHT_IMAGE) do begin
      if j < 0 then begin
        Inc(m, UNITY);
        continue;
      end;
      n := defx - UNITX * 2;
      for i := (Map.m_ClientRect.Left - Map.m_nBlockLeft - 2) to (Map.m_ClientRect.Right - Map.m_nBlockLeft + 2) do
        begin
        if (i >= 0) and (i < LOGICALMAPUNIT * 3) and (j >= 0) {and (j < LOGICALMAPUNIT * 3)} then begin
          fridx := (Map.m_MArr[i, j].FrImg) and $7FFF;
          if fridx > 0 then begin
            ani := Map.m_MArr[i, j].AniFrame;
            wunit := Map.m_MArr[i, j].Area;
            blend := FALSE;
            if (wunit < 100) then begin //mir3's animations are different then mir2's
              if (ani and $80) > 0 then begin
                blend := TRUE;
                ani := ani and $7F;
              end;
              if (ani > 0) then begin
                anitick := Map.m_MArr[i, j].AniTick;
                fridx := fridx + (m_nAniCount mod (ani + (ani * anitick))) div (1 + anitick);
              end;
            end else begin
               if (ani and 7) <> 0 then begin
                 blend := true;
                 ani := ani and 7;
               end;
               if (ani > 0) then begin
                anitick := Map.m_MArr[i, j].AniTick;
                fridx := fridx + (m_nAniCount mod (ani + (ani * 3))) div 4;
              end;
            end;
            if (Map.m_MArr[i, j].DoorOffset and $80) > 0 then begin
              if (Map.m_MArr[i, j].DoorIndex and $7F) > 0 then
                fridx := fridx + (Map.m_MArr[i, j].DoorOffset and $7F);
            end;
            fridx := fridx - 1;
            DSurface := GetObjsEx(wunit, fridx, ax, ay);
            if DSurface <> nil then begin
              if ((blend = false) and (DSurface.Width = 48) and (DSurface.Height = 32)) then begin
                if (wunit > 99) then
                  mmm := m+ay - DSurface.Height + UnitY
                else
                  mmm := m + UNITY - DSurface.Height;
                if ((n + DSurface.Width > 0) and (n <= g_FScreenWidth) and (mmm + DSurface.Height > 0)) or (mmm < drawingbottomline) then begin
                  m_ObjSurface.Draw(n, mmm, DSurface.ClientRect, Dsurface, TRUE)
                end
              end
            end;
          end;

        end;
        Inc(n, UNITX);
      end;
      Inc(m, UNITY);
    end;
    {$endregion}
    {$region 'finaly draw all the objects and actors'}
    m:=origm;
    n:=orign;
    for j := (Map.m_ClientRect.Top - Map.m_nBlockTop) to (Map.m_ClientRect.Bottom - Map.m_nBlockTop + LONGHEIGHT_IMAGE) do begin
      if j < 0 then begin
        Inc(m, UNITY);
        continue;
      end;
      n := defx - UNITX * 2;
      {$region 'draw front objects + mir3 has double front, on this row only'}
      for i := (Map.m_ClientRect.Left - Map.m_nBlockLeft - 2) to (Map.m_ClientRect.Right - Map.m_nBlockLeft + 2) do
        begin
        if (i >= 0) and (i < LOGICALMAPUNIT * 3) and (j >= 0) {and (j < LOGICALMAPUNIT * 3)} then begin
          nImgNumber := Map.m_MArr[i, j].MidImg;
          if (nImgNumber > 0) and (Map.m_MArr[i,j].MidIndex > 99) then begin  //only mir3 map 'objects'
            wunit := Map.m_MArr[i,j].MidIndex - 100;
            ani := Map.m_MArr[i,j].AniTick;
              if (ani <> 255) and (ani > 0) then begin
                if (ani and 7) <> 0 then
                  ani := ani and 7;
                nImgNumber := nImgNumber + (m_nAniCount Mod (ani + (ani * 3))) Div 4;
              end;
            nImgNumber := nImgNumber - 1;
            if wunit in [low(g_WMir3MapObjects) .. high(g_WMir3MapObjects)] then
              dsurface := g_WMir3MapObjects[wunit].getCachedImage(nImgNumber, aX, aY);
            if dsurface <> nil then begin
              mmm := m +ay - DSurface.Height + UnitY;
              m_MapSurface.Draw(n, mmm, dsurface.ClientRect, dsurface, true);
            end;
          end;
          fridx := (Map.m_MArr[i, j].FrImg) and $7FFF;
          if fridx > 0 then begin
            ani := Map.m_MArr[i, j].AniFrame;
            wunit := Map.m_MArr[i, j].Area;

            blend := FALSE;
            if (wunit < 100) then begin //mir3's animations are different then mir2's
            //mir2
              if (ani and $80) > 0 then begin
                blend := TRUE;
                ani := ani and $7F;
              end;
              if (ani > 0) then begin
                anitick := Map.m_MArr[i, j].AniTick;
                fridx := fridx + (m_nAniCount mod (ani + (ani * anitick))) div (1 + anitick);
              end;
            end else begin
            //mir3
            {
               if (ani and 7) <> 0 then begin
                 ani := ani and 7;
               end;
               if (ani > 0) then begin
                anitick := Map.m_MArr[i, j].AniTick;
                fridx := fridx + (m_nAniCount mod (ani + (ani * 3))) div 4;
              end;
            }
            end;
            if (Map.m_MArr[i, j].DoorOffset and $80) > 0 then begin
              if (Map.m_MArr[i, j].DoorIndex and $7F) > 0 then
                fridx := fridx + (Map.m_MArr[i, j].DoorOffset and $7F);
            end;
            fridx := fridx - 1;
            DSurface := GetObjsEx(wunit, fridx, ax, ay);
            if (DSurface <> nil) then begin
              if blend then begin
                if (wunit > 99) then
                  mmm := m+ay - DSurface.Height + UnitY
                else
                  mmm := m + ay - 68; //UNITY - DSurface.Height;
                if ((n > 0) and (mmm + DSurface.Height > 0) and (n + Dsurface.Width < g_FScreenWidth)) or
                  (mmm < drawingbottomline)
                 then begin
                  DrawBlend(m_ObjSurface, n + ax - 2, mmm, DSurface, 1);
                end
              end
              else if (DSurface.Width <> 48) or (DSurface.Height <> 32) then begin
                if (wunit > 99) then
                  mmm := m+ay - DSurface.Height + UnitY
                else
                  mmm := m + UNITY - DSurface.Height;
                if ((n + DSurface.Width > 0) and (n <= g_FScreenWidth) and (mmm + DSurface.Height > 0)) or
                  (mmm < drawingbottomline) then begin
                  m_ObjSurface.Draw(n, mmm, DSurface.ClientRect, Dsurface, TRUE)
                end
              end;
            end;
          end;
        end;
        Inc(n, UNITX);
      end;
      {$endregion}
      if (j <= (Map.m_ClientRect.Bottom - Map.m_nBlockTop)) and (not g_boServerChanging) then begin
        k := j - (Map.m_ClientRect.Top - Map.m_nBlockTop);
        for ii := m_DrawArray[k].ClEvent.Count - 1 downto 0 do begin
          evn := TClEvent(m_DrawArray[k].ClEvent[ii]);
          evn.DrawEvent(m_ObjSurface, (evn.m_nX - Map.m_ClientRect.Left) * UNITX + defx,m);
        end;

        for ii := m_DrawArray[k].DeathActorList.Count - 1 downto 0 do begin
          actor := m_DrawArray[k].DeathActorList[ii];
          actor.m_nSayX := (actor.m_nRx - Map.m_ClientRect.Left) * UNITX + defx + actor.m_nShiftX + 24;
          actor.m_nSayY := m + UNITY + actor.m_nShiftY + 16 - 60 + (actor.m_nDownDrawLevel * UNITY);
          actor.m_nDrawX := (actor.m_nRx - Map.m_ClientRect.Left) * UNITX + defx;
          actor.m_nDrawY := m + (actor.m_nDownDrawLevel * UNITY);
          if not Actor.m_boOutside then
            actor.DrawChr(m_ObjSurface, actor.m_nDrawX, actor.m_nDrawY, FALSE, True);
        end;
        nIndex := 8;
        if g_boDrawDropItem then begin
          for ii := m_DrawArray[k].ItemList.Count - 1 downto 0 do begin
            DropItem := PTDropItem(m_DrawArray[k].ItemList[ii]);
            if DropItem <> nil then begin
              d := GetDnItemImg(DropItem.Looks);
              //d := FrmMain.GetWDnItemImg(DropItem.Looks);
              if d <> nil then begin
                ix := (DropItem.x - Map.m_ClientRect.Left) * UNITX + defx + SOFFX; // + actor.ShiftX;
                iy := m; // + actor.ShiftY;
                if DropItem = g_FocusItem then begin
                  DrawEffect(m_ObjSurface, ix + HALFX - (d.Width div 2), iy + HALFY - (d.Height div 2), d, ceBright,
                    False);
                end
                else begin
                  m_ObjSurface.Draw(ix + HALFX - (d.Width div 2),
                    iy + HALFY - (d.Height div 2),
                    d.ClientRect,
                    d, TRUE);
                end;
              end;
            end;
          end;
        end;
        //m_DrawArray[k].ItemList.Clear;
        nIndex := 9;
        for ii := 0 to m_DrawArray[k].ShopActorList.Count - 1 do begin
          actor := m_DrawArray[k].ShopActorList[ii];
          actor.m_nSayX := (actor.m_nRx - Map.m_ClientRect.Left) * UNITX + defx + actor.m_nShiftX + 24;
          actor.m_nSayY := m + UNITY + actor.m_nShiftY + 16 - 95 + (actor.m_nDownDrawLevel * UNITY);
          d := g_WMain99Images.GetCachedImage(511 + actor.m_btShopIdx * 2, ax, ay);
          if d <> nil then
            m_ObjSurface.Draw(actor.m_nSayX + ax, actor.m_nSayY + ay, d.ClientRect, d, True);
        end;
        nIndex := 10;
        for ii := 0 to m_DrawArray[k].ActorList.Count - 1 do begin
          actor := m_DrawArray[k].ActorList[ii];
          actor.m_nSayX := (actor.m_nRx - Map.m_ClientRect.Left) * UNITX + defx + actor.m_nShiftX + 24;
          actor.m_nSayY := m + UNITY + actor.m_nShiftY + 16 - 95 + (actor.m_nDownDrawLevel * UNITY);
          actor.m_nDrawX := (actor.m_nRx - Map.m_ClientRect.Left) * UNITX + defx;
          actor.m_nDrawY := m + (actor.m_nDownDrawLevel * UNITY);
          if not Actor.m_boOutside then begin //draw the actors if they are in view range i guess
            if ((not g_SetupInfo.boHideAroundHum) or (Actor.m_btRace <> 0) or (Actor = g_MySelf)) and
               ((not g_SetupInfo.boHideAllyHum) or (Actor.m_btRace <> 0) or (Actor = g_MySelf) or (Actor.m_OldNameColor <> ALLYCOLOR)) then
              actor.DrawChr(m_ObjSurface, actor.m_nDrawX, actor.m_nDrawY, FALSE, True);
            if Actor.m_boShop and not Actor.m_boShopLeft then begin
              d := g_WMain99Images.GetCachedImage(510 + actor.m_btShopIdx * 2, ax, ay);
              if d <> nil then
                m_ObjSurface.Draw((actor.m_nRx - Map.m_ClientRect.Left) * UNITX + defx + ax,
                  m + (actor.m_nDownDrawLevel * UNITY) + ay, d.ClientRect, d, True);
            end;
            if Actor.m_nState and $02000000 <> 0 then begin
              d := g_WMons[24].GetCachedImage(3740 + FrmMain.m_CurrentTick div 200 mod 10, ax, ay);
              if d <> nil then
                m_ObjSurface.Draw(actor.m_nDrawX + ax, actor.m_nDrawY + ay, d.ClientRect, d, fxAnti);
            end;
          end;
        end;
        //m_DrawArray[k].ActorList.Clear;
        nIndex := 11;
        for ii := 0 to m_DrawArray[k].MagicEffList.Count - 1 do begin
          meff := TMagicEff(m_DrawArray[k].MagicEffList[ii]);
          meff.DrawEff(m_ObjSurface);
        end;
      end;
      //
      Inc(m, UNITY);
    end;
    {$endregion}
    nIndex := 12;
    for I := 0 to m_DrawOutsideList.Count - 1 do begin
      actor := m_DrawOutsideList[i];
      actor.DrawChr(m_ObjSurface, actor.m_nDrawX, actor.m_nDrawY, FALSE, True);
    end;

    if not g_boServerChanging then begin
    try
      //****
      //if you mouseover: draw the target highlighted   (but blended!

      if (g_FocusCret <> nil) then begin
        if IsValidActor(g_FocusCret) and (g_FocusCret <> g_MySelf) then
          //            if (actor.m_btRace <> 81) or (FocusCret.State and $00800000 = 0) then //Jacky
          if (g_FocusCret.m_nState and $00800000 = 0) then //Jacky
            g_FocusCret.DrawChr(m_ObjSurface,
              (g_FocusCret.m_nRx - Map.m_ClientRect.Left) * UNITX + defx,
              (g_FocusCret.m_nRy - Map.m_ClientRect.Top - 1) * UNITY + defy,
              True, False);
      end;

      if (g_MagicTarget <> nil) then begin
        if IsValidActor(g_MagicTarget) and (g_MagicTarget <> g_MySelf) then
          if g_MagicTarget.m_nState and $00800000 = 0 then
            g_MagicTarget.DrawChr(m_ObjSurface,
              (g_MagicTarget.m_nRx - Map.m_ClientRect.Left) * UNITX + defx,
              (g_MagicTarget.m_nRy - Map.m_ClientRect.Top - 1) * UNITY + defy,
              True, False);
      end;
      //**** seems to be a check that only works true if you use /debug screen   (aka always run :p)
      //if not g_boCheckBadMapMode then
      //draw your own char blended in with roofs etc
      if g_MySelf.m_nState and $00800000 = 0 then
          g_MySelf.DrawChr(m_ObjSurface, (g_MySelf.m_nRx - Map.m_ClientRect.Left)
            * UNITX + defx, (g_MySelf.m_nRy - Map.m_ClientRect.Top - 1) * UNITY +
            defy, True, FALSE);
    except
      DebugOutStr('108');
    end;
  end;
  try
    //**** ¸¶¹ý È¿°ú
    for k := 0 to m_ActorList.count - 1 do begin
      Actor := m_ActorList[k];
      if (abs(g_MySelf.m_nCurrX - actor.m_nCurrX) > MAXLEFT2) or
        (g_MySelf.m_nCurrY - actor.m_nCurrY > MAXTOP2) or
        (g_MySelf.m_nCurrY - actor.m_nCurrY < MAXTOP3) then
        Continue;
      Actor.DrawEff(m_ObjSurface,
        (Actor.m_nRx - Map.m_ClientRect.Left) * UNITX + defx,
        (Actor.m_nRy - Map.m_ClientRect.Top - 1) * UNITY + defy);
    end;
  except
    DebugOutStr('109');
  end;

        //2010-10-01
    nIndex := 13;
    NameTexture := GetTempSurface(WILFMT_A4R4G4B4);
    HintTexture := GetTempSurface(WILFMT_A1R5G5B5);
    if (NameTexture <> nil) and (HintTexture <> nil) then begin
      NameTexture.Clear;
      HintTexture.Clear;
      nIndex := 14;
      for K := Low(m_DrawArray) to High(m_DrawArray) do begin
        for ii := m_DrawArray[k].ItemList.Count - 1 downto 0 do begin
          DropItem := PTDropItem(m_DrawArray[k].ItemList[ii]);
          if DropItem <> nil then begin
            ix := (DropItem.X - Map.m_ClientRect.Left) * UNITX + defx + SOFFX;
            iy := (DropItem.Y - Map.m_ClientRect.Top - 1) * UNITY + defy + SOFFY;
            if FrmMain.m_CurrentTick - DropItem.FlashTime > g_dwDropItemFlashTime {5 * 1000} then begin
              DropItem.FlashTime := FrmMain.m_CurrentTick;
              DropItem.BoFlash := TRUE;
              DropItem.FlashStepTime := FrmMain.m_CurrentTick;
              DropItem.FlashStep := 0;
            end;
            I := 0;
            if DropItem.BoFlash then begin
              if FrmMain.m_CurrentTick - DropItem.FlashStepTime >= 20 then begin
                DropItem.FlashStepTime := FrmMain.m_CurrentTick;
                Inc(DropItem.FlashStep);
              end;
              if (DropItem.FlashStep >= 0) and (DropItem.FlashStep < 10) then begin
                I := DropItem.FlashStep;
              end
              else
                DropItem.BoFlash := FALSE;
            end;
            if (DropItem <> g_FocusItem) and
              (DropItem.Filtr.boShow or (g_SetupInfo.boShowItemName)) then begin

              if (DropItem.nColor <> 15718028{getrgb(147}) then begin

                NameTexture.TextOutEx(ix + HALFX - DropItem.Width div 2,
                  iy + HALFY - DropItem.Height * 2,
                  DropItem.Name,
                  DropItem.nColor);
              end else begin
                NameTexture.TextOutEx(ix + HALFX - DropItem.Width div 2,
                  iy + HALFY - DropItem.Height * 2,
                  DropItem.Name,
                  DropItemColor[DropItem.Filtr.boColor]);
              end;
            end else begin
              if DropItem.BoFlash then begin
                DSurface := g_WMain99Images.GetCachedImage(FLASHBASE + I, ax, ay);
                HintTexture.CopyTexture(ix + ax, iy + ay, DSurface);
              end;
            end;
          end;
        end;
      end;
      nIndex := 15;
      if g_SetupInfo.boShowName or g_SetupInfo.boShowNameMon then begin
        k := 0;
        while True do begin
          if K > m_ActorList.Count then break;
          if K = m_ActorList.Count then begin
            Actor := g_MySelf;
            if not g_SetupInfo.boShowName then break;
          end
          else begin
            Actor := m_ActorList[k];
            if (Actor = g_MySelf) or ((Actor.m_btRace <> RCC_USERHUMAN) and Actor.m_boDeath) or
              (abs(g_MySelf.m_nCurrX - actor.m_nCurrX) > MAXLEFT2) or
              (g_MySelf.m_nCurrY - actor.m_nCurrY > MAXTOP2) or
              (g_MySelf.m_nCurrY - actor.m_nCurrY < (MAXTOP3 + 4)) or
              (Actor.m_nSayX = 0) or
              ((not Actor.m_boShowName) and (not g_SetupInfo.boShowNameMon)) or
              ((Actor.m_boShowName) and (not g_SetupInfo.boShowName)) then begin
              Inc(k);
              Continue;
            end;
          end;
          if (g_FocusCret <> Actor) then begin
            if Actor = g_MySelf then begin
              if not g_boSelectMyself then begin
                if g_SetupInfo.boShowNameAll then begin
                  NameTextOut(Actor, NameTexture,
                    Actor.m_nSayX,
                    Actor.m_nSayY + 30,
                    Actor.m_NameColor,
                    Actor.m_sDescUserName + '\' + Actor.m_UserName, True);
                end else begin
                  if g_boUseWuXin and (Actor.m_btWuXin in [1..5]) then begin
//                   NameTexture.TextOutEx(Actor.m_nSayX - 12,
//                        Actor.m_nSayY + 30 - 6,
//                        '[' + GetWuXinName(Actor.m_btWuXin) + ']',
//                        GetWuXinColor(Actor.m_btWuXin));
                    NameTexture.TextOutEx(Actor.m_nSayX - Actor.m_NameWidth div 2,
                        Actor.m_nSayY + 30,
                        Actor.m_UserName,
                        Actor.m_NameColor);
                  end else begin
                    NameTexture.TextOutEx(Actor.m_nSayX - Actor.m_NameWidth div 2,
                        Actor.m_nSayY + 30,
                        Actor.m_UserName,
                        Actor.m_NameColor);
                  end;
                end;
              end;
            end else begin
              if (Actor.m_btRace = RCC_MERCHANT) then begin
                if Actor.m_sDescUserName <> '' then begin
                  NameTexture.TextOutEx(Actor.m_nSayX - Actor.m_DescNameWidth div 2,
                      Actor.m_nSayY + 30 - 6,
                      Actor.m_sDescUserName,
                      Actor.m_NameColor);
                  NameTexture.TextOutEx(Actor.m_nSayX - Actor.m_NameWidth div 2,
                      Actor.m_nSayY + 30 + 6,
                      Actor.m_UserName,
                      clWhite);
                end else begin
                  NameTexture.TextOutEx(Actor.m_nSayX - Actor.m_NameWidth div 2,
                      Actor.m_nSayY + 30,
                      Actor.m_UserName,
                      Actor.m_NameColor);
                end;

              end else begin
                if g_SetupInfo.boShowNameAll and (Actor.m_btRace = RCC_USERHUMAN) then begin
                  NameTextOut(Actor, NameTexture,
                    Actor.m_nSayX,
                    Actor.m_nSayY + 30,
                    Actor.m_NameColor,
                    Actor.m_sDescUserName + '\' + Actor.m_UserName, False);
                end else begin
                  {if Actor.m_btWuXin in [1..5] then begin
                    NameTexture.TextOutEx(Actor.m_nSayX - 12,
                        Actor.m_nSayY + 30 - 6,
                        '[' + GetWuXinName(Actor.m_btWuXin) + ']',
                        GetWuXinColor(Actor.m_btWuXin));
                    NameTexture.TextOutEx(Actor.m_nSayX - Actor.m_NameWidth div 2,
                        Actor.m_nSayY + 30 + 6,
                        Actor.m_UserName,
                        Actor.m_NameColor);
                  end else begin  }
                  NameTexture.TextOutEx(Actor.m_nSayX - Actor.m_NameWidth div 2,
                        Actor.m_nSayY + 30,
                        Actor.m_UserName,
                        Actor.m_NameColor);
                  //end;
                end;
              end;
            end;
          end;
          Inc(K);
        end;
      end;
      DrawBlend(m_ObjSurface, 0, 0, HintTexture, 1);
    end;  
      {if FrmMain.m_CurrentTick > TestTick2 then begin
        FrmMain.Caption := IntToStr(FrmMain.m_CurrentTick - TestTick1);
        TestTick2 := FrmMain.m_CurrentTick + 500;
      end;   }
    //end;
    //if (FrmMain.m_CurrentTick - TestTick) > 500 then begin
      //DebugOutStr('TPlayScene.PlaySurface 102 ' + IntToStr(FrmMain.m_CurrentTick - TestTick));
    //end;
  except
    DebugOutStr('106 ' + intToStr(nIndex));
  end;
  //2010-10-01
  if NameTexture <> nil then
    m_ObjSurface.Draw(0, 0, NameTexture.ClientRect, NameTexture, fxBlend);
  try
    PlayDrawScreen;
  except
    DebugOutStr('111');
  end;

  try
    PlayDrawCenterMsg();
  except
    DebugOutStr('112');
  end;
  m_dwPlayChangeTick := FrmMain.m_CurrentTick + 50;
end;

procedure TPlayScene.MagicSurface(Sender: TObject);
var
  k: integer;
  meff: TMagicEff;
begin
  if (m_objSurface = nil) or (m_MagSurface = nil) then exit;
  m_MagSurface.Draw(SOFFX, SOFFY, m_ObjSurface.ClientRect, m_ObjSurface, FALSE);
  for k := 0 to m_EffectList.count - 1 do begin
    meff := TMagicEff(m_EffectList[k]);
    meff.DrawEff(m_ObjSurface);
  end;
end;

procedure TPlayScene.MapLightSurface(Sender: TObject);
var
  m, n, i, j, idx: Integer;
begin
  m := m_nDefYY - UNITY*4;
  for j:=(Map.m_ClientRect.Top - Map.m_nBlockTop - 10) to (Map.m_ClientRect.Bottom - Map.m_nBlockTop + LONGHEIGHT_IMAGE + 10) do begin
    if j < 0 then begin
      Inc (m, UNITY);
      continue;
    end;
    n := m_nDefXX-UNITX*5;
    for i:=(Map.m_ClientRect.Left - Map.m_nBlockLeft-10) to (Map.m_ClientRect.Right - Map.m_nBlockLeft+10) do begin
      if (i > 0) and (i < LOGICALMAPUNIT*5) and (j >= 0) and (j < LOGICALMAPUNIT*5) then begin
        idx := Map.m_MArr[i, j].Light;
        if idx > 0 then begin
           AddMapLight (i+Map.m_nBlockLeft, j+Map.m_nBlockTop, idx);
        end;
      end;
      Inc (n, UNITX);
    end;
    Inc (m, UNITY);
  end;
end;

procedure TPlayScene.AddMapLight(tx, ty, light: Integer);
var
  d: TDirectDrawSurface;
  t: TRect;
  topPoint, bottomPoint: TPoint;
  tp2, bp2, tp3, bp3, tp4, bp4: TPoint;
  RX, RY, FlyX, FlyY, nPx, nPy:integer;
  Lx1, Lx2, Ly1, Ly2, left_position, top_position, right_position, bottom_position,
  incremental_increase_of_light, i, amount_to_increase: Integer;
  colour_of_light: RGBColourArray;
begin
  if light = 255 then exit;
  
  left_position := 70;
  top_position := 50;
  right_position := 125;
  bottom_position := 80;
  incremental_increase_of_light := 0;
  amount_to_increase := 70;
  d := CheckLightImageSize(g_WEnvironmentImages.GetCachedImage(0, nPx, nPy));
  RX := tx;
  RY := ty;
  ScreenXYfromMCXY(RX, RY, FlyX, FlyY);
  FlyX := FlyX;
  FlyY := FlyY;

  colour_of_light := GetHGEColour(g_cur_colour_of_dark, 100);

  case light of
    40: begin
      colour_of_light := GetHGEColour('148,89,68', 100);
      light := 2;
    end;
    41: begin
      colour_of_light := GetHGEColour('66,89,148', 100);
      light := 5;
    end;
  end;

  if light > 10 then
    light := 10;

  for i := 0 to light do begin
    topPoint.X := (FlyX + nPx) - left_position - incremental_increase_of_light;
    topPoint.Y := (FlyY + nPy) - top_position - incremental_increase_of_light;
    bottomPoint.X := topPoint.X + right_position + (incremental_increase_of_light * 2);
    bottomPoint.Y := topPoint.Y + bottom_position + (incremental_increase_of_light * 2);
    t.TopLeft := topPoint;
    t.BottomRight := bottomPoint;
    if d <> nil then
      m_LightSurface.StretchDraw(t, d.ClientRect,d,ARGB(200, colour_of_light[1], colour_of_light[2], colour_of_light[3]),Blend_SrcAlphaAdd);
    inc(incremental_increase_of_light, amount_to_increase);
  end;
end;

procedure TPlayScene.DrawCastingLight();
var
  i, j, k, idx, ax, ay, user_object_rx, user_object_ry, user_position_x, user_position_y, actual_size_of_light,
  top_position, left_position, right_position, bottom_position, amount_to_increase: Integer;
  user_object: TActor;
  wimg: TWMImages;
  image_to_draw: TDirectDrawSurface;
  top_left_position, bottom_right_position: TPoint;
  temp_rectangle: TRect;
  rgb_colours: RGBColourArray;
  current_effect_colour, colour_fire_red, colour_thunder_blue, colour_ice_blue,
  colour_poison_green, colour_blood_red: String;
begin
try
  left_position := 40;
  top_position := 50;
  right_position := 125;
  bottom_position := 80;
  amount_to_increase := 3;
  current_effect_colour := '255,255,255';
  actual_size_of_light := 15;
  colour_fire_red := '148,89,68';
  colour_thunder_blue := '66,89,148';
  colour_ice_blue := '153,217,234';
  colour_poison_green := '34,177,76';
  colour_blood_red := '219,17,28';
  image_to_draw := nil;
  for i := 0 to m_ActorList.Count - 1 do begin
    user_object := TActor(m_ActorList[i]);
    if user_object = nil then continue;//safety should never happen :p
    //if the user is outside our screen range, ignore him
    if (abs(g_MySelf.m_nCurrX - user_object.m_nCurrX) > MAXLEFT2) or
      (g_MySelf.m_nCurrY - user_object.m_nCurrY > MAXTOP2) or
      (g_MySelf.m_nCurrY - user_object.m_nCurrY < MAXTOP3) then
      Continue;
    k := user_object.m_nRy - Map.m_nBlockTop - (Map.m_ClientRect.Top - Map.m_nBlockTop) - user_object.m_nDownDrawLevel;
    if (k < 0) or  (k > DRAWLISTCOUNT) then continue;
    //if the user is death, ignore him
    if user_object.m_boOutside or user_object.m_boDeath then continue;
    //user is in screen and alive so draw his light
    {$region 'Draw This actors light'}
    user_object_rx := user_object.m_nRx;
    user_object_ry := user_object.m_nRy;
    ScreenXYfromMCXY(user_object_rx, user_object_ry, user_position_x, user_position_y);
    user_position_x := user_position_x + user_object.m_nShiftX;
    user_position_y := user_position_y + user_object.m_nShiftY;
    if user_object.m_boUseMagic and (user_object.m_CurMagic.EffectNumber > 0) then begin
      if user_object.m_nCurEffFrame in [0..user_object.m_nSpellFrame - 1] then begin
        image_to_draw := CheckLightImageSize(g_WEnvironmentImages.GetCachedImage(0, ax, ay));
        case user_object.m_CurMagic.EffectNumber of
          0: image_to_draw := nil;
          1, 3, 7, 12, 20, 21, 34, 49, 101, 114, 115: current_effect_colour := colour_fire_red;
          8, 9, 11, 14, 18, 40, 66, 116: current_effect_colour := colour_thunder_blue;
          31, 39, 71, 117: current_effect_colour := colour_ice_blue;
          4, 46, 47: current_effect_colour := colour_poison_green;
          48: current_effect_colour := colour_blood_red;
          43: actual_size_of_light := 70;
          55: actual_size_of_light := 50;
          22: begin
            actual_size_of_light := 50;
            current_effect_colour := colour_thunder_blue;
          end;
          45: begin
            actual_size_of_light := 60;
            current_effect_colour := colour_fire_red;
          end;
          58: begin
            actual_size_of_light := 60;
            current_effect_colour := colour_ice_blue;
          end;
          61: begin
            current_effect_colour := colour_fire_red;
            amount_to_increase := 8;
          end;
          62: begin
            current_effect_colour := colour_thunder_blue;
            amount_to_increase := 8;
          end;
        end;

        if user_object.individual_depth_of_dark >= 0 then begin
          if (Round(user_object.m_nSpellFrame div 2) + 1) > user_object.m_nCurEffFrame then
            Inc(user_object.individual_depth_of_dark, amount_to_increase)
          else
            Dec(user_object.individual_depth_of_dark, amount_to_increase);
        end;

        if user_object.individual_depth_of_dark < 0 then
          user_object.individual_depth_of_dark := 0;

        rgb_colours := GetHGEColour(current_effect_colour, user_object.individual_depth_of_dark);
        for k := 0 to 2 do begin
          top_left_position.X := (user_position_x + ax - UNITX div 2) - left_position - actual_size_of_light - user_object.individual_incremental_increase_of_light;
          top_left_position.Y := (user_position_y + ay - UNITY div 2) - top_position - actual_size_of_light - user_object.individual_incremental_increase_of_light;
          bottom_right_position.X := top_left_position.X + right_position + (actual_size_of_light * 2) + (user_object.individual_incremental_increase_of_light * 2);
          bottom_right_position.Y := top_left_position.Y + bottom_position + (actual_size_of_light * 2) + (user_object.individual_incremental_increase_of_light * 2);
          temp_rectangle.TopLeft := top_left_position;
          temp_rectangle.BottomRight := bottom_right_position;
          if image_to_draw <> nil then
            m_LightSurface.StretchDraw(temp_rectangle, image_to_draw.ClientRect,image_to_draw,ARGB(user_object.individual_depth_of_dark, rgb_colours[1], rgb_colours[2], rgb_colours[3]),Blend_SrcAlphaAdd);

          if user_object.individual_incremental_increase_of_light < 40 then
            Inc(user_object.individual_incremental_increase_of_light, 1);
        end;
      end;
    end;

    if ((user_object.m_boHitEffect) or (user_object.m_boShowCbo)) and (user_object.m_nHitEffectNumber > 0) then begin
      Inc(user_object.individual_level_of_light, 1);
      if (Round(user_object.m_nSpellFrame div 2) + 1) > user_object.current_effect_for_light then
        Inc(user_object.individual_depth_of_dark, 3)
      else
        Dec(user_object.individual_depth_of_dark, 3);

      if user_object.individual_depth_of_dark < 0 then
          user_object.individual_depth_of_dark := 0;

      case user_object.m_nHitEffectNumber of
        0: image_to_draw := nil;
        6: actual_size_of_light := 50;
        4: begin
            actual_size_of_light := 50;
            current_effect_colour := colour_fire_red;
          end;
        9: current_effect_colour := colour_fire_red;
        113: begin
            actual_size_of_light := 100;
          end;
      end;
      image_to_draw := CheckLightImageSize(g_WEnvironmentImages.GetCachedImage(0, ax, ay));

      rgb_colours := GetHGEColour(current_effect_colour, user_object.individual_depth_of_dark);
      for k := 0 to 2 do begin
        top_left_position.X := (user_position_x + ax - UNITX div 2) - left_position - actual_size_of_light - user_object.individual_incremental_increase_of_light;
        top_left_position.Y := (user_position_y + ay - UNITY div 2) - top_position - actual_size_of_light - user_object.individual_incremental_increase_of_light;
        bottom_right_position.X := top_left_position.X + right_position + (actual_size_of_light * 2) + (user_object.individual_incremental_increase_of_light * 2);
        bottom_right_position.Y := top_left_position.Y + bottom_position + (actual_size_of_light * 2) + (user_object.individual_incremental_increase_of_light * 2);
        temp_rectangle.TopLeft := top_left_position;
        temp_rectangle.BottomRight := bottom_right_position;
        if image_to_draw <> nil then
          m_LightSurface.StretchDraw(temp_rectangle, image_to_draw.ClientRect,image_to_draw,ARGB(user_object.individual_depth_of_dark, rgb_colours[1], rgb_colours[2], rgb_colours[3]),Blend_SrcAlphaAdd);

        if user_object.individual_incremental_increase_of_light < 40 then
          Inc(user_object.individual_incremental_increase_of_light, 1);
      end;
      {$endregion}
      //m_DrawArray[k].ActorList.Add(Actor);
    end;
  end;
except
  on e: exception do begin
    FrmMain.OnProgramException(self,E);
  end;
end;
end;

procedure TPlayScene.MagicLightSurface(); //Samuel drawing blended gfx to dark and coloured circles.
var
  i, j, idx, ax, ay, k, ii: integer;
  meff: TMagicEff;
  fgeff: TFireGunEffect;
  lteff: TLightingThunder;
  bgeff: TBujaukGroundEffect;
  teff: TThuderEffect;
  dooeff: TDrawEffectOnObject;
  ddneff: TDelayNormalDrawEffect;
  eventEff: TClEvent;
  d: TDirectDrawSurface;
  t: TRect;
  topPoint, bottomPoint: TPoint;
  RX, RY, FlyX, FlyY, nPx, nPy, m:integer;
  obj: TObject;
  defx: Integer;
  defy: Integer;
  testx, testy: integer;
  user_object: TActor;
begin
  for i := 0 to m_EffectList.Count - 1 do begin
    obj := m_EffectList[i];
    if obj = nil then continue; //safety check
    
    if obj.ClassType = TFireGunEffect then begin
      TFireGunEffect(m_EffectList[i]).DrawLightEff(m_LightSurface);
    end else if obj.ClassType = TLightingThunder then begin
      TLightingThunder(m_EffectList[i]).DrawEff(m_LightSurface);
    end else if obj.ClassType = TBujaukGroundEffect then begin
      bgeff := TBujaukGroundEffect(m_EffectList[i]);
      bgeff.DrawEff(m_LightSurface);
      bgeff.DrawLightEff(m_LightSurface);
    end else if obj.ClassType = TThuderEffect then begin
      teff := TThuderEffect(m_EffectList[i]);
      teff.DrawEff(m_LightSurface);
      teff.DrawLightEff(m_LightSurface);
    end else if obj.ClassType = TDrawEffectOnObject then begin
      TDrawEffectOnObject(m_EffectList[i]).DrawLightEff(m_LightSurface);
    end else if obj.ClassType = TThreeNodeDrawEffect then begin
      TThreeNodeDrawEffect(m_EffectList[i]).DrawLightEff(m_lightsurface);
    end else if obj.ClassType = TStraightNodeDrawEffect then begin
      TStraightNodeDrawEffect(m_EffectList[i]).DrawLightEff(m_lightsurface);
    end else if not (obj.ClassType = TNormalDrawEffect) then begin
      meff := TMagicEff(m_EffectList[i]);
      meff.DrawEff(m_LightSurface);
      meff.DrawLightEff(m_LightSurface);
    end;
  end;

  for j := (Map.m_ClientRect.Top - Map.m_nBlockTop) to (Map.m_ClientRect.Bottom - Map.m_nBlockTop + LONGHEIGHT_IMAGE) do begin
      if j < 0 then begin
        Inc(m, UNITY);
        continue;
      end;

      if (j <= (Map.m_ClientRect.Bottom - Map.m_nBlockTop)) and (not g_boServerChanging) then begin
        k := j - (Map.m_ClientRect.Top - Map.m_nBlockTop);
        for ii := m_DrawArray[k].ClEvent.Count - 1 downto 0 do begin
          eventEff := TClEvent(m_DrawArray[k].ClEvent[ii]);
          ScreenXYFromMCXY(eventEff.m_nX, eventEff.m_nY, testx, testy);
          if eventEff.m_nLight > 0 then
            eventEff.DrawEventLight(m_ObjSurface, testx - 20, testy - 13);
        end;
    end;
  end;
end;

procedure TPlayScene.LightSurface(Sender: TObject);
var
  i: integer;
  nActorBrightness: Integer;
  Actor: TActor;
  tx,ty,bx,by, amount_of_loops: Integer;
  light_pulse: Boolean;
  colour_of_light: string;
begin
  amount_of_loops := 1;
  light_pulse := false;
  colour_of_light := '255,255,255';
  tx := 30;
  ty := 50;
  bx := 110;
  by := 90;

  for i := 0 to m_ActorList.Count - 1 do begin //Samuel draw light on actors
    Actor := m_ActorList[i];

    if (Actor.m_boUseEffect) and (Actor.m_btRace <> 50) then
      DrawMobMagicLight(Actor);

    if (Actor.m_nState and $00100000 <> 0) or (Actor.m_nState and $00080000 <> 0) or (Actor.m_nState and $01000000 <> 0) then begin

        amount_of_loops := 3;
        light_pulse := true;
        if (Actor.m_nState and $00100000 <> 0) then begin
          colour_of_light := '255,127,39';
        end else if (Actor.m_nState and $00080000 <> 0) then begin
          tx := 50;
          colour_of_light := '66,89,148';
          AddShieldLight(tx,ty,bx,by,amount_of_loops,colour_of_light,Actor,light_pulse);
          tx := 10;
          colour_of_light := '255,127,39';
        end;
        AddShieldLight(tx,ty,bx,by,amount_of_loops,colour_of_light,Actor,light_pulse);
    end;

    case Actor.m_btRace of
      44: begin //HolyDeva(MoonObject)
        Actor.m_nLightRange := 23;
        if Actor.m_boDeath then begin
          Actor.m_nLightRange := 0;
        end;
      end;
      106: begin //light on rtz
        if ((Actor.m_nState and STATE_STONE_MODE) <> 0) or (Actor.m_boDeath) then
          Actor.m_nLightRange := 0
        else
          Actor.m_nLightRange := 20;
      end;
      110, 111: begin
        Actor.m_nLightRange := 21;
        if Actor.m_boDeath then begin
          Actor.m_nLightRange := 0;
        end;
      end;
      114: begin
        Actor.m_nLightRange := 22;
        if Actor.m_boDeath then begin
          Actor.m_nLightRange := 0;
        end;
      end;
    end;

    if Actor.m_nLightRange <> 0 then begin
      case Actor.m_nLightRange of
        1,4,7,10: begin
          amount_of_loops := 8;
        end;
        2,5,8,11: begin
          amount_of_loops := 11;
        end;
        3,6,9,12: begin
          amount_of_loops := 14;
        end;
        20: begin //red thudner zuma
          amount_of_loops := 2;
        end;
        21: begin
          amount_of_loops := 2;
        end;
        22: begin
          amount_of_loops := 6;
        end;
        23: begin
          amount_of_loops := 2;
        end;
      end;
      if Actor = g_MySelf then
        nActorBrightness := 200
      else
        nActorBrightness := 150;

      case Actor.m_nLightRange of
        1,2,3: begin //Normal
          colour_of_light := '255,240,221';
          AddActorLight(tx, ty, bx, by, amount_of_loops, colour_of_light, Actor, light_pulse);
        end;
        4,5,6: begin //Red
          colour_of_light := '255,235,235';
          AddActorLight(tx, ty, bx, by, amount_of_loops, colour_of_light, Actor, light_pulse);
        end;
        7,8,9: begin //Blue
          colour_of_light := '235,235,255';
          AddActorLight(tx, ty, bx, by, amount_of_loops, colour_of_light, Actor, light_pulse);
        end;
        10,11,12: begin //Green
          colour_of_light := '235,255,235';
          AddActorLight(tx, ty, bx, by, amount_of_loops, colour_of_light, Actor, light_pulse);
        end;
        20: Begin //red thudner zuma
          colour_of_light := '148,89,68';
          AddActorLight(tx, ty, bx, by, amount_of_loops, colour_of_light, Actor, light_pulse);
        End;
        21, 22: begin //element
          colour_of_light := '255,240,221';
          AddActorLight(tx, ty, bx, by, amount_of_loops, colour_of_light, Actor, light_pulse);
        end;
        23 : begin //HolyDeva(MoonObject)
          colour_of_light := '235,235,255';
          AddActorLight(tx, ty, bx, by, amount_of_loops, colour_of_light, Actor, light_pulse);
        end;
      end;
    end else begin
      if Actor = g_MySelf then begin
        AddActorLight(tx,ty,bx,by,amount_of_loops,colour_of_light,Actor,light_pulse);
      end else if (Actor.m_btRaceServer = RC_NPC) or (Actor.m_btRaceServer = RC_GUARD) then begin
        AddActorLight(tx,ty,bx,by,4,'255,240,221',Actor,false);
      end;
    end;
  end;
end;

procedure TPlayScene.DrawMobMagicLight(user_object: TActor);
var
  i, j, k, idx, ax, ay, user_object_rx, user_object_ry, user_position_x, user_position_y, actual_size_of_light,
  top_position, left_position, right_position, bottom_position, amount_to_increase, amount_to_decrease, temp: Integer;
  wimg: TWMImages;
  image_to_draw: TDirectDrawSurface;
  top_left_position, bottom_right_position: TPoint;
  temp_rectangle: TRect;
  rgb_colours: RGBColourArray;
  current_effect_colour, colour_fire_red, colour_thunder_blue, colour_ice_blue,
  colour_poison_green, colour_blood_red, colour_purple: String;
begin
  left_position := 40;
  top_position := 50;
  right_position := 125;
  bottom_position := 80;
  amount_to_increase := 2;
  current_effect_colour := '255,255,255';
  actual_size_of_light := 15;
  colour_fire_red := '148,89,68';
  colour_thunder_blue := '66,89,148';
  colour_ice_blue := '153,217,234';
  colour_poison_green := '34,139,34';
  colour_blood_red := '219,17,28';
  colour_purple := '72,61,139';
  image_to_draw := nil;
  amount_to_decrease := 2;
  temp := 0;

  user_object_rx := user_object.m_nRx;
  user_object_ry := user_object.m_nRy;
  ScreenXYfromMCXY(user_object_rx, user_object_ry, user_position_x, user_position_y);
  user_position_x := user_position_x + user_object.m_nShiftX;
  user_position_y := user_position_y + user_object.m_nShiftY;

  image_to_draw := CheckLightImageSize(g_WEnvironmentImages.GetCachedImage(0, ax, ay));

  case user_object.m_btRace of
    18, 14, 15, 61, 49: current_effect_colour := colour_fire_red;
    16, 53, 36: begin
      actual_size_of_light := -20;
      amount_to_increase := 1;
    end;
    20: begin
      current_effect_colour := colour_fire_red;
      amount_to_increase := 4;
      amount_to_decrease := 3;
    end;
    21, 60: begin
      current_effect_colour := colour_thunder_blue;
      amount_to_increase := 4;
    end;
    33, 64, 70, 71, 113: begin
      image_to_draw := nil;
    end;
    63: begin
      case user_object.m_nCurrentAction of
        SM_FLYAXE: current_effect_colour := colour_fire_red;
        SM_LIGHTING, SM_NOWDEATH: begin
          actual_size_of_light := actual_size_of_light + 50;
          amount_to_increase := 1;
        end;
        else
          image_to_draw := nil;
      end;
    end;
    75: begin
      if (user_object.m_nCurrentAction = SM_TURN) then
        current_effect_colour := colour_fire_red
      else
        image_to_draw := nil;
    end;
    77: begin
      if (user_object.m_nCurrentAction = SM_TURN) then
        current_effect_colour := colour_thunder_blue
      else
        image_to_draw := nil;
    end;
    78: begin
      actual_size_of_light := actual_size_of_light + 50;
      case user_object.m_nCurrentAction of
        SM_NOWDEATH: begin
          actual_size_of_light := actual_size_of_light + 50;
          current_effect_colour := colour_fire_red;
        end;
        SM_LIGHTING: begin
          actual_size_of_light := actual_size_of_light + 100;
          current_effect_colour := colour_purple;
          amount_to_increase := 2;
        end;  
      end;
    end;
    83: begin
      actual_size_of_light := actual_size_of_light + 100;
      current_effect_colour := colour_fire_red;
      amount_to_increase := 2;
      if (user_object.m_nCurrentAction = SM_HIT) then
        actual_size_of_light := actual_size_of_light + 100;
    end;
    105: begin
      actual_size_of_light := actual_size_of_light + 50;
      current_effect_colour := colour_poison_green;
    end;
    106: begin
      if (user_object.m_nCurrentAction = SM_LIGHTING) or (user_object.m_nCurrentAction = SM_HIT) then
        current_effect_colour := colour_fire_red
      else
        image_to_draw := nil;
    end;
    62: begin
      current_effect_colour := colour_fire_red;
      if user_object.m_nCurrentAction = SM_LIGHTING then
        actual_size_of_light := actual_size_of_light + 50;
      if user_object.m_nCurrentAction = SM_NOWDEATH then begin
        actual_size_of_light := actual_size_of_light + 100;
        current_effect_colour := colour_purple;
      end;
    end;
    110: begin
      if user_object.m_nCurrentAction = SM_LIGHTING then begin
        actual_size_of_light := actual_size_of_light + 25;
        case user_object.GetCurrentFrameNumber of
          0..3: current_effect_colour := colour_poison_green;
          4,5: current_effect_colour := colour_thunder_blue;
          6,7: current_effect_colour := colour_purple;
          8,9: current_effect_colour := colour_fire_red;
        end;
      end else if not (user_object.m_nCurrentAction = SM_NOWDEATH) then
        image_to_draw := nil;
    end;
    111: begin
      actual_size_of_light := actual_size_of_light + 50;
      if user_object.m_nCurrentAction = SM_LIGHTING then begin
        actual_size_of_light := actual_size_of_light + 25;
        current_effect_colour := colour_thunder_blue;
      end else if not (user_object.m_nCurrentAction = SM_NOWDEATH) then
        image_to_draw := nil;
    end;
    114: begin
      case user_object.m_nCurrentAction of
        SM_LIGHTING, SM_NOWDEATH: begin
          actual_size_of_light := actual_size_of_light + 150;
          current_effect_colour := colour_thunder_blue;
        end;
        else
          image_to_draw := nil;
      end;
    end;
    44: begin
      actual_size_of_light := actual_size_of_light + 20;
      if user_object.m_nCurrentAction = SM_HIT then begin
        actual_size_of_light := actual_size_of_light + 40;
        current_effect_colour := colour_thunder_blue;
      end else if not (user_object.m_nCurrentAction = SM_NOWDEATH) then
        image_to_draw := nil;
    end;
  end;

  if user_object.individual_depth_of_dark >= 0 then begin
    if Round(user_object.GetEndFrameNumber div 2) > (user_object.GetCurrentFrameNumber - amount_to_decrease) then
      Inc(user_object.individual_depth_of_dark, amount_to_increase)
    else
      Dec(user_object.individual_depth_of_dark, amount_to_increase);
  end;

  if user_object.individual_depth_of_dark <= 0 then
    user_object.individual_depth_of_dark := 0;

  rgb_colours := GetHGEColour(current_effect_colour, user_object.individual_depth_of_dark);
  for k := 0 to 1 do begin
    top_left_position.X := (user_position_x + ax - UNITX div 2) - left_position - actual_size_of_light - user_object.individual_incremental_increase_of_light;
    top_left_position.Y := (user_position_y + ay - UNITY div 2) - top_position - actual_size_of_light - user_object.individual_incremental_increase_of_light;
    bottom_right_position.X := top_left_position.X + right_position + (actual_size_of_light * 2) + (user_object.individual_incremental_increase_of_light * 2);
    bottom_right_position.Y := top_left_position.Y + bottom_position + (actual_size_of_light * 2) + (user_object.individual_incremental_increase_of_light * 2);
    temp_rectangle.TopLeft := top_left_position;
    temp_rectangle.BottomRight := bottom_right_position;
    if image_to_draw <> nil then
      m_LightSurface.StretchDraw(temp_rectangle, image_to_draw.ClientRect,image_to_draw,ARGB(user_object.individual_depth_of_dark, rgb_colours[1], rgb_colours[2], rgb_colours[3]),Blend_SrcAlphaAdd);

    if user_object.individual_incremental_increase_of_light < 40 then begin
      Inc(user_object.individual_incremental_increase_of_light, 5);
    end;
  end;
end;

procedure TPlayScene.AddShieldLight(tx, ty, bx, by, loop_count: Integer; colour_of_light: string; actor: TActor; pulse_effect: Boolean);
var
  d: TDirectDrawSurface;
  t: TRect;
  topPoint, bottomPoint: TPoint;
  RX, RY, FlyX, FlyY, nPx, nPy, incremental_increase_of_light, i, current_depth_of_dark:integer;
  rgb_colours: RGBColourArray;
begin
  incremental_increase_of_light := 0;
  current_depth_of_dark := 0;
  d := CheckLightImageSize(g_WEnvironmentImages.GetCachedImage(0, nPx, nPy));
  RX := actor.m_nRx;
  RY := actor.m_nRy;
  ScreenXYfromMCXY(RX, RY, FlyX, FlyY);
  FlyX := FlyX + actor.m_nShiftX;
  FlyY := FlyY + actor.m_nShiftY;

  if (FrmMain.m_CurrentTick - level_of_light_tick > 10) then begin
    Inc(level_of_light, 1);
    if (10 > level_of_light) then begin
      Inc(depth_of_dark, 1);
    end else begin
      Dec(depth_of_dark, 1);
      if depth_of_dark <= 70 then
        level_of_light := 0;
    end;
    level_of_light_tick := FrmMain.m_CurrentTick;
  end;

  rgb_colours := GetHGEColour(colour_of_light, depth_of_dark);

  for i := 0 to 3 do begin
    if i < 3 then
      current_depth_of_dark := depth_of_dark
    else
      current_depth_of_dark := 70;
    topPoint.X := (FlyX + nPx - UNITX div 2) - tx - incremental_increase_of_light;
    topPoint.Y := (FlyY + nPy - UNITY div 2) - ty - incremental_increase_of_light;
    bottomPoint.X := topPoint.X + bx + (incremental_increase_of_light * 2);
    bottomPoint.Y := topPoint.Y + by + (incremental_increase_of_light * 2);
    t.TopLeft := topPoint;
    t.BottomRight := bottomPoint;
    if d <> nil then
      m_LightSurface.StretchDraw(t, d.ClientRect,d,ARGB(depth_of_dark, rgb_colours[1], rgb_colours[2], rgb_colours[3]),Blend_SrcAlphaAdd);
    Inc(incremental_increase_of_light, 15);
  end;
end;


procedure TPlayScene.AddActorLight(tx, ty, bx, by, loop_count: Integer; colour_of_light: string; actor: TActor; pulse_effect: Boolean);
var
  d: TDirectDrawSurface;
  t: TRect;
  topPoint, bottomPoint: TPoint;
  RX, RY, FlyX, FlyY, nPx, nPy, incremental_increase_of_light, i, current_depth_of_dark:integer;
  rgb_colours: RGBColourArray;
begin
  incremental_increase_of_light := 0;
  current_depth_of_dark := 0;
  d := CheckLightImageSize(g_WEnvironmentImages.GetCachedImage(0, nPx, nPy));
  RX := actor.m_nRx;
  RY := actor.m_nRy;
  ScreenXYfromMCXY(RX, RY, FlyX, FlyY);
  FlyX := FlyX + actor.m_nShiftX;
  FlyY := FlyY + actor.m_nShiftY;

  rgb_colours := GetHGEColour(colour_of_light, 0);

  for i := 0 to loop_count do begin
    topPoint.X := (FlyX + nPx - UNITX div 2) - tx - incremental_increase_of_light;
    topPoint.Y := (FlyY + nPy - UNITY div 2) - ty - incremental_increase_of_light;
    bottomPoint.X := topPoint.X + bx + (incremental_increase_of_light * 2);
    bottomPoint.Y := topPoint.Y + by + (incremental_increase_of_light * 2);
    t.TopLeft := topPoint;
    t.BottomRight := bottomPoint;
    if d <> nil then
      m_LightSurface.StretchDraw(t, d.ClientRect,d,ARGB(70, rgb_colours[1], rgb_colours[2], rgb_colours[3]),Blend_SrcAlphaAdd);
    Inc(incremental_increase_of_light, 25);
  end;
end;

{-------------------------------------------------------}

//cx, cy, tx, ty : ¸ÊÀÇ ÁÂÇ¥

procedure TPlayScene.NewMagic(aowner: TActor;
  magid, magnumb {Effect}, cx, cy, tx, ty, targetcode: Integer;
  mtype: TMagicType; //EffectType
  Recusion: Boolean;
  anitime: Integer;
  var bofly: Boolean);
var
  i, scx, scy, sctx, scty, effnum: Integer;
  meff,seff: TMagicEff;
  target: TActor;
  wimg: TWMImages;
  clThunderBlue, clFireRed, clPoisonGreen, clIceBlue, clBloodRed: String;
begin
  clThunderBlue := '66,89,148';
  clFireRed := '148,89,68';
  clPoisonGreen := '34,177,76';
  clIceBlue := '153,217,234';
  clBloodRed := '219,17,28';
  bofly := FALSE;
  if magid <> 111 then //
    for i := 0 to m_EffectList.count - 1 do
      if TMagicEff(m_EffectList[i]).ServerMagicId = magid then
        Exit; //
  ScreenXYfromMCXY(cx, cy, scx, scy);
  ScreenXYfromMCXY(tx, ty, sctx, scty);
  if magnumb > 0 then
    GetEffectBase(magnumb - 1, 0, wimg, effnum) //magnumb{Effect}
  else
    effnum := -magnumb;

  target := FindActor(targetcode);

  meff := nil;
  case mtype of //EffectType
    mtReady, mtFly, mtFlyAxe: begin
      case magnumb of //Samuel added for house keeping of skills.
        120: begin //BlazingStrike
          for I := 0 to 2 do begin
            meff := TDelayMagicEff.Create(magid, effnum, scx, scy, sctx, scty, mtype, Recusion, anitime);
            meff.TargetActor := target;
            TDelayMagicEff(meff).nDelayTime := FrmMain.m_CurrentTick + LongWord(I * 100);
            meff.frame := 5;
            meff.EffectBase := 3240;
            meff.ImgLib := g_WCboEffectImages;
            meff.MagExplosionBase := 3560;
            if i = 0 then
              meff.ExplosionFrame := 6
            else
              meff.ExplosionFrame := 1;
            meff.m_nFlyParameter := 600;

            meff.TargetRx := tx;
            meff.TargetRy := ty;
            if meff.TargetActor <> nil then begin
              meff.TargetRx := TActor(meff.TargetActor).m_nCurrX;
              meff.TargetRy := TActor(meff.TargetActor).m_nCurrY;
            end;
            meff.MagOwner := aowner;
            m_EffectList.Add(meff);
          end;
          exit;
        end;
        33: begin //frost fire ball
          meff := TFlameIceMagicEff.Create(magid, effnum, scx, scy, sctx, scty, mtype, Recusion, anitime);
          meff.TargetActor := target;
        end;
      end;

      meff := TMagicEff.Create(magid, effnum, scx, scy, sctx, scty, mtype, Recusion, anitime);
      meff.TargetActor := target;
      case magnumb of
        1: begin
          meff.Colour := clFireRed;
        end;
        3: begin // Samuel fireball coloured light.
          meff.Colour := clFireRed;
        end;
        80: begin
          meff.EffectBase := 50;
          meff.frame := 10;
          meff.ImgLib := g_WDragonImages;
          meff.MagExplosionBase := 200;
          meff.ExplosionFrame := 20;
          meff.m_nFlyParameter := 600;
          meff.Light := 2;
          meff.Colour := clFireRed;
        end;
        98: begin
          meff.frame := 3;
          meff.EffectBase := 100;
          meff.MagExplosionBase := 270;
          meff.TargetActor := target;
          meff.NextFrameTime := 60;
          meff.ExplosionFrame := 10;
          meff.ImgLib := g_WMagic5Images;
        end;
        99: begin
          meff.frame := 6;
          meff.EffectBase := 280;
          meff.MagExplosionBase := 450;
          meff.TargetActor := target;
          meff.NextFrameTime := 60;
          meff.ExplosionFrame := 10;
          meff.ImgLib := g_WMagic5Images;
        end;
        39: begin //FrostCrunch
          meff.frame := 4;
          meff.Light := 1;
          meff.Colour := clIceBlue;
          if wimg <> nil then
            meff.ImgLib := wimg;
        end;
        130: begin //OrcSpiritBall
          meff.EffectBase := 4140;
          meff.frame := 3;
          meff.ImgLib := g_WMons[32];
          meff.MagExplosionBase := 4220;
          meff.ExplosionFrame := 3;
          //m//eff.m_nFlyParameter := 600;
          meff.Colour := clPoisonGreen;
          meff.FixedEffect := False;
          meff.SpecialFly1 := True;
        end;
        114: begin //Combustion
          meff.EffectBase := 2600;
          meff.frame := 5;
          meff.ImgLib := g_WCboEffectImages;
          meff.MagExplosionBase := 2770;
          meff.ExplosionFrame := 25;
          meff.m_nFlyParameter := 600;
          meff.Colour := clFireRed;
        end;
        115: begin //PheonixDash
          meff.EffectBase := 2410;
          meff.frame := 3;
          meff.ImgLib := g_WCboEffectImages;
          meff.MagExplosionBase := 2580;
          meff.ExplosionFrame := 8;
          meff.m_nFlyParameter := 600;
          meff.Colour := clFireRed;
        end;
        116: begin //ThunderOrb
          meff.EffectBase := 4230;
          meff.NotFixed := True;
          meff.frame := 4;
          meff.ImgLib := g_WCboEffectImages;
          meff.MagExplosionBase := 4240;
          meff.ExplosionFrame := 8;
          meff.m_nFlyParameter := 600;
          meff.Colour := clThunderBlue;
        end;
        118: begin //PrimalRush
          meff := TTigerMagicEff.Create(magid, effnum, scx, scy, sctx, scty, mtype, Recusion, anitime);
          meff.TargetActor := target;
          TTigerMagicEff(meff).btDir := aowner.m_btDir;
          meff.frame := 5;
          meff.EffectBase := 3580;
          meff.Repetition := False;
          meff.ImgLib := g_WCboEffectImages;
          meff.MagExplosionBase := 3740;
          meff.ExplosionFrame := 10;
          meff.m_nFlyParameter := 600;
        end;
        119: begin //SoulSurge
          meff.EffectBase := 2080;
          meff.frame := 3;
          meff.MagExplosionDir := True;
          meff.ImgLib := g_WCboEffectImages;
          meff.MagExplosionBase := 2250;
          meff.ExplosionFrame := 5;
          meff.m_nFlyParameter := 600;
        end;
        121: begin //SpiritFlux
          meff.EffectBase := 2810;
          meff.frame := 5;
          meff.Repetition := False;
          meff.MagExplosionDir := True;
          meff.ImgLib := g_WCboEffectImages;
          meff.MagExplosionBase := 2980;
          meff.ExplosionFrame := 10;
          meff.m_nFlyParameter := 600;
          meff.Light := 2;
        end;
      end;
      bofly := True;
    end;
    mtExplosion: begin
      case magnumb of
        18: begin //ElectricShock
            meff := TMagicEff.Create(magid, effnum, scx, scy, sctx, scty, mtype, Recusion, anitime);
            meff.MagExplosionBase := 1570;
            meff.TargetActor := target;
            meff.NextFrameTime := 80;
            meff.Colour := clThunderBlue;
          end;
        21: begin //Firebang
            meff := TMagicEff.Create(magid, effnum, scx, scy, sctx, scty, mtype, Recusion, anitime);
            meff.MagExplosionBase := 1660;
            meff.TargetActor := nil; //target;
            meff.NextFrameTime := 80;
            meff.ExplosionFrame := 20;
            meff.light := 2; //this was 3
            meff.Colour := clFireRed;
          end;
        26: begin //Revelation
            meff := TMagicEff.Create(magid, effnum, scx, scy, sctx, scty, mtype,
              Recusion, anitime);
            meff.MagExplosionBase := 3990;
            meff.TargetActor := target;
            meff.NextFrameTime := 80;
            meff.ExplosionFrame := 10;
            meff.light := 1;
          end;
        27: begin //MassHealing
            meff := TMagicEff.Create(magid, effnum, scx, scy, sctx, scty, mtype,
              Recusion, anitime);
            meff.MagExplosionBase := 1800;
            meff.TargetActor := nil; //target;
            meff.NextFrameTime := 80;
            meff.ExplosionFrame := 10;
            meff.light := 1;
          end;
        30: begin //TurnUndead
            meff := TMagicEff.Create(magid, effnum, scx, scy, sctx, scty, mtype,
              Recusion, anitime);
            meff.MagExplosionBase := 3930;
            meff.TargetActor := target;
            meff.NextFrameTime := 80;
            meff.ExplosionFrame := 16;
            meff.light := 1;
          end;
        31: begin //IceStorm
            meff := TMagicEff.Create(magid, effnum, scx, scy, sctx, scty, mtype, Recusion, anitime);
            meff.MagExplosionBase := 3850;
            meff.TargetActor := nil; //target;
            meff.NextFrameTime := 80;
            meff.ExplosionFrame := 20;
            meff.Colour := clIceBlue;
            meff.light := 2;
          end;
        34: begin //FlamePillar
            meff := TMagicEff.Create(magid, effnum, scx, scy, sctx, scty, mtype,
              Recusion, anitime);
            meff.MagExplosionBase := 140;
            meff.TargetActor := target; //target;
            meff.NextFrameTime := 80;
            meff.ExplosionFrame := 20;
            meff.light := 3;
            if wimg <> nil then
              meff.ImgLib := wimg;
          end;
        40: begin // purification
            meff := TMagicEff.Create(magid, effnum, scx, scy, sctx, scty, mtype,
              Recusion, anitime);
            meff.MagExplosionBase := 620;
            meff.TargetActor := target;
            meff.NextFrameTime := 100;
            meff.ExplosionFrame := 20;
            meff.light := 1;
            meff.Colour := clthunderblue;
            if wimg <> nil then
              meff.ImgLib := wimg;
          end;
        45: begin //Flamefield
            meff := TMagicEff.Create(magid, effnum, scx, scy, sctx, scty, mtype, Recusion, anitime);
            meff.ImgLib := g_WMagic2Images;
            meff.MagExplosionBase := 923;
            meff.TargetActor := nil; //target;
            meff.TargetX := aOwner.m_nDrawX + 23;
            meff.TargetY := aOwner.m_nDrawY + 18;
            meff.NextFrameTime := 80;
            meff.ExplosionFrame := 10;
            meff.light := 4; //this was 3
            meff.Colour := clFireRed;
          end;
        47, MAGICEX_AMYOUNSULGROUP: begin //MassPoison
          SoundUtil.PlaySound(11041);
          end;
        48: begin //Vampirism
            meff := TMagicEff.Create(magid, effnum, scx, scy, sctx, scty, mtype, Recusion, anitime);
            meff.MagExplosionBase := 1060;
            meff.TargetActor := target; //target;
            meff.NextFrameTime := 50;
            meff.ExplosionFrame := 20;
            meff.light := 1;
            meff.Colour := clBloodRed;
            if wimg <> nil then
              meff.ImgLib := wimg;
          end;
        49: begin //meteorstrike
            meff := TMagicEff.Create(magid, effnum, scx, scy, sctx, scty, mtype, Recusion, anitime);
            meff.MagExplosionBase := 640;
            meff.TargetActor := nil; //target;
            meff.NextFrameTime := 60;
            meff.ExplosionFrame := 40;
            meff.Colour := clFireRed;
            meff.Light := 3;
            if wimg <> nil then
              meff.ImgLib := wimg;
          end;
        58: begin //Blizzard
            meff := TMagicEff.Create(magid, effnum, scx, scy, sctx, scty, mtype, Recusion, anitime);
            meff.MagExplosionBase := 370;
            meff.MagicId := 66;
            meff.TargetActor := nil; //target;
            meff.NextFrameTime := 70;
            meff.ExplosionFrame := 40;
            meff.Light := 3;
            meff.Colour := clIceBlue;
            if wimg <> nil then
              meff.ImgLib := wimg;
          end;
        51: begin //±ùÅØÏø
            meff := TMagicEff.Create(magid, effnum, scx, scy, sctx, scty, mtype, Recusion, anitime);
            meff.MagExplosionBase := 910;
            meff.TargetActor := nil; //target;
            meff.NextFrameTime := 100;
            meff.ExplosionFrame := 11;
            meff.ImgLib := g_WMagic99Images;
          end;
        53: begin //Á«»¨Âä
            meff := TMagicEff.Create(magid, effnum, scx, scy, sctx, scty, mtype, Recusion, anitime);
            meff.MagExplosionBase := 820;
            meff.TargetActor := nil; //target;
            meff.NextFrameTime := 80;
            meff.ExplosionFrame := 13;
            meff.ImgLib := g_WMagic99Images;
          end;
        52: begin //Resurrect
            meff := TMagicEff.Create(magid, effnum, scx, scy, sctx, scty, mtype, Recusion, anitime);
            meff.MagExplosionBase := 850;
            meff.TargetActor := nil; //target;
            meff.NextFrameTime := 80;
            meff.ExplosionFrame := 10;
            meff.ImgLib := g_WMagic99Images;
          end;
        55: begin //Entrapment
            meff := TMagicEff.Create(magid, effnum, scx, scy, sctx, scty, mtype, Recusion, anitime);
            meff.MagExplosionBase := 1010;
            meff.TargetActor := target;
            meff.NextFrameTime := 80;
            meff.ExplosionFrame := 18;
            meff.Light := 2;
            meff.ImgLib := g_WMagic2Images;
          end;
        66: begin //Plague
            meff := TMagicEff.Create(magid, effnum, scx, scy, sctx, scty, mtype, Recusion, anitime);
            meff.MagExplosionBase := 1074;
            meff.TargetActor := nil; //target;
            meff.NextFrameTime := 100;
            meff.ExplosionFrame := 10;
            meff.light := 3;
            meff.Colour := clThunderBlue;
            if wimg <> nil then
              meff.ImgLib := g_WMagic99Images;
          end;
        71: begin //Hyperthermia
            ScreenXYfromMCXY(tx - 2, ty - 2, sctx, scty);
            meff := TMagicEff.Create(magid, effnum, scx, scy, sctx, scty, mtype, Recusion, anitime);
            meff.MagExplosionBase := 80;
            meff.TargetActor := nil; //target;
            meff.NextFrameTime := 80;
            meff.ExplosionFrame := 17;
            if wimg <> nil then
              meff.ImgLib := wimg;

            meff.TargetRx := tx - 2;
            meff.TargetRy := ty - 2;
            meff.MagOwner := aowner;
            meff.Light := 2;
            meff.Colour := clIceBlue;
            m_EffectList.Add(meff);

            ScreenXYfromMCXY(tx + 2, ty - 2, sctx, scty);
            meff := TMagicEff.Create(magid, effnum, scx, scy, sctx, scty, mtype, Recusion, anitime);
            meff.MagExplosionBase := 80;
            meff.TargetActor := nil; //target;
            meff.NextFrameTime := 80;
            meff.ExplosionFrame := 17;
            if wimg <> nil then
              meff.ImgLib := wimg;

            meff.TargetRx := tx + 2;
            meff.TargetRy := ty - 2;
            meff.MagOwner := aowner;
            meff.Light := 2;
            meff.Colour := clIceBlue;
            m_EffectList.Add(meff);

            ScreenXYfromMCXY(tx + 2, ty + 2, sctx, scty);
            meff := TMagicEff.Create(magid, effnum, scx, scy, sctx, scty, mtype, Recusion, anitime);
            meff.MagExplosionBase := 80;
            meff.TargetActor := nil; //target;
            meff.NextFrameTime := 80;
            meff.ExplosionFrame := 17;
            if wimg <> nil then
              meff.ImgLib := wimg;

            meff.TargetRx := tx + 2;
            meff.TargetRy := ty + 2;
            meff.MagOwner := aowner;
            meff.Light := 2;
            meff.Colour := clIceBlue;
            m_EffectList.Add(meff);

            ScreenXYfromMCXY(tx - 2, ty + 2, sctx, scty);
            meff := TMagicEff.Create(magid, effnum, scx, scy, sctx, scty, mtype, Recusion, anitime);
            meff.MagExplosionBase := 80;
            meff.TargetActor := nil; //target;
            meff.NextFrameTime := 80;
            meff.ExplosionFrame := 17;
            if wimg <> nil then
              meff.ImgLib := wimg;

            meff.TargetRx := tx - 2;
            meff.TargetRy := ty + 2;
            meff.MagOwner := aowner;
            meff.Light := 2;
            meff.Colour := clIceBlue;
            m_EffectList.Add(meff);

            ScreenXYfromMCXY(tx, ty, sctx, scty);
            meff := TMagicEff.Create(magid, effnum, scx, scy, sctx, scty, mtype, Recusion, anitime);
            meff.MagExplosionBase := 80;
            meff.TargetActor := nil; //target;
            meff.NextFrameTime := 80;
            meff.ExplosionFrame := 17;
            if wimg <> nil then
              meff.ImgLib := wimg;

            meff.Light := 2;
            meff.Colour := clIceBlue;
          end;
        72: begin //SoulSteal
            meff := TMagicEff.Create(magid, effnum, scx, scy, sctx, scty, mtype, Recusion, anitime);
            meff.MagExplosionBase := 30;
            meff.TargetActor := nil; //target;
            meff.NextFrameTime := 80;
            meff.ExplosionFrame := 22;
            meff.Light := 3;
            if wimg <> nil then
              meff.ImgLib := wimg;
          end;
        117: begin //IceCrunch
            meff := TMagicEff.Create(magid, effnum, scx, scy, sctx, scty, mtype, Recusion, anitime);
            meff.MagExplosionBase := 3150 + aowner.m_btDir * 10;
            meff.TargetActor := nil; //target;
            meff.NextFrameTime := 80;
            meff.ExplosionFrame := 10;
            meff.ImgLib := g_WcboEffectImages;
            meff.light := 3;
            meff.Colour := clIceBlue;
          end;
        123: begin   //Uproar
            meff := TMagicEff.Create(magid, effnum, scx, scy, sctx, scty, mtype, False, anitime);
            meff.MagExplosionBase := 930;
            meff.TargetActor := aowner; //target;
            meff.NextFrameTime := 40;
            meff.FixedEffect := True;
            meff.ExplosionFrame := 10;
            meff.ImgLib := g_WMagic99Images;
          end;
        124: begin //TitanSmash
            meff := TMagicEff.Create(magid, effnum, scx, scy, sctx, scty, mtype, False, anitime);
            meff.MagExplosionBase := 1391;
            //meff.TargetActor := aowner; //target;
            meff.NextFrameTime := 80;
            meff.ExplosionFrame := 14;
            meff.ImgLib := g_WMagic2Images;
          end;
        4: begin //Poisoning
            meff := TMagicEff.Create(magid, effnum, scx, scy, sctx, scty, mtype, Recusion, anitime);
            meff.TargetActor := target;
            meff.NextFrameTime := 80;
            meff.MagExplosionBase := 578;
            meff.ImgLib := g_WMagic99Images;
            meff.Colour := clPoisonGreen;
          end;
        MAGICEX_AMYOUNSUL: begin //red poisoning
            meff := TMagicEff.Create(magid, effnum, scx, scy, sctx, scty, mtype, Recusion, anitime);
            meff.TargetActor := target;
            meff.NextFrameTime := 80;
            meff.MagExplosionBase := 598;
            meff.ImgLib := g_WMagic99Images;
            meff.Colour := clFireRed;
          end;
        35: begin
          if target <> nil then begin
            meff := TMagicEff.Create(magid, effnum, scx, scy, sctx, scty, mtype,Recusion, anitime);
            meff.ImgLib := g_WMagic2Images;
            meff.MagExplosionBase := 165;
            meff.TargetActor := target;
            meff.NextFrameTime := 80;
            meff.ExplosionFrame := 10;
            meff.light := 1;
          end;
        end;
        65: begin
          meff := TMagicEff.Create(magid, effnum, scx, scy, sctx, scty, mtype, Recusion, anitime);
          meff.ImgLib := g_WMagic2Images;
          meff.MagExplosionBase := 1110;
          meff.TargetActor := target;
          meff.NextFrameTime := 80;
          meff.ExplosionFrame := 10;
          meff.light := 1;
        end;
      else begin //Ä¬ÈÏ
          meff := TMagicEff.Create(magid, effnum, scx, scy, sctx, scty, mtype, Recusion, anitime);
          meff.TargetActor := target;
          meff.NextFrameTime := 80;
        end;
      end;
    end;
    mtFireWind: begin
      case magnumb of
        63: begin
          meff := TDrawTimedEffect.Create(aowner, g_WMagic99Images, 1060, 20000, 5, 100, True);
          meff.Light := 0;
        end;
      end;
    end;
    mtFireGun: begin//hell fire
      meff := TFireGunEffect.Create(930, scx, scy, sctx, scty);
      meff.Colour := clFireRed;
    end;
    mtThunder: begin //different types of thunder bolt
      if magid = 74 then begin
        meff := TThuderEffect.Create(350, sctx, scty, nil); //target);
        meff.ImgLib := g_WDragonImages;
        meff.NextFrameTime := 80;
        meff.ExplosionFrame := 35;
        meff.light := 2; //this was 3
        meff.Colour := clFireRed;
      end else if magid = 75 then begin
        meff := TThuderEffect.Create(400, sctx, scty, nil); //target);
        meff.ExplosionFrame := 4;
        meff.ImgLib := g_WDragonImages;
        meff.Colour := clFireRed;
        meff.Light := 1;
        SoundUtil.PlaySound(8301);
      end else if magid = 76 then begin  //lava
        meff := TThuderEffect.Create(440, sctx, scty, nil); //target);
        meff.ExplosionFrame := 20;
        meff.ImgLib := g_WDragonImages;
        meff.Colour := clFireRed;
        meff.Light := 1;
        SoundUtil.PlaySound(8302);
      end else begin
          meff := TThuderEffect.Create(10, sctx, scty, nil); //target);
          meff.ExplosionFrame := 10;
          meff.MagExplosionBase := 20;
          meff.NextFrameTime := 80;
          meff.ImgLib := g_WMagic2Images;
          meff.Colour := clThunderBlue;
          meff.Light := 1;
      end;
    end;
    mtLightingThunder: begin //lightning
      meff := TLightingThunder.Create(970, scx, scy, sctx, scty, target);
      meff.Colour := clThunderBlue;
      meff.Light := 1;
    end;
    mtExploBujauk: begin //different types of amulet throw
      case magnumb of
        10: begin //  soul fire ball
          meff := TExploBujaukEffect.Create(140, scx, scy, sctx, scty, target);
          meff.ImgLib := g_WMagic6Images;
          TExploBujaukEffect(meff).MagicNumber := 10;
          meff.MagExplosionBase := 300;
          end;
        59: begin // mass soul fire ball
          meff := TExploBujaukEffect.Create(1110, scx, scy, sctx, scty, target);
          meff.ImgLib := g_WMagic8Images;
          TExploBujaukEffect(meff).MagicNumber := 10;
          TExploBujaukEffect(meff).MagicBlend := True;
          meff.MagExplosionBase := 1640;
          meff.frame := 6;
        end;
        17: begin // MassHiding
          meff := TExploBujaukEffect.Create(140, scx, scy, sctx, scty, target);
          TExploBujaukEffect(meff).MagicNumber := 17;
          meff.ImgLib := g_WMagic6Images;
          meff.MagExplosionBase := 1540;
        end;
        94: begin
          meff := TExploBujaukEffect.Create(140, scx, scy, sctx, scty, target);
          TExploBujaukEffect(meff).MagicNumber := 11;
          meff.ImgLib := g_WMagic6Images;
          meff.MagExplosionBase := 1320;
        end;
      end;
      bofly := True;
    end;
    mtBujaukGroundEffect: begin
        meff := TBujaukGroundEffect.Create(140, magnumb, scx, scy, sctx, scty);
        meff.ImgLib := g_WMagic6Images;
        case magnumb of
          11: begin
            meff.ExplosionFrame := 20; //
            meff.Colour := clThunderBlue;
            meff.Light := 3;
          end;
          12: begin
            meff.ExplosionFrame := 20; //
            meff.Colour := clFireRed;
            meff.Light := 3;
          end;
          46: begin
            meff.ExplosionFrame := 24;
            meff.Colour := clPoisonGreen;
            meff.light := 3;
          end;
        end;
        bofly := True;
      end;
    mtKyulKai: begin
        meff := nil; //TKyulKai.Create (1380, scx, scy, sctx, scty);
      end;
    mt12: begin
      meff := nil;
    end;
    mt13: begin
      meff := TMagicEff.Create(magid, effnum, scx, scy, sctx, scty, mtype, Recusion, anitime);
      if meff <> nil then begin
        case magnumb of
          32: begin //MinotaurKing Red Circle attack
            meff.ImgLib := g_WMobMagicImages;
            meff.MagExplosionBase := 126;
            meff.TargetActor := target;
            meff.light := 3;
            meff.Colour := clFireRed;
            meff.NextFrameTime := 20;
          end;
          37: begin
            meff.ImgLib := g_WMons[22];  //OmaKing mass attack
            meff.MagExplosionBase := 3520;
            meff.TargetActor := target;
            meff.light := 3;
            meff.NextFrameTime := 50;
            SoundUtil.PlaySound(2396);
          end;
          38: begin
            meff.ImgLib := g_WMons[32];  //OrcGiant Smash Attack
            meff.MagExplosionBase := 6530;
            meff.frame := 5;
            meff.TargetActor := target;
            meff.light := 3;
            meff.NextFrameTime := 100;
            //SoundUtil.PlaySound(2396);
          end;
          39: begin
            meff.ImgLib := g_WMons[32];  //OrcGiant Explosion
            meff.MagExplosionBase := 6640;
            meff.frame := 10;
            meff.TargetActor := target;
            meff.light := 4;
            meff.NextFrameTime := 100;
            //SoundUtil.PlaySound(2396);
          end;
          40: begin
            meff.ImgLib := g_WMons[32];  //OrcGiant Explosion Smoke
            meff.MagExplosionBase := 6630;
            meff.frame := 10;
            meff.TargetActor := target;
            meff.light := 2;
            meff.NextFrameTime := 200;
            //SoundUtil.PlaySound(2396);
          end;
          41: begin
            meff.ImgLib := g_WMons[32];  //OrcGiant Explosion Smoke
            meff.MagExplosionBase := 7510;
            meff.frame := 10;
            meff.TargetActor := target;
            meff.light := 3;
            meff.NextFrameTime := 100;
            //SoundUtil.PlaySound(2396);
          end;
        end;
      end;
    end;
    mt14: begin //FlameDisruptor
      meff := TThuderEffect.Create(100, sctx, scty, nil); //target);
      meff.ExplosionFrame := 15;
      meff.MagExplosionBase := 100;
      meff.ImgLib := g_WMagic6Images;
      meff.Colour := clFireRed;
      meff.Light := 2;
    end;
    mt15: begin
      meff := TFlyingBug.Create(magid, effnum, scx, scy, sctx, scty, mtype,
          Recusion, anitime);
      meff.TargetActor := target;
      bofly := True;
    end;
    mt16: begin

    end;
  end;

  if (meff = nil) then
    Exit;

  meff.TargetRx := tx;
  meff.TargetRy := ty;
  if meff.TargetActor <> nil then begin
    meff.TargetRx := TActor(meff.TargetActor).m_nCurrX;
    meff.TargetRy := TActor(meff.TargetActor).m_nCurrY;
  end;
  meff.MagOwner := aowner;
  meff.user_x := scx;
  meff.user_y := scy;
  m_EffectList.Add(meff);
end;

procedure TPlayScene.DelMagic(magid: Integer);
var
  i: Integer;
begin
  for i := 0 to m_EffectList.count - 1 do begin
    if TMagicEff(m_EffectList[i]).ServerMagicId = magid then begin
      TMagicEff(m_EffectList[i]).Free;
      m_EffectList.Delete(i);
      break;
    end;
  end;
end;

//cx, cy, tx, ty : ¸ÊÀÇ ÁÂÇ¥

function TPlayScene.NewFlyObject(aowner: TActor; cx, cy, tx, ty, targetcode:
  Integer; mtype: TMagicType): TMagicEff;
var
  scx, scy, sctx, scty: Integer;
  meff: TMagicEff;
begin
  ScreenXYfromMCXY(cx, cy, scx, scy);
  ScreenXYfromMCXY(tx, ty, sctx, scty);
  case mtype of
    mtFlyArrow: meff := TFlyingArrow.Create(1, 1, scx, scy, sctx, scty, mtype, True, 0);
    mt12: meff := TFlyingFireBall.Create(1, 1, scx, scy, sctx, scty, mtype, True, 0);
    mt15: meff := TFlyingBug.Create(1, 1, scx, scy, sctx, scty, mtype, True, 0);
  else
    meff := TFlyingAxe.Create(1, 1, scx, scy, sctx, scty, mtype, True, 0);
  end;
  meff.TargetRx := tx;
  meff.TargetRy := ty;
  meff.TargetActor := FindActor(targetcode);
  meff.MagOwner := aowner;
  m_FlyList.Add(meff);
  Result := meff;
end;

procedure TPlayScene.ScreenXYfromMCXY(cx, cy: Integer; var sx, sy: Integer);
begin
  if g_MySelf = nil then Exit;
  if g_FScreenWidth = 1024 then sx := (cx - g_MySelf.m_nRx) * UNITX + 476 + UNITX div 2 - g_MySelf.m_nShiftX
  else sx := (cx - g_MySelf.m_nRx) * UNITX + 364 + UNITX div 2 - g_MySelf.m_nShiftX;
  if g_FScreenHeight = 768 then sy := (cy - g_MySelf.m_nRy) * UNITY + 320 + UNITY div 2 - g_MySelf.m_nShiftY
  else sy := (cy - g_MySelf.m_nRy) * UNITY + 224 + UNITY div 2 - g_MySelf.m_nShiftY;
end;

//ÆÁÄ»×ù±ê mx, my×ª»»³Éccx, ccyµØÍ¼×ù±ê

procedure TPlayScene.CXYfromMouseXY(mx, my: Integer; var ccx, ccy: Integer);
begin
  if g_MySelf = nil then Exit;
  if g_FScreenWidth = 1024 then ccx := Round((mx - 476 + g_MySelf.m_nShiftX - UNITX div 2) / UNITX) + g_MySelf.m_nRx
  else ccx := Round((mx - 364 + g_MySelf.m_nShiftX - UNITX div 2) / UNITX) + g_MySelf.m_nRx;

  if g_FScreenHeight = 768 then ccy := Round((my - 320 + g_MySelf.m_nShiftY - UNITY div 2) / UNITY) + g_MySelf.m_nRy
  else ccy := Round((my - 224 + g_MySelf.m_nShiftY - UNITY div 2) / UNITY) + g_MySelf.m_nRy;
end;

//È­¸éÁÂÇ¥·Î Ä³¸¯ÅÍ, ÇÈ¼¿ ´ÜÀ§·Î ¼±ÅÃ..

function TPlayScene.GetCharacter(X, Y, wantsel: Integer; var nowsel: Integer;
  liveonly: Boolean): TActor;
var
  k, i, ccx, ccy, dx, dy: Integer;
  a: TActor;
begin
  Result := nil;
  nowsel := -1;
  CXYfromMouseXY(X, Y, ccx, ccy);
  for k := ccy + 8 downto ccy - 1 do begin
    for i := m_ActorList.count - 1 downto 0 do
      if TActor(m_ActorList[i]) <> g_MySelf then begin
        a := TActor(m_ActorList[i]);
        if (not liveonly or not a.m_boDeath) and (a.m_boHoldPlace) and (a.m_boVisible) then begin
          if a.m_nCurrY = k then begin
            //´õ ³ÐÀº ¹üÀ§·Î ¼±ÅÃµÇ°Ô
            dx := (a.m_nRx - Map.m_ClientRect.Left) * UNITX + m_nDefXX + a.m_nPx + a.m_nShiftX;
            dy := (a.m_nRy - Map.m_ClientRect.Top - 1) * UNITY + m_nDefYY + a.m_nPy + a.m_nShiftY;
            if a.CheckSelect(X - dx, Y - dy) then begin
              Result := a;
              Inc(nowsel);
              if nowsel >= wantsel then
                Exit;
            end;
          end;
        end;
      end;
  end;
end;

//È¡µÃÊó±êËùÖ¸×ø±êµÄ½ÇÉ«

function TPlayScene.GetAttackFocusCharacter(X, Y, wantsel: Integer; var nowsel:
  Integer; liveonly: Boolean): TActor;
var
  k, i, ccx, ccy, dx, dy, centx, centy: Integer;
  a: TActor;
begin            
  Result := GetCharacter(X, Y, wantsel, nowsel, liveonly);
  if Result = nil then begin
    nowsel := -1;
    CXYfromMouseXY(X, Y, ccx, ccy);
    for k := ccy + 8 downto ccy - 1 do begin
      for i := m_ActorList.count - 1 downto 0 do
        if TActor(m_ActorList[i]) <> g_MySelf then begin
          a := TActor(m_ActorList[i]);
          if (not liveonly or not a.m_boDeath) and (a.m_boHoldPlace) and (a.m_boVisible) then begin
            if a.m_nCurrY = k then begin
              //
              dx := (a.m_nRx - Map.m_ClientRect.Left) * UNITX + m_nDefXX + a.m_nPx + a.m_nShiftX;
              dy := (a.m_nRy - Map.m_ClientRect.Top - 1) * UNITY + m_nDefYY + a.m_nPy + a.m_nShiftY;
              if a.CharWidth > 40 then
                centx := (a.CharWidth - 40) div 2
              else
                centx := 0;
              if a.CharHeight > 70 then
                centy := (a.CharHeight - 70) div 2
              else
                centy := 0;
              if (X - dx >= centx) and (X - dx <= a.CharWidth - centx) and (Y - dy >= centy) and
                (Y - dy <= a.CharHeight - centy) then begin
                Result := a;
                Inc(nowsel);
                if nowsel >= wantsel then
                  Exit;
              end;
            end;
          end;
        end;
    end;
  end;
end;

function TPlayScene.IsSelectMyself(X, Y: Integer): Boolean;
var
  k, ccx, ccy, dx, dy: Integer;
begin
  Result := FALSE;
  CXYfromMouseXY(X, Y, ccx, ccy);
  for k := ccy + 2 downto ccy - 1 do begin
    if g_MySelf.m_nCurrY = k then begin
      //´õ ³ÐÀº ¹üÀ§·Î ¼±ÅÃµÇ°Ô
      dx := (g_MySelf.m_nRx - Map.m_ClientRect.Left) * UNITX + m_nDefXX + g_MySelf.m_nPx + g_MySelf.m_nShiftX;
      dy := (g_MySelf.m_nRy - Map.m_ClientRect.Top - 1) * UNITY + m_nDefYY + g_MySelf.m_nPy + g_MySelf.m_nShiftY;
      if g_MySelf.CheckSelect(X - dx, Y - dy) then begin
        Result := True;
        Exit;
      end;
    end;
  end;
end;
//È¡µÃÖ¸¶¨×ù±êµØÃæÎïÆ·
// x,y ÎªÆÁÄ»×ù±ê

function TPlayScene.GetDropItems(X, Y: Integer; var inames: string; var MaxWidth: Integer): pTDropItem;
//È­¸éÁÂÇ¥·Î ¾ÆÀÌÅÛ
var
  i, ccx, ccy, ssx, ssy {, dx, dy}, nWidth: Integer;
  DropItem: pTDropItem;
  //S: TDirectDrawSurface;
  //  c: byte;
begin
  Result := nil;
  CXYfromMouseXY(X, Y, ccx, ccy);
  ScreenXYfromMCXY(ccx, ccy, ssx, ssy);
  //  dx := X - ssx;
  //  dy := Y - ssy;
  inames := '';
  MaxWidth := 0;
  for i := 0 to g_DropedItemList.count - 1 do begin
    DropItem := pTDropItem(g_DropedItemList[i]);
    if (DropItem.X = ccx) and (DropItem.Y = ccy) then begin
      {S := GetDnItemImg(DropItem.looks);
      if S = nil then
        continue;     }
      if Result = nil then
        Result := DropItem;
      nWidth := g_DXCanvas.TextWidth(DropItem.name);
      if nWidth > MaxWidth then MaxWidth := nWidth;
      if (DropItem.nColor <> 15718028) then
      inames := inames + '<Color=' + IntToStr(clWebGold) + '>' +DropItem.name + '<ENDCOLOR>' + '\'
      else
        inames := inames + DropItem.name + '\';
      //break;
    //end;
    end;
  end;
end;

procedure TPlayScene.GetXYDropItemsList(nX, nY: Integer; var ItemList: TList);
var
  i: Integer;
  DropItem: pTDropItem;
begin
  for i := 0 to g_DropedItemList.count - 1 do begin
    DropItem := g_DropedItemList[i];
    if (DropItem.X = nX) and (DropItem.Y = nY) then begin
      ItemList.Add(DropItem);
    end;
  end;
end;

function TPlayScene.GetXYDropItems(nX, nY: Integer): pTDropItem;
var
  i: Integer;
  DropItem: pTDropItem;
begin
  Result := nil;
  for i := 0 to g_DropedItemList.count - 1 do begin
    DropItem := g_DropedItemList[i];
    if (DropItem.X = nX) and (DropItem.Y = nY) then begin
      Result := DropItem;
      break;
    end;
  end;
end;

function TPlayScene.CanHorseRun(sx, sy, ex, ey: Integer): Boolean;
var
  ndir, rx, ry: Integer;
begin
  Result := False;
  if g_boSendLuck then
    exit;

  ndir := GetNextDirection(sx, sy, ex, ey);
  rx := sx;
  ry := sy;
  GetNextPosXY(ndir, rx, ry);
  if not CanWalkEx(rx, ry) then
    exit;
  GetNextPosXY(ndir, rx, ry);
  if CanWalkEx(rx, ry) and CanWalkEx(ex, ey) then
    Result := True
  else
    Result := FALSE;
end;

function TPlayScene.CanHorseRunEx(sx, sy, ex, ey: Integer): Boolean;
var
  ndir, rx, ry: Integer;
begin
  Result := False;
  if g_boSendLuck then
    exit;

  ndir := GetNextDirection(sx, sy, ex, ey);
  rx := sx;
  ry := sy;
  GetNextPosXY(ndir, rx, ry);
  if not CanWalkEx2(rx, ry) then
    exit;
  GetNextPosXY(ndir, rx, ry);
  if CanWalkEx2(rx, ry) and CanWalkEx2(ex, ey) then
    Result := True
  else
    Result := FALSE;
end;

function TPlayScene.CanLeap(sx, sy, ex, ey: Integer): Boolean;
begin
  Result := False;
  if g_boSendLuck then
    exit;
  if CanWalkEx(ex, ey) then
    Result := True
  else
    Result := FALSE;
end;

function TPlayScene.CanRun(sx, sy, ex, ey: Integer): Boolean;
var
  ndir, rx, ry: Integer;
begin
  Result := False;
  if g_boSendLuck then
    exit;
  ndir := GetNextDirection(sx, sy, ex, ey);
  rx := sx;
  ry := sy;
  GetNextPosXY(ndir, rx, ry);

  if CanWalkEx(rx, ry) and CanWalkEx(ex, ey) then
    Result := True
  else
    Result := FALSE;
end;

function TPlayScene.CanRunEx(sx, sy, ex, ey: Integer): Boolean;
var
  ndir, rx, ry: Integer;
begin
  ndir := GetNextDirection(sx, sy, ex, ey);
  rx := sx;
  ry := sy;
  GetNextPosXY(ndir, rx, ry);

  if CanWalkEx2(rx, ry) and CanWalkEx2(ex, ey) then
    Result := True
  else
    Result := FALSE;

end;

function TPlayScene.CanWalkEx(mx, my: Integer): Boolean;
begin
  Result := FALSE;
  if Map.CanMove(mx, my) then
    Result := not CrashManEx(mx, my);
end;

function TPlayScene.CanWalkEx2(mx, my: Integer): Boolean;
begin
  Result := FALSE;
  if Map.CanMove(mx, my) then
    Result := not CrashManEx2(mx, my);
end;

function TPlayScene.CrashManEx2(mx, my: Integer): Boolean;
var
  i: Integer;
  Actor: TActor;
begin
  Result := FALSE;
  for i := 0 to m_ActorList.count - 1 do begin
    Actor := TActor(m_ActorList[i]);
    if (Actor.m_boVisible) and (Actor.m_boHoldPlace) and (not Actor.m_boDeath)
      and (Actor.m_nCurrX = mx) and (Actor.m_nCurrY = my) then begin
      Result := True;
      break;
    end;
  end;
end;
//´©ÈË

function TPlayScene.CrashManEx(mx, my: Integer): Boolean;
var
  i: Integer;
  Actor: TActor;
begin
  Result := FALSE;

  for i := 0 to m_ActorList.count - 1 do begin
    Actor := TActor(m_ActorList[i]);
    if (Actor.m_boVisible) and (Actor.m_boHoldPlace) and (not Actor.m_boDeath)
      and (Actor.m_nCurrX = mx) and (Actor.m_nCurrY = my) then begin
      //      DScreen.AddChatBoardString ('Actor.m_btRace ' + IntToStr(Actor.m_btRace),clWhite, clRed);
      if g_ClientConf.boWarDisHumRun and (g_nAreaStateValue = OT_FREEPKAREA) then begin
        Result := True;
        Exit;
      end;
      if (Actor.m_btRace = RCC_USERHUMAN) then begin
        if g_ClientConf.boRUNHUMAN or (g_ClientConf.SafeAreaLimited and (g_nAreaStateValue = OT_SAFEAREA)) then
          continue;
      end
      else if (Actor.m_btRace = RCC_MERCHANT) then begin
        if g_ClientConf.boRunNpc then
          continue;
      end
      else if ((Actor.m_btRace <> RCC_USERHUMAN) and (Actor.m_btRaceServer in [RC_GUARD, RC_ARCHERGUARD])) then begin
        if g_ClientConf.boRunGuard then
          continue;
      end
      else if (Actor.m_btRaceServer <> 55) and (Actor.m_btRaceServer <> 30) then begin
        if g_ClientConf.boRUNMON or
          (g_ClientConf.SafeAreaLimited and (g_nAreaStateValue = OT_SAFEAREA)) then
          Continue;
      end;
      //m_btRace ´óÓÚ 0 ²¢²»µÈÓÚ 50 ÔòÎª¹ÖÎï
      Result := True;
      break;
    end;
  end;
end;

function TPlayScene.CanWalk(mx, my: Integer): Boolean;
begin
  if g_boSendLuck then begin
    Result := False;
    exit;
  end;
  Result := FALSE;
  if Map.CanMove(mx, my) then
    Result := not CrashMan(mx, my);
end;

function TPlayScene.CrashMan(mx, my: Integer): Boolean;
var
  i: Integer;
  a: TActor;
begin
  Result := FALSE;
  for i := 0 to m_ActorList.count - 1 do begin
    a := TActor(m_ActorList[i]);
    if (a.m_boVisible) and (a.m_boHoldPlace) and (not a.m_boDeath) and
      (a.m_nCurrX = mx) and (a.m_nCurrY = my) then begin
      Result := True;
      break;
    end;
  end;
end;

function TPlayScene.CanDrawTileMap: Boolean;
begin
  Result := False;
  with Map do
    if (m_ClientRect.Left = m_OldClientRect.Left) and (m_ClientRect.Top = m_OldClientRect.Top) then
      Exit;
  if not g_boDrawTileMap then
    Exit;
  Result := True;
end;

function TPlayScene.CanFly(mx, my: Integer): Boolean;
begin
  Result := Map.CanFly(mx, my);
end;

{------------------------ Actor ------------------------}

function TPlayScene.FindNpcActor(id: Integer): TNpcActor;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to m_ActorList.count - 1 do begin
    if TActor(m_ActorList[i]).m_nRecogId = id then begin
      if TActor(m_ActorList[i]) is TNpcActor then begin
        Result := TNpcActor(m_ActorList[i]);
      end;
      break;
    end;
  end;
end;

function TPlayScene.FindActor(id: Integer): TActor;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to m_ActorList.count - 1 do begin
    if TActor(m_ActorList[i]).m_nRecogId = id then begin
      Result := TActor(m_ActorList[i]);
      break;
    end;
  end;
end;

function TPlayScene.FindActor(sname: string): TActor;
var
  i: Integer;
  Actor: TActor;
begin
  Result := nil;
  for i := 0 to m_ActorList.count - 1 do begin
    Actor := TActor(m_ActorList[i]);
    if CompareText(Actor.m_UserName, sname) = 0 then begin
      Result := Actor;
      break;
    end;
  end;
end;

function TPlayScene.FindActorXY(X, Y: Integer): TActor;
//¸Ê ÁÂÇ¥·Î actor ¾òÀ½
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to m_ActorList.count - 1 do begin
    if (TActor(m_ActorList[i]).m_nCurrX = X) and (TActor(m_ActorList[i]).m_nCurrY = Y) then begin
      Result := TActor(m_ActorList[i]);
      if (not Result.m_boDeath) and Result.m_boVisible and Result.m_boHoldPlace then
        break;
      Result := nil;
    end;
  end;
end;

function TPlayScene.IsValidActor(Actor: TActor): Boolean;
var
  i: Integer;
begin
  Result := FALSE;
  for i := 0 to m_ActorList.count - 1 do begin
    if TActor(m_ActorList[i]) = Actor then begin
      Result := True;
      break;
    end;
  end;
end;

procedure TPlayScene.Lost;
begin
  if m_MapSurface <> nil then
    m_MapSurface.Lost;
  if m_ObjSurface <> nil then
    m_ObjSurface.Lost;
  if m_MagSurface <> nil then
    m_MagSurface.Lost;
  if m_LightSurface <> nil then
    m_LightSurface.Lost;
end;

procedure TPlayScene.ClearMissionList(Actor: TActor);
var
  ClientMission: pTClientMission;
begin
  if Actor.m_btRace = 50 then begin
    with Actor as TNPCActor do begin
      if m_MissionList <> nil then begin
        for ClientMission in m_MissionList do begin
          ClientMission.NPC := nil;
        end;
        m_MissionList.Clear;
      end;
    end;
  end;
end;

procedure TPlayScene.SetMissionList(Actor: TNPCActor);
var
  ClientMission: pTClientMission;
begin
  with Actor do begin
    if m_MissionList <> nil then begin
      m_MissionList.Clear;
    end;
    for ClientMission in g_MissionList do begin
      if (CompareText(ClientMission.sNPCMapName, g_sMapTitle) = 0) and
        (ClientMission.wNPCCurrX = m_nCurrX) and (ClientMission.wNPCCurrY = m_nCurrY) then begin
        if m_MissionList = nil then
          m_MissionList := TList.Create;
        ClientMission.NPC := Actor;
        m_MissionList.Add(ClientMission);
      end;
    end;
  end;
end;

procedure TPlayScene.RefMissionList;
var
  Actor: TActor;
  I: Integer;
begin
  for I := 0 to m_ActorList.Count - 1 do begin
    Actor := TActor(m_ActorList.Items[I]);
    if (Actor.m_btRace = 50) then begin
      SetMissionList(TNPCActor(Actor));
    end;
  end;
end;

procedure TPlayScene.RefMissionInfo;
var
  Actor: TActor;
  I: Integer;
begin
  if g_MySelf = nil then exit;
  for I := 0 to m_ActorList.Count - 1 do begin
    Actor := TActor(m_ActorList.Items[I]);
    if (Actor.m_btRace = 50) then begin
      SetMissionInfo(TNPCActor(Actor));
    end;
  end;
end;

procedure TPlayScene.SetMissionInfo(Actor: TNPCActor);
var
  MissionList: TList;
  ClientMission: pTClientMission;
  MissionInfo: pTClientMissionInfo;
  MissionStatus, OldMissionStatus: TNPCMissionStatus;
begin
  if g_MySelf = nil then exit;
  MissionList := Actor.m_MissionList;
  Actor.m_MissionStatus := NPCMS_None;
  if (MissionList <> nil) and (MissionList.Count > 0) then begin
    for ClientMission in MissionList do begin
      if ClientMission.boHide then Continue;
      if Actor.m_MissionStatus = NPCMS_Complete then break;
      MissionInfo := pTClientMissionInfo(ClientMission.MissionInfo);
      OldMissionStatus := Actor.m_MissionStatus;
      MissionStatus := OldMissionStatus;
      //ÊÇ·ñÓÐÒÑÍê³ÉÈÎÎñ
      if (MissionInfo <> nil) and (not ClientMission.boAccept) then begin
        if OldMissionStatus = NPCMS_None then
          OldMissionStatus := NPCMS_Atelic;
        MissionStatus := NPCMS_Complete;
        if (ClientMission.CompleteFlag[0].nFlag <> 0) and
          (GetMissionFlagStatus(ClientMission.CompleteFlag[0].nFlag) <> ClientMission.CompleteFlag[0].btValue) then
          MissionStatus := OldMissionStatus;
        if (MissionStatus = NPCMS_Complete) and (ClientMission.CompleteFlag[1].nFlag <> 0) and
          (GetMissionFlagStatus(ClientMission.CompleteFlag[1].nFlag) <> ClientMission.CompleteFlag[1].btValue) then
          MissionStatus := OldMissionStatus;
        if (MissionStatus = NPCMS_Complete) and (ClientMission.CompleteFlag[2].nFlag <> 0) and
          (GetMissionFlagStatus(ClientMission.CompleteFlag[2].nFlag) <> ClientMission.CompleteFlag[2].btValue) then
          MissionStatus := OldMissionStatus;

        if ((MissionStatus = NPCMS_Complete) and (MissionInfo <> nil) and
          (MissionInfo.nItemCount1 < ClientMission.CompleteItem[0].wItemCount)) then
          MissionStatus := OldMissionStatus;
        if ((MissionStatus = NPCMS_Complete) and (MissionInfo <> nil) and
          (MissionInfo.nItemCount2 < ClientMission.CompleteItem[1].wItemCount)) then
          MissionStatus := OldMissionStatus;
        if ((MissionStatus = NPCMS_Complete) and (MissionInfo <> nil) and
          (MissionInfo.nItemCount3 < ClientMission.CompleteItem[2].wItemCount)) then
          MissionStatus := OldMissionStatus;

        if ((MissionStatus = NPCMS_Complete) and (MissionInfo <> nil) and
          (MissionInfo.MissionInfo.btKillCount1 < ClientMission.btKillCount1)) then
          MissionStatus := OldMissionStatus;
        if ((MissionStatus = NPCMS_Complete) and (MissionInfo <> nil) and
          (MissionInfo.MissionInfo.btKillCount2 < ClientMission.btKillCount2)) then
          MissionStatus := OldMissionStatus;
      end else
      if ClientMission.boAccept and (OldMissionStatus <> NPCMS_Complete) and (OldMissionStatus <> NPCMS_Accept) then begin
        MissionStatus := NPCMS_Accept;
        if (ClientMission.AcceptFlag[0].nFlag <> 0) and
          (GetMissionFlagStatus(ClientMission.AcceptFlag[0].nFlag) <> ClientMission.AcceptFlag[0].btValue) then
          MissionStatus := OldMissionStatus;
        if (MissionStatus = NPCMS_Accept) and (ClientMission.AcceptFlag[1].nFlag <> 0) and
          (GetMissionFlagStatus(ClientMission.AcceptFlag[1].nFlag) <> ClientMission.AcceptFlag[1].btValue) then
          MissionStatus := OldMissionStatus;
        if (MissionStatus = NPCMS_Accept) and (ClientMission.AcceptFlag[2].nFlag <> 0) and
          (GetMissionFlagStatus(ClientMission.AcceptFlag[2].nFlag) <> ClientMission.AcceptFlag[2].btValue) then
          MissionStatus := OldMissionStatus;

        if (MissionStatus = NPCMS_Accept) and (ClientMission.btJob <> 99) and (g_MySelf.m_btJob <> ClientMission.btJob) then
          MissionStatus := OldMissionStatus;

        if (MissionStatus = NPCMS_Accept) and (ClientMission.btSex <> 99) and (g_MySelf.m_btSex <> ClientMission.btSex) then
          MissionStatus := OldMissionStatus;

        if (MissionStatus = NPCMS_Accept) and
          ((g_MySelf.m_Abil.Level < ClientMission.nMinLevel) or (g_MySelf.m_Abil.Level > ClientMission.nMaxLevel)) then
          MissionStatus := OldMissionStatus;

        if (MissionStatus = NPCMS_Accept) and (ClientMission.btCycCount > 0) and
          (ClientMission.btCycVar in [Low(g_MissionArithmometer)..High(g_MissionArithmometer)]) and
          (g_MissionArithmometer[ClientMission.btCycVar] >= ClientMission.btCycCount) then
          MissionStatus := OldMissionStatus;                                   
      end;
      Actor.m_MissionStatus := MissionStatus;
    end;
  end;
end;

function TPlayScene.NewActor(chrid: Integer;
  cx: Word; //x
  cy: Word; //y
  cdir: Word;
  cfeature: Integer; //race, hair, dress, weapon
  cstate: Integer;
  btSIdx, btWuXin: Integer): TActor;
var
  i: Integer;
  Actor: TActor;
begin
  Result := nil; //jacky
  for i := 0 to m_ActorList.count - 1 do
    if TActor(m_ActorList[i]).m_nRecogId = chrid then begin
      Result := TActor(m_ActorList[i]);
      Exit; //ÀÌ¹Ì ÀÖÀ½
    end;
  if IsChangingFace(chrid) then
    Exit; //º¯½ÅÁß...

  case RACEfeature(cfeature) of //m_btRaceImg
    0: Actor := THumActor.Create; //ÈËÎï
    9: Actor := TSoccerBall.Create; //×ãÇò
    13: Actor := TKillingHerb.Create; //Ê³ÈË»¨
    14: Actor := TSkeletonOma.Create; //÷¼÷Ã
    15: Actor := TDualAxeOma.Create; //ÖÀ¸«÷¼÷Ã

    16: Actor := TGasKuDeGi.Create; //¶´Çù

    17: Actor := TCatMon.Create; //¹³×¦Ã¨
    18: Actor := THuSuABi.Create; //µ¾²ÝÈË
    19: Actor := TCatMon.Create; //ÎÖÂêÕ½Ê¿

    20: Actor := TFireCowFaceMon.Create; //»ðÑæÎÖÂê
    21: Actor := TCowFaceKing.Create; //ÎÖÂê½ÌÖ÷
    22: Actor := TDualAxeOma.Create; //ºÚ°µÕ½Ê¿
    23: Actor := TWhiteSkeleton.Create; //±äÒì÷¼÷Ã
    24: Actor := TSuperiorGuard.Create; //´øµ¶ÎÀÊ¿
    25: Actor := TBoxSpider.Create;
    26: Actor := TGrassSpider.Create;
    30: Actor := TCatMon.Create; //³¯°³Áþ
    31: Actor := TCatMon.Create; //½ÇÓ¬
    32: Actor := TScorpionMon.Create; //Ð«×Ó

    33: Actor := TCentipedeKingMon.Create; //´¥ÁúÉñ
    34: Actor := TBigHeartMon.Create; //³àÔÂ¶ñÄ§
    35: Actor := TSpiderHouseMon.Create; //»ÃÓ°Ö©Öë
    36: Actor := TExplosionSpider.Create; //ÔÂÄ§Ö©Öë
    37: Actor := TFlyingSpider.Create; //

    40: Actor := TZombiLighting.Create; //½©Ê¬1
    41: Actor := TZombiDigOut.Create; //½©Ê¬2
    42: Actor := TZombiZilkin.Create; //½©Ê¬3

    43: Actor := TBeeQueen.Create; //½ÇÓ¬³²
    44: Actor := TMoonMon.Create;
    45: Actor := TArcherMon.Create; //¹­¼ýÊÖ
    47: Actor := TSculptureMon.Create; //×æÂêµñÏñ  »ðÁú½«¾ü
    48: Actor := TSculptureMon.Create; //
    49: Actor := TSculptureKingMon.Create; //×æÂê½ÌÖ÷
    //242: Actor := TTiger.Create;

    50: begin
      case APPRfeature(cfeature) of
        52, 78: Actor := TSnowmanNpcActor.Create; //Ñ©ÈË
        53, 77, 80, 81, 92, 96: Actor := TFixedNpcActor.Create;
        54..64, 74, 76, 146: Actor := TBoxNpcActor.Create;
        67..69, 79: Actor := THeroNpcActor.Create;
        70: Actor := TDynamicBoxNpcActor.Create;
        75: Actor := TTavernNpcActor.Create;
        125: Actor := TQuiescenceNpcActor.Create;
        83, 88..90, 94, 126..139, 141..143, 147..152, 162, 164..166, 169..175, 177, 178, 180: Actor := TBaseNpcActor.Create;
        156: Actor := TStatuaryNpcActor.Create;
        140, 144: Actor := TTreeNpcActor.Create;
        145: Actor := TDynamicTreeNpcActor.Create;
        153: Actor := TFlyDynamicNpcActor.Create;
        154..155: Actor := TMachineryNpcActor.Create;
        157..159, 161, 163, 176, 179: Actor := T2NpcActor.Create;
        82, 160: Actor := TDynamicTree2NpcActor.Create;
        167, 168: Actor := TDynamicTreeNpcActor.Create;
      else Actor := TNpcActor.Create;
      end;
    end;

    52: Actor := TGasKuDeGi.Create; //Ð¨¶ê
    53: Actor := TGasKuDeGi.Create; //·à³æ
    54: Actor := TSmallElfMonster.Create; //ÉñÊÞ
    55: Actor := TWarriorElfMonster.Create; //ÉñÊÞ1

    60: Actor := TElectronicScolpionMon.Create;
    61: Actor := TBossPigMon.Create;
    62: Actor := TKingOfSculpureKingMon.Create;
    63: Actor := TSkeletonKingMon.Create;
    64: Actor := TGasKuDeGi.Create;
    65: Actor := TSamuraiMon.Create;
    66: Actor := TSkeletonSoldierMon.Create;
    67: Actor := TSkeletonSoldierMon.Create;
    68: Actor := TSkeletonSoldierMon.Create;
    69: Actor := TBoneArcher.Create;
    70: Actor := TMinoGuard.Create;
    71: Actor := TMinoGuard.Create;
    72: Actor := TMinoGuard.Create;
    73: Actor := TPBOMA1Mon.Create;
    74: Actor := TCatMon.Create;
    75: Actor := TStoneMonster.Create;
    76: Actor := TSuperiorGuard.Create;
    77: Actor := TStoneMonster.Create;
    78: Actor := TOmaKing.Create; //Ä§Áú½ÌÖ÷
    79: Actor := TPBOMA6Mon.Create;
    80: Actor := TMineMon.Create;
    81: Actor := TAngel.Create;
    82: Actor := TDragonBody.Create;
    83: Actor := TFireDragon.Create;
    84: Actor := TDragonStatue.Create;
    85: Actor := TDoubleATKSpider.Create; //±ê×¼Ë«ÖØ¹¥»÷¹ÖÎï
    86: Actor := TMagicMonSpider.Create;
    87: Actor := T87KindSpider.Create;
    88: Actor := TDragonStatue.Create;
    90: Actor := TFiredrakeKingSpider.Create; //Áú
    91: Actor := TXueyuKindSpider.Create; //Ñ©ÓòÄ§Íõ
    92: Actor := TM2N4XKingSpider.Create;
   // 93: Actor := TM3N4XKingSpider.Create;
    98: Actor := TWallStructure.Create; //LeftWall
    99: Actor := TCastleDoor.Create; //MainDoor
    100: Actor := TDualEffectSpider.Create;
    101: Actor := TPillarSpider.Create;
    102: Actor := TFrostTiger.Create;
    103: Actor := TKhazardMon.Create;
    104: Actor := TCrystalSpider.Create;
    105: Actor := TYimoogi.Create;
    106: Actor := TRedThunderZuma.Create;
    107: Actor := TBlackFoxMan.Create;
    108: Actor := TRedFoxMan.Create;
    109: Actor := TWhiteFoxMan.Create;
    110: Actor := TElement.Create;
    111: Actor := TElement.Create;
    112: Actor := TTrapRock.Create;
    113: Actor := TGuardianRock.Create;
    114: Actor := TOrbSpirit.Create;
    115: Actor := TOmaKing.Create; //OKS
    116: Actor := TSpiritMonster.Create;
    117: Actor := TDoubleATKSpider.Create;
    118: Actor := TManEaterWorm.Create;
    119: Actor := TOrcObject.Create;
    120: Actor := TIceObject.Create;
    121: Actor := TIceObject.Create;
    122: Actor := TIceObject.Create;
    123: Actor := TIceNode.Create;
    124: Actor := TOrcGiant.Create;
    125: Actor := TOrcWarLord.Create;
  else
    Actor := TActor.Create;
  end;

  with Actor do begin
    m_nRecogId := chrid;
    m_nCurrX := cx;
    m_nCurrY := cy;
    m_nRx := m_nCurrX;
    m_nRy := m_nCurrY;
    m_btDir := cdir;
    m_nFeature := cfeature;
    m_btRace := RACEfeature(cfeature); //changefeature°¡ ÀÖÀ»¶§¸¸
    m_btHair := HAIRfeature(cfeature); //º¯°æµÈ´Ù.
    m_btDress := DRESSfeature(cfeature);
    m_btWeapon := WEAPONfeature(cfeature);
    m_btRaceServer := 0;
    if m_btRace <> 0 then begin
      m_btRaceServer := m_btWeapon;
      m_btWeapon := 0;
    end;

    m_wAppearance := APPRfeature(cfeature);
    m_WMImages := GetMonImg(m_wAppearance);
    //      Horse:=Horsefeature(cfeature);
    //      Effect:=Effectfeature(cfeature);
    m_Action := nil;
    if m_btRace = 0 then begin
      m_btSex := m_btDress mod 2; //0:³²ÀÚ 1:¿©ÀÚ
    end else
    if m_btRace = 50 then begin
      SetMissionList(TNPCActor(Actor));
      SetMissionInfo(TNPCActor(Actor));
      m_btSex := 0;
      if m_wAppearance in [33..50, 53..64, 70, 74, 76..78, 80..82, 92, 96, 140, 145, 146, 154..161, 163, 167, 168, 176, 179] then
        Actor.m_boShowHealthBar := False;
    end
    else begin
      m_btSex := 0;
    end;
    if btSIdx <> -1 then m_btStrengthenIdx := btSIdx;
    if (btWuXin in [1..5]) then m_btWuXin := btWuXin;
    m_nState := cstate;
    //m_SayingArr[0] := '';
    if m_btRace = 0 then begin
      SetActorGroup(Actor);
    end;
  end;
  m_ActorList.Add(Actor);
  Result := Actor;
end;

procedure TPlayScene.SetOperateHint(sHint: string);
begin

end;

procedure TPlayScene.ActorDied(Actor: TObject);
//var
//  i: Integer;
 // flag: Boolean;
begin
  TActor(Actor).m_btHorse := 0;
  {for i := 0 to m_ActorList.count - 1 do
    if m_ActorList[i] = Actor then begin
      m_ActorList.Delete(i);
      break;
    end;
  flag := FALSE;
  for i := 0 to m_ActorList.count - 1 do
    if not TActor(m_ActorList[i]).m_boDeath then begin
      m_ActorList.Insert(i, Actor);
      flag := True;
      break;
    end;
  if not flag then
    m_ActorList.Add(Actor); }
end;

procedure TPlayScene.SetActorDrawLevel(Actor: TObject; Level: Integer);
var
  i: Integer;
begin
  if Level = 0 then begin //¸Ç Ã³À½¿¡ ±×¸®µµ·Ï ÇÔ
    for i := 0 to m_ActorList.count - 1 do
      if m_ActorList[i] = Actor then begin
        m_ActorList.Delete(i);
        m_ActorList.Insert(0, Actor);
        break;
      end;
  end;
end;

procedure TPlayScene.SetMembersGroup(GroupMember: pTGroupMember; boGroup:
  Boolean);
var
  i: Integer;
  Actor: TActor;
begin
  for i := 0 to m_ActorList.count - 1 do begin
    Actor := m_ActorList.Items[i];
    if GroupMember.ClientGroup.UserID = Actor.m_nRecogId then begin
      if boGroup then begin
        Actor.m_Group := GroupMember;
        GroupMember.isScreen := Actor;
        Actor.m_Abil.MaxHP := GroupMember.ClientGroup.MaxHP;
        Actor.m_Abil.HP := GroupMember.ClientGroup.HP;
      end
      else begin
        Actor.m_Group := nil;
        GroupMember.isScreen := nil;
      end;
      Break;
    end;
  end;
end;

procedure TPlayScene.SetMembersGroup(GroupMembers: TList);
var
  i, ii: Integer;
  Actor: TActor;
  GroupMember: pTGroupMember;
begin
  for i := 0 to m_ActorList.count - 1 do begin
    Actor := m_ActorList.Items[i];
    Actor.m_Group := nil;
    for ii := 0 to GroupMembers.Count - 1 do begin
      GroupMember := GroupMembers.Items[ii];
      if GroupMember.ClientGroup.UserID = Actor.m_nRecogId then begin
        Actor.m_Group := GroupMember;
        GroupMember.isScreen := Actor;
        Actor.m_Abil.MaxHP := GroupMember.ClientGroup.MaxHP;
        Actor.m_Abil.HP := GroupMember.ClientGroup.HP;
        //Actor.
        Break;
      end;
    end;
  end;
end;
{
procedure TPlayScene.SetGroupNameColor(Actor: TActor; Color: Byte);
var
  GroupMember: pTGroupMember;
  i: Integer;
begin
  for i:=0 to g_GroupMembers.count - 1 do begin
    GroupMember := g_GroupMembers[i];
    if GroupMember.ClientGroup.UserID = Actor.m_nRecogId then begin
      if GroupMember.ClientGroup.NameColor <> Color then begin
        FrmDlg2.m_boChangeGroup := True;
        GroupMember.ClientGroup.NameColor := Color;
      end;
      Break;
    end;
  end;

end;      }

procedure TPlayScene.SetActorGroup(Actor: TActor);
var
  ii: Integer;
  GroupMember: pTGroupMember;
begin
  if g_GroupMembers.Count <= 0 then
    exit;
  for ii := 0 to g_GroupMembers.Count - 1 do begin
    GroupMember := g_GroupMembers.Items[ii];
    if GroupMember.ClientGroup.UserID = Actor.m_nRecogId then begin
      GroupMember.isScreen := Actor;
      Actor.m_Group := GroupMember;
      Actor.m_Abil.MaxHP := GroupMember.ClientGroup.MaxHP;
      Actor.m_Abil.HP := GroupMember.ClientGroup.HP;
      Break;
    end;
  end;
end;

procedure TPlayScene.ClearGroup();
var
  i: Integer;
begin
  for i := 0 to m_ActorList.count - 1 do begin
    TActor(m_ActorList[i]).m_Group := nil;
  end;
end;

function TPlayScene.DeleteActor(id: Integer): TActor;
var
  i: Integer;
begin
  Result := nil;
  i := 0;
  while True do begin
    if i >= m_ActorList.count then
      break;
    if TActor(m_ActorList[i]).m_nRecogId = id then begin
      if g_TargetCret = TActor(m_ActorList[i]) then
        g_TargetCret := nil;
      if g_FocusCret = TActor(m_ActorList[i]) then
        g_FocusCret := nil;
      if g_MagicTarget = TActor(m_ActorList[i]) then
        g_MagicTarget := nil;
      if g_MagicLockTarget = TActor(m_ActorList[i]) then
        g_MagicLockTarget := nil;
      if g_NPCTarget = TActor(m_ActorList[i]) then
        g_NPCTarget := nil;
      if TActor(m_ActorList[i]).m_Group <> nil then begin
        TActor(m_ActorList[i]).m_Group.isScreen := nil;
        TActor(m_ActorList[i]).m_Group := nil;
      end;
      ClearMissionList(TActor(m_ActorList[i]));
      TActor(m_ActorList[i]).m_dwDeleteTime := FrmMain.m_CurrentTick;
      g_FreeActorList.Add(m_ActorList[i]);
      //TActor(ActorList[i]).Free;
      m_ActorList.Delete(i);
    end
    else
      Inc(i);
  end;
end;

procedure TPlayScene.SetEditChar(sMsg: string);
begin
  if sMsg <> '' then begin
    FrmDlg.DEditChat.Visible := True;
    FrmDlg.DEditChat.SetFocus;
    FrmDlg.DEditChat.Text := '/' + sMsg + ' ';
    //FrmDlg.DEditChatChange(FrmDlg.DEditChat);
  end;
end;

procedure TPlayScene.DelActor(Actor: TObject);
var
  i: Integer;
begin
  for i := 0 to m_ActorList.count - 1 do
    if m_ActorList[i] = Actor then begin
      if TActor(m_ActorList[i]).m_Group <> nil then begin
        TActor(m_ActorList[i]).m_Group.isScreen := nil;
        TActor(m_ActorList[i]).m_Group := nil;
      end;
      ClearMissionList(TActor(m_ActorList[i]));
      TActor(m_ActorList[i]).m_dwDeleteTime := FrmMain.m_CurrentTick;
      g_FreeActorList.Add(m_ActorList[i]);
      m_ActorList.Delete(i);
      break;
    end;
end;

function TPlayScene.ButchAnimal(X, Y: Integer): TActor;
var
  i: Integer;
  a: TActor;
begin
  Result := nil;
  for i := 0 to m_ActorList.count - 1 do begin
    a := TActor(m_ActorList[i]);
    if a.m_boDeath and (a.m_btRace <> 0) then begin //µ¿¹° ½ÃÃ¼
      if (abs(a.m_nCurrX - X) <= 1) and (abs(a.m_nCurrY - Y) <= 1) then begin
        Result := a;
        break;
      end;
    end;
  end;
end;

{------------------------- Msg -------------------------}


procedure TPlayScene.SendMsg(ident, chrid, X, Y, cdir, Feature, State: Integer; str: string; btSIdx, btWuXin: Integer);
var
  Actor: TActor;
begin
  case ident of
    SM_TEST: begin
        Actor := NewActor(111, 254 {x}, 214 {y}, 0, 0, 0);
        g_MySelf := THumActor(Actor);
        Map.LoadMap('0', g_MySelf.m_nCurrX, g_MySelf.m_nCurrY);
      end;
    SM_CHANGEMAP,
      SM_NEWMAP: begin
        g_boAutoMoveing := False;
        g_nMiniMapMoseX := -1;
        g_nMiniMapMoseY := -1;
        g_nMiniMapPath := nil;

        Map.LoadMap(str, X, Y);
        //DarkLevel := cdir;
        FrmDlg.DMaxMiniMap.Visible := False;
        g_nMiniMapIndex := cdir - 1;
        g_nMiniMapOldX := -1;
        FrmDlg.SetMiniMapSize(g_nViewMinMapLv);

        if (ident = SM_NEWMAP) and (g_MySelf <> nil) then begin
          g_MySelf.m_nCurrX := X;
          g_MySelf.m_nCurrY := Y;
          g_MySelf.m_nRx := X;
          g_MySelf.m_nRy := Y;
          DelActor(g_MySelf);
        end;

        if PrevVMMStyle = 1 then begin
            g_nViewMinMapLv := PrevVMMStyle;
            FrmDlg.SetMiniMapSize(g_nViewMinMapLv);
            PrevVMMStyle := g_nViewMinMapLv;
          end else if PrevVMMStyle = 2 then begin
            g_nViewMinMapLv := PrevVMMStyle;
            FrmDlg.SetMiniMapSize(g_nViewMinMapLv);
            PrevVMMStyle := g_nViewMinMapLv;
          end else if PrevVMMStyle < 1 then begin
            g_nViewMinMapLv := PrevVMMStyle;
            FrmDlg.SetMiniMapSize(g_nViewMinMapLv);
            PrevVMMStyle := g_nViewMinMapLv;
          end;

        //g_LegendMapName := Map.m_sFileName;
        //g_LegendMap.LoadMap();
      end;
    SM_LOGON: begin
        Actor := FindActor(chrid);
        if Actor = nil then begin
          Actor := NewActor(chrid, X, Y, cdir, Feature, State);
          //Actor.m_btWuXin := Hibyte(cdir);
          //cdir := Lobyte(cdir);
          Actor.SendMsg(SM_TURN, X, Y, cdir, Feature, State, '', 0);
        end;
        if g_MySelf <> nil then begin
          g_MySelf := nil;
        end;
        g_MySelf := THumActor(Actor);
      end;
    SM_HIDE: begin
        Actor := FindActor(chrid);
        if Actor <> nil then begin
          if Actor.m_boDelActionAfterFinished then begin //¶¥À¸·Î »ç¶óÁö´Â ¾Ö´Ï¸ÞÀÌ¼ÇÀÌ ³¡³ª¸é ÀÚµ¿À¸·Î »ç¶óÁü.
            Exit;
          end;
          if Actor.m_nWaitForRecogId <> 0 then begin //º¯½ÅÁß.. º¯½ÅÀÌ ³¡³ª¸é ÀÚµ¿À¸·Î »ç¶óÁü
            Exit;
          end;
        end;
        DeleteActor(chrid);
      end;
  else begin
      Actor := FindActor(chrid);
      if (ident = SM_TURN) or (ident = SM_RUN) or (ident = SM_LEAP) or (ident = SM_HORSERUN) or (ident = SM_WALK) or
        {(ident = SM_MAGICMOVE) or (ident = SM_MAGICFIR) or}
        (ident = SM_DEATH) or (ident = SM_SKELETON) or
        (ident = SM_DIGUP) or (ident = SM_ALIVE) then begin
        if Actor = nil then
          Actor := NewActor(chrid, X, Y, LoByte(cdir), Feature, State);
        if Actor <> nil then begin
          //if Hibyte(cdir) in [1..5] then
            //Actor.m_btWuXin := Hibyte(cdir);
          Actor.m_nLightRange := HiByte(cdir);
          if ident = SM_SKELETON then begin
            Actor.m_boDeath := True;
            Actor.m_boSkeleton := True;
          end;
        end;
      end;
      if Actor = nil then Exit;
      if btSIdx <> -1 then Actor.m_btStrengthenIdx := btSIdx;
      if (btWuXin in [1..5]) then Actor.m_btWuXin := btWuXin;
      case ident of
        SM_FEATURECHANGED: begin
            Actor.m_nFeature := Feature;
            DecodeBuffer(str, @Actor.m_Features, sizeof(TFeatures));
            Actor.FeatureChanged;
          end;
        SM_CHARSTATUSCHANGED: begin
            Actor.m_nState := Feature;
            Actor.m_nHitSpeed := State;

            //i think this fixed a bug with para and dash combination but need to test if its there before i apply this fix:
            //actor.SendMsg (ident, x, y, cdir, feature, state, '', 0);
          end;
      else begin
          if ident = SM_TURN then begin
            Actor.SetUsername(str, -1);
            //Actor.m_sUserName := str;
          end;
          Actor.SendMsg(ident, X, Y, cdir, Feature, State, '', 0);
        end;
      end;
    end;
  end;
end;
end.

