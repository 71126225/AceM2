unit FWeb;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, OleCtrls, SHDocVw, ExtCtrls, WebBrowserWithUI, MSHTML;

type
 TObjectProcedure = procedure of object;

 TEventObject = class(TInterfacedObject, IDispatch)
   private
     FOnEvent: TObjectProcedure;
   protected
     function GetTypeInfoCount(out Count: Integer): HResult; stdcall;
     function GetTypeInfo(Index, LocaleID: Integer; out TypeInfo): HResult; stdcall;
     function GetIDsOfNames(const IID: TGUID; Names: Pointer; NameCount, LocaleID: Integer; DispIDs: Pointer): HResult; stdcall;
     function Invoke(DispID: Integer; const IID: TGUID; LocaleID: Integer; Flags: Word; var Params; VarResult, ExcepInfo, ArgErr: Pointer): HResult; stdcall;
   public
     constructor Create(const OnEvent: TObjectProcedure) ;
     property OnEvent: TObjectProcedure read FOnEvent write FOnEvent;
   end;

  TFrmWeb = class(TForm)
    wb: TWebBrowserWithUI;

    pnl1: TPanel;
    procedure wbNavigateComplete2(ASender: TObject; const pDisp: IDispatch; var URL: OleVariant);
    procedure wbDocumentComplete(ASender: TObject; const pDisp: IDispatch; var URL: OleVariant);
    procedure FormHide(Sender: TObject);
    procedure wbTitleChange(ASender: TObject; const Text: WideString);
    procedure wbProgressChange(ASender: TObject; Progress, ProgressMax: Integer);
    procedure wbDownloadBegin(Sender: TObject);
    procedure wbBeforeNavigate2(ASender: TObject; const pDisp: IDispatch;
      var URL, Flags, TargetFrameName, PostData, Headers: OleVariant;
      var Cancel: WordBool);
  private
    { Private declarations }
    FTitle: string;
    FMainOK: Boolean;
    procedure Document_OnMouseOver;
    procedure Document_OnMouseUp;
  public
    m_sTitle: string;
    procedure ShowWeb(sUrl: string);
  end;

var
  FrmWeb: TFrmWeb;
  htmlDoc : IHTMLDocument2;
implementation
uses
  ActiveX, MShare, Share, clMain, StrUtils, HUtil32, Grobal2, Fstate, HGEGUI;

{$R *.dfm}

procedure TFrmWeb.FormHide(Sender: TObject);
begin
  wb.Stop;
end;

procedure TFrmWeb.ShowWeb(sUrl: string);
begin
  m_sTitle := 'Loading,please wait... 0%';
  FTitle := 'Web Window';
  FMainOK := False;
  pnl1.Visible := True;
  if sUrl <> '' then begin
    Show;
    wb.Navigate(sUrl);
  end;
end;

procedure TFrmWeb.wbBeforeNavigate2(ASender: TObject; const pDisp: IDispatch;
  var URL, Flags, TargetFrameName, PostData, Headers: OleVariant;
  var Cancel: WordBool);
var
  Command: String;
  Seller: String;
  sItemName: string;
  sCount: string;
  MakeIndex: integer;
  nCount: integer;
begin
exit;
  if g_boAllowAuction then begin
    //need to ask quest how many we wanna buy? :p
    Command := '';
    if (AnsiPos('@',Url) > 0) then
    Command := AnsiMidStr(Url,AnsiPos('@',url),99999);
    if AnsiStartsStr('@AuctionBuy',Command) then begin
      wb.Stop();
      Command := AnsiMidStr(Url,Length('@AuctionBuy('),99999);
      Command := GetValidStr3(Command,Seller,[',']);
      Command := GetValidStr3(Command,sItemName,[',']);
      if Seller = g_Myself.m_UserName then begin
        FrmDlg.DMessageDlg('You cannot buy your own items!', [mbOK]);
        exit;
      end;
      Command := GetValidStr3(Command,sCount,[',']);
      nCount := StrToIntDef(sCount,1);
      if (nCount > 1) then begin
        if mrYes = FrmDlg.DMessageDlg('How many would you like to buy?', [mbOk], 10, deInteger,'',True) then begin
         nCount := StrToIntDef(FrmDlg.DlgEditText, -1);
        end else exit;
        if nCount = 0 then exit;
      end;
      MakeIndex := StrToIntDef(AnsiLeftStr(Command,Length(command)-1),1);
      //nCount  := 1;//make it ask instead!
      if (mrYes = FrmDlg.DMessageDlg('Are you sure you want to buy ' + sItemName + '?', [mbYes, mbNo,mbCancel],70,denone,'',True)) then
        FrmMain.SendClientMessage(CM_AUCTIONBID,0,0,0,0,'name');
    end;
    if AnsiStartsStr('@AuctionBid',Command) then begin
      wb.Stop();
      //make it ask how much we wanna bid first
      FrmMain.SendClientMessage(CM_AUCTIONBID,0,0,0,0);
    end;
  end;
  //outputdebugstring(pansichar('testing urls: ' + string(url)));
end;

procedure TFrmWeb.wbDocumentComplete(ASender: TObject; const pDisp: IDispatch; var URL: OleVariant);
begin
  if not FMainOK then begin
    if wb.Application = pDisp then begin
      m_sTitle := FTitle;
      FMainOK := True;
      pnl1.Visible := False;
    end;
  end
  else begin
    m_sTitle := FTitle;
  end;
   if Assigned(wb.Document) then
   begin
     htmlDoc := wb.Document as IHTMLDocument2;
     htmlDoc.onmouseup := (TEventObject.Create(Document_OnMouseUp) as IDispatch);
     htmlDoc.onmouseover := (TEventObject.Create(Document_OnMouseOver) as IDispatch) ;
   end
end;

procedure TFrmWeb.wbDownloadBegin(Sender: TObject);
begin
  wb.Silent := True;
end;

procedure TFrmWeb.wbNavigateComplete2(ASender: TObject; const pDisp: IDispatch; var URL: OleVariant);
begin
  wb.Silent := True;
end;

procedure TFrmWeb.wbProgressChange(ASender: TObject; Progress, ProgressMax: Integer);
begin
  if ProgressMax <= 0 then exit;
  if (Progress <> -1) and (Progress < ProgressMax) then
    m_sTitle := 'Loading,please wait... ' + IntToStr(Round(Progress / ProgressMax * 100)) + '%';
end;

procedure TFrmWeb.wbTitleChange(ASender: TObject; const Text: WideString);
begin
  FTitle := Text;
end;

procedure TFrmWeb.Document_OnMouseUp;
var
  element : IHTMLElement;
  Command: String;
  Seller: String;
  sItemName: string;
  sCount: string;
  MakeIndex: integer;
  nCount: integer;
begin
   if not g_boAllowAuction then exit; //dont waste our time if auction isnt enabled
   if htmlDoc = nil then Exit;
   element := htmlDoc.parentWindow.event.srcElement;
   if element.getAttribute('Command',0) = null then exit;
   Command := element.getAttribute('Command',0);
   if AnsiStartsStr('@AuctionBuy',Command) then begin
     Command := AnsiMidStr(Command,Length('@AuctionBuy(')+1,99999);
     Command := GetValidStr3(Command,Seller,[',']);
     Command := GetValidStr3(Command,sItemName,[',']);
    if Seller = g_Myself.m_UserName then begin
      FrmDlg.DMessageDlg('You cannot buy your own items!', [mbOK]);
      exit;
    end;
    Command := GetValidStr3(Command,sCount,[',']);
    nCount := StrToIntDef(sCount,1);
    if (nCount > 1) then begin
      if mrYes = FrmDlg.DMessageDlg('How many would you like to buy?', [mbOk], 10, deInteger,'',True) then begin
       nCount := StrToIntDef(FrmDlg.DlgEditText, -1);
      end else exit;
      if nCount = 0 then exit;
    end;
    MakeIndex := StrToIntDef(AnsiLeftStr(Command,Length(command)-1),1);
    //nCount  := 1;//make it ask instead!
    if (mrYes = FrmDlg.DMessageDlg('Are you sure you want to buy ' + sItemName + '?', [mbYes, mbNo,mbCancel],70,denone,'',True)) then
      FrmMain.SendClientMessage(CM_AUCTIONBID,MakeIndex,0,0,nCount,Seller);
  end;
  if AnsiStartsStr('@AuctionBid',Command) then begin
    //make it ask how much we wanna bid first
    FrmMain.SendClientMessage(CM_AUCTIONBID,0,0,0,0);
  end;
end;


procedure TFrmWeb.Document_OnMouseOver;
var
   element : IHTMLElement;
   stats,Vals,Flute,Strength,mapdesc,mapname: string;
   value: string;
   TempItem:pTNewClientItem;
   i: integer;
begin
   DScreen.ClearHint(true);
   if not g_boAllowAuction then exit; //dont waste our time if auction isnt enabled
   if (g_myself = nil) then exit;

   if htmlDoc = nil then Exit;

   element := htmlDoc.parentWindow.event.srcElement;
   if element.getAttribute('stats',0) = null then exit;
   if element.getAttribute('Value',0) = null then exit;
   if element.getAttribute('Flute',0) = null then exit;
   if element.getAttribute('Strenghtinfo',0) = null then exit;
   if element.getAttribute('mapdesc',0) = null then exit;
   if element.getAttribute('mapname',0) = null then exit;

   

   stats := string(element.getAttribute('stats',0));
   Vals := string(element.getAttribute('Value',0));
   Flute := string(element.getAttribute('Flute',0));
   Strength := string(element.getAttribute('Strenghtinfo',0));

   try
     new(TempItem);
     {$region 'Ugly code to turn string of stats into item value'}
     stats := GetValidStr3(stats,value,[',']);
     TempItem.UserItem.MakeIndex := StrToInt(value);
     stats := GetValidStr3(stats,value,[',']);
     TempItem.UserItem.wIndex := StrToInt(value);
     stats := GetValidStr3(stats,value,[',']);
     TempItem.UserItem.btBindMode1 := StrToInt(value);
     stats := GetValidStr3(stats,value,[',']);
     TempItem.UserItem.btBindMode2 := StrToInt(value);
     stats := GetValidStr3(stats,value,[',']);
     TempItem.UserItem.TermTime := StrToInt(value);
     stats := GetValidStr3(stats,value,[',']);
     TempItem.UserItem.Dura := StrToInt(value);
     stats := GetValidStr3(stats,value,[',']);
     TempItem.UserItem.DuraMax := StrToInt(value);
     stats := GetValidStr3(stats,value,[',']);
     TempItem.UserItem.EffectValue.btColor := StrToInt(value);
     stats := GetValidStr3(stats,value,[',']);
     TempItem.UserItem.EffectValue.btEffect := StrToInt(value);
     stats := GetValidStr3(stats,value,[',']);
     TempItem.UserItem.EffectValue.btUpgrade := StrToInt(value);
     stats := GetValidStr3(stats,value,[',']);
     TempItem.UserItem.EffectValue.btReserved := StrToInt(value);
     stats := GetValidStr3(stats,value,[',']);
     TempItem.UserItem.EffectValue.btReserved2 := StrToInt(value);
     stats := GetValidStr3(stats,value,[',']);
     TempItem.UserItem.Value.btWuXin := StrToInt(value);
     stats := GetValidStr3(stats,value,[',']);
     TempItem.UserItem.Value.btFluteCount := StrToInt(value);
     stats := GetValidStr3(stats,value,[',']);
     TempItem.UserItem.Value.StrengthenInfo.btCanStrengthenCount := StrToInt(value);
     stats := GetValidStr3(stats,value,[',']);
     TempItem.UserItem.Value.StrengthenInfo.btStrengthenCount := StrToInt(value);
     stats := GetValidStr3(stats,value,[',']);
     TempItem.UserItem.ComLevel:= StrToInt(value);
     i := 0;
     while length(Vals) > 1 do begin
       Vals := GetValidStr3(Vals,value,[',']);
       TempItem.UserItem.Value.btValue[i] := StrToInt(value);
       inc(i);
     end;
     i := 0;
     while length(Flute) > 1 do begin
       Flute := GetValidStr3(Flute,value,[',']);
       TempItem.UserItem.Value.wFlute[i] := StrToInt(value);
       inc(i);
     end;
     i := 0;
     while length(Strength) > 1 do begin
       Strength := GetValidStr3(Strength,value,[',']);
       TempItem.UserItem.Value.StrengthenInfo.btStrengthenInfo[i] := StrToInt(value);
       inc(i);
     end;
     TempItem.s := GetStditem(TempItem.UserItem.wIndex, g_Myself.m_Abil.Level, g_Myself.m_btJob);

     {$endregion}
     DScreen.ShowHint(g_FScreenWidth-100,5,
          ShowItemInfo(TempItem^, [], []), clwhite, False, 0, True);
   finally
     Dispose(TempItem);
   end;
end; (*Document_OnMouseOver*)

{ TEventObject }

constructor TEventObject.Create(const OnEvent: TObjectProcedure) ;
begin
   inherited Create;
   FOnEvent := OnEvent;
   
end;

function TEventObject.GetIDsOfNames(const IID: TGUID; Names: Pointer; NameCount, LocaleID: Integer; DispIDs: Pointer): HResult;
begin
   Result := E_NOTIMPL;
end;

function TEventObject.GetTypeInfo(Index, LocaleID: Integer; out TypeInfo): HResult;
begin
   Result := E_NOTIMPL;
end;

function TEventObject.GetTypeInfoCount(out Count: Integer): HResult;
begin
   Result := E_NOTIMPL;
end;

function TEventObject.Invoke(DispID: Integer; const IID: TGUID; LocaleID: Integer; Flags: Word; var Params; VarResult, ExcepInfo, ArgErr: Pointer): HResult;
begin
   if (DispID = DISPID_VALUE) then
   begin
     if Assigned(FOnEvent) then FOnEvent;
     Result := S_OK;
   end
   else Result := E_NOTIMPL;
end;

initialization
  OleInitialize(nil);

finalization
  try
    OleUninitialize;
  except
  end;

end.

