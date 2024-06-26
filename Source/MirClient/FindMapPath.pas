unit FindMapPath;

interface

uses
  Windows, Classes, SysUtils, Messages;

type

  TTerrainTypes = (ttNormal, ttSand, ttForest, ttRoad, ttObstacle, ttPath);

  TPath = array of TPoint;

  TPathMapCell = record
    Distance: Integer;
    Direction: Integer;
  end;
  TPathMapArray = array of array of TPathMapCell;

  {TMapHeader = packed record // 传奇地图数据头结构 52
    Width: word; //2
    Height: word; //2
    Title: array[1..16] of char; //标题      16
    UpdateDate: TDateTime; //8
    Reserved: array[0..23] of char; //保留
  end;    }
 {
  TMapPrjInfo = record
    ident: string[16];
    ColCount: Integer;
    RowCount: Integer;
  end;
  }
  TMapMendHeader = packed record
    nWidth, nHeight: Word;
    nCount: Byte;
  end;

  TMapMendInfo = packed record
    nX, nY, nWidth, nHeight: Word;
  end;
  TCellParams = record
    TerrainType: Boolean;
    OnPath: Boolean;
  end;
  TMapData = array of array of TCellParams;


//******************************************************************************
//***************************code for map reading*******************************
//******************************************************************************
//map version 0 (original mir2 wemade)
  TOldMapInfo = packed record
    BkImg: word;
    MidImg: word;
    FrImg: word;
    DoorIndex: byte;
    DoorOffset: byte;
    AniFrame: byte;
    AniTick: byte;
    Area: byte;
    light: byte;
  end;
  pTOldMapInfo = ^TOldMapInfo;

  //map version 1
  TMapInfo = packed record
    case Integer of
      1:(
        BkImg: word;
        MidImg: word;
        FrImg: word;
        DoorIndex: byte;
        DoorOffset: byte;
        AniFrame: byte;
        AniTick: byte;
        Area: byte;
        light: byte;
        BkIndex: Byte;
        MidIndex: Byte;
      );
      2:(
        nInteger1: Integer;
        nInteger2: Integer;
        nInteger3: Integer;
        nWord4: Word;
      );
  end;
  PTMapInfo = ^TMapInfo;

  //map version 2 (shanda's 2010 format) using xors!
  TENMapInfo = packed record
    BkImg: Word;
    BkImgNot: word;
    MidImg: word;
    FrImg: word;
    DoorIndex: byte;
    DoorOffset: byte;
    AniFrame: byte;
    AniTick: byte;
    Area: byte;
    light: byte;
    btNot: byte;
  end;
  PTENMapInfo = ^TENMapInfo;

  //map version 3 (shanda's 2012 format) no more xors but loads of extra data
   TSdoMapInfo2012 = packed record
    BkImg: Word;
    MidImg: word;
    FrImg: word;
    DoorIndex: byte;  //not sure on this yet
    DoorOffset: byte; //not sure on this yet
    AniFrame: byte; //appears $80 is xored to check if it's enabled? (80 = enabled, 00 = disabled)
    AniTick: byte;  //this might be in seconds rather then ms not sure
    Area: byte;
    light: byte;     //this appears to be 5 in n0 while it used to be 4 max (maybe cause of blue candles there now)
    BkIndex: byte;
    MidIndex: Byte;
    AniTileImg: Word;
    Reserved: array[0..4] of byte;
    //reserved 0-1: havent found any map that had info in either field, could be anitileimg is actualy a longword but dont see a reason for this at the moment
    // 2-3 seems to be a 'word' linked to object files ?
    // 4  possibly the 'area' (object filenumber) for the object images linked in reserved 2/3
    AniTileFrame: byte;            //amount of frames an animation tile has
    AniTileTiles: word;            //total amount of tiles used in a single animation (basicaly an offset value so frame 1 = tile 1, frame 2 = tile 2 + this value etc
    //AniTileTick: byte;             //amount of ms (or seconds but :p) an animation frame runs for
    Reserved2: array[0..11] of byte;
    //reserved2:
    //0 : seems to be 0 on maps, possible anitiletick is a word rather then a byte
    //1 :
    //2: seems to be linked to 3 and might be some alpha index value or something dunno
    //3: seems to be FF if there's a glow comming out of a building blacksmith next to bw sz and a few other maps (you can see the black/grey swirly thing)
    //4: seems to be even more light related
    //5: probably FF if 4 is used
  end;
  pTSdoMapInfo2012 = ^TSdoMapInfo2012;

  //map version 5(ei)
  //first part of mapfile is all the info on tiles (tiles span across 2*2 squares so half the info
  TEiTileInfo = Packed Record
    bFileIdx: byte;
    wTileIdx: Word;
  End;
  pTEiTileInfo = ^TEiTileInfo;
  
  //second part is the info each xy coord
  TEIMapInfo = Packed Record
    bflag: byte; //not sure if this is accurate but value '3' seemed to cause the linked objects to blend so i think it's light :p
    AniFrame: byte;    //aka bObj1Ani
    AniFramefr: byte;  //aka bObj2Ani
    frindex: byte;     //aka bFileIdx1
    midindex: byte;    //aka bFileIdx2                
    midimg: Word;      //aka wObj1
    frimg: Word;       //aka wObj2
    DoorIndex: byte;
    DoorOffset: byte;
    wLigntNEvent: word;
    wLigntNEvent1: byte;
  End;
  pTEIMapInfo = ^TEIMapInfo;

  //map version 6 (shanda mir3)
  TShandaEIMapInfo = Packed Record
    bflag: byte;
    bkindex: byte;
    midindex: byte;
    frindex: byte;
    bkimg: word;
    midimg: word;
    frimg: word;
    Reserved: array[0..9] of byte;
  end;
  pTShandaEIMapInfo = ^TShandaEIMapInfo;


  //map version 0+1+3 header
  TMapHeader = packed record
    Width: word;
    Height: word;
    Title: string[15];
    UpdateDate: TDateTime;
    Reserved: array[0..23] of char;
  end;

  //map version 2 header
  TENMapHeader = packed record
    Title: string[16];
    Reserved: LongWord;
    Width: Word;
    Not1: Word;
    Height: Word;
    Not2: Word;
    Reserved2: array[0..24] of char;
  end;

  //map version 4 header
   TAntihackMapHeader = packed record
    sTitle:     string[30];
    wWidth:     word;
    wXOR:       word;
    wHeight:    word;
    UpdateDate: TDateTime;
    Reserved:   array[0..18] of char;
  end;

  //map version 5 header
   TEIMapHeader = Packed Record
    sTitle: Array[1..20] Of char;
    wAttr: Word;
    width: Word;
    height: Word;
    cEventFileIdx: Char;
    cFogColor: Char;
  End;

  //map version 6 header
  TShandaEIMapHeader = packed record
    Title: string[15];
    Width: Word;
    Height: Word;
    Reserved: array[0..19] of char;
  end;

//******************************************************************************
//***************************end of map reading*********************************
//******************************************************************************

  TGetCostFunc = function(X, Y, Direction: Integer; PathWidth: Integer = 0): Integer;

  {TMapLoading = class(TThread) //寻路类
  protected
    procedure Execute; override;
  end;   }

  TPathMap = class //寻路类
  public
    PathMapArray: TPathMapArray;
    MapHeight: Integer;
    MapWidth: Integer;
    GetCostFunc: TGetCostFunc;
    PathWidth: Integer;

    constructor Create;
    function FindPath(MapWidthin, MapHeightin: Integer; StartX, StartY, StopX, StopY: Integer; pGetCostFunc: TGetCostFunc): TPath;
    function FindPathOnMap(X, Y: Integer): TPath;
    procedure MakePathMap(MapWidthin, MapHeightin: Integer; StartX, StartY: Integer; pGetCostFunc: TGetCostFunc);

  private
    function DirToDX(Direction: Integer): Integer;
    function DirToDY(Direction: Integer): Integer;

  protected
    function GetCost(X, Y, Direction: Integer): Integer; virtual;
    function FillPathMap(X1, Y1, X2, Y2: Integer): TPathMapArray;
  end;

  TLegendMap = class(TPathMap)
  private
    FPath: TPath;
  public
    MapHeader: TMapHeader;
    MapData: array[0..1000 * 1000 - 1] of TSdoMapInfo2012;
    MapTerrain: array[0..1000, 0..1000] of Boolean;
    //MapData: TMapData;

    Title: string;
    boNewMap: Boolean;
    //MapLoad: TMapLoading;
    constructor Create;
    destructor Destroy; override;
    property Path: TPath read FPath write FPath;

    //function LoadMap(): Boolean;
    procedure LoadFileData(sFileName: string);
    function TerrainType(nX, nY: Integer): Boolean;
    procedure SetTerrainType(nX, nY: Integer; boFlag: Boolean);
    function FindPath(StartX, StartY, StopX, StopY, PathSpace: Integer): TPath; overload;
    function FindPath(StopX, StopY: Integer): TPath; overload;
    procedure SetStartPos(StartX, StartY, PathSpace: Integer);

  protected
    function GetCost(X, Y, Direction: Integer): Integer; override;
  end;

  TWaveCell = record //路线点
    X, Y: Integer; //
    Cost: Integer; //
    Direction: Integer;
  end;

  TWave = class //路线类
  private
    FData: array of TWaveCell;
    FPos: Integer; //
    FCount: Integer; //
    FMinCost: Integer;
    function GetItem: TWaveCell;
  public
    property Item: TWaveCell read GetItem; //
    property MinCost: Integer read FMinCost; // Cost

    constructor Create;
    destructor Destroy; override;
    procedure Add(NewX, NewY, NewCost, NewDirection: Integer); //
    procedure Clear; //FCount
    function Start: Boolean; //
    function Next: Boolean; //
  end;

const
  TerrainParams: array[Boolean] of Integer = (-1, 4);
  {TerrainParams: array[TTerrainTypes] of TTerrainParam = (
    (CellColor: clWhite; CellLabel: '平地'; MoveCost: 4),
    (CellColor: clOlive; CellLabel: '沙地'; MoveCost: 6),
    (CellColor: clGreen; CellLabel: '树林'; MoveCost: 10),
    (CellColor: clSilver; CellLabel: '马路'; MoveCost: 2),
    (CellColor: clBlack; CellLabel: '障碍物'; MoveCost: - 1),
    (CellColor: clRed; CellLabel: '路径'; MoveCost: 0)); }

implementation

uses clmain, graphics, Mshare;

constructor TWave.Create;
begin
  Clear; //
end;

destructor TWave.Destroy;
begin
  FData := nil; //
  inherited Destroy;
end;

function TWave.GetItem: TWaveCell;
begin
  Result := FData[FPos]; //
end;

procedure TWave.Add(NewX, NewY, NewCost, NewDirection: Integer);
begin
  if FCount >= Length(FData) then //
    SetLength(FData, Length(FData) + 30); //
  with FData[FCount] do begin
    X := NewX;
    Y := NewY;
    Cost := NewCost;
    Direction := NewDirection;
  end;
  if NewCost < FMinCost then //NewCost
    FMinCost := NewCost;
  Inc(FCount); //
end;

procedure TWave.Clear;
begin
  FPos := 0;
  FCount := 0;
  FMinCost := High(Integer);
end;

function TWave.Start: Boolean;
begin
  FPos := 0; //
  Result := (FCount > 0); //
end;

function TWave.Next: Boolean;
begin
  Inc(FPos); //
  Result := (FPos < FCount); // false,
end;

constructor TPathMap.Create;
begin
  inherited Create();
end;

function TPathMap.FindPath(MapWidthin, MapHeightin: Integer; StartX, StartY,
  StopX, StopY: Integer;
  pGetCostFunc: TGetCostFunc): TPath;
begin
  MapWidth := MapWidthin; //
  MapHeight := MapHeightin; //
  GetCostFunc := pGetCostFunc;
  PathMapArray := FillPathMap(StartX, StartY, StopX, StopY);
  Result := FindPathOnMap(StopX, StopY);
end;

//*************************************************************
//    从TPathMap中找出 TPath
//*************************************************************

function TPathMap.FindPathOnMap(X, Y: Integer): TPath;
var
  Direction: Integer;
begin
  Result := nil;
  if (X >= MapWidth) or (Y >= MapHeight) then Exit;
  if PathMapArray[Y, X].Distance < 0 then Exit;
  SetLength(Result, PathMapArray[Y, X].Distance + 1); //
  while PathMapArray[Y, X].Distance > 0 do begin
    Result[PathMapArray[Y, X].Distance] := Point(X, Y);
    Direction := PathMapArray[Y, X].Direction;
    X := X - DirToDX(Direction);
    Y := Y - DirToDY(Direction);
  end;
  Result[0] := Point(X, Y);
end;

procedure TPathMap.MakePathMap(MapWidthin, MapHeightin: Integer; StartX, StartY:
  Integer;
  pGetCostFunc: TGetCostFunc);
begin
  MapWidth := MapWidthin;
  MapHeight := MapHeightin; //
  GetCostFunc := pGetCostFunc;
  PathMapArray := FillPathMap(StartX, StartY, -1, -1);
end;

//*************************************************************
//    方向编号转为X方向符号
//     7  0  1
//     6  X  2
//     5  4  3
//*************************************************************

function TPathMap.DirToDX(Direction: Integer): Integer;
begin
  case Direction of
    0, 4: Result := 0;
    1..3: Result := 1;
  else
    Result := -1;
  end;
end;

function TPathMap.DirToDY(Direction: Integer): Integer;
begin
  case Direction of
    2, 6: Result := 0;
    3..5: Result := 1;
  else
    Result := -1;
  end;
end;

//*************************************************************
//    寻路算法
//    X1,Y1为路径运算起点，X2，Y2为路径运算终点
//*************************************************************

function TPathMap.FillPathMap(X1, Y1, X2, Y2: Integer): TPathMapArray;
var
  OldWave, NewWave: TWave;
  Finished: Boolean;
  I: TWaveCell;

  procedure PreparePathMap; //初始化PathMapArray
  var
    X, Y: Integer; //
  begin
    SetLength(Result, MapHeight, MapWidth);
    for Y := 0 to (MapHeight - 1) do
      for X := 0 to (MapWidth - 1) do
        Result[Y, X].Distance := -1;
  end;

  //计算相邻8个节点的权cost，并合法点加入NewWave(),并更新最小cost
  //合法点是指非障碍物且Result[X，Y]中未访问的点
  procedure TestNeighbours;
  var
    X, Y, C, D: Integer;
  begin
    for D := 0 to 7 do begin
      X := OldWave.Item.X + DirToDX(D);
      Y := OldWave.Item.Y + DirToDY(D);
      C := GetCost(X, Y, D);
      if (C >= 0) and (Result[Y, X].Distance < 0) then
        NewWave.Add(X, Y, C, D); //
    end;
  end;

  procedure ExchangeWaves; //
  var
    W: TWave;
  begin
    W := OldWave;
    OldWave := NewWave;
    NewWave := W;
    NewWave.Clear;
  end;

begin
  PreparePathMap; // 初始化PathMapArray ,Distance:=-1
  OldWave := TWave.Create;
  NewWave := TWave.Create;
  Result[Y1, X1].Distance := 0; // 起点Distance:=0
  OldWave.Add(X1, Y1, 0, 0); //将起点加入OldWave
  TestNeighbours; //

  Finished := ((X1 = X2) and (Y1 = Y2)); //检验是否到达终点
  while not Finished do begin
    ExchangeWaves; //
    if not OldWave.Start then
      Break;
    repeat
      I := OldWave.Item;
      I.Cost := I.Cost - OldWave.MinCost; // 如果大于MinCost
      if I.Cost > 0 then // 加入NewWave
        NewWave.Add(I.X, I.Y, I.Cost, I.Direction) //更新Cost= cost-MinCost
      else begin //  处理最小COST的点
        if Result[I.Y, I.X].Distance >= 0 then
          Continue;

        Result[I.Y, I.X].Distance := Result[I.Y - DirToDY(I.Direction), I.X -
          DirToDX(I.Direction)].Distance + 1;
        // 此点 Distance:=上一个点Distance+1

        Result[I.Y, I.X].Direction := I.Direction;
        //
        Finished := ((I.X = X2) and (I.Y = Y2)); //检验是否到达终点
        if Finished then
          Break;
        TestNeighbours;
      end;
    until not OldWave.Next; //
  end; // OldWave;
  NewWave.Free;
  OldWave.Free;
end;

function TPathMap.GetCost(X, Y, Direction: Integer): Integer;
begin
  Direction := (Direction and 7);
  if (X < 0) or (X >= MapWidth) or (Y < 0) or (Y >= MapHeight) then
    Result := -1
  else
    Result := GetCostFunc(X, Y, Direction, PathWidth);
end;
 {
function TLegendMap.LoadMap(): Boolean;
begin
  Result := True;
  if g_LegendMapRun then exit;
  if g_LegendMapName <> Title then begin
    Title := g_LegendMapName;
    g_LegendMapRun := True;
    MapLoad := TMapLoading.Create(True);
    MapLoad.FreeOnTerminate := True;
    MapLoad.Resume;
  end;
  g_LegendMapName := '';
end;

procedure TMapLoading.Execute;
var
  aMapFile: TFileStream;
  i, j: Integer;
  MapBuf: TMapBlock;
begin
  with g_LegendMap do begin
    aMapFile := TFileStream.Create(Title, fmOpenRead  or fmShareDenyNone);
    try
      aMapFile.Read(MapHeader, sizeof(TMapHeader)); //
      MapWidth := MapHeader.Width;
      MapHeight := MapHeader.Height;
      SetLength(MapData, MapWidth, MapHeight);
      for i := 0 to MapHeader.width - 1 do
        for j := 0 to MapHeader.height - 1 do begin
          aMapFile.Read(MapBuf, sizeof(MapBuf));
          if ((MapBuf.wBkImg and $8000) + (MapBuf.wFrImg and $8000)) = 0 then
            MapData[i, j].TerrainType := True //标识为平地
          else
            MapData[i, j].TerrainType := False; //标识为障碍物
        end;
    except
      aMapFile.Free;
    end;
    aMapFile.Free;
  end;
  PostMessage(g_FrmMainWinHandle, WM_USER + 1004, 0, 0);
  inherited;
end;       }

constructor TLegendMap.Create;
begin
  inherited Create();
  Title := '';
  FillChar(MapTerrain[0, 0], SizeOf(MapTerrain), True);
  //Priority := tpLower;
end;

destructor TLegendMap.Destroy;
begin
  FPath := nil;
  //MapData := nil;
  inherited;
end;


function TLegendMap.FindPath(StopX, StopY: Integer): TPath;
begin
  //if g_LegendMapRun then exit;
  Result := FindPathOnMap(StopX, StopY);
end;

function TLegendMap.TerrainType(nX, nY: Integer): Boolean;
begin
  Result := False;
  if (nX > 0) and (nY > 0) and (nX <= 1000) and (nY <= 1000) then begin
    if MapTerrain[nX, nY] then begin
      Result := (MapData[nX * MapHeight + nY].BkImg and $8000) + (MapData[nX * MapHeight + nY].FrImg and $8000) = 0;
    end;
  end;
end;

procedure TLegendMap.SetTerrainType(nX, nY: Integer; boFlag: Boolean);
begin
  if (nX > 0) and (nY > 0) and (nX <= 1000) and (nY <= 1000) then begin
    MapTerrain[nX, nY] := boFlag;
  end;
end;

function TLegendMap.FindPath(StartX, StartY, StopX, StopY, PathSpace: Integer): TPath;
begin
  //if g_LegendMapRun then exit;
  PathWidth := PathSpace;
  PathMapArray := FillPathMap(StartX, StartY, StopX, StopY);
  Result := FindPathOnMap(StopX, StopY);
end;

procedure TLegendMap.SetStartPos(StartX, StartY, PathSpace: Integer);
begin
  PathWidth := PathSpace;
  PathMapArray := FillPathMap(StartX, StartY, -1, -1);
end;

function TLegendMap.GetCost(X, Y, Direction: Integer): Integer;
var
  cost: Integer;
  //  sel : Integer;
begin
  Direction := (Direction and 7);
  if (X < 0) or (X >= MapWidth) or (Y < 0) or (Y >= MapHeight) then
    Result := -1
  else begin
    Result := TerrainParams[TerrainType(x, y)];
    if (X < MapWidth - PathWidth) and (X > PathWidth) and
      (Y < MapHeight - PathWidth) and (Y > PathWidth) then begin
      cost := TerrainParams[TerrainType(X - PathWidth, Y)]
        + TerrainParams[TerrainType(X + PathWidth, Y)]
        + TerrainParams[TerrainType(X, Y - PathWidth)]
        + TerrainParams[TerrainType(X, Y + PathWidth)];
      if cost < 4 * TerrainParams[True] then
        Result := -1;
    end;

    if ((Direction and 1) = 1) and (Result > 0) then // 如果是斜方向,则COST增加
      Result := Result + (Result shr 1); //应为Result*sqt(2),此处近似为1.5
  end;

end;

procedure TLegendMap.LoadFileData(sFileName: string);
var
  aMapFile: TFileStream;
  MendHeader: TMapMendHeader;
  MendInfo: TMapMendInfo;
  I, J, Y: Integer;

  //headers
  header: TMapHeader;
  ENMapHeader: TENMapHeader;
  AntiHackHeader: TAntihackMapHeader;
  EIMapHeader: TEIMapHeader;
  ShandaEIHeader: TShandaEIMapHeader;
  //body data
  MapArr: array of array of TMapInfo;
  ENMapData: array of array of TENMapInfo;
  OldMapData: array of array of TOldMapInfo;
  supernewmapdata: array of array of tsdomapinfo2012;
  EIMapData: array of array of TEIMapInfo;
  EITileData: array of array of TEITileInfo;
  ShandaEIMapData: array of array of TShandaEIMapInfo;
  bMapType: byte;//0: original, 1: shanda 2010, 2: newer wemade, 3: shanda 2012, 4: wemade antihack
const
  XORWORD = $AA38;
begin
  if FileExists(sFileName) then begin
    aMapFile := TFileStream.Create(sFileName, fmOpenRead or fmShareDenyNone);
    try
      bMapType := 0;
      //read the header and determine the type
      aMapFile.Read(ENMapHeader, Sizeof(TENMapHeader));
      if (ENMapHeader.Title = '')  then begin//mir3 wemade maps dont have a title
        bMapType := 5;
        Move(ENMapHeader, EIMapHeader, SizeOf(enmapheader));
        MapHeader.Width := EIMapHeader.width;
        MapHeader.Height := EIMapHeader.height;
      end else
      if (ENMapHeader.Title = '(C) SNDA, MIR3.') then begin //shanda's mir3 map files have this title
        bMapType := 6;
        Move(ENMapHeader, ShandaEIHeader, SizeOf(enmapheader));
        MapHeader.Width := ShandaEIHeader.width;
        MapHeader.Height := ShandaEIHeader.height;
      end else
      if Pos('Mir2 AntiHack',ENMapHeader.Title) = 1 then begin //wemades encrypted map format for labyrinths
        bMapType := 4;
        //needs yet another map header etc to read this
        Move(ENMapHeader, AntiHackHeader, SizeOf(enmapheader)); //only copying what's inside, i know technicaly the antihack header is 10 bytes bigger
        MapHeader.Width := AntiHackHeader.wWidth xor AntiHackHeader.wXOR;
        MapHeader.Height := AntiHackHeader.wHeight xor AntiHackHeader.wXOR;
      end else
      if ENMapHeader.Title = 'Map 2010 Ver 1.0' then begin
        bMapType := 1;
        MapHeader.Width := ENMapHeader.Width xor XORWORD;
        MapHeader.Height := ENMapHeader.Height xor XORWORD;
      end else begin
        Move(ENMapHeader, header, SizeOf(header));
        MapHeader.Width := header.Width;
        MapHeader.Height := header.Height;
        if (header.Title[14] = #$D) and (header.Title[15] = #$A) then begin
          if (aMapFile.Size > (sizeof(header) + (header.Width * header.Height* sizeof(TMapInfo)))) then begin
          bMapType := 3;
        end else
          bMapType := 2;
        end;

      end;


      MapWidth := Mapheader.Width;
      MapHeight := Mapheader.Height;
      if (MapWidth > 1000) or (MapWidth < 0) or (MapHeight > 1000) or (MapHeight < 0) then exit;
      SetLength(supernewmapdata, MapWidth, MapHeight);
      //read the rest of the mapfile
      case bMapType of
        0: begin //original
          aMapFile.Seek(SizeOf(header), 0);
          SetLength(OldMapData, MapWidth, MapHeight);
          for i := 0 to MapWidth - 1 do begin
            aMapFile.Read(OldMapData[i, 0], sizeof(TOldMapInfo) * MapHeight);
            for j := 0 to MapHeight - 1 do
              Move(OldMapData[i, j], supernewmapdata[i, j], SizeOf(TOldMapInfo));
          end;
        end;
        1: begin //shanda 2010
          SetLength(ENMapData, MapWidth, MapHeight);
          for i := 0 to MapWidth - 1 do begin
            aMapFile.Read(ENMapData[i, 0], SizeOf(TENMapInfo) * MapHeight);
            for j := 0 to MapHeight - 1 do begin
              supernewmapdata[i, j].BkImg := ENMapData[i, j].BkImg xor XORWORD;
              if (ENMapData[i, j].BkImgNot xor $AA38) = $2000 then
                supernewmapdata[i, j].BkImg := supernewmapdata[i, j].BkImg or $8000;
              supernewmapdata[i, j].MidImg := ENMapData[i, j].MidImg xor XORWORD;
              supernewmapdata[i, j].FrImg := ENMapData[i, j].FrImg xor XORWORD;
              supernewmapdata[i, j].DoorIndex := ENMapData[i, j].DoorIndex;
              supernewmapdata[i, j].DoorOffset := ENMapData[i, j].DoorOffset;
              supernewmapdata[i, j].AniFrame := ENMapData[i, j].AniFrame;
              supernewmapdata[i, j].AniTick := ENMapData[i, j].AniTick;
              supernewmapdata[i, j].Area := ENMapData[i, j].Area;
              supernewmapdata[i, j].light := ENMapData[i, j].light;
              supernewmapdata[i, j].BkIndex := 0;
              supernewmapdata[i, j].MidIndex := 0;
            end;
          end;
          ENMapData := nil;
        end;
        2: begin  //wemades newer type
          SetLength(MapArr, MapWidth, MapHeight);
          aMapFile.Seek(SizeOf(header), 0);
          for i := 0 to MapWidth - 1 do begin
            aMapFile.Read(MapArr[i, 0], sizeof(TMapInfo) * MapHeight);
            for j := 0 to MapHeight - 1 do
              Move(MapArr[i, j], supernewmapdata[i, j], SizeOf(TMapInfo));
          end;
        end;
        3: begin //shanda's 2012 type
          aMapFile.Seek(SizeOf(header), 0);
          SetLength(supernewMapData, MapWidth, MapHeight);
          for i := 0 to MapWidth - 1 do begin
            aMapFile.Read(supernewMapData[i, 0], sizeof(TsdoMapInfo2012) * MapHeight);
            {
            for j := 0 to MapHeight - 1 do begin
              MapArr[i, j].BkImg := supernewMapData[i, j].BkImg;
              MapArr[i, j].MidImg := supernewMapData[i, j].MidImg;
              MapArr[i, j].FrImg := supernewMapData[i,j].FrImg;
              MapArr[i, j].BkIndex := supernewMapData[i, j].BkIndex;
              MapArr[i, j].MidIndex := supernewMapData[i,j].MidIndex;
              MapArr[i, j].Area := supernewMapData[i,j].Area;
              MapArr[i, j].DoorIndex := supernewMapData[i,j].DoorIndex;
              MapArr[i, j].DoorOffset := supernewMapData[i,j].DoorOffset;
              MapArr[i,j].AniFrame := supernewMapData[i,j].AniFrame;
              MapArr[i,j].AniTick := supernewMapData[i,j].AniTick;
              MapArr[i,j].light := supernewMapData[i,j].light;
              //todo: finish this, there's no fields for the new data atm so not processing it yet
              if supernewmapdata[i,j].Reserved[2] > 0 then
                bmaptype := bmaptype;
            end;
            }
          end;
        end;
        4: begin //wemades antihack type
          aMapFile.Seek(SizeOf(AntiHackHeader), 0);
          SetLength(OldMapData, MapWidth, MapHeight);
          for i := 0 to MapWidth - 1 do begin
            aMapFile.Read(OldMapData[i, 0], sizeof(TOldMapInfo) * MapHeight);
            for j := 0 to MapHeight - 1 do begin
              Move(OldMapData[i, j], supernewmapdata[i, j], SizeOf(TOldMapInfo));
              supernewmapdata[i,j].BkImg := supernewmapdata[i,j].BkImg xor AntiHackHeader.wXOR;
              supernewmapdata[i,j].MidImg := supernewmapdata[i,j].MidImg xor AntiHackHeader.wXOR;
              supernewmapdata[i,j].FrImg := supernewmapdata[i,j].FrImg xor AntiHackHeader.wXOR;
            end;
          end;
        end;
        5: begin //wemades mir3 format
          aMapFile.Seek(SizeOf(EiMapHeader), 0);
          SetLength(EITileData, MapWidth div 2, MapHeight div 2);
          SetLength(EIMapData, MapWidth, MapHeight);
          //first part fo the mapfile contains all the tile info's
          for i := 0 to (MapWidth div 2) - 1 do begin
            aMapFile.Read(EITileData[i, 0], sizeof(TEITileInfo) * (MapHeight div 2)); //only one tile info for every 2 tiles so has to read half
            for j := 0 to (MapHeight div 2) - 1 do begin
              supernewmapdata[i*2,j*2].BkImg := EITileData[i,j].wTileIdx+1;
              supernewmapdata[i*2,j*2].BkIndex := 100 + EITileData[i,j].bFileIdx; //adding 100 so the draw code knows this is an ei file
              supernewmapdata[i*2+1,j*2].BkImg := EITileData[i,j].wTileIdx+1;
              supernewmapdata[i*2+1,j*2].BkIndex := 100 + EITileData[i,j].bFileIdx; //adding 100 so the draw code knows this is an ei file
              supernewmapdata[i*2,j*2+1].BkImg := EITileData[i,j].wTileIdx+1;
              supernewmapdata[i*2,j*2+1].BkIndex := 100 + EITileData[i,j].bFileIdx; //adding 100 so the draw code knows this is an ei file
              supernewmapdata[i*2+1,j*2+1].BkImg := EITileData[i,j].wTileIdx+1;
              supernewmapdata[i*2+1,j*2+1].BkIndex := 100 + EITileData[i,j].bFileIdx; //adding 100 so the draw code knows this is an ei file
            end;
          end;
          //now read the actual xy data
          aMapFile.Seek(SizeOf(EIMapHeader) + ((MapWidth div 2) * (MapHeight div 2))*sizeof(TEITileInfo),0);//this shouldnt technicaly be needed but safety
          for i := 0 to MapWidth - 1 do begin
            aMapFile.Read(EIMapData[i, 0], sizeof(TEIMapInfo) * MapHeight);
            for j := 0 to MapHeight - 1 do begin
              supernewmapdata[i,j].AniFrame := EIMapData[i,j].AniFramefr;
              supernewmapdata[i,j].AniTick := EIMapData[i,j].AniFrame;//cheat
              supernewmapdata[i,j].MidImg := EIMapData[i,j].midimg+1;
              supernewmapdata[i,j].MidIndex := 100 + EIMapData[i,j].midIndex;
              supernewmapdata[i,j].FrImg := EIMapData[i,j].frimg+1;
              supernewmapdata[i,j].Area := 100 + EIMapData[i,j].frindex;
              supernewmapdata[i,j].DoorIndex := EIMapData[i,j].DoorIndex;
              supernewmapdata[i,j].DoorOffset := EIMapData[i,j].DoorOffset;
              //walk and dontwalk info goes last?
              if Boolean(EIMapData[i,j].bflag and $01) = false then supernewmapdata[i,j].BkImg := supernewmapdata[i,j].BkImg or $8000;
              if Boolean(EIMapData[i,j].bflag and $02) = false then supernewmapdata[i,j].FrImg := supernewmapdata[i,j].FrImg or $8000;
            end;
          end;
        end;
        6: begin //shanda's mir3 format
          aMapFile.Seek(SizeOf(TShandaEIMapHeader), 0);
          SetLength(ShandaEIMapData, MapWidth, MapHeight);
          for i := 0 to MapWidth - 1 do begin
            aMapFile.Read(ShandaEIMapData[i, 0], sizeof(TShandaEIMapInfo) * MapHeight);
            for j := 0 to MapHeight - 1 do begin
              supernewmapdata[i,j].BkImg := ShandaEiMapData[i,j].bkimg +1;
              supernewmapdata[i,j].BkIndex := 100 + ShandaEiMapData[i,j].bkindex;
              supernewmapdata[i,j].midImg := ShandaEiMapData[i,j].midimg +1;
              supernewmapdata[i,j].midIndex := 100 + ShandaEiMapData[i,j].midindex;
              supernewmapdata[i,j].frImg := ShandaEiMapData[i,j].frimg +1;
              supernewmapdata[i,j].area := 100 + ShandaEiMapData[i,j].frindex;
               //supernewmapdata and dontwalk info goes last?
              if Boolean(ShandaEiMapData[i,j].bflag and $01) = false then supernewmapdata[i,j].BkImg := supernewmapdata[i,j].BkImg or $8000;
              if Boolean(ShandaEiMapData[i,j].bflag and $02) = false then supernewmapdata[i,j].FrImg := supernewmapdata[i,j].FrImg or $8000;
              //if ShandaEIMapData[i,j].Reserved[0] <> $FF  then
                //outputdebugstring(pAnsiChar(inttostr(ShandaEIMapData[i,j].Reserved[0])));

            end;
          end;
        end;
      end;
      //now convert MapArr (our unified map format) into MapData (the format the client uses to process maps)
      for I := 0 to MapWidth - 1 do begin
        y := i * MapHeight;
        for j := 0 to MapHeight - 1 do begin
          MapData[y+j] := supernewmapdata[i,j];
        end;
      end;
    finally
      aMapFile.Free;
    end;
    {
    sFileName := sFileName + '.mend';
    if FileExists(sFileName) then begin
      aMapFile := TFileStream.Create(sFileName, fmOpenRead or fmShareDenyNone);
      try
        aMapFile.Read(MendHeader, Sizeof(TMapMendHeader));
        if (MendHeader.nWidth = MapWidth) and (MendHeader.nHeight = MapHeight) then begin
          for I := 0 to MendHeader.nCount - 1 do begin
            if aMapFile.Read(MendInfo, Sizeof(TMapMendInfo)) = Sizeof(TMapMendInfo) then begin
              if (MendInfo.nX > 0) and (MendInfo.nY > 0) and (MendInfo.nWidth > 0) and (MendInfo.nHeight > 0) and
                ((MendInfo.nX + MendInfo.nWidth) < MapWidth) and ((MendInfo.nY + MendInfo.nHeight) < MapHeight) then begin
                for J := MendInfo.nX to MendInfo.nX + MendInfo.nWidth do begin
                  for Y := 0 to MendInfo.nHeight - 1 do begin
                    aMapFile.Read(OldMapInfo, Sizeof(TOldMapInfo));
                    Move(OldMapInfo, MapData[J * MapHeight + MendInfo.nY + Y], SizeOf(TOldMapInfo));
                    MapData[J * MapHeight + MendInfo.nY + Y].BkIndex := 0;
                    MapData[J * MapHeight + MendInfo.nY + Y].MidIndex := 0;
                  end;
                end;
              end;
            end;
          end;
        end;
      finally
        aMapFile.Free;
      end;
    end;
    }
  end else
    DScreen.AddSayMsg('MapFile not found', clRed, clWhite, true, us_sys);
  ///  FrmMain.DScreen.AddChatBoardString('MapFile not found',clWhite, clRed);
end;

{ TMapLoading }



end.
