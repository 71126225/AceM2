program RPGViewer;

uses
  Forms,
  FrmMain in 'FrmMain.pas' {FormMain},
  ZShare in 'ZShare.pas',
  FrmAdd in 'FrmAdd.pas' {FormAdd},
  FrmDel in 'FrmDel.pas' {FormDel},
  FrmOut in 'FrmOut.pas' {FormOut},
  FrmAlpha in 'FrmAlpha.pas' {FormAlpha},
  MyCommon in '..\..\MyCommon\MyCommon.pas',
  HUtil32 in '..\..\Common\HUtil32.pas',
  Bass in '..\..\MirClient\Bass.pas',
  DLLFile in '..\..\MirClient\DLLFile.pas',
  pngimage in '..\..\..\Components\pngimage\pngimage.pas',
  pnglang in '..\..\..\Components\pngimage\pnglang.pas',
  pnglib in '..\..\..\Components\pngimage\pnglib.pas',
  WIL in '..\..\..\Needs Sorting\from sources folder\DX9WIL\WIL.pas',
  wm521g in '..\..\..\Needs Sorting\from sources folder\DX9WIL\wm521g.pas',
  wmM2Def in '..\..\..\Needs Sorting\from sources folder\DX9WIL\wmM2Def.pas',
  wmM2Wis in '..\..\..\Needs Sorting\from sources folder\DX9WIL\wmM2Wis.pas',
  wmM3Def in '..\..\..\Needs Sorting\from sources folder\DX9WIL\wmM3Def.pas',
  wmMyImage in '..\..\..\Needs Sorting\from sources folder\DX9WIL\wmMyImage.pas',
  wmWoool in '..\..\..\Needs Sorting\from sources folder\DX9WIL\wmWoool.pas',
  wmM2Zip in '..\..\..\Needs Sorting\from sources folder\DX9WIL\wmM2Zip.pas',
  wmM3Zip in '..\..\..\Needs Sorting\from sources folder\DX9WIL\wmM3Zip.pas',
  DropGroupPas in '..\..\..\Components\dropbox\DropGroupPas.pas',
  WmM3Wtl in '..\..\..\Needs Sorting\from sources folder\DX9WIL\WmM3Wtl.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormMain, FormMain);
  Application.CreateForm(TFormAdd, FormAdd);
  Application.CreateForm(TFormDel, FormDel);
  Application.CreateForm(TFormOut, FormOut);
  Application.CreateForm(TFormAlpha, FormAlpha);
  Application.Run;
end.
