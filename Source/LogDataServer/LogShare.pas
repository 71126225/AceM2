unit LogShare;

interface
uses
  Windows, Messages, SysUtils;

const
  GS_QUIT = 2000;
  SG_FORMHANDLE = 1000; //服务器HANLD
  SG_STARTNOW = 1001; //正在启动服务器...
  SG_STARTOK = 1002; //启动完成...

  tLogServer = 2;

  ADODBString = 'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=%s;Persist Security Info=False';
  ADODBSQL =
    'INSERT INTO Log (Action, Map, X coordinate, Y coordinate, Character name, Item name, Item ID, Item quantity, Transaction object, Note 1, Note 2, Note 3) values (%s,'#39'%s'#39',%s,%s,'#39'%s'#39','#39'%s'#39',%s,%s,'#39'%s'#39','#39'%s'#39','#39'%s'#39','#39'%s'#39')';

type
  TLogClass = record
    sLogName: string[10];
    nLogIdx: Byte;
  end;
var
  sBaseDir: string = '.\BaseDir\';
  sServerName: string = '飞鸿网络';
  sCaption: string = 'Log Data Server';
  g_dwGameCenterHandle: THandle;
  nServerPort: Integer = 10000;
  g_boTeledata: Boolean = False;

  m_LogList: array[0..12] of TLogClass = (
    (sLogName: 'Death'; nLogIdx: 0),
    (sLogName: 'Gold Coin Changes'; nLogIdx: 1),
    (sLogName: 'Bond Change'; nLogIdx: 2),
    (sLogName: 'Points change'; nLogIdx: 3),
    (sLogName: 'Ingot Change'; nLogIdx: 4),
    (sLogName: 'Points change'; nLogIdx: 5),
    (sLogName: 'Quantity changes'; nLogIdx: 6),
    (sLogName: 'Add items'; nLogIdx: 7),
    (sLogName: 'Reduce items'; nLogIdx: 8),
    (sLogName: 'Warehouse access'; nLogIdx: 9),
    (sLogName: 'Strengthening changes'; nLogIdx: 10),
    (sLogName: 'Adjust items'; nLogIdx: 11),
    (sLogName: 'Reputation Changes'; nLogIdx: 12)
  );

procedure SendGameCenterMsg(wIdent: Word; sSendMsg: string);
implementation

procedure SendGameCenterMsg(wIdent: Word; sSendMsg: string);
var
  SendData: TCopyDataStruct;
  nParam: Integer;
begin
  nParam := MakeLong(Word(tLogServer), wIdent);
  SendData.cbData := Length(sSendMsg) + 1;
  GetMem(SendData.lpData, SendData.cbData);
  StrCopy(SendData.lpData, PChar(sSendMsg));
  SendMessage(g_dwGameCenterHandle, WM_COPYDATA, nParam, Cardinal(@SendData));
  FreeMem(SendData.lpData);
end;

end.

