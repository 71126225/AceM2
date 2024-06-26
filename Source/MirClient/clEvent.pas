unit clEvent;

interface

uses
  Windows, Classes, HGETextures, Grobal2, CliUtil, MShare, SysUtils;

const
  ZOMBIDIGUPDUSTBASE = 420;
  STONEFRAGMENTBASE = 64;
  HOLYCURTAINBASE = 1390;
  SHOPBASE = 328;
  FIREBURNBASE = 1630;
  SCULPTUREFRAGMENT = 1349;
type
  TClEvent = class
    m_nX: Integer;
    m_nY: Integer;
    m_nDir: Integer;
    m_nPx: Integer;
    m_nPy: Integer;
    m_nPx2: Integer;
    m_nPy2: Integer;
    m_nPx3: Integer;
    m_nPy3: Integer;
    m_nPx4: Integer;
    m_nPy4: Integer;
    m_nPx5: Integer;
    m_nPy5: Integer;
    m_nEventType: Integer;
    m_nEventParam: Integer;
    m_nServerId: Integer;
    m_Dsurface: TDirectDrawSurface;
    m_Dsurface2: TDirectDrawSurface;
    m_Dsurface3: TDirectDrawSurface;
    m_Dsurface4: TDirectDrawSurface;
    m_Dsurface5: TDirectDrawSurface;
    m_boBlend: Boolean;
    m_dwFrameTime: LongWord;
    m_dwFrameTick: LongWord;
    m_dwCurframe: LongWord;
    m_boClient: Boolean;
    m_nLight: Integer;
    random_flicker_tick: Integer;
    random_flicker: Integer;
    colour_of_event: Cardinal;
  private
  public
    constructor Create(svid, ax, ay, evtype: integer);
    destructor Destroy; override;
    procedure DrawEvent(backsurface: TDirectDrawSurface; ax, ay: integer); dynamic;
    procedure Run; dynamic;
    procedure DrawEventLight(surface_for_light: TDirectDrawSurface; x, y: Integer);
  end;

  TShopClEvent = class(TClEvent)
    m_sShopName: string[10];
  public
    constructor Create(svid, ax, ay, evtype: integer; sName: string);
    procedure DrawEvent(backsurface: TDirectDrawSurface; ax, ay: integer); override;
  end;

  TClEventManager = class
  private
  public
    EventList: TList;
    constructor Create;
    destructor Destroy; override;
    procedure ClearEvents;
    function AddEvent(evn: TClEvent): TClEvent;
    procedure DelEvent(evn: TClEvent);
    procedure DelEventById(svid: integer);
    function GetEvent(ax, ay, etype: integer): TClEvent;
    procedure Execute;
  end;

implementation

uses
  ClMain, WMFile, HGE;

constructor TClEvent.Create(svid, ax, ay, evtype: integer);
begin
  m_nServerId := svid;
  m_nX := ax;
  m_nY := ay;
  m_nEventType := evtype;
  m_nEventParam := 0;
  m_boBlend := FALSE;
  m_dwFrameTime := FrmMain.m_CurrentTick;
  m_dwCurframe := 0;
  m_nLight := 0;
  m_boClient := False;
  m_dwFrameTick := 20;
  size_of_light_flicker := 0;
  random_flicker_tick := 0;
  random_flicker := 0;
  colour_of_event := ARGB(100,255,255,255);
end;

destructor TClEvent.Destroy;
begin
  if m_nEventType = ET_MACHINERY then
    Map.MarkCanWalk(m_nX, m_nY, True);
  inherited Destroy;
end;

procedure TClEvent.DrawEvent(backsurface: TDirectDrawSurface; ax, ay: integer);
begin
  if m_Dsurface <> nil then begin
    if m_boBlend then
      DrawBlend(backsurface, ax + m_nPx, ay + m_nPy, m_Dsurface, 1)
    else
      backsurface.Draw(ax + m_nPx, ay + m_nPy, m_Dsurface.ClientRect, m_Dsurface, TRUE);
  end;
  if m_Dsurface2 <> nil then begin
    if m_boBlend then
      DrawBlend(backsurface, ax + m_nPx2, ay + m_nPy2, m_Dsurface2, 1)
    else
      backsurface.Draw(ax + m_nPx2, ay + m_nPy2, m_Dsurface2.ClientRect, m_Dsurface2, TRUE);
  end;
  if m_Dsurface3 <> nil then begin
    if m_boBlend then
      DrawBlend(backsurface, ax + m_nPx3, ay + m_nPy3, m_Dsurface3, 1)
    else
      backsurface.Draw(ax + m_nPx3, ay + m_nPy3, m_Dsurface3.ClientRect, m_Dsurface3, TRUE);
  end;
  if m_Dsurface4 <> nil then begin
    if m_boBlend then
      DrawBlend(backsurface, ax + m_nPx4, ay + m_nPy4, m_Dsurface4, 1)
    else
      backsurface.Draw(ax + m_nPx4, ay + m_nPy4, m_Dsurface4.ClientRect, m_Dsurface4, TRUE);
  end;
  if m_Dsurface5 <> nil then begin
    if m_boBlend then
      DrawBlend(backsurface, ax + m_nPx5, ay + m_nPy5, m_Dsurface5, 1)
    else
      backsurface.Draw(ax + m_nPx5, ay + m_nPy5, m_Dsurface5.ClientRect, m_Dsurface5, TRUE);
  end;
end;

procedure TClEvent.DrawEventLight(surface_for_light: TDirectDrawSurface; x, y: Integer);
var
  image_to_draw: TDirectDrawSurface;
  temp_rectangle: TRect;
  top_left_position, bottom_right_position: TPoint;
  left_position, top_position, right_position, bottom_position, nPx, nPy,
  incremental_increase_of_light, i, actual_size_of_light, nSizeOfLight: Integer;
begin
  left_position := 15;
  top_position := 35;
  right_position := 110;
  bottom_position := 65;
  incremental_increase_of_light := 0;
  actual_size_of_light := 0;

  nSizeOfLight := 1;//add a default value to prevent infinite loops, doh
  case m_nLight of
    1: nSizeOfLight := 3;
    3: nSizeOfLight := 6;
  end;
  if nSizeOfLight > 6 then begin
    nSizeOfLight := 1;
    outputdebugstring('error to many lights');
  end;

  image_to_draw := CheckLightImageSize(g_WEnvironmentImages.GetCachedImage(0, nPx, nPy));

  if ((FrmMain.m_CurrentTick - random_flicker_tick) > 250) then begin
    random_flicker_tick := FrmMain.m_CurrentTick;
    random_flicker := Random(15);
  end;

  if size_of_light_flicker < random_flicker then
          Inc(size_of_light_flicker, 2)
  else if size_of_light_flicker > random_flicker then
          Dec(size_of_light_flicker, 2);
  for i := 0 to nSizeOfLight do begin
    if i < nSizeOfLight - 1 then
      actual_size_of_light := size_of_light_flicker
    else
      actual_size_of_light := 0;

      top_left_position.X := (x + nPx - UNITX div 2) - left_position - incremental_increase_of_light - actual_size_of_light;
      top_left_position.Y := (y + nPy - UNITY div 2) - top_position - incremental_increase_of_light - actual_size_of_light;
      bottom_right_position.X := top_left_position.X + right_position + (incremental_increase_of_light * 2) + (actual_size_of_light * 2);
      bottom_right_position.Y := top_left_position.Y + bottom_position + (incremental_increase_of_light * 2) + (actual_size_of_light * 2);
      temp_rectangle.TopLeft := top_left_position;
      temp_rectangle.BottomRight := bottom_right_position;
      if (image_to_draw <> nil) then
        surface_for_light.StretchDraw(temp_rectangle, image_to_draw.ClientRect, image_to_draw, colour_of_event, Blend_SrcAlphaAdd);
      Inc(incremental_increase_of_light, 20);
    end;
end;

procedure TClEvent.Run;
begin
  m_Dsurface := nil;
  m_Dsurface2 := nil;
  m_Dsurface3 := nil;
  m_Dsurface4 := nil;
  m_Dsurface5 := nil;
  if FrmMain.m_CurrentTick - m_dwFrameTime > m_dwFrameTick then begin
    m_dwFrameTime := FrmMain.m_CurrentTick;
    Inc(m_dwCurframe);
  end;
  //Inc(m_dwCurframe);
  case m_nEventType of

    ET_DIGOUTZOMBI: m_Dsurface := g_WMons[6].GetCachedImage(ZOMBIDIGUPDUSTBASE + m_nDir, m_nPx, m_nPy);
    ET_PILESTONES: begin
        if m_nEventParam <= 0 then
          m_nEventParam := 1;
        if m_nEventParam > 5 then
          m_nEventParam := 5;

        m_Dsurface := g_WEffectImages.GetCachedImage(STONEFRAGMENTBASE + (m_nEventParam - 1), m_nPx, m_nPy);
      end;
    ET_HOLYCURTAIN: begin
        m_Dsurface := g_WMagicImages.GetCachedImage(HOLYCURTAINBASE + (m_dwCurframe mod 10), m_nPx, m_nPy);

        m_boBlend := TRUE;
        m_nLight := 1;
      end;
    ET_MACHINERY: begin
        m_Dsurface := g_WMagicImages.GetCachedImage(HOLYCURTAINBASE + (m_dwCurframe mod 10), m_nPx, m_nPy);
        m_Dsurface2 := g_WMagicImages.GetCachedImage(HOLYCURTAINBASE + ((m_dwCurframe + 2) mod 10), m_nPx2, m_nPy2);
        m_Dsurface3 := g_WMagicImages.GetCachedImage(HOLYCURTAINBASE + ((m_dwCurframe + 4) mod 10), m_nPx3, m_nPy3);
        m_boBlend := TRUE;
        m_nLight := 1;
        Map.MarkCanWalk(m_nX, m_nY, False);
      end;
    ET_FIRE: begin
       // m_Dsurface := g_WMagic99Images.GetCachedImage(FIREBURNBASE + ((m_dwCurframe div 3) mod 3), m_nPx, m_nPy);
        m_Dsurface := g_WMagicImages.GetCachedImage(FIREBURNBASE + ((m_dwCurframe div 2) mod 6), m_nPx, m_nPy);
        m_boBlend := True;
        m_nLight := 1;
      end;
    ET_SCULPEICE: begin
        m_Dsurface := g_WMons[7].GetCachedImage(SCULPTUREFRAGMENT, m_nPx, m_nPy);
      end;
    ET_SHOP: begin
        m_Dsurface := g_WEffectImages.GetCachedImage(SHOPBASE + (m_dwCurframe mod 10), m_nPx, m_nPy);
        m_boBlend := TRUE;
        m_nLight := 1;
      end;
    ET_INCHP: begin
        m_Dsurface := g_WMagic99Images.GetCachedImage(880 + ((m_dwCurframe div 3) mod 16), m_nPx, m_nPy);

        m_boBlend := True;
        m_nLight := 1;
      end;
    ET_RANDOMGATE: begin
        m_Dsurface := g_WEffectImages.GetCachedImage(846 + ((m_dwCurframe div 3) mod 10), m_nPx, m_nPy);

        m_boBlend := True;
        m_nLight := 3;
      end;
    ET_POISONCLOUD: begin
      m_Dsurface := g_WMagic99Images.GetCachedImage(900 + ((m_dwCurframe div 2) mod 20), m_nPx, m_nPy);
        m_boBlend := True;
        m_nLight := 3;
        colour_of_event := ARGB(245,94,237,136);
      end;
    ET_TRAP: begin
        m_Dsurface := g_WMagicKiller.GetCachedImage(420 + ((m_dwCurframe div 3) mod 8), m_nPx, m_nPy);
        m_boBlend := TRUE;
        m_nLight := 3;
        colour_of_event := ARGB(245,94,237,136);
      end;
  end;
end;

{-----------------------------------------------------------------------------}

{-----------------------------------------------------------------------------}

constructor TClEventManager.Create;
begin
  EventList := TList.Create;
end;

destructor TClEventManager.Destroy;
var
  i: integer;
begin
  for i := 0 to EventList.Count - 1 do
    TClEvent(EventList[i]).Free;
  EventList.Free;
  inherited Destroy;
end;

procedure TClEventManager.ClearEvents;
var
  i: integer;
begin
  for i := 0 to EventList.Count - 1 do
    TClEvent(EventList[i]).Free;
  EventList.Clear;
end;

function TClEventManager.AddEvent(evn: TClEvent): TClEvent;
var
  i: integer;
  //  event: TClEvent;
begin
  for i := 0 to EventList.Count - 1 do
    if (EventList[i] = evn) or (TClEvent(EventList[i]).m_nServerId = evn.m_nServerId) then begin
      evn.Free;
      Result := nil;
      exit;
    end;
  EventList.Add(evn);
  Result := evn;
end;

procedure TClEventManager.DelEvent(evn: TClEvent);
var
  i: integer;
begin
  for i := 0 to EventList.Count - 1 do
    if (EventList[i] = evn) and (not evn.m_boClient) then begin
      TClEvent(EventList[i]).Free;
      EventList.Delete(i);
      break;
    end;
end;

procedure TClEventManager.DelEventById(svid: integer);
var
  i: integer;
begin
  for i := 0 to EventList.Count - 1 do
    if (TClEvent(EventList[i]).m_nServerId = svid) and (not TClEvent(EventList[i]).m_boClient) then begin
      TClEvent(EventList[i]).Free;
      EventList.Delete(i);
      break;
    end;
end;

function TClEventManager.GetEvent(ax, ay, etype: integer): TClEvent;
var
  i: integer;
begin
  Result := nil;
  for i := 0 to EventList.Count - 1 do
    if (TClEvent(EventList[i]).m_nX = ax) and (TClEvent(EventList[i]).m_nY = ay) and
      (TClEvent(EventList[i]).m_nEventType = etype) then begin
      Result := TClEvent(EventList[i]);
      break;
    end;
end;

procedure TClEventManager.Execute;
var
  i: integer;
begin
  for i := 0 to EventList.Count - 1 do
    TClEvent(EventList[i]).Run;
end;

{ TShopClEvent }

constructor TShopClEvent.Create(svid, ax, ay, evtype: integer; sName: string);
begin
  inherited Create(svid, ax, ay, evtype);
  m_sShopName := sName;
end;

procedure TShopClEvent.DrawEvent(backsurface: TDirectDrawSurface; ax, ay: integer);
begin
  inherited;
  with g_DXCanvas do begin
    //SetBkMode(Handle, TRANSPARENT);
    TextOut(ax, ay, $B1D2B7, m_sShopName);
    //Release;
  end;
end;

end.
