unit FState;

interface

uses
  Windows, SysUtils, StrUtils, Classes, Messages, Graphics, Controls, Forms, Dialogs, HGEBase, DES, HGE,
  HGEGUI, HGETextures, Grids, Grobal2, ClFunc, HUtil32, FindMapPath,
  SoundUtil, IntroScn, MShare, DateUtils, DirectXGraphics, MudUtil, RSA, IniFiles;

type
  //THintBack = (hbConnect, hbLogin);
  TItemPaintMode = set of (pmNone, pmShowLevel, pmGrayScale, pmBlend);
  TSpotDlgMode = (dmSell, dmRepair);

  pTDiceInfo = ^TDiceInfo;
  TDiceInfo = record
    nDicePoint: Integer; //0x66C
    nPlayPoint: Integer; //0x670 当前骰子点数
    nX: Integer; //0x674
    nY: Integer; //0x678
    n67C: Integer; //0x67C
    n680: Integer; //0x680
    dwPlayTick: LongWord; //0x684
  end;

  TFrmDlg = class(TForm)
    DBackground: TDWindow;
    DWinSelServer: TDWindow;
    DWndHint: TDWindow;
    DBTHintClose: TDButton;
    DLogIn: TDWindow;
    DLoginClose: TDButton;
    DLoginOk: TDButton;
    DLoginChgPw: TDButton;
    DLoginNew: TDButton;
    DEditID: TDEdit;
    DEditPass: TDEdit;
    DLoginHome: TDButton;
    DLoginExit: TDButton;
    DNewAccount: TDWindow;
    DNewAccountOk: TDButton;
    DNewAccountCancel: TDButton;
    DEditNewId: TDEdit;
    DEditNewPasswd: TDEdit;
    DEditConfirm: TDEdit;
    DEditYourName: TDEdit;
    DEditBirthDay: TDEdit;
    DEditQuiz1: TDEdit;
    DEditAnswer1: TDEdit;
    DEditQuiz2: TDEdit;
    DEditAnswer2: TDEdit;
    DEditEMail: TDEdit;
    DEditPhone: TDEdit;
    DEditMobPhone: TDEdit;
    DEditRecommendation: TDEdit;
    DChgPw: TDWindow;
    DChgpwOk: TDButton;
    DChgpwCancel: TDButton;
    DEditChgId: TDEdit;
    DEditChgCurrentpw: TDEdit;
    DEditChgNewPw: TDEdit;
    DEditChgRepeat: TDEdit;
    DMsgDlg: TDWindow;
    DMsgDlgOk: TDButton;
    DMsgDlgCancel: TDButton;
    DSelectChr: TDWindow;
    DscSelect1: TDButton;
    DscSelect2: TDButton;
    DscSelect3: TDButton;
    DscStart: TDButton;
    DscNewChr: TDButton;
    DscEraseChr: TDButton;
    DscCredits: TDButton;
    DscExit: TDButton;
    DCreateChr: TDWindow;
    DccWarrior: TDButton;
    DccWizzard: TDButton;
    DccMonk: TDButton;
    DccJ: TDButton;
    DccM: TDButton;
    DccS: TDButton;
    DccH: TDButton;
    DccT: TDButton;
    DccMale: TDButton;
    DccFemale: TDButton;
    DccClose: TDButton;
    DccOk: TDButton;
    DRenewChr: TDWindow;
    DEditChrName: TDEdit;
    DButRenewChr: TDButton;
    DButRenewClose: TDButton;
    DBottom: TDWindow;
    DMyState: TDButton;
    DMyBag: TDButton;
    DMyMagic: TDButton;
    DOption: TDButton;
    DBotTrade: TDButton;
    DBotGuild: TDButton;
    DBotGroup: TDButton;
    DBotFriend: TDButton;
    DBotSort: TDButton;
    DTop: TDWindow;
    DTopHelp: TDButton;
    DTopGM: TDButton;
    DOpenMinmap: TDButton;
    DMiniMapDlg: TDWindow;
    DMinMap128: TDWindow;
    DTopShop: TDButton;
    DMiniMapMax: TDButton;
    DMaxMiniMap: TDWindow;
    DMaxMinimapClose: TDButton;
    DMaxMap792: TDWindow;
    DBottom2: TDWindow;
    DItemBag: TDWindow;
    DItemGrid: TDGrid;
    DGold: TDButton;
    DCloseBag: TDButton;
    DEditDlgEdit: TDEdit;
    DWndSay: TDWindow;
    DBTEdit: TDButton;
    DBTSayLock: TDButton;
    DBTSayMove: TDButton;
    DSayUpDown: TDUpDown;
    DEditChat: TDImageEdit;
    DBTFace: TDButton;
    DBTOption: TDButton;
    DWndFace: TDWindow;
    DWudItemShow: TDWindow;
    DBTItemShowClose: TDButton;
    DUserState: TDWindow;
    DCloseUserState: TDButton;
    DMerchantDlg: TDWindow;
    DMDlgUpDonw: TDUpDown;
    DMerchantDlgClose: TDButton;
    DMenuDlg: TDWindow;
    DMenuUpDonw: TDUpDown;
    DWndBuy: TDWindow;
    DBuyOK: TDButton;
    DBuyClose: TDButton;
    DBuyAdd: TDButton;
    DBuyDel: TDButton;
    DBuyEdit: TDEdit;
    DDealDlg: TDWindow;
    DDRGrid: TDGrid;
    DDGrid: TDGrid;
    DDGold: TDButton;
    DDealOk: TDButton;
    DDealClose: TDButton;
    DDealLock: TDButton;
    DDRDealLock: TDCheckBox;
    DDRDealOk: TDCheckBox;
    DGroupDlg: TDWindow;
    DGrpCreate: TDButton;
    DGrpAddMem: TDButton;
    DGrpDelMem: TDButton;
    DGroupExit: TDButton;
    DCBGroupItemDef: TDCheckBox;
    DCBGroupItemRam: TDCheckBox;
    DGrpAllowGroup: TDCheckBox;
    DGrpCheckGroup: TDCheckBox;
    DGrpDlgClose: TDButton;
    DGroupUpDown: TDUpDown;
    DGrpMemberList: TDWindow;
    DGrpUserList: TDWindow;
    DTopEMail: TDButton;
    DBTCheck1: TDButton;
    DBTCheck2: TDButton;
    DBTCheck3: TDButton;
    DBTCheck4: TDButton;
    DBTCheck5: TDButton;
    DBTCheck6: TDButton;
    DBTCheck7: TDButton;
    DBTCheck8: TDButton;
    DBTCheck9: TDButton;
    DBTCheck10: TDButton;
    DPopUpEdits: TDPopUpMemu;
    DPopUpSayList: TDPopUpMemu;
    DPopUpPlay: TDPopUpMemu;
    DStateWin: TDWindow;
    DStateWinItem: TDWindow;
    DSWWeapon: TDButton;
    DCloseState: TDButton;
    DSWDress: TDButton;
    DSWArmRingR: TDButton;
    DSWRingR: TDButton;
    DSWBelt: TDButton;
    DSWBujuk: TDButton;
    DSWHouse: TDButton;
    DSWCharm: TDButton;
    DSWCowry: TDButton;
    DSWArmRingL: TDButton;
    DSWLight: TDButton;
    DSWNecklace: TDButton;
    DSWHelmet: TDButton;
    DSWBoots: TDButton;
    DSWRingL: TDButton;
    DStateWinAbil: TDWindow;
    DStateBTItem: TDButton;
    DStateBTAbil: TDButton;
    DStateBTMagic: TDButton;
    DStateBTInfo: TDButton;
    DStateAbilOk: TDButton;
    DStateAbilExit: TDButton;
    DStateWinMagic: TDWindow;
    DStateWinInfo: TDWindow;
    DStateGrid: TDGrid;
    DStateAbilAdd3: TDButton;
    DStateAbilDel3: TDButton;
    DStateAbilAdd1: TDButton;
    DStateAbilDel1: TDButton;
    DStateAbilAdd2: TDButton;
    DStateAbilDel2: TDButton;
    DStateAbilAdd4: TDButton;
    DStateAbilDel4: TDButton;
    DStateAbilAdd5: TDButton;
    DStateAbilDel5: TDButton;
    DStateAbilAdd6: TDButton;
    DStateAbilDel6: TDButton;
    DStateInfoName: TDEdit;
    DStateInfoAge: TDEdit;
    DStateInfoAM: TDCheckBox;
    DStateInfoPM: TDCheckBox;
    DStateInfoNight: TDCheckBox;
    DStateInfoMidNight: TDCheckBox;
    DStateInfoFriend: TDCheckBox;
    DStateInfoExit: TDButton;
    DStateInfoSave: TDButton;
    DStateInfoRefPic: TDButton;
    DStateInfoUpLoadPic: TDButton;
    DStateInfoMemo: TDMemo;
    DStateInfoArea: TDComboBox;
    DStateInfoCity: TDComboBox;
    DStateInfoProvince: TDComboBox;
    DStateInfoSex: TDComboBox;
    DUserStateItem: TDWindow;
    DWeaponUS1: TDButton;
    DDressUS1: TDButton;
    DArmringRUS1: TDButton;
    DRingRUS1: TDButton;
    DBeltUS1: TDButton;
    DCharmUS1: TDButton;
    DBujukUS1: TDButton;
    DHouseUS1: TDButton;
    DCowryUS1: TDButton;
    DBootsUS1: TDButton;
    DRingLUS1: TDButton;
    DArmringLUS1: TDButton;
    DLightUS1: TDButton;
    DNecklaceUS1: TDButton;
    DHelmetUS1: TDButton;
    DUserStateInfo: TDWindow;
    DUserStateInfoName: TDEdit;
    DUserStateInfoAge: TDEdit;
    DUserStateInfoMemo: TDMemo;
    DUserStateInfoRefPic: TDButton;
    DUserStateInforeport: TDButton;
    DUserStateInfoFriend: TDCheckBox;
    DUserStateInfoMidNight: TDCheckBox;
    DUserStateInfoNight: TDCheckBox;
    DUserStateInfoPM: TDCheckBox;
    DUserStateInfoAM: TDCheckBox;
    DUserStateBTItem: TDButton;
    DUserStateBTInfo: TDButton;
    DUserStateInfoSex: TDEdit;
    DUserStateInfoArea: TDEdit;
    DUserStateInfoProvince: TDEdit;
    DUserStateInfoCity: TDEdit;
    DItemAddBag1: TDButton;
    DItemAddBag2: TDButton;
    DItemAddBag3: TDButton;
    DItemAppendBag1: TDWindow;
    DItemAppendBag2: TDWindow;
    DItemAppendBag3: TDWindow;
    DItemGrid1: TDGrid;
    DItemGrid2: TDGrid;
    DItemGrid3: TDGrid;
    DItemBagRef: TDButton;
    DItemBagShop: TDButton;
    DBTTakeHorse: TDButton;
    DBTAttackMode: TDButton;
    DWndAttackModeList: TDWindow;
    DBTAttackModeAll: TDButton;
    DBTAttackModePeace: TDButton;
    DBTAttackModeDear: TDButton;
    DBTAttackModeMaster: TDButton;
    DBTAttackModeGroup: TDButton;
    DBTAttackModeGuild: TDButton;
    DBTAttackModePK: TDButton;
    DMenuShop: TDButton;
    DMenuReturn: TDButton;
    DMenuRepairAll: TDButton;
    DMenuSuperRepairAll: TDButton;
    DMenuRepair: TDButton;
    DMenuSuperRepair: TDButton;
    DMenuBuy: TDButton;
    DMenuSell: TDButton;
    DMenuClose: TDButton;
    DMenuGrid: TDGrid;
    DMagicFront: TDButton;
    DMagicNext: TDButton;
    DUserKeyGrid1: TDGrid;
    DUserKeyGrid2: TDGrid;
    DMagicBase: TDButton;
    DMagicCbo: TDButton;
    DMagicCBOSetup: TDButton;
    DStateWinMagicCbo: TDWindow;
    DStateWinMagicCboClose: TDButton;
    DStateWinMagicCboOK: TDButton;
    DStateWinMagicCboExit: TDButton;
    DStateWinMagicCboICO: TDButton;
    DStateWinMagicCboGrid: TDGrid;
    DBtnSayAll: TDButton;
    DBtnSayWhisper: TDButton;
    DBtnSayCry: TDButton;
    DBtnSayGroup: TDButton;
    DBtnSayGuild: TDButton;
    DBtnSaySys: TDButton;
    DBtnSayHear: TDButton;
    DBtnSayCustom: TDButton;
    dchkSayLock: TDCheckBox;
    dwndSayMode: TDWindow;
    dbtnSayModeHear: TDButton;
    dbtnSayModeWhisper: TDButton;
    dbtnSayModeCry: TDButton;
    dbtnSayModeGroup: TDButton;
    dbtnSayModeGuild: TDButton;
    dbtnSayModeWorld: TDButton;
    dwndWhisperName: TDWindow;
    dbtnSelServer1: TDButton;
    dbtnSelServer2: TDButton;
    dbtnSelServer3: TDButton;
    dbtnSelServer4: TDButton;
    dbtnSelServer5: TDButton;
    dbtnSelServer6: TDButton;
    dbtnSelServer7: TDButton;
    dbtnSelServer8: TDButton;
    dbtnSelServerClose: TDButton;
    dbtnLoginLostPw: TDButton;
    DMagicSub: TDButton;
    DMakeMagicAdd1: TDButton;
    DMakeMagicAdd2: TDButton;
    DMakeMagicAdd3: TDButton;
    DMakeMagicAdd4: TDButton;
    DMakeMagicAdd5: TDButton;
    DMakeMagicAdd6: TDButton;
    DMakeMagicAdd7: TDButton;
    DMakeMagicAdd8: TDButton;
    DMakeMagicAdd9: TDButton;
    DMakeMagicAdd10: TDButton;
    RState: TRSA;
    DButtonTop: TDButton;
    DCreateChr2: TDWindow;
    DEditChrName2: TDEdit;
    DccOk2: TDButton;
    DccClose2: TDButton;
    DccManWarrior: TDButton;
    DccManWizzard: TDButton;
    DccManMonk: TDButton;
    DccWoManWarrior: TDButton;
    DccWoManWizzard: TDButton;
    DccWoManMonk: TDButton;
    DTopStatusEXP: TDButton;
    DTopStatusPOW: TDButton;
    DTopStatusSC: TDButton;
    DTopStatusAC: TDButton;
    DTopStatusDC: TDButton;
    DTopStatusHIDEMODE: TDButton;
    DTopStatusSTONE: TDButton;
    DTopStatusMC: TDButton;
    DTopStatusMP: TDButton;
    DTopStatusMAC: TDButton;
    DTopStatusHP: TDButton;
    DTopStatusDAMAGEARMOR: TDButton;
    DTopStatusDECHEALTH: TDButton;
    DTopStatusCOBWEB: TDButton;
    DStateBTHorse: TDButton;
    DStateWinHorse: TDWindow;
    DHorseRein: TDButton;
    DHorseBell: TDButton;
    DHorseSaddle: TDButton;
    DHorseDecoration: TDButton;
    DHorseNail: TDButton;
    DUserStateBTHorse: TDButton;
    DUserStateHorse: TDWindow;
    DUSHorseRein: TDButton;
    DUSHorseBell: TDButton;
    DUSHorseSaddle: TDButton;
    DUSHorseDecoration: TDButton;
    DUSHorseNail: TDButton;
    DNewAccountClose: TDButton;
    DBotMiniMap: TDButton;
    DBotAddAbil: TDButton;
    DBotMusic: TDButton;
    DMiniMap: TDWindow;
    DBotWndSay: TDWindow;
    DCloseSayHear: TDButton;
    DCloseSayWhisper: TDButton;
    DCloseSayCry: TDButton;
    DCloseSayGuild: TDButton;
    DCloseSayGroup: TDButton;
    DStateBTState: TDButton;
    DStateWinState: TDWindow;
    DOpenCompoundItem: TDButton;
    DBottom3: TDWindow;
    DBottom4: TDWindow;
    DTopCharStatus: TDWindow;
    DScrollBgTopMini: TDWindow;
    DScrollBgBottomMini: TDWindow;
    DChatImgBgLeftTopMini: TDWindow;
    DChatImgBgLeftBottomMini: TDWindow;
    DChatImgBgBottomMini: TDWindow;
    DChatImgBgTopMini: TDWindow;
    DChatImgBgLeftMidleMini: TDWindow;
    DScrollBgMiddleMini: TDWindow;
    DMiniMapFrame: TDWindow;
    DTopCharAvatar: TDWindow;
    DFrameMaxMin: TDButton;
    DChatEnlargeButton: TDButton;
    DccKiller: TDButton;
    DccRanger: TDButton;
    DSaleDlg: TDWindow;
    DSaleDlgSell: TDButton;
    DSaleDlgClose: TDButton;
    DSaleDlgSpot: TDButton;
    DSaleDlgLock: TDButton;
    DSubShop: TDWindow;
    DSubShopClose: TDButton;
    DSubShopGrid: TDGrid;
    DSubShopBuy: TDButton;
    DSubShopUpDown: TDUpDown;
    DTopStatusSlowDown: TDButton;
    DTopStatusFreeze: TDButton;
    DTopStatusStun: TDButton;
    DTopStatusRage: TDButton;
    DTopStatusMagicBooster: TDButton;
    DTopStatusUE: TDButton;
    DTopStatusCurse: TDButton;
    DTopStatusProField: TDButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure DWinSelServerMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure DWinSelServerClick(Sender: TObject; X, Y: Integer);
    procedure dbtnSelServer1ClickSound(Sender: TObject;
      Clicksound: TClickSound);
    procedure DWinSelServerDirectPaint(Sender: TObject;
      dsurface: TDXTexture);
    procedure DWinSelServerExitClick(Sender: TObject; X, Y: Integer);
    procedure DWndHintDirectPaint(Sender: TObject;
      dsurface: TDXTexture);
    procedure dbtnSelServer1Click(Sender: TObject; X, Y: Integer);
    procedure DBTHintCloseClick(Sender: TObject; X, Y: Integer);
    procedure DLogInDirectPaint(Sender: TObject; dsurface: TDXTexture);
    procedure DLoginHomeDirectPaint(Sender: TObject;
      dsurface: TDXTexture);
    procedure DLoginCloseClick(Sender: TObject; X, Y: Integer);
    procedure DNewAccountDirectPaint(Sender: TObject;
      dsurface: TDXTexture);
    procedure DWndHintVisible(Sender: TObject; boVisible: Boolean);
    procedure DWndHintKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DMsgDlgDirectPaint(Sender: TObject; dsurface: TDXTexture);
    procedure DMsgDlgKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DMsgDlgOkClick(Sender: TObject; X, Y: Integer);
    procedure DscSelect1Click(Sender: TObject; X, Y: Integer);
    procedure DCreateChrDirectPaint(Sender: TObject;
      dsurface: TDXTexture);
    procedure DccWarriorDirectPaint(Sender: TObject;
      dsurface: TDXTexture);
    procedure DRenewChrDirectPaint(Sender: TObject;
      dsurface: TDXTexture);
    procedure DRenewChrClick(Sender: TObject; X, Y: Integer);
    procedure DMyStateDirectPaint(Sender: TObject;
      dsurface: TDXTexture);
    procedure DButtonDirectPaint(Sender: TObject;
      dsurface: TDXTexture);
    procedure DBotGuildDirectPaint(Sender: TObject;
      dsurface: TDXTexture);
    procedure DBottomDirectPaint(Sender: TObject; dsurface: TDXTexture);
    procedure DTopDirectPaint(Sender: TObject; dsurface: TDXTexture);
    procedure DTopGMMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure DccWarriorMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure DMyStateMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure DTopMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure DOpenMinmapDirectPaint(Sender: TObject;
      dsurface: TDXTexture);
    procedure DOpenMinmapClick(Sender: TObject; X, Y: Integer);
    procedure DMiniMapDlgDirectPaint(Sender: TObject;
      dsurface: TDXTexture);
    procedure DMinMap128DirectPaint(Sender: TObject;
      dsurface: TDXTexture);
    procedure DMinMap128MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure DMinMap128MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure DMinMap128MouseEntry(Sender: TObject; MouseEntry: TMouseEntry);
    procedure DMaxMinimapCloseClick(Sender: TObject; X, Y: Integer);
    procedure DMiniMapMaxClick(Sender: TObject; X, Y: Integer);
    procedure DMiniMapDlgInRealArea(Sender: TObject; X, Y: Integer;
      var IsRealArea: Boolean);
    procedure DMaxMiniMapDirectPaint(Sender: TObject;
      dsurface: TDXTexture);
    procedure DMaxMap792DirectPaint(Sender: TObject;
      dsurface: TDXTexture);
    procedure DMaxMap792MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure DMaxMap792MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure DBottom2EndDirectPaint(Sender: TObject;
      dsurface: TDXTexture);
    procedure DBottom2DirectPaint(Sender: TObject;
      dsurface: TDXTexture);
    procedure DBottom3EndDirectPaint(Sender: TObject;
      dsurface: TDXTexture);
    procedure DBottom3DirectPaint(Sender: TObject;
      dsurface: TDXTexture);
    procedure DBottom4EndDirectPaint(Sender: TObject;
      dsurface: TDXTexture);
    procedure DBottom4DirectPaint(Sender: TObject;
      dsurface: TDXTexture);
    procedure DTopCharStatusEndDirectPaint(Sender: TObject;
      dsurface: TDXTexture);                                                     
    procedure DTopCharStatusDirectPaint(Sender: TObject;
      dsurface: TDXTexture);                                                                    
    procedure DTopCharAvatarEndDirectPaint(Sender: TObject;
      dsurface: TDXTexture);
    procedure DTopCharAvatarDirectPaint(Sender: TObject;
      dsurface: TDXTexture);
    procedure DChatImgBgTopMiniEndDirectPaint(Sender: TObject;
      dsurface: TDXTexture);
    procedure DChatImgBgTopMiniDirectPaint(Sender: TObject;
      dsurface: TDXTexture);
    procedure DChatImgBgBottomMiniEndDirectPaint(Sender: TObject;
      dsurface: TDXTexture);
    procedure DChatImgBgBottomMiniDirectPaint(Sender: TObject;
      dsurface: TDXTexture);
    procedure DChatImgMiddleMiniLeftEndDirectPaint(Sender: TObject;
      dsurface: TDXTexture);
    procedure DChatImgMiddleMiniLeftDirectPaint(Sender: TObject;
      dsurface: TDXTexture);
    procedure DChatImgMiddleMiniRightEndDirectPaint(Sender: TObject;
      dsurface: TDXTexture);
    procedure DChatImgMiddleMiniRightDirectPaint(Sender: TObject;
      dsurface: TDXTexture);
    procedure DMiniMapFrameDirectPaint(Sender: TObject;
      dsurface: TDXTexture);
    procedure DMiniMapFrameEndDirectPaint(Sender: TObject;
      dsurface: TDXTexture);
    procedure DMyStateClick(Sender: TObject; X, Y: Integer);
    procedure DItemBagDirectPaint(Sender: TObject; dsurface: TDXTexture);
    procedure DItemGridGridPaint(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState; dsurface: TDXTexture);
    procedure DItemGridGridMouseMove(Sender: TObject; X, Y: integer; ACol, ARow: Integer; Shift: TShiftState);
    procedure DItemGridGridSelect(Sender: TObject; X, Y: integer; ACol, ARow: Integer; Shift: TShiftState);
    procedure DItemGridDblClick(Sender: TObject);
    procedure DGoldClick(Sender: TObject; X, Y: Integer);
    procedure DBackgroundMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure DBackgroundBackgroundClick(Sender: TObject);
    procedure DMsgDlgInRealArea(Sender: TObject; X, Y: Integer;
      var IsRealArea: Boolean);
    procedure DWndSayDirectPaint(Sender: TObject; dsurface: TDXTexture);
    procedure DBTSayMoveMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure DEditChatChange(Sender: TObject);
    procedure DBTEditDirectPaint(Sender: TObject; dsurface: TDXTexture);
    procedure DBTFaceClick(Sender: TObject; X, Y: Integer);
    procedure DBTOptionClick(Sender: TObject; X, Y: Integer);
    procedure DEditChatClick(Sender: TObject; X, Y: Integer);
    procedure DEditChatCheckItem(Sender: TObject; ItemIndex: Integer; var ItemName: string);
    procedure DBTEditClick(Sender: TObject; X, Y: Integer);
    procedure DWndFaceDirectPaint(Sender: TObject; dsurface: TDXTexture);
    procedure DWndFaceClick(Sender: TObject; X, Y: Integer);
    procedure DWndFaceMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure DEditChatDrawEditImage(Sender: TObject; ImageSurface: TDXTexture; Rect: TRect;
      ImageIndex: Integer);
    procedure DBTSayLockClick(Sender: TObject; X, Y: Integer);
    procedure DBTSayLockDirectPaint(Sender: TObject; dsurface: TDXTexture);
    procedure DWudItemShowDirectPaint(Sender: TObject; dsurface: TDXTexture);
    procedure DWudItemShowVisible(Sender: TObject; boVisible: Boolean);
    procedure DTopShopClick(Sender: TObject; X, Y: Integer);
    procedure DStateWinItemDirectPaint(Sender: TObject; dsurface: TDXTexture);
    procedure DSWWeaponDirectPaint(Sender: TObject; dsurface: TDXTexture);
    procedure DSWWeaponMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure DStateWinItemMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure DUserStateDirectPaint(Sender: TObject; dsurface: TDXTexture);
    procedure DWeaponUS1DirectPaint(Sender: TObject; dsurface: TDXTexture);
    procedure DWeaponUS1MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure DMerchantDlgDirectPaint(Sender: TObject; dsurface: TDXTexture);
    procedure DMerchantDlgMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure DMerchantDlgMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure DMerchantDlgClick(Sender: TObject; X, Y: Integer);
    procedure DMerchantDlgCloseClick(Sender: TObject; X, Y: Integer);
    procedure DWndBuyDirectPaint(Sender: TObject; dsurface: TDXTexture);
    procedure DBuyOKClick(Sender: TObject; X, Y: Integer);
    procedure DBuyAddClick(Sender: TObject; X, Y: Integer);
    procedure DBuyEditChange(Sender: TObject);
    procedure DWndBuyVisible(Sender: TObject; boVisible: Boolean);
    procedure DDealDlgDirectPaint(Sender: TObject; dsurface: TDXTexture);
    procedure DDRGridGridPaint(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState;
      dsurface: TDXTexture);
    procedure DDRGridGridMouseMove(Sender: TObject; X, Y: integer; ACol, ARow: Integer; Shift: TShiftState);
    procedure DDGridGridPaint(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState;
      dsurface: TDXTexture);
    procedure DDGridGridMouseMove(Sender: TObject; X, Y: integer; ACol, ARow: Integer; Shift: TShiftState);
    procedure DDGridGridSelect(Sender: TObject; X, Y: integer; ACol, ARow: Integer; Shift: TShiftState);
    procedure DDGoldClick(Sender: TObject; X, Y: Integer);
    procedure DDealCloseClick(Sender: TObject; X, Y: Integer);
    procedure DDealOkClick(Sender: TObject; X, Y: Integer);
    procedure DDealLockClick(Sender: TObject; X, Y: Integer);
    procedure DGroupDlgDirectPaint(Sender: TObject; dsurface: TDXTexture);
    procedure DCBGroupItemDefClick(Sender: TObject; X, Y: Integer);
    procedure DGrpAllowGroupClick(Sender: TObject; X, Y: Integer);
    procedure DGrpCheckGroupClick(Sender: TObject; X, Y: Integer);
    procedure DGrpMemberListDirectPaint(Sender: TObject; dsurface: TDXTexture);
    procedure DGroupDlgVisible(Sender: TObject; boVisible: Boolean);
    procedure DGrpCreateClick(Sender: TObject; X, Y: Integer);
    procedure DGrpAddMemClick(Sender: TObject; X, Y: Integer);
    procedure DGrpDelMemClick(Sender: TObject; X, Y: Integer);
    procedure DGroupExitClick(Sender: TObject; X, Y: Integer);
    procedure DGrpUserListDblClick(Sender: TObject);
    procedure DGrpMemberListDblClick(Sender: TObject);
    procedure DBotGuildClick(Sender: TObject; X, Y: Integer);
    procedure DBuyEditKeyPress(Sender: TObject; var Key: Char);
    procedure DBTCheck1DirectPaint(Sender: TObject; dsurface: TDXTexture);
    procedure DBotSortClick(Sender: TObject; X, Y: Integer);
    procedure DBTCheck1Click(Sender: TObject; X, Y: Integer);
    procedure DTopEMailClick(Sender: TObject; X, Y: Integer);
    procedure DTopEMailDirectPaint(Sender: TObject; dsurface: TDXTexture);
    procedure DPopUpEditsPopIndex(Sender, DControl: TDControl; ItemIndex: Integer; UserName: string);
    procedure DEditIDMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure DWndSayMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure DWndSayMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure DPopUpSayListPopIndex(Sender, DControl: TDControl; ItemIndex: Integer; UserName: string);
    procedure DGrpUserListMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure DGrpMemberListMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure DGroupDlgMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure DGrpMemberListMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure DGrpMemberListMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure DGrpUserListMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure DGrpUserListMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure DPopUpPlayPopIndex(Sender, DControl: TDControl; ItemIndex: Integer; UserName: string);
    procedure DSWWeaponMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure DStateWinItemMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure DItemBagMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure DStateWinDirectPaint(Sender: TObject; dsurface: TDXTexture);
    procedure DStateBTItemDirectPaint(Sender: TObject; dsurface: TDXTexture);
    procedure DStateBTItemClick(Sender: TObject; X, Y: Integer);
    procedure DStateGridGridPaint(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState;
      dsurface: TDXTexture);
    procedure DStateAbilAdd3DirectPaint(Sender: TObject; dsurface: TDXTexture);
    procedure DStateAbilExitClick(Sender: TObject; X, Y: Integer);
    procedure DStateAbilAdd1MouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure DStateAbilAdd1MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure DStateInfoNameChange(Sender: TObject);
    procedure DStateInfoExitClick(Sender: TObject; X, Y: Integer);
    procedure DStateInfoSaveClick(Sender: TObject; X, Y: Integer);
    procedure DStateInfoRefPicClick(Sender: TObject; X, Y: Integer);
    procedure DUserStateItemClick(Sender: TObject; X, Y: Integer);
    procedure DUserStateItemMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure DUserStateItemDirectPaint(Sender: TObject; dsurface: TDXTexture);
    procedure DUserStateBTItemClick(Sender: TObject; X, Y: Integer);
    procedure DUserStateBTInfoDirectPaint(Sender: TObject; dsurface: TDXTexture);
    procedure DUserStateVisible(Sender: TObject; boVisible: Boolean);
    procedure DItemAddBag1DirectPaint(Sender: TObject; dsurface: TDXTexture);
    procedure DItemAddBag1MouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure DItemAddBag1MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure DItemBagRefClick(Sender: TObject; X, Y: Integer);
    procedure DItemBagShopClick(Sender: TObject; X, Y: Integer);
    procedure DWndAttackModeListDirectPaint(Sender: TObject; dsurface: TDXTexture);
    procedure DBTAttackModeClick(Sender: TObject; X, Y: Integer);
    procedure DBTAttackModeGuildClick(Sender: TObject; X, Y: Integer);
    procedure DBTTakeHorseClick(Sender: TObject; X, Y: Integer);
    procedure DBTTakeHorseDirectPaint(Sender: TObject; dsurface: TDXTexture);
    procedure DItemBagMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure DMenuDlgDirectPaint(Sender: TObject; dsurface: TDXTexture);
    procedure DMenuDlgVisible(Sender: TObject; boVisible: Boolean);
    procedure DMenuShopDirectPaint(Sender: TObject; dsurface: TDXTexture);
    procedure DMenuShopClick(Sender: TObject; X, Y: Integer);
    procedure DMenuGridGridPaint(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState;
      dsurface: TDXTexture);
    procedure DMenuSellClick(Sender: TObject; X, Y: Integer);
    procedure DStateWinVisible(Sender: TObject; boVisible: Boolean);
    procedure DItemBagVisible(Sender: TObject; boVisible: Boolean);
    procedure DMenuGridGridMouseMove(Sender: TObject; X, Y: integer; ACol, ARow: Integer; Shift: TShiftState);
    procedure DMenuGridGridSelect(Sender: TObject; X, Y, ACol, ARow: Integer; Shift: TShiftState);
    procedure DBuyAddDirectPaint(Sender: TObject; dsurface: TDXTexture);
    procedure DMagicFrontClick(Sender: TObject; X, Y: Integer);
    procedure DStateGridGridSelect(Sender: TObject; X, Y, ACol, ARow: Integer; Shift: TShiftState);
    procedure DUserKeyGrid1GridPaint(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState;
      dsurface: TDXTexture);
    procedure DUserKeyGrid1GridSelect(Sender: TObject; X, Y, ACol, ARow: Integer; Shift: TShiftState);
    procedure DWudItemShowMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure DBottomEndDirectPaint(Sender: TObject; dsurface: TDXTexture);
    procedure DMagicBaseDirectPaint(Sender: TObject; dsurface: TDXTexture);
    procedure DMagicBaseClick(Sender: TObject; X, Y: Integer);
    procedure DMagicCBOSetupClick(Sender: TObject; X, Y: Integer);
    procedure DStateWinMagicVisible(Sender: TObject; boVisible: Boolean);
    procedure DStateWinMagicCboICODirectPaint(Sender: TObject; dsurface: TDXTexture);
    procedure DStateWinMagicCboICOInRealArea(Sender: TObject; X, Y: Integer; var IsRealArea: Boolean);
    procedure DStateWinMagicCboGridGridPaint(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState;
      dsurface: TDXTexture);
    procedure DStateWinMagicCboDirectPaint(Sender: TObject; dsurface: TDXTexture);
    procedure DStateWinMagicCboICOClick(Sender: TObject; X, Y: Integer);
    procedure DStateWinMagicCboGridGridSelect(Sender: TObject; X, Y, ACol, ARow: Integer; Shift: TShiftState);
    procedure DStateWinMagicCboOKClick(Sender: TObject; X, Y: Integer);
    procedure DStateWinMagicCboVisible(Sender: TObject; boVisible: Boolean);
    procedure DStateWinMagicCboGridGridMouseMove(Sender: TObject; X, Y, ACol, ARow: Integer; Shift: TShiftState);
    procedure DWndSayInRealArea(Sender: TObject; X, Y: Integer; var IsRealArea: Boolean);
    procedure DBtnSayAllDirectPaint(Sender: TObject; dsurface: TDXTexture);
    procedure DBtnSayAllClick(Sender: TObject; X, Y: Integer);
    procedure dchkSayLockChange(Sender: TObject);
    procedure dwndSayModeDirectPaint(Sender: TObject; dsurface: TDXTexture);
    procedure dbtnSayModeHearDirectPaint(Sender: TObject; dsurface: TDXTexture);
    procedure dbtnSayModeHearClick(Sender: TObject; X, Y: Integer);
    procedure DEditChatKeyPress(Sender: TObject; var Key: Char);
    procedure DEditChatVisible(Sender: TObject; boVisible: Boolean);
    procedure dwndWhisperNameDirectPaint(Sender: TObject; dsurface: TDXTexture);
    procedure dwndWhisperNameVisible(Sender: TObject; boVisible: Boolean);
    procedure DEditChatKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure DWndSayEndDirectPaint(Sender: TObject; dsurface: TDXTexture);
    procedure DUserKeyGrid1GridMouseMove(Sender: TObject; X, Y, ACol, ARow: Integer; Shift: TShiftState);
    procedure DUserKeyGrid2DblClick(Sender: TObject);
    procedure DBottom2MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure DBottom3MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure DBottom4MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure DTopCharStatusMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure DMiniMapFrameMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure DWinSelServerVisible(Sender: TObject; boVisible: Boolean);
    procedure DLoginNewClick(Sender: TObject; X, Y: Integer);
    procedure DTopHelpClick(Sender: TObject; X, Y: Integer);
    procedure DLoginHomeClick(Sender: TObject; X, Y: Integer);
    procedure DLoginChgPwClick(Sender: TObject; X, Y: Integer);
    procedure dbtnLoginLostPwClick(Sender: TObject; X, Y: Integer);
    procedure DTopGMClick(Sender: TObject; X, Y: Integer);
    procedure DMakeMagicAdd1Click(Sender: TObject; X, Y: Integer);
    procedure DButtonTopClick(Sender: TObject; X, Y: Integer);
    procedure DTopShopDirectPaint(Sender: TObject; dsurface: TDXTexture);
    procedure DccManWarriorDirectPaint(Sender: TObject; dsurface: TDXTexture);
    procedure DTopStatusEXPDirectPaint(Sender: TObject; dsurface: TDXTexture);
    procedure DTopStatusEXPMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure DUSHorseReinDirectPaint(Sender: TObject; dsurface: TDXTexture);
    procedure DUSHorseReinMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure dbtnSelServer1DirectPaint(Sender: TObject; dsurface: TDXTexture);
    procedure DCreateChrVisible(Sender: TObject; boVisible: Boolean);
    procedure DButRenewChrDirectPaint(Sender: TObject; dsurface: TDXTexture);
    procedure DBTHintCloseDirectPaint(Sender: TObject; dsurface: TDXTexture);
    procedure DTopHelpDirectPaint(Sender: TObject; dsurface: TDXTexture);
    procedure DBotAddAbilDirectPaint(Sender: TObject; dsurface: TDXTexture);
    procedure DBotMiniMapClick(Sender: TObject; X, Y: Integer);
    procedure DChatEnlargeClick(Sender: TObject; X, Y: Integer);
    procedure DMiniMapDirectPaint(Sender: TObject; dsurface: TDXTexture);
    procedure DMiniMapMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure DMiniMapMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure DMiniMapMouseEntry(Sender: TObject; MouseEntry: TMouseEntry);
    procedure DBottomMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure DBotWndSayDirectPaint(Sender: TObject; dsurface: TDXTexture);
    procedure DBotWndSayInRealArea(Sender: TObject; X, Y: Integer; var IsRealArea: Boolean);
    procedure DBotWndSayMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure DBotWndSayMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure DCloseSayHearDirectPaint(Sender: TObject; dsurface: TDXTexture);
    procedure DCloseSayHearClick(Sender: TObject; X, Y: Integer);
    procedure DCloseSayHearMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure DBTItemShowCloseDirectPaint(Sender: TObject; dsurface: TDXTexture);
    procedure DStateInfoRefPicDirectPaint(Sender: TObject; dsurface: TDXTexture);
    procedure DMagicFrontDirectPaint(Sender: TObject; dsurface: TDXTexture);
    procedure DMDlgUpDonwPositionChange(Sender: TObject);
    procedure DMDlgUpDonwEndDirectPaint(Sender: TObject; dsurface: TDXTexture);
    procedure DOpenCompoundItemClick(Sender: TObject; X, Y: Integer);
    procedure DOpenCompoundItemDirectPaint(Sender: TObject;
      dsurface: TDXTexture);
    procedure DItemBagRefDirectPaint(Sender: TObject; dsurface: TDXTexture);
    procedure DBottom4MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure DscSelect1DirectPaint(Sender: TObject; dsurface: TDXTexture);
    procedure DscCreateChrDirectPaint(Sender: TObject; dsurface: TDXTexture);
    procedure DscOKCloseChrDirectPaint(Sender: TObject; dsurface: TDXTexture);
    procedure DSaleDlgSpotDirectPaint(Sender: TObject; dsurface: TDXTexture);
    procedure DSaleDlgSellClick(Sender: TObject; X, Y: Integer);
    procedure DSaleDlgSpotMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure DSaleDlgDirectPaint(Sender: TObject; dsurface: TDXTexture);
    procedure DSaleDlgLockClick(Sender: TObject; X, Y: Integer);
    procedure DSaleDlgSpotClick(Sender: TObject; X, Y: Integer);
    procedure DSaleDlgCloseClick(Sender: TObject; X, Y: Integer);
    procedure DSubShopGridGridPaint(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState; dsurface: TDXTexture);
    procedure DSubShopDirectPaint(Sender: TObject; dsurface: TDXTexture);
    procedure DSubShopGridGridSelect(Sender: TObject; X, Y, ACol, ARow: Integer;
      Shift: TShiftState);
    procedure DSubShopGridGridMouseMove(Sender: TObject; X, Y, ACol,
      ARow: Integer; Shift: TShiftState);
    procedure DSubShopBuyClick(Sender: TObject; X, Y: Integer);
    procedure DGoldMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure DUserKeyGrid1GridRightSelect(Sender: TObject; X, Y, ACol,
      ARow: Integer; Shift: TShiftState);
  private
    //FCompoundItemBtnTick: LongWord;
    FCompoundItemBtnIndex: Integer;
    FMagicCboKeyIndex: Byte;
    procedure DSayMoveSize(Y: Integer);
  public
    //    SelServerIndex: Integer;
    //    MoveServerIndex: Integer;
        //WndHintBack: THintBack;
    m_nDiceCount: Integer;
    m_boPlayDice: Boolean;
    m_Dice: array[0..9] of TDiceInfo;

    HintBack: TSceneType;
    boHintFocus: Boolean;
    sHintStr: string;
    DlgEditText: string;
    DlgChecked: Boolean;
    YesResult: TModalResult;
    NoResult: TModalResult;
    msglx, msgly: Integer;
    //    ViewDlgEdit: Boolean;
    MsgText: string;
    btWuXin: Byte;
    btJob: Byte;
    btSex: Byte;
    btAniIndex: Integer;
    dwStartTime: LongWord;
    RenewChrIdx: Integer;
    m_dwBlinkTime: LongWord;
    m_boViewBlink: Boolean;
    TempList: TList;
    boMaxMinimapShow: Boolean;
    m_nMouseIdx: Integer;
    m_dwDblClick: LongWord;
    m_boRING: Boolean;
    m_boARMRING: Boolean;
    //m_MsgList: TStringList;
    //m_DMsgSurface: TDXTexture;
    BoGuildChat: Boolean;
    BoMakeDrugMenu: Boolean;
    //boShowDlg: Boolean;
    nShowDlgCount: Integer;
    FaceSelectindex: Integer;
    pClickName: pTClickName;
    nClickNameIndex: Integer;
    pClickItem: pTClickItem;
    nClickItemIndex: Integer;
    pClickIndex: Integer;
    HintDrawList: TList;
    boSelectGuildRankName: Boolean;
    boSelectGuildName: Boolean;
    //    boSelectUserName: Boolean;
    //    nUserNameLen: integer;
    nGuildNameLen: Integer;
    nGuildRankNameLen: Integer;
    nUS1UserNameLen: integer;
    nUS1GuildNameLen: Integer;
    nUS1GuildRankNameLen: Integer;
    UserState1: TClientStateInfo;
    MerchantName: string;
    MDlgStr: string;
    MDlgPoints: TList;
    //    MDlgNewPoints: TList;
    MDlgDraws: TList;
    MDlgRefTime: LongWord;
    RequireAddPoints: Boolean;
    MerchantHeight: Integer;
    //    SelectMenuStr: string;
        //    MoveMenuStr: string;
    MDlgMove: TClickPoint;
    MDlgSelect: TClickPoint;
    //    MDlgNewMoveRect: TRect;
    //    MDlgNewSelectRect: TRect;
    LastestClickTime: LongWord;
    SpotDlgMode: TSpotDlgMode;
    BuyGoods: TClientGoods;
    //    BuyIndex: Integer;
    GroupListIndex: Integer;
    GroupListMoveIndex: Integer;
    UserListIndex: Integer;
    UserListMoveIndex: Integer;
    RefGroupList: TStringList;
    GuildIndex: Integer;
    GuildName: string;
    StatePage: Integer;
    UserStatePage: Integer;
    boCheckShow: Boolean;
    boNewEMail: Boolean;
    SayDlgDown: Boolean;
    StateAbilIndex: Integer;
    AddressList: TStringList;
    TempAddressList: TStringList;
    NakedCount: Integer;
    NakedBackCount: Integer;
    NakedAbil: TNakedAbil;

    TempRealityInfo: TUserRealityInfo;
    MyHDInfoSurface: TDXImageTexture;
    UserHDInfoSurface: TDXImageTexture;
    //    MyHDDIB: TBitmap;
    //    UserHDDIB: TBitmap;
    boSuperRepair: Boolean;
    MDlgVisible: Boolean;
    boOpenItemBag: Boolean;
    boOpenStatus: Boolean;
    NpcBindGold: Boolean;
    NpcGoodsIdx: Byte;
    NpcGoodsList: TList;
    NpcGoodItems: array of TClientGoods;
    NpcReturnItemList: TList;
    NpcReturn: Boolean;
    NpcSubItems: array of TNewClientItem;
    MagicList1: TQuickStringList;
    MagicList2: TQuickStringList;
    MagicPage: Byte;
    MagicMaxPage: Byte;
    DMagicIndex: Byte;
    CboMagicList: TCboMagicListInfo;

    FShowItemEffectTick: LongWord;
    FShowItemEffectIndex: Integer;
    FSayNameIndex: Integer;
    FHelpTick: LongWord;
    NAHelps: TStringList;


    nShopSelectionIdx: integer;
    nSubShopSelectionIdx: integer;
    nSubShopIndex: integer;
    SellItem: TMovingItem;
    nSellMode: integer;
    LastSubListRequest: longword;
    nSubShopSelAniIndex: integer;
    SubShopAniTick: longword;

    procedure RefMenuSellBtns;
    procedure ClearReturnItemList();
    procedure ClearGoodsList();
    procedure RefGoodItems();
    procedure Initialize;
    procedure InitializeEx();
    function DMessageDlg(msgstr: string; DlgButtons: TMsgDlgButtons; MsgLen: Integer = 70; EClass:
      TDEditClass = deNone; defmsg: string = ''; boBottom: boolean = False): TModalResult;
    function DModalMessageDlg(nShowCount: Integer; msgstr: string; DlgButtons: TMsgDlgButtons; MsgLen: Integer = 70; EClass:
      TDEditClass = deNone; defmsg: string = ''; boBottom: boolean = False): TModalResult;
    procedure DModalDlgOkClick(Sender: TObject; X, Y: Integer);
    procedure DModalDlgKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure DModalDlgChange(Sender: TObject);
    procedure OpenItemBag;
    procedure OpenMyStatus;
    procedure OpenUserState(UserState: PTClientStateInfo);
    procedure RefItemPaint(dsurface, d: TDXTexture; X, Y, ax, ay: Integer; NewClientItem: pTNewClientItem;
      boCount: Boolean = True; PaintMode: TItemPaintMode = [pmNone]; pRect: PRect = nil);
    //procedure DealItemReturnBag(mitem: TNewClientItem);
    procedure DealZeroGold;
    procedure DropMovingItem;
    procedure DrawZoomDlg(DModalWindow: TDModalWindow);
    procedure CancelItemMoving;
    procedure OpenSayItemShow(mitem: TNewClientItem);
    procedure ShowMDlg(nResID, nWidth, nHeight: Integer; mname, msgstr: string);
    procedure CloseMDlg;
    function GetBuyCount(nQueryCount: Integer; ClientGoods: TClientGoods; boBindGold: Boolean): Integer;
    function GetBuyGoodsIndex(ClientGoods: TClientGoods): Integer;
    procedure OpenDealDlg;
    procedure CloseDealDlg;
    procedure SetGroupWnd();
    procedure CreateGroup(sChrName: string);
    procedure OpenPlayPopupMemu(AC: TObject; nX, nY: Integer);
    procedure PageChanged;
    procedure UserPageChanged;
    procedure LoadAddressList();
    procedure ClearAddressList();
    procedure RefNakedWindow();
    procedure RefRealityInfo();
    procedure RefPhotoSurface(FileName: string; var HDInfoSurface: TDXImageTexture);
    procedure RefAddBagWindow();
    procedure RefJobMagic(btJob: Byte);
    function UserKeyInfoIsValid(nIdx: Byte; var nIndex: Integer): Boolean;
    procedure RefCheckButtonXY();
    procedure RefStatusInfoForm();
    procedure SetMiniMapSize(flag: Byte);
    procedure SetChatSize(flag: Byte);
    procedure CloseSellWindow();
    procedure RemoveFromSublist(MakeIndex: integer);
  end;

var
  FrmDlg: TFrmDlg;
  sXML3: string = '2.';
  sXML6: string = 'P';

implementation

{$R *.dfm}

uses
  ClMain, Share, Actor, GameSetup, FState2, WMFile, cliUtil, Clipbrd, EDcodeEx, Jpeg, FState3, wil,
  MNSHare, LShare, ShellAPI, MD5Unit, FState4, FWeb, Registry, Bass;

const
  MDLGCLICKOX = 25;
  MDLGCHICKOY = 1;
  MDLGMOVEIMAGE = 622;
  MDLGCHICKIMAGE = 623;


const
  DMsgDefMaxLen = 180;
  DMsgDefLeft = 40;
  DMsgDefWidth = 260;
  DMsgDefTop = 28;
  DMsgDefHeigth = 102;

const
  DEFMERCHANTMAXHEIGHT = 140;
  DEFMERCHANTMAXWIDTH = 354;
  DEFMDLGMAXWIDTH = 354;
  MDLGMAXHEIGHT = 1024;

var
  g_MERCHANTMAXHEIGHT: Integer = DEFMERCHANTMAXHEIGHT;
  g_MERCHANTMAXWIDTH: Integer = DEFMERCHANTMAXWIDTH;

procedure TFrmDlg.CancelItemMoving;
var
  idx, n: Integer;
begin
  if g_boItemMoving then begin
    idx := g_MovingItem.Index2;
    if g_MovingItem.ItemType = mtStateItem then begin
      n := -(idx + 1);
      if n in [0..MAXUSEITEMS - 1] then begin
        g_UseItems[n] := g_MovingItem.Item;
      end else
      if n in [16..20] then begin
        if g_UseItems[U_HOUSE].S.Name <> '' then begin
          g_UseItems[U_HOUSE].UserItem.HorseItems[n - 16] := UserItemToHorseItem(@g_MovingItem.Item.UserItem);
        end;
      end;
    end
    else if g_MovingItem.ItemType = mtBagItem then begin
      AddItemBag(g_MovingItem.Item, idx);
    end;
    ArrangeItembag;
    ClearMovingItem();
  end;
end;

procedure TFrmDlg.DBackgroundBackgroundClick(Sender: TObject);
var
  dropgold: Integer;
  valstr: string;
begin
  if g_boItemMoving then begin
    DBackground.WantReturn := True;
    if (g_MovingItem.ItemType = mtBagGold) and (g_MovingItem.Item.S.name = g_sGoldName) {'金币'} then begin
      g_boItemMoving := FALSE;
      g_MovingItem.Item.S.name := '';
      if mrYes = DMessageDlg('Are you sure you want to discard ' + g_sGoldName + '?', [mbYes, mbNo, mbAbort], 10, deInteger) then begin
        GetValidStrVal(DlgEditText, valstr, [' ']);
        dropgold := StrToIntDef(valstr, 0);
        if dropgold > 0 then
          frmMain.SendDropGold(dropgold);
      end;
    end
    else if (g_MovingItem.ItemType = mtBagItem) then begin
      {if DDealDlg.Visible then begin
        if mrYes = DMessageDlg('是否确定丢弃[' + g_MovingItem.Item.S.name + ']?', [mbYes, mbNo]) then
          DropMovingItem;
      end else       }
      DropMovingItem;
    end
    else if (g_MovingItem.ItemType = mtStateMagic) or (g_MovingItem.ItemType = mtBottom) then begin
      g_boItemMoving := FALSE;
    end;
  end;
end;

procedure TFrmDlg.DBackgroundMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if g_boItemMoving then begin
    DBackground.WantReturn := True;
  end;
end;

procedure TFrmDlg.DBotAddAbilDirectPaint(Sender: TObject; dsurface: TDXTexture);
var
  d: TDXTexture;
begin
  with Sender as TDButton do begin
    if (g_nNakedCount = 0) and (g_nNakedBackCount = 0) then begin
      Visible := False;
      Exit;
    end;
    if WLib <> nil then begin
      if Downed then begin
        d := WLib.Images[FaceIndex + 1];
      end
      else begin
        if (((FrmMain.m_CurrentTick - AppendTick) mod 400) > 200) then begin
          d := WLib.Images[FaceIndex + 2];
        end else
          d := WLib.Images[FaceIndex];
      end;
      if d <> nil then
        dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, True);
    end;
  end;
end;

procedure TFrmDlg.DBotGuildClick(Sender: TObject; X, Y: Integer);
begin
  if FrmDlg3.DGuildDlg.Visible then begin
    FrmDlg3.DGuildDlg.Visible := FALSE;
  end
  else if FrmMain.m_CurrentTick > g_dwQueryMsgTick then begin
    g_dwQueryMsgTick := FrmMain.m_CurrentTick + 3000;
    //frmMain.SendGuildMemberList(g_GuildMemberIndex);
    frmMain.SendGuildDlg(g_GuildNoticeIndex);
  end;
end;

procedure TFrmDlg.DBotGuildDirectPaint(Sender: TObject;
  dsurface: TDXTexture);
var
  d: TDXTexture;
  idx: integer;
begin
if g_nInterface = 1 then begin
  with Sender as TDButton do begin
    if WLib <> nil then begin
      if Downed then begin
        d := WLib.Images[FaceIndex];
        if d <> nil then
          dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, True);
      end;
    end;
  end;
end
else if g_nInterface = 2 then begin
  with Sender as TDButton do begin
    if WLib <> nil then begin
      idx := 0;
      if Downed then begin
        inc(idx, 2)
      end
      else if MouseEntry = msIn then begin
        Inc(idx, 1)
      end;
      d := WLib.Images[FaceIndex + idx];
      if d <> nil then
        dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, True);
    end;
  end;
end;
end;

procedure TFrmDlg.DChatEnlargeClick(Sender: TObject; X, Y: Integer);
var
  d: TDXTexture;
  ax, ay, I: integer;
  rc: TRect;
  r: Extended;
  sStr: string;
//
  Enlarged: Boolean;
begin
  if g_nEnlargeChat = 1 then begin
     SetChatSize(0);
     g_nEnlargeChat := 0;
  end else begin
     SetChatSize(1);
     g_nEnlargeChat := 1;
  end;
end;

procedure TFrmDlg.DBotMiniMapClick(Sender: TObject; X, Y: Integer);
var
  d: TDXTexture;
begin
{  if FrmMain.m_CurrentTick < TDControl(Sender).AppendTick then begin
    Exit;
  end;
  TDControl(Sender).AppendTick := FrmMain.m_CurrentTick + 1000;  }

  if not DMiniMap.Visible then begin
    if g_nMiniMapIndex > 10000 then
      d := g_WUIBImages.Images[g_nMiniMapIndex - 10000]
    else if g_nMiniMapIndex >= 1000 then
      d := g_WMyMMapImages.Images[g_nMiniMapIndex - 1000]
    else
      d := g_WMMapImages.Images[g_nMiniMapIndex];
    if d = nil then begin
      DScreen.AddSysMsg('Map not available.', $32F4);
      Exit;
    end;
    g_nViewMinMapLv := 1;
    SetMiniMapSize(1);
    PrevVMMStyle := g_nViewMinMapLv;
  end
  else begin
    if g_nViewMinMapLv >= 2 then begin
      g_nViewMinMapLv := 0;
      SetMiniMapSize(g_nViewMinMapLv);
      PrevVMMStyle := g_nViewMinMapLv;
    end
    else begin
      Inc(g_nViewMinMapLv);
      SetMiniMapSize(g_nViewMinMapLv);
      PrevVMMStyle := g_nViewMinMapLv;
    end;
  end;
end;

procedure TFrmDlg.DMagicBaseClick(Sender: TObject; X, Y: Integer);
begin
  with Sender as TDButton do begin
    if DMagicIndex <> Tag then begin
      DMagicIndex := Tag;
      PlaySound(s_glass_button_click);
      if Tag <> 1 then
        DStateWinMagicCbo.Visible := False;
    end;
  end;
end;

procedure TFrmDlg.DMagicBaseDirectPaint(Sender: TObject; dsurface: TDXTexture);
var
  d: TDXTexture;
begin
  with Sender as TDButton do begin
    if WLib <> nil then begin
      if DMagicIndex <> tag then begin
        d := WLib.Images[FaceIndex + 1];
        if d <> nil then
          dsurface.Draw(SurfaceX(Left), SurfaceY(Top) + 2, d.ClientRect, d, True);
        with g_DXCanvas do begin
          TextOut(SurfaceX(Left) + (Width - TextWidth(Caption)) div 2, SurfaceY(Top) + (Height - TextHeight(Caption)) div 2 + 1, Caption, DFColor);
        end;
      end else begin
        d := WLib.Images[FaceIndex];
        if d <> nil then
          dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, True);
        with g_DXCanvas do begin
          TextOut(SurfaceX(Left) + (Width - TextWidth(Caption)) div 2, SurfaceY(Top) + (Height - TextHeight(Caption)) div 2, Caption, clWhite);
        end;
      end;
    end;
  end;
end;

procedure TFrmDlg.DMagicCBOSetupClick(Sender: TObject; X, Y: Integer);
begin
  DStateWinMagicCbo.Visible := not DStateWinMagicCbo.Visible;
end;

procedure TFrmDlg.DBotSortClick(Sender: TObject; X, Y: Integer);
{var
  ClientCheckMsg: pTClientCheckMsg;  }
{var
  GroupMember: pTGroupMember;
  i: Integer;    }
begin
  FrmDlg3.dwndMission.Visible := not FrmDlg3.dwndMission.Visible;
    //GMManageShow;
    {for I := 0 to 6 do begin
      New(GroupMember);
      GroupMember.isScreen := nil;
      GroupMember.ClientGroup.UserName := '测试号' + inttostr(i);
      GroupMember.ClientGroup.UserID := 1234;
      GroupMember.ClientGroup.WuXin := Random(5) + 1;
      GroupMember.ClientGroup.Level := Random(255);
      GroupMember.ClientGroup.HP := 255;
      GroupMember.ClientGroup.MP := 255;
      GroupMember.ClientGroup.Maxhp := 300;
      GroupMember.ClientGroup.MaxMP := 255;
      GroupMember.ClientGroup.btSex := Random(2);
      GroupMember.ClientGroup.btJob := Random(3);
      g_GroupMembers.Add(GroupMember);
    end;
    FrmDlg2.m_boChangeGroup := True;  }
    {New(ClientCheckMsg);
    ClientCheckMsg.str := '[测试人物] 想请你一起组队,是否同意?';
    ClientCheckMsg.EndTime := FrmMain.m_CurrentTick + 10 * 1000;
    ClientCheckMsg.MsgIndex := 0;
    ClientCheckMsg.MsgType := Random(2);
    g_QuestMsgList.Add(ClientCheckMsg);    }
    //FrmDlg2.DWndMakeItem.Visible := not FrmDlg2.DWndMakeItem.Visible;
    //DMessageDlg('该功能尚未正式开放！敬请期待！', []);
end;

//DMiniMapFrame

procedure TFrmDlg.DMiniMapFrameDirectPaint(Sender: TObject;
  dsurface: TDXTexture);
var
  d: TDXTexture;
  ax, ay: integer;
  sStr: string;
begin
  with Sender as TDWindow do begin
    ax := SurfaceX(Left);
    ay := SurfaceY(Top);
    d := WLib.Images[FaceIndex];
    if d <> nil then
      dsurface.Draw(ax, ay, d.ClientRect, d, True);

   with g_DXCanvas do begin
    //MapName + Coordonates
    if g_nViewMinMapLv = 0 then
    begin
      sStr := g_sMapTitle;   //mapname
      TextOut(945 - TextWidth(sStr) div 2, 4, clWhite, sStr);
      sStr := IntToStr(g_MySelf.m_nCurrX) + ':' + IntToStr(g_MySelf.m_nCurrY);    //Coords
      TextOut(948 - TextWidth(sStr) div 2, 27, clWhite, sStr);
    end;

    if g_nViewMinMapLv = 1 then
    begin
      sStr := g_sMapTitle;
      TextOut(945 - TextWidth(sStr) div 2, 4, clWhite, sStr);
      sStr := IntToStr(g_MySelf.m_nCurrX) + ':' + IntToStr(g_MySelf.m_nCurrY);
      TextOut(948 - TextWidth(sStr) div 2, 147, clWhite, sStr);
    end;

    if g_nViewMinMapLv = 2 then
    begin
      sStr := g_sMapTitle;
      TextOut(910 - TextWidth(sStr) div 2, 4, clWhite, sStr);
      sStr := IntToStr(g_MySelf.m_nCurrX) + ':' + IntToStr(g_MySelf.m_nCurrY);
      TextOut(910 - TextWidth(sStr) div 2, 227, clWhite, sStr);
    end;
  end;
  end;
end;

procedure TFrmDlg.DMiniMapFrameEndDirectPaint(Sender: TObject;
  dsurface: TDXTexture);
var
  d: TDXTexture;
begin
  with Sender as TDWindow do begin
    d := WLib.Images[29];
    if d <> nil then
      DSurface.Draw(SurfaceX(Left) + 68, SurfaceY(Top) + 10, d.ClientRect, d, True);
    
    //boCheckShow := (FrmMain.m_CurrentTick - DBottom2.AppendTick) mod 600 > 300;
  end;
end;

procedure TFrmDlg.DMiniMapFrameMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  {with Sender as TDWindow do begin
    x := x - left;
    y := y - top;
  end;
  if Sender = DBottom2 then begin
    with DUserKeyGrid2 do begin
      if (Button = mbRight) and (x >= Left) and (y >= Top) and (X <= Left + Width) and (y <= Top + Height) then begin
        DUserKeyGrid2DblClick(DUserKeyGrid2);
      end;
    end;
  end
  else if Sender = DBottom then begin
    with DUserKeyGrid1 do begin
      if (Button = mbRight) and (x >= Left) and (y >= Top) and (X <= Left + Width) and (y <= Top + Height) then begin
        DUserKeyGrid2DblClick(DUserKeyGrid1);
      end else
      if (x >= 208) and (y >= 230) and (X <= 208 + g_FScreenWidth - 436) and (y <= 230 + 16) then begin
        if not DEditChat.Visible then begin
          DEditChat.Visible := True;
          DEditChat.SetFocus;
          case g_SayMode of
            usm_Hear: DEditChat.Text := '';
            usm_Whisper: DEditChat.Text := '/';
            usm_Cry: DEditChat.Text := '!';
            usm_Group: DEditChat.Text := '!!';
            usm_Guild: DEditChat.Text := '!~';
            usm_World: DEditChat.Text := g_Cmd_AllMsg + ' ';
          end;
        end
        else
          DEditChat.SetFocus;
      end;
    end;
  end;    }  //ripman -> disable this after tests
end;

procedure TFrmDlg.DChatImgMiddleMiniLeftDirectPaint(Sender: TObject;
  dsurface: TDXTexture);
var
  d: TDXTexture;
  ax, ay, I, x: integer;
  rc: TRect;
  r: Extended;
  sStr: string;
begin
  with Sender as TDWindow do begin

    ax := SurfaceX(Left);
    ay := SurfaceY(Top);

    d := WLib.Images[FaceIndex];

    if d <> nil then begin

      dsurface.Draw(ax, ay, d.ClientRect, d, True);
      d := g_WUI3Images.Images[2933]; //middle chat images right
      rc := d.ClientRect;

      if g_nEnlargeChat = 0 then
      begin
        DSurface.Draw(SurfaceX(Left), SurfaceY(Top), rc, d, TRUE);
      end;

      if g_nEnlargeChat = 1 then
      begin
        for  i:=0 to 80 do DSurface.Draw(SurfaceX(Left), SurfaceY(Top)+20+i, rc, d, TRUE);
      end;
    end;
  end;
end;

procedure TFrmDlg.DChatImgMiddleMiniLeftEndDirectPaint(Sender: TObject;
  dsurface: TDXTexture);
var
  d: TDXTexture;
begin
  with Sender as TDWindow do begin
    d := WLib.Images[29];
    if d <> nil then
      DSurface.Draw(SurfaceX(Left) + 68, SurfaceY(Top) + 10, d.ClientRect, d, True);
  end;
end;

procedure TFrmDlg.DChatImgMiddleMiniRightDirectPaint(Sender: TObject;
  dsurface: TDXTexture);
var
  d: TDXTexture;
  ax, ay, I, x: integer;
  rc: TRect;
  r: Extended;
  sStr: string;
begin
  with Sender as TDWindow do begin

    ax := SurfaceX(Left);
    ay := SurfaceY(Top);

    d := WLib.Images[FaceIndex];

    if d <> nil then begin

      dsurface.Draw(ax, ay, d.ClientRect, d, True);
      d := g_WUI3Images.Images[2934]; //middle chat images right
      if d <> nil then begin
        rc := d.ClientRect;
        if g_nEnlargeChat = 0 then
        begin
          for  i:=0 to 5 do DSurface.Draw(SurfaceX(Left), SurfaceY(Top)-i, rc, d, TRUE);
        end;

        if g_nEnlargeChat = 1 then
        begin
          for  i:=0 to 84 do DSurface.Draw(SurfaceX(Left), SurfaceY(Top)-30+10+i, rc, d, TRUE);
        end;
      end;
    end;
  end;

end;

procedure TFrmDlg.DChatImgMiddleMiniRightEndDirectPaint(Sender: TObject;
  dsurface: TDXTexture);
var
  d: TDXTexture;
begin
  with Sender as TDWindow do begin
    d := WLib.Images[29];
    if d <> nil then
      DSurface.Draw(SurfaceX(Left) + 68, SurfaceY(Top) + 10, d.ClientRect, d, True);
  end;
end;


procedure TFrmDlg.DChatImgBgTopMiniDirectPaint(Sender: TObject;  //ripman
  dsurface: TDXTexture);
var
  d: TDXTexture;
  ax, ay, I, x: integer;
  rc: TRect;
  r: Extended;
  sStr: string;
begin
  with Sender as TDWindow do begin
    ax := SurfaceX(Left);
    ay := SurfaceY(Top);
    d := WLib.Images[FaceIndex];
    if d <> nil then
      dsurface.Draw(ax, ay, d.ClientRect, d, True);
      //Top Middle Line
      d := g_WUI3Images.Images[2931];
      if d <> nil then begin
        rc := d.ClientRect;
        for  i:=0 to 343 do DSurface.Draw(SurfaceX(Left) - 198 + i, SurfaceY(Top), rc, d, TRUE);
      end;
  end;
end;

procedure TFrmDlg.DChatImgBgTopMiniEndDirectPaint(Sender: TObject;
  dsurface: TDXTexture);
var
  d: TDXTexture;
begin
  with Sender as TDWindow do begin
    d := WLib.Images[29];
    if d <> nil then
      DSurface.Draw(SurfaceX(Left) + 68, SurfaceY(Top) + 10, d.ClientRect, d, True);
  end;
end;

procedure TFrmDlg.DChatImgBgBottomMiniDirectPaint(Sender: TObject;
  dsurface: TDXTexture);
var
  d: TDXTexture;
  ax, ay, I, x: integer;
  rc: TRect;
  r: Extended;
  sStr: string;
begin
  with Sender as TDWindow do begin
    ax := SurfaceX(Left);
    ay := SurfaceY(Top);
    d := WLib.Images[FaceIndex];
    if d <> nil then
      dsurface.Draw(ax, ay, d.ClientRect, d, True);

       //ripman9
      //DChatImgBgBottomMini
      d := g_WUI3Images.Images[2936];
      if d <> nil then begin

        rc := d.ClientRect;

        if g_nEnlargeChat = 0 then
          for  i:=0 to 320 do DSurface.Draw(SurfaceX(Left) - 180 + i, SurfaceY(Top), rc, d, TRUE);

        if g_nEnlargeChat = 1 then
          for  i:=0 to 320 do DSurface.Draw(SurfaceX(Left) - 180 + i, SurfaceY(Top) - 1, rc, d, TRUE);
      end;
  end;
end;

procedure TFrmDlg.DChatImgBgBottomMiniEndDirectPaint(Sender: TObject;
  dsurface: TDXTexture);
var
  d: TDXTexture;
begin
  with Sender as TDWindow do begin
    d := WLib.Images[29];
    if d <> nil then
      DSurface.Draw(SurfaceX(Left) + 68, SurfaceY(Top) + 10, d.ClientRect, d, True);
  end;
end;

procedure TFrmDlg.DTopCharAvatarDirectPaint(Sender: TObject;
  dsurface: TDXTexture);
var
  d: TDXTexture;
  ax, ay, avatar: integer;
begin
  with Sender as TDWindow do begin
    ax := SurfaceX(Left);
    ay := SurfaceY(Top);
    d := WLib.Images[FaceIndex];
    if d <> nil then
      dsurface.Draw(ax, ay, d.ClientRect, d, True);

    d := nil;

    if (g_MySelf.m_btJob = 0) and (g_MySelf.m_btSex = 0) then avatar := 2864;
    if (g_MySelf.m_btJob = 0) and (g_MySelf.m_btSex = 1) then avatar := 2869;
    if (g_MySelf.m_btJob = 1) and (g_MySelf.m_btSex = 0) then avatar := 2862;
    if (g_MySelf.m_btJob = 1) and (g_MySelf.m_btSex = 1) then avatar := 2867;
    if (g_MySelf.m_btJob = 2) and (g_MySelf.m_btSex = 0) then avatar := 2861;
    if (g_MySelf.m_btJob = 2) and (g_MySelf.m_btSex = 1) then avatar := 2866;
    if (g_MySelf.m_btJob = 3) and (g_MySelf.m_btSex = 0) then avatar := 2860;
    if (g_MySelf.m_btJob = 3) and (g_MySelf.m_btSex = 1) then avatar := 2865;
    if (g_MySelf.m_btJob = 4) and (g_MySelf.m_btSex = 0) then avatar := 2863;
    if (g_MySelf.m_btJob = 4) and (g_MySelf.m_btSex = 1) then avatar := 2868;

    DTopCharAvatar.SetImgIndex(g_WUI3Images, avatar);
    DTopCharAvatar.Left := 6;
    DTopCharAvatar.Top := 5;
  end;
end;

procedure TFrmDlg.DTopCharAvatarEndDirectPaint(Sender: TObject;
  dsurface: TDXTexture);
var
  d: TDXTexture;
begin
  with Sender as TDWindow do begin
    d := WLib.Images[29];
    if d <> nil then
      DSurface.Draw(SurfaceX(Left) + 68, SurfaceY(Top) + 10, d.ClientRect, d, True);
  end;
end;

//DTopCharStatus

procedure TFrmDlg.DTopCharStatusDirectPaint(Sender: TObject;
  dsurface: TDXTexture);
var
  d: TDXTexture;
  ax, ay, I, avatar: integer;
  rc: TRect;
  r: Extended;
  sStr: string;
begin
  with Sender as TDWindow do begin
    ax := SurfaceX(Left);
    ay := SurfaceY(Top);
    d := WLib.Images[FaceIndex];
    if d <> nil then
      dsurface.Draw(ax, ay, d.ClientRect, d, True);

    //d := nil;

    //if d <> nil then
    //  dsurface.Draw(g_FScreenWidth - 52, ay + 79, d.ClientRect, d, FALSE);
    if g_MySelf <> nil then begin
      if (g_MySelf.m_Abil.MaxHP > 0) and (g_MySelf.m_Abil.MaxMP > 0) then begin
        if (g_MySelf.m_btJob = 0) and (g_MySelf.m_Abil.Level < 26) then begin
          //MP Bar < Level 26
         d := g_WUI3Images.Images[2949];
         if d <> nil then begin
          rc := d.ClientRect;
          rc.Right := d.ClientRect.Right - 2;
          dsurface.Draw(68, ay + 44, rc, d, TRUE);
         end;

         //HP Bar for Warrior < Level 26
         d := g_WUI3Images.Images[2961];
         if d <> nil then begin
          rc := d.ClientRect;
          if g_MySelf.m_Abil.HP > 0 then r := g_MySelf.m_Abil.MaxHP / g_MySelf.m_Abil.HP else r := 0;
          if r > 0 then rc.Right := Round(rc.Right / r) else rc.Right := 0;
           rc.Right := _MIN(rc.Right, d.Width);
           dsurface.Draw(68, ay + 29, rc, d, TRUE);
          end;
          end else begin
           d := g_WUI3Images.Images[2961];
          if d <> nil then begin
          //HP bar
		      rc := d.ClientRect;
          if g_MySelf.m_Abil.HP > 0 then r := g_MySelf.m_Abil.MaxHP / g_MySelf.m_Abil.HP else r := 0;
          if r > 0 then rc.Right := Round(rc.Right / r) else rc.Right := 0;
           rc.Right := _MIN(rc.Right, d.Width);
           dsurface.Draw(68, ay + 29, rc, d, TRUE);
          end;

          d := g_WUI3Images.Images[2962];
          if d <> nil then begin
          // MP Bar
		      rc := d.ClientRect;
          if g_MySelf.m_Abil.HP > 0 then r := g_MySelf.m_Abil.MaxMP / g_MySelf.m_Abil.MP else r := 0;
          if r > 0 then rc.Right := Round(rc.Right / r) else rc.Right := 0;
           rc.Right := _MIN(rc.Right, d.Width);
           dsurface.Draw(68, ay + 44, rc, d, TRUE);
          end;
         end;
       end;
    end;

	  d := nil;

    with g_DXCanvas do begin
    //HP and MP on main screen
    sStr := IntToStr(g_MySelf.m_Abil.HP) + '/' + IntToStr(g_MySelf.m_Abil.MaxHP);
    TextOut(68 + 60 - TextWidth(sStr) div 2, ay + 26, clWhite, sStr);
    sStr := IntToStr(g_MySelf.m_Abil.MP) + '/' + IntToStr(g_MySelf.m_Abil.MaxMP);
    TextOut(68 + 60 - TextWidth(sStr) div 2, ay + 41, clWhite, sStr);
    //Level
    sStr := IntToStr(g_MySelf.m_Abil.Level);
    TextOut(68, ay + 5, clWhite, sStr);
    //Username
    sStr := g_MySelf.m_UserName;
    TextOut(143 - TextWidth(sStr) div 2, ay + 5, clWhite, sStr);
    end;
  end;
end;

procedure TFrmDlg.DTopCharStatusEndDirectPaint(Sender: TObject;
  dsurface: TDXTexture);
var
  d: TDXTexture;
begin
  with Sender as TDWindow do begin
    d := WLib.Images[29];
    if d <> nil then
      DSurface.Draw(SurfaceX(Left) + 68, SurfaceY(Top) + 10, d.ClientRect, d, True);

    //boCheckShow := (FrmMain.m_CurrentTick - DBottom2.AppendTick) mod 600 > 300;
  end;
end;

procedure TFrmDlg.DTopCharStatusMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  with Sender as TDWindow do begin
    x := x - left;
    y := y - top;
  end;
  if Sender = DBottom2 then begin
    with DUserKeyGrid2 do begin
      if (Button = mbRight) and (x >= Left) and (y >= Top) and (X <= Left + Width) and (y <= Top + Height) then begin
        DUserKeyGrid2DblClick(DUserKeyGrid2);
      end;
    end;
  end
  else if Sender = DBottom then begin
    with DUserKeyGrid1 do begin
      if (Button = mbRight) and (x >= Left) and (y >= Top) and (X <= Left + Width) and (y <= Top + Height) then begin
        DUserKeyGrid2DblClick(DUserKeyGrid1);
      end else
      if (x >= 208) and (y >= 230) and (X <= 208 + g_FScreenWidth - 436) and (y <= 230 + 16) then begin
        if not DEditChat.Visible then begin
          DEditChat.Visible := True;
          DEditChat.SetFocus;
          case g_SayMode of
            usm_Hear: DEditChat.Text := '';
            usm_Whisper: DEditChat.Text := '/';
            usm_Cry: DEditChat.Text := '!';
            usm_Group: DEditChat.Text := '!!';
            usm_Guild: DEditChat.Text := '!~';
            usm_World: DEditChat.Text := g_Cmd_AllMsg + ' ';
          end;
        end
        else
          DEditChat.SetFocus;
      end;
    end;
  end;
end;

//Bottom4

procedure TFrmDlg.DBottom4DirectPaint(Sender: TObject;
  dsurface: TDXTexture);
var
  d: TDXTexture;
  ax, ay, I, avatar: integer;
  rc: TRect;
  r: Extended;
  sStr: string;
begin
  with Sender as TDWindow do begin
    ax := SurfaceX(Left);
    ay := SurfaceY(Top);
    d := WLib.Images[FaceIndex];
    if d <> nil then
      dsurface.Draw(ax, ay, d.ClientRect, d, True);

    if (g_MySelf.m_Abil.MaxExp > 0) then begin
       d := g_WUI3Images.Images[2950];
       if d <> nil then begin
          //Experience Bar
          rc := d.ClientRect;
          if g_MySelf.m_Abil.Exp > 0 then r := g_MySelf.m_Abil.MaxExp / g_MySelf.m_Abil.Exp else r := 0;
          if r > 0 then rc.Right := Round(rc.Right / r) else rc.Right := 0;
          rc.Right := _MIN(rc.Right, d.Width);
          dsurface.Draw(g_FScreenWidth - 261, g_FScreenHeight - 12, rc, d, TRUE);
        end;
      end;

	  //with g_DXCanvas do begin
      //TextOut(g_FScreenWidth - 285, g_FScreenHeight - 10, clWhite, FormatDateTime('HH:MM:SS', g_ServerDateTime));       //ripman
      //sStr := 'Experience:' + IntToStr(g_MySelf.m_Abil.Exp) + '/' + IntToStr(g_MySelf.m_Abil.MaxExp);
      //TextOut(g_FScreenWidth - 265 - TextWidth(sStr) div 2, g_FScreenHeight - 15, clWhite, sStr);
	  //end;

  end;
end;

procedure TFrmDlg.DBottom4EndDirectPaint(Sender: TObject;
  dsurface: TDXTexture);
var
  d: TDXTexture;
begin
  with Sender as TDWindow do begin
    d := WLib.Images[29];
    if d <> nil then
      DSurface.Draw(SurfaceX(Left) + 68, SurfaceY(Top) + 10, d.ClientRect, d, True);
    
    //boCheckShow := (FrmMain.m_CurrentTick - DBottom2.AppendTick) mod 600 > 300;
  end;
end;

procedure TFrmDlg.DBottom4MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  with Sender as TDWindow do begin
    x := x - left;
    y := y - top;
  end;
  if Sender = DBottom2 then begin
    with DUserKeyGrid2 do begin
      if (Button = mbRight) and (x >= Left) and (y >= Top) and (X <= Left + Width) and (y <= Top + Height) then begin
        DUserKeyGrid2DblClick(DUserKeyGrid2);
      end;
    end;
  end
  else if Sender = DBottom then begin
    with DUserKeyGrid1 do begin
      if (Button = mbRight) and (x >= Left) and (y >= Top) and (X <= Left + Width) and (y <= Top + Height) then begin
        DUserKeyGrid2DblClick(DUserKeyGrid1);
      end else
      if (x >= 208) and (y >= 230) and (X <= 208 + g_FScreenWidth - 436) and (y <= 230 + 16) then begin
        if not DEditChat.Visible then begin
          DEditChat.Visible := True;
          DEditChat.SetFocus;
          case g_SayMode of
            usm_Hear: DEditChat.Text := '';
            usm_Whisper: DEditChat.Text := '/';
            usm_Cry: DEditChat.Text := '!';
            usm_Group: DEditChat.Text := '!!';
            usm_Guild: DEditChat.Text := '!~';
            usm_World: DEditChat.Text := g_Cmd_AllMsg + ' ';
          end;
        end
        else
          DEditChat.SetFocus;
      end;
    end;
  end;
end;

procedure TFrmDlg.DBottom4MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var
  ShowMsg: string;
  nLeft: Integer;
  fPercentage: Float;
  sPercentage: String;
begin
pClickName := nil;
  pClickItem := nil;
  nClickNameIndex := 0;
  nClickItemIndex := 0;
  if g_MySelf = nil then Exit;
  Dec(Y, DBottom.Top);
  Dec(X, DBottom.Left);
  ShowMsg := '';
  nLeft := g_FScreenWidth - 265;
  if (x >= nLeft) and (x <= nLeft + 250) and (y <= 115) and (y >= 107) then begin
    x := g_FScreenWidth - 215;
    Y := 786;
  fPercentage := g_MySelf.m_Abil.Exp / g_MySelf.m_Abil.MaxExp * 100;
  if fPercentage < 1 then sPercentage := '0' + FormatFloat('#.##', fPercentage) else sPercentage := FormatFloat('#.##', fPercentage);
      ShowMsg := 'Experience:' + IntToStr(g_MySelf.m_Abil.Exp) + '/' + IntToStr(g_MySelf.m_Abil.MaxExp) + ' (' + sPercentage + '%)';
  end;
    if ShowMsg <> '' then
      DScreen.ShowHint(DBottom.SurfaceX(DBottom.Left + X), DBottom.SurfaceY(DBottom.Top + Y), ShowMsg, clWhite, False, Integer(Sender));
end;

//Bottom3

procedure TFrmDlg.DBottom3DirectPaint(Sender: TObject;
  dsurface: TDXTexture);
var
  d: TDXTexture;
  ax, ay, I, x: integer;
  rc: TRect;
  r: Extended;
  sStr: string;
begin
  with Sender as TDWindow do begin
    ax := SurfaceX(Left);
    ay := SurfaceY(Top);
    d := WLib.Images[FaceIndex];
    if d <> nil then
      dsurface.Draw(ax, ay, d.ClientRect, d, True);

      if g_nEnlargeChat = 0 then
      begin
        DBottom3.Top := g_FScreenHeight - d.Height  - 89;
      end;

      if g_nEnlargeChat = 1 then
      begin
        DBottom3.Top := g_FScreenHeight - d.Height  - 150;
      end;

  end;
end;

procedure TFrmDlg.DBottom3EndDirectPaint(Sender: TObject;
  dsurface: TDXTexture);
var
  d: TDXTexture;
begin
  with Sender as TDWindow do begin
    d := WLib.Images[29];
    if d <> nil then
      DSurface.Draw(SurfaceX(Left) + 68, SurfaceY(Top) + 10, d.ClientRect, d, True);
    //boCheckShow := (FrmMain.m_CurrentTick - DBottom2.AppendTick) mod 600 > 300;
  end;
end;

procedure TFrmDlg.DBottom3MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  with Sender as TDWindow do begin
    x := x - left;
    y := y - top;
  end;
  if Sender = DBottom2 then begin
    with DUserKeyGrid2 do begin
      if (Button = mbRight) and (x >= Left) and (y >= Top) and (X <= Left + Width) and (y <= Top + Height) then begin
        DUserKeyGrid2DblClick(DUserKeyGrid2);
      end;
    end;
  end
  else if Sender = DBottom then begin
    with DUserKeyGrid1 do begin
      if (Button = mbRight) and (x >= Left) and (y >= Top) and (X <= Left + Width) and (y <= Top + Height) then begin
        DUserKeyGrid2DblClick(DUserKeyGrid1);
      end else
      if (x >= 208) and (y >= 230) and (X <= 208 + g_FScreenWidth - 436) and (y <= 230 + 16) then begin
        if not DEditChat.Visible then begin
          DEditChat.Visible := True;
          DEditChat.SetFocus;
          case g_SayMode of
            usm_Hear: DEditChat.Text := '';
            usm_Whisper: DEditChat.Text := '/';
            usm_Cry: DEditChat.Text := '!';
            usm_Group: DEditChat.Text := '!!';
            usm_Guild: DEditChat.Text := '!~';
            usm_World: DEditChat.Text := g_Cmd_AllMsg + ' ';
          end;
        end
        else
          DEditChat.SetFocus;
      end;
    end;
  end;
end;

//Bottom2

procedure TFrmDlg.DBottom2DirectPaint(Sender: TObject;
  dsurface: TDXTexture);
var
  d: TDXTexture;
  ax, ay, I: integer;
  rc: TRect;
  r: Extended;
  sStr: string;
begin
  with Sender as TDWindow do begin
    ax := SurfaceX(Left);
    ay := SurfaceY(Top);
    d := WLib.Images[FaceIndex];
    if d <> nil then
      dsurface.Draw(ax, ay, d.ClientRect, d, True);

if g_nInterface = 2 then begin

      if g_nEnlargeChat = 0 then
      begin

       //Side scroll bar
        if DSayUpDown.DParent <> nil then DSayUpDown.DParent.DelChild(DSayUpDown);
        DSayUpDown.DParent := DBottom3;
        DBottom3.AddChild(DSayUpDown);

        DSayUpDown.SetImgIndex(g_WUI3Images, 920);
        DSayUpDown.Top := 20;
        DSayUpDown.Left := 380;
        DSayUpDown.Height := 87;

        DSayUpDown.UpButton.SetImgIndex(g_WUI3Images, 921);
        DSayUpDown.DownButton.SetImgIndex(g_WUI3Images, 924);
        DSayUpDown.MoveButton.SetImgIndex(g_WUI3Images, 937);

        //Scroll bar background top and down

        DScrollBgTopMini.SetImgIndex(g_WUI3Images, 2932);
        DScrollBgTopMini.Left := 365;
        DScrollBgTopMini.Top := 19;

        DScrollBgBottomMini.SetImgIndex(g_WUI3Images, 2937);
        DScrollBgBottomMini.Left := 365;
        DScrollBgBottomMini.Top := 80;

        DScrollBgMiddleMini.SetImgIndex(g_WUI3Images, 2934);  //Only when you extend the chat bar
        DScrollBgMiddleMini.Left := 365;
        DScrollBgMiddleMini.Top := 50;

        DScrollBgBottomMini.SetImgIndex(g_WUI3Images, 2937);
        DScrollBgBottomMini.Left := 365;
        DScrollBgBottomMini.Top := 80;

        DChatImgBgLeftTopMini.SetImgIndex(g_WUI3Images, 2930);
        DChatImgBgLeftTopMini.Left := 0;
        DChatImgBgLeftTopMini.Top := 20;
        DChatImgBgLeftTopMini.Visible := True;

        DChatImgBgLeftBottomMini.SetImgIndex(g_WUI3Images, 2935);
        DChatImgBgLeftBottomMini.Left := 0;
        DChatImgBgLeftBottomMini.Top := 80;

        DChatImgBgLeftMidleMini.SetImgIndex(g_WUI3Images, 2933);
        DChatImgBgLeftMidleMini.Left := 0;
        DChatImgBgLeftMidleMini.Top := 50;

        DChatImgBgTopMini.SetImgIndex(g_WUI3Images, 2931);
        DChatImgBgTopMini.Left := 200;
        DChatImgBgTopMini.Top := 19;
        DChatImgBgTopMini.Width := 350;
        DChatImgBgTopMini.Visible := True;

        DChatImgBgBottomMini.SetImgIndex(g_WUI3Images, 2936);
        DChatImgBgBottomMini.Left := 200;
        DChatImgBgBottomMini.Top := 80;
        DChatImgBgBottomMini.Width := 350;
        DChatImgBgBottomMini.Visible := True;

        // Where you write
        DEditChat.Left := 3;
        DEditChat.Top := 89;
        DEditChat.Height := 15;
        DEditChat.Width := 373;
        DEditChat.MaxLength := 125;
        DEditChat.boTransparent := False;
        if DEditChat.DParent <> nil then DEditChat.DParent.DelChild(DEditChat);
        DEditChat.DParent := DBottom3;
        DBottom3.AddChild(DEditChat);

        // Chat box
        DBotWndSay.Left := 3;
        DBotWndSay.Top := 22;
        // DBotWndSay.Width := 330;
        DBotWndSay.Height := 65;
        DBotWndSay.Visible := True;
        if DBotWndSay.DParent <> nil then DBotWndSay.DParent.DelChild(DBotWndSay);
        DBotWndSay.DParent := DBottom3;
        DBottom3.AddChild(DBotWndSay);
      end;
      if g_nEnlargeChat = 1 then
      begin
        //Side scroll bar
        DSayUpDown.SetImgIndex(g_WUI3Images, 920);
        DSayUpDown.Top := 20;
        DSayUpDown.Left := 380;
        DSayUpDown.Height := 148;
        if DSayUpDown.DParent <> nil then DSayUpDown.DParent.DelChild(DSayUpDown);
        DSayUpDown.DParent := DBottom3;
        DBottom3.AddChild(DSayUpDown);

        DSayUpDown.UpButton.SetImgIndex(g_WUI3Images, 921);
        DSayUpDown.DownButton.SetImgIndex(g_WUI3Images, 924);
        DSayUpDown.MoveButton.SetImgIndex(g_WUI3Images, 937);

        //Scroll bar background top and down
        DScrollBgTopMini.SetImgIndex(g_WUI3Images, 2932);
        DScrollBgTopMini.Left := 365;
        DScrollBgTopMini.Top := 19;

        DScrollBgBottomMini.SetImgIndex(g_WUI3Images, 2937);
        DScrollBgBottomMini.Left := 365;
        DScrollBgBottomMini.Top := 141;

        DScrollBgMiddleMini.SetImgIndex(g_WUI3Images, 2934);  //Only when you extend the chat bar
        DScrollBgMiddleMini.Left := 365;
        DScrollBgMiddleMini.Top := 50;

        DChatImgBgLeftTopMini.SetImgIndex(g_WUI3Images, 2930);
        DChatImgBgLeftTopMini.Left := 0;
        DChatImgBgLeftTopMini.Top := 20;
        DChatImgBgLeftTopMini.Visible := True;

        DChatImgBgLeftBottomMini.SetImgIndex(g_WUI3Images, 2935);
        DChatImgBgLeftBottomMini.Left := 0;
        DChatImgBgLeftBottomMini.Top := 141;
        if DChatImgBgLeftBottomMini.DParent <> nil then DChatImgBgLeftBottomMini.DParent.DelChild(DChatImgBgLeftBottomMini);
        DChatImgBgLeftBottomMini.DParent := DBottom3;
        DBottom3.AddChild(DChatImgBgLeftBottomMini);

        DChatImgBgLeftMidleMini.SetImgIndex(g_WUI3Images, 2933);
        DChatImgBgLeftMidleMini.Left := 0;
        DChatImgBgLeftMidleMini.Top := 50;

        DChatImgBgTopMini.SetImgIndex(g_WUI3Images, 2931);
        DChatImgBgTopMini.Left := 200;
        DChatImgBgTopMini.Top := 19;
        DChatImgBgTopMini.Width := 350;
        DChatImgBgTopMini.Visible := True;
        if DChatImgBgTopMini.DParent <> nil then DChatImgBgTopMini.DParent.DelChild(DChatImgBgTopMini);
        DChatImgBgTopMini.DParent := DBottom3;
        DBottom3.AddChild(DChatImgBgTopMini);

        DChatImgBgBottomMini.SetImgIndex(g_WUI3Images, 2936);
        DChatImgBgBottomMini.Left := 200;
        DChatImgBgBottomMini.Top := 142;
        DChatImgBgBottomMini.Width := 350;
        DChatImgBgBottomMini.Visible := True;
        if DChatImgBgTopMini.DParent <> nil then DChatImgBgTopMini.DParent.DelChild(DChatImgBgTopMini);
        DChatImgBgTopMini.DParent := DBottom3;
        DBottom3.AddChild(DChatImgBgTopMini);

        // Where you write
        DEditChat.Left := 3;
        DEditChat.Top := 151;
        DEditChat.Height := 15;
        DEditChat.Width := 373;
        DEditChat.MaxLength := 125;
        DEditChat.boTransparent := False;
        if DEditChat.DParent <> nil then DEditChat.DParent.DelChild(DEditChat);
        DEditChat.DParent := DBottom3;
        DBottom3.AddChild(DEditChat);

        // Chat box
        DBotWndSay.Left := 3;
        DBotWndSay.Top := 22;
        // DBotWndSay.Width := 330;
        DBotWndSay.Height := 130;
        DBotWndSay.Visible := True;
        if DBotWndSay.DParent <> nil then DBotWndSay.DParent.DelChild(DBotWndSay);
        DBotWndSay.DParent := DBottom3;
        DBottom3.AddChild(DBotWndSay);
      end;
    end;
  end;
end;

procedure TFrmDlg.DBottom2EndDirectPaint(Sender: TObject;
  dsurface: TDXTexture);
var
  d: TDXTexture;
begin
  with Sender as TDWindow do begin
    d := WLib.Images[29];
    if d <> nil then
      DSurface.Draw(SurfaceX(Left) + 68, SurfaceY(Top) + 10, d.ClientRect, d, True);

    //boCheckShow := (FrmMain.m_CurrentTick - DBottom2.AppendTick) mod 600 > 300;
  end;
end;

procedure TFrmDlg.DBottom2MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  with Sender as TDWindow do begin
    x := x - left;
    y := y - top;
  end;
  if Sender = DBottom2 then begin
    with DUserKeyGrid2 do begin
      if (Button = mbRight) and (x >= Left) and (y >= Top) and (X <= Left + Width) and (y <= Top + Height) then begin
//        DUserKeyGrid2DblClick(DUserKeyGrid2);
      end;
    end;
  end
  else if Sender = DBottom then begin
    with DUserKeyGrid1 do begin
      if (Button = mbRight) and (x >= Left) and (y >= Top) and (X <= Left + Width) and (y <= Top + Height) then begin
//        DUserKeyGrid2DblClick(DUserKeyGrid1);
      end else
      if (x >= 208) and (y >= 230) and (X <= 208 + g_FScreenWidth - 436) and (y <= 230 + 16) then begin
        if not DEditChat.Visible then begin
          DEditChat.Visible := True;
          DEditChat.SetFocus;
          case g_SayMode of
            usm_Hear: DEditChat.Text := '';
            usm_Whisper: DEditChat.Text := '/';
            usm_Cry: DEditChat.Text := '!';
            usm_Group: DEditChat.Text := '!!';
            usm_Guild: DEditChat.Text := '!~';
            usm_World: DEditChat.Text := g_Cmd_AllMsg + ' ';
          end;
        end
        else
          DEditChat.SetFocus;
      end;
    end;
  end;
end;

procedure TFrmDlg.DBottomDirectPaint(Sender: TObject;
  dsurface: TDXTexture);
const
  AttackModeName: array[0..6] of string[14] = ('Attack All', 'Peaceful', 'Marriage', 'Mentor', 'Group', 'Guild', 'Red And White');
var
  d: TDXTexture;
  ax, ay: integer;
  rc: TRect;
  r: Extended;
  sStr: string;
  I: Integer;
begin
  with Sender as TDWindow do begin
    ax := SurfaceX(Left);
    ay := SurfaceY(Top);
    d := WLib.Images[FaceIndex];
    if d <> nil then
      dsurface.Draw(ax, ay, d.ClientRect, d, True);

if g_nInterface = 1 then begin
    if FrmMain.m_CurrentTick > AppendTick then begin
      AppendTick := FrmMain.m_CurrentTick + 2000;
      boNewEMail := False;
      for I := 0 to g_EMailList.Count - 1 do begin
        if not pTEMailInfo(g_EMailList.Objects[i]).ClientEMail.boRead then begin
          boNewEMail := True;
          break;
        end;
      end;
    end;
    //QuickSlot 1-6 Text
    d := g_WMain99Images.Images[1822];//1
    if d <> nil then
      if g_FScreenWidth = DEFMAXSCREENWIDTH then
        dsurface.Draw(385+47, ay + 79, d.ClientRect, d, True)
      else
        dsurface.Draw(283+36, ay + 79, d.ClientRect, d, True);
    d := g_WMain99Images.Images[1823];//2
    if d <> nil then
      if g_FScreenWidth = DEFMAXSCREENWIDTH then
        dsurface.Draw(428+37, ay + 79, d.ClientRect, d, True)
      else
        dsurface.Draw(326+26, ay + 79, d.ClientRect, d, True);
    d := g_WMain99Images.Images[1824];//3
    if d <> nil then
      if g_FScreenWidth = DEFMAXSCREENWIDTH then
        dsurface.Draw(472+30, ay + 79, d.ClientRect, d, True)
      else
        dsurface.Draw(370+18, ay + 79, d.ClientRect, d, True);
    d := g_WMain99Images.Images[1825];//4
    if d <> nil then
      if g_FScreenWidth = DEFMAXSCREENWIDTH then
        dsurface.Draw(516+20, ay + 79, d.ClientRect, d, True)
      else
        dsurface.Draw(414+9, ay + 79, d.ClientRect, d, True);
    d := g_WMain99Images.Images[1826];//5
    if d <> nil then
      if g_FScreenWidth = DEFMAXSCREENWIDTH then
        dsurface.Draw(559+12, ay + 79, d.ClientRect, d, True)
      else
        dsurface.Draw(457, ay + 79, d.ClientRect, d, True);
    d := g_WMain99Images.Images[1827];//6
    if d <> nil then
      if g_FScreenWidth = DEFMAXSCREENWIDTH then
        dsurface.Draw(604+4, ay + 79, d.ClientRect, d, True)
      else
        dsurface.Draw(502-8, ay + 79, d.ClientRect, d, True);


   { case HourOf(g_ServerDateTime) of
      0..6: d := g_WMain99Images.Images[1862]; //早上
      7..11: d := g_WMain99Images.Images[1859]; //白天
      12..18: d := g_WMain99Images.Images[1860]; //傍晚
      19..23: d := g_WMain99Images.Images[1861]; //晚上
    end;
    if d <> nil then
      dsurface.Draw(g_FScreenWidth - 52, ay + 79, d.ClientRect, d, FALSE);
    }
    if g_MySelf <> nil then begin
      if (g_MySelf.m_Abil.MaxHP > 0) and (g_MySelf.m_Abil.MaxMP > 0) then begin
      //Draw HP for Warrior under 26
        if (g_MySelf.m_btJob = 0) and (g_MySelf.m_Abil.Level < 26) then begin
          d := g_WUI3Images.Images[470];
          if d <> nil then begin
            rc := d.ClientRect;
            rc.Right := d.ClientRect.Right - 2;
            rc.Top := Round(rc.Bottom / g_MySelf.m_Abil.MaxHP * (g_MySelf.m_Abil.MaxHP - g_MySelf.m_Abil.HP));
            dsurface.Draw(47, ay + 85 + rc.Top, rc, d, TRUE);
          end;
        end else begin
        //Draw HP/MP Split bar
        if (g_MySelf.m_btJob > 0) or (g_MySelf.m_Abil.Level > 25) then begin
          d := g_WMain99Images.Images[14];
          if d <> nil then begin
            rc := d.ClientRect;
            rc.Right := d.ClientRect.Right - 2;
            dsurface.Draw(47{38}, ay + 85{90}, rc, d, TRUE);
          end;
        end;
        //HP bar
        d := g_WMain99Images.Images[12];
          if d <> nil then begin
		      rc := d.ClientRect;
          if g_MySelf.m_Abil.HP > 0 then r := g_MySelf.m_Abil.MaxHP / g_MySelf.m_Abil.HP else r := 0;
          if r > 0 then rc.Top := Round(rc.Top / r) else rc.Top := 0;
           rc.Top := Round(rc.Bottom / g_MySelf.m_Abil.MaxHP * (g_MySelf.m_Abil.MaxHP - g_MySelf.m_Abil.HP));
           dsurface.Draw(47{40}, ay + 86{91} + rc.Top, rc, d, TRUE);
          end;
        //MP Bar
        d := g_WMain99Images.Images[13];
          if d <> nil then begin
		      rc := d.ClientRect;
          if g_MySelf.m_Abil.HP > 0 then r := g_MySelf.m_Abil.MaxMP / g_MySelf.m_Abil.MP else r := 0;
           if r > 0 then rc.Top := Round(rc.Top / r) else rc.Top := 0;
           rc.Top := Round(rc.Bottom / g_MySelf.m_Abil.MaxMP * (g_MySelf.m_Abil.MaxMP - g_MySelf.m_Abil.MP));
           dsurface.Draw(47 + rc.Left, ay + 86 + rc.Top, rc, d, TRUE);
          end;
        end;
      end;

      if (g_MySelf.m_Abil.MaxExp > 0) then begin
        d := g_WMain99Images.Images[1866];
        if d <> nil then begin
          //EXP
          rc := d.ClientRect;
          if g_MySelf.m_Abil.Exp > 0 then
            r := g_MySelf.m_Abil.MaxExp / g_MySelf.m_Abil.Exp
          else
            r := 0;
          if r > 0 then
            rc.Right := Round(rc.Right / r)
          else
            rc.Right := 0;
          rc.Right := _MIN(rc.Right, d.Width);
          dsurface.Draw(g_FScreenWidth - 135, g_FScreenHeight - 73, rc, d, TRUE);

          //Bag Weight
          rc := d.ClientRect;
          if g_MySelf.m_Abil.MaxWeight > 0 then
            r := g_MySelf.m_Abil.MaxWeight / g_MySelf.m_Abil.Weight
          else
            r := 0;
          if r >0 then
            rc.Right := Round(rc.Right / r)
          else
            rc.Right := 0;
          rc.Right := _MIN(rc.Right, d.Width);
          dsurface.Draw(g_FScreenWidth - 135, g_FScreenHeight - 48, rc, d, TRUE);
        end;
      end;

    end;
    d := nil;
    case g_nAreaStateValue of
      OT_SAFEAREA: d := g_WMain99Images.Images[1868];
      OT_SAFEPK: d := g_WMain99Images.Images[1867];
      OT_FREEPKAREA: d := g_WMain99Images.Images[1867];
    end;
    if d <> nil then
      dsurface.Draw(0, 0, d.ClientRect, d, False);

    with g_DXCanvas do begin
      if DBTAttackMode.Tag in [Low(AttackModeName)..High(AttackModeName)] then
        TextOut(ax + g_FScreenWidth - 111{152}, ay + 151{113}, clWhite, AttackModeName[DBTAttackMode.Tag]);

     TextOut(ax + g_FScreenWidth - 128, ay + 224, clWhite, FormatDateTime('HH:MM:SS', g_ServerDateTime));
      sStr := IntToStr(g_MySelf.m_Abil.HP) + '/' + IntToStr(g_MySelf.m_Abil.MaxHP);
      TextOut(ax + 56 - TextWidth(sStr) div 2, ay + 211, clWhite, sStr);
      sStr := IntToStr(g_MySelf.m_Abil.MP) + '/' + IntToStr(g_MySelf.m_Abil.MaxMP); 
      TextOut(ax + 118 - TextWidth(sStr) div 2, ay + 211, clWhite, sStr);
      sStr := IntToStr(g_MySelf.m_Abil.Level);
      TextOut(ax + g_FScreenWidth - 129 - TextWidth(sStr) div 2, ay + 146, clWhite, sStr);
      TextOut(8, g_FScreenHeight - 18, clWhite, g_sMapTitle + ' ' + IntToStr(g_MySelf.m_nCurrX) + ':' + IntToStr(g_MySelf.m_nCurrY));
    end;
end
else if g_nInterface = 2 then begin
    if FrmMain.m_CurrentTick > AppendTick then begin
      AppendTick := FrmMain.m_CurrentTick + 2000;
      boNewEMail := False;
      for I := 0 to g_EMailList.Count - 1 do begin
        if not pTEMailInfo(g_EMailList.Objects[i]).ClientEMail.boRead then begin
          boNewEMail := True;
          break;
        end;
      end;
    end;
    //QuickSlot 1-6 Text        //ripman
    d := g_WUI3Images.Images[351];//1
    if d <> nil then
        dsurface.Draw(72,    ay + 87, d.ClientRect, d, True);

    d := g_WUI3Images.Images[352];//2
    if d <> nil then
        dsurface.Draw(72+34, ay + 87, d.ClientRect, d, True);

    d := g_WUI3Images.Images[353];//3
    if d <> nil then
        dsurface.Draw(72+70, ay + 87, d.ClientRect, d, True);

    d := g_WUI3Images.Images[354];//4
    if d <> nil then
        dsurface.Draw(72+105, ay + 87, d.ClientRect, d, True);

    d := g_WUI3Images.Images[355];//5
    if d <> nil then
        dsurface.Draw(72+140, ay + 87, d.ClientRect, d, True);

    d := g_WUI3Images.Images[356];//6
    if d <> nil then
        dsurface.Draw(72+176, ay + 87, d.ClientRect, d, True);

    d := nil;

      if (g_MySelf.m_Abil.Weight > 0) then begin     
        d := g_WUI3Images.Images[2950];
        if d <> nil then begin
          //Weight Bar
          rc := d.ClientRect;
          if g_MySelf.m_Abil.Weight > 0 then r := g_MySelf.m_Abil.MaxWeight / g_MySelf.m_Abil.Weight else r := 0;
          if r > 0 then rc.Right := Round(rc.Right / r) else rc.Right := 0;
          rc.Right := _MIN(rc.Right, d.Width);
          dsurface.Draw(39, g_FScreenHeight - 12, rc, d, TRUE);
         end;
      end;
    end;
    d := nil;
    case g_nAreaStateValue of
      OT_SAFEAREA: d := g_WMain99Images.Images[1868];
      OT_SAFEPK: d := g_WMain99Images.Images[1867];
      OT_FREEPKAREA: d := g_WMain99Images.Images[1867];
    end;
    if d <> nil then
      dsurface.Draw(0, 0, d.ClientRect, d, False);

   { with g_DXCanvas do begin
      if DBTAttackMode.Tag in [Low(AttackModeName)..High(AttackModeName)] then
        TextOut(g_FScreenWidth - 285, g_FScreenHeight - 10, clWhite, AttackModeName[DBTAttackMode.Tag]);   //ripman -> attack mode test
  end; }
 end;
end;

procedure TFrmDlg.DBottomEndDirectPaint(Sender: TObject; dsurface: TDXTexture);
var
  ax, ay: integer;
begin
  if dwndWhisperName.Visible then begin
    with DEditChat do begin
      ax := SurfaceX(Left + Width);
      ay := SurfaceY(Top);
      with g_DXCanvas do begin
        TextOut(ax - TextWidth('[Use up and down arrows to select, or space and return key]'), ay + 2, $808080,
          '[Use up and down arrows to select, or space and return key]');
      end;
    end;
  end;
  DBtCheck1.Visible := g_QuestMsgList.Count > 0;
  DBtCheck2.Visible := g_QuestMsgList.Count > 1;
  DBtCheck3.Visible := g_QuestMsgList.Count > 2;
  DBtCheck4.Visible := g_QuestMsgList.Count > 3;
  DBtCheck5.Visible := g_QuestMsgList.Count > 4;
  DBtCheck6.Visible := g_QuestMsgList.Count > 5;
  DBtCheck7.Visible := g_QuestMsgList.Count > 6;
  DBtCheck8.Visible := g_QuestMsgList.Count > 7;
  DBtCheck9.Visible := g_QuestMsgList.Count > 8;
  DBtCheck10.Visible := g_QuestMsgList.Count > 9;
end;

procedure TFrmDlg.DBottomMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
var
  ShowMsg: string;
  nLeft: Integer;
  fPercentage: Float;
  sPercentage: String;
begin
if g_nInterface = 1 then begin
  pClickName := nil;
  pClickItem := nil;
  nClickNameIndex := 0;
  nClickItemIndex := 0;
  if g_MySelf = nil then Exit;
  Dec(Y, DBottom.Top);
  Dec(X, DBottom.Left);
  ShowMsg := '';
  nLeft := g_FScreenWidth - 160;
  if (x >= nLeft) and (x <= nLeft + 105) and (y >= 171) and (y <= 171 + 26) then begin
    x := nLeft;
    Y := 192;
    fPercentage := g_MySelf.m_Abil.Exp / g_MySelf.m_Abil.MaxExp * 100;
    if fPercentage < 1 then sPercentage := '0' + FormatFloat('#.##', fPercentage) else sPercentage := FormatFloat('#.##', fPercentage);
     ShowMsg := 'Experience:(' + sPercentage + '%)';
//    ShowMsg := 'Experience:' + IntToStr(g_MySelf.m_Abil.Exp) + '/' + IntToStr(g_MySelf.m_Abil.MaxExp);
  end else
  if (x >= nLeft+45) and (x <= nLeft + 110) and (y >= 150) and (y <= 150 + 20) then begin
    x := nLeft;
    Y := 171;
    ShowMsg := 'Current attack mode';
  end else
  if (x >= nLeft) and (x <= nLeft + 105) and (y >= 200) and (y <= 200 + 26) then begin
    x := nLeft;
    Y := 223;
    ShowMsg := 'Bag Weight:' + IntToStr(g_MySelf.m_Abil.Weight) + '/' + IntToStr(g_MySelf.m_Abil.MaxWeight);
  end;
  if ShowMsg <> '' then
    DScreen.ShowHint(DBottom.SurfaceX(DBottom.Left + X), DBottom.SurfaceY(DBottom.Top + Y), ShowMsg, clWhite, False, Integer(Sender));
end else if g_nInterface = 2 then begin
  pClickName := nil;
  pClickItem := nil;
  nClickNameIndex := 0;
  nClickItemIndex := 0;
  if g_MySelf = nil then Exit;
  Dec(Y, DBottom.Top);
  Dec(X, DBottom.Left);
  ShowMsg := '';

  nLeft := g_FScreenWidth - 265;

  fPercentage := Round(g_MySelf.m_Abil.Weight / g_MySelf.m_Abil.MaxWeight * 100);

  if (x >= 39) and (x <= 289) and (y <= 115) and (y >= 107)  then begin
    x := 115;
    Y := 786;
    ShowMsg := 'Bag Weight:' + IntToStr(g_MySelf.m_Abil.Weight) + '/' + IntToStr(g_MySelf.m_Abil.MaxWeight) + ' (' + FloatToStr(fPercentage) + '%)';
  end;
  if ShowMsg <> '' then
    DScreen.ShowHint(DBottom.SurfaceX(DBottom.Left + X), DBottom.SurfaceY(DBottom.Top + Y), ShowMsg, clWhite, False, Integer(Sender));
end;
end;

procedure TFrmDlg.DBotWndSayDirectPaint(Sender: TObject; dsurface: TDXTexture);    //ripman
var
  i, ii: integer;
  sx, sy: integer;
  d: TDXTexture;
  nCount: integer;
  pMessage: pTSayMessage;
  SayImage: pTSayImage;
  nx, ny, ax, ay, nLeft: Integer;
  py: smallint;
  sStr: string;
  ClickName: pTClickName;
  ClickItem: pTClickItem;
  SAYLISTHEIGHT : integer;
begin
  with Sender as TDWindow do begin
  if g_nInterface = 2 then begin
      if g_nEnlargeChat = 0 then
      begin
              SAYLISTHEIGHT := 15;
              g_DXCanvas.FillRect(SurfaceX(Left), SurfaceX(Top) + 346, g_FScreenWidth - 414 - 238, 57, BGSURFACECOLOR or $FFFFFFFF);
      end;

      if g_nEnlargeChat = 1 then
      begin
              SAYLISTHEIGHT := 17;
              g_DXCanvas.FillRect(SurfaceX(Left), SurfaceX(Top) - 50 + 340, g_FScreenWidth - 414 - 238, 110, BGSURFACECOLOR or $FFFFFFFF);
      end;
  end;
    //g_DXCanvas.FillRect(SurfaceX(Left), SurfaceX(Top), Width, Height, BGSURFACECOLOR or $50000000);
    //g_DXCanvas.FillRect(SurfaceX(Left), SurfaceX(Top), Width, Height, BGSURFACECOLOR or $50FFFFFF);
    //DrawAlphaOfColor(dsurface, SurfaceX(Left), SurfaceX(Top), Width, Height, BGSURFACECOLOR, 60);
    //DrawAlphaEx(dsurface, SurfaceX(Left), SurfaceX(Top), DScreen.m_HintBGSurface, 0, 0, Width, Height, 1, 60);

    if g_nInterface = 1 then SAYLISTHEIGHT := 16;

    sx := SurfaceX(Left);
    sy := SurfaceY(Top);
    nCount := Height div SAYLISTHEIGHT;
    with DScreen do begin
      DSayUpDown.MaxPosition := _MAX(0, m_SayTransferList.count - nCount);
      for i := DSayUpDown.Position to (DSayUpDown.Position + nCount - 1) do begin
        if i > m_SayTransferList.count - 1 then break;
        pMessage := m_SayTransferList[i];
        ClickName := nil;
        ClickItem := nil;
        if (pClickName <> nil) and (nClickNameIndex > 0) and (pMessage.ClickList <> nil) and
          (pMessage.ClickList.Count > 0) then begin
          for ii := 0 to pMessage.ClickList.Count - 1 do begin
            if pTClickName(pMessage.ClickList[ii]).Index = nClickNameIndex then begin
              ClickName := pMessage.ClickList[ii];
              break;
            end;
          end;
        end
        else if (pClickItem <> nil) and (nClickItemIndex > 0) and (pMessage.ItemList <> nil) and
          (pMessage.ItemList.Count > 0) then begin
          for ii := 0 to pMessage.ItemList.Count - 1 do begin
            if pTClickItem(pMessage.ItemList[ii]).Index = nClickItemIndex then begin
              ClickItem := pMessage.ItemList[ii];
              break;
            end;
          end;
        end;
        ax := sx;
        ay := sy + (i - DSayUpDown.Position) * SAYLISTHEIGHT;
        if pMessage.SaySurface <> nil then
          dsurface.Draw(ax, ay, pMessage.SaySurface.ClientRect, pMessage.SaySurface, True);
        if (pMessage.ImageList <> nil) and (pMessage.ImageList.Count > 0) then begin
          for ii := 0 to pMessage.ImageList.Count - 1 do begin
            SayImage := pMessage.ImageList[ii];
            if (SayImage.nIndex <= High(g_FaceIndexInfo)) then begin
              d := g_WFaceImages.GetCachedImage(g_FaceIndexInfo[SayImage.nIndex].ImageIndex, nx, ny);
              if d <> nil then begin
                if g_nInterface = 2 then dsurface.Draw(ax + SayImage.nLeft, ay + (SAYLISTHEIGHT - d.Height) div 2, d.ClientRect, d, True)
                  else if g_nInterface = 1 then dsurface.Draw(ax + SayImage.nLeft, ay + (SAYLISTHEIGHT - d.Height) div 2 - 1, d.ClientRect, d, True);
                py := ny;
                if (FrmMain.m_CurrentTick - g_FaceIndexInfo[SayImage.nIndex].dwShowTime) > LongWord(nx) then begin
                  g_FaceIndexInfo[SayImage.nIndex].ImageIndex := g_FaceIndexInfo[SayImage.nIndex].ImageIndex + py;
                  g_FaceIndexInfo[SayImage.nIndex].dwShowTime := FrmMain.m_CurrentTick;
                end;
              end;
            end;
          end;
        end;
        if (i = pClickIndex) then begin
          sStr := '';
          nLeft := 0;
          if pClickName <> nil then begin
            sStr := pClickName.sStr;
            nLeft := pClickName.nLeft;
          end
          else if pClickItem <> nil then begin
            sStr := pClickItem.sStr;
            nLeft := pClickItem.nLeft;
          end;
          if sStr <> '' then begin
            with g_DXCanvas do begin
              //SetBkMode(Handle, TRANSPARENT);
              if SayDlgDown then
                TextOut(ax + nLeft + 1, ay + 3, clWhite, sstr)
              else
                TextOut(ax + nLeft, ay + 2, clWhite, sstr);
              //Release;
            end;
          end;
        end
        else begin
          sStr := '';
          nLeft := 0;
          if ClickName <> nil then begin
            sStr := ClickName.sStr;
            nLeft := ClickName.nLeft;
          end
          else if ClickItem <> nil then begin
            sStr := ClickItem.sStr;
            nLeft := ClickItem.nLeft;
          end;
          if sStr <> '' then begin
            with g_DXCanvas do begin
              //SetBkMode(Handle, TRANSPARENT);
              if SayDlgDown then
                TextOut(ax + nLeft + 1, ay + 3, clWhite, sstr)
              else
                TextOut(ax + nLeft, ay + 2, clWhite, sstr);
              //Release;
            end;
          end;
        end;
      end;
    end;
  end;
end;

procedure TFrmDlg.DBotWndSayInRealArea(Sender: TObject; X, Y: Integer; var IsRealArea: Boolean);
var
  ii, nX, nY: integer;
  pMessage: pTSayMessage;
  ClickName: pTClickName;
  ClickItem: pTClickItem;
begin
  IsRealArea := True;
  with Sender as TDWindow do begin
    pClickName := nil;
    pClickItem := nil;
    nClickNameIndex := 0;
    nClickItemIndex := 0;
    nX := X;
    nY := Y;
    pClickIndex := DSayUpDown.Position + nY div SAYLISTHEIGHT;
    with DScreen do begin
      if (pClickIndex >= 0) and (pClickIndex < m_SayTransferList.count) then begin
        pMessage := m_SayTransferList[pClickIndex];
        if (pMessage.ClickList <> nil) and (pMessage.ClickList.Count > 0) then begin
          for ii := 0 to pMessage.ClickList.Count - 1 do begin
            ClickName := pMessage.ClickList[ii];
            if (nX >= ClickName.nLeft) and (nX <= ClickName.nRight) then begin
              pClickName := ClickName;
              nClickNameIndex := ClickName.Index;
              IsRealArea := True;
              break;
            end;
          end;
        end;
        if (pClickName = nil) and (pMessage.ItemList <> nil) and (pMessage.ItemList.Count > 0) then begin
          for ii := 0 to pMessage.ItemList.Count - 1 do begin
            ClickItem := pMessage.ItemList[ii];
            if (nX >= ClickItem.nLeft) and (nX <= ClickItem.nRight) then begin
              pClickItem := ClickItem;
              nClickItemIndex := ClickItem.Index;
              IsRealArea := True;
              break;
            end;
          end;
        end;
      end;
    end;
  end;
end;

procedure TFrmDlg.DBotWndSayMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  SayDlgDown := True;
end;

procedure TFrmDlg.DBotWndSayMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  i: integer;
begin
  SayDlgDown := False;
  if mbRight = Button then begin
    if pClickName <> nil then begin
      with Sender as TDControl do begin
        DPopUpSayList.Visible := False;
        DPopUpSayList.Item.Clear;
        DPopUpSayList.Item.AddObject('Name: ' + pClickName.sStr, TObject(-1));
        DPopUpSayList.Item.AddObject('-', nil);
        DPopUpSayList.Item.AddObject('Private Chat', TObject(1));
        if (not InFriendList(pClickName.sStr)) and
          (pClickName.sStr <> g_MySelf.m_UserName) then
          DPopUpSayList.Item.AddObject('Add as Friend', TObject(2))
        else
          DPopUpSayList.Item.AddObject('Add as Friend', nil);

        if (not InBlacklist(pClickName.sStr)) then
          DPopUpSayList.Item.AddObject('Unblock Chat', TObject(7))
        else
          DPopUpSayList.Item.AddObject('Allow Chat', TObject(8));

        if InFriendList(pClickName.sStr) then
          DPopUpSayList.Item.AddObject('Send Message', TObject(3))
        else
          DPopUpSayList.Item.AddObject('Send Message', nil);

        DPopUpSayList.Item.AddObject('Invite to Group', TObject(4));
        DPopUpSayList.Item.AddObject('Invite to Guild', TObject(5));
        DPopUpSayList.Item.AddObject('-', nil);
        DPopUpSayList.Item.AddObject('Copy Name', TObject(6));
        DPopUpSayList.RefSize;
        DPopUpSayList.Popup(Sender, SurfaceX(X), SurfaceY(Y), pClickName.sStr);
      end;
    end;
  end
  else begin
    if pClickName <> nil then begin
      PlayScene.SetEditChar(pClickName.sStr);
    end
    else if pClickItem <> nil then begin
      if pClickItem.pc.s.name <> '' then begin
        OpenSayItemShow(pClickItem.pc);
      end
      else if pClickItem.ItemIndex < 0 then begin
        for I := Low(g_ItemArr) to High(g_ItemArr) do begin
          if (g_ItemArr[i].s.Name <> '') and (g_ItemArr[i].UserItem.MakeIndex = (-pClickItem.ItemIndex)) then begin
            OpenSayItemShow(g_ItemArr[i]);
            pClickItem.pc := g_ItemArr[i];
            break;
          end;
        end;
      end
      else begin
        if FrmMain.m_CurrentTick > DWndSay.AppendTick then begin
          DWndSay.AppendTick := FrmMain.m_CurrentTick + 500;
          FrmMain.SendGetSayItem(pClickItem.nIndex, pClickItem.ItemIndex); //去服务器取回装备属性
        end;
      end;
    end;
  end;
end;

procedure TFrmDlg.DBTAttackModeClick(Sender: TObject; X, Y: Integer);
begin
  DWndAttackModeList.TopShow;
end;

procedure TFrmDlg.DBTAttackModeGuildClick(Sender: TObject; X, Y: Integer);
begin
  with Sender as TDButton do begin
    DBTAttackMode.Tag := Tag;
    frmMain.SendSay('@AttackMode ' + IntToStr(Tag));
  end;
  DWndAttackModeList.Visible := False;
end;

procedure TFrmDlg.DBTCheck1Click(Sender: TObject; X, Y: Integer);
var
  ClientCheckMsg: pTClientCheckMsg;
  str: string;
  nid: integer;
begin
  with Sender as TDButton do begin
    if (Tag >= 0) and (Tag < g_QuestMsgList.Count) then begin
      Downed := False;
      ClientCheckMsg := g_QuestMsgList[Tag];
      if ClientCheckMsg.MsgType = tmc_Naked then begin
        StatePage := 1;
        DStateWin.Visible := True;
        PageChanged;
      end
      else begin
        str := ClientCheckMsg.str;
        nid := ClientCheckMsg.MsgIndex;
        Dispose(ClientCheckMsg);
        g_QuestMsgList.Delete(Tag);
        Visible := False;
        FrmDlg.RefCheckButtonXY;
        if mrYes = DMessageDlg(str, [mbYes, mbNo]) then
          frmMain.SendCheckMsgDlgSelect(nid, 1)
        else
          frmMain.SendCheckMsgDlgSelect(nid, 0);
      end;
    end
    else begin
      Visible := False;
      exit;
    end;
  end;
end;

procedure TFrmDlg.DBTCheck1DirectPaint(Sender: TObject; dsurface: TDXTexture);
var
  d: TDXTexture;
  idx: integer;
  ClientCheckMsg: pTClientCheckMsg;
begin
  with Sender as TDButton do begin
    if (Tag >= 0) and (Tag < g_QuestMsgList.Count) then begin
      ClientCheckMsg := g_QuestMsgList[Tag];
      if (ClientCheckMsg.MsgType = tmc_Naked) and ((g_nNakedCount = 0) and (g_nNakedBackCount = 0)) and (ClientCheckMsg = g_ClientCheckMsg) then begin
        Dispose(ClientCheckMsg);
        g_QuestMsgList.Delete(Tag);
        g_ClientCheckMsg := nil;
        Visible := False;
        FrmDlg.RefCheckButtonXY;
        exit;
      end
      else if (ClientCheckMsg.MsgType <> tmc_Naked) and (FrmMain.m_CurrentTick > ClientCheckMsg.EndTime) then begin
        Dispose(ClientCheckMsg);
        g_QuestMsgList.Delete(Tag);
        Visible := False;
        FrmDlg.RefCheckButtonXY;
        exit;
      end;
      idx := 0;
      case ClientCheckMsg.MsgType of
        tmc_Group: idx := 0;
        tmc_Friend: idx := 3;
        tmc_Guild: idx := 6;
        tmc_Naked: idx := 9;
        tmc_Deal: idx := 12;
        //CHECK_FRIEND : idx := 3;
      end;
    end
    else begin
      Visible := False;
      exit;
    end;
    //idx := 0;
    if WLib <> nil then begin
      {if Downed then begin
        inc(idx, 2)
      end
      else if (MouseEntry = msIn) or }
      if (((FrmMain.m_CurrentTick - ClientCheckMsg.ShowTime) mod 400) > 200) then begin
        Inc(idx, 1)
      end;
      d := WLib.Images[FaceIndex + idx];
      if d <> nil then
        dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, True);
    end;
  end;
end;

procedure TFrmDlg.DBTEditClick(Sender: TObject; X, Y: Integer);
begin
  if not DEditChat.Visible then begin
    DEditChat.Visible := True;
    DEditChat.SetFocus;
    case g_SayMode of
      usm_Hear: DEditChat.Text := '';
      usm_Whisper: DEditChat.Text := '/';
      usm_Cry: DEditChat.Text := '!';
      usm_Group: DEditChat.Text := '!!';
      usm_Guild: DEditChat.Text := '!~';
      usm_World: DEditChat.Text := g_Cmd_AllMsg + ' ';
    end;
  end
  else
    DEditChat.SetFocus;
end;

procedure TFrmDlg.DBTEditDirectPaint(Sender: TObject; dsurface: TDXTexture);
var
  d: TDXTexture;
  ax, ay: integer;
begin
  with Sender as TDButton do begin
    ax := SurfaceX(Left);
    ay := SurfaceY(Top);
    if DEditChat.Visible then
      d := WLib.Images[130]
    else
      d := WLib.Images[FaceIndex];
    if d <> nil then
      DrawWindow(dsurface, ax, ay, d);
  end;
end;

procedure TFrmDlg.DBTFaceClick(Sender: TObject; X, Y: Integer);
begin
  DWndFace.TopShow;
end;

procedure TFrmDlg.DBTHintCloseClick(Sender: TObject; X, Y: Integer);
begin
  if HintBack = stClose then begin
    FrmMain.Close;
  end
  else begin
    if HintBack = stSelServer then
      FrmMain.CSocket.Active := False;
    DScreen.ChangeScene(HintBack);
  end;
end;

procedure TFrmDlg.DBTHintCloseDirectPaint(Sender: TObject; dsurface: TDXTexture);
var
  d: TDXTexture;
  ax, ay: Integer;
begin
  with Sender as TDButton do begin
    ax := SurfaceX(Left);
    ay := SurfaceY(Top);
    if Downed then begin
      d := WLib.Images[FaceIndex + 1];
      Inc(ax);
      Inc(ay);
    end
    else
      d := WLib.Images[FaceIndex];
      
    if d <> nil then
      dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, True);

    with g_DXCanvas do begin
      TextOut(ax + (Width - TextWidth(Caption)) div 2, ay + (Height - TextHeight(Caption)) div 2 + 1, DFColor, Caption);
    end;
  end;
end;

procedure TFrmDlg.DBTItemShowCloseDirectPaint(Sender: TObject; dsurface: TDXTexture);
var
  d: TDXTexture;
  idx: integer;
begin
  with Sender as TDButton do begin
    if WLib <> nil then begin
      idx := 0;
      if Downed then begin
        inc(idx, 2)
      end
      else if MouseEntry = msIn then begin
        Inc(idx, 1)
      end;
      d := WLib.Images[FaceIndex + idx];
      if d <> nil then
        dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, True);
    end;
  end;
end;

procedure TFrmDlg.dbtnLoginLostPwClick(Sender: TObject; X, Y: Integer);
begin
  if g_WebInfo.g_LostPassUrl <> '' then begin
    SendMessage(Application.Handle, WM_SYSCOMMAND, SC_MINIMIZE, 0);
    ShellExecute(Handle, 'Open', @g_WebInfo.g_LostPassUrl[1], '', '', SW_SHOW);
  end;
end;

procedure TFrmDlg.DBtnSayAllClick(Sender: TObject; X, Y: Integer);
var
  UserSayType: TUserSayType;
begin
  with Sender as TDButton do begin
    UserSayType := TUserSayType(Integer(AppendData));
    if g_SayShowType <> UserSayType then begin
      PlaySound(s_glass_button_click);
      g_SayShowType := UserSayType;
      g_SayEffectIndex[UserSayType] := False;
      case UserSayType of
        us_All: DScreen.ChangeTransferMsg([us_Hear, us_Whisper, us_Cry, us_Group, us_Guild, us_Sys]);
        us_Hear,
          us_Whisper,
          us_Cry,
          us_Group,
          us_Guild,
          us_Sys: DScreen.ChangeTransferMsg([UserSayType]);
        us_Custom: DScreen.ChangeTransferMsg(g_SayShowCustom);
      end;
    end;
  end;
end;

procedure TFrmDlg.DBtnSayAllDirectPaint(Sender: TObject; dsurface: TDXTexture);
var
  d: TDXTexture;
  idx: integer;
  UserSayType: TUserSayType;
begin
  with Sender as TDButton do begin
    UserSayType := TUserSayType(Integer(AppendData));
    if WLib <> nil then begin
      idx := 1;
      if g_SayShowType = UserSayType then begin
        idx := 0;
        g_SayEffectIndex[UserSayType] := False;
      end
      else if g_SayEffectIndex[UserSayType] then begin
        if ((FrmMain.m_CurrentTick - AppendTick) div 200 mod 2 = 0) then begin
          idx := 0;
        end;
      end;
      d := WLib.Images[FaceIndex + idx];
      if d <> nil then
        dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, True);
    end;
  end;
end;

procedure TFrmDlg.dbtnSayModeHearClick(Sender: TObject; X, Y: Integer);
{var
  SayMode: TUserSayMode; }
begin
  //  SayMode := g_SayMode;
  with Sender as TDButton do begin
    g_SayMode := TUserSayMode(Tag);
    DEditChat.Visible := True;
    DEditChat.SetFocus;
    case g_SayMode of
      usm_Hear: DEditChat.Text := '';
      usm_Whisper: DEditChat.Text := '/';
      usm_Cry: DEditChat.Text := '!';
      usm_Group: DEditChat.Text := '!!';
      usm_Guild: DEditChat.Text := '!~';
      usm_World: DEditChat.Text := g_Cmd_AllMsg + ' ';
    end;
  end;
  dwndSayMode.Visible := False;
end;

procedure TFrmDlg.dbtnSayModeHearDirectPaint(Sender: TObject; dsurface: TDXTexture);
var
  d: TDXTexture;
  ax, ay: integer;
begin
  with Sender as TDButton do begin
    ax := SurfaceX(Left);
    ay := SurfaceY(Top);
    if MouseEntry = msIn then
      d := WLib.Images[FaceIndex + 1]
    else
      d := WLib.Images[FaceIndex];

    if d <> nil then begin
      dsurface.Draw(ax, ay, d.ClientRect, d, True);
    end;
  end;
end;

procedure TFrmDlg.DBTOptionClick(Sender: TObject; X, Y: Integer);
begin
  FrmDlg3.DGameSetup.Visible := not FrmDlg3.DGameSetup.Visible;
  FrmDlg3.DGSConfigClick(FrmDlg3.dbtnGSSay, 0, 0);
end;

procedure TFrmDlg.DBTSayLockClick(Sender: TObject; X, Y: Integer);
begin
  dwndSayMode.TopShow;
end;

procedure TFrmDlg.DBTSayLockDirectPaint(Sender: TObject; dsurface: TDXTexture);
var
  d: TDXTexture;
begin
  with Sender as TDButton do begin
    if WLib <> nil then begin
      d := WLib.Images[FaceIndex + Integer(g_SayMode)];
      if d <> nil then
        dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, True);
    end;
  end;
end;

procedure TFrmDlg.DBTSayMoveMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var
  ShowMsg: string;
  ay: Integer;
begin
  with Sender as TDControl do begin
    ay := y;
    X := SurfaceX(Left);
    y := SurfaceY(Top);
    ShowMsg := '';
    if Sender = DBTAttackMode then begin
      ShowMsg := 'Change Attack Mode<(' + GetHookKeyStr(@g_CustomKey[DK_CHANGEATTACKMODE]) + ')/FCOLOR=$FFFF>';
    end
    else if Sender = DBTSayMove then begin
      ShowMsg := 'Press and hold while dragging to resize Chat Box';
      DSayMoveSize(SurfaceY(ay));
    end
    else if Sender = DBTFace then begin
      ShowMsg := 'Emoticon';
    end
    else if Sender = DBTOption then begin
      ShowMsg := 'Chatbox Filter settings';
    end
    else if Sender = dchkSayLock then begin
      ShowMsg := 'Auto Scroll Chat';
      {if g_SayUpDownLock then
        ShowMsg := '点击自动滚屏'
      else
        ShowMsg := '点击锁定聊天框';}
    end
    else if Sender = DBTTakeHorse then begin
      if g_MySelf.m_btHorse = 0 then
        ShowMsg := 'Ride Horse\<(' + GetHookKeyStr(@g_CustomKey[DK_ONHORSE]) + ')/FCOLOR=$FFFF>'
      else
        ShowMsg := 'Dismount Horse\<(' + GetHookKeyStr(@g_CustomKey[DK_ONHORSE]) + ')/FCOLOR=$FFFF>';
    end;
    if ShowMsg <> '' then
      DScreen.ShowHint(x, y, ShowMsg, clWhite, True, Integer(Sender));
  end;
end;

procedure TFrmDlg.DBTTakeHorseClick(Sender: TObject; X, Y: Integer);
begin
  with Sender as TDButton do begin
    if FrmMain.m_CurrentTick < AppendTick then
      exit;
    AppendTick := FrmMain.m_CurrentTick + 2000;
    if g_MySelf.m_btHorse = 0 then begin
      frmMain.SendSay(g_Cmd_TakeOnHorse);
    end
    else begin
      frmMain.SendSay(g_Cmd_TakeOffHorse);
    end;
  end;

end;

procedure TFrmDlg.DBTTakeHorseDirectPaint(Sender: TObject; dsurface: TDXTexture);
var
  d: TDXTexture;
  idx: integer;
begin
  if g_MySelf = nil then
    exit;
  with Sender as TDButton do begin
    if WLib <> nil then begin
      if g_MySelf.m_btHorse = 0 then
        idx := 0
      else
        idx := 3;
      if Downed then begin
        inc(idx, 2)
      end
      else if MouseEntry = msIn then begin
        Inc(idx, 1)
      end;
      d := WLib.Images[FaceIndex + idx];
      if d <> nil then
        dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, True);
    end;
  end;
end;

procedure TFrmDlg.DStateBTItemClick(Sender: TObject; X, Y: Integer);
begin
  with Sender as TDButton do begin
    if StatePage <> Tag then begin
      StatePage := Tag;
      PageChanged;
      PlaySound(s_glass_button_click);
    end;
  end;
end;

procedure TFrmDlg.DStateBTItemDirectPaint(Sender: TObject; dsurface: TDXTexture);
var
  d: TDXTexture;
  nTop: Byte;
begin
  with Sender as TDButton do begin
    if WLib <> nil then begin
      nTop := 0;
      if StatePage = tag then begin
        d := WLib.Images[FaceIndex];
      end else begin
        d := WLib.Images[FaceIndex + 1];
        nTop := 2;
      end;

      if d <> nil then
        dsurface.Draw(SurfaceX(Left), SurfaceY(Top) + nTop, d.ClientRect, d, True);
    end;
  end;
end;

procedure TFrmDlg.DStateGridGridPaint(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState;
  dsurface: TDXTexture);
var
  idx, nMagID: Integer;
  Magic: TClientDefMagic;
  d: TDXTexture;
  MagicList: TStringList;
  sStr: string;
  nMaxTrain: Integer;
  rc: TRect;
begin
  case DMagicIndex of
    0: MagicList := MagicList1;
    1: MagicList := MagicList2;
  else
    exit;
  end;
  with Sender as TDGrid do begin
    idx := ACol + ARow * ColCount + MagicPage * 5;
    if (Idx >= 0) and (idx < MagicList.Count) then begin
      nMagID := Integer(MagicList.Objects[idx]);
      Magic := GetMagicInfo(nMagID);
      if Magic.Magic.sMagicName <> '' then begin
        if gdSelected in state then
          d := GetDefMagicIcon(Magic.Magic.wMagicIcon+1)
        else
          d := GetDefMagicIcon(Magic.Magic.wMagicIcon);
        if g_MyMagicArry[nMagID].Level in [Low(Magic.Magic.MaxTrain)..High(Magic.Magic.MaxTrain)] then
          nMaxTrain := Magic.Magic.MaxTrain[g_MyMagicArry[nMagID].Level]
        else
          nMaxTrain := Magic.Magic.MaxTrain[High(Magic.Magic.MaxTrain)];
        
        if d <> nil then begin
          dsurface.Draw(SurfaceX(Rect.Left + (ColWidth - d.Width) div 2), SurfaceY(Rect.Top + (RowHeight - d.Height) div 2), d.ClientRect, d, False);

        end;
        d := g_WMain99Images.Images[1807];
        if d <> nil then
          dsurface.Draw(SurfaceX(Rect.Left + 44), SurfaceY(Rect.Top + 20), d.ClientRect, d, False);

        d := g_WMain99Images.Images[1808];
        if d <> nil then begin
          rc := d.ClientRect;
          if g_MyMagicArry[nMagID].Level < 3 then
            rc.Right := _MIN(Round(rc.Right / (nMaxTrain / g_MyMagicArry[nMagID].CurTrain)), rc.Right);
          dsurface.Draw(SurfaceX(Rect.Left + 46), SurfaceY(Rect.Top + 22), rc, d, FALSE);
        end;

        if g_MyMagicArry[nMagID].btKey > 0 then begin
          d := g_WMain99Images.Images[2095 + g_MyMagicArry[nMagID].btKey];
          if d <> nil then
            dsurface.Draw(SurfaceX(Rect.Left + 183), SurfaceY(Rect.Top + 3), d.ClientRect, d, True);
        end;

        with g_DXCanvas do begin
          TextOut(SurfaceX(Rect.Left + 43), SurfaceY(Rect.Top + 3), $8CC6EF, Magic.Magic.sMagicName);

          if g_MyMagicArry[nMagID].Level < 3 then
          begin
            sStr := IntToStr(g_MyMagicArry[nMagID].CurTrain) + '/' + IntToStr(nMaxTrain);
            TextOut(SurfaceX(Rect.Left + 96 - (TextWidth(sStr) div 2)), SurfaceY(Rect.Top + 19), clWhite, sStr);
            TextOut(SurfaceX(Rect.Left + 155), SurfaceY(Rect.Top + 19), clWhite, 'Lv.' + IntToStr(g_MyMagicArry[nMagID].Level));
          end
          else
          begin
            //sStr := '-';
            //TextOut(SurfaceX(Rect.Left + 96 - (TextWidth(sStr) div 2)), SurfaceY(Rect.Top + 19), clWhite, sStr);
            TextOut(SurfaceX(Rect.Left + 155), SurfaceY(Rect.Top + 19), clWhite, 'Lv.Max');
          end;
        end;
      end;
    end;
  end;
end;

procedure TFrmDlg.DStateGridGridSelect(Sender: TObject; X, Y, ACol, ARow: Integer; Shift: TShiftState);
  procedure ClearUserKeyType(nIdx: Integer);
  var
    i: integer;
  begin
    for i := Low(CboMagicList.MagicList) to High(CboMagicList.MagicList) do begin
      if CboMagicList.MagicList[i] = nIdx then begin
        CboMagicList.MagicList[i] := 0;
      end;
    end;
  end;
var
  idx, nMagID: Integer;
  MagicList: TStringList;
begin
  case DMagicIndex of
    0: MagicList := MagicList1;
    1: MagicList := MagicList2;
  else exit;
  end;
  with Sender as TDGrid do begin
    idx := ACol + ARow * ColCount + MagicPage * 5;
    if (Idx >= 0) and (idx < MagicList.Count) then begin
      nMagID := Integer(MagicList.Objects[idx]);
      if (g_MyMagicArry[nMagID].boStudy) and (not (nMagID in [3, 4, 7, 64])) then
      begin
        if DStateWinMagicCbo.Visible and (FMagicCboKeyIndex in [Low(CboMagicList.MagicList)..High(CboMagicList.MagicList)]) then
        begin
          ClearUserKeyType(nMagID);
          CboMagicList.MagicList[FMagicCboKeyIndex] := nMagID;
        end
        else
        begin
          FrmDlg4.FMagicKeyIndex := g_MyMagicArry[nMagID].btKey;
          FrmDlg4.FMagidID := nMagID;
          FrmDlg4.DWndMagicKey.ShowModal;
        end;
      end;
    end;
  end;
end;

procedure TFrmDlg.DStateInfoExitClick(Sender: TObject; X, Y: Integer);
begin
  RefRealityInfo();
end;



procedure TFrmDlg.DStateInfoNameChange(Sender: TObject);
var
  i: integer;
  StrList: TStringList;
begin
  DStateInfoSave.Visible := True;
  DStateInfoExit.Visible := True;
  DStateInfoSave.Enabled := True;
  DStateInfoExit.Enabled := True;

  if Sender = DStateInfoProvince then begin
    TempRealityInfo.btProvince := DStateInfoProvince.ItemIndex;
    exit;//dont bother getting a list of city's
    TempAddressList := nil;
    DStateInfoCity.Item.Clear;
    DStateInfoArea.Item.Clear;
    if (DStateInfoProvince.ItemIndex >= 0) and (DStateInfoProvince.ItemIndex < AddressList.Count) then begin
      TempRealityInfo.btProvince := DStateInfoProvince.ItemIndex;
      if AddressList.Objects[DStateInfoProvince.ItemIndex] <> nil then begin
        TempAddressList := TStringList(AddressList.Objects[DStateInfoProvince.ItemIndex]);
        for I := 0 to TempAddressList.Count - 1 do
          DStateInfoCity.Item.AddObject(TempAddressList[i], TempAddressList.Objects[i]);
        DStateInfoCity.ItemIndex := 1;
        DStateInfoNameChange(DStateInfoCity);
      end;
    end;
  end
  else if Sender = DStateInfoCity then begin
    exit;//dont bother with city's
    DStateInfoArea.Item.Clear;
    if TempAddressList = nil then
      exit;
    if (DStateInfoCity.ItemIndex >= 0) and (DStateInfoCity.ItemIndex < TempAddressList.Count) then begin
      TempRealityInfo.btCity := DStateInfoCity.ItemIndex;
      if TempAddressList.Objects[DStateInfoCity.ItemIndex] <> nil then begin
        StrList := TStringList(TempAddressList.Objects[DStateInfoCity.ItemIndex]);
        for I := 0 to StrList.Count - 1 do
          DStateInfoArea.Item.Add(StrList[i]);
        DStateInfoArea.ItemIndex := 1;
        DStateInfoNameChange(DStateInfoArea);
      end;
    end;
  end
  else if Sender = DStateInfoArea then begin
    exit;//dont bother with areas
    if (DStateInfoArea.ItemIndex >= 0) then begin
      TempRealityInfo.btArea := DStateInfoArea.ItemIndex;
    end;
  end
  else if Sender = DStateInfoSex then begin
    if (DStateInfoSex.ItemIndex >= 0) then begin
      TempRealityInfo.btSex := DStateInfoSex.ItemIndex;
    end;
  end
  else if Sender = DStateInfoMemo then begin
    TempRealityInfo.sIdiograph := DStateInfoMemo.GetText;
  end
  else if Sender = DStateInfoName then begin
    TempRealityInfo.sUserName := DStateInfoName.Text;
  end
  else if Sender = DStateInfoAM then begin
    SetByteStatus(TempRealityInfo.btOnlineTime, 0, DStateInfoAM.Checked);
  end
  else if Sender = DStateInfoPM then begin
    SetByteStatus(TempRealityInfo.btOnlineTime, 1, DStateInfoPM.Checked);
  end
  else if Sender = DStateInfoNight then begin
    SetByteStatus(TempRealityInfo.btOnlineTime, 2, DStateInfoNight.Checked);
  end
  else if Sender = DStateInfoMidNight then begin
    SetByteStatus(TempRealityInfo.btOnlineTime, 3, DStateInfoMidNight.Checked);
  end
  else if Sender = DStateInfoFriend then begin
    TempRealityInfo.boFriendSee := DStateInfoFriend.Checked;
  end
  else if Sender = DStateInfoAge then begin
    TempRealityInfo.btOld := StrToIntDef(DStateInfoAge.Text, 0);
  end;
end;

procedure TFrmDlg.DStateInfoRefPicClick(Sender: TObject; X, Y: Integer);
begin
  with Sender as TDButton do begin
    if (FrmMain.m_CurrentTick - AppendTick) < 2000 then
      exit;
    AppendTick := FrmMain.m_CurrentTick;
    if Sender = DStateInfoUpLoadPic then begin
      FrmMain.SendClientSocket(CM_SAVEUSERPHOTO, 0, 0, 0, 0, '');
      DStateInfoUpLoadPic.Enabled := False;
    end
    else if Sender = DStateInfoRefPic then begin
      FrmMain.SendClientSocket(CM_SAVEUSERPHOTO, 0, 0, 0, 2, '');
    end
    else if Sender = DUserStateInfoRefPic then begin
      FrmMain.SendClientSocket(CM_SAVEUSERPHOTO, 0, 0, 0, 3, '');
    end;
  end;
end;

procedure TFrmDlg.DStateInfoRefPicDirectPaint(Sender: TObject; dsurface: TDXTexture);
var
  d: TDXTexture;
  idx: integer;
begin
  with Sender as TDButton do begin
    if WLib <> nil then begin
      idx := 0;
      if not Enabled then begin
        inc(idx, 2)
      end
      else if Downed then begin
        Inc(idx, 1)
      end;
      d := WLib.Images[FaceIndex + idx];
      if d <> nil then
        dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, True);
    end;
  end;
end;

procedure TFrmDlg.DStateInfoSaveClick(Sender: TObject; X, Y: Integer);
begin
  FrmMain.SendClientMessage(CM_REALITYINFO,
    Integer(TempRealityInfo.boFriendSee),
    MakeWord(TempRealityInfo.btOld, TempRealityInfo.btSex),
    MakeWord(TempRealityInfo.btProvince, TempRealityInfo.btCity),
    MakeWord(TempRealityInfo.btArea, TempRealityInfo.btOnlineTime),
    TempRealityInfo.sUserName + '/' + TempRealityInfo.sIdiograph);
  g_UserRealityInfo := TempRealityInfo;
  RefRealityInfo();
end;

procedure TFrmDlg.DStateAbilAdd1MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
var
  ShowMsg: string;
begin
  with Sender as TDControl do begin
    X := SurfaceX(Left);
    y := SurfaceY(Top);
    ShowMsg := 'Press and Hold <Ctrl/FCOLOR=$FFFF> to quickly add Ability Points\';
    if (Sender = DStateAbilAdd1) or (Sender = DStateAbilDel1) then begin
      ShowMsg := ShowMsg + '<' + IntToStr(g_ClientNakedInfo.NakedAddInfo.nNakedAcCount) +
        '/FCOLOR=$FFFF> adds an additional AC Point ';
    end
    else if (Sender = DStateAbilAdd2) or (Sender = DStateAbilDel2) then begin
      ShowMsg := ShowMsg + '<' + IntToStr(g_ClientNakedInfo.NakedAddInfo.nNakedMAcCount) +
        '/FCOLOR=$FFFF> adds an additional MAC Point ';
    end
    else if (Sender = DStateAbilAdd3) or (Sender = DStateAbilDel3) then begin
      ShowMsg := ShowMsg + '<' + IntToStr(g_ClientNakedInfo.NakedAddInfo.nNakedDcCount) +
        '/FCOLOR=$FFFF> adds an additional DC Point';
    end
    else if (Sender = DStateAbilAdd4) or (Sender = DStateAbilDel4) then begin
      ShowMsg := ShowMsg + '<' + IntToStr(g_ClientNakedInfo.NakedAddInfo.nNakedMcCount) +
        '/FCOLOR=$FFFF> adds an additional MC Point';
    end
    else if (Sender = DStateAbilAdd5) or (Sender = DStateAbilDel5) then begin
      ShowMsg := ShowMsg + '<' + IntToStr(g_ClientNakedInfo.NakedAddInfo.nNakedScCount) +
        '/FCOLOR=$FFFF> adds an additional SC Point';
    end
    else if (Sender = DStateAbilAdd6) or (Sender = DStateAbilDel6) then begin
      ShowMsg := ShowMsg + '<' + IntToStr(g_ClientNakedInfo.NakedAddInfo.nNakedHPCount) +
        '/FCOLOR=$FFFF> adds an additional Health Point';
    end;
    DScreen.ShowHint(x, y, ShowMsg, clWhite, True, Integer(Sender));
  end;
end;

procedure TFrmDlg.DStateAbilAdd1MouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  boAdd: Boolean;
  nIndex: Integer;
  pNaked, pBackNaked: PWord;
  nCount: Integer;
begin
  with Sender as TDButton do begin
    if g_nNakedBackCount > 0 then begin
      nCount := 1;
      if ssCtrl in Shift then
        nCount := 10;

      if Tag > 9 then begin
        boAdd := True;
        nIndex := Tag - 10;
      end
      else begin
        boAdd := False;
        nIndex := Tag;
      end;
      if (nIndex < 0) or (nIndex > 6) then
        exit;
      pNaked := PWord(@NakedAbil);
      pBackNaked := PWord(@g_ClientNakedInfo.NakedAbil);
      Inc(pNaked, nIndex);
      Inc(pBackNaked, nIndex);
      if boAdd then begin
        if NakedBackCount <= 0 then
          exit;
        if nCount > NakedBackCount then
          nCount := NakedBackCount;
        if nCount > (pBackNaked^ - pNaked^) then
          nCount := (pBackNaked^ - pNaked^);
        if nCount > 0 then begin
          Inc(pNaked^, nCount);
          Dec(NakedBackCount, nCount);
        end;
      end
      else if pNaked^ > 0 then begin
        if nCount > pNaked^ then
          nCount := pNaked^;
        Dec(pNaked^, nCount);
        Inc(NakedBackCount, nCount);
      end;
      DStateAbilOk.Visible := (NakedBackCount <> g_nNakedBackCount);
      DStateAbilExit.Visible := (NakedBackCount <> g_nNakedBackCount);
      DStateAbilOk.Enabled := (NakedBackCount <> g_nNakedBackCount);
      DStateAbilExit.Enabled := (NakedBackCount <> g_nNakedBackCount);
      DStateAbilAdd1.Enabled := NakedAbil.nAc > 0;
      DStateAbilAdd2.Enabled := NakedAbil.nMAc > 0;
      DStateAbilAdd3.Enabled := NakedAbil.nDc > 0;
      DStateAbilAdd4.Enabled := NakedAbil.nMc > 0;
      DStateAbilAdd5.Enabled := NakedAbil.nSc > 0;
      DStateAbilAdd6.Enabled := NakedAbil.nHP > 0;
      DStateAbilDel1.Enabled := (NakedBackCount > 0) and (g_ClientNakedInfo.NakedAbil.nAc > NakedAbil.nAc);
      DStateAbilDel2.Enabled := (NakedBackCount > 0) and (g_ClientNakedInfo.NakedAbil.nMAc > NakedAbil.nMAc);
      DStateAbilDel3.Enabled := (NakedBackCount > 0) and (g_ClientNakedInfo.NakedAbil.nDc > NakedAbil.nDc);
      DStateAbilDel4.Enabled := (NakedBackCount > 0) and (g_ClientNakedInfo.NakedAbil.nMc > NakedAbil.nMc);
      DStateAbilDel5.Enabled := (NakedBackCount > 0) and (g_ClientNakedInfo.NakedAbil.nSc > NakedAbil.nSc);
      DStateAbilDel6.Enabled := (NakedBackCount > 0) and (g_ClientNakedInfo.NakedAbil.nHP > NakedAbil.nHP);
    end
    else begin
      nCount := 1;
      if ssCtrl in Shift then
        nCount := 10;

      if Tag > 9 then begin
        boAdd := False;
        nIndex := Tag - 10;
      end
      else begin
        boAdd := True;
        nIndex := Tag;
      end;
      if (nIndex < 0) or (nIndex > 6) then
        exit;
      pNaked := PWord(@NakedAbil);
      Inc(pNaked, nIndex);
      if boAdd then begin
        if NakedCount <= 0 then
          exit;
        if nCount > NakedCount then
          nCount := NakedCount;
        Inc(pNaked^, nCount);
        Dec(NakedCount, nCount);
      end
      else if pNaked^ > 0 then begin
        if nCount > pNaked^ then
          nCount := pNaked^;
        Dec(pNaked^, nCount);
        Inc(NakedCount, nCount);
      end;
      DStateAbilOk.Visible := (NakedCount <> g_nNakedCount);
      DStateAbilExit.Visible := (NakedCount <> g_nNakedCount);
      DStateAbilOk.Enabled := (NakedCount <> g_nNakedCount);
      DStateAbilExit.Enabled := (NakedCount <> g_nNakedCount);
      DStateAbilAdd1.Enabled := NakedCount > 0;
      DStateAbilAdd2.Enabled := NakedCount > 0;
      DStateAbilAdd3.Enabled := NakedCount > 0;
      DStateAbilAdd4.Enabled := NakedCount > 0;
      DStateAbilAdd5.Enabled := NakedCount > 0;
      DStateAbilAdd6.Enabled := NakedCount > 0;
      DStateAbilDel1.Enabled := NakedAbil.nAc > 0;
      DStateAbilDel2.Enabled := NakedAbil.nMAc > 0;
      DStateAbilDel3.Enabled := NakedAbil.nDc > 0;
      DStateAbilDel4.Enabled := NakedAbil.nMc > 0;
      DStateAbilDel5.Enabled := NakedAbil.nSc > 0;
      DStateAbilDel6.Enabled := NakedAbil.nHP > 0;
    end;
  end;
end;

procedure TFrmDlg.DStateAbilAdd3DirectPaint(Sender: TObject; dsurface: TDXTexture);
var
  d: TDXTexture;
  idx: integer;
begin
  with Sender as TDButton do begin
    if WLib <> nil then begin
      idx := 0;
      if not Enabled then begin
        inc(idx, 3);
      end
      else if Downed then begin
        inc(idx, 2);
      end
      else if MouseEntry = msIn then begin
        Inc(idx, 1);
      end;
      d := WLib.Images[FaceIndex + idx];
      if d <> nil then
        dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, True);
    end;
  end;
end;

procedure TFrmDlg.DStateAbilExitClick(Sender: TObject; X, Y: Integer);
begin // NakedAbil
  if Sender = DStateAbilExit then
    RefNakedWindow();
  if Sender = DStateAbilOK then begin
    FrmMain.SendClientSocket(CM_NAKEDABILITYCHANGE, 0, 0, 0, 0, EncodeBuffer(@NakedAbil, SizeOf(NakedAbil)));
    DStateAbilOk.Visible := False;
    DStateAbilExit.Visible := False;
    DStateAbilOk.Enabled := False;
    DStateAbilExit.Enabled := False;
    DStateAbilAdd1.Enabled := False;
    DStateAbilAdd2.Enabled := False;
    DStateAbilAdd3.Enabled := False;
    DStateAbilAdd4.Enabled := False;
    DStateAbilAdd5.Enabled := False;
    DStateAbilAdd6.Enabled := False;
    DStateAbilDel1.Enabled := False;
    DStateAbilDel2.Enabled := False;
    DStateAbilDel3.Enabled := False;
    DStateAbilDel4.Enabled := False;
    DStateAbilDel5.Enabled := False;
    DStateAbilDel6.Enabled := False;
  end;
end;

procedure TFrmDlg.DMenuDlgDirectPaint(Sender: TObject; dsurface: TDXTexture);
var
  d: TDXTexture;
  ax, ay: integer;
begin
  with Sender as TDWindow do begin
    ax := SurfaceX(Left);
    ay := SurfaceY(Top);
    d := WLib.Images[FaceIndex];
    if d <> nil then
      DrawWindow(dsurface, ax, ay, d);
  end;
  with g_DXCanvas do begin
    FillRect(aX+18, ay+48, 263, 18, $FF000000);
    TextOut(ax + 19, ay + 49, $FFFFFF,'Goods'); //(Width - TextWidth(Caption)) div 2, ay + (Height - TextHeight(Caption)) div 2 + 1, $FFFFFF, Caption);
    TextOut(ax + 260-TextWidth('Price'), ay + 49, $FFFFFF,'Price');
  end;
end;

procedure TFrmDlg.DMenuDlgVisible(Sender: TObject; boVisible: Boolean);
begin
  NpcGoodsIdx := 0;
  g_CursorMode := cr_None;
  FrmMain.Cursor := crMyNone;
  LastestClickTime := FrmMain.m_CurrentTick;
  if boVisible then begin
    g_SellDlgItemSellWait.Item.s.name := '';
    DItemBag.Visible := True;
    DMerchantDlg.Visible := False;
  end
  else begin
    DStateWin.Visible := boOpenStatus;
    DItemBag.Visible := boOpenItemBag;
    //DMerchantDlg.Visible := MDlgVisible;
    DWndBuy.Visible := False;
    ClearGoodsList;
  end;
end;

procedure TFrmDlg.DMenuGridGridMouseMove(Sender: TObject; X, Y: integer; ACol, ARow: Integer; Shift: TShiftState);
var
  idx: Integer;
  cu: pTNewClientItem;
  nPic: Integer;
begin
  with Sender as TDGrid do begin
    if NpcGoodsIdx = 0 then begin
      idx := ACol + ARow * ColCount + DMenuUpDonw.Position {* RowCount};
      if (Length(NpcGoodItems) > 0) and (idx in [Low(NpcGoodItems)..High(NpcGoodItems)]) then begin
        if NpcGoodItems[idx].ClientItem.s.Name <> '' then begin
          DScreen.ShowHint(SurfaceX(Left + (x - left)) + 30, SurfaceY(Top + (y - Top) + 30),
            ShowItemInfo(NpcGoodItems[idx].ClientItem, [mis_buy], [NpcGoodItems[idx].nItemPic, Integer(NpcBindGold)]),
            clwhite, False, idx, True);
        end;
      end;
    end
    else begin
      idx := ACol + ARow * ColCount;
      if (idx >= 0) and (idx < NpcReturnItemList.Count) then begin
        cu := NpcReturnItemList[idx];
        nPic := GetUserItemPrice(@cu.UserItem, @cu.s) div 2 * 3;
        DScreen.ShowHint(SurfaceX(Left + (x - left)), SurfaceY(Top + (y - Top) + 30),
          ShowItemInfo(cu^, [mis_buy], [nPic, 0]), clwhite, False, idx, True);
      end;
    end;
  end;
end;

procedure TFrmDlg.DMenuGridGridPaint(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState;
  dsurface: TDXTexture);
var
  d: TDXTexture;
  idx: Integer;
  cu: pTNewClientItem;
  str: string;
begin
  with Sender as TDGrid do begin

    if NpcGoodsIdx = 0 then begin //buy
      idx := ACol + ARow * ColCount + DMenuUpDonw.Position {* RowCount};
      if nShopSelectionIdx <> idx then
        d:=g_WMain99Images.Images[1645]
      else
        d:=g_WMain99Images.Images[1645+1];
      if d <> nil then
        dsurface.Draw(SurfaceX(Rect.Left), SurfaceY(Rect.Top), d.ClientRect, d, True);
      if (Length(NpcGoodItems) > 0) and (idx in [Low(NpcGoodItems)..High(NpcGoodItems)]) then begin
        if NpcGoodItems[idx].ClientItem.S.name <> '' then begin
          d := GetBagItemImg(NpcGoodItems[idx].ClientItem.S.looks);
          if d <> nil then begin
            RefItemPaint(dsurface, d,
              SurfaceX(Rect.Left)+5,
              SurfaceY(Rect.Top + (RowHeight - d.Height) div 2),
              SurfaceX(Rect.Right),
              SurfaceY(Rect.Bottom) - 1,
              @NpcGoodItems[idx].ClientItem, False);
          end;
          if NpcGoodItems[idx].nStock > 30000 then
            str:= '*' + NpcGoodItems[idx].ClientItem.S.name
          else
            str:= NpcGoodItems[idx].ClientItem.S.name;
          g_DXCanvas.TextOut(SurfaceX(Rect.Left) + 47, SurfaceY(Rect.Top) +  (RowHeight-g_DXCanvas.TextHeight(str)) div 2, $ADD6EF,str);
          str := IntToStr((NpcGoodItems[idx].ClientItem.s.Price * g_nCurMerRate) div 100);
          g_DXCanvas.TextOut(SurfaceX(Rect.Right) - g_DXCanvas.TextWidth(str) - 6, SurfaceY(Rect.Top) +  (RowHeight-g_DXCanvas.TextHeight(str)) div 2, $ADD6EF,str);
        end;
      end;
    end
    else begin //buyback
      idx := ACol + ARow * ColCount;
      if nShopSelectionIdx <> idx then
        d:=g_WMain99Images.Images[1645]
      else
        d:=g_WMain99Images.Images[1645+1];
//      d:=g_WMain99Images.Images[1645];
      if d <> nil then
        dsurface.Draw(SurfaceX(Rect.Left), SurfaceY(Rect.Top), d.ClientRect, d, True);
      if (idx >= 0) and (idx < NpcReturnItemList.Count) then begin
        cu := NpcReturnItemList[idx];
        if cu.S.name <> '' then begin
          d := GetBagItemImg(cu.S.looks);
          if d <> nil then begin
            RefItemPaint(dsurface, d,
              SurfaceX(Rect.Left) + 5,
              SurfaceY(Rect.Top  + (RowHeight - d.Height) div 2 { + 1}),
              SurfaceX(Rect.Right),
              SurfaceY(Rect.Bottom) - 1,
              cu, False);
          end;
          str:= cu.S.name;
          g_DXCanvas.TextOut(SurfaceX(Rect.Left) + 47, SurfaceY(Rect.Top) +  (RowHeight-g_DXCanvas.TextHeight(str)) div 2, $ADD6EF,str);
        end;
      end;
    end;
  end;
end;

procedure TFrmDlg.DMenuGridGridSelect(Sender: TObject; X, Y, ACol, ARow: Integer; Shift: TShiftState);
var
  idx: Integer;
  nCount: Integer;
begin
  if g_SellDlgItemSellWait.Item.s.name <> '' then
    exit;
  with Sender as TDGrid do begin
    if not g_boItemMoving then begin
      if NpcGoodsIdx = 0 then begin
        idx := ACol + ARow * ColCount + DMenuUpDonw.Position {* RowCount};
        nShopSelectionIdx := idx;
        if (Length(NpcGoodItems) > 0) and (idx in [Low(NpcGoodItems)..High(NpcGoodItems)]) then begin
          if NpcGoodItems[idx].ClientItem.s.name <> '' then begin
            if NpcGoodItems[idx].nStock > 30000 then begin
              if LastSubListRequest + 5000 < FrmMain.m_CurrentTick then begin
                LastSubListRequest := FrmMain.m_CurrentTick;
                FrmMain.SendClientMessage(CM_REQUESTSUBLIST, 0, GetBuyGoodsIndex(NpcGoodItems[idx]), 0, 0, '');
              end;
            end;
          end;
        end;
      end
      else begin
        idx := ACol + ARow * ColCount;
        nShopSelectionIdx:= idx;
      end;
    end;
  end;
end;

procedure TFrmDlg.RefMenuSellBtns();
{
const
  CDMenuBtnPos: array [0 .. 5] of TSmallPoint = (//
    (X: 15; Y: 224),
    (X: 15; Y: 252),
    (X: 79; Y: 224),
    (X: 79; Y: 252),
    (X: 142; Y: 224),
    (X: 142; Y: 252)
  );
}
begin
  //DMenuBuy.Visible := (g_nCurMerFlag or 1 = g_nCurMerFlag);
  DMenuSell.Visible := (g_nCurMerFlag or 2 = g_nCurMerFlag);
  //DMenuRepair.Visible := (g_nCurMerFlag or 4 = g_nCurMerFlag);
  //DMenuSuperRepair.Visible := (g_nCurMerFlag or 8 = g_nCurMerFlag);
  //DMenuRepairAll.Visible := (g_nCurMerFlag or 4 = g_nCurMerFlag);
  //DMenuSuperRepairAll.Visible := (g_nCurMerFlag or 8 = g_nCurMerFlag);
end;


procedure TFrmDlg.DMenuSellClick(Sender: TObject; X, Y: Integer);
var
  nMoney: Integer;
  i: integer;
  ShowStr: string;
  Item: TNewClientItem;
begin

  if Sender = DMenuBuy then begin
    if NpcGoodsIdx = 0 then begin
      if (Length(NpcGoodItems) > 0) and (nShopSelectionIdx in [Low(NpcGoodItems)..High(NpcGoodItems)]) then begin
        if NpcGoodItems[nShopSelectionIdx].ClientItem.s.name <> '' then begin
          if (sm_Superposition in NpcGoodItems[nShopSelectionIdx].ClientItem.s.StdModeEx) and (NpcGoodItems[nShopSelectionIdx].ClientItem.s.DuraMax > 1) then begin
            BuyGoods := NpcGoodItems[nShopSelectionIdx];
            DBuyEdit.Text := '1';
            DBuyEditChange(DBuyEdit);
            DWndBuy.Visible := True;
            DBuyEdit.SetFocus;
          end else begin
            if  (nShopSelectionIdx >= 0) and (nShopSelectionIdx < 60000) then begin
              frmMain.SendBuyItem(g_nCurMerchant, nShopSelectionIdx, 1, 0, NpcBindGold, NpcGoodItems[nShopSelectionIdx].ClientItem.s.name);
              g_SellDlgItemSellWait.Item.UserItem.MakeIndex := 0;
              g_SellDlgItemSellWait.Item.S.name := NpcGoodItems[nShopSelectionIdx].ClientItem.s.name;
            end
          end;
        end;
      end;
    end
    else begin
      if (nShopSelectionIdx >= 0) and (nShopSelectionIdx < NpcReturnItemList.Count) then begin
        g_SellDlgItemSellWait.Item := pTNewClientItem(NpcReturnItemList[nShopSelectionIdx])^;
        g_SellDlgItemSellWait.Index2 := nShopSelectionIdx;
        FrmMain.SendClientMessage(CM_USERBUYRETURNITEM, g_nCurMerchant,
          LoWord(g_SellDlgItemSellWait.Item.UserItem.MakeIndex),
          HiWord(g_SellDlgItemSellWait.Item.UserItem.MakeIndex), nShopSelectionIdx);
      end;
    end;
  end
  else
  if Sender = DMenuSell then begin
    if (g_nCurMerFlag or 2 <> g_nCurMerFlag) then
      exit;
    DSaleDlg.Visible := true;
    nSellMode := 0;
  end
  else if Sender = DMenuRepair then begin
    if (g_nCurMerFlag or 4 <> g_nCurMerFlag) then
     exit;
    //if not DStateWin.Visible then begin
    //  StatePage := 0;
    //  PageChanged;
    //  DStateWin.Visible := True;
    //end;
    boSuperRepair := False;
    DSaleDlg.Visible := true;
    nSellMode := 1;
  end
  else if Sender = DMenuSuperRepair then begin
    if (g_nCurMerFlag or 8 <> g_nCurMerFlag) then
      exit;
    //if not DStateWin.Visible then begin
    //  StatePage := 0;
    //  PageChanged;
    //  DStateWin.Visible := True;
    //end;
    boSuperRepair := True;
    DSaleDlg.Visible := true;
    nSellMode := 2;
  end;
  {
  else if (Sender = DMenuRepairAll) or (Sender = DMenuSuperRepairAll) then begin
    if (Sender = DMenuRepairAll) and (g_nCurMerFlag or 4 <> g_nCurMerFlag) then
      exit;
    if (Sender = DMenuSuperRepairAll) and (g_nCurMerFlag or 8 <> g_nCurMerFlag) then
      exit;
    nMoney := 0;
    for I := Low(g_UseItems) to High(g_UseItems) do begin
      if g_UseItems[i].s.name <> '' then begin
        if (sm_Arming in g_UseItems[i].s.StdModeEx) and
          (not (CheckItemBindMode(@g_UseItems[i].UserItem, bm_NoRepair))) and
          (g_UseItems[i].UserItem.Dura < g_UseItems[i].UserItem.DuraMax) then begin
          nMoney := nMoney + GetRepairItemPrice(@g_UseItems[i].UserItem, @g_UseItems[i].s);
        end;
      end;
    end;
    if g_UseItems[U_House].S.name <> '' then begin
      for I := Low(g_UseItems[U_House].UserItem.HorseItems) to High(g_UseItems[U_House].UserItem.HorseItems) do begin
        if g_UseItems[U_House].UserItem.HorseItems[I].wIndex > 0 then begin
          Item := HorseItemToClientItem(@g_UseItems[U_House].UserItem.HorseItems[I]);
          if (Item.S.name <> '') and (not (CheckItemBindMode(@Item.UserItem, bm_NoRepair))) and
            (Item.UserItem.Dura < Item.s.DuraMax) then begin
            nMoney := nMoney + GetRepairItemPrice(@Item.UserItem, @Item.s);
          end;
        end;
      end;
    end;
    if Sender = DMenuSuperRepairAll then
      nMoney := nMoney * 3;
    if nMoney > 0 then begin
      ShowStr := 'Total cost to repair equipment: ' + GetGoldStr(nMoney) + ' ' + g_sGoldName + '。';
      if g_MySelf.m_nGold < nMoney then
        ShowStr := ShowStr + '\Not enough gold，not all equipment may be repaired，do you wish to continue?'
      else
        ShowStr := ShowStr + 'Are you sure you want to repair?';
      if mrYes = FrmDlg.DMessageDlg(ShowStr, [mbYes, mbNo]) then begin
        frmMain.SendRepairItem(g_nCurMerchant, 0, MakeWord(Integer(Sender = DMenuSuperRepairAll), 0));
      end;
    end
    else
      DMessageDlg('Could not repair.', []);
  end;
  }
  if DStateWin.Visible then
    DStateWin.Visible := boOpenStatus;
end;

procedure TFrmDlg.DMenuShopClick(Sender: TObject; X, Y: Integer);
begin
  nShopSelectionIdx := -1;
  nSubShopSelectionIdx := -1;
  with Sender as TDButton do begin
    if Tag in [0, 1] then begin
      if NpcGoodsIdx <> Tag then begin
        if Tag = 0 then begin
          if High(NpcGoodItems) > 0 then
            DMenuUpDonw.MaxPosition := High(NpcGoodItems) - DMenuGrid.RowCount + 1 {div DMenuGrid.RowCount}
          else
            DMenuUpDonw.MaxPosition := 0;
        end
        else
          DMenuUpDonw.MaxPosition := 0;
        NpcGoodsIdx := Tag;
        PlaySound(s_glass_button_click);
        DWndBuy.Visible := False;
      end;
    end;
  end;
end;

procedure TFrmDlg.DMenuShopDirectPaint(Sender: TObject; dsurface: TDXTexture);
var
  d: TDXTexture;
  ax,ay: integer;
begin
  with Sender as TDButton do begin
    ax := SurfaceX(Left);
    ay := SurfaceY(Top);
    if NpcGoodsIdx = tag then
      d := WLib.Images[FaceIndex+1]
    else
      d := WLib.Images[FaceIndex];
    if d <> nil then
      dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, True);

    with g_DXCanvas do begin
      TextOut(ax + (Width - TextWidth(Caption)) div 2, ay + (Height - TextHeight(Caption)) div 2 + 1, DFColor, Caption);
    end;
  end;
end;

procedure TFrmDlg.DUSHorseReinDirectPaint(Sender: TObject; dsurface: TDXTexture);
var
  d: TDXTexture;
//  where: integer;
  //boDraw: Boolean;
//  nInt: Integer;
//  showstr: string;
  pRect: TRect;
  Item: TNewClientItem;
begin
  with Sender as TDButton do begin
    FillChar(Item, SizeOf(Item), #0);
    if (Tag in [Low(UserState1.UseItems)..High(UserState1.UseItems)]) then begin
      Item := UserState1.UseItems[Tag];
    end else
    if Tag in [16..20] then begin
      if UserState1.UseItems[U_HOUSE].S.Name <> '' then begin
        Item := HorseItemToClientItem(@UserState1.UseItems[U_HOUSE].UserItem.HorseItems[Tag - 16]);
      end;
    end;
    if Item.S.name <> '' then begin
      d := GetBagItemImg(Item.S.looks);
      if d <> nil then begin
        pRect.Left := SurfaceX(Left - 1);
        pRect.Top := SurfaceY(Top - 1);
        pRect.Right := SurfaceX(Left + Width + 1);
        pRect.Bottom := SurfaceY(Top + Height + 1);
        RefItemPaint(dsurface, d, //人物背包栏
          SurfaceX(Left + (Width - d.Width) div 2),
          SurfaceY(Top + (Height - d.Height) div 2),
          1,
          1,
          @Item, False, [pmShowLevel], @pRect);
      end;
    end;
  end;
end;

procedure TFrmDlg.DUSHorseReinMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
var
  nLocalX, nLocalY: Integer;
  nHintX, nHintY: Integer;
  sel: Integer;
  //MoveItemState: TMoveItemState;
  Item: TNewClientItem;
begin
  with Sender as TDControl do begin
    if DParent = nil then exit;
    nLocalX := LocalX(X - Left);
    nLocalY := LocalY(Y - Top);
    nHintX := SurfaceX(Left) + DParent.SurfaceX(DParent.Left) + nLocalX + 30;
    nHintY := SurfaceY(Top) + DParent.SurfaceY(DParent.Top) + nLocalY + 30;
    sel := Tag;
    FillChar(Item, SizeOf(Item), #0);
    if (sel in [Low(UserState1.UseItems)..High(UserState1.UseItems)]) then begin
      Item := UserState1.UseItems[sel];
    end else
    if sel in [16..20] then begin
      if UserState1.UseItems[U_HOUSE].S.Name <> '' then begin
        Item := HorseItemToClientItem(@UserState1.UseItems[U_HOUSE].UserItem.HorseItems[sel - 16]);
      end;
    end;
    if Item.s.Name <> '' then begin
      DScreen.ShowHint(nHintX, nHintY, ShowItemInfo(Item, [], []), clwhite, False, Integer(Sender), True);
    end;
    //end;
  end;
end;

procedure TFrmDlg.DButRenewChrDirectPaint(Sender: TObject; dsurface: TDXTexture);
var
  d: TDXTexture;
begin
  with Sender as TDButton do begin
    if WLib <> nil then begin
      if Downed then begin
        d := WLib.Images[FaceIndex + 1];
      end
      else
        d := WLib.Images[FaceIndex];
      if d <> nil then
        dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, True);
    end;
  end;
end;

procedure TFrmDlg.DButtonTopClick(Sender: TObject; X, Y: Integer);
begin
  FrmMain.SendClientMessage(CM_GETRANKING,0,0,0,0, g_MySelf.m_UserName);
end;

procedure TFrmDlg.DBuyAddClick(Sender: TObject; X, Y: Integer);
var
  nCount: integer;
begin
  nCount := StrToIntDef(DBuyEdit.Text, 0);
  if Sender = DBuyAdd then
    inc(nCount)
  else begin
    if nCount > 0 then
      Dec(nCount);
  end;
  DBuyEdit.Text := intToStr(nCount);
  DBuyEditChange(DBuyEdit);
end;

procedure TFrmDlg.DBuyAddDirectPaint(Sender: TObject; dsurface: TDXTexture);
var
  d: TDXTexture;
begin
  with Sender as TDButton do begin
    if WLib <> nil then begin
      if Downed then begin
        d := WLib.Images[FaceIndex];
        if d <> nil then
          dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, False);
      end;
    end;
  end;
end;

function TFrmDlg.GetBuyGoodsIndex(ClientGoods: TClientGoods): Integer;
var
  i: integer;
begin
  Result := 65535;
  for I := 0 to NpcGoodsList.Count - 1 do begin
    if PTClientGoods(NpcGoodsList[i]).ClientItem.s.Idx =
      ClientGoods.ClientItem.s.Idx then begin
      Result := I;
      break;
    end;
  end;
end;

function TFrmDlg.GetBuyCount(nQueryCount: Integer; ClientGoods: TClientGoods; boBindGold: Boolean): Integer;
var
  pGold: pInteger;
  BagCount: Integer;
begin
  Result := nQueryCount;
  if g_MySelf = nil then
    exit;
  if boBindGold then
    pGold := @g_nBindGold
  else
    pGold := @g_MySelf.m_nGold;
  if (ClientGoods.nItemPic * Result) > pGold^ then begin
    Result := pGold^ div ClientGoods.nItemPic;
  end;
  BagCount := _MIN(10, GetBagResidualCount());
  if Result > 0 then begin
    if (sm_Superposition in ClientGoods.ClientItem.s.StdModeEx) and (ClientGoods.ClientItem.s.DuraMax > 1) then begin
      if BagCount > 0 then begin
        if Result > ClientGoods.ClientItem.s.DuraMax then
          Result := ClientGoods.ClientItem.s.DuraMax
      end
      else
        Result := 0;
    end
    else if Result > BagCount then
      Result := BagCount;
  end;
end;

procedure TFrmDlg.DBuyEditChange(Sender: TObject);
begin
  DBuyEdit.OnChange := nil;
  try
    {nCount := StrToIntDef(DBuyEdit.Text, 0);
    {if (BuyGoods.nItemPic * nCount) > g_MySelf.m_nGold then begin
      nCount := g_MySelf.m_nGold div BuyGoods.nItemPic;
    end;
    BagCount := GetBagResidualCount();
    if nCount > 0 then begin
      if sm_Superposition in BuyGoods.ClientItem.s.StdModeEx then begin
        if BagCount > 0 then begin
          if nCount > BuyGoods.ClientItem.s.DuraMax then
            nCount := BuyGoods.ClientItem.s.DuraMax
        end
        else
          nCount := 0;
      end
      else if nCount > BagCount then
        nCount := BagCount;
    end;     }
    DBuyEdit.Text := IntToStr(GetBuyCount(StrToIntDef(DBuyEdit.Text, 0), BuyGoods, NpcBindGold));
  finally
    DBuyEdit.OnChange := DBuyEditChange;
  end;

end;

procedure TFrmDlg.DBuyEditKeyPress(Sender: TObject; var Key: Char);
begin
  if byte(Key) = 13 then begin
    DBuyOKClick(DBuyOk, 0, 0);
    Key := #0;
  end;
  if byte(Key) = 27 then begin
    DWndBuy.Visible := FALSE;
    Key := #0;
  end;
end;

procedure TFrmDlg.DBuyOKClick(Sender: TObject; X, Y: Integer);
var
  nCount: integer;
  idx: integer;
begin
  if g_SellDlgItemSellWait.Item.S.name <> '' then
    exit;
  nCount := StrToIntDef(DBuyEdit.Text, 0);
  idx := GetBuyGoodsIndex(buyGoods);
  if (Length(NpcGoodItems) > 0) and (nCount > 0) and (idx >= 0) and (idx < 60000) then begin
    frmMain.SendBuyItem(g_nCurMerchant, idx, nCount, 0, NpcBindGold,buyGoods.ClientItem.s.name);
    g_SellDlgItemSellWait.Item.UserItem.MakeIndex := 0;
    g_SellDlgItemSellWait.Item.S.name := buyGoods.ClientItem.s.name;
  end;
  DWndBuy.Visible := False;
end;

procedure TFrmDlg.DCBGroupItemDefClick(Sender: TObject; X, Y: Integer);
begin
  if Sender = DCBGroupItemDef then begin
    DCBGroupItemDef.Checked := True;
    DCBGroupItemRam.Checked := False;
  end
  else if Sender = DCBGroupItemRam then begin
    DCBGroupItemRam.Checked := True;
    DCBGroupItemDef.Checked := False;
  end;
  g_GroupItemMode := DCBGroupItemRam.Checked;
end;

procedure TFrmDlg.DccManWarriorDirectPaint(Sender: TObject; dsurface: TDXTexture);
var
  d: TDXTexture;
  Idx: Integer;
begin
  with Sender as TDButton do begin
    Idx := btJob * 10 + btSex;
    if Idx = Tag then d := WLib.Images[FaceIndex]
    else d := WLib.Images[FaceIndex + 1];
    if d <> nil then
      dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, True);
  end;
end;

procedure TFrmDlg.DccWarriorDirectPaint(Sender: TObject; dsurface: TDXTexture);
var
  d: TDXTexture;
begin
  with Sender as TDButton do begin
    if (Tag = btJob) or ((Tag - 10) = btSex) then begin
      d := WLib.Images[FaceIndex - 5];
      if d <> nil then
        dsurface.Draw(SurfaceX(Left) - 1, SurfaceY(Top) - 1, d.ClientRect, d, True);
    end else
    if Downed then begin
      d := WLib.Images[FaceIndex];
      if d <> nil then
        dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, True);
    end;
  end;
end;

procedure TFrmDlg.DccWarriorMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  //X := DCreateChr.SurfaceX(DCreateChr.Left);
  //y := DCreateChr.SurfaceY(DCreateChr.Top);
end;

procedure TFrmDlg.dchkSayLockChange(Sender: TObject);
begin
  g_SayUpDownLock := not dchkSayLock.Checked;
end;

procedure TFrmDlg.DCloseSayHearClick(Sender: TObject; X, Y: Integer);
begin
  if FrmMain.m_CurrentTick < TDButton(Sender).AppendTick then Exit;
  TDButton(Sender).AppendTick := FrmMain.m_CurrentTick + 200;
  if Sender = DCloseSayHear then begin
    SetIntStatus(g_nGameSetupData, GSP_NOTSAYHEAR, not CheckIntStatus(g_nGameSetupData, GSP_NOTSAYHEAR));
    frmMain.SendGroupMode;
  end else
  if Sender = DCloseSayWhisper then begin
    SetIntStatus(g_nGameSetupData, GSP_NOTSAYWHISPER, not CheckIntStatus(g_nGameSetupData, GSP_NOTSAYWHISPER));
    frmMain.SendGroupMode;
  end else
  if Sender = DCloseSayCry then begin
    SetIntStatus(g_nGameSetupData, GSP_NOTSAYCRY, not CheckIntStatus(g_nGameSetupData, GSP_NOTSAYCRY));
    frmMain.SendGroupMode;
  end else
  if Sender = DCloseSayGuild then begin
    SetIntStatus(g_nGameSetupData, GSP_NOTSAYGUILD, not CheckIntStatus(g_nGameSetupData, GSP_NOTSAYGUILD));
    frmMain.SendGroupMode;
  end else
  if Sender = DCloseSayGroup then begin
    SetIntStatus(g_nGameSetupData, GSP_NOTSAYGROUP, not CheckIntStatus(g_nGameSetupData, GSP_NOTSAYGROUP));
    frmMain.SendGroupMode;
  end;
end;

procedure TFrmDlg.DCloseSayHearDirectPaint(Sender: TObject; dsurface: TDXTexture);
var
  d: TDXTexture;
  boClick: Boolean;
begin
  boClick := False;
  if Sender = DCloseSayHear then begin
    boClick := CheckIntStatus(g_nGameSetupData, GSP_NOTSAYHEAR);
  end else
  if Sender = DCloseSayWhisper then begin
    boClick := CheckIntStatus(g_nGameSetupData, GSP_NOTSAYWHISPER);
  end else
  if Sender = DCloseSayCry then begin
    boClick := CheckIntStatus(g_nGameSetupData, GSP_NOTSAYCRY);
  end else
  if Sender = DCloseSayGuild then begin
    boClick := CheckIntStatus(g_nGameSetupData, GSP_NOTSAYGUILD);
  end else
  if Sender = DCloseSayGroup then begin
    boClick := CheckIntStatus(g_nGameSetupData, GSP_NOTSAYGROUP);
  end;
  with Sender as TDButton do begin
    if WLib <> nil then begin
      d := WLib.Images[FaceIndex + Integer(boClick)];
      if d <> nil then
        dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, True);
    end;
  end;

  {
  dchkSayHear.Checked := CheckIntStatus(g_nGameSetupData, GSP_NOTSAYHEAR);
    dchkSayWhisper.Checked := CheckIntStatus(g_nGameSetupData, GSP_NOTSAYWHISPER);
    dchkSayCry.Checked := CheckIntStatus(g_nGameSetupData, GSP_NOTSAYCRY);
    dchkSayGroup.Checked := CheckIntStatus(g_nGameSetupData, GSP_NOTSAYGROUP);
    dchkSayGuild.Checked := CheckIntStatus(g_nGameSetupData, GSP_NOTSAYGUILD);


  SetIntStatus(g_nGameSetupData, GSP_NOTSAYHEAR, dchkSayHear.Checked);
  SetIntStatus(g_nGameSetupData, GSP_NOTSAYWHISPER, dchkSayWhisper.Checked);
  SetIntStatus(g_nGameSetupData, GSP_NOTSAYCRY, dchkSayCry.Checked);
  SetIntStatus(g_nGameSetupData, GSP_NOTSAYGROUP, dchkSayGroup.Checked);
  SetIntStatus(g_nGameSetupData, GSP_NOTSAYGUILD, dchkSayGuild.Checked); }
end;

procedure TFrmDlg.DCloseSayHearMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
var
  ShowMsg: string;
begin
  with Sender as TDControl do begin
    X := SurfaceX(Left);
    y := SurfaceY(Top-20);
    ShowMsg := '';
    if Sender = DCloseSayHear then begin
      ShowMsg := 'Reject nearby chat';
    end else
    if Sender = DCloseSayWhisper then begin
      ShowMsg := 'Reject Whispers';
    end else
    if Sender = DCloseSayCry then begin
      ShowMsg := 'Reject Shouts';
    end else
    if Sender = DCloseSayGuild then begin
      ShowMsg := 'Reject Guild Messages';
    end else
    if Sender = DCloseSayGroup then begin
      ShowMsg := 'Reject Group Messages';
    end;
  end;
  if ShowMsg <> '' then
    DScreen.ShowHint(x, y, ShowMsg, clWhite, False, Integer(Sender));
end;

procedure TFrmDlg.DCreateChrDirectPaint(Sender: TObject; dsurface: TDXTexture);
var
  d: TDXTexture;
  ax, ay: integer;
  n: Integer;
begin
  with Sender as TDWindow do begin
    ax := SurfaceX(Left);
    ay := SurfaceY(Top);
    d := WLib.Images[FaceIndex];
    if d <> nil then
      DrawWindow(dsurface, ax, ay, d);
    with g_DXCanvas do begin
      n:= SelectChrScene.NewIndex;
      if SelectChrScene.ChrArr[n].Selected then begin
        If (SelectChrScene.ChrArr[n].UserChr.job = 0) and (SelectChrScene.ChrArr[n].UserChr.Sex = 0) then
          d:= g_WUI3Images.Images[2874];
        If (SelectChrScene.ChrArr[n].UserChr.job = 0) and (SelectChrScene.ChrArr[n].UserChr.Sex = 1) then
          d:= g_WUI3Images.Images[2879];
        If (SelectChrScene.ChrArr[n].UserChr.job = 1) and (SelectChrScene.ChrArr[n].UserChr.Sex = 0) then
          d:= g_WUI3Images.Images[2872];
        If (SelectChrScene.ChrArr[n].UserChr.job = 1) and (SelectChrScene.ChrArr[n].UserChr.Sex = 1) then
          d:= g_WUI3Images.Images[2877];
        If (SelectChrScene.ChrArr[n].UserChr.job = 2) and (SelectChrScene.ChrArr[n].UserChr.Sex = 0) then
          d:= g_WUI3Images.Images[2871];
        If (SelectChrScene.ChrArr[n].UserChr.job = 2) and (SelectChrScene.ChrArr[n].UserChr.Sex = 1) then
          d:= g_WUI3Images.Images[2876];
        If (SelectChrScene.ChrArr[n].UserChr.job = 3) and (SelectChrScene.ChrArr[n].UserChr.Sex = 0) then
          d:= g_WUI3Images.Images[2870];
        If (SelectChrScene.ChrArr[n].UserChr.job = 3) and (SelectChrScene.ChrArr[n].UserChr.Sex = 1) then
          d:= g_WUI3Images.Images[2875];
        If (SelectChrScene.ChrArr[n].UserChr.job = 4) and (SelectChrScene.ChrArr[n].UserChr.Sex = 0) then
          d:= g_WUI3Images.Images[2873];
        If (SelectChrScene.ChrArr[n].UserChr.job = 4) and (SelectChrScene.ChrArr[n].UserChr.Sex = 1) then
          d:= g_WUI3Images.Images[2878];
      end;
      with g_DXCanvas do begin
        if d <> nil then
          dsurface.Draw(SurfaceX(Left) + 114, SurfaceY(Top) + 275, d.ClientRect, d, True);
      end;
    end;
  end;
end;

procedure TFrmDlg.DCreateChrVisible(Sender: TObject; boVisible: Boolean);
begin
  if boVisible then begin
    SelectChrScene.SelChrNewJob(btJob);
    SelectChrScene.SelChrNewm_btSex(btSex);
  end;
end;

procedure TFrmDlg.DDealCloseClick(Sender: TObject; X, Y: Integer);
begin
  if FrmMain.m_CurrentTick > g_dwDealActionTick then begin
    CloseDealDlg;
    frmMain.SendCancelDeal;
  end;
end;

procedure TFrmDlg.DDealDlgDirectPaint(Sender: TObject; dsurface: TDXTexture);
var
  d: TDXTexture;
  ax, ay: integer;
begin
  with Sender as TDWindow do begin
    ax := SurfaceX(Left);
    ay := SurfaceY(Top);
    d := WLib.Images[FaceIndex];
    if d <> nil then
      DrawWindow(dsurface, ax, ay, d);

    with g_DXCanvas do begin
      TextOut(ax + 97, ay + 30, g_sDealWho, clWhite);
      TextOut(ax + 28, ay + 134, g_sGoldName + ': ' + GetGoldStr(g_nDealRemoteGold), clWhite);
      TextOut(ax + 28, ay + 254, g_sGoldName + ': ' + GetGoldStr(g_nDealGold), clWhite);
    end;
  end;
end;

procedure TFrmDlg.DDealLockClick(Sender: TObject; X, Y: Integer);
begin
  if FrmMain.m_CurrentTick > g_dwDealActionTick then begin
    frmMain.SendDealLock;
    g_dwDealActionTick := FrmMain.m_CurrentTick + 1000;
    g_boDealLock := True;
    DDealOk.Enabled := DDRDealLock.Checked;
    DDealLock.Enabled := False;
  end;
end;

procedure TFrmDlg.DDealOkClick(Sender: TObject; X, Y: Integer);
begin
  if FrmMain.m_CurrentTick > g_dwDealActionTick then begin
    frmMain.SendDealEnd;
    g_dwDealActionTick := FrmMain.m_CurrentTick + 4000;
    g_boDealEnd := True;
    DDealOk.Enabled := False;
    DDealLock.Enabled := False;
  end;
end;

procedure TFrmDlg.DDGoldClick(Sender: TObject; X, Y: Integer);
var
  DGold: Integer;
  valstr: string;
begin
  if g_MySelf = nil then
    Exit;
  if (not g_boDealEnd) and (not g_boDealLock) and (FrmMain.m_CurrentTick > g_dwDealActionTick) then begin
    if not g_boItemMoving then begin
      if g_nDealGold > 0 then begin
        PlaySound(s_money);
        g_boItemMoving := True;
        g_MovingItem.Index2 := -97; //背券 芒俊辑狼 捣
        g_MovingItem.ItemType := mtDealGold;
        g_MovingItem.Item.S.name := g_sGoldName {'金币'};
      end;
    end
    else begin
      if (g_MovingItem.ItemType = mtDealGold) or (g_MovingItem.ItemType = mtBagGold) then begin
        if (g_MovingItem.ItemType = mtBagGold) and (g_MovingItem.Item.S.name = g_sGoldName) then begin
          g_boItemMoving := FALSE;
          g_MovingItem.Item.S.name := '';
          DMessageDlg('Please enter amount of ' + g_sGoldName + ' to be placed:', [mbOk, mbAbort]);
          GetValidStrVal(DlgEditText, valstr, [' ']);
          DGold := StrToIntDef(valstr, 0);
          if (DGold <= (g_nDealGold + g_MySelf.m_nGold)) and (DGold > 0) then begin
            frmMain.SendChangeDealGold(DGold);
            g_dwDealActionTick := FrmMain.m_CurrentTick + 4000;
          end;
        end;
        g_boItemMoving := FALSE;
        g_MovingItem.Item.S.name := '';
      end;
    end;
  end;
end;

procedure TFrmDlg.DDGridGridMouseMove(Sender: TObject; X, Y: integer; ACol, ARow: Integer; Shift: TShiftState);
var
  idx: Integer;
begin
  with Sender as TDGrid do begin
    idx := ACol + ARow * DDGrid.ColCount;
    if idx in [0..MAXDEALITEMCOUNT - 1] then begin
      if g_DealItems[idx].s.Name <> '' then begin
        with DDGrid do
          DScreen.ShowHint(SurfaceX(Left + (x - left)), SurfaceY(Top + (y - Top) + 30),
            ShowItemInfo(g_DealItems[idx], [mis_MyDeal], []), clwhite, False, idx, True);
      end;
    end;
  end;
end;

procedure TFrmDlg.DDGridGridPaint(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState;
  dsurface: TDXTexture);
var
  idx: Integer;
  d: TDXTexture;
  pRect: TRect;
begin
  idx := ACol + ARow * DDGrid.ColCount;
  if idx in [0..MAXDEALITEMCOUNT - 1] then begin
    if g_DealItems[idx].S.name <> '' then begin
      d := GetBagItemImg(g_DealItems[idx].S.looks);
      if d <> nil then
        with DDGrid do begin //交易窗口
          pRect.Left := SurfaceX(Rect.Left);
          pRect.Top := SurfaceY(Rect.Top);
          pRect.Right := SurfaceX(Rect.Right + 1);
          pRect.Bottom := SurfaceY(Rect.Bottom);
          RefItemPaint(dsurface, d,
            SurfaceX(Rect.Left + (ColWidth - d.Width) div 2 - 1),
            SurfaceY(Rect.Top + (RowHeight - d.Height) div 2 + 1),
            SurfaceX(Rect.Right),
            SurfaceY(Rect.Bottom) - 12,
            @g_DealItems[idx], True, [pmShowLevel], @pRect);
        end;
    end;
  end;
end;

procedure TFrmDlg.DDGridGridSelect(Sender: TObject; X, Y: integer; ACol, ARow: Integer; Shift: TShiftState);
var
  idx: Integer;
begin
  if (not g_boDealEnd) and (not g_boDealLock) and (FrmMain.m_CurrentTick > g_dwDealActionTick) then begin
    if not g_boItemMoving then begin
      idx := ACol + ARow * DDGrid.ColCount;
      if idx in [0..MAXDEALITEMCOUNT - 1] then
        if g_DealItems[idx].S.name <> '' then begin
          if (not g_boDealEnd) and (not g_boDealLock) and (g_DealDlgItem.Item.s.Name = '') then begin
            g_DealDlgItem.Index2 := idx;
            g_DealDlgItem.Item := g_DealItems[idx];
            frmMain.SendDelDealItem(g_DealItems[idx]);
            g_DealItems[idx].S.name := '';
            ItemClickSound(g_DealDlgItem.Item.S);
            g_dwDealActionTick := FrmMain.m_CurrentTick + 4000;
          end;
        end;
    end
    else begin
      if g_MovingItem.ItemType = mtDealGold then
        g_boItemMoving := False
      else if g_MovingItem.ItemType = mtBagGold then
        DDGoldClick(Self, 0, 0)
      else if (g_MovingItem.ItemType = mtBagItem) and (not g_boDealEnd) and (not g_boDealLock) and
        (g_DealDlgItem.Item.s.Name = '') then begin
        ItemClickSound(g_MovingItem.Item.S);
        if CheckItemBindMode(@g_MovingItem.Item.UserItem, bm_NoDeal) then begin
          AddItemBag(g_MovingItem.Item, g_MovingItem.Index2);
          ClearMovingItem();
          DMessageDlg('Can not trade this item.', [mbOk]);
          exit;
        end;
        g_DealDlgItem := g_MovingItem;
        frmMain.SendAddDealItem(g_DealDlgItem.Item);
        g_dwDealActionTick := FrmMain.m_CurrentTick + 4000;

        ClearMovingItem();
      end;
    end;
    ArrangeItembag;
  end;
end;

procedure TFrmDlg.DDRGridGridMouseMove(Sender: TObject; X, Y: integer; ACol, ARow: Integer; Shift: TShiftState);
var
  idx: Integer;
begin
  with Sender as TDgrid do begin
    idx := ACol + ARow * DDRGrid.ColCount;
    if idx in [0..MAXDEALITEMCOUNT - 1] then begin
      if g_DealRemoteItems[idx].s.Name <> '' then begin
        with DDRGrid do
          DScreen.ShowHint(SurfaceX(Left + (x - left)), SurfaceY(Top + (y - Top) + 30),
            ShowItemInfo(g_DealRemoteItems[idx], [], []), clwhite, False, idx, True);
      end;
    end;
  end;
end;

procedure TFrmDlg.DDRGridGridPaint(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState;
  dsurface: TDXTexture);
var
  idx: Integer;
  d: TDXTexture;
  pRect: TRect;
begin
  idx := ACol + ARow * DDRGrid.ColCount;
  if idx in [0..MAXDEALITEMCOUNT - 1] then begin
    if g_DealRemoteItems[idx].S.name <> '' then begin
      d := GetBagItemImg(g_DealRemoteItems[idx].S.looks);
      if d <> nil then
        with DDRGrid do begin //交易窗口
          pRect.Left := SurfaceX(Rect.Left);
          pRect.Top := SurfaceY(Rect.Top);
          pRect.Right := SurfaceX(Rect.Right + 1);
          pRect.Bottom := SurfaceY(Rect.Bottom);
          RefItemPaint(dsurface, d,
            SurfaceX(Rect.Left + (ColWidth - d.Width) div 2 - 1),
            SurfaceY(Rect.Top + (RowHeight - d.Height) div 2 + 1),
            SurfaceX(Rect.Right),
            SurfaceY(Rect.Bottom) - 12,
            @g_DealRemoteItems[idx], True, [pmShowLevel], @pRect);
        end;
    end;
  end;
end;
{
procedure TFrmDlg.DealItemReturnBag(mitem: TNewClientItem);
begin
 if not g_boDealEnd then begin
   g_DealDlgItem := mitem;
   frmMain.SendDelDealItem(g_DealDlgItem);
   g_dwDealActionTick := FrmMain.m_CurrentTick + 4000;
 end;
end; }

procedure TFrmDlg.DealZeroGold;
begin
  if not g_boDealEnd and (g_nDealGold > 0) then begin
    g_dwDealActionTick := FrmMain.m_CurrentTick + 4000;
    frmMain.SendChangeDealGold(0);
  end;
end;

procedure TFrmDlg.DEditChatChange(Sender: TObject);
var
  Text: string;
begin
  Text := DEditChat.Text;
  g_SayMode := usm_Hear;
//  if Text <> '' then begin
//    case Text[1] of
//      '/': g_SayMode := usm_Whisper;
//      '!': begin
//          g_SayMode := usm_Cry;
//          if length(Text) > 1 then begin
//            if Text[2] = '!' then
//              g_SayMode := usm_Group
//            else if Text[2] = '~' then
//              g_SayMode := usm_Guild;
//          end;
//        end;
//      '@': begin
//          if CompareLStr(Text, g_Cmd_AllMsg + ' ', Length(g_Cmd_AllMsg + ' ')) then
//            g_SayMode := usm_World;
//        end;
//    end;
//  end;
  if (Text = '/') and (g_MyWhisperList.Count > 0) then
    dwndWhisperName.Visible := True
  else
    dwndWhisperName.Visible := False;
end;

procedure TFrmDlg.DEditChatCheckItem(Sender: TObject; ItemIndex: Integer; var ItemName: string);
var
  i: Integer;
begin
  ItemName := '';
  if ItemIndex <= 0 then
    exit;
  for I := Low(g_ItemArr) to High(g_ItemArr) do begin
    if g_ItemArr[i].UserItem.MakeIndex = ItemIndex then begin
      ItemName := g_ItemArr[i].s.Name;
      Break;
    end;
  end;
end;

procedure TFrmDlg.DEditChatClick(Sender: TObject; X, Y: Integer);
var
  nBack: Byte;
begin
  nBack := 255;
  if g_boItemMoving then begin
    if g_MovingItem.ItemType = mtBagItem then begin
      nBack := DEditChat.AddItemToList(g_MovingItem.Item.s.Name,
        IntToStr(g_MovingItem.Item.UserItem.MakeIndex));
    end;
    CancelItemMoving;
    case nBack of
      2: DMessageDlg('[Error]:Chat box not long enough.', []);
      3: DMessageDlg('[Error]:Same equipment is in chat box.', []);
      4: DMessageDlg('[Failed]:You have sent a maximum limit on number.', []);
      255: DMessageDlg('[Error]:Can not use the equipment in bag.', []);
    end;
  end;
end;

procedure TFrmDlg.DEditChatDrawEditImage(Sender: TObject; ImageSurface: TDXTexture; Rect: TRect;
  ImageIndex: Integer);
var
  d: TDXTexture;
  ax, ay, nx, ny: integer;
  py: smallint;
begin
  with Sender as TDControl do begin
    if ImageIndex in [Low(g_FaceIndexInfo)..High(g_FaceIndexInfo)] then begin
      d := g_WFaceImages.GetCachedImage(g_FaceIndexInfo[ImageIndex].ImageIndex, nx, ny);
      if d <> nil then begin
        ax := Rect.Left;
        ay := Rect.Top + ((Rect.Bottom - Rect.Top) - d.Height) div 2;
        ImageSurface.Draw(ax, ay, d.ClientRect, d, True);
        py := ny;
        if (FrmMain.m_CurrentTick - g_FaceIndexInfo[ImageIndex].dwShowTime) > LongWord(nx) then begin
          g_FaceIndexInfo[ImageIndex].ImageIndex := g_FaceIndexInfo[ImageIndex].ImageIndex + py;
          g_FaceIndexInfo[ImageIndex].dwShowTime := FrmMain.m_CurrentTick;
        end;
      end;
    end;
  end;
end;

procedure TFrmDlg.DEditChatKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if dwndWhisperName.Visible then begin
    if Key = VK_UP then begin
      Inc(FSayNameIndex);
      if FSayNameIndex >= g_MyWhisperList.Count then
        FSayNameIndex := g_MyWhisperList.Count - 1;
      if FSayNameIndex > 7 then
        FSayNameIndex := 7;
      Key := 0;
    end
    else if Key = VK_DOWN then begin
      Dec(FSayNameIndex);
      if FSayNameIndex < 0 then
        FSayNameIndex := 0;
      Key := 0;
    end;
  end;
end;

procedure TFrmDlg.DEditChatKeyPress(Sender: TObject; var Key: Char);
  procedure SelectChatName;
  begin
    if (FSayNameIndex >= 0) and (FSayNameIndex < g_MyWhisperList.Count) then begin
      DEditChat.Text := '/' + g_MyWhisperList[FSayNameIndex] + ' ';
    end;
  end;
var
  SayMode: TUserSayMode;
begin
  SayMode := g_SayMode;
  DEditChat.OnKeyPress := nil;
  try
    if Key = #32 then begin
      if dwndWhisperName.Visible then begin
        SelectChatName;
        Key := #0;
      end;
    end
    else if Key = #13 then begin
      if dwndWhisperName.Visible then begin
        SelectChatName;
        Key := #0;
      end
      else begin
        if (g_SayMode = usm_World) and ((g_UseItems[U_CIMELIA].s.Name = '') or (g_UseItems[U_CIMELIA].s.StdMode <> tm_Cowry) or
          (g_UseItems[U_CIMELIA].s.Shape <> 0) or (g_UseItems[U_CIMELIA].UserItem.Dura <= 0)) then begin
          FrmDlg.DMessageDlg('You do not have the equipment to perform this action!', []);
          FrmDlg.DEditChat.SetFocus;
          Key := #0;
          exit;
        end;
        frmMain.SendSay(FrmDlg.DEditChat.Text);
        FrmDlg.DEditChat.Text := '';
        FrmDlg.DEditChat.Visible := FALSE;
        Key := #0;
      end;
    end
    else if Key = #27 then begin
      FrmDlg.DEditChat.Text := '';
      FrmDlg.DEditChat.Visible := FALSE;
      Key := #0;
    end;
  finally
    DEditChat.OnKeyPress := DEditChatKeyPress;
    g_SayMode := SayMode;
  end;
end;

procedure TFrmDlg.DEditChatVisible(Sender: TObject; boVisible: Boolean);
begin
  if not boVisible then begin
  end;
end;

procedure TFrmDlg.DEditIDMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  Clipboard: TClipboard;
begin
  with Sender as TDControl do begin
    if (mbRight = Button) and (Enabled) then begin
      Clipboard := TClipboard.Create;
      try
        DPopUpEdits.Visible := False;
        DPopUpEdits.Item.Clear;
        //DPopUpEdits.Item.AddObject('撤消     Ctrl+Z', nil);
        //DPopUpEdits.Item.AddObject('-', nil);
        if Selected and (not ReadOnly) then
          DPopUpEdits.Item.AddObject('Cut     Ctrl+X', TObject(1))
        else
          DPopUpEdits.Item.AddObject('Cut     Ctrl+X', nil);

        if Selected then
          DPopUpEdits.Item.AddObject('Copy     Ctrl+C', TObject(2))
        else
          DPopUpEdits.Item.AddObject('Copy     Ctrl+C', nil);

        if (Clipboard.AsText <> '') and (not ReadOnly) then
          DPopUpEdits.Item.AddObject('Paste     Ctrl+V', TObject(3))
        else
          DPopUpEdits.Item.AddObject('Paste     Ctrl+V', nil);

        if Selected and (not ReadOnly) then
          DPopUpEdits.Item.AddObject('Delete     Del', TObject(4))
        else
          DPopUpEdits.Item.AddObject('Delete     Del', nil);
        DPopUpEdits.Item.AddObject('-', nil);

        DPopUpEdits.Item.AddObject('Select     Ctrl+A', TObject(5));
        DPopUpEdits.RefSize;
        DPopUpEdits.Popup(Sender, SurfaceX(X), SurfaceY(Y), '');
      finally
        Clipboard.Free;
      end;
    end;
  end;
end;

procedure TFrmDlg.DPopUpEditsPopIndex(Sender, DControl: TDControl; ItemIndex: Integer; UserName: string);
var
  Key: Word;
begin
  with DControl do begin
    case Integer(TDPopUpMemu(Sender).Item.Objects[ItemIndex]) of
      1: begin
          Key := Word('X');
          KeyDown(Key, [ssCtrl]);
        end;
      2: begin
          Key := Word('C');
          KeyDown(Key, [ssCtrl]);
        end;
      3: begin
          Key := Word('V');
          KeyDown(Key, [ssCtrl]);
        end;
      4: begin
          Key := VK_DELETE;
          KeyDown(Key, []);
        end;
      5: begin
          Key := Word('A');
          KeyDown(Key, [ssCtrl]);
        end;
    end;
  end;
end;
{
procedure TFrmDlg.DelStorageItem(itemserverindex: Integer);
var
 i: Integer;
 pg: PTClientGoods;
begin
 for i := 0 to MenuList.count - 1 do begin
   pg := PTClientGoods(MenuList[i]);
   if (pg.ClientItem.UserItem.MakeIndex = itemserverindex) then begin
     Dispose(pg);
     MenuList.Delete(i);
     DMenuUpDonw.MaxPosition := MenuList.Count - 4;
     if i < g_SaveItemList.count then
       g_SaveItemList.Delete(i);
     if menuindex > MenuList.count - 1 then
       menuindex := MenuList.count - 1;
     break;
   end;
 end;
end;       }

procedure TFrmDlg.DGoldClick(Sender: TObject; X, Y: Integer);
begin
  if g_MySelf = nil then
    Exit;
  if not g_boItemMoving then begin
    if g_MySelf.m_nGold > 0 then begin
      PlaySound(s_money);
      g_boItemMoving := True;
      g_MovingItem.Index2 := -98;
      g_MovingItem.Item.S.name := g_sGoldName {'金币'};
      g_MovingItem.ItemType := mtBagGold;
    end;
  end
  else begin
    if (g_MovingItem.ItemType = mtDealGold) or (g_MovingItem.ItemType = mtBagGold) then begin
      g_boItemMoving := FALSE;
      g_MovingItem.Item.S.name := '';
      if g_MovingItem.ItemType = mtDealGold then
        DealZeroGold;
    end;
  end;
end;

procedure TFrmDlg.DGoldMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var
showstr: string;
begin
  with sender as TDButton do begin
  showstr:='<'+ g_sGoldName + '/FCOLOR=$FFFF>' + ': ' + GetGoldStr(g_MySelf.m_nGold) + '\' +
  '<'+ g_sGameGoldName + ' /FCOLOR=$CCFF>' + ': ' + GetGoldStr(g_MySelf.m_nGameGold) + '\' +
  '<'+ g_sGamePointName + ' /FCOLOR=$A0FF>' + ': ' + GetGoldStr(g_MySelf.m_nGamePoint) + '\' +
  '<'+ g_sBindGoldName + ' /FCOLOR=$73FF>' + ': ' + GetGoldStr(g_nBindGold);
  DScreen.ShowHint(SurfaceX(X), SurfaceY(Y + 90), showstr, clWhite, True, Integer(Sender));
  end;
end;

procedure TFrmDlg.DGroupDlgDirectPaint(Sender: TObject; dsurface: TDXTexture);
var
  d: TDXTexture;
  ax, ay: integer;
begin
  with Sender as TDWindow do begin
    ax := SurfaceX(Left);
    ay := SurfaceY(Top);
    d := WLib.Images[FaceIndex];
    if d <> nil then
      DrawWindow(dsurface, ax, ay, d);
    DGrpAllowGroup.Checked := not CheckIntStatus(g_nGameSetupData, GSP_NOTGROUP);
    DGrpCheckGroup.Checked := CheckIntStatus(g_nGameSetupData, GSP_GROUPCHECK);
    DCBGroupItemRam.Checked := g_GroupItemMode;
    DCBGroupItemDef.Checked := not g_GroupItemMode;
    with g_DXCanvas do begin
      TextOut(ax + 36, ay + 225, $B6C2A4, 'Nearby Players');
      TextOut(ax + 180, ay + 225, $B6C2A4, 'Guild Name');
    end;
  end;
end;

procedure TFrmDlg.DGroupDlgMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
  UserListMoveIndex := -1;
  GroupListMoveIndex := -1;
end;

procedure TFrmDlg.DGroupDlgVisible(Sender: TObject; boVisible: Boolean);
begin
  GroupListIndex := -1;
  UserListIndex := -1;
  UserListMoveIndex := -1;
  GroupListMoveIndex := -1;
end;

procedure TFrmDlg.DGroupExitClick(Sender: TObject; X, Y: Integer);
var
  who: string;
begin
  if (FrmMain.m_CurrentTick > g_dwChangeGroupModeTick) and (g_GroupMembers.count > 0) then begin
    who := g_MySelf.m_UserName;
    if who <> '' then begin
      g_dwChangeGroupModeTick := FrmMain.m_CurrentTick + 2000; //timeout 5檬
      frmMain.SendDelGroupMember(who);
    end;
  end;
end;

procedure TFrmDlg.DGrpAddMemClick(Sender: TObject; X, Y: Integer);
var
  who: string;
begin
  if (FrmMain.m_CurrentTick > g_dwChangeGroupModeTick) {and (g_GroupMembers.count > 0)} then begin
    DMessageDlg('Please enter the name of character you want to add..', [mbOk, mbAbort]);
    who := Trim(DlgEditText);
    if who <> '' then begin
      g_dwChangeGroupModeTick := FrmMain.m_CurrentTick + 2000; //timeout 5檬
      CreateGroup(who);
    end;
  end;
end;

procedure TFrmDlg.DGrpAllowGroupClick(Sender: TObject; X, Y: Integer);
begin
  if FrmMain.m_CurrentTick > g_dwChangeGroupModeTick then begin
    //g_boAllowGroup := not g_boAllowGroup;
    SetIntStatus(g_nGameSetupData, GSP_NOTGROUP, not CheckIntStatus(g_nGameSetupData, GSP_NOTGROUP));
    g_dwChangeGroupModeTick := FrmMain.m_CurrentTick + 2000; //timeout 5檬
    frmMain.SendGroupMode;
  end;
end;

procedure TFrmDlg.DGrpCheckGroupClick(Sender: TObject; X, Y: Integer);
begin
  if FrmMain.m_CurrentTick > g_dwChangeGroupModeTick then begin
    //g_boCheckGroup := not g_boCheckGroup;
    SetIntStatus(g_nGameSetupData, GSP_GROUPCHECK, not CheckIntStatus(g_nGameSetupData, GSP_GROUPCHECK));
    g_dwChangeGroupModeTick := FrmMain.m_CurrentTick + 2000; //timeout 5檬
    frmMain.SendGroupMode;
  end;
end;

procedure TFrmDlg.DGrpCreateClick(Sender: TObject; X, Y: Integer);
var
  who: string;
begin
  if (FrmMain.m_CurrentTick > g_dwChangeGroupModeTick) then begin
    if (UserListIndex < RefGroupList.count) and (UserListIndex >= 0) then begin
      who := RefGroupList[UserListIndex];
      if who <> '' then begin
        g_dwChangeGroupModeTick := FrmMain.m_CurrentTick + 2000; //timeout 5檬
        CreateGroup(who);
      end;
    end
    else
      DMessageDlg('Select the nearby player you wish to add to group..', [mbOk]);
  end;
end;

procedure TFrmDlg.DGrpDelMemClick(Sender: TObject; X, Y: Integer);
var
  who: string;
  GroupMember: pTGroupMember;
begin
  if (FrmMain.m_CurrentTick > g_dwChangeGroupModeTick) then begin
    if (GroupListIndex < g_GroupMembers.count) and (GroupListIndex >= 0) then begin
      GroupMember := g_GroupMembers[GroupListIndex];
      who := GroupMember.ClientGroup.UserName;
      if who <> '' then begin
        g_dwChangeGroupModeTick := FrmMain.m_CurrentTick + 2000; //timeout 5檬
        frmMain.SendDelGroupMember(who);
      end;
    end;
  end;
end;

procedure TFrmDlg.DGrpMemberListDblClick(Sender: TObject);
var
  who: string;
  GroupMember: pTGroupMember;
begin
  who := '';
  if (GroupListIndex < g_GroupMembers.count) and (GroupListIndex >= 0) then begin
    GroupMember := g_GroupMembers[GroupListIndex];
    who := GroupMember.ClientGroup.UserName;
  end;
  if who <> '' then begin
    PlayScene.SetEditChar(who);
  end;
end;

procedure TFrmDlg.DGrpMemberListDirectPaint(Sender: TObject; dsurface: TDXTexture);
var
  i, ax, ay: integer;
  GroupMember: pTGroupMember;
  Actor: TActor;
  nX, nY: Integer;
begin
  with Sender as TDWindow do begin
    ax := SurfaceX(Left);
    ay := SurfaceY(Top);
    with g_DXCanvas do begin
      //SetBkMode(Handle, TRANSPARENT);
      if Sender = DGrpMemberList then begin
        if g_GroupMembers.count > 1 then begin
          GroupMember := g_GroupMembers[0];

          if 0 = GroupListMoveIndex then begin
            FillRect(ax + 4, ay + 3, 230, 14, $A062625A);
          end
          else if 0 = GroupListIndex then begin
            FillRect(ax + 4, ay + 3, 230, 14, $C862625A);
          end;
            TextOut(ax + 6, ay + 4, $6090C0, GroupMember.ClientGroup.UserName + '(Leader)');
          for i := 1 to g_GroupMembers.count - 1 do begin
            GroupMember := g_GroupMembers[i];
            nX := ax + 6 + ((i - 1) mod 2) * 116;
            nY := ay + 21 + (i - 1) div 2 * 14;
            if i = GroupListMoveIndex then begin
              FillRect(nx - 2, ny - 1, 116, 14, $A062625A);
            end
            else if i = GroupListIndex then begin
              FillRect(nx - 2, ny - 1, 116, 14, $C862625A);
            end;
              TextOut(nX, ny, $B6C0A9, GroupMember.ClientGroup.UserName);
          end;
        end;
      end
      else if Sender = DGrpUserList then begin
        if (FrmMain.m_CurrentTick - AppendTick) > 1000 then begin
          AppendTick := FrmMain.m_CurrentTick;
          RefGroupList.Clear;
          with PlayScene do begin
            for i := 0 to m_ActorList.Count - 1 do begin
              Actor := m_ActorList[i];
              if (Actor.m_btRace = 0) and (Actor.m_Group = nil) and (Actor <> g_MySelf) then begin
                RefGroupList.AddObject(Actor.m_UserName, TObject(Actor));
              end;
            end;
            if RefGroupList.Count > 8 then begin
              DGroupUpDown.MaxPosition := RefGroupList.Count - 8;
            end
            else begin
              DGroupUpDown.MaxPosition := 0;
              DGroupUpDown.Position := 0;
            end;
          end;
        end;
        if RefGroupList.count > 0 then begin
          for i := DGroupUpDown.Position to DGroupUpDown.Position + 7 do begin
            if i >= RefGroupList.count then
              Break;
            {if i = UserListIndex then
              nFColor := clYellow
            else
              nFColor := $B6C0A9;   }
            if i = UserListMoveIndex then begin
              FillRect(ax + 2, ay + 2 + (i - DGroupUpDown.Position) * 14, 218, 14, $A062625A);
            end
            else if i = UserListIndex then begin
              FillRect(ax + 2, ay + 2 + (i - DGroupUpDown.Position) * 14, 218, 14, $C862625A);
            end;
            TextOut(ax + 36 - Left, ay + 3 + (i - DGroupUpDown.Position) * 14, $B6C0A9, RefGroupList[i]);
            actor := TActor(RefGroupList.Objects[i]);
            if Actor <> nil then begin
              TextOut(ax + 180 - Left, ay + 3 + (i - DGroupUpDown.Position) * 14, $B6C0A9, Actor.m_sGuildName);
            end;
          end;
        end;
      end;
      //Release;
    end;
  end;
end;

procedure TFrmDlg.DGrpMemberListMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  x := x - DGrpMemberList.Left;
  y := y - DGrpMemberList.Top;
  GroupListIndex := -1;
  if (X >= 6) and (x <= 258) and (y >= 4) and (y <= 17) then begin
    GroupListIndex := 0;
  end
  else if (X >= 6) and (x <= 250) and (y >= 18) and (y <= 65) then begin
    GroupListIndex := (y - 18) div 16 * 2 + (X - 6) div 125 + 1;
  end;
end;

procedure TFrmDlg.DGrpMemberListMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
  x := x - DGrpMemberList.Left;
  y := y - DGrpMemberList.Top;
  GroupListMoveIndex := -1;
  if (X >= 6) and (x <= 258) and (y >= 4) and (y <= 17) then begin
    GroupListMoveIndex := 0;
  end
  else if (X >= 6) and (x <= 250) and (y >= 18) and (y <= 65) then begin
    GroupListMoveIndex := (y - 18) div 16 * 2 + (X - 6) div 125 + 1;
  end;
end;

procedure TFrmDlg.DGrpMemberListMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  UserName: string;
begin
  with (Sender as TDControl) do begin
    if (mbRight = Button) then begin
      if (GroupListIndex >= 0) and (GroupListIndex < g_GroupMembers.Count) then begin
        UserName := pTGroupMember(g_GroupMembers[GroupListIndex]).ClientGroup.UserName;
        FrmDlg2.DPopUpMemuGroup.Visible := False;
        FrmDlg2.DPopUpMemuGroup.Item.Clear;
        FrmDlg2.DPopUpMemuGroup.Item.AddObject('Name: ' + UserName, TObject(-1));
        FrmDlg2.DPopUpMemuGroup.Item.AddObject('-', nil);
        if (g_GroupMembers.Count > 0) and
          (pTGroupMember(g_GroupMembers[0]).ClientGroup.UserName = g_MySelf.m_UserName) then begin
          FrmDlg2.DPopUpMemuGroup.Item.AddObject('Kick from group', TObject(1));
        end
        else
          FrmDlg2.DPopUpMemuGroup.Item.AddObject('Kick from group', nil);
        FrmDlg2.DPopUpMemuGroup.Item.AddObject('Private Chat', TObject(2));
        if (not InFriendList(UserName)) and
          (UserName <> g_MySelf.m_UserName) then
          FrmDlg2.DPopUpMemuGroup.Item.AddObject('Add As Friend', TObject(3))
        else
          FrmDlg2.DPopUpMemuGroup.Item.AddObject('Add As Friend', nil);

        if InFriendList(UserName) then
          FrmDlg2.DPopUpMemuGroup.Item.AddObject('Send Message', TObject(4))
        else
          FrmDlg2.DPopUpMemuGroup.Item.AddObject('Send Message', nil);

        FrmDlg2.DPopUpMemuGroup.Item.AddObject('Invite Guild', TObject(5));
        FrmDlg2.DPopUpMemuGroup.Item.AddObject('-', nil);
        FrmDlg2.DPopUpMemuGroup.Item.AddObject('Copy Name', TObject(6));
        FrmDlg2.DPopUpMemuGroup.RefSize;
        FrmDlg2.DPopUpMemuGroup.Popup(Sender, SurfaceX(X), SurfaceY(Y), UserName);
      end;
    end;
  end;
end;

procedure TFrmDlg.DGrpUserListDblClick(Sender: TObject);
var
  who: string;
begin
  who := '';
  if (UserListIndex < RefGroupList.count) and (UserListIndex >= 0) then begin
    who := RefGroupList[UserListIndex];
  end;
  if who <> '' then begin
    PlayScene.SetEditChar(who);
  end;
end;

procedure TFrmDlg.DGrpUserListMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  x := x - DGrpUserList.Left;
  y := y - DGrpUserList.Top;
  UserListIndex := -1;
  if (X > 6) and (x < 250) and (y > 3) and (y < 128) then begin
    UserListIndex := (y - 3) div 14 + DGroupUpDown.Position;
  end;
end;

procedure TFrmDlg.DGrpUserListMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
  x := x - DGrpUserList.Left;
  y := y - DGrpUserList.Top;
  UserListMoveIndex := -1;
  if (X > 6) and (x < 250) and (y > 3) and (y < 128) then begin
    UserListMoveIndex := (y - 3) div 14 + DGroupUpDown.Position;
  end;
end;

procedure TFrmDlg.DGrpUserListMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  UserName: string;
begin
  with Sender as TDControl do begin
    if mbRight = Button then begin
      if (UserListIndex < RefGroupList.count) and (UserListIndex >= 0) then begin
        UserName := RefGroupList[UserListIndex];
        DPopUpSayList.Visible := False;
        DPopUpSayList.Item.Clear;
        DPopUpSayList.Item.AddObject('Name: ' + UserName, TObject(-1));
        DPopUpSayList.Item.AddObject('-', nil);
        DPopUpSayList.Item.AddObject('Private Chat', TObject(1));
        if (not InFriendList(UserName)) and
          (UserName <> g_MySelf.m_UserName) then
          DPopUpSayList.Item.AddObject('Add As Friend', TObject(2))
        else
          DPopUpSayList.Item.AddObject('Add As Friend', nil);

        if (not InBlacklist(UserName)) then
          DPopUpSayList.Item.AddObject('Block Chat', TObject(7))
        else
          DPopUpSayList.Item.AddObject('Unblock Chat', TObject(8));

        if InFriendList(UserName) then
          DPopUpSayList.Item.AddObject('Send Message', TObject(3))
        else
          DPopUpSayList.Item.AddObject('Send Message', nil);

        DPopUpSayList.Item.AddObject('Invite to Group', TObject(4));
        DPopUpSayList.Item.AddObject('Invite to Guild', TObject(5));
        DPopUpSayList.Item.AddObject('-', nil);
        DPopUpSayList.Item.AddObject('Copy Name', TObject(6));
        DPopUpSayList.RefSize;
        DPopUpSayList.Popup(Sender, SurfaceX(X), SurfaceY(Y), UserName);
      end;
    end;
  end
end;

procedure TFrmDlg.DPopUpSayListPopIndex(Sender, DControl: TDControl; ItemIndex: Integer; UserName: string);
var
  Idx: integer;
begin
  with DControl do begin
    case Integer(TDPopUpMemu(Sender).Item.Objects[ItemIndex]) of
      1: PlayScene.SetEditChar(UserName);
      2: FrmMain.SendClientMessage(CM_FRIEND_CHENGE, 0, 0, 0, 0, UserName);
      3: FrmDlg2.OpenNewMail(UserName);
      4: CreateGroup(UserName);
      5: frmMain.SendGuildAddMem(UserName);
      6: CopyStrToClipboard(UserName);
      7: begin
          if g_MyBlacklist.IndexOf(UserName) = -1 then begin
            g_MyBlacklist.Add(UserName)
          end;
        end;
      8: begin
          Idx := g_MyBlacklist.IndexOf(UserName);
          if Idx <> -1 then
            g_MyBlacklist.Delete(idx);
        end;
    end;
  end;
end;

procedure TFrmDlg.DItemAddBag1DirectPaint(Sender: TObject; dsurface: TDXTexture);
var
  d: TDXTexture;
  ax, ay: integer;
begin
  with Sender as TDButton do begin
    ax := SurfaceX(Left);
    ay := SurfaceY(Top);
    if Tag in [Low(g_AddBagItems)..High(g_AddBagItems)] then begin
      if g_boItemMoving and (g_MovingItem.ItemType = mtBagItem) and (g_MovingItem.Item.S.name <> '') and
        (g_MovingItem.Item.s.StdMode = tm_AddBag) then begin
        if (g_AddBagItems[Tag].s.Name = '') then begin
          d := g_WMain99Images.Images[2112 + (FrmMain.m_CurrentTick - AppendTick) div 200 mod 2];
          if d <> nil then
            DrawBlend(dsurface, ax - 12 - 1, ay - 14 + 1, d, 1);
        end;
      end;
      if g_AddBagItems[Tag].s.name <> '' then begin
        d := GetBagItemImg(g_AddBagItems[Tag].S.looks);
        if d <> nil then
          RefItemPaint(dsurface, d, //人物背包栏
            ax + (Width - d.Width) div 2,
            ay + (Height - d.Height) div 2,
            Width,
            Height,
            @g_AddBagItems[Tag], False);
      end;
    end;
  end;
end;

procedure TFrmDlg.DItemAddBag1MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
var
  nLocalX, nLocalY: Integer;
  nHintX, nHintY: Integer;
begin
  with Sender as TDButton do begin
    nLocalX := LocalX(X - Left);
    nLocalY := LocalY(Y - Top);
    nHintX := SurfaceX(Left) + DParent.SurfaceX(DParent.Left) + nLocalX;
    nHintY := SurfaceY(Top) + DParent.SurfaceY(DParent.Top) + nLocalY + 30;
    if Tag in [Low(g_AddBagItems)..High(g_AddBagItems)] then begin
      if g_AddBagItems[Tag].s.Name <> '' then begin
        DScreen.ShowHint(nHintX, nHintY, ShowItemInfo(g_AddBagItems[Tag], [mis_AddBag], []), clwhite, False, Tag, True);
      end;
    end;
  end;
end;

procedure TFrmDlg.DItemAddBag1MouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  with Sender as TDButton do begin
    if Button = mbLeft then begin
      if g_MoveAddBagItem.Item.s.Name = '' then begin
        if Tag in [Low(g_AddBagItems)..High(g_AddBagItems)] then begin
          if not g_boItemMoving then begin
            if (g_AddBagItems[Tag].s.Name <> '') and (g_MoveAddBagItem.Item.s.Name = '') then begin
              g_MoveAddBagItem.Index2 := Tag;
              g_MoveAddBagItem.Item := g_AddBagItems[Tag];
              g_MoveAddBagItem.ItemType := mtBagItem;
              g_AddBagItems[Tag].S.name := '';
              ItemClickSound(g_AddBagItems[Tag].S);
              frmMain.SendTakeOffAddBagItem(Tag);
              ArrangeItembag;
            end;
          end
          else begin
            if (g_MovingItem.ItemType = mtBagItem) and (g_MovingItem.Item.s.StdMode = tm_AddBag) and
              (g_MovingItem.Item.s.Name <> '') and (g_MoveAddBagItem.Item.s.Name = '') and
              (g_AddBagItems[Tag].s.Name = '') then begin
              g_MoveAddBagItem := g_MovingItem;
              frmMain.SendTakeOnAddBagItem(Tag, g_MovingItem.Item.UserItem.MakeIndex);
              ClearMovingItem();
              ArrangeItembag;
            end;
          end;
        end;
      end;
    end;
  end;
end;

procedure TFrmDlg.DItemBagDirectPaint(Sender: TObject;
  dsurface: TDXTexture);
var
  d: TDXTexture;
  ax, ay: integer;
begin
  with Sender as TDWindow do begin
    ax := SurfaceX(Left);
    ay := SurfaceY(Top);
    d := WLib.Images[FaceIndex];
    if d <> nil then
      DrawWindow(dsurface, ax, ay, d);
    if Sender = DItemBag then begin
     // d := g_WMain99Images.Images[1869];
     // if d <> nil then
     //   dsurface.Draw(ax + 11, ay + 230, d.ClientRect, d, False);
      with g_DXCanvas do begin
        TextOut(ax + 72, ay + 282, GetGoldStr(g_MySelf.m_nGold), clWhite);
        //TextOut(ax + 136, ay + 257, GetGoldStr(g_nBindGold), clWhite);
        TextOut(ax + 72, ay + 294, GetGoldStr(g_MySelf.m_nGameGold) + ' ' + g_sGameGoldName, $CCFF);
      end;
      DItemBagRef.Enabled := FrmMain.m_CurrentTick > g_BagCheckTick;

    end;
  end;
end;

procedure TFrmDlg.DItemBagMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  with Sender as TDWindow do begin
    x := x - left;
    y := y - top;
  end;
  if Sender = DItemBag then begin
    with DItemGrid do begin
      if (Button = mbRight) and (x >= Left) and (y >= Top) and (X <= Left + Width) and (y <= Top + Height) then begin
        DItemGridDblClick(DItemGrid);
      end;
    end;
  end
  else if Sender = DItemAppendBag1 then begin
    with DItemGrid1 do begin
      if (Button = mbRight) and (x >= Left) and (y >= Top) and (X <= Left + Width) and (y <= Top + Height) then begin
        DItemGridDblClick(DItemGrid1);
      end;
    end;
  end
  else if Sender = DItemAppendBag2 then begin
    with DItemGrid2 do begin
      if (Button = mbRight) and (x >= Left) and (y >= Top) and (X <= Left + Width) and (y <= Top + Height) then begin
        DItemGridDblClick(DItemGrid2);
      end;
    end;
  end
  else if Sender = DItemAppendBag3 then begin
    with DItemGrid3 do begin
      if (Button = mbRight) and (x >= Left) and (y >= Top) and (X <= Left + Width) and (y <= Top + Height) then begin
        DItemGridDblClick(DItemGrid3);
      end;
    end;
  end;
end;

procedure TFrmDlg.DItemBagMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
var
  ShowMsg: string;
begin
  with Sender as TDWindow do begin
    ShowMsg := '';
    x := x - Left;
    y := y - Top;
    if (x >= 42) and (y >= 436) and (x <= 42 + 180) and (y <= 436 + 15) then begin
      y := SurfaceY(Top + 436);
      ShowMsg := g_sBindGoldName + ' is a special server currency.\';
      ShowMsg := ShowMsg + 'This can only be used for certain situations.\';
      ShowMsg := ShowMsg + 'This currency can not be traded with other players.\';
      ShowMsg := ShowMsg + 'For more information on the currency, contact Server Admin.\';
    end
    else if (x >= 42) and (y >= 457) and (x <= 42 + 180) and (y <= 457 + 15) then begin
      y := SurfaceY(Top + 457);
      ShowMsg := g_sGameGoldName + ' is a special server currency.\';
      ShowMsg := ShowMsg + 'This can be used to buy items from the GameShop.\';
      //ShowMsg := ShowMsg + '可以在商铺中使用' + g_sGamePointName + '对换' + g_sGameGoldName + ',\';
      ShowMsg := ShowMsg + 'For more information on the currency, contact Server Admin.\';
    end
    else if (x >= 42) and (y >= 478) and (x <= 42 + 180) and (y <= 478 + 15) then begin
      y := SurfaceY(Top + 478);
      ShowMsg := g_sGamePointName + ' is a special server currency.,\';
      ShowMsg := ShowMsg + 'This can be used to buy items from the GameShop.\';
      //ShowMsg := ShowMsg + '该货币只可以用于商铺购买道具和对换' + g_sGameGoldName + '.\';
      ShowMsg := ShowMsg + 'For more information on the currency, contact Server Admin.\'

    end;
    X := SurfaceX(Left + 42);
    if ShowMsg <> '' then
      DScreen.ShowHint(x, y, ShowMsg, clWhite, True, Integer(Sender));
  end;
end;

procedure TFrmDlg.DItemBagRefClick(Sender: TObject; X, Y: Integer);
begin
  g_BagCheckTick := FrmMain.m_CurrentTick + 60 * 1000;
  //frmMain.SendQueryBagItems;
  DScreen.AddSysMsg('Bag refreshed!',clWhite);
end;

procedure TFrmDlg.DItemBagRefDirectPaint(Sender: TObject; dsurface: TDXTexture);
var
  d: TDXTexture;
begin
  with Sender as TDButton do begin
    if WLib <> nil then begin
      if not Enabled then
        d := WLib.Images[FaceIndex + 1]
      else if Downed then
        d := WLib.Images[FaceIndex]
      else
        d := nil;
      if d <> nil then
        dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, True);
    end;
  end;
end;

procedure TFrmDlg.DItemBagShopClick(Sender: TObject; X, Y: Integer);
begin
  FrmDlg2.DWndUserShop.Visible := not FrmDlg2.DWndUserShop.Visible;
end;

procedure TFrmDlg.DItemBagVisible(Sender: TObject; boVisible: Boolean);
begin
  if not boVisible then
    boOpenItemBag := False;
end;

procedure TFrmDlg.DItemGridDblClick(Sender: TObject);
var
  idx: Integer;
  where: Integer;

  procedure TakeOnAddBag(boMoving: Boolean);
  var
    Item: pTNewClientItem;
    nIdx: Integer;
    i: integer;
    ItemIndex: Integer;
  begin
    nIdx := -1;
    if boMoving then begin
      Item := @g_MovingItem.Item;
      ItemIndex := g_MovingItem.Index2;
    end
    else begin
      Item := @g_ItemArr[idx];
      ItemIndex := idx;
    end;
    if (g_MoveAddBagItem.Item.s.Name = '') then begin
      for I := Low(g_AddBagItems) to High(g_AddBagItems) do begin
        if g_AddBagItems[i].s.Name = '' then begin
          nIdx := I;
          break;
        end;
      end;
      if nIdx > -1 then begin
        ItemClickSound(Item.s);
        g_MoveAddBagItem.Index2 := ItemIndex;
        g_MoveAddBagItem.Item := Item^;
        g_MoveAddBagItem.ItemType := mtBagItem;
        Item.s.Name := '';
        frmMain.SendTakeOnAddBagItem(nIdx, item.UserItem.MakeIndex);
        g_boItemMoving := FALSE;
      end;
    end;
  end;
begin
  m_dwDblClick := FrmMain.m_CurrentTick;
  //idx := DItemGrid.Col + DItemGrid.row * DItemGrid.ColCount;
  idx := m_nMouseIdx;
  if idx in [Low(g_ItemArr)..High(g_ItemArr)] then begin
    if (not g_boItemMoving) and (g_ItemArr[idx].S.name <> '') then begin
      {SafeFillChar(keyvalue, sizeof(TKeyBoardState), #0);
      GetKeyboardState(keyvalue);
      if keyvalue[VK_CONTROL] = $80 then begin
        cu := g_ItemArr[idx];
        DelItemBagByIdx(idx);
        AddItemBag(cu);
      end
      else
      if not (CheckByteStatus(Item.s.Bind, Ib_NoSave) or CheckByteStatus(Item.UserItem.btBindMode1, Ib_NoSave))
        then begin
      }
      if FrmDlg4.DWndCompound.Visible{ and FrmDlg4.CanCompoundItemAdd(@g_ItemArr[idx])} then begin
        FrmDlg4.CompoundItemAdd(idx);
        exit;
      end
      else if FrmDlg4.DWndArmAbilityMove.Visible{ and FrmDlg4.CanArmAbilityMoveAdd(@g_ItemArr[idx])} then begin
        FrmDlg4.ArmAbilityMoveAdd(idx);
        exit;
      end
      else if FrmDlg3.DWndArmStrengthen.Visible and FrmDlg3.CanArmStrengthenAdd(@g_ItemArr[idx]) then begin
        FrmDlg3.ArmStrengthenAdd(idx);
        exit;
      end
      else if FrmDlg3.DWndMakeItem.Visible and FrmDlg3.CanMakeItemAdd(@g_ItemArr[idx]) then begin
        FrmDlg3.MakeItemAdd(idx);
        exit;
      end
      else if FrmDlg3.DWndItemUnseal.Visible and FrmDlg3.CanItemUnsealAdd(@g_ItemArr[idx]) then begin
        FrmDlg3.ItemUnsealAdd(idx);
        exit;
      end
      else if FrmDlg4.DWndItemRemove.Visible and FrmDlg4.CanItemRemoveStoneAdd(@g_ItemArr[idx]) then begin
        FrmDlg4.ItemRemoveStoneAdd(idx);
        exit;
      end
      else if FrmDlg2.DStorageDlg.Visible and (not (CheckItemBindMode(@g_ItemArr[idx].UserItem, bm_NoSave))) then begin
        FrmDlg2.AutoStorage(idx);
        exit;
      end
      else if ((tm_MakeStone = g_ItemArr[idx].S.StdMode) and (g_ItemArr[idx].S.Shape = 3)) or
        (tm_ResetStone = g_ItemArr[idx].S.StdMode) then begin
        if (g_SendSelectItem.s.name = '') then begin
          g_Selectitem := g_ItemArr[idx];
          g_CursorMode := cr_SelItem;
          FrmMain.Cursor := crMySelItem;
        end;
        Exit;
      end
      else if (tm_MakeStone = g_ItemArr[idx].S.StdMode) and (g_ItemArr[idx].S.Shape = 9) then begin
        if (g_SendRemoveStoneItem.s.name = '') then begin
          if FrmDlg4.DWndItemRemove.Visible then begin
            g_RemoveStoneItem := g_ItemArr[idx];
            g_CursorMode := cr_Srepair;
            FrmMain.Cursor := crSrepair;
          end
          else
            FrmDlg.DMessageDlg('Please open to remove equipment from window.', []);
        end;
        Exit;
      end
      else if (tm_AddBag = g_ItemArr[idx].S.StdMode) then begin
        TakeOnAddBag(False);
        Exit;
      end
      else if (sm_Eat in g_ItemArr[idx].S.StdModeEx) then begin
        frmMain.EatItem(idx);
        Exit;
      end
      else if g_WaitingUseItem.Item.s.name = '' then begin
        where := GetTakeOnPosition(g_ItemArr[idx].S.StdMode);
        if where in [0..MAXUSEITEMS - 1] then begin
          if where = U_RINGL then begin
            if m_boRING then
              Inc(where);
            m_boRING := not m_boRING;
          end
          else if where = U_ARMRINGL then begin
            if m_boARMRING then
              Inc(where);
            m_boARMRING := not m_boARMRING;
          end;
          ItemClickSound(g_ItemArr[idx].S);
          g_WaitingUseItem.Item := g_ItemArr[idx];
          g_WaitingUseItem.Index2 := where;
          g_WaitingUseItem.ItemType := mtBagItem;
          FrmMain.SendTakeOnItem(where, g_ItemArr[idx].UserItem.MakeIndex, g_ItemArr[idx].S.Name);
          DelItemBagByIdx(idx);
        end else
        if (where in [16..20]) then begin
          ItemClickSound(g_ItemArr[idx].S);
          g_WaitingUseItem.Item := g_ItemArr[idx];
          g_WaitingUseItem.Index2 := where;
          g_WaitingUseItem.ItemType := mtBagItem;
          FrmMain.SendTakeOnItem(where, g_ItemArr[idx].UserItem.MakeIndex, g_ItemArr[idx].S.Name);
          DelItemBagByIdx(idx);
        end;
      end;
    end
    else begin
      if g_boItemMoving and (g_MovingItem.Item.S.name <> '') and (g_MovingItem.ItemType = mtBagItem) then begin
        if (tm_AddBag = g_MovingItem.Item.S.StdMode) then begin
          TakeOnAddBag(True);
        end
        else if (sm_Eat in g_MovingItem.Item.S.StdModeEx) then begin
          frmMain.EatItem(-1);
        end
        else begin
          if g_WaitingUseItem.Item.s.name = '' then begin
            where := GetTakeOnPosition(g_MovingItem.Item.S.StdMode);
            if where in [0..MAXUSEITEMS - 1] then begin
              if where = U_RINGL then begin
                if m_boRING then
                  Inc(where);
                m_boRING := not m_boRING;
              end
              else if where = U_ARMRINGL then begin
                if m_boARMRING then
                  Inc(where);
                m_boARMRING := not m_boARMRING;
              end;
              ItemClickSound(g_MovingItem.Item.S);
              g_WaitingUseItem.Item := g_MovingItem.Item;
              g_WaitingUseItem.Index2 := where;
              g_WaitingUseItem.ItemType := mtBagItem;
              g_boItemMoving := False;
              FrmMain.SendTakeOnItem(where, g_MovingItem.Item.UserItem.MakeIndex, g_MovingItem.Item.S.Name);
              g_MovingItem.Item.S.Name := '';
            end else
            if (where in [16..20]) then begin
              ItemClickSound(g_MovingItem.Item.S);
              g_WaitingUseItem.Item := g_MovingItem.Item;
              g_WaitingUseItem.Index2 := where;
              g_WaitingUseItem.ItemType := mtBagItem;
              g_boItemMoving := False;
              FrmMain.SendTakeOnItem(where, g_MovingItem.Item.UserItem.MakeIndex, g_MovingItem.Item.S.Name);
              g_MovingItem.Item.S.Name := '';
            end;
          end;
        end;
      end;
    end;
  end;
end;

procedure TFrmDlg.DItemGridGridMouseMove(Sender: TObject; X, Y: integer; ACol, ARow: Integer; Shift: TShiftState);
var
  idx: Integer;
  MoveItemState: TMoveItemState;
begin
  m_nMouseIdx := -1;
  with Sender as TDGrid do begin
    if ssRight in Shift then begin
      if g_boItemMoving then
        DItemGridGridSelect(Sender, X, Y, ACol, ARow, Shift);
    end
    else begin
      idx := ACol + ARow * ColCount + g_AddBagInfo[Tag].nStateCount;
      if idx in [Low(g_ItemArr)..High(g_ItemArr)] then begin
        m_nMouseIdx := idx;
        if g_ItemArr[idx].s.Name <> '' then begin
          MoveItemState := [mis_Bag];
          case g_CursorMode of
            cr_Sell: MoveItemState := MoveItemState + [mis_Sell];
            cr_Repair: begin
                if boSuperRepair then
                  MoveItemState := MoveItemState + [mis_SuperRepair]
                else
                  MoveItemState := MoveItemState + [mis_Repair];
              end;
          end;
          if g_boItemMoving then begin
            if (ssCtrl in shift) and (g_MovingItem.Item.s.StdMode = tm_gem) and
               (g_ItemArr[idx].s.StdMode in [tm_Weapon, tm_Necklace, tm_Ring, tm_ArmRing, tm_Dress, tm_Helmet, tm_Belt, tm_Boot]) //only these can be repaired or gemmed so
            then begin
              if (g_MovingItem.Item.s.Shape in [3,4]) then
                MoveItemState := MoveItemState + [mis_GemRepair]
              else
               MoveItemState := MoveItemState + [mis_Gem];
            end;
          end;
          if FrmDlg2.DStorageDlg.Visible then
            MoveItemState := MoveItemState + [mis_Storage];
          if FrmDlg4.DWndCompound.Visible then
            MoveItemState := MoveItemState + [mis_CompoundItemAdd];
          if FrmDlg4.DWndArmAbilityMove.Visible then
            MoveItemState := MoveItemState + [mis_ArmAbilityMoveAdd];
          if FrmDlg3.DWndArmStrengthen.Visible then
            MoveItemState := MoveItemState + [mis_ArmStrengthenAdd];
          if FrmDlg3.DWndMakeItem.Visible then
            MoveItemState := MoveItemState + [mis_MakeItemAdd];
          if FrmDlg3.DWndItemUnseal.Visible then
            MoveItemState := MoveItemState + [mis_ItemUnsealAdd];
          if FrmDlg4.DWndItemRemove.Visible then
            MoveItemState := MoveItemState + [mis_ItemRemoveStoneAdd];

          DScreen.ShowHint(SurfaceX(Left + (x - left)), SurfaceY(Top + (y - Top) + 30),
            ShowItemInfo(g_ItemArr[idx], MoveItemState, []), clwhite, False, idx, True);
        end;
      end;
    end;
  end;
end;

procedure TFrmDlg.DItemGridGridPaint(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState; dsurface: TDXTexture);
var
  idx, nInt: Integer;
  d: TDXTexture;
  boShowCount: Boolean;
  showstr: string;
  pRect: TRect;
  SysTick: LongWord;
  i,ii,ax,ay:integer;
  ItemEffect:pTItemEffect;
begin
  with Sender as TDgrid do begin
    idx := ACol + ARow * ColCount + g_AddBagInfo[Tag].nStateCount;
    if idx in [Low(g_ItemArr)..High(g_ItemArr)] then begin
      if g_ItemArr[idx].S.name <> '' then begin
        d := GetBagItemImg(g_ItemArr[idx].S.looks);
        if d <> nil then begin
          boShowCount := True;
          if (g_CursorMode = cr_Repair) then begin
            boShowCount := False;
          end;
          pRect.Left := SurfaceX(Rect.Left);
          pRect.Top := SurfaceY(Rect.Top);
          pRect.Right := SurfaceX(Rect.Right + 1);
          pRect.Bottom := SurfaceY(Rect.Bottom);
          RefItemPaint(dsurface, d, //人物背包栏
            SurfaceX(Rect.Left + (ColWidth - d.Width) div 2 { - 1}),
            SurfaceY(Rect.Top + (RowHeight - d.Height) div 2 { + 1}),
            SurfaceX(Rect.Right),
            SurfaceY(Rect.Bottom) - 12,
            @g_ItemArr[idx], boShowCount, [pmShowLevel], @pRect);
          if (not boShowCount) and ((sm_Arming in g_ItemArr[idx].s.StdModeEx) or (sm_HorseArm in g_ItemArr[idx].s.StdModeEx)) and
            (not (CheckItemBindMode(@g_ItemArr[idx].UserItem, bm_NoRepair))) and
            (g_ItemArr[idx].UserItem.Dura < g_ItemArr[idx].UserItem.DuraMax) then begin
            nInt := Round(g_ItemArr[idx].UserItem.Dura / g_ItemArr[idx].UserItem.DuraMax * 100);
            with g_DXCanvas do begin
              //SetBkMode(Handle, TRANSPARENT);
              showstr := IntToStr(nInt) + '%';
              if nInt <= 30 then
                TextOut(SurfaceX(Rect.Right) - TextWidth(showstr), SurfaceY(Rect.Bottom) - 12, clRed, showstr)
              else
                TextOut(SurfaceX(Rect.Right) - TextWidth(showstr), SurfaceY(Rect.Bottom) - 12, clwhite, showstr);
              //Release;
            end;
          end;
          SysTick := FrmMain.m_CurrentTick;
          if (SysTick < FShowItemEffectTick) and (g_ItemArr[idx].UserItem.MakeIndex = FShowItemEffectIndex) then begin
            d := g_WMain99Images.Images[1990 + (FShowItemEffectTick - SysTick) div 150];
            if d <> nil then begin
              DrawBlend(dsurface, SurfaceX(Rect.Left) - 23, SurfaceY(Rect.Top) - 23, d, 1);
            end;
          end;
          //draw the effect(sparkle for upgrades)
          i:=0;
          while true do begin
            if i >= g_ItemEffects.Count then break;
            if pTItemEffect(g_ItemEffects[i]).Idx = idx then begin
              ItemEffect := g_ItemEffects[i];
              d := g_WMainImages.GetCachedImage (ItemEffect.n_StartFrame + ItemEffect.n_CurrentFrame, ax, ay);
              if d <> nil then
              for ii:= 0 to 5 do
                     DrawBlend(dsurface,((Rect.Left + (ColWidth - d.Width) div 2 - 1)+ACol)+ax - 10,
                       ((Rect.Top + (RowHeight - d.Height) div 2 + 1)+ARow) + ay - 10, d, 1);
              if (FrmMain.m_CurrentTick - ItemEffect.n_LastFrame) >= ItemEffect.n_NextFrame then begin
                if ItemEffect.n_CurrentFrame = 0 then
                  PlaySound(10310);
                ItemEffect.n_LastFrame:= FrmMain.m_CurrentTick;
                inc(ItemEffect.n_CurrentFrame);
                if ItemEffect.n_CurrentFrame = ItemEffect.n_EndFrame then begin
                   g_ItemEffects.Delete(i);
                   dispose(ItemEffect);
                   continue;
                end;
              end;
            end;
            inc(i);
          end;


          {if (not boDraw) and (g_UseItems[Tag].s.StdModeEx = sm_Arming) then begin
            if CheckWuXinConsistent(g_MySelf.m_btWuXin, g_UseItems[Tag].UserItem.Value.btValue[tb_wuxin]) or
              CheckWuXinRestraint(g_MySelf.m_btWuXin, g_UseItems[Tag].UserItem.Value.btValue[tb_wuxin]) then begin
              d := g_WMain2Images.Images[260 + (FrmMain.m_CurrentTick - AppendTick) div 150 mod 6];
              if d <> nil then begin
                DrawBlend(dsurface, SurfaceX(Left) - 21, SurfaceY(Top) - 23, d, 1);
              end;
            end;
          end; }
        end;
      end;
    end;
  end;
end;

procedure TFrmDlg.DItemGridGridSelect(Sender: TObject; X, Y: integer; ACol, ARow: Integer; Shift: TShiftState);
var
  idx: Integer;
  temp: TNewClientItem;
  nCount: Integer;
  sQuestion: string;
begin
  with Sender as TDGrid do begin
    if (FrmMain.m_CurrentTick - m_dwDblClick) < 500 then
      Exit;
    idx := ACol + ARow * ColCount + g_AddBagInfo[Tag].nStateCount;
    if idx in [Low(g_ItemArr)..High(g_ItemArr)] then begin
      {should never even have a chance to run this code }
      if (DMenuDlg.Visible) and ((g_CursorMode = cr_Sell) or (g_CursorMode = cr_Repair)) then begin
        if g_SellDlgItemSellWait.Item.s.name <> '' then
          exit;

        if g_CursorMode = cr_Sell then begin
          if CheckItemBindMode(@g_ItemArr[idx].UserItem, bm_NoSell) then
            exit;
          ItemClickSound(g_ItemArr[idx].S);
          g_SellDlgItemSellWait.Index2 := idx;
          g_SellDlgItemSellWait.Item := g_ItemArr[idx];
          g_SellDlgItemSellWait.ItemType := mtBagItem;
          frmMain.SendSellItem(g_nCurMerchant, g_SellDlgItemSellWait.Item.UserItem.MakeIndex);
          DelItemBagByIdx(idx);
        end
        else if g_CursorMode = cr_Repair then begin
          if ((sm_Arming in g_ItemArr[idx].s.StdModeEx) or (sm_HorseArm in g_ItemArr[idx].s.StdModeEx)) and
            (not (CheckItemBindMode(@g_ItemArr[idx].UserItem, bm_NoRepair))) and
            (g_ItemArr[idx].UserItem.Dura < g_ItemArr[idx].UserItem.DuraMax) then begin
            ItemClickSound(g_ItemArr[idx].S);
            g_SellDlgItemSellWait.Index2 := idx;
            g_SellDlgItemSellWait.Item := g_ItemArr[idx];
            g_SellDlgItemSellWait.ItemType := mtBagItem;
            DelItemBagByIdx(idx);
            frmMain.SendRepairItem(g_nCurMerchant, g_SellDlgItemSellWait.Item.UserItem.MakeIndex,
              MakeWord(Integer(boSuperRepair), 255));
          end;
        end;
        exit;
      end;
      {end of no chance}
      if not g_boItemMoving then begin
        if g_ItemArr[idx].S.name <> '' then begin
          if g_CursorMode = cr_SelItem then begin
            g_CursorMode := cr_None;
            FrmMain.Cursor := crMyNone;
            if (g_Selectitem.s.name <> '') and (g_SendSelectItem.s.name = '') then begin
              if (tm_MakeStone = g_Selectitem.S.StdMode) and (g_Selectitem.S.Shape = 3) then begin
                if sm_ArmingStrong in g_ItemArr[idx].S.StdModeEx then begin
                  if (g_ItemArr[idx].UserItem.Value.btFluteCount > 0) and (GetFluteCount(@g_ItemArr[idx].UserItem) > 0) then begin
                    if g_ItemArr[idx].UserItem.Value.StrengthenInfo.btStrengthenCount >= g_Selectitem.s.Need then begin
                      g_SendSelectItem := g_Selectitem;
                      FrmMain.SendClientSocket(CM_BAGUSEITEM, g_ItemArr[idx].UserItem.MakeIndex,
                        LoWord(g_Selectitem.UserItem.MakeIndex), HiWord(g_Selectitem.UserItem.MakeIndex), 0, '');
                    end
                    else
                      DMessageDlg('Gem properties do not comply with the level.', [mbOK]);
                  end
                  else
                    DMessageDlg('The equipment has no Stone Slot.', [mbOK]);
                end;
              end
              else if (tm_ResetStone = g_Selectitem.S.StdMode) then begin
                if sm_ArmingStrong in g_ItemArr[idx].S.StdModeEx then begin
                  if not CheckItemBindMode(@g_ItemArr[idx].UserItem, bm_Unknown) then begin
                    g_SendSelectItem := g_Selectitem;
                    FrmMain.SendClientSocket(CM_BAGUSEITEM, g_ItemArr[idx].UserItem.MakeIndex,
                      LoWord(g_Selectitem.UserItem.MakeIndex), HiWord(g_Selectitem.UserItem.MakeIndex), 0, '');
                  end
                  else
                    DMessageDlg('Unopened equipment, can not use this.', [mbOK]);
                end;
              end;
            end;
          end
          else if (ssShift in Shift) then begin
            if (g_UniteUseItem.Item.s.Name = '') and
              (sm_Superposition in g_ItemArr[idx].s.StdModeEx) and
              (g_ItemArr[idx].UserItem.Dura > 0) and (g_ItemArr[idx].UserItem.DuraMax > 1) then begin
              if mrYes = DMessageDlg('How much do you want to split?', [mbYes, mbNo, mbAbort], 10, deInteger) then begin
                nCount := StrToIntDef(DlgEditText, -1);
                if (nCount > 0) and (nCount <= (g_ItemArr[idx].UserItem.Dura - 1)) then begin
                  g_UniteUseItem.Index2 := idx;
                  g_UniteUseItem.Item := g_ItemArr[idx];
                  g_UniteUseItem.ItemType := mtBagItem;
                  FrmMain.SendClientMessage(CM_CHANGEITEMDURA, g_ItemArr[idx].UserItem.MakeIndex, nCount, 0, 0, '');
                end;
              end;
            end;

          end
          else if ssCtrl in Shift then begin
            if not DEditChat.Visible then begin
              DBTEditClick(DBTEdit, 0, 0);
            end;
            DEditChat.AddItemToList(g_ItemArr[idx].S.name, IntToStr(g_ItemArr[idx].UserItem.MakeIndex));
            //DEditChat.AddImageToList(IntToStr(FaceSelectindex));
            //DWndFace.Visible := False;
          end
          else begin
            g_boItemMoving := True;
            g_MovingItem.Index2 := idx;
            g_MovingItem.Item := g_ItemArr[idx];
            g_MovingItem.ItemType := mtBagItem;
            DelItemBagByIdx(idx);
            ItemClickSound(g_ItemArr[idx].S);
          end;
        end;
      end
      else begin //if there's an item stuck on our cursor already (movingitem)
        if g_CursorMode = cr_SelItem then begin
          g_CursorMode := cr_None;
          FrmMain.Cursor := crMyNone;
        end;
        if g_MovingItem.ItemType <> mtBagGold then begin
          if g_MovingItem.ItemType = mtStateItem then begin //item is comming from our equipment
            if (g_WaitingUseItem.Item.S.name <> '') or (g_MovingItem.Item.s.Name = '') then
              Exit;
            g_WaitingUseItem.Index2 := g_MovingItem.Index2;
            g_WaitingUseItem.Item := g_MovingItem.Item;
            g_WaitingUseItem.ItemType := mtBagItem;
            ItemClickSound(g_WaitingUseItem.Item.S);
            frmMain.SendTakeOffItem(-(g_MovingItem.Index2 + 1), g_WaitingUseItem.Item.UserItem.MakeIndex, g_WaitingUseItem.Item.S.name);
            g_MovingItem.Item.S.name := '';
            g_boItemMoving := False;
          end
          else if g_MovingItem.ItemType = mtBottom then
            ClearMovingItem()
          else if g_MovingItem.ItemType = mtDealGold then
            DGoldClick(Self, 0, 0)
          else if g_MovingItem.ItemType = mtBagItem then begin //item is comming from our bag
            if (g_ItemArr[idx].S.name <> '') and
              (g_ItemArr[idx].UserItem.MakeIndex <> g_MovingItem.Item.UserItem.MakeIndex) and
              (g_ItemArr[idx].s.Idx = g_MovingItem.Item.s.Idx) and
              (sm_Superposition in g_MovingItem.Item.s.StdModeEx) and
              (g_MovingItem.Item.s.StdMode = g_ItemArr[idx].S.StdMode) and
              (g_ItemArr[idx].UserItem.Dura < g_ItemArr[idx].UserItem.DuraMax) then begin
              if (g_ItemArr[idx].UserItem.btBindMode1 = g_MovingItem.Item.UserItem.btbindmode1) and
                (g_ItemArr[idx].UserItem.btBindMode2 = g_MovingItem.Item.UserItem.btbindmode2) then begin
                if (g_UniteUseItem.Item.s.Name = '') then begin
                  FrmMain.SendClientMessage(CM_CHANGEITEMDURA, g_ItemArr[idx].UserItem.MakeIndex,
                    LoWord(g_MovingItem.Item.UserItem.MakeIndex), HiWord(g_MovingItem.Item.UserItem.MakeIndex), 1, '');
                  g_UniteUseItem := g_MovingItem;
                  ClearMovingItem();
                end;
              end
              else begin
                AddItemBag(g_MovingItem.Item, g_MovingItem.Index2);
                ClearMovingItem();
                DMessageDlg('Can not perform this action', []);
                exit;
              end;
            end
            else begin
              if g_ItemArr[idx].S.name <> '' then begin //if we are moving an item, it's not a stackable item, and there's another item in the spot we just clicked
                if (ssCtrl in shift) and (g_MovingItem.Item.s.StdMode = tm_gem) and //item we are moving is a gem/orb/repair item
                  (g_ItemArr[idx].s.StdMode in [tm_Weapon, tm_Necklace, tm_Ring, tm_ArmRing, tm_Dress, tm_Helmet, tm_Belt, tm_Boot]) //only these can be repaired or gemmed so
                then begin
                  if (g_MovingItem.Item.s.Shape in [3,4]) then begin //repair items
                    if (g_ItemArr[idx].UserItem.Dura < g_ItemArr[idx].UserItem.DuraMax) then begin
                      if ((g_MovingItem.Item.s.Shape = 3) and (g_ItemArr[idx].s.StdMode in [tm_Weapon, tm_Necklace, tm_Ring, tm_ArmRing])) or
                         ((g_MovingItem.Item.s.Shape = 4) and (g_ItemArr[idx].s.StdMode in [tm_Dress, tm_Helmet, tm_Belt, tm_Boot])) then begin
                        if mrYes = DMessageDlg('Do you wish to repair [' + g_ItemArr[idx].S.name + ']?', [mbYes, mbNo]) then
                          FrmMain.SendClientMessage(CM_UPGRADEITEM, g_ItemArr[idx].UserItem.MakeIndex, LoWord(g_MovingItem.Item.UserItem.MakeIndex), HiWord(g_MovingItem.Item.UserItem.MakeIndex), 0, '');
                      end else
                        DMessageDlg('You cannot use ' + g_MovingItem.Item.s.Name + ' to repair ' + g_ItemArr[idx].s.Name, [mbOK]);
                    end else
                      DMessageDlg('Item is already at maximum durability', [mbOK]);
                  end else begin //gems and orbs
                    sQuestion := 'Do you wish to attempt upgrading [' + g_ItemArr[idx].S.Name + ']?';
                    if (g_MovingItem.Item.s.Shape = 0) then
                      sQuestion := 'Do you wish to attempt upgrading [' + g_ItemArr[idx].S.Name + ']?\ Warning: chance of breaking the item!';
                    if mrYes = DMessageDlg(sQuestion, [mbYes, mbNo]) then
                      FrmMain.SendClientMessage(CM_UPGRADEITEM, g_ItemArr[idx].UserItem.MakeIndex, LoWord(g_MovingItem.Item.UserItem.MakeIndex), HiWord(g_MovingItem.Item.UserItem.MakeIndex), 0, '');

                  end;
                  AddItemBag(g_MovingItem.Item, g_MovingItem.Index2);
                  clearMovingItem();
                  exit;
                end;
                temp := g_ItemArr[idx];
                DelItemBagByIdx(idx);
                AddItemBag(g_MovingItem.Item, idx);
                g_MovingItem.Index2 := idx;
                g_MovingItem.Item := temp
              end
              else begin
                AddItemBag(g_MovingItem.Item, idx);
                ClearMovingItem();
              end;
            end;
          end;
        end
        else begin
          ClearMovingItem();
        end;
      end;
    end;
    ArrangeItembag;
  end;
end;

procedure TFrmDlg.DLoginChgPwClick(Sender: TObject; X, Y: Integer);
begin
    FrmMain.SendAccountCreateValidation(1);
end;

procedure TFrmDlg.DLoginCloseClick(Sender: TObject; X, Y: Integer);
begin
  FrmMain.CSocket.Active := False;
  DScreen.ChangeScene(stSelServer);
end;

procedure TFrmDlg.DLogInDirectPaint(Sender: TObject;
  dsurface: TDXTexture);
var
  d: TDXTexture;
  ax, ay: integer;
begin
  with Sender as TDWindow do begin
    ax := SurfaceX(Left);
    ay := SurfaceY(Top);
    d := WLib.Images[FaceIndex];
    if d <> nil then
      DrawWindow(dsurface, ax, ay, d);
  end;
end;

procedure TFrmDlg.DLoginHomeClick(Sender: TObject; X, Y: Integer);
begin
  SendMessage(Application.Handle, WM_SYSCOMMAND, SC_MINIMIZE, 0);
  ShellExecute(Handle, 'Open', 'http://www.acem2.com/', '', '', SW_SHOW);
end;

procedure TFrmDlg.DLoginHomeDirectPaint(Sender: TObject;
  dsurface: TDXTexture);
var
  d: TDXTexture;
  FColor: TColor;
begin
  with Sender as TDButton do begin
    d := nil;
    if WLib <> nil then
        d := WLib.Images[FaceIndex];
    if MouseEntry = msIn then begin
      if WLib <> nil then
        d := WLib.Images[FaceIndex + 1];
    end;
    if TDButton(Sender).Downed then begin
      if WLib <> nil then
        d := WLib.Images[FaceIndex + 2];
    end;
    if d <> nil then
      dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, True);
  end;
end;

procedure TFrmDlg.DLoginNewClick(Sender: TObject; X, Y: Integer);
begin
  FrmMain.SendAccountCreateValidation(0);
end;

procedure TFrmDlg.DMagicFrontClick(Sender: TObject; X, Y: Integer);
begin
  if (Sender = DMagicFront) then begin
    if MagicPage > 0 then
      Dec(MagicPage);
  end
  else if (Sender = DMagicNext) then begin
    if MagicPage < MagicMaxPage then
      Inc(MagicPage);
  end;
end;

procedure TFrmDlg.DMagicFrontDirectPaint(Sender: TObject; dsurface: TDXTexture);
var
  d: TDXTexture;
  idx: Integer;
begin
  with Sender as TDButton do begin
    if WLib <> nil then begin
      idx := 0;
      if Downed then begin
        inc(idx, 2)
      end
      else if MouseEntry = msIn then begin
        Inc(idx, 1)
      end;
      d := WLib.Images[FaceIndex + idx];
      if d <> nil then
        dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, True);
    end;
  end;
end;

procedure TFrmDlg.DMakeMagicAdd1Click(Sender: TObject; X, Y: Integer);
begin
  if g_boSendMakeMagicAdd then
    Exit;
  with Sender as TDButton do begin
    if g_MakeMagic[Tag] < g_btMakeMagicMaxLevel then begin
      g_boSendMakeMagicAdd := True;
      FrmMain.SendClientMessage(CM_MAKEMAGIC, Tag, 0, 0, 0);
    end;
  end;
end;

procedure TFrmDlg.DMaxMap792DirectPaint(Sender: TObject;
  dsurface: TDXTexture);
var
  d: TDXTexture;
  mx, my, i: integer;
  rc, dc: TRect;
  actor: TActor;
  cX, cY: integer;
  btColor: Byte;
  boMove: Boolean;
  ax, ay: integer;
  MapDesc: pTMapDesc;
  nWidth, nHeight: Integer;
begin
  with Sender as TDWindow do begin
    if g_MySelf = nil then
      exit;
    if FrmMain.m_CurrentTick > m_dwBlinkTime + 300 then begin
      m_dwBlinkTime := FrmMain.m_CurrentTick;
      m_boViewBlink := not m_boViewBlink;
    end;
    if g_nMiniMapIndex > 10000 then
      d := g_WUIBImages.Images[g_nMiniMapIndex - 10000]
    else if g_nMiniMapIndex >= 1000 then
      d := g_WMyMMapImages.Images[g_nMiniMapIndex - 1000]
    else
      d := g_WMMapImages.Images[g_nMiniMapIndex];
    //d := g_WMMapImages.Images[g_nMiniMapIndex];
    if d = nil then begin
      DMaxMiniMap.Visible := False;
      exit;
    end;
    cx := -1;
    cy := 0;

    ax := SurfaceX(Left);
    ay := SurfaceY(Top);

    nWidth := _MIN(d.ClientRect.Right, Width);
    nHeight := _MIN(d.ClientRect.Bottom, Height);

    dc.Left := ax + (Width - nWidth) div 2;
    dc.Top := ay + (Height - nHeight) div 2;
    dc.Right := dc.Left + nWidth;
    dc.Bottom := dc.Top + nHeight;
    rc.Left := 0;
    rc.Top := 0;
    rc.Right := d.ClientRect.Right;
    rc.Bottom := d.ClientRect.Bottom;
    DSurface.StretchDraw(dc, rc, d, True);

    if (g_nMiniMapMaxX >= dc.Left) and (g_nMiniMapMaxX <= dc.Right) and
      (g_nMiniMapMaxY >= dc.Top) and (g_nMiniMapMaxY <= dc.Bottom) then begin
      cX := (g_nMiniMapMaxX - dc.Left) * 32 * rc.Right div nWidth div 48;
      cy := (g_nMiniMapMaxY - dc.Top) * rc.Bottom div nHeight;
    end;

    if cx > -1 then begin
      g_nMiniMapMaxMosX := cX;
      g_nMiniMapMaxMosY := cY;
    end
    else begin
      g_nMiniMapMaxMosX := g_MySelf.m_nCurrX;
      g_nMiniMapMaxMosY := g_MySelf.m_nCurrY;
    end;
    with g_DXCanvas do begin
      if (g_MapDesc <> nil) and g_SetupInfo.boShowMapHint then begin
        //SetBkMode(Handle, TRANSPARENT);
        for i := 0 to g_MapDesc.MaxList.Count - 1 do begin
          MapDesc := g_MapDesc.MaxList[i];
          if MapDesc.nColor > 0 then begin
            mx := dc.Left + Trunc((MapDesc.nX * 48) * (nWidth / rc.Right)) div 32;
            my := dc.Top + Trunc(MapDesc.nY * (nHeight / rc.Bottom));
            TextOut(mx - TextWidth(MapDesc.sName) div 2, my, MapDesc.nColor, MapDesc.sName);
          end;
        end;
        //Release;
      end;
      if (g_nMiniMapPath <> nil) and (High(g_nMiniMapPath) > 0) then begin
        //SetBkMode(Handle, TRANSPARENT);
        //Pen.Color := clRed;
        boMove := False;
        mx := -1;
        my := -1;
        for I := Low(g_nMiniMapPath) to High(g_nMiniMapPath) do begin
          mx := dc.Left + Trunc((g_nMiniMapPath[i].X * 48) * (nWidth / rc.Right)) div 32;
          my := dc.Top + Trunc(g_nMiniMapPath[i].Y * (nHeight / rc.Bottom));
          if boMove then
            LineTo(mx, my, clRed)
          else
            MoveTo(mx, my);
          boMove := True;
        end;
        //Release;
        d := g_WMain99Images.Images[71];
        if d <> nil then
          DSurface.Draw(mx - 2, my + 2 - d.Height, d.ClientRect, d, True);
      end;
    end;
    TempList.Clear;
    for I := 0 to PlayScene.m_ActorList.Count - 1 do begin
      actor := TActor(PlayScene.m_ActorList.Items[I]);
      if (actor <> nil) and
        (actor <> g_MySelf) and
        (not actor.m_boDeath) and
        (abs(g_MySelf.m_nCurrX - actor.m_nCurrX) < 20) and
        (abs(g_MySelf.m_nCurrY - actor.m_nCurrY) < 20) then begin
        mx := dc.Left + Trunc((actor.m_nCurrX * 48) * (nWidth / rc.Right)) div 32;
        my := dc.Top + Trunc(actor.m_nCurrY * (nHeight / rc.Bottom));
        if (actor.m_Group <> nil) or (actor.m_btRace = 50) then begin
          TempList.Add(actor);
          Continue;
        end;
        if ((Actor.m_btRace <> RCC_USERHUMAN) and
          (Actor.m_btRaceServer in [RC_GUARD, RC_ARCHERGUARD])) then begin
          btColor := 65 {129};
        end
        else begin
          case actor.m_btRace of //
            0: btColor := 66;
          else
            btColor := 67;
          end;
        end;
        d := g_WMain99Images.Images[btColor];
        if d <> nil then
          dsurface.Draw(mx - d.Width div 2, my - d.Height div 2,
            d.ClientRect, d, True);
      end;
    end;

    if TempList.Count > 0 then
      for I := 0 to TempList.Count - 1 do begin
        actor := TActor(TempList.Items[I]);
        mx := dc.Left + Trunc((actor.m_nCurrX * 48) * (nWidth / rc.Right)) div 32;
        my := dc.Top + Trunc(actor.m_nCurrY * (nHeight / rc.Bottom));
        case actor.m_btRace of //
          50: btColor := 68;
        else
          btColor := 69;
        end;
        d := g_WMain99Images.Images[btColor];
        if d <> nil then
          dsurface.Draw(mx - d.Width div 2, my - d.Height div 2,
            d.ClientRect, d, True);
      end;

    if not m_boViewBlink then begin
      mx := dc.Left + Trunc((g_MySelf.m_nCurrX * 48) * (nWidth / rc.Right)) div 32;
      my := dc.Top + Trunc(g_MySelf.m_nCurrY * (nHeight / rc.Bottom));
      d := g_WMain99Images.Images[70];
      if d <> nil then
        dsurface.Draw(mx - d.Width div 2, my - d.Height div 2,
          d.ClientRect, d, True);
    end;
    if cx > -1 then begin
      mx := dc.Left + Trunc((cX * 48) * (nWidth / rc.Right)) div 32;
      my := dc.Top + Trunc(cY * (nHeight / rc.Bottom)) + 2;
      d := g_WMain99Images.Images[71];
      if d <> nil then
        DSurface.Draw(mx, my - d.Height, d.ClientRect, d, True);
    end;
  end;
end;

procedure TFrmDlg.DMaxMap792MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if Button = mbRight then begin
    g_boAutoMoveing := False;
    FrmMain.SendSay(g_Cmd_UserMove + ' ' + IntToStr(g_nMiniMapMaxMosX) + ' ' + IntToStr(g_nMiniMapMaxMosY) + ' TOPHINT');
  end else begin
    g_nMiniMapPath := FindPath(g_nMiniMapMaxMosX, g_nMiniMapMaxMosY);
    if High(g_nMiniMapPath) > 2 then begin
      g_boAutoMoveing := False;
      g_nMiniMapMoseX := g_nMiniMapMaxMosX;
      g_nMiniMapMoseY := g_nMiniMapMaxMosY;
      DScreen.AddSysMsg(Format('[Click the screen to stop moving.]',
        [g_nMiniMapMaxMosX, g_nMiniMapMaxMosY]), clWhite);
      {DScreen.AddChatBoardString(Format('自动移动(%d,%d)，点击屏幕停止移动！',
        [g_nMiniMapMaxMosX, g_nMiniMapMaxMosY]), GetRGB(180), clWhite);    }
      g_boAutoMoveing := True;
      g_boNpcMoveing := False;
    end
    else begin
      g_nMiniMapMoseX := -1;
      g_nMiniMapMoseY := -1;
      DScreen.AddSysMsg('[Unable to reach destination]', clWhite);
      //DScreen.AddChatBoardString('自动移动失败，无法到达终点！', GetRGB(56), clWhite);
    end;
  end;
end;

procedure TFrmDlg.DMaxMap792MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
var
  ShowStr: string;
begin
  g_nMiniMapMaxX := DMaxMap792.SurfaceX(x);
  g_nMiniMapMaxY := DMaxMap792.SurfaceY(Y);
  ShowStr := 'Left-Click to automatically find path';
  //ShowStr := ShowStr + '右键单击自动传送\(<自动传送需要配戴传送装备/FCOLOR=$FFFF>)';
  DScreen.ShowHint(DMaxMap792.SurfaceX(DMaxMap792.Left + x), DMaxMap792.SurfaceY(DMaxMap792.Top) + Y, ShowStr, clWhite, False, x);
end;

procedure TFrmDlg.DMaxMinimapCloseClick(Sender: TObject; X, Y: Integer);
begin
  with Sender as TDButton do begin
    if DParent <> nil then
      DParent.Visible := False;
  end;
end;

procedure TFrmDlg.DMaxMiniMapDirectPaint(Sender: TObject;
  dsurface: TDXTexture);
var
  d: TDXTexture;
  ax, ay: integer;
begin
  with Sender as TDWindow do begin
    ax := SurfaceX(Left);
    ay := SurfaceY(Top);
    d := WLib.Images[FaceIndex];
    if d <> nil then
      dsurface.Draw(ax, ay, d.ClientRect, d, False);

    with g_DXCanvas do begin
      //SetBkMode(Handle, TRANSPARENT);
      //Font.Color := clWhite;
      TextOut(ax + 162 - TextWidth(g_sMapTitle) div 2, ay + 14, g_sMapTitle, clWhite);
      if (g_nMiniMapMaxMosX <> g_MySelf.m_nCurrX) or (g_nMiniMapMaxMosY <> g_MySelf.m_nCurrY) then begin
        TextOut(ax + 315, ay + 14, IntToStr(g_MySelf.m_nCurrX) + ',' +
          IntToStr(g_MySelf.m_nCurrY) + '  ->  ' + IntToStr(g_nMiniMapMaxMosX)
          + ',' + IntToStr(g_nMiniMapMaxMosY), clWhite);
      end
      else begin
        TextOut(ax + 315, ay + 14, IntToStr(g_MySelf.m_nCurrX) + ',' +
          IntToStr(g_MySelf.m_nCurrY) + '  ->  0,0', clWhite);
      end;
      if g_nMiniMapMoseX <> -1 then begin
        TextOut(ax + 520, ay + 14, IntToStr(g_nMiniMapMoseX)
          + ',' + IntToStr(g_nMiniMapMoseY) + ' is moving, and the remaining ' +
          IntToStr(High(g_nMiniMapPath)) + ' steps', clWhite);
      end
      else begin
        TextOut(ax + 520, ay + 14, '0,0  No destination set, click map to set one.', clWhite);
      end;
      //Release;
    end;
  end;
end;

procedure TFrmDlg.DMDlgUpDonwEndDirectPaint(Sender: TObject;
  dsurface: TDXTexture);
var
  d: TDXTexture;
begin
  if not g_boShowRollBarHint then
    exit;
  if TDUpDown(Sender).MoveShow and Assigned(TDUpDown(Sender).MoveButton) then
  begin
    with TDUpDown(Sender).MoveButton as TDButton do begin
      d := g_WMain99Images.Images[182];
      if d <> nil then
        dsurface.Draw(SurfaceX(Left + Width div 2), SurfaceY(Top + Height div 2), d.ClientRect, d, True);
    end;
  end;
end;

procedure TFrmDlg.DMDlgUpDonwPositionChange(Sender: TObject);
begin
  g_boShowRollBarHint := False;
end;

procedure TFrmDlg.DMerchantDlgClick(Sender: TObject; X, Y: Integer);
var
  L, T: Integer;
begin
  if FrmMain.m_CurrentTick < LastestClickTime then
    Exit;
  L := DMerchantDlg.Left + 20;
  T := DMerchantDlg.Top + 28;
  if ((X - DMerchantDlg.Left - 20) < g_MERCHANTMAXWIDTH) and ((Y - DMerchantDlg.Top - 28) < g_MERCHANTMAXHEIGHT) then begin
    Y := Y + DMDlgUpDonw.Position;
    with DMerchantDlg do begin
      if (MDlgSelect.rstr <> '') and
        (X >= SurfaceX(L + MDlgSelect.Rc.Left)) and (X <= SurfaceX(L + MDlgSelect.Rc.Right)) and
        (Y >= SurfaceY(T + MDlgSelect.Rc.Top)) and (Y <= SurfaceY(T + MDlgSelect.Rc.Bottom)) then begin
        PlaySound(s_glass_button_click);
        LastestClickTime := FrmMain.m_CurrentTick + 5000;
        //DScreen.AddSysMsg(MDlgSelect.rstr, clWhite);
        frmMain.SendMerchantDlgSelect(g_nCurMerchant, MDlgSelect.rstr);
        MDlgSelect.rstr := '';
        exit;
      end;
    end;
  end;
  MDlgSelect.rstr := '';
end;

procedure TFrmDlg.DMerchantDlgCloseClick(Sender: TObject; X, Y: Integer);
begin
  CloseMDlg;
end;

procedure TFrmDlg.DMerchantDlgDirectPaint(Sender: TObject; dsurface: TDXTexture);
var
  d: TDXTexture;
  ax, ay, I, Index, px, py: integer;
  rc, dc: TRect;
  pShowHint: pTNewShowHint;
  dwTime: LongWord;
begin
  with Sender as TDWindow do begin
    ax := SurfaceX(Left);
    ay := SurfaceY(Top);
    d := WLib.Images[FaceIndex];
    if d <> nil then begin
      DrawWindow(dsurface, ax, ay, d);
      rc.Left := 0;
      rc.Top := DMDlgUpDonw.Position;
      rc.Right := g_MERCHANTMAXWIDTH;
      rc.Bottom := DMDlgUpDonw.Position + g_MerchantMaxHeight;
      Inc(ax, 20);
      Inc(ay, 28);  //18
      dwTime := FrmMain.m_CurrentTick;
      for i := 0 to MDlgDraws.Count - 1 do begin
        pShowHint := MDlgDraws[i];
        if (pShowHint.Surfaces <> nil) and (pShowHint.IndexList <> nil) and (pShowHint.IndexList.Count > 0) then begin
          Index := dwTime div pShowHint.dwTime mod LongWord(pShowHint.IndexList.Count);
          d := pShowHint.Surfaces.GetCachedImage(StrToIntDef(pShowHint.IndexList[Index], -1), px, py);
          if d <> nil then begin
            if pShowHint.boMove then begin
              px := pShowHint.nX + px;
              py := pShowHint.ny + py - DMDlgUpDonw.Position;
            end
            else begin
              px := pShowHint.nX;
              py := pShowHint.ny - DMDlgUpDonw.Position;
            end;
            if pShowHint.boRect then
              dc := pShowHint.Rect
            else
              dc := d.ClientRect;
            if px >= rc.Right then
              Continue;
            if py >= g_MerchantMaxHeight then
              Continue;
            if px < 0 then begin
              dc.Left := -px;
              px := 0;
            end;
            if py < 0 then begin
              dc.Top := -py;
              py := 0;
            end;
            if (dc.Right - dc.Left + px) > rc.Right then
              dc.Right := rc.Right - px - dc.Left;
            if (dc.Bottom - dc.Top + py) > g_MerchantMaxHeight then
              dc.Bottom := g_MerchantMaxHeight - py - dc.Top;
            if (dc.Right - dc.Left) <= 0 then
              Continue;
            if (dc.Bottom - dc.Top) <= 0 then
              Continue;
            if pShowHint.boBlend then
              DrawBlendR(DSurface, ax + px, ay + py, dc, d, Integer(pShowHint.boTransparent))
            else
              DSurface.Draw(ax + px, ay + py, dc, d, pShowHint.boTransparent);
          end;
        end;

      end;
      DSurface.Draw(ax, ay, rc, Surface, TRUE);
        if (MDlgSelect.rstr <> '') and (DMerchantDlg.Downed) and (not MDlgSelect.boItem) then begin
          dc := MDlgSelect.rc;
          dc.Left := ax + dc.Left;
          dc.Right := ax + dc.Right;
          dc.Top := dc.Top - DMDlgUpDonw.Position;
          dc.Bottom := dc.Bottom - DMDlgUpDonw.Position;
          if (dc.Bottom > 0) and (dc.Top < rc.Bottom) then begin
            dc.Top := dc.Top + ay;
            dc.Bottom := dc.Bottom + ay;
            if MDlgMove.boNewPoint then begin
              dc.Top := dc.Top - 2;
              dc.Bottom := dc.Bottom + 3;
              g_DXCanvas.FillRect(dc.Left + MDLGCLICKOX, dc.Top, dc.Right - dc.Left - 20,
                dc.Bottom - dc.Top, $B4635C63);
              g_DXCanvas.TextOut(dc.Left + NEWPOINTOX + 1, dc.Top + 2 + NEWPOINTOY, MDlgMove.sstr, MDlgMove.Color);
              d := g_WMain99Images.Images[MDLGCHICKIMAGE];
              if d <> nil then begin
                g_DXCanvas.Draw(dc.Left, dc.Top + 2, d.ClientRect, d, True);
              end;
            end
            else begin
              g_DXCanvas.MoveTo(dc.Left - 1, dc.Top + g_DXCanvas.TextHeight(MDlgMove.sstr) + 1);
              g_DXCanvas.LineTo(dc.Right - 3, dc.Top + g_DXCanvas.TextHeight(MDlgMove.sstr) + 1, clBlack);
              g_DXCanvas.TextOut(dc.Left + 1, dc.Top + 1, MDlgSelect.sstr, clLime);
              g_DXCanvas.MoveTo(dc.Left + 1, dc.Top + g_DXCanvas.TextHeight(MDlgMove.sstr) + 2);
              g_DXCanvas.LineTo(dc.Right, dc.Top + g_DXCanvas.TextHeight(MDlgMove.sstr) + 2, clLime);
            end;
          end;
        end
        else if (MDlgMove.rstr <> '') and (not DMerchantDlg.Downed) and (not MDlgMove.boItem) then begin
          dc := MDlgMove.rc;
          dc.Left := ax + dc.Left;
          dc.Right := ax + dc.Right;
          dc.Top := dc.Top - DMDlgUpDonw.Position;
          dc.Bottom := dc.Bottom - DMDlgUpDonw.Position;
          if (dc.Bottom > 0) and (dc.Top < rc.Bottom) then begin
            dc.Top := dc.Top + ay;
            dc.Bottom := dc.Bottom + ay;
            if MDlgMove.boNewPoint then begin
              dc.Top := dc.Top - 2;
              dc.Bottom := dc.Bottom + 3;
              g_DXCanvas.FillRect(dc.Left + MDLGCLICKOX, dc.Top, dc.Right - dc.Left - 20, dc.Bottom - dc.Top, $B4939594);
              g_DXCanvas.TextOut(dc.Left + NEWPOINTOX, dc.Top + 1 + NEWPOINTOY, MDlgMove.sstr, MDlgMove.Color);
              d := g_WMain99Images.Images[MDLGMOVEIMAGE];
              if d <> nil then begin
                g_DXCanvas.Draw(dc.Left, dc.Top + 2, d.ClientRect, d, True);
              end;
            end
            else begin
              g_DXCanvas.TextOut(dc.Left, dc.Top, MDlgMove.sstr, clAqua);
              g_DXCanvas.MoveTo(dc.Left, dc.Top + g_DXCanvas.TextHeight(MDlgMove.sstr) + 1);
              g_DXCanvas.LineTo(dc.Right - 1, dc.Top + g_DXCanvas.TextHeight(MDlgMove.sstr) + 1, clAqua);

            end;
          end;
        end;
    end;
  end;
end;

procedure TFrmDlg.DMerchantDlgMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  i, L, T: Integer;
  p: pTClickPoint;
begin
  MDlgRefTime := 0;
  if FrmMain.m_CurrentTick < LastestClickTime then
    Exit;
  MDlgSelect.rstr := '';
  L := DMerchantDlg.Left + 20;
  T := DMerchantDlg.Top + 28;     //18
  if ((X - DMerchantDlg.Left - 20) < g_MERCHANTMAXWIDTH) and ((Y - DMerchantDlg.Top - 28) < g_MERCHANTMAXHEIGHT) then begin
    Y := Y + DMDlgUpDonw.Position;
    with DMerchantDlg do begin
      for i := 0 to MDlgPoints.count - 1 do begin
        p := pTClickPoint(MDlgPoints[i]);
        if (not p.boItem) and (X >= SurfaceX(L + p.rc.Left)) and (X <= SurfaceX(L + p.rc.Right)) and
          (Y >= SurfaceY(T + p.rc.Top)) and (Y <= SurfaceY(T + p.rc.Bottom)) then begin
          MDlgSelect := p^;
          exit;
        end;
      end;
    end;
  end;
end;

procedure TFrmDlg.DMerchantDlgMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
var
  i, L, T, nY: Integer;
  p: pTClickPoint;
begin
  MDlgMove.rstr := '';
  if DMerchantDlg.Downed then
    exit;
  MDlgSelect.rstr := '';
  L := DMerchantDlg.Left + 20;
  T := DMerchantDlg.Top + 28;
  if ((X - DMerchantDlg.Left - 20) < g_MERCHANTMAXWIDTH) and ((Y - DMerchantDlg.Top - 28) < g_MERCHANTMAXHEIGHT) then begin
    nY := y;
    Y := Y + DMDlgUpDonw.Position;
    with DMerchantDlg do begin
      for i := 0 to MDlgPoints.count - 1 do begin
        p := pTClickPoint(MDlgPoints[i]);
        if (X >= SurfaceX(L + p.rc.Left)) and (X <= SurfaceX(L + p.rc.Right)) and
          (Y >= SurfaceY(T + p.rc.Top)) and (Y <= SurfaceY(T + p.rc.Bottom)) then begin
          if p.boItem then begin
            if SurfaceY(nY) > 320 then
              DScreen.ShowHint(SurfaceX(X), SurfaceY(nY),
                ShowItemInfo(p.Item, [], []), clwhite, True, p.Item.s.Idx, True)
            else
              DScreen.ShowHint(SurfaceX(X) + 30, SurfaceY(nY + 30),
                ShowItemInfo(p.Item, [], []), clwhite, False, p.Item.s.Idx, True);
          end
          else begin
            MDlgMove := p^;
          end;
          break;
        end;
      end;
    end;
  end;
end;

procedure TFrmDlg.DModalDlgKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  MDWindow: TDModalWindow;
begin
  MDWindow := nil;
  if Sender is TDModalWindow then begin
    MDWindow := TDModalWindow(Sender);
  end
  else if (Sender is TDEdit) and (TDEdit(Sender).DParent is TDModalWindow) then begin
    MDWindow := TDModalWindow(TDEdit(Sender).DParent);
  end;

  if MDWindow <> nil then
    with MDWindow do begin
      if Key = 13 then begin
        DialogResult := YesResult;
        Visible := FALSE;
        Key := 0;
      end;
      if Key = 27 then begin
        DialogResult := NoResult;
        Visible := FALSE;
        Key := 0;
      end;
    end;
end;

procedure TFrmDlg.DModalDlgChange(Sender: TObject);
begin
  with Sender as TDCheckBox do begin
    if Tag = 0 then begin
      Checked := True;
      if TObject(AppendData) is TDCheckBox then
        TDCheckBox(AppendData).Checked := False;
      DlgChecked := False;
    end
    else begin
      Checked := True;
      if TObject(AppendData) is TDCheckBox then
        TDCheckBox(AppendData).Checked := False;
      DlgChecked := True;
    end;
  end;
end;

procedure TFrmDlg.DModalDlgOkClick(Sender: TObject; X, Y: Integer);
begin
  if (Sender is TDButton) and (TDButton(Sender).DParent <> nil) then begin
    with TDButton(Sender).DParent as TDModalWindow do begin
      if TDButton(Sender).Tag = 1 then
        DialogResult := YesResult;
      if TDButton(Sender).Tag = 0 then
        DialogResult := NoResult;
      Visible := FALSE;
    end;
  end;
end;

function TFrmDlg.DModalMessageDlg(nShowCount: Integer; msgstr: string; DlgButtons: TMsgDlgButtons; MsgLen: Integer = 70; EClass:
  TDEditClass = deNone; defmsg: string = ''; boBottom: Boolean = false): TModalResult;
var
  lx, ly: integer;
  d: TDXTexture;
  str, data: string;
  nLen: integer;
  nHeight, nWidth: integer;
  i: integer;
  DMsgMaxLen: Integer;
  DMsgLeft: Integer;
  DMsgTop: Integer;
  ModalWindow: TDModalWindow;
  DEdit: TDEdit;
  DOKButton, DNoButton: TDButton;
  CheckBoxYes, CheckBoxNo: TDCheckBox;

  procedure ShowDice();
  var
    I: Integer;
    bo05: Boolean;
  begin
    if m_nDiceCount = 1 then begin
      if m_Dice[0].n67C < 20 then begin
        if FrmMain.m_CurrentTick - m_Dice[0].dwPlayTick > 100 then begin
          if m_Dice[0].n67C div 5 = 4 then begin
            m_Dice[0].nPlayPoint := Random(6) + 1;
          end
          else begin
            m_Dice[0].nPlayPoint := m_Dice[0].n67C div 5 + 8;
          end;
          m_Dice[0].dwPlayTick := FrmMain.m_CurrentTick;
          Inc(m_Dice[0].n67C);
        end;
        exit;
      end; //00491461
      m_Dice[0].nPlayPoint := m_Dice[0].nDicePoint;
      if FrmMain.m_CurrentTick - m_Dice[0].dwPlayTick > 1500 then begin
        ModalWindow.Visible := False;
      end;
      exit;
    end; //004914AD

    bo05 := True;
    for I := 0 to m_nDiceCount - 1 do begin
      if m_Dice[I].n67C < m_Dice[I].n680 then begin
        if FrmMain.m_CurrentTick - m_Dice[I].dwPlayTick > 100 then begin
          if m_Dice[I].n67C div 5 = 4 then begin
            m_Dice[I].nPlayPoint := Random(6) + 1;
          end
          else begin
            m_Dice[I].nPlayPoint := m_Dice[I].n67C div 5 + 8;
          end;
          m_Dice[I].dwPlayTick := FrmMain.m_CurrentTick;
          Inc(m_Dice[I].n67C);
        end;
        bo05 := False;
      end
      else begin //004915E4
        m_Dice[I].nPlayPoint := m_Dice[I].nDicePoint;
        if FrmMain.m_CurrentTick - m_Dice[I].dwPlayTick < 2000 then begin
          bo05 := False;
        end;
      end;
    end; //for
    if bo05 then begin
      ModalWindow.Visible := False;
    end;

  end;
begin
  //  Result := mrCancel;
  Result := mrCancel;
  if (msgstr = '') and (not (mbHelp in DlgButtons)) then
    exit;

  ModalWindow := TDModalWindow.Create(Self);
  ModalWindow.Parent := Self;
  d := g_WMain99Images.Images[30];
  if d <> nil then begin
    ModalWindow.SetImgIndex(g_WMain99Images, 30);
    ModalWindow.Left := (g_FScreenWidth - d.Width) div 2;
    if boBottom then
      ModalWindow.Top := (g_FScreenHeight - d.Height) - 20
    else
      ModalWindow.Top := (g_FScreenHeight - d.Height) div 2;
  end;
  DEdit := nil;
  DOKButton := nil;
  DNoButton := nil;
  CheckBoxYes := nil;
  CheckBoxNo := nil;
  try
    ModalWindow.YesResult := mrOk;
    ModalWindow.NoResult := mrCancel;

    //    lx := 148;
    //    ly := 78;
    ModalWindow.KeyFocus := True;
    ModalWindow.Visible := False;
    //ModalWindow.DParent := DBackground;
    ModalWindow.OnInRealArea := DMsgDlgInRealArea;
    ModalWindow.OnDirectPaint := DMsgDlgDirectPaint;
    ModalWindow.OnKeyDown := DModalDlgKeyDown;
    DMsgMaxLen := 0;
    DMsgTop := DMsgDefTop;
    ModalWindow.Floating := True; //允许鼠标移动
    ModalWindow.MsgList.Clear;
    DMsgLeft := 0;
    if (mbAbort in DlgButtons) then begin
      ModalWindow.KeyFocus := False;
      DEdit := TDEdit.Create(Self);
      DEdit.Parent := Self;
      DEdit.DParent := ModalWindow;
      ModalWindow.DControls.Add(Pointer(DEdit));
      DEdit.OnKeyDown := DModalDlgKeyDown;
      DEdit.OnMouseUp := DEditIDMouseUp;
      DEdit.EditClass := EClass;

      DEdit.Left := 36;
      DEdit.Top := 43;
      DEdit.Width := 257;
      DEdit.Height := 16;
      DEdit.MaxLength := MsgLen;
      DEdit.Visible := False;
      DEdit.Visible := True;
      DEdit.Text := defmsg;
      ModalWindow.MsgList.Add(msgstr);
      nWidth := 328;
      nHeight := 116;
      DMsgLeft := 32;
      DMsgTop := 20;
      if mbIgnore in DlgButtons then
        DEdit.PasswordChar := '*'
      else
        DEdit.PasswordChar := #0;
    end
    else if (mbHelp in DlgButtons) then begin
      nWidth := 188;
      nHeight := 105;
      ModalWindow.Floating := False;
      for I := 0 to m_nDiceCount - 1 do begin
        m_Dice[I].n67C := 0;
        m_Dice[I].n680 := Random(m_nDiceCount + 2) * 5;
        m_Dice[I].nPlayPoint := 1;
        m_Dice[I].dwPlayTick := FrmMain.m_CurrentTick;
        m_Dice[I].nX := ((nWidth div 2 + 6) - ((m_nDiceCount * 32 + m_nDiceCount) div 2)) + (I * 32 + I);
        m_Dice[I].nY := nHeight div 2 - 14;
      end;
    end
    else begin
      str := msgstr;
      while True do begin
        if str = '' then
          break;
        str := GetValidStr3(str, data, ['\']);
        if data <> '' then begin
          nLen := Canvas.TextWidth(data);
          if nLen > DMsgMaxLen then
            DMsgMaxLen := nLen;
          ModalWindow.MsgList.Add(data);
        end;
      end;
      nHeight := DMsgDefHeigth + (ModalWindow.MsgList.Count - 1) * 14;
      if DMsgMaxLen > DMsgDefMaxLen then begin
        DMsgLeft := DMsgDefLeft;
        nWidth := DMsgDefWidth + (DMsgMaxLen - DMsgDefMaxLen);
      end
      else begin
        nWidth := DMsgDefWidth;
        DMsgLeft := (DMsgDefWidth - DMsgMaxLen) div 2;
      end;
    end;
    ModalWindow.Left := (g_FScreenWidth - nWidth) div 2;
    if bobottom then
      ModalWindow.Top := (g_FScreenHeight - nHeight) -20
    else
      ModalWindow.Top := (g_FScreenHeight - nHeight) div 2;
    ModalWindow.Width := nWidth;
    ModalWindow.Height := nHeight;
    ModalWindow.CreateSurface(nil);
    {ModalWindow.Surface := TDXTexture.Create(FrmMain.DXDraw.DDraw);
    ModalWindow.Surface.SystemMemory := True;
    ModalWindow.Surface.SetSize(nWidth, nHeight);
    ModalWindow.Surface.Canvas.Font.Name := DEFFONTNAME;
    ModalWindow.Surface.Canvas.Font.Size := DEFFONTSIZE;    }

    DrawZoomDlg(ModalWindow);
    if (mbAbort in DlgButtons) then begin
      d := g_WMain99Images.Images[272];
      if d <> nil then
        ModalWindow.Surface.CopyTexture(32, 41, d);
    end;
    for i := 0 to ModalWindow.MsgList.Count - 1 do
      ModalWindow.Surface.TextOutEx(DMsgLeft, DMsgTop + i * 14, ModalWindow.MsgList[i], $C8FCF8);
    //ModalWindow.MsgLeft := DMsgLeft;
    //ModalWindow.MsgTop := DMsgTop;
    //with ModalWindow.Surface.Canvas do begin
      {SetBkMode(Handle, TRANSPARENT);
      for i := 0 to ModalWindow.MsgList.Count - 1 do
        BoldTextOutEx(ModalWindow.Surface, DMsgLeft, DMsgTop + i * 14, $C8FCF8, $F0, ModalWindow.MsgList[i]);
      Release; }
    //end;

    lx := nWidth div 2 + 7;
    ly := nHeight - 44;
    Inc(lx, 12);
    if mbRetry in DlgButtons then begin
      //      lx := lx - 56;
      if mbYes in DlgButtons then
        ModalWindow.YesResult := mrYes
      else
        ModalWindow.YesResult := mrOk;
      DOKButton := TDButton.Create(Self);
      DOKButton.Parent := Self;
      DOKButton.DParent := ModalWindow;
      ModalWindow.DControls.Add(Pointer(DOKButton));
      DOKButton.Tag := 1;
      DOKButton.Caption := 'OK';
      DOKButton.OnClickSound := dbtnSelServer1ClickSound;
      DOKButton.OnClick := DModalDlgOkClick;
      DOKButton.SetImgIndex(g_WMain99Images, 1650);
      DOKButton.OnDirectPaint := DBTHintCloseDirectPaint;
      DOKButton.DFColor := $ADD6EF;
      DOKButton.Left := DEdit.Left + DEDit.Width - DOKButton.Width;
      DOKButton.Top := ly;
      DOKButton.Visible := True;

      CheckBoxYes := TDCheckBox.Create(Self);
      CheckBoxYes.Parent := Self;
      CheckBoxYes.DParent := ModalWindow;
      CheckBoxYes.OnChange := DModalDlgChange;
      CheckBoxYes.Checked := not DlgChecked;
      ModalWindow.DControls.Add(Pointer(CheckBoxYes));
      CheckBoxYes.OffsetLeft := 4;
      CheckBoxYes.OffsetTop := 1;
      CheckBoxYes.Tag := 0;
      CheckBoxYes.Caption := g_sGoldName;
      CheckBoxYes.SetImgIndex(g_WMain99Images, 151);

      CheckBoxYes.Left := DEdit.Left;
      CheckBoxYes.Top := DEdit.Top + DEdit.Height + 8;
      CheckBoxYes.Visible := True;

      CheckBoxNo := TDCheckBox.Create(Self);
      CheckBoxNo.Parent := Self;
      CheckBoxNo.DParent := ModalWindow;
      CheckBoxNo.OnChange := DModalDlgChange;
      CheckBoxNo.Checked := DlgChecked;
      ModalWindow.DControls.Add(Pointer(CheckBoxNo));
      CheckBoxNo.OffsetLeft := 4;
      CheckBoxNo.OffsetTop := 1;
      CheckBoxNo.Tag := 1;
      CheckBoxNo.Caption := g_sGameGoldName;
      CheckBoxNo.SetImgIndex(g_WMain99Images, 151);

      CheckBoxNo.Left := DEdit.Left;
      CheckBoxNo.Top := CheckBoxYes.Top + CheckBoxYes.Height + 4;
      CheckBoxNo.Visible := True;

      CheckBoxNo.AppendData := CheckBoxYes;
      CheckBoxYes.AppendData := CheckBoxNo;

    end
    else begin
      if (mbCancel in DlgButtons) or (mbNo in DlgButtons) then begin
        if mbCancel in DlgButtons then
          ModalWindow.NoResult := mrCancel
        else
          ModalWindow.NoResult := mrNo;
        DNoButton := TDButton.Create(Self);
        DNoButton.Parent := Self;
        DNOButton.DParent := ModalWindow;
        ModalWindow.DControls.Add(Pointer(DNoButton));
        DNoButton.Tag := 0;
        DNoButton.Caption := 'No';
        DNoButton.OnClickSound := dbtnSelServer1ClickSound;
        DNoButton.OnClick := DModalDlgOkClick;
        DNoButton.SetImgIndex(g_WMain99Images, 1650);
        DNoButton.OnDirectPaint := DBTHintCloseDirectPaint;
        DNoButton.DFColor := $ADD6EF;
        DNoButton.Left := lx;
        DNoButton.Top := ly;
        DNoButton.Visible := True;
        lx := lx - 114 + 56;
      end;
      if (mbYes in DlgButtons) or (mbOk in DlgButtons) or (DlgButtons = []) then begin
        lx := lx - 56;
        if mbYes in DlgButtons then
          ModalWindow.YesResult := mrYes
        else
          ModalWindow.YesResult := mrOk;
        DOKButton := TDButton.Create(Self);
        DOKButton.Parent := Self;
        DOKButton.DParent := ModalWindow;
        ModalWindow.DControls.Add(Pointer(DOKButton));
        DOKButton.Tag := 1;
        DOKButton.Caption := 'OK';
        DOKButton.OnClickSound := dbtnSelServer1ClickSound;
        DOKButton.OnClick := DModalDlgOkClick;
        DOKButton.SetImgIndex(g_WMain99Images, 1650);
        DOKButton.OnDirectPaint := DBTHintCloseDirectPaint;
        DOKButton.DFColor := $ADD6EF;
        DOKButton.Left := lx;
        DOKButton.Top := ly;
        DOKButton.Visible := True;
      end;
    end;
    ReleaseDCapture;
    ModalWindow.ModalShow;
    if DEdit <> nil then
      DEdit.SetFocus
    else
      ModalWindow.SetFocus;
    frmMain.TimerRun.Enabled := False;
    while True do begin
      if not ModalWindow.Visible then
        break;
      if (mbHelp in DlgButtons) then begin
        ShowDice();
      end;
      if nShowDlgCount = nShowCount then
        frmMain.AppOnIdle();
      Application.ProcessMessages;
      if Application.Terminated then
        Exit;
      Sleep(40);
    end;
    if DEdit <> nil then
      DlgEditText := DEdit.Text;
    Result := ModalWindow.DialogResult;
  finally
    ModalWindow.ModalClose;
    if DEdit <> nil then
      g_DControlFreeList.Add(DEdit);
    if DOKButton <> nil then
      g_DControlFreeList.Add(DOKButton);
    if DNoButton <> nil then
      g_DControlFreeList.Add(DNoButton);
    if CheckBoxYes <> nil then
      g_DControlFreeList.Add(CheckBoxYes);
    if CheckBoxNo <> nil then
      g_DControlFreeList.Add(CheckBoxNo);
    g_DControlFreeList.Add(ModalWindow);
  end;
end;

function TFrmDlg.DMessageDlg(msgstr: string; DlgButtons: TMsgDlgButtons; MsgLen: Integer = 70; EClass:
      TDEditClass = deNone; defmsg: string = ''; boBottom: boolean = False): TModalResult;
var
  lx, ly: integer;
  d: TDXTexture;
begin
  if g_ConnectionStep = cnsPlay then begin
    Inc(nShowDlgCount);
    try
      Result := DModalMessageDlg(nShowDlgCount, msgstr, DlgButtons, MsgLen, EClass, defMsg, boBottom);
    finally
      Dec(nShowDlgCount);
      if nShowDlgCount <= 0 then begin
        nShowDlgCount := 0;
        frmMain.TimerRun.Enabled := True;
      end;
    end;
    exit;
  end;
  Result := mrCancel;
  if msgstr = '' then
    exit;
  YesResult := mrOk;
  NoResult := mrCancel;
  lx := 148;
  ly := 78;
  DMsgDlg.KeyFocus := True;

  DMsgDlg.Floating := False;
  d := g_WMain99Images.Images[1620];
  if d <> nil then begin
    DMsgDlg.SetImgIndex(g_WMain99Images, 1620);
    if not boBottom then begin
      DMsgDlg.Top := (g_FScreenHeight - d.Height) div 2;
    end else begin
      DMsgDlg.Top := (g_FScreenHeight - d.Height) - 20 ;
    end;
    DMsgDlg.Left := (g_FScreenWidth - d.Width) div 2;

    DMsgDlgOk.SetImgIndex(g_WMain99Images, 1650);
    DMsgDlgCancel.SetImgIndex(g_WMain99Images, 1650);
    DMsgDlgOk.OnDirectPaint := DBTHintCloseDirectPaint;
    DMsgDlgCancel.OnDirectPaint := DBTHintCloseDirectPaint;
    DMsgDlgOk.DFColor := $ADD6EF;
    DMsgDlgCancel.DFColor := $ADD6EF;

    msglx := 36;
    msgly := 33;
    lx := 156;
    ly := 62;
  end;

  MsgText := msgstr;
  //ViewDlgEdit := FALSE; //编辑框不可见
  DMsgDlgOk.Visible := FALSE;
  DMsgDlgCancel.Visible := FALSE;
  if mbCancel in DlgButtons then begin
    NoResult := mrCancel;
    DMsgDlgCancel.Left := lx;
    DMsgDlgCancel.Top := ly;
    DMsgDlgCancel.Visible := True;
    lx := lx - 114 + 56;
  end
  else if mbNo in DlgButtons then begin
    NoResult := mrNo;
    DMsgDlgCancel.Left := lx;
    DMsgDlgCancel.Top := ly;
    DMsgDlgCancel.Visible := True;
    lx := lx - 114 + 56;
  end;
  if mbYes in DlgButtons then begin
    lx := lx - 56;
    YesResult := mrYes;
    DMsgDlgOk.Left := lx;
    DMsgDlgOk.Top := ly;
    DMsgDlgOk.Visible := True;
  end
  else if (mbOk in DlgButtons) or (DlgButtons = []) then begin
    lx := lx - 56;
    YesResult := mrOk;
    DMsgDlgOk.Left := lx;
    DMsgDlgOk.Top := ly;
    DMsgDlgOk.Visible := True;
  end;
  DMsgDlg.ShowModal;
  if DEditDlgEdit.Visible then
    DEditDlgEdit.SetFocus;

  frmMain.TimerRun.Enabled := False;
  //Result := YesResult;
  //boShowDlg := True;
  while True do begin
    if not DMsgDlg.Visible then
      break;

    frmMain.AppOnIdle();
    Application.ProcessMessages;
    if Application.Terminated then
      Exit;
    //if not boShowDlg then break;
    Sleep(40);
  end;
  frmMain.TimerRun.Enabled := True;
  DlgEditText := DEditDlgEdit.Text;
  DEditDlgEdit.Visible := False;
  Result := DMsgDlg.DialogResult;
  if DEditChat.Visible then
    DEditChat.SetFocus;
  DMsgDlg.Visible := False;
end;

procedure TFrmDlg.DMiniMapDirectPaint(Sender: TObject; dsurface: TDXTexture);
var
  d: TDXTexture;
  mx, my, i, nLen: integer;
  rc, dc: TRect;
  actor: TActor;
  cX, cY: integer;
  btColor: Byte;
  boMove: Boolean;
  ax, ay: integer;
  MapDesc: pTMapDesc;
  str: string;
  nWidth, nHeight: Integer;
begin
  with Sender as TDWindow do begin
    if g_MySelf = nil then
      exit;

    if FrmMain.m_CurrentTick > m_dwBlinkTime + 300 then begin
      m_dwBlinkTime := FrmMain.m_CurrentTick;
      m_boViewBlink := not m_boViewBlink;
    end;
    //g_MapDesc
    if g_nMiniMapIndex > 10000 then
      d := g_WUIBImages.Images[g_nMiniMapIndex - 10000]
    else if g_nMiniMapIndex >= 1000 then begin
      d := g_WMyMMapImages.Images[g_nMiniMapIndex - 1000]
    end
    else
      d := g_WMMapImages.Images[g_nMiniMapIndex];

    if d = nil then begin
      Visible := False;
      g_nViewMinMapLv := 0;
      SetMiniMapSize(g_nViewMinMapLv);
      Exit;
    end;

    if g_nViewMinMapLv = 2 then begin
      cx := -1;
      cy := 0;

      ax := SurfaceX(Left);
      ay := SurfaceY(Top);

      nWidth := _MIN(d.ClientRect.Right, Width)+10;
      nHeight := _MIN(d.ClientRect.Bottom, Height)+10;

      dc.Left := ax + (Width - nWidth) div 2;
      dc.Top := ay + (Height - nHeight) div 2;
      dc.Right := dc.Left + nWidth;
      dc.Bottom := dc.Top + nHeight;
      rc.Left := 0;
      rc.Top := 0;
      rc.Right := d.ClientRect.Right;
      rc.Bottom := d.ClientRect.Bottom;
      if g_boViewMiniMapMark then begin
        DSurface.StretchDraw(dc, rc, d, $80FFFFFF, fxBlend);
      end
      else begin
        g_DXCanvas.FillRect(ax, ay, cx, cy, $FF000000);  //ripman messing minimap g_DXCanvas.FillRect(ax, ay, ax, ay, $FF000000);
        DSurface.StretchDraw(dc, rc, d, False);
      end;

      if (g_nMiniMapMaxX >= dc.Left) and (g_nMiniMapMaxX <= dc.Right) and
        (g_nMiniMapMaxY >= dc.Top) and (g_nMiniMapMaxY <= dc.Bottom) then begin
        cX := (g_nMiniMapMaxX - dc.Left) * 32 * rc.Right div nWidth div 48;
        cy := (g_nMiniMapMaxY - dc.Top) * rc.Bottom div nHeight;
      end;

      if cx > -1 then begin
        g_nMiniMapMaxMosX := cX;
        g_nMiniMapMaxMosY := cY;
      end
      else begin
        g_nMiniMapMaxMosX := g_MySelf.m_nCurrX;
        g_nMiniMapMaxMosY := g_MySelf.m_nCurrY;
      end;

      if (g_nMiniMapOldX = -1)  then begin
        g_nMiniMapOldX := g_MySelf.m_nCurrX;
        g_nMiniMapOldY := g_MySelf.m_nCurrY;
        Surface.Clear;
        with Surface do begin
          if (g_MapDesc <> nil) and g_SetupInfo.boShowMapHint then begin
            for i := 0 to g_MapDesc.MaxList.Count - 1 do begin
              MapDesc := g_MapDesc.MaxList[i];
              if MapDesc.nColor > 0 then begin
                mx := Trunc((MapDesc.nX * 48) * (nWidth / rc.Right)) div 32;
                my := Trunc(MapDesc.nY * (nHeight / rc.Bottom));
                TextOutEx(mx - g_DXCanvas.TextWidth(MapDesc.sName) div 2, my, MapDesc.sName, MapDesc.nColor, $8);
              end;
            end;
          end;
        end;
      end;
      if Surface <> nil then
        DSurface.Draw(ax, ay, Surface.ClientRect, Surface, True);
      if (g_nMiniMapPath <> nil) and (High(g_nMiniMapPath) > 0) then begin
        boMove := False;
        mx := -1;
        my := -1;
        for I := Low(g_nMiniMapPath) to High(g_nMiniMapPath) do begin
          mx := dc.Left + Trunc((g_nMiniMapPath[i].X * 48) * (nWidth / rc.Right)) div 32;
          my := dc.Top + Trunc(g_nMiniMapPath[i].Y * (nHeight / rc.Bottom));
          if boMove then
            g_DXCanvas.LineTo(mx, my, clRed)
          else
            g_DXCanvas.MoveTo(mx, my);
          boMove := True;
        end;
        d := g_WMain99Images.Images[71];
        if d <> nil then
          DSurface.Draw(mx - 2, my + 2 - d.Height, d.ClientRect, d, True);
      end;

      TempList.Clear;
      for I := 0 to PlayScene.m_ActorList.Count - 1 do begin
        actor := TActor(PlayScene.m_ActorList.Items[I]);
        if (actor <> nil) and
          (actor <> g_MySelf) and
          (not actor.m_boDeath) and
          (abs(g_MySelf.m_nCurrX - actor.m_nCurrX) < 20) and
          (abs(g_MySelf.m_nCurrY - actor.m_nCurrY) < 20) then begin
          mx := dc.Left + Trunc((actor.m_nCurrX * 48) * (nWidth / rc.Right)) div 32;
          my := dc.Top + Trunc(actor.m_nCurrY * (nHeight / rc.Bottom));
          if (actor.m_Group <> nil) or (actor.m_btRace = 50) then begin
            TempList.Add(actor);
            Continue;
          end;
          if ((Actor.m_btRace <> RCC_USERHUMAN) and
            (Actor.m_btRaceServer in [RC_GUARD, RC_ARCHERGUARD])) then begin
            btColor := 65 {129};
          end
          else begin
            case actor.m_btRace of //
              0: btColor := 66;
            else
              btColor := 67;
            end;
          end;
          d := g_WMain99Images.Images[btColor];
          if d <> nil then
            dsurface.Draw(mx - d.Width div 2, my - d.Height div 2, d.ClientRect, d, True);
        end;
      end;

      if TempList.Count > 0 then
        for I := 0 to TempList.Count - 1 do begin
          actor := TActor(TempList.Items[I]);
          mx := dc.Left + Trunc((actor.m_nCurrX * 48) * (nWidth / rc.Right)) div 32;
          my := dc.Top + Trunc(actor.m_nCurrY * (nHeight / rc.Bottom));
          case actor.m_btRace of //
            50: btColor := 68;
          else
            btColor := 69;
          end;
          d := g_WMain99Images.Images[btColor];
          if d <> nil then
            dsurface.Draw(mx - d.Width div 2, my - d.Height div 2,
              d.ClientRect, d, True);
        end;

      if not m_boViewBlink then begin
        mx := dc.Left + Trunc((g_MySelf.m_nCurrX * 48) * (nWidth / rc.Right)) div 32;
        my := dc.Top + Trunc(g_MySelf.m_nCurrY * (nHeight / rc.Bottom));
        d := g_WMain99Images.Images[70];
        if d <> nil then
          dsurface.Draw(mx - d.Width div 2, my - d.Height div 2,
            d.ClientRect, d, True);
      end;
      if cx > -1 then begin
        str := IntToStr(cx) + ',' + IntToStr(cy);
        g_DXCanvas.TextOut(ax + 96 - g_DXCanvas.TextWidth(str) div 2, ay + 146, $8CEFF7, str);
        
        mx := dc.Left + Trunc((cX * 48) * (nWidth / rc.Right)) div 32;
        my := dc.Top + Trunc(cY * (nHeight / rc.Bottom)) + 2;

        d := g_WMain99Images.Images[71];
        if d <> nil then
          DSurface.Draw(mx, my - d.Height, d.ClientRect, d, True);
      end;

    end else begin
      cx := -1;
      cy := 0;

      ax := SurfaceX(Left);
      ay := SurfaceY(Top);

      mx := (g_MySelf.m_nCurrX * 48) div 32;
      my := (g_MySelf.m_nCurrY * 32) div 32;
      rc.Left := _MAX(0, mx - 64);
      rc.Top := _MAX(0, my - 64);
      if d = nil then begin
        rc.Right := rc.Left + Width;
        rc.Bottom := rc.Top + Height;
      end
      else begin
        rc.Right := _MIN(d.ClientRect.Right, rc.Left + Width);
        rc.Bottom := _MIN(d.ClientRect.Bottom, rc.Top + Height);

      end;

      if g_nMiniMapX >= 0 then begin
        cX := (g_nMiniMapX + rc.Left - ax) * 32 div 48;
        cy := (g_nMiniMapY + rc.Top - ay) * 32 div 32;
      end;

      if cx > -1 then begin
        g_nMiniMapMosX := cX;
        g_nMiniMapMosY := cY;
      end
      else begin
        g_nMiniMapMosX := g_MySelf.m_nCurrX;
        g_nMiniMapMosY := g_MySelf.m_nCurrY;
      end;
      if g_boViewMiniMapMark then DSurface.Draw(ax, ay, rc, d, $80FFFFFF, fxBlend)
      else begin
        //g_DXCanvas.FillRect(ax, ay, cx, cy, $FF000000);  //removed by ripman
        DSurface.Draw(ax, ay, rc, d, FALSE);
      end;


      if (g_nMiniMapOldX <> g_MySelf.m_nCurrX) or (g_nMiniMapOldY <> g_MySelf.m_nCurrY) then begin
        g_nMiniMapOldX := g_MySelf.m_nCurrX;
        g_nMiniMapOldY := g_MySelf.m_nCurrY;
        Surface.Clear;
        //if d <> nil then
          //Surface.Draw(0, 0, rc, d, FALSE);
        with Surface do begin
          if (g_MapDesc <> nil) and g_SetupInfo.boShowMapHint then begin
            //SetBkMode(Handle, TRANSPARENT);
            for i := 0 to g_MapDesc.MinList.Count - 1 do begin
              MapDesc := g_MapDesc.MinList[i];
              if MapDesc.nColor > 0 then begin
                mx := (MapDesc.nX * 48) div 32 - rc.Left + 2;
                my := (MapDesc.nY * 32) div 32 - rc.Top - 2;
                nLen := g_DXCanvas.TextWidth(MapDesc.sName) div 2;
                mx := mx - nLen;
                if ((mx + nLen * 2) > 0) and ((my + 14) > 0) and (mx < Width) and (my < Height) then
                  TextOutEx(mx, my, MapDesc.sName, MapDesc.nColor, $8);
              end;
            end;
            //Release;
          end;
          if (g_nMiniMapPath <> nil) and (High(g_nMiniMapPath) > 0) then begin
            mx := (g_nMiniMapPath[High(g_nMiniMapPath)].X * 48) div 32 - rc.Left + 2;
            my := (g_nMiniMapPath[High(g_nMiniMapPath)].Y * 32) div 32 - rc.Top - 2;

            d := g_WMain99Images.Images[71];
            if d <> nil then
              Surface.CopyTexture(mx - 2, my + 2 - d.Height, d);
          end;
        end;
      end;
      if Surface <> nil then
        DSurface.Draw(ax, ay, Surface.ClientRect, Surface, True);
      if (g_nMiniMapPath <> nil) and (High(g_nMiniMapPath) > 0) then begin
        //SetBkMode(Handle, TRANSPARENT);
        //Pen.Color := clRed;
        boMove := False;
        for I := Low(g_nMiniMapPath) to High(g_nMiniMapPath) do begin
          mx := (g_nMiniMapPath[i].X * 48) div 32 - rc.Left + 2;
          my := (g_nMiniMapPath[i].Y * 32) div 32 - rc.Top - 2;
          if (mx < 0) or (my < 0) or (mx > Surface.Width) or (my > Surface.Height) then
            Continue;
          if boMove then
            g_DXCanvas.LineTo(ax + mx, ay + my, clRed)
          else
            g_DXCanvas.MoveTo(ax + mx, ay + my);
          boMove := True;
        end;
        //Release;
        //d := g_WMain99Images.Images[71];
        //if d <> nil then
          //Surface.CopyTexture(mx - 2, my + 2 - d.Height, d);
          //Surface.Draw(mx - 2, my + 2 - d.Height, d.ClientRect, d, True);
      end;
      TempList.Clear;
      for I := 0 to PlayScene.m_ActorList.Count - 1 do begin
        actor := TActor(PlayScene.m_ActorList.Items[I]);
        if (actor <> nil) and
          (actor <> g_MySelf) and
          (not actor.m_boDeath) and
          (abs(g_MySelf.m_nCurrX - actor.m_nCurrX) < 20) and
          (abs(g_MySelf.m_nCurrY - actor.m_nCurrY) < 20) then begin
          mx := ax + (actor.m_nCurrX * 48) div 32 - rc.Left + 2;
          my := ay + (actor.m_nCurrY * 32) div 32 - rc.Top - 2;
          if (actor.m_Group <> nil) or (actor.m_btRace = 50) then begin
            TempList.Add(actor);
            Continue;
          end;
          if ((Actor.m_btRace <> RCC_USERHUMAN) and (Actor.m_btRaceServer in [RC_GUARD, RC_ARCHERGUARD])) then begin
            btColor := 65 {129};
          end
          else begin
            case actor.m_btRace of //
              0: btColor := 66;
            else
              btColor := 67;
            end;
          end;
          d := g_WMain99Images.Images[btColor];
          if d <> nil then
            dsurface.Draw(mx - d.Width div 2, my - d.Height div 2, d.ClientRect, d, True);
        end;
      end;

      if TempList.Count > 0 then
        for I := 0 to TempList.Count - 1 do begin
          actor := TActor(TempList.Items[I]);
          mx := ax + (actor.m_nCurrX * 48) div 32 - rc.Left + 2;
          my := ay + (actor.m_nCurrY * 32) div 32 - rc.Top - 2;
          case actor.m_btRace of //
            50: btColor := 68;
          else
            btColor := 69;
          end;
          d := g_WMain99Images.Images[btColor];
          if d <> nil then
            dsurface.Draw(mx - d.Width div 2, my - d.Height div 2, d.ClientRect, d, True);
        end;

      if not m_boViewBlink then begin
        mx := ax + (g_MySelf.m_nCurrX * 48) div 32 - rc.Left + 2;
        my := ay + (g_MySelf.m_nCurrY * 32) div 32 - rc.Top - 2;
        //dsurface.Pixels[mx + 2, my - 2] := clRed;
        d := g_WMain99Images.Images[70];
        if d <> nil then
          dsurface.Draw(mx - d.Width div 2, my - d.Height div 2, d.ClientRect, d, True);
      end;

      if cx > -1 then begin
        str := IntToStr(cx) + ',' + IntToStr(cy);
        g_DXCanvas.TextOut(ax + 64 - g_DXCanvas.TextWidth(str) div 2, ay + 114, $8CEFF7, str);
        mx := ax + (cX * 48) div 32 - rc.Left;
        my := ay + (cY * 32) div 32 - rc.Top;
        d := g_WMain99Images.Images[71];
        if d <> nil then
          DSurface.Draw(mx, my - d.Height, d.ClientRect, d, True);
      end;
    end;
  end;
end;

procedure TFrmDlg.DMiniMapDlgDirectPaint(Sender: TObject;
  dsurface: TDXTexture);
var
  d, dd: TDXTexture;
  rc: TRect;
  ax, ay: integer;
  str: string;
begin
  with Sender as TDWindow do begin
    d := WLib.Images[FaceIndex];
    if d <> nil then begin
      boMaxMinimapShow := True;
      g_boMiniMapShow := not g_boMiniMapClose;
      //if not g_boMiniMapClose then begin
      if g_nMiniMapIndex < 0 then begin
        boMaxMinimapShow := False;
      end
      else begin
        if g_nMiniMapIndex > 10000 then
          dd := g_WUIBImages.Images[g_nMiniMapIndex - 10000]
        else if g_nMiniMapIndex >= 1000 then
          dd := g_WMyMMapImages.Images[g_nMiniMapIndex - 1000]
        else
          dd := g_WMMapImages.Images[g_nMiniMapIndex];
        //dd := g_WMMapImages.Images[g_nMiniMapIndex];
        if dd = nil then
          boMaxMinimapShow := False;
      end;
      //end;

      ax := 58;
      if g_boMiniMapShow then begin
        dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, True);
        ay := 134;
        DMinMap128.Visible := True;
      end
      else begin
        rc := d.ClientRect;
        rc.Top := 133;
        dsurface.Draw(SurfaceX(Left), SurfaceY(Top), rc, d, True);
        ay := 1;
        DMinMap128.Visible := False;
      end;
      with g_DXCanvas do begin
        //SetBkMode(Handle, TRANSPARENT);
        //Font.Color := clWhite;
        str := IntToStr(g_MySelf.m_nCurrX);
        TextOut(SurfaceX(Left) + ax - TextWidth(str) div 2, SurfaceY(Top) + ay, str, clWhite);
        str := IntToStr(g_MySelf.m_nCurrY);
        TextOut(SurfaceX(Left) + ax + 54 - TextWidth(str) div 2, SurfaceY(Top) + ay, str, clWhite);
        //Release;
      end;
    end;
  end;
end;

procedure TFrmDlg.DMiniMapDlgInRealArea(Sender: TObject; X, Y: Integer;
  var IsRealArea: Boolean);
var
  d: TDXTexture;
begin
  with Sender as TDWindow do begin
    if WLib <> nil then begin
      d := WLib.Images[FaceIndex];
      if d <> nil then begin
        if g_boMiniMapShow then begin
          if d.Pixels[x, y] <= 0 then
            IsRealArea := FALSE;
        end
        else begin
          if d.Pixels[x, y + 133] <= 0 then
            IsRealArea := FALSE;
        end;
      end;
    end;
  end;
end;

procedure TFrmDlg.DMiniMapMaxClick(Sender: TObject; X, Y: Integer);
begin
  if boMaxMinimapShow then
    DMaxMiniMap.Visible := not DMaxMiniMap.Visible
  else
    DScreen.AddSysMsg('No available map.', $32F4);
end;

procedure TFrmDlg.DMiniMapMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  nX, nY: Integer;
begin
  if (Button = mbRight) or (Button = mbMiddle) then begin
    if g_nViewMinMapLv = 2 then begin
      nX := g_nMiniMapMaxMosX;
      nY := g_nMiniMapMaxMosY; 
    end else begin
      nX := g_nMiniMapMosX;
      nY := g_nMiniMapMosY; 
    end;
    if Button = mbMiddle then begin
      g_boAutoMoveing := False;
      FrmMain.SendSay(g_Cmd_UserMove + ' ' + IntToStr(nX) + ' ' + IntToStr(nY) + ' TOPHINT');
    end else begin
      g_nMiniMapOldX := -1;
      g_nMiniMapPath := FindPath(nX, nY);
      if High(g_nMiniMapPath) > 2 then begin
        g_boAutoMoveing := False;
        g_nMiniMapMoseX := nX;
        g_nMiniMapMoseY := nY;
        DScreen.AddSysMsg('Auto Moving to Destination' + '<CO$FFFFFF>[' + IntToStr(nX)
          + ',' + IntToStr(nY) + ']<CE>', clLime);
        g_boAutoMoveing := True;
        g_boNpcMoveing := False;
      end
      else begin
        g_nMiniMapMoseX := -1;
        g_nMiniMapMoseY := -1;
        DScreen.AddSysMsg('Unabled to reach Destination' + '<CO$FFFFFF>[' + IntToStr(nX)
          + ',' + IntToStr(nY) + ']<CE>', clRed);
      end;
    end;
  end else
    g_boViewMiniMapMark := not g_boViewMiniMapMark;
end;

procedure TFrmDlg.DMiniMapMouseEntry(Sender: TObject; MouseEntry: TMouseEntry);
begin
  if MouseEntry = msOut then begin
    g_nMiniMapX := -1;
    g_nMiniMapMaxX := -1;
  end;
end;

procedure TFrmDlg.DMiniMapMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
var
  ShowStr: string;
begin
  if g_nViewMinMapLv = 2 then begin
    g_nMiniMapMaxX := DMiniMap.SurfaceX(x);
    g_nMiniMapMaxY := DMiniMap.SurfaceY(Y);
  end else begin
    g_nMiniMapX := DMiniMap.SurfaceX(x);
    g_nMiniMapY := DMiniMap.SurfaceY(y);
  end;
  ShowStr := 'Right-Click to automatically find path.\';
  ShowStr := ShowStr + '<Left click to change Mini Map Transparency./FCOLOR=$FFFF>';
  DScreen.ShowHint(DMiniMap.SurfaceX(DMiniMap.Left), DMiniMap.SurfaceY(DMiniMap.Top) + DMiniMap.Height + 35, ShowStr, clWhite, False, x);
end;

procedure TFrmDlg.DMinMap128DirectPaint(Sender: TObject;
  dsurface: TDXTexture);
var
  d: TDXTexture;
  mx, my, i, nLen: integer;
  rc: TRect;
  actor: TActor;
  cX, cY: integer;
  btColor: Byte;
  boMove: Boolean;
  ax, ay: integer;
  MapDesc: pTMapDesc;
  str: string;
begin
  with Sender as TDWindow do begin
    if g_MySelf = nil then
      exit;

    if FrmMain.m_CurrentTick > m_dwBlinkTime + 300 then begin
      m_dwBlinkTime := FrmMain.m_CurrentTick;
      m_boViewBlink := not m_boViewBlink;
    end;
    //g_MapDesc
    if g_nMiniMapIndex > 10000 then
      d := g_WUIBImages.Images[g_nMiniMapIndex - 10000]
    else if g_nMiniMapIndex >= 1000 then
      d := g_WMyMMapImages.Images[g_nMiniMapIndex - 1000]
    else
      d := g_WMMapImages.Images[g_nMiniMapIndex];
    {if d = nil then begin
      //Visible := False;
      exit;
    end; }
    cx := -1;
    cy := 0;

    ax := SurfaceX(Left);
    ay := SurfaceY(Top);

    mx := (g_MySelf.m_nCurrX * 48) div 32;
    my := (g_MySelf.m_nCurrY * 32) div 32;
    rc.Left := _MAX(0, mx - 64);
    rc.Top := _MAX(0, my - 64);
    if d = nil then begin
      rc.Right := rc.Left + Width;
      rc.Bottom := rc.Top + Height;
    end
    else begin
      rc.Right := _MIN(d.ClientRect.Right, rc.Left + Width);
      rc.Bottom := _MIN(d.ClientRect.Bottom, rc.Top + Height);

    end;

    if g_nMiniMapX >= 0 then begin
      cX := (g_nMiniMapX + rc.Left - ax) * 32 div 48;
      cy := (g_nMiniMapY + rc.Top - ay) * 32 div 32;
    end;

    if cx > -1 then begin
      g_nMiniMapMosX := cX;
      g_nMiniMapMosY := cY;
    end
    else begin
      g_nMiniMapMosX := g_MySelf.m_nCurrX;
      g_nMiniMapMosY := g_MySelf.m_nCurrY;
    end;
    if d <> nil then
      DSurface.Draw(ax, ay, rc, d, FALSE);
    if (g_nMiniMapOldX <> g_MySelf.m_nCurrX) or (g_nMiniMapOldY <> g_MySelf.m_nCurrY) then begin
      g_nMiniMapOldX := g_MySelf.m_nCurrX;
      g_nMiniMapOldY := g_MySelf.m_nCurrY;
      Surface.Clear;
      //if d <> nil then
        //Surface.Draw(0, 0, rc, d, FALSE);
      with Surface do begin
        if (g_MapDesc <> nil) and g_SetupInfo.boShowMapHint then begin
          //SetBkMode(Handle, TRANSPARENT);
          for i := 0 to g_MapDesc.MinList.Count - 1 do begin
            MapDesc := g_MapDesc.MinList[i];
            if MapDesc.nColor > 0 then begin
              mx := (MapDesc.nX * 48) div 32 - rc.Left + 2;
              my := (MapDesc.nY * 32) div 32 - rc.Top - 2;
              nLen := g_DXCanvas.TextWidth(MapDesc.sName) div 2;
              mx := mx - nLen;
              if ((mx + nLen * 2) > 0) and ((my + 14) > 0) and (mx < Width) and (my < Height) then
                TextOutEx(mx, my, MapDesc.sName, MapDesc.nColor, $8);
            end;
          end;
          //Release;
        end;
        if (g_nMiniMapPath <> nil) and (High(g_nMiniMapPath) > 0) then begin
          mx := (g_nMiniMapPath[High(g_nMiniMapPath)].X * 48) div 32 - rc.Left + 2;
          my := (g_nMiniMapPath[High(g_nMiniMapPath)].Y * 32) div 32 - rc.Top - 2;

          d := g_WMain99Images.Images[71];
          if d <> nil then
            Surface.CopyTexture(mx - 2, my + 2 - d.Height, d);
        end;
      end;
    end;
    if Surface <> nil then
      DSurface.Draw(ax, ay, Surface.ClientRect, Surface, True);
    if (g_nMiniMapPath <> nil) and (High(g_nMiniMapPath) > 0) then begin
      //SetBkMode(Handle, TRANSPARENT);
      //Pen.Color := clRed;
      boMove := False;
      for I := Low(g_nMiniMapPath) to High(g_nMiniMapPath) do begin
        mx := (g_nMiniMapPath[i].X * 48) div 32 - rc.Left + 2;
        my := (g_nMiniMapPath[i].Y * 32) div 32 - rc.Top - 2;
        if (mx < 0) or (my < 0) or (mx > Surface.Width) or (my > Surface.Height) then
          Continue;
        if boMove then
          g_DXCanvas.LineTo(ax + mx, ay + my, clRed)
        else
          g_DXCanvas.MoveTo(ax + mx, ay + my);
        boMove := True;
      end;
      //Release;
      //d := g_WMain99Images.Images[71];
      //if d <> nil then
        //Surface.CopyTexture(mx - 2, my + 2 - d.Height, d);
        //Surface.Draw(mx - 2, my + 2 - d.Height, d.ClientRect, d, True);
    end;
    TempList.Clear;
    for I := 0 to PlayScene.m_ActorList.Count - 1 do begin
      actor := TActor(PlayScene.m_ActorList.Items[I]);
      if (actor <> nil) and
        (actor <> g_MySelf) and
        (not actor.m_boDeath) and
        (abs(g_MySelf.m_nCurrX - actor.m_nCurrX) < 20) and
        (abs(g_MySelf.m_nCurrY - actor.m_nCurrY) < 20) then begin
        mx := ax + (actor.m_nCurrX * 48) div 32 - rc.Left + 2;
        my := ay + (actor.m_nCurrY * 32) div 32 - rc.Top - 2;
        if (actor.m_Group <> nil) or (actor.m_btRace = 50) then begin
          TempList.Add(actor);
          Continue;
        end;
        if ((Actor.m_btRace <> RCC_USERHUMAN) and
          (Actor.m_btRaceServer in [RC_GUARD, RC_ARCHERGUARD])) then begin
          btColor := 65 {129};
        end
        else begin
          case actor.m_btRace of //
            0: btColor := 66;
          else
            btColor := 67;
          end;
        end;
        d := g_WMain99Images.Images[btColor];
        if d <> nil then
          dsurface.Draw(mx - d.Width div 2, my - d.Height div 2, d.ClientRect, d, True);
      end;
    end;

    if TempList.Count > 0 then
      for I := 0 to TempList.Count - 1 do begin
        actor := TActor(TempList.Items[I]);
        mx := ax + (actor.m_nCurrX * 48) div 32 - rc.Left + 2;
        my := ay + (actor.m_nCurrY * 32) div 32 - rc.Top - 2;
        case actor.m_btRace of //
          50: btColor := 68;
        else
          btColor := 69;
        end;
        d := g_WMain99Images.Images[btColor];
        if d <> nil then
          dsurface.Draw(mx - d.Width div 2, my - d.Height div 2,
            d.ClientRect, d, True);
      end;

    if not m_boViewBlink then begin
      mx := ax + (g_MySelf.m_nCurrX * 48) div 32 - rc.Left + 2;
      my := ay + (g_MySelf.m_nCurrY * 32) div 32 - rc.Top - 2;
      //dsurface.Pixels[mx + 2, my - 2] := clRed;
      d := g_WMain99Images.Images[70];
      if d <> nil then
        dsurface.Draw(mx - d.Width div 2, my - d.Height div 2,
          d.ClientRect, d, True);
    end;

    if cx > -1 then begin
      str := IntToStr(cx) + ',' + IntToStr(cy);
      //SetBkMode(DSurface.Canvas.Handle, TRANSPARENT);
      g_DXCanvas.TextOut(ax + 64 - g_DXCanvas.TextWidth(str) div 2, ay + 114, $8CEFF7, str);
      //DSurface.Canvas.Release;
      mx := ax + (cX * 48) div 32 - rc.Left;
      my := ay + (cY * 32) div 32 - rc.Top;
      d := g_WMain99Images.Images[71];
      if d <> nil then
        DSurface.Draw(mx, my - d.Height, d.ClientRect, d, True);
    end;
  end;
end;

procedure TFrmDlg.DMinMap128MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if Button = mbRight then begin
    g_boAutoMoveing := False;
    FrmMain.SendSay(g_Cmd_UserMove + ' ' + IntToStr(g_nMiniMapMosX) + ' ' + IntToStr(g_nMiniMapMosY) + ' TOPHINT');
  end else begin
    g_nMiniMapOldX := -1;
    g_nMiniMapPath := FindPath(g_nMiniMapMosX, g_nMiniMapMosY);
    if High(g_nMiniMapPath) > 2 then begin
      g_boAutoMoveing := False;
      g_nMiniMapMoseX := g_nMiniMapMosX;
      g_nMiniMapMoseY := g_nMiniMapMosY;
      DScreen.AddSysMsg('[Click the screen to stop moving.]', clWhite);
      {DScreen.AddChatBoardString(Format('自动移动(%d,%d)，点击屏幕停止移动！',
        [g_nMiniMapMosX, g_nMiniMapMosY]), GetRGB(180), clWhite);   }
      g_boAutoMoveing := True;
      g_boNpcMoveing := False;
    end
    else begin
      g_nMiniMapMoseX := -1;
      g_nMiniMapMoseY := -1;
      DScreen.AddSysMsg('[Unable to reach the destination.]', clWhite);
      //DScreen.AddChatBoardString('自动移动失败，无法到达终点！', GetRGB(56), clWhite);
    end;
  end;
end;

procedure TFrmDlg.DMinMap128MouseEntry(Sender: TObject;
  MouseEntry: TMouseEntry);
begin
  if MouseEntry = msOut then
    g_nMiniMapX := -1;
end;

procedure TFrmDlg.DMinMap128MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
var
  ShowStr: string;
begin
  g_nMiniMapX := DMinMap128.SurfaceX(x);
  g_nMiniMapY := DMinMap128.SurfaceY(DMinMap128.Top) + Y;
  y := y + 30;
  ShowStr := 'Left-Click to automatically find path';
  //ShowStr := ShowStr + '右键单击自动传送\(<自动传送需要配戴传送装备/FCOLOR=$FFFF>)';
  DScreen.ShowHint(DMinMap128.SurfaceX(x), DMinMap128.SurfaceY(DMinMap128.Top) + Y, ShowStr, clWhite, False, x);
end;

procedure TFrmDlg.DMsgDlgDirectPaint(Sender: TObject;
  dsurface: TDXTexture);
var
  d: TDXTexture;
  ax, ay, ly, I, nX, nY: integer;
  str, str1, str2, str3: string;
  MaxLen, MaxLen2: integer;
begin
  with Sender as TDWindow do begin
    ax := SurfaceX(Left);
    ay := SurfaceY(Top);
    if g_ConnectionStep = cnsPlay then begin
      if Sender is TDModalWindow then begin
        with TDModalWindow(Sender) do begin
          g_DXCanvas.FillRect(ax + 2, ay + 2, Width - 4, Height - 4, $FF101018);
          for I := 0 to 3 do begin
            if DlgInfo[I].WMImages = nil then Continue;
            d := DlgInfo[I].WMImages.Images[DlgInfo[I].Index];
            if d <> nil then begin
              g_DXCanvas.StretchDraw(Rect(DlgInfo[I].Rect.Left + ax, DlgInfo[I].Rect.Top + ay,
                DlgInfo[I].Rect.Right + ax, DlgInfo[I].Rect.Bottom + ay),
                d.ClientRect, d, True);
            end;
          end;
          for I := 4 to 7 do begin
            if DlgInfo[I].WMImages = nil then Continue;
            d := DlgInfo[I].WMImages.Images[DlgInfo[I].Index];
            if d <> nil then begin
              if I = 5 then
                g_DXCanvas.Draw(d, DlgInfo[I].Rect.Left + ax, DlgInfo[I].Rect.Top + ay, fxBlend, $FFFFFFFF, False, True)
              else
                g_DXCanvas.Draw(DlgInfo[I].Rect.Left + ax, DlgInfo[I].Rect.Top + ay, d.ClientRect, d, True);
            end;
          end;
          if Surface <> nil then
            g_DXCanvas.Draw(ax, ay, Surface.ClientRect, Surface, True);
          //if Surface <> nil then
            //DrawWindow(dsurface, ax, ay, Surface);
        end;
        if m_nDiceCount > 0 then begin
          for I := 0 to m_nDiceCount - 1 do begin
            d := GetBagItemImg(m_Dice[I].nPlayPoint + 376 - 1, nX, nY);
            if d <> nil then begin
              dsurface.Draw(SurfaceX(Left) + m_Dice[I].nX + nX - 14, SurfaceY(Top) + m_Dice[I].nY + nY + 38, d.ClientRect, d, TRUE);
            end;
          end;
        end;
      end;
    end
    else begin
      d := WLib.Images[FaceIndex];
      if d <> nil then
        DrawWindow(dsurface, ax, ay, d);

      ly := msgly;
      str := MsgText;
      str := GetValidStr3(str, str1, ['\']);
      str := GetValidStr3(str, str2, ['\']);
      str := GetValidStr3(str, str3, ['\']);
      if str3 <> '' then
        ly := ly - 14
      else if str2 <> '' then
        ly := ly - 7;
      with g_DXCanvas do begin
        //SetBkMode(Handle, TRANSPARENT);
        MaxLen := TextWidth(str1);
        MaxLen2 := TextWidth(str2);
        if MaxLen < MaxLen2 then
          MaxLen := MaxLen2;
        MaxLen2 := TextWidth(str3);
        if MaxLen < MaxLen2 then
          MaxLen := MaxLen2;
        MaxLen := MaxLen div 2;
        if Str1 <> '' then
          TextOut(ax + (136 - MaxLen), ay + ly, clWhite, str1);
        Inc(ly, 14);
        if Str2 <> '' then
          TextOut(ax + (136 - MaxLen), ay + ly, clWhite, str2);
        Inc(ly, 14);
        if Str3 <> '' then
          TextOut(ax + (136 - MaxLen), ay + ly, clWhite, str3);
        //Release;
      end;
    end;
  end;
end;

procedure TFrmDlg.DMsgDlgInRealArea(Sender: TObject; X, Y: Integer; var IsRealArea: Boolean);
begin
  IsRealArea := True;
end;

procedure TFrmDlg.DMsgDlgKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if m_nDiceCount = 0 then begin
    if Key = 13 then begin
      DMsgDlg.DialogResult := YesResult;
      DMsgDlg.Visible := FALSE;
    end;
    if Key = 27 then begin
      DMsgDlg.DialogResult := NoResult;
      DMsgDlg.Visible := FALSE;
    end;
  end;
end;

procedure TFrmDlg.DMsgDlgOkClick(Sender: TObject; X, Y: Integer);
begin
  if Sender = DMsgDlgOk then
    DMsgDlg.DialogResult := YesResult;
  if Sender = DMsgDlgCancel then
    DMsgDlg.DialogResult := NoResult;
  DMsgDlg.Visible := FALSE;
end;

procedure TFrmDlg.DMyStateClick(Sender: TObject; X, Y: Integer);
var
  Reg: TRegistry;
  ini: TIniFile;
begin

  if Sender = DOption then begin
    FrmDlg3.DGameSetup.Visible := not FrmDlg3.DGameSetup.Visible;
  end;

  if Sender = DBotAddAbil then begin
    StatePage := 1;
    DStateWin.Visible := True;
    PageChanged;
  end;

  if Sender = DBotMusic then begin
    if g_boBGSound or g_boSound then begin
      g_boSound := False;
      g_boBGSound := False;
      SilenceSound;
      ClearBGM;
      DScreen.AddSysMsg('[Game Sound Off]', clWhite);
        if g_nInterface = 2 then
              DBotMusic.SetImgIndex(g_WUI3Images, 2982);
      end else begin
      g_boSound := True;
      g_boBGSound := True;
      if g_boCanSound then begin
        if MusicHS >= BASS_ERROR_ENDED then begin
          if BASS_ChannelIsActive(MusicHS) <> BASS_ACTIVE_PLAYING then begin
            PlayMapMusic(True);
          end else
            BASS_ChannelSetAttribute(MusicHS, BASS_ATTRIB_VOL, g_btMP3Volume / 100);
        end else
          PlayMapMusic(True);
      end;
      DScreen.AddSysMsg('[Game Sound On]', clWhite);
        if g_nInterface = 2 then
            DBotMusic.SetImgIndex(g_WUI3Images, 2986);
    end;
  {  Reg := TRegistry.Create;
    Try
      Reg.RootKey := HKEY_LOCAL_MACHINE;
      if Reg.OpenKey(REG_SETUP_PATH, True) then begin
        Reg.WriteBool(REG_SETUP_MP3OPEN, g_boBGSound);
        Reg.WriteBool(REG_SETUP_SOUNDOPEN, g_boSound);
      end;
      Reg.CloseKey;
    Finally
      Reg.Free;
    End;    }       //ripman

  ini := TIniFile.Create('.\mir2.ini');
  if ini <> nil then begin
    ini.WriteBool('Options', 'BGSound', g_boBGSound);
    ini.WriteBool('Options', 'Sound', g_boSound);
    ini.Free;
  end;
end;

  //FrmDlg3.DGameSetup.Visible := not FrmDlg3.DGameSetup.Visible;
  if Sender = DMyBag then
    OpenItemBag;
  if Sender = DMyState then begin
    StatePage := 0;
    OpenMyStatus;
  end
  else if Sender = DMyMagic then begin
    StatePage := 2;
    OpenMyStatus;
  end
  else if Sender = DBotFriend then
    FrmDlg2.DWinFriend.Visible := not FrmDlg2.DWinFriend.Visible;
  if Sender = DBotGroup then
    DGroupDlg.Visible := not DGroupDlg.Visible;
  if Sender = DBotTrade then begin
    g_CursorMode := cr_Deal;
    FrmMain.Cursor := crMyDeal;
    {if FrmMain.m_CurrentTick > g_dwQueryMsgTick then begin
      g_dwQueryMsgTick := FrmMain.m_CurrentTick + 3000;
      frmMain.SendDealTry;
    end;   }
  end;

end;

procedure TFrmDlg.DMyStateDirectPaint(Sender: TObject;
  dsurface: TDXTexture);
var
  d: TDXTexture;
  idx: integer;
begin
  with Sender as TDButton do begin
    if WLib <> nil then begin
      if Downed then begin
        d := WLib.Images[FaceIndex];
        if d <> nil then
          dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, True);
      end;
    end;
  end;
end;

procedure TFrmDlg.DMyStateMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var
  ShowMsg: string;
begin
  with Sender as TDControl do begin
  if g_nInterface = 1 then begin
    X := SurfaceX(Left);
    y := SurfaceY(Top) - 2;
    ShowMsg := '';
    if Sender = DMyState then begin
      ShowMsg := 'Character<(' + GetHookKeyStr(@g_CustomKey[DK_OPENMYSTATUS0]) + ',' + GetHookKeyStr(@g_CustomKey[DK_OPENMYSTATUS02]) + ')/FCOLOR=$FFFF>';
      X := x - 60;
      Y := Y - 8;
    end
    else if Sender = DMyBag then begin
      ShowMsg := 'Inventory<(' + GetHookKeyStr(@g_CustomKey[DK_OPENITEMBAG]) + ','+ GetHookKeyStr(@g_CustomKey[DK_OPENITEMBAG2]) +')/FCOLOR=$FFFF>';
      X := x - 53;
      Y := Y - 8;
    end
    else if Sender = DMyMagic then begin
      ShowMsg := 'Magic<(' + GetHookKeyStr(@g_CustomKey[DK_OPENMYSTATUS3]) + ',S)/FCOLOR=$FFFF>';
      X := x - 52;
      Y := Y - 8;
    end
    else if Sender = DBotTrade then begin
      ShowMsg := 'Trade<(T)/FCOLOR=$FFFF>';
      X := x - 30;
    end
    else if Sender = DBotGuild then begin
      ShowMsg := 'Guild<(G)/FCOLOR=$FFFF>';
      X := x - 30;
    end
    else if Sender = DBotGroup then begin
      ShowMsg := 'Group<(P)/FCOLOR=$FFFF>';
      X := x - 30;
    end
    else if Sender = DBotFriend then begin
      ShowMsg := 'Friend<(W)/FCOLOR=$FFFF>';
      X := x - 30;
    end
    else if Sender = DBotSort then begin
      ShowMsg := 'Quest<(Q)/FCOLOR=$FFFF>';
      X := x - 30;
    end
    else if Sender = DOption then begin
      ShowMsg := 'Options<(F12)/FCOLOR=$FFFF>';
      X := x - 36;
    end
    else if Sender = DButtonTop then begin
      ShowMsg := 'Ranking';
      X := x - 11;
    end
    else if Sender = FrmDlg2.dbtnSelectChr then begin
      ShowMsg := 'Log Out<(ALT + X)/FCOLOR=$FFFF>';
      X := x - 46;
    end
    else if Sender = FrmDlg2.dbtnExitGame then begin
      ShowMsg := 'Exit Game<(ALT + Q)/FCOLOR=$FFFF>';
      X := x - 46;
    end
    else if Sender = DTopShop then begin
      ShowMsg := 'GameShop';
    end
    else if Sender = DOpenCompoundItem then begin
      ShowMsg := 'Compound Window';
    end
    else if Sender = DTopHelp then begin
      ShowMsg := 'Help<(H)/FCOLOR=$FFFF>';
      X := x - 25;
    end
    else if Sender = DTopEMail then begin
      ShowMsg := 'Mail<(E)/FCOLOR=$FFFF>';
      X := x - 25;
    end
    else if Sender = DBTTakeHorse then begin
      if g_MySelf.m_btHorse = 0 then
        ShowMsg := 'Ride Horse<(' + GetHookKeyStr(@g_CustomKey[DK_ONHORSE]) + ')/FCOLOR=$FFFF>'
      else
        ShowMsg := 'Dismount Horse<(' + GetHookKeyStr(@g_CustomKey[DK_ONHORSE]) + ')/FCOLOR=$FFFF>';
      X := x - 44;
    end
    else if Sender = DBotAddAbil then begin
      ShowMsg := 'Abilities';
      X := x - 8;
    end
    else if Sender = DBotMusic then begin
      ShowMsg := 'Sound';
      X := x - 20;
      Y := Y - 8;
    end
    else if Sender = DBotMiniMap then begin
      ShowMsg := 'Minimap<(V)/FCOLOR=$FFFF>';
      X := x - 8;
    end
    else if Sender = DBTFace then begin
      ShowMsg := 'Emoticon';
      X := x - 17;
    end;
  end
  else if g_nInterface = 2 then begin
    X := SurfaceX(Left);
    y := SurfaceY(Top) - 2;
    ShowMsg := '';
    if Sender = DMyState then begin
      ShowMsg := 'Character<(' + GetHookKeyStr(@g_CustomKey[DK_OPENMYSTATUS0]) + ',C)/FCOLOR=$FFFF>';
      X := x - 60;
      Y := Y - 8;
    end
    else if Sender = DMyBag then begin
      ShowMsg := 'Inventory<(' + GetHookKeyStr(@g_CustomKey[DK_OPENITEMBAG]) + ',B)/FCOLOR=$FFFF>';
      X := x - 53;
      Y := Y - 8;
    end
    else if Sender = DMyMagic then begin
      ShowMsg := 'Magic<(' + GetHookKeyStr(@g_CustomKey[DK_OPENMYSTATUS3]) + ',S)/FCOLOR=$FFFF>';
      X := x - 52;
      Y := Y - 6;
    end
    else if Sender = DBotTrade then begin
      ShowMsg := 'Trade<(T)/FCOLOR=$FFFF>';
      X := x - 30;
    end
    else if Sender = DBotGuild then begin
      ShowMsg := 'Guild<(G)/FCOLOR=$FFFF>';
      X := x - 20;
      Y := Y - 8;
    end
    else if Sender = DBotGroup then begin
      ShowMsg := 'Group<(P)/FCOLOR=$FFFF>';
      X := x - 30;
    end
    else if Sender = DBotFriend then begin
      ShowMsg := 'Friend<(W)/FCOLOR=$FFFF>';
      X := x - 55;
      Y := Y + 20;
    end
    else if Sender = DBotSort then begin
      ShowMsg := 'Quest<(Q)/FCOLOR=$FFFF>';
      X := x - 30;
      Y := Y - 8;
    end
    else if Sender = DOption then begin
      ShowMsg := 'Options<(F12)/FCOLOR=$FFFF>';
      X := x - 55 - 20;
      Y := Y + 30;
    end
    else if Sender = DButtonTop then begin
      ShowMsg := 'Ranking';
      X := x - 55;
      Y := Y + 20;
    end
    else if Sender = FrmDlg2.dbtnSelectChr then begin
      ShowMsg := 'Log Out<(ALT + X)/FCOLOR=$FFFF>';
      X := x - 46;
    end
    else if Sender = FrmDlg2.dbtnExitGame then begin
      ShowMsg := 'Exit Game<(ALT + Q)/FCOLOR=$FFFF>';
      X := x - 46;
    end
    else if Sender = DTopShop then begin
      ShowMsg := 'GameShop';
    end
    else if Sender = DOpenCompoundItem then begin
      ShowMsg := 'Compound Window';
    end
    else if Sender = DTopHelp then begin
      ShowMsg := 'Help<(H)/FCOLOR=$FFFF>';
      X := x - 55;
      Y := Y + 20;
    end
    else if Sender = DTopEMail then begin
      ShowMsg := 'Mail<(E)/FCOLOR=$FFFF>';
      X := x - 15;
      Y := Y - 5;
    end
    else if Sender = DBTTakeHorse then begin
      if g_MySelf.m_btHorse = 0 then
        ShowMsg := 'Ride Horse<(' + GetHookKeyStr(@g_CustomKey[DK_ONHORSE]) + ')/FCOLOR=$FFFF>'
      else
        ShowMsg := 'Dismount Horse<(' + GetHookKeyStr(@g_CustomKey[DK_ONHORSE]) + ')/FCOLOR=$FFFF>';
      X := x - 55 - 42;
      Y := Y + 20;
    end
    else if Sender = DBotAddAbil then begin
      ShowMsg := 'Abilities';
      X := x - 8;
    end
    else if Sender = DBotMusic then begin
      ShowMsg := 'Sound';
      X := x - 42;
      Y := Y + 37;
    end
    else if Sender = DBotMiniMap then begin
      ShowMsg := 'Minimap<(V)/FCOLOR=$FFFF>';
      X := x - 82;
      Y := Y + 25;
    end
    else if Sender = DBTFace then begin
      ShowMsg := 'Emoticon';
      X := x - 57;
      Y := Y + 20;
    end
    else if Sender = DFrameMaxMin then begin
      ShowMsg := 'Size Window';
      X := x - 70;
      Y := Y + 42;
    end
    else if Sender = DChatEnlargeButton then begin
      ShowMsg := 'Resize Chat';
      X := x - 70;
      Y := Y + 42;
    end;
end;
    if ShowMsg <> '' then
      DScreen.ShowHint(x, y, ShowMsg, clWhite, True, Integer(Sender));
  end;
end;

procedure TFrmDlg.DButtonDirectPaint(Sender: TObject;
  dsurface: TDXTexture);
var
  d: TDXTexture;
  idx: integer;
begin
if g_nInterface = 1 then begin
  with Sender as TDButton do begin
    if WLib <> nil then begin
      if Downed then begin
        d := WLib.Images[FaceIndex];
        if d <> nil then
          dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, True);
      end;
    end;
  end;
end
else if g_nInterface = 2 then begin
  with Sender as TDButton do begin
    if WLib <> nil then begin
      idx := 0;
      if Downed then begin
        inc(idx, 1)
      end
      else if MouseEntry = msIn then begin
        Inc(idx, 2)
      end;
      d := WLib.Images[FaceIndex + idx];
      if d <> nil then
        dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, True);
    end;
  end;
 end;
end;

procedure TFrmDlg.DNewAccountDirectPaint(Sender: TObject;
  dsurface: TDXTexture);
var
  d: TDXTexture;
  ax, ay: integer;
  I: Integer;
begin
  with Sender as TDWindow do begin
    ax := SurfaceX(Left);
    ay := SurfaceY(Top);
    d := WLib.Images[FaceIndex];
    if d <> nil then
      DrawWindow(dsurface, ax, ay, d);
    if Sender = DNewAccount then begin
      with g_DXCanvas do begin
        for i := 0 to NAHelps.Count - 1 do begin
          TextOut(ax + 298, ay + 55 + i * 14, clSilver, NAHelps[i]);
        end;
      end;
    end;
  end;
end;

procedure TFrmDlg.DOpenMinmapClick(Sender: TObject; X, Y: Integer);
begin
  g_boMiniMapClose := not g_boMiniMapClose;
end;

procedure TFrmDlg.DOpenMinmapDirectPaint(Sender: TObject;
  dsurface: TDXTexture);
var
  d: TDXTexture;
  Idx: Integer;
begin
  with Sender as TDButton do begin
    if WLib <> nil then begin
      Idx := FaceIndex;
      if not g_boMiniMapClose then begin
        if MouseEntry = msIn then
          Inc(Idx);
      end
      else begin
        if MouseEntry = msIn then
          Inc(Idx, 3)
        else
          Inc(Idx, 2)
      end;
      d := WLib.Images[Idx];
      if d <> nil then
        dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, True);
    end;
  end;
end;

procedure TFrmDlg.DrawZoomDlg(DModalWindow: TDModalWindow);
var
  d: TDXTexture;
begin
  with DModalWindow do begin
    SafeFillChar(DlgInfo, SizeOf(DlgInfo), #0);
    d := g_WMain99Images.Images[2161];
    if d <> nil then begin
      DlgInfo[0].WMImages := g_WMain99Images;
      DlgInfo[0].Index := 2161;
      DlgInfo[0].Rect.Left := 0;
      DlgInfo[0].Rect.Top := 0;
      DlgInfo[0].Rect.Bottom := d.Height;
      DlgInfo[0].Rect.Right := Width;
    end;
    d := g_WMain99Images.Images[2181];
    if d <> nil then begin
      DlgInfo[1].WMImages := g_WMain99Images;
      DlgInfo[1].Index := 2181;
      DlgInfo[1].Rect.Left := 0;
      DlgInfo[1].Rect.Top := Height - d.Height;
      DlgInfo[1].Rect.Bottom := Height;
      DlgInfo[1].Rect.Right := Width;
    end;
    d := g_WMain99Images.Images[2170];
    if d <> nil then begin
      DlgInfo[2].WMImages := g_WMain99Images;
      DlgInfo[2].Index := 2170;
      DlgInfo[2].Rect.Left := 0;
      DlgInfo[2].Rect.Top := 0;
      DlgInfo[2].Rect.Bottom := Height;
      DlgInfo[2].Rect.Right := d.Width;
    end;
    d := g_WMain99Images.Images[2172];
    if d <> nil then begin
      DlgInfo[3].WMImages := g_WMain99Images;
      DlgInfo[3].Index := 2172;
      DlgInfo[3].Rect.Left := Width - d.Width;
      DlgInfo[3].Rect.Top := 0;
      DlgInfo[3].Rect.Bottom := Height;
      DlgInfo[3].Rect.Right := Width;
    end;

    d := g_WMain99Images.Images[2160];
    if d <> nil then begin
      DlgInfo[4].WMImages := g_WMain99Images;
      DlgInfo[4].Index := 2160;
      DlgInfo[4].Rect.Left := 0;
      DlgInfo[4].Rect.Top := 0;
    end;
    d := g_WMain99Images.Images[2182];
    if d <> nil then begin
      DlgInfo[5].WMImages := g_WMain99Images;
      DlgInfo[5].Index := 2182;
      DlgInfo[5].Rect.Left := Width - d.Width;
      DlgInfo[5].Rect.Top := 0;
    end;
    d := g_WMain99Images.Images[2180];
    if d <> nil then begin
      DlgInfo[6].WMImages := g_WMain99Images;
      DlgInfo[6].Index := 2180;
      DlgInfo[6].Rect.Left := 0;
      DlgInfo[6].Rect.Top := Height - d.Height;
    end;
    d := g_WMain99Images.Images[2182];
    if d <> nil then begin
      DlgInfo[7].WMImages := g_WMain99Images;
      DlgInfo[7].Index := 2182;
      DlgInfo[7].Rect.Left := Width - d.Width;
      DlgInfo[7].Rect.Top := Height - d.Height;
    end;
  end;
end;

procedure TFrmDlg.DRenewChrClick(Sender: TObject; X, Y: Integer);
var
  lx, ly, idx: integer;
begin
  lx := DRenewChr.LocalX(X) - DRenewChr.Left;
  ly := DRenewChr.LocalY(Y) - DRenewChr.Top;
  if (lx >= 24) and (lX <= 244) and (lY >= 70) and (lY <= (208 + 124)) then begin
    idx := (lY - 70) div 16;
    if idx in [Low(SelectChrScene.RenewChr)..high(SelectChrScene.RenewChr)] then begin
      if SelectChrScene.RenewChr[idx].Name <> '' then begin
        PlaySound(s_glass_button_click);
        RenewChrIdx := idx + 1;
      end;
      exit;
    end;
  end;
  RenewChrIdx := 0;
end;

procedure TFrmDlg.DRenewChrDirectPaint(Sender: TObject;
  dsurface: TDXTexture);
var
  d: TDXTexture;
  ax, ay: integer;
  sMan: string;
  I: integer;
  FontColor: TColor;
begin
  with Sender as TDWindow do begin
    ax := SurfaceX(Left);
    ay := SurfaceY(Top);
    d := WLib.Images[FaceIndex];
    if d <> nil then
      DrawWindow(dsurface, ax, ay, d);
    with SelectChrScene do begin
      for I := Low(RenewChr) to _MIN(high(RenewChr), 12) do begin
        if RenewChr[I].Name <> '' then begin
          with g_DXCanvas do begin
            //SetBkMode(Handle, TRANSPARENT);
            if I = RenewChrIdx - 1 then FontColor := clYellow
            else FontColor := clWhite;
            TextOut(ax + 40, ay + 80 + I * 16, RenewChr[I].Name, FontColor);
            sMan := IntToStr(RenewChr[I].Level);
            TextOut(ax + 150 - TextWidth(sMan) div 2, ay + 80 + I * 16, sMan, FontColor);
            sMan := GetJobName(RenewChr[I].Job);
            TextOut(ax + 230 - TextWidth(sMan) div 2, ay + 80 + I * 16, sMan, FontColor);
            TextOut(ax + 280, ay + 80 + I * 16, GetsexName(RenewChr[I].Sex), FontColor);
          end;
        end;
      end;
    end;
  end;
end;

procedure TFrmDlg.DropMovingItem;
begin
  if g_boItemMoving then begin
    if (g_MovingItem.ItemType = mtBagitem) and (g_MovingItem.Item.S.name <> '') then begin
      if CheckItemBindMode(@g_MovingItem.Item.UserItem, bm_NoDrop) then begin
        AddItemBag(g_MovingItem.Item, g_MovingItem.Index2);
        g_MovingItem.Item.S.name := '';
        g_boItemMoving := False;
        DMessageDlg('You are not allowed to drop this item!', []);
        exit;
      end;
      if CheckItemBindMode(@g_MovingItem.Item.UserItem, bm_DropDestroy) then begin
        g_boItemMoving := False;
        if mrNo = DMessageDlg('This item will be destroyed after drop, do you wish to drop [' + g_MovingItem.Item.S.name + ']?', [mbYes, mbNo]) then begin
          AddItemBag(g_MovingItem.Item, g_MovingItem.Index2);
          g_MovingItem.Item.S.name := '';
        end
        else begin
          frmMain.SendDropItem(g_MovingItem.Item.S.name, g_MovingItem.Item.UserItem.MakeIndex);
          AddDropItem(g_MovingItem.Item);
          ClearMovingItem();
        end;
        exit;
      end;
      g_boItemMoving := False;
      if (g_boCancelDropItemHint and (not DDealDlg.Visible)) or (mrYes = DMessageDlg('Are you sure you want to drop [' + g_MovingItem.Item.S.name + ']?', [mbYes, mbNo])) then begin
        frmMain.SendDropItem(g_MovingItem.Item.S.name, g_MovingItem.Item.UserItem.MakeIndex);
        AddDropItem(g_MovingItem.Item);
      end
      else begin
        AddItemBag(g_MovingItem.Item, g_MovingItem.Index2);
      end;
    end;
    ClearMovingItem();
  end;
end;

procedure TFrmDlg.DSaleDlgCloseClick(Sender: TObject; X, Y: Integer);
begin
  with Sender as TDButton do begin
    if DParent <> nil then
      DParent.Visible := False;
  end;
  CloseSellWindow();
  DSubShop.Visible := false;
end;

procedure TFrmDlg.DSaleDlgDirectPaint(Sender: TObject; dsurface: TDXTexture);
var
  d: TDXTexture;
  ax, ay: integer;
  output: string;
  nprice: integer;
begin
  with Sender as TDWindow do begin
    ax := SurfaceX(Left);
    ay := SurfaceY(Top);
    d := WLib.Images[FaceIndex];
    if d <> nil then
      DrawWindow(dsurface, ax, ay, d);
    if (nSellMode = 0) then begin
      g_DXCanvas.TextOut(ax + 14, ay + 21, 'Sell:', clwhite);
      if SellItem.item.s.name <> '' then begin
        nprice:= GetUserItemPrice(@SellItem.Item.UserItem,@SellItem.Item.s) div 2;
        nprice := (nprice * g_nCurMerRate) div 100;
        output := IntToStr(nprice) + ' Gold';
        g_DXCanvas.TextOut(ax + 110 - g_DXCanvas.TextWidth(output), ay + 21, output, clwhite);
      end;
    end else if (nSellMode = 2) then begin
      g_DXCanvas.TextOut(ax + 14, ay + 21, 'Special Repair:', clwhite);
      if SellItem.item.s.name <> '' then begin
        output := IntToStr(GetRepairItemPrice(@SellItem.Item.UserItem,@SellItem.Item.s) *3) + ' Gold';
        g_DXCanvas.TextOut(ax + 110 - g_DXCanvas.TextWidth(output), ay + 21, output, clwhite);
      end;
    end else if (nSellMode = 1) then begin
      g_DXCanvas.TextOut(ax + 14, ay + 21, 'repair:', clwhite);
      if SellItem.item.s.name <> '' then begin
        output := IntToStr(GetRepairItemPrice(@SellItem.Item.UserItem,@SellItem.Item.s)) + ' Gold';
        g_DXCanvas.TextOut(ax + 110 - g_DXCanvas.TextWidth(output), ay + 21, output, clwhite);
      end;
    end;

  end;

end;

procedure TFrmDlg.DSaleDlgLockClick(Sender: TObject; X, Y: Integer);
begin
  if DSaleDlgLock.FaceIndex = 10 then begin
    DSaleDlgLock.FaceIndex := 12;
    DSaleDlgLock.Caption := 'Unlock';
  end else begin
    DSaleDlgLock.FaceIndex := 10;
    DSaleDlgLock.Caption := 'Lock';
  end;
end;

procedure TFrmDlg.DSaleDlgSellClick(Sender: TObject; X, Y: Integer);
begin
  if SellItem.Item.s.Name = '' then exit;
  if (nSellMode = 0) then begin//if we are selling stuff
    if CheckItemBindMode(@SellItem.Item, bm_NoSell) then
      exit;//should really add a 'cannot sell this' warning here
    ItemClickSound(SellItem.Item.s);
    g_SellDlgItemSellWait := SellItem;
    frmMain.SendSellItem(g_nCurMerchant, g_SellDlgItemSellWait.Item.UserItem.MakeIndex);
//    DelItemBagByIdx(g_SellDlgItemSellWait.Index2);
    SellItem.Index2 := 0;
    SellItem.Item.s.name := '';
  end else if (nSellMode in [1,2]) then begin //(special) repair
    if CheckItemBindMode(@SellItem.Item, bm_NoRepair) then
      exit;//should really add a 'cannot sell this' warning here
    ItemClickSound(SellItem.Item.s);
    g_SellDlgItemSellWait := SellItem;
    frmMain.SendRepairItem(g_nCurMerchant, g_SellDlgItemSellWait.Item.UserItem.MakeIndex,
      MakeWord(Integer(boSuperRepair), 255));
//    DelItemBagByIdx(g_SellDlgItemSellWait.Index2);
    SellItem.Index2 := 0;
    SellItem.Item.s.name := '';
  end;
  
end;

procedure TFrmDlg.DSaleDlgSpotClick(Sender: TObject; X, Y: Integer);
begin
  if g_boItemMoving then begin
    if g_MovingItem.ItemType = mtBottom then
      exit;//for now dont allow selling from quickslot items
    if g_MovingItem.ItemType = mtStateItem then
      exit;//for now dont allow selling of equiped items
    if g_MovingItem.ItemType <> mtBagItem then
      exit; //incase there's itemtypes i dont know about
//    AddItemBag(g_MovingItem.Item, g_MovingItem.Index2);
    if SellItem.item.s.name <> '' then begin//return the old sell item back to inventory
      additembag(sellitem.Item, sellitem.Index2);
    end;
    SellItem := g_MovingItem;//cheat :p
    clearMovingItem();
    if (nSellMode = 0) then begin
      if DSaleDlgLock.FaceIndex = 12 then //have the lock button enabled
        DSaleDlgSellClick(sender, x, y);
    end;
  end else begin
    if SellItem.Item.s.Name <> '' then begin
      g_MovingItem := SellItem;
      SellItem.Item.s.Name := '';
      g_boItemMoving := true;
    end;
  end;

end;

procedure TFrmDlg.DSaleDlgSpotDirectPaint(Sender: TObject;
  dsurface: TDXTexture);
var
  d:TDXTexture;
begin
  with DSaleDlgSpot do begin
    if SellItem.Item.s.Name <> '' then begin
      d := GetBagItemImg(SellItem.Item.s.looks);
      if d <> nil then begin
        RefItemPaint(dsurface, d,
          SurfaceX(DSaleDlgSpot.Left + (DSaleDlgSpot.Width div 2) - (d.ClientRect.Right div 2)),
          SurfaceY(DSaleDlgSpot.Top + (DSaleDlgSpot.Height div 2) - (d.ClientRect.Bottom div 2)),
          SurfaceX(DSaleDlgSpot.Left + (DSaleDlgSpot.Width div 2) + (d.ClientRect.Right div 2)),
          SurfaceY(DSaleDlgSpot.Top + (DSaleDlgSpot.Height div 2) + (d.ClientRect.Bottom div 2)),
          @SellItem.Item, true);
      end;
    end;
  end;
end;

procedure TFrmDlg.DSaleDlgSpotMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var
  MoveItemState: TMoveItemState;
begin
  if SellItem.Item.s.name = '' then exit;
  if nSellMode = 0 then
    MoveItemState := [mis_Sell];
  if nSellMode = 1 then
    MoveItemState := [mis_repair];
  if nSellMode = 2 then
    MoveItemState := [mis_SuperRepair];
  with Sender as TDButton do begin
    DScreen.ShowHint(SurfaceX(Left + (x - left)) + 30, SurfaceY(Top + (y - Top) + 30),
        ShowItemInfo(SellItem.Item, MoveItemState, []), clwhite, False, SellItem.Item.UserItem.MakeIndex, True);
  end
end;

procedure TFrmDlg.DSayMoveSize(Y: Integer);  //ripman
var
  nCount: Integer;
begin
  if not DBTSayMove.Downed then
    exit;
  nCount := (g_FScreenHeight - Y - DBottom3.Height - 39 + 13) div SAYLISTHEIGHT;
  if nCount < 3 then
    nCount := 3;
  if nCount > 29 then
    nCount := 29;

  DWndSay.Height := 2 + nCount * SAYLISTHEIGHT;
  DWndSay.Top := g_FScreenHeight - DWndSay.Height - DBottom.Height - 39;

  DBtnSayAll.Top := DWndSay.Height + 1;
  DBtnSayHear.Top := DWndSay.Height + 1;
  DBtnSayWhisper.Top := DWndSay.Height + 1;
  DBtnSayCry.Top := DWndSay.Height + 1;
  DBtnSayGroup.Top := DWndSay.Height + 1;
  DBtnSayGuild.Top := DWndSay.Height + 1;
  DBtnSaySys.Top := DWndSay.Height + 1;
  DBtnSayCustom.Top := DWndSay.Height + 1;
  dchkSayLock.Top := DWndSay.Height + 2;

  DBTSayLock.Top := DWndSay.Height + 19;
  DBTEdit.Top := DBTSayLock.Top;
  DSayUpDown.Height := DWndSay.Height - 15 + 18;
  DEditChat.Top := DBTEdit.Top + (DBTEdit.Height - 16) div 2;
  DBTFace.Top := DBTEdit.Top;
  DBTOption.Top := DBTEdit.Top;
  DBTTakeHorse.Top := DBTEdit.Top;
end;

procedure TFrmDlg.DscSelect1Click(Sender: TObject; X, Y: Integer);
begin
  if (Sender = DccOk) or (Sender = DccOk2) then
    SelectChrScene.SelChrNewOk;
  if Sender = DccClose then
    SelectChrScene.SelChrNewClose;

  if Sender = DButRenewChr then
    SelectChrScene.SelRenewChr;
    
  if Sender = DButRenewClose then
    SelectChrScene.ChangeSelectChrState(scSelectChr);

  if not SelectChrScene.CreateChrMode then begin 

    if Sender = DscExit then
      FrmMain.Close;

    if Sender = DscStart then
      SelectChrScene.SelChrStartClick;

    if Sender = DscSelect1 then
      SelectChrScene.SelChrSelect1Click;
    if Sender = DscSelect2 then
      SelectChrScene.SelChrSelect2Click;
    if Sender = DscSelect3 then
      SelectChrScene.SelChrSelect3Click;

    if Sender = DscNewChr then
      SelectChrScene.SelChrNewChrClick;
    if Sender = DscEraseChr then
      SelectChrScene.SelChrEraseChrClick;
    if Sender = DscCredits then
      SelectChrScene.SelChrCreditsClick;
  end;

  if (Sender = DccClose) or (Sender = DccClose2) then
    SelectChrScene.SelChrNewClose;

  if Sender = DccWarrior then begin
    btjob := 0;
    SelectChrScene.SelChrNewJob(0);
  end;
  if Sender = DccWizzard then begin
    btJob := 1;
    SelectChrScene.SelChrNewJob(1);
  end;
  if Sender = DccMonk then begin
    btJob := 2;
    SelectChrScene.SelChrNewJob(2);
  end;
  if Sender = DccKiller then begin
    btJob := 3;
    SelectChrScene.SelChrNewJob(3);
  end;
  if Sender = DccRanger then begin
    btJob := 4;
   SelectChrScene.SelChrNewJob(4);
  end;
  if Sender = DccMale then begin
    btSex := 0;
    SelectChrScene.SelChrNewm_btSex(0);
  end;

  if Sender = DccFemale then begin
    btSex := 1;
    SelectChrScene.SelChrNewm_btSex(1);
  end;;

  if Sender = DccJ then
    btWuXin := 0;
  if Sender = DccM then
    btWuXin := 1;
  if Sender = DccS then
    btWuXin := 2;
  if Sender = DccH then
    btWuXin := 3;
  if Sender = DccT then
    btWuXin := 4;

  if Sender = DccManWarrior then begin
    btjob := 0;
    btSex := 0;
  end;
  if Sender = DccManWizzard then begin
    btjob := 1;
    btSex := 0;
  end;
  if Sender = DccManMonk then begin
    btjob := 2;
    btSex := 0;
  end;
  if Sender = DccWoManWarrior then begin
    btjob := 0;
    btSex := 1;
  end;
  if Sender = DccWoManWizzard then begin
    btjob := 1;
    btSex := 1;
  end;
  if Sender = DccWoManMonk then begin
    btjob := 2;
    btSex := 1;
  end;
end;

procedure TFrmDlg.DscSelect1DirectPaint(Sender: TObject; dsurface: TDXTexture);
var
  d: TDirectDrawSurface;
begin
  with Sender as TDButton do begin
    d := nil;
    if not SelectChrScene.CreateChrMode then begin
      if Downed then begin
        if Sender = DscStart then d := WLib.Images[FaceIndex + 2];
        if Sender = DscNewChr then d := WLib.Images[FaceIndex + 2];
        if Sender = DscEraseChr then d := WLib.Images[FaceIndex + 2];
        if Sender = DscCredits then d := WLib.Images[FaceIndex + 2];
        if Sender = DscExit then d := WLib.Images[FaceIndex + 2];
      end else
      if MouseEntry = msIn then begin
        if Sender = DscStart then d := WLib.Images[FaceIndex + 1];
        if Sender = DscNewChr then d := WLib.Images[FaceIndex + 1];
        if Sender = DscEraseChr then d := WLib.Images[FaceIndex + 1];
        if Sender = DscCredits then d := WLib.Images[FaceIndex + 1];
        if Sender = DscExit then d := WLib.Images[FaceIndex + 1];
      end else begin
        if Sender = DscStart then d := WLib.Images[FaceIndex];
        if Sender = DscNewChr then d := WLib.Images[FaceIndex];
        if Sender = DscEraseChr then d := WLib.Images[FaceIndex];
        if Sender = DscCredits then d := WLib.Images[FaceIndex];
        if Sender = DscExit then d := WLib.Images[FaceIndex];
      end;
      if (d = nil) and (WLib <> nil) then
        d := WLib.Images[FaceIndex];
      if d <> nil then
        dsurface.Draw(Left, Top, d.ClientRect, d, True);
    end;
  end;
end;

procedure TFrmDlg.DscCreateChrDirectPaint(Sender: TObject; dsurface: TDXTexture);
var
  d: TDirectDrawSurface;
  n: Integer;
  ax, ay : Integer;
begin
  with Sender as TDButton do begin
    ax := SurfaceX(Left) - Left;
    ay := SurfaceY(Top) - Top;
    d := nil;
    if Sender = DccWarrior then d := WLib.Images[FaceIndex];
    if Sender = DccWizzard then d := WLib.Images[FaceIndex];
    if Sender = DccMonk then d := WLib.Images[FaceIndex];
    if Sender = DccKiller then d := WLib.Images[FaceIndex];
    if Sender = DccRanger then d := WLib.Images[FaceIndex];
    if Sender = DccMale then d := WLib.Images[FaceIndex];
    if Sender = DccFemale then d := WLib.Images[FaceIndex];
    n := SelectChrScene.NewIndex;
    if SelectChrScene.ChrArr[n].Selected then begin
      if (SelectChrScene.ChrArr[n].UserChr.job = 0) and (Sender = DccWarrior) then d := WLib.Images[FaceIndex + 1];
      if (SelectChrScene.ChrArr[n].UserChr.job = 1) and (Sender = DccWizzard) then d := WLib.Images[FaceIndex + 1];
      if (SelectChrScene.ChrArr[n].UserChr.job = 2) and (Sender = DccMonk) then d := WLib.Images[FaceIndex + 1];
      if (SelectChrScene.ChrArr[n].UserChr.job = 3) and (Sender = DccKiller) then d := WLib.Images[FaceIndex + 1];
      if (SelectChrScene.ChrArr[n].UserChr.job = 4) and (Sender = DccRanger) then d := WLib.Images[FaceIndex + 1];

      if (SelectChrScene.ChrArr[n].UserChr.Sex = 0) and (Sender = DccMale) then d := WLib.Images[FaceIndex + 1];
      if (SelectChrScene.ChrArr[n].UserChr.Sex = 1) and (Sender = DccFemale) then d := WLib.Images[FaceIndex + 1];
    end;
    if d <> nil then
      dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, True);
  end;
end;

procedure TFrmDlg.DscOKCloseChrDirectPaint(Sender: TObject; dsurface: TDXTexture); 
var 
  d: TDirectDrawSurface; 
  n: Integer;
  ax, ay : Integer; 
begin 
  with Sender as TDButton do begin 
    ax := SurfaceX(Left) - Left;
    ay := SurfaceY(Top) - Top;
    d := nil; 
    if Downed then begin 
      if Sender = DccOk then d := WLib.Images[FaceIndex + 1]; 
      if Sender = DccClose then d := WLib.Images[FaceIndex + 1]; 
      if Sender = DNewAccountOk then d := WLib.Images[FaceIndex + 1]; 
      if Sender = DNewAccountCancel then d := WLib.Images[FaceIndex + 1];
      if Sender = DChgpwOk then d := WLib.Images[FaceIndex + 1];
      if Sender = DChgpwCancel then d := WLib.Images[FaceIndex + 1];
    end else 
    if MouseEntry = msIn then begin 
      if Sender = DccOk then d := WLib.Images[FaceIndex + 2]; 
      if Sender = DccClose then d := WLib.Images[FaceIndex + 2]; 
      if Sender = DNewAccountOk then d := WLib.Images[FaceIndex + 2]; 
      if Sender = DNewAccountCancel then d := WLib.Images[FaceIndex + 2];
      if Sender = DChgpwOk then d := WLib.Images[FaceIndex + 2];
      if Sender = DChgpwCancel then d := WLib.Images[FaceIndex + 2];
    end else begin 
      if Sender = DccOk then d := WLib.Images[FaceIndex]; 
      if Sender = DccClose then d := WLib.Images[FaceIndex];
      if Sender = DNewAccountOk then d := WLib.Images[FaceIndex];
      if Sender = DNewAccountCancel then d := WLib.Images[FaceIndex];
      if Sender = DChgpwOk then d := WLib.Images[FaceIndex];
      if Sender = DChgpwCancel then d := WLib.Images[FaceIndex];
    end; 
    if d <> nil then 
      dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, True); 
    with g_DXCanvas do begin 
      if Downed then begin 
        if Sender = DccOK then TextOut(ax + 65, ay + 405, 'Create', clGray); 
        if Sender = DccClose then TextOut(ax + 171, ay + 405, 'Close', clGray); 
        if Sender = DNewAccountOk then TextOut(ax + 125, ay + 243, 'Create', clGray);
        if Sender = DNewAccountCancel then TextOut(ax + 241, ay + 243, 'Cancel', clGray);
        if Sender = DChgpwOk then TextOut(ax + 192, ay + 178, 'OK', clGray);
        if Sender = DChgpwCancel then TextOut(ax + 299, ay + 178, 'Cancel', clGray);
      end else begin
        if Sender = DccOK then TextOut(ax + 65, ay + 405, 'Create', GetRGB(150));
        if Sender = DccClose then TextOut(ax + 171, ay + 405, 'Close', GetRGB(150));
        if Sender = DNewAccountOk then TextOut(ax + 125, ay + 243, 'Create', GetRGB(150));
        if Sender = DNewAccountCancel then TextOut(ax + 241, ay + 243, 'Cancel', GetRGB(150));
        if Sender = DChgpwOk then TextOut(ax + 192, ay + 178, 'OK', GetRGB(150));
        if Sender = DChgpwCancel then TextOut(ax + 299, ay + 178, 'Cancel', GetRGB(150));
      end;
    end;
  end;
end;

procedure TFrmDlg.DStateWinDirectPaint(Sender: TObject; dsurface: TDXTexture);
var
  d: TDXTexture;
  ax, ay: integer;
  FontColor: TColor;
begin
  if g_MySelf = nil then
    exit;

  with Sender as TDWindow do begin
    ax := SurfaceX(Left);
    ay := SurfaceY(Top);
    d := WLib.Images[FaceIndex];

    if d <> nil then begin
      DrawWindow(DSurface, ax, ay, d);
      //Surface.Fill(0);
      //Surface.Draw(0, 0, d.ClientRect, d, True);

      d := WLib.Images[2299 + StatePage];
      if d <> nil then
        DrawWindow(DSurface, ax + 38, ay + 46, d);

      //Surface.Draw(8, 37, d.ClientRect, d, True);
      //DrawWindow(DSurface, ax, ay, Surface);
    end;
    with g_DXCanvas do begin
    FontColor := clWhite;
      TextOut(ax + Width div 2 - TextWidth(g_MySelf.m_UserName) div 2 + 6, ay + 20, $B1D2B7, g_MySelf.m_UserName);
    end;
  end;
end;


procedure TFrmDlg.DStateWinItemDirectPaint(Sender: TObject; dsurface: TDXTexture);
const
  nWidth = 100;
  nHeight = 120;
var
  d: TDXTexture;
  ax, ay, bbx, bby, idx: integer;
  Rect: TRect;
  NakedAddAbil: TNakedAddAbil;
  TempNakedAbil: TNakedAbil;
  FontColor: TColor;
  MagicList: TStringList;
  boShow: Boolean;
  AddAbility: TAddAbility;
  I: Integer;
  StdItem: TStdItem;
  str: string;
  row: integer;
  fPercentage: Float;
  sPercentage: String;
begin
  if g_MySelf = nil then
    exit;

  with Sender as TDWindow do begin
    ax := SurfaceX(Left) - Left;
    ay := SurfaceY(Top) - Top;
    if Sender = DStateWinState then begin
      with g_DXCanvas do begin
        DStateBTItem.SendToBack;
        DStateBTState.BringToFront;
        FontColor := clWhite;
        Inc(ax, Left);
        Inc(ay, Top);
        fPercentage := g_MySelf.m_Abil.Exp / g_MySelf.m_Abil.MaxExp * 100;
        if fPercentage < 1 then sPercentage := '0' + FormatFloat('#.##', fPercentage)
            else sPercentage := FormatFloat('#.##', fPercentage);
        FontColor := clWhite;
        TextOut(ax + 37, ay + 10, 'Class: ', $C5C2C5);
        TextOut(ax + 150, ay + 10, GetJobName(g_MySelf.m_btJob), FontColor); //职业
        TextOut(ax + 37, ay + 26, 'Level: ', $C5C2C5);
        TextOut(ax + 150, ay + 26, IntToStr(g_MySelf.m_Abil.Level), FontColor); //人物等级
        TextOut(ax + 37, ay + 42, 'Experience: ', $C5C2C5);
        TextOut(ax + 150, ay + 42, IntToStr(g_MySelf.m_Abil.Exp) + ' (' + sPercentage + '%)', FontColor); //经验
        TextOut(ax + 37, ay + 58, 'Total Experience: ', $C5C2C5);
        TextOut(ax + 150, ay + 58, IntToStr(g_MySelf.m_Abil.MaxExp), FontColor); //经验
        row := 0;
        if g_MySelf.m_Abil.Weight > g_MySelf.m_Abil.MaxWeight then FontColor := clRed;
        TextOut(ax + 37, ay + (row * 16) + 90, 'Bag Weight: ', $C5C2C5);
        TextOut(ax + 150, ay + (row * 16) + 90, IntToStr(g_MySelf.m_Abil.Weight) + '/' + IntToStr(g_MySelf.m_Abil.MaxWeight), FontColor);
        inc(row);
        FontColor := clWhite;
        if g_MySelf.m_Abil.WearWeight > g_MySelf.m_Abil.MaxWearWeight then FontColor := clRed;
        TextOut(ax + 37, ay + (row * 16) +90, 'Body Weight: ', $C5C2C5);
        TextOut(ax + 150, ay + (row * 16) +90, IntToStr(g_MySelf.m_Abil.WearWeight) + '/' + IntToStr(g_MySelf.m_Abil.MaxWearWeight), FontColor);
        inc(row);
        FontColor := clWhite;
        if g_MySelf.m_Abil.HandWeight > g_MySelf.m_Abil.MaxHandWeight then FontColor := clRed;
        TextOut(ax + 37, ay + 90 + (row * 16), 'Hand Weight: ', $C5C2C5);
        TextOut(ax + 150, ay + 90 + (row * 16), IntToStr(g_MySelf.m_Abil.HandWeight) + '/' + IntToStr(g_MySelf.m_Abil.MaxHandWeight), FontColor); //腕力
        inc(row);
        FontColor := clWhite;
        if g_nPkPoint >= 200 then FontColor := clRed
        else if g_nPkPoint >= 100 then FontColor := clyellow;
        TextOut(ax + 37, ay + 90 + (row * 16), 'PK Points: ', $C5C2C5);
        TextOut(ax + 150, ay + 90 + (row * 16), IntToStr(g_nPkPoint), FontColor);
        inc(row);
        FontColor := clWhite;
        TextOut(ax + 37, ay + 90 + (row * 16), 'Credit Points: ', $C5C2C5);
        TextOut(ax + 150, ay + 90 + (row * 16), IntToStr(g_nCreditPoint), FontColor);
//        inc(row);
//        TextOut(ax + 37, ay + 90 + (row * 16), '??Stat1??' {'文采'}, $C5C2C5);
//        TextOut(ax + 150, ay + 90 + (row * 16), IntToStr(g_nLiterary), FontColor);
//        inc(row);
//        TextOut(ax + 37, ay + 90 + (row * 16), '??Stat2??' {'修练'}, $C5C2C5);
//        TextOut(ax + 150, ay + 90 + (row * 16), IntToStr(g_nGameGird), FontColor);
      end;
    end else
    if Sender = DStateWinItem then begin
      DStateBTState.SendToBack;
      DStateBTItem.BringToFront;

      d := g_WMain99Images.Images[236 + Integer(g_MySelf.m_btSex = 1)];
      if d <> nil then
        dsurface.Draw(ax + 112, ay + 105, d.ClientRect, d, True);

      bbx := left + 18;
      bby := Top + 56;
      if g_UseItems[U_DRESS].S.name <> '' then begin
        idx := g_UseItems[U_DRESS].S.looks;
        if idx >= 0 then begin
          ay := ay - 120;
          d := GetStateItemImgXY(idx, ax, ay);
          if d <> nil then
            dsurface.Draw(SurfaceX(bbx + ax), SurfaceY(bby + ay), d.ClientRect, d, True);

          if g_UseItems[U_DRESS].S.AniCount = 29 then begin
            d := GetStateItemImgXY(2425, ax, ay);
            if d <> nil then
              DrawBlend(dsurface, SurfaceX(bbx + ax), SurfaceY(bby + ay), d, 1);
          end
          else if g_UseItems[U_DRESS].S.AniCount = 30 then begin
            d := GetStateItemImgXY(2426, ax, ay);
            if d <> nil then
              DrawBlend(dsurface, SurfaceX(bbx + ax), SurfaceY(bby + ay), d, 1);
          end
          else if g_UseItems[U_DRESS].S.AniCount = 33 then begin
            d := GetStateItemImgXY(2541, ax, ay);
            if d <> nil then
              DrawBlend(dsurface, SurfaceX(bbx + ax), SurfaceY(bby + ay), d, 1);
          end
          else if g_UseItems[U_DRESS].S.AniCount = 34 then begin
            d := GetStateItemImgXY(2543, ax, ay);
            if d <> nil then
              DrawBlend(dsurface, SurfaceX(bbx + ax), SurfaceY(bby + ay), d, 1);
          end
          else if g_UseItems[U_DRESS].S.AniCount = 42 then begin
            d := GetStateItemImgXY(2600 + Integer((FrmMain.m_CurrentTick - AppendTick) div 200 mod 20), ax, ay);
            if d <> nil then
              DrawBlend(dsurface, SurfaceX(bbx + ax), SurfaceY(bby + ay), d, 1);
          end;
        end;
      end;

      idx := HUMHAIRANFRAME * (g_MySelf.m_btHair + 1) - 1;
      if idx > 0 then begin
        d := g_WHairImgImages.GetCachedImage(idx, ax, ay);
        if d <> nil then
          dsurface.Draw(SurfaceX(bbx + ax), SurfaceY(bby + ay), d.ClientRect, d, True);
      end;

      if g_UseItems[U_WEAPON].S.name <> '' then begin
        idx := g_UseItems[U_WEAPON].S.looks;
        if idx >= 0 then begin
          d := GetStateItemImgXY(idx, ax, ay);
          if d <> nil then
            dsurface.Draw(SurfaceX(bbx + ax), SurfaceY(bby + ay), d.ClientRect, d, True);

          if g_UseItems[U_WEAPON].S.AniCount = 21 then begin
            d := g_WMain99Images.GetCachedImage(1438, ax, ay);
            if d <> nil then
              DrawBlend(dsurface, SurfaceX(bbx + ax), SurfaceY(bby + ay), d, 1);
          end
          else if g_UseItems[U_WEAPON].S.AniCount = 23 then begin
            d := GetStateItemImgXY(1890 + Integer((FrmMain.m_CurrentTick - AppendTick) div 200 mod 10), ax, ay);
            if d <> nil then
              DrawBlend(dsurface, SurfaceX(bbx + ax), SurfaceY(bby + ay), d, 1);
          end
          else if g_UseItems[U_WEAPON].S.AniCount = 31 then begin
            d := GetStateItemImgXY(2427, ax, ay);
            if d <> nil then
              DrawBlend(dsurface, SurfaceX(bbx + ax), SurfaceY(bby + ay), d, 1);
          end
          else if g_UseItems[U_WEAPON].S.AniCount = 35 then begin
            d := GetStateItemImgXY(2530 + Integer((FrmMain.m_CurrentTick - AppendTick) div 200 mod 8), ax, ay);
            if d <> nil then
              DrawBlend(dsurface, SurfaceX(bbx + ax), SurfaceY(bby + ay), d, 1);
          end
          else if g_UseItems[U_WEAPON].S.AniCount = 37 then begin
            d := GetStateItemImgXY(2550 + Integer((FrmMain.m_CurrentTick - AppendTick) div 200 mod 10), ax, ay);
            if d <> nil then
              DrawBlend(dsurface, SurfaceX(bbx + ax), SurfaceY(bby + ay), d, 1);
          end
          else if g_UseItems[U_WEAPON].S.AniCount = 39 then begin
            d := GetStateItemImgXY(2560 + Integer((FrmMain.m_CurrentTick - AppendTick) div 200 mod 10), ax, ay);
            if d <> nil then
              DrawBlend(dsurface, SurfaceX(bbx + ax), SurfaceY(bby + ay), d, 1);
          end;
        end;

      end;
      if not CheckIntStatus(g_nGameSetupData, GSP_HIDEHELMET) then begin
        if g_UseItems[U_HELMET].S.name <> '' then begin
          idx := g_UseItems[U_HELMET].S.looks;
          if idx >= 0 then begin
            d := GetStateItemImgXY(idx, ax, ay);
            if d <> nil then
              dsurface.Draw(SurfaceX(bbx + ax - 1), SurfaceY(bby + ay), d.ClientRect, d, True);
          end;
        end;
      end;
      //      bbx := Left  + 233;
      //      bby := Top  + 3;
            {idx := (FrmMain.m_CurrentTick - AppendTick) div 150 mod 10;
            d := g_WMain99Images.GetCachedImage(534 + (g_MySelf.m_btWuXinLevel div 10 * 20) + idx, ax, ay);
            if d <> nil then
              DrawBlend(dsurface, SurfaceX(bbx + ax), SurfaceY(bby + ay), d, 1);  }

      with g_DXCanvas do begin
        //SetBkMode(Handle, TRANSPARENT);
        if (MouseEntry = msin) and (boSelectGuildName) then
          FontColor := clSilver
        else
          FontColor := clWhite;

        TextOut(SurfaceX(Left) + 2, SurfaceY(Top) + 2, g_MySelf.m_sGuildName, FontColor);
        nGuildNameLen := TextWidth(g_MySelf.m_sGuildName);
        if (MouseEntry = msin) and (boSelectGuildRankName) then
          FontColor := clSilver
        else
          FontColor := clWhite;
        TextOut(SurfaceX(Left) + 2, SurfaceY(Top) + 16, g_MySelf.m_sGuildRankName, FontColor);
        nGuildRankNameLen := TextWidth(g_MySelf.m_sGuildRankName);
        //Release;
      end;
    end
    else if Sender = DStateWinAbil then begin
      SafeFillChar(TempNakedAbil, SizeOf(TempNakedAbil), #0);
      if g_nNakedBackCount > 0 then begin
        TempNakedAbil.nAc := g_ClientNakedInfo.NakedAbil.nAc - NakedAbil.nAC;
        TempNakedAbil.nMAc := g_ClientNakedInfo.NakedAbil.nMAc - NakedAbil.nMAc;
        TempNakedAbil.nDc := g_ClientNakedInfo.NakedAbil.nDc - NakedAbil.nDc;
        TempNakedAbil.nMc := g_ClientNakedInfo.NakedAbil.nMc - NakedAbil.nMc;
        TempNakedAbil.nSc := g_ClientNakedInfo.NakedAbil.nSc - NakedAbil.nSc;
        TempNakedAbil.nHP := g_ClientNakedInfo.NakedAbil.nHP - NakedAbil.nHP;
      end
      else begin
        TempNakedAbil.nAc := g_ClientNakedInfo.NakedAbil.nAc + NakedAbil.nAC;
        TempNakedAbil.nMAc := g_ClientNakedInfo.NakedAbil.nMAc + NakedAbil.nMAc;
        TempNakedAbil.nDc := g_ClientNakedInfo.NakedAbil.nDc + NakedAbil.nDc;
        TempNakedAbil.nMc := g_ClientNakedInfo.NakedAbil.nMc + NakedAbil.nMc;
        TempNakedAbil.nSc := g_ClientNakedInfo.NakedAbil.nSc + NakedAbil.nSc;
        TempNakedAbil.nHP := g_ClientNakedInfo.NakedAbil.nHP + NakedAbil.nHP;
      end;
      GetNakedAbilitys(@NakedAddAbil, @TempNakedAbil, @g_ClientNakedInfo.NakedAddInfo);
      with g_DXCanvas do begin
      DStateBTAbil.BringToFront;
        FontColor := clWhite;
        TextOut(ax + 50, ay + 101, 'AC: ', $C5C2C5);
        TextOut(ax + 80, ay + 101,
          IntToStr(Loword(g_MySelf.m_Abil.AC)) + ' - ' +
          IntToStr(Hiword(g_MySelf.m_Abil.AC)), FontColor);
        TextOut(ax + 50, ay + 117, 'MAC: ', $C5C2C5);
        TextOut(ax + 80, ay + 117,
          IntToStr(Loword(g_MySelf.m_Abil.MAC)) + ' - ' +
          IntToStr(Hiword(g_MySelf.m_Abil.MAC)), FontColor);
        TextOut(ax + 50, ay + 133, 'DC: ', $C5C2C5);
        TextOut(ax + 80, ay + 133,
          IntToStr(Loword(g_MySelf.m_Abil.DC)) + ' - ' +
          IntToStr(Hiword(g_MySelf.m_Abil.DC)), FontColor);
        TextOut(ax + 50, ay + 149, 'MC: ', $C5C2C5);
        TextOut(ax + 80, ay + 149,
          IntToStr(Loword(g_MySelf.m_Abil.MC)) + ' - ' +
          IntToStr(Hiword(g_MySelf.m_Abil.MC)), FontColor);
        TextOut(ax + 50, ay + 165, 'SC: ', $C5C2C5);
        TextOut(ax + 80, ay + 165,
          IntToStr(Loword(g_MySelf.m_Abil.SC)) + ' - ' +
          IntToStr(Hiword(g_MySelf.m_Abil.SC)), FontColor);
        TextOut(ax + 50, ay + 181, 'Acc: ', $C5C2C5);
        TextOut(ax + 80, ay + 181, IntToStr(g_nMyHitPoint), FontColor);
        TextOut(ax + 50, ay + 197, 'Agil: ', $C5C2C5);
        TextOut(ax + 80, ay + 197, IntToStr(g_nMySpeedPoint), FontColor);
        TextOut(ax + 150, ay + 101, 'Dmg Bonus: ', $C5C2C5);
        TextOut(ax + 222, ay + 101, '+' + IntToStr(g_nMyAddAttack) + '%', FontColor);
        TextOut(ax + 150, ay + 101 + 1 * 14, 'Absorb Dmg: ', $C5C2C5);
        TextOut(ax + 222, ay + 101 + 1 * 14, '+' + IntToStr(g_nMyDelDamage) + '%', FontColor);
        TextOut(ax + 150, ay + 101 + 2 * 14, 'Atk Speed: ', $C5C2C5);
        if g_Myself.m_nHitSpeed >= 0 then
        TextOut(ax + 222, ay + 101 + 2 * 14, '+' + IntToStr(g_Myself.m_nHitSpeed{g_nDeadliness}) {+ '%'}, FontColor) //used to be crit rate rather then aspeed, but someone translated it wrong
        else
          TextOut(ax + 222, ay + 101 + 2 * 14, IntToStr(g_Myself.m_nHitSpeed{g_nDeadliness}) {+ '%'}, FontColor);
        TextOut(ax + 150, ay + 101 + 3 * 14, 'Anti Magic: ', $C5C2C5);
        TextOut(ax + 222, ay + 101 + 3 * 14, '+' + IntToStr(g_nMyAntiMagic * 10) + '%', FontColor); //魔法躲避
        TextOut(ax + 150, ay + 101 + 4 * 14, 'Anti Poison: ', $C5C2C5);
        TextOut(ax + 222, ay + 101 + 4 * 14, '+' + IntToStr(g_nMyAntiPoison * 10) + '%', FontColor); //毒物躲避
        TextOut(ax + 150, ay + 101 + 5 * 14, 'Poison Recov: ', $C5C2C5);
        TextOut(ax + 222, ay + 101 + 5 * 14, '+' + IntToStr(g_nMyPoisonRecover * 10) + '%', FontColor); //中毒恢复
        TextOut(ax + 150, ay + 101 + 6 * 14, 'HP Recovery: ', $C5C2C5);
        TextOut(ax + 222, ay + 101 + 6 * 14, '+' + IntToStr(g_nMyHealthRecover * 10) + '%', FontColor); //体力恢复
        TextOut(ax + 150, ay + 101 + 7 * 14, 'MP Recovery: ', $C5C2C5);
        TextOut(ax + 222, ay + 101 + 7 * 14, '+' + IntToStr(g_nMySpellRecover * 10) + '%', FontColor); //魔法恢复
        TextOut(ax + 50, ay + 230, 'Ability Points: ', $C5C2C5);
        if NakedBackCount > 0 then
          TextOut(ax + 130, ay + 230, IntToStr(NakedCount + (g_nNakedBackCount - NakedBackCount)) + '/' + IntToStr(NakedBackCount), FontColor)
        else
          TextOut(ax + 130, ay + 230, IntToStr(NakedCount + (g_nNakedBackCount - NakedBackCount)), FontColor); //分配点数

        if g_nNakedBackCount > 0 then begin
          TextOut(ax + 50, ay + 249, 'AC: ', $C5C2C5);
          TextOut(ax + 80, ay + 249, IntToStr(g_ClientNakedInfo.NakedAbil.nAc - NakedAbil.nAc), FontColor); //体质
          TextOut(ax + 50, ay + 265, 'MAC: ', $C5C2C5);
          TextOut(ax + 80, ay + 265, IntToStr(g_ClientNakedInfo.NakedAbil.nMAc - NakedAbil.nMac), FontColor); //身法
          TextOut(ax + 50, ay + 281, 'DC: ', $C5C2C5);
          TextOut(ax + 80, ay + 281, IntToStr(g_ClientNakedInfo.NakedAbil.nDc - NakedAbil.nDC), FontColor); //力量
          TextOut(ax + 50, ay + 297, 'MC: ', $C5C2C5);
          TextOut(ax + 80, ay + 297, IntToStr(g_ClientNakedInfo.NakedAbil.nMc - NakedAbil.nMC), FontColor); //智力
          TextOut(ax + 50, ay + 313, 'SC: ', $C5C2C5);
          TextOut(ax + 80, ay + 313, IntToStr(g_ClientNakedInfo.NakedAbil.nSc - NakedAbil.nSC), FontColor); //精神
          TextOut(ax + 50, ay + 329, 'HP: ', $C5C2C5);
          TextOut(ax + 80, ay + 329, IntToStr(g_ClientNakedInfo.NakedAbil.nHP - NakedAbil.nHP), FontColor); //体力

        end
        else begin
          TextOut(ax + 50, ay + 249, 'AC: ', $C5C2C5);
          TextOut(ax + 80, ay + 249, IntToStr(g_ClientNakedInfo.NakedAbil.nAc + NakedAbil.nAc), FontColor); //体质
          TextOut(ax + 50, ay + 265, 'MAC: ', $C5C2C5);
          TextOut(ax + 80, ay + 265, IntToStr(g_ClientNakedInfo.NakedAbil.nMAc + NakedAbil.nMac), FontColor); //身法
          TextOut(ax + 50, ay + 281, 'DC: ', $C5C2C5);
          TextOut(ax + 80, ay + 281, IntToStr(g_ClientNakedInfo.NakedAbil.nDc + NakedAbil.nDC), FontColor); //力量
          TextOut(ax + 50, ay + 297, 'MC: ', $C5C2C5);
          TextOut(ax + 80, ay + 297, IntToStr(g_ClientNakedInfo.NakedAbil.nMc + NakedAbil.nMC), FontColor); //智力
          TextOut(ax + 50, ay + 313, 'SC: ', $C5C2C5);
          TextOut(ax + 80, ay + 313, IntToStr(g_ClientNakedInfo.NakedAbil.nSc + NakedAbil.nSC), FontColor); //精神
          TextOut(ax + 50, ay + 329, 'HP: ', $C5C2C5);
          TextOut(ax + 80, ay + 329, IntToStr(g_ClientNakedInfo.NakedAbil.nHP + NakedAbil.nHP), FontColor); //体力

        end;
        TextOut(ax + 150, ay + 249, 'Total AC: ', $C5C2C5);
        TextOut(ax + 222, ay + 249,
          IntToStr({Loword(g_MySelf.m_Abil.AC) + }NakedAddAbil.nAc { + g_ClientNakedAddAbil.nAc}) + ' - ' +
          IntToStr({Hiword(g_MySelf.m_Abil.AC) + }NakedAddAbil.nAc2 { + g_ClientNakedAddAbil.nAc2}), FontColor); //物防
        TextOut(ax + 150, ay + 265, 'Total MAC: ', $C5C2C5);
        TextOut(ax + 222, ay + 265,
          IntToStr({Loword(g_MySelf.m_Abil.MAC) + }NakedAddAbil.nMac { + g_ClientNakedAddAbil.nMac}) + ' - ' +
          IntToStr({Hiword(g_MySelf.m_Abil.MAC) + }NakedAddAbil.nMac2 { + g_ClientNakedAddAbil.nMac2}), FontColor);
        TextOut(ax + 150, ay + 281, 'Total DC: ', $C5C2C5);
        TextOut(ax + 222, ay + 281,
          IntToStr({Loword(g_MySelf.m_Abil.DC) + }NakedAddAbil.nDc { + g_ClientNakedAddAbil.nDC}) + ' - ' +
          IntToStr({Hiword(g_MySelf.m_Abil.DC) + }NakedAddAbil.nDC2 { + g_ClientNakedAddAbil.nDC2}), FontColor);
        TextOut(ax + 150, ay + 297, 'Total MC: ', $C5C2C5);
        TextOut(ax + 222, ay + 297,
          IntToStr({Loword(g_MySelf.m_Abil.MC) +}NakedAddAbil.nMC { + g_ClientNakedAddAbil.nMC}) + ' - ' +
          IntToStr({Hiword(g_MySelf.m_Abil.MC) +}NakedAddAbil.nMc2 { + g_ClientNakedAddAbil.nMc2}), FontColor);
        TextOut(ax + 150, ay + 313, 'Total SC: ', $C5C2C5);
        TextOut(ax + 222, ay + 313,
          IntToStr({Loword(g_MySelf.m_Abil.SC) +}NakedAddAbil.nSC { + g_ClientNakedAddAbil.nSc}) + ' - ' +
          IntToStr({Hiword(g_MySelf.m_Abil.SC) +}NakedAddAbil.nSC2 {+ g_ClientNakedAddAbil.nSC2}), FontColor);
        TextOut(ax + 150, ay + 329, 'Total HP: ', $C5C2C5);
        TextOut(ax + 222, ay + 329, IntToStr({g_MySelf.m_Abil.MaxHP + }NakedAddAbil.nHP {+ g_ClientNakedAddAbil.nHP}), FontColor);
      end;
    end
    else if Sender = DStateWinInfo then begin

      if MyHDInfoSurface <> nil then begin

      DStateBTInfo.BringToFront;
        DStateInfoRefPic.Enabled := False;
        Rect.Left := 0;

        ax := ax + Left + 16;
        aY := aY + Top + 7;

        if MyHDInfoSurface.Width < nWidth then begin
          ax := ax + (nWidth - MyHDInfoSurface.Width) div 2;
          Rect.Right := MyHDInfoSurface.Width;
        end
        else begin
          Rect.Right := nWidth;
        end;
        Rect.Top := 0;
        if MyHDInfoSurface.Height < nHeight then begin
          aY := aY + (nHeight - MyHDInfoSurface.Height) div 2;
          Rect.Bottom := MyHDInfoSurface.Height;
        end
        else begin
          Rect.Bottom := nHeight;
        end;
        dsurface.Draw(aX, aY, Rect, MyHDInfoSurface, False);
      end
      else begin
        d := g_WMain99Images.Images[252 + Integer(g_UserRealityInfo.sPhotoID <> '')];
        if d <> nil then
          dsurface.Draw(ax + Left + 35, ay + Top - 1, d.ClientRect, d, True);
        if g_UserRealityInfo.sPhotoID <> '' then
          DStateInfoRefPic.Enabled := True
        else
          DStateInfoRefPic.Enabled := False;
      end;
    end
    else if Sender = DStateWinMagic then begin
    DStateBTMagic.BringToFront;
      DMagicCBOSetup.Visible := DMagicIndex = 1;
      DMagicCBOSetup.Enabled := not DStateWinMagicCbo.Visible;
      DMagicSub.Visible := False;
      DMakeMagicAdd1.Visible := False;
      DMakeMagicAdd2.Visible := False;
      DMakeMagicAdd3.Visible := False;
      DMakeMagicAdd4.Visible := False;
      DMakeMagicAdd5.Visible := False;
      DMakeMagicAdd6.Visible := False;
      DMakeMagicAdd7.Visible := False;
      DMakeMagicAdd8.Visible := False;
      DMakeMagicAdd9.Visible := False;
      DMakeMagicAdd10.Visible := False;
      case DMagicIndex of
        0: MagicList := MagicList1;
        1: MagicList := MagicList2;
      else exit;
      end;
      MagicMaxPage := MagicList.Count div 5;
      if MagicList.Count > (MagicMaxPage * 5) then
        Inc(MagicMaxPage);
      Dec(MagicMaxPage);
      if MagicPage > MagicMaxPage then
        MagicPage := MagicMaxPage;
      DMagicFront.Enabled := True;
      DMagicNext.Enabled := True;
      if MagicMaxPage = 0 then begin
        DMagicFront.Enabled := False;
        DMagicNext.Enabled := False;
      end
      else if MagicPage = 0 then begin
        DMagicFront.Enabled := False;
      end
      else if MagicPage = MagicMaxPage then begin
        DMagicNext.Enabled := False;
      end;
    end else
    if Sender = DStateWinHorse then begin
      with g_DXCanvas do begin
      ax := ax + 12;
      ay := ay + 6;
      DStateBTHorse.BringToFront;
        if g_UseItems[U_HOUSE].S.name <> '' then begin
          GetHorseLevelAbility(@g_UseItems[U_HOUSE].UserItem, @g_UseItems[U_HOUSE].S, AddAbility);
          for I := Low(g_UseItems[U_HOUSE].UserItem.HorseItems) to High(g_UseItems[U_HOUSE].UserItem.HorseItems) do begin
            if g_UseItems[U_HOUSE].UserItem.HorseItems[I].wIndex > 0 then begin
              StdItem := GetStditem(g_UseItems[U_HOUSE].UserItem.HorseItems[I].wIndex, g_Myself.m_Abil.Level, g_Myself.m_btJob);
              if StdItem.Name <> '' then
                GetHorseAddAbility(@g_UseItems[U_HOUSE].UserItem, @StdItem, I, AddAbility);
            end;
          end;

          d := g_WMain99Images.Images[1775];
          if d <> nil then begin
            Rect := d.ClientRect;
            Rect.Right := _MIN(Round(Rect.Right / (g_UseItems[U_HOUSE].UserItem.dwMaxExp / g_UseItems[U_HOUSE].UserItem.dwExp)), rect.Right);
            dsurface.Draw(ax + 69, ay + 117, Rect, d, True);
          end;

          d := g_WMain99Images.Images[1774];
          if d <> nil then begin
            Rect := d.ClientRect;
            if g_MySelf.m_btHorse <> 0 then
              Rect.Right := _MIN(Round(Rect.Right / (g_MySelf.m_Abil.MaxHP / g_MySelf.m_Abil.HP)), rect.Right)
            else
              Rect.Right := _MIN(Round(Rect.Right / (AddAbility.HP / g_UseItems[U_HOUSE].UserItem.wHP)), rect.Right);
            dsurface.Draw(ax + 69, ay + 103, Rect, d, True);
          end;

          TextOut(ax + 38, ay + 80, 'Level: ', $C5C2C5);
          TextOut(ax + 70, ay + 80, $FFFFFF, IntToStr(g_UseItems[U_HOUSE].UserItem.btLevel));


          TextOut(ax + 105, ay + 80, 'Status: ', $C5C2C5);
          if g_UseItems[U_HOUSE].UserItem.btAliveTime > 0 then begin
            TextOut(ax + 140, ay + 80, $C0C0C0, 'Has Died ' + IntToStr(g_UseItems[U_HOUSE].UserItem.btAliveTime) + ' minutes untill revive');
          end else begin
            TextOut(ax + 140, ay + 80, $00FF00, 'Normal ');
          end;


          if g_MySelf.m_btHorse <> 0 then str := IntToStr(g_MySelf.m_Abil.HP) + '/' + IntToStr(g_MySelf.m_Abil.MaxHP)
          else str := IntToStr(g_UseItems[U_HOUSE].UserItem.wHP) + '/' + IntToStr(AddAbility.HP);
          TextOut(ax + 38, ay + 99, 'HP: ', $C5C2C5);
          TextOut(ax + 147 - TextWidth(str) div 2 + 12, ay + 99, $FFFFFF, str);


          str := IntToStr(g_UseItems[U_HOUSE].UserItem.dwExp) + '/' + IntToStr(g_UseItems[U_HOUSE].UserItem.dwMaxExp);
          TextOut(ax + 38, ay + 113, 'EXP: ', $C5C2C5);
          TextOut(ax + 147 - TextWidth(str) div 2 + 12, ay + 113, $FFFFFF, str);


          TextOut(ax + 50, ay + 293, 'AC: ', $C5C2C5);
          TextOut(ax + 88, ay + 293, $FFFFFF, IntToStr(AddAbility.AC) + '-' + IntToStr(AddAbility.AC2));
          TextOut(ax + 50, ay + 307, 'MAC: ', $C5C2C5);
          TextOut(ax + 88, ay + 307, $FFFFFF, IntToStr(AddAbility.MAC) + '-' + IntToStr(AddAbility.MAC2));
          TextOut(ax + 50, ay + 321, 'DC: ', $C5C2C5);
          TextOut(ax + 88, ay + 321, $FFFFFF, IntToStr(AddAbility.DC) + '-' + IntToStr(AddAbility.DC2));
          TextOut(ax + 168, ay + 293, 'Acc: ', $C5C2C5);
          TextOut(ax + 206, ay + 293, $FFFFFF, IntToStr(AddAbility.wHitPoint));
          TextOut(ax + 168, ay + 307, 'Agil: ', $C5C2C5);
          TextOut(ax + 206, ay + 307, $FFFFFF, IntToStr(AddAbility.wSpeedPoint));

          d := g_WRideImages.GetCachedImage(RIDEFRAME * (g_UseItems[U_HOUSE].S.Shape - 1) + 80 + Integer((FrmMain.m_CurrentTick - AppendTick) div 120 mod 8), bbx, bby);
          if d <> nil then
            dsurface.Draw(aX + bbx + 126, aY + bby + 190, d.ClientRect, d, True);
        end;
      end;
    end;
  end;
end;

procedure TFrmDlg.DStateWinItemMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
  StateAbilIndex := -1;
  if Sender = DStateWinItem then begin
    boSelectGuildName := False;
    boSelectGuildRankName := False;
    if (x >= 74) and (x <= 74 + 48) and (y >= 80) and (y <= 80 + 98) then begin
      DSWWeaponMouseMove(DSWWeapon, Shift, X - DStateWinItem.Left, Y - DStateWinItem.Top);
    end
    else if (x >= 123) and (x <= 123 + 48) and (y >= 110) and (y <= 110 + 120) then begin
      DSWWeaponMouseMove(DSWDress, Shift, X - DStateWinItem.Left, Y - DStateWinItem.Top);
    end
    else if (x >= 123) and (x <= 123 + 48) and (y >= 80) and (y <= 80 + 32) then begin
      DSWWeaponMouseMove(DSWHelmet, Shift, X - DStateWinItem.Left, Y - DStateWinItem.Top);
    end
    else if (x >= 16) and (x <= 16 + nGuildNameLen) and (y >= 90) and (y <= 104) then begin
      boSelectGuildName := True;
    end
    else if (x >= 16) and (x <= 16 + nGuildRankNameLen) and (y >= 105) and (y <= 119) then begin
      boSelectGuildRankName := True;
    end;
  end;
end;

procedure TFrmDlg.DStateWinItemMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if (x >= 74) and (x <= 74 + 48) and (y >= 80) and (y <= 80 + 98) then begin
    DSWWeaponMouseUp(DSWWeapon, Button, Shift, X, Y);
  end
  else if (x >= 123) and (x <= 123 + 48) and (y >= 110) and (y <= 110 + 120) then begin
    DSWWeaponMouseUp(DSWDress, Button, Shift, X, Y);
  end
  else if (x >= 123) and (x <= 123 + 48) and (y >= 80) and (y <= 80 + 32) then begin
    DSWWeaponMouseUp(DSWHelmet, Button, Shift, X, Y);
  end;
  if boSelectGuildName then begin
    PlayScene.SetEditChar(g_MySelf.m_sGuildName);
  end
  else if boSelectGuildRankName then begin
    PlayScene.SetEditChar(g_MySelf.m_sGuildRankName);
  end;
end;

procedure TFrmDlg.DStateWinMagicCboDirectPaint(Sender: TObject; dsurface: TDXTexture);
var
  d: TDXTexture;
  ax, ay: integer;
begin
  with Sender as TDWindow do begin
    ax := SurfaceX(Left);
    ay := SurfaceY(Top);
    d := WLib.Images[FaceIndex];
    if d <> nil then
      DrawWindow(dsurface, ax, ay, d);
  end;
end;

procedure TFrmDlg.DStateWinMagicCboGridGridMouseMove(Sender: TObject; X, Y, ACol, ARow: Integer; Shift: TShiftState);
var
  idx: Integer;
  ShowMsg: string;
begin
  with Sender as TDGrid do begin
    idx := ACol + ARow;
    if (Idx in [Low(CboMagicList.MagicList)..High(CboMagicList.MagicList)]) then
    begin
      if idx = FMagicCboKeyIndex then
        ShowMsg := 'To move the set just click cancel. \' + 'Click the skill to to set a position.\'
      else
        ShowMsg := 'Click to move.\';
      ShowMsg := ShowMsg + '<Two Combos /FCOLOR=$FFFF>required to perform skill.\';
      DScreen.ShowHint(SurfaceX(Left + (x - left)), SurfaceY(Top + (y - Top) + 30),
        ShowMsg, clWhite, False, Integer(Sender));
    end;
  end;
end;

procedure TFrmDlg.DStateWinMagicCboGridGridPaint(Sender: TObject; ACol, ARow: Integer; Rect: TRect;
  State: TGridDrawState; dsurface: TDXTexture);
var
  idx, nMagID: Integer;
  Magic: TClientDefMagic;
  d: TDXTexture;
begin
  with Sender as TDGrid do
  begin
    idx := ACol + ARow;
    if (Idx in [Low(CboMagicList.MagicList)..High(CboMagicList.MagicList)]) and (idx = FMagicCboKeyIndex) then
    begin
      d := g_WMain99Images.Images[2112 + (FrmMain.m_CurrentTick - AppendTick) div 200 mod 2];
      if d <> nil then
        DrawBlend(dsurface, SurfaceX(Rect.Left + (ColWidth - d.Width) div 2), SurfaceY(Rect.Top + (RowHeight - d.Height) div 2), d, 1);
    end;
  end;
  with Sender as TDGrid do begin
    idx := ACol + ARow;
    if (Idx in [Low(CboMagicList.MagicList)..High(CboMagicList.MagicList)]) then begin
      nMagID := CboMagicList.MagicList[Idx];
      if nMagID = 0 then
        exit;

      Magic := GetMagicInfo(nMagID);
      if Magic.Magic.sMagicName <> '' then begin
        d := GetDefMagicIcon(Magic.Magic.wMagicIcon);
        if d <> nil then begin
          if g_MyMagicArry[nMagID].boStudy then begin
            dsurface.Draw(SurfaceX(Rect.Left + (ColWidth - d.Width) div 2),
              SurfaceY(Rect.Top + (RowHeight - d.Height) div 2), d.ClientRect, d, False);
          end
          else
            CboMagicList.MagicList[Idx] := 0;
        end;
      end
      else
        CboMagicList.MagicList[Idx] := 0;
    end;
  end;  
end;

procedure TFrmDlg.DStateWinMagicCboGridGridSelect(Sender: TObject; X, Y, ACol, ARow: Integer; Shift: TShiftState);
  procedure ClearUserKeyType(nIdx: Integer);
  var
    i: integer;
  begin
    for i := Low(CboMagicList.MagicList) to High(CboMagicList.MagicList) do begin
      if CboMagicList.MagicList[i] = nIdx then begin
        CboMagicList.MagicList[i] := 0;
      end;
    end;
  end;

  function CheckMagic(nMagID: Integer; out nIndex: Integer): Boolean;
  begin
    Result := False;
    if nMagID in [Low(g_MyMagicArry)..High(g_MyMagicArry)] then begin
      if g_MyMagicArry[nMagID].boStudy then begin
        Result := True;
        nIndex := g_MyMagicArry[nMagID].Def.Magic.wMagicIcon;
      end;
    end;
  end;
var
  idx: Integer;
begin
  with Sender as TDGrid do
  begin
    idx := ACol + ARow;
    if (Idx in [Low(CboMagicList.MagicList)..High(CboMagicList.MagicList)]) then
    begin
      if (idx = FMagicCboKeyIndex) then
        CboMagicList.MagicList[Idx] := 0
      else
        FMagicCboKeyIndex := idx;
    end;
  end;
end;

procedure TFrmDlg.DStateWinMagicCboICOClick(Sender: TObject; X, Y: Integer);
begin
  FrmDlg4.FMagicKeyIndex := g_MyMagicArry[SKILL_CBO].btKey;
  FrmDlg4.FMagidID := SKILL_CBO;
  FrmDlg4.DWndMagicKey.ShowModal;
end;

procedure TFrmDlg.DStateWinMagicCboICODirectPaint(Sender: TObject; dsurface: TDXTexture);
var
  d: TDXTexture;
begin
  with Sender as TDButton do begin
    if g_MyMagicArry[SKILL_CBO].btKey = 0 then begin
      d := g_WMain99Images.Images[1870];
      if d <> nil then begin
        dsurface.Draw(SurfaceX(Left + 2), SurfaceY(Top + 2), d.ClientRect, d, True);
      end;
    end
    else begin
      d := g_WMain99Images.Images[2095 + g_MyMagicArry[SKILL_CBO].btKey];
      if d <> nil then begin
        dsurface.Draw(SurfaceX(Left + 6), SurfaceY(Top + 3), d.ClientRect, d, True);
      end;
    end;
  end;
end;

procedure TFrmDlg.DStateWinMagicCboICOInRealArea(Sender: TObject; X, Y: Integer; var IsRealArea: Boolean);
begin
  IsRealArea := True;
end;

procedure TFrmDlg.DStateWinMagicCboOKClick(Sender: TObject; X, Y: Integer);
var
  i, ii: integer;
begin
  for I := Low(CboMagicList.MagicList) to High(CboMagicList.MagicList) do begin
    if CboMagicList.MagicList[i] = 0 then
      for ii := I + 1 to High(CboMagicList.MagicList) do begin
        if CboMagicList.MagicList[ii] > 0 then begin
          CboMagicList.MagicList[i] := CboMagicList.MagicList[ii];
          CboMagicList.MagicList[ii] := 0;
          break;
        end;
      end;
  end;
  if (CboMagicList.MagicList[0] > 0) and (CboMagicList.MagicList[1] > 0) then begin
    FrmMain.SendClientMessage(CM_CBOMAGIC, CboMagicList.nMagicList, 0, 0, 0, '');
    DStateWinMagicCbo.Visible := False;
  end
  else
    DMessageDlg('Two combos must be set!', [mbOK]);
end;

procedure TFrmDlg.DStateWinMagicCboVisible(Sender: TObject; boVisible: Boolean);
begin
  FMagicCboKeyIndex := 0;
  CboMagicList := g_CboMagicList;
end;

procedure TFrmDlg.DStateWinMagicVisible(Sender: TObject; boVisible: Boolean);
begin
  if not boVisible then
    DStateWinMagicCbo.Visible := False;
end;

procedure TFrmDlg.DStateWinVisible(Sender: TObject; boVisible: Boolean);
begin
  if not boVisible then
    boOpenStatus := False;
end;

procedure TFrmDlg.DSubShopBuyClick(Sender: TObject; X, Y: Integer);
begin
  if g_SellDlgItemSellWait.Item.s.Name <> '' then exit;//cant buy an item while clients still waiting for last sale to work
  
  if (Length(NpcSubItems) > 0) and (nSubShopSelectionIdx in [Low(NpcSubItems)..High(NpcSubItems)]) then begin
    if NpcSubItems[nSubShopSelectionIdx].s.name <> '' then begin
      if (nSubShopSelectionIdx >= 0) and (nSubShopSelectionIdx < 60000) then begin
        frmMain.SendBuyItem(g_nCurMerchant, nSubShopIndex, 1,  NpcSubItems[nSubShopSelectionIdx].UserItem.MakeIndex, NpcBindGold,NpcSubItems[nSubShopSelectionIdx].s.name);
        g_SellDlgItemSellWait.Item.UserItem.MakeIndex := NpcSubItems[nSubShopSelectionIdx].UserItem.MakeIndex;
        g_SellDlgItemSellWait.Item.S.name := NpcSubItems[nSubShopSelectionIdx].s.name;
        nSubShopSelectionIdx := -1;
      end;
    end;
  end
end;

procedure TFrmDlg.DSubShopDirectPaint(Sender: TObject; dsurface: TDXTexture);
var
  d: TDXTexture;
  ax, ay: integer;
begin
  if Length(NpcSubItems) = 0 then begin
    DSubShop.Visible := false;
    exit;
  end;
  with Sender as TDWindow do begin
    ax := SurfaceX(Left);
    ay := SurfaceY(Top);
    d := WLib.Images[FaceIndex];
    if d <> nil then
      DrawWindow(dsurface, ax, ay, d);
  end;
  with g_DXCanvas do begin
    //FillRect(aX+16, ay+15, 126, 24, $FF000000);
    if Length(NpcSubItems) > 0 then
      TextOut(ax + 8 + (126-TextWidth(NpcSubItems[0].S.Name)) div 2, ay + 28, $FFFFFF,'Item: '+NpcSubItems[0].S.Name);
  end;
end;

procedure TFrmDlg.DSubShopGridGridMouseMove(Sender: TObject; X, Y, ACol,
  ARow: Integer; Shift: TShiftState);
var
  idx: integer;
begin
  with Sender as TDGrid do begin
    idx := ACol + ARow * ColCount + (DSubShopUpDown.Position * Colcount);
      if (Length(NpcSubItems) > 0) and (idx in [Low(NpcSubItems)..High(NpcSubItems)]) then begin
        if NpcSubItems[idx].s.Name <> '' then begin
          DScreen.ShowHint(SurfaceX(Left + (x - left)) + 30, SurfaceY(Top + (y - Top) + 30),
            ShowItemInfo(NpcSubItems[idx], [mis_buy], [NpcSubItems[idx].s.Price, Integer(NpcBindGold)]),
            clwhite, False, idx, True);
        end;
      end;
    end
end;

procedure TFrmDlg.DSubShopGridGridPaint(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState; dsurface: TDXTexture);
var
  d: TDXTexture;
  idx: Integer;
  cu: pTNewClientItem;
  str: string;
  ani: integer;
begin
  with Sender as TDGrid do begin
    idx := ACol + ARow * ColCount + (DSubShopUpDown.Position * ColCount);
    if nSubShopSelectionIdx = idx then begin
      if SubShopAnitick + 40 < FrmMain.m_CurrentTick then begin
        SubShopAniTick:= FrmMain.m_CurrentTick;
        inc(nSubShopSelAniIndex);
        if nSubShopSelAniIndex > 15 then nSubShopSelAniIndex := 0;
      end;

      d := g_WUI3Images.Images[2880+nSubShopSelAniIndex];
      if d <> nil then
        DSurface.Draw(SurfaceX(Rect.Left), SurfaceY(Rect.Top), d.ClientRect , d, True);
    end;
    if (Length(NpcSubItems) > 0) and (idx in [Low(NpcSubItems)..High(NpcSubItems)]) then begin
      if NpcSubItems[idx].S.name <> '' then begin
        d := GetBagItemImg(NpcSubItems[idx].S.looks);
        if d <> nil then begin
          RefItemPaint(dsurface, d,
            SurfaceX(Rect.Left)+((ColWidth - d.Width) div 2),
            SurfaceY(Rect.Top + (RowHeight - d.Height) div 2),
            SurfaceX(Rect.Right),
            SurfaceY(Rect.Bottom) - 12,
          @NpcSubItems[idx], False);
        end;
      end;
    end;
  end;
end;

procedure TFrmDlg.DSubShopGridGridSelect(Sender: TObject; X, Y, ACol,
  ARow: Integer; Shift: TShiftState);
var
  idx: integer;
begin
  with Sender as TDGrid do begin
    idx := ACol + ARow * ColCount + (DSubShopUpDown.Position * ColCount);
    nSubShopSelectionIdx := idx;
  end;
end;

procedure TFrmDlg.DSWWeaponDirectPaint(Sender: TObject; dsurface: TDXTexture);
var
  d: TDXTexture;
  where: integer;
  //boDraw: Boolean;
  nInt: Integer;
  showstr: string;
  pRect: TRect;
  Item: TNewClientItem;
begin
  with Sender as TDButton do begin
    FillChar(Item, SizeOf(Item), #0);
    if (Tag in [Low(g_UseItems)..High(g_UseItems)]) then begin
      Item := g_UseItems[Tag];
      if g_boItemMoving and (g_MovingItem.ItemType = mtBagItem) and (g_MovingItem.Item.S.name <> '') then begin
        where := GetTakeOnPosition(g_MovingItem.Item.S.StdMode);
        if where in [0..MAXUSEITEMS - 1] then begin
          if (Tag = where) or ((where = U_RINGL) and (Sender = DSWRingR)) or
            ((where = U_ARMRINGL) and (Sender = DSWArmRingR)) then begin
            d := g_WMain99Images.Images[2112 + (FrmMain.m_CurrentTick - AppendTick) div 200 mod 2];
            if d <> nil then
              DrawBlend(dsurface, SurfaceX(Left) - 12, SurfaceY(Top) - 14, d, 1);
            //            boDraw := True;
          end;
        end;
      end;
    end else
    if Tag in [16..20] then begin
      if g_UseItems[U_HOUSE].S.Name <> '' then begin
        Item := HorseItemToClientItem(@g_UseItems[U_HOUSE].UserItem.HorseItems[Tag - 16]);
      end;
      if g_boItemMoving and (g_MovingItem.ItemType = mtBagItem) and (g_MovingItem.Item.S.name <> '') then begin
        where := GetHorseTakeOnPosition(g_MovingItem.Item.S.StdMode);
        if where in [Low(g_UseItems[U_HOUSE].UserItem.HorseItems)..High(g_UseItems[U_HOUSE].UserItem.HorseItems)] then begin
          if ((Tag - 16) = where) then begin
            d := g_WMain99Images.Images[2112 + (FrmMain.m_CurrentTick - AppendTick) div 200 mod 2];
            if d <> nil then
              DrawBlend(dsurface, SurfaceX(Left) - 12, SurfaceY(Top) - 14, d, 1);
            //            boDraw := True;
          end;
        end;
      end;
    end;
    if Item.S.name <> '' then begin
      d := GetBagItemImg(Item.S.looks);
      if d <> nil then begin
        pRect.Left := SurfaceX(Left - 1);
        pRect.Top := SurfaceY(Top - 1);
        pRect.Right := SurfaceX(Left + Width + 1);
        pRect.Bottom := SurfaceY(Top + Height + 1);
        RefItemPaint(dsurface, d, //人物背包栏
          SurfaceX(Left + (Width - d.Width) div 2),
          SurfaceY(Top + (Height - d.Height) div 2),
          1,
          1,
          @Item, False, [pmShowLevel], @pRect);
        if ((sm_Arming in Item.s.StdModeEx) or (sm_HorseArm in Item.s.StdModeEx)) and (Item.UserItem.Dura < Item.UserItem.DuraMax) then begin
          nInt := Round(Item.UserItem.Dura / Item.UserItem.DuraMax * 100);
          if (nInt <= 50) or (g_CursorMode = cr_Repair) then begin
            with g_DXCanvas do begin
              showstr := IntToStr(nInt) + '%';
              if nInt <= 30 then TextOut(SurfaceX(Left + Width - 2) - TextWidth(showstr), SurfaceY(Top + Height) - 12, clRed, showstr)
              else TextOut(SurfaceX(Left + Width - 2) - TextWidth(showstr), SurfaceY(Top + Height) - 12, clwhite, showstr);
            end;
          end;
        end;
      end;
    end;
  end;
end;

procedure TFrmDlg.DSWWeaponMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
var
  nLocalX, nLocalY: Integer;
  nHintX, nHintY: Integer;
  sel: Integer;
  MoveItemState: TMoveItemState;
  Item: TNewClientItem;
begin
  with Sender as TDControl do begin
    if DParent = nil then exit;
    nLocalX := LocalX(X - Left);
    nLocalY := LocalY(Y - Top);
    nHintX := SurfaceX(Left) + DParent.SurfaceX(DParent.Left) + nLocalX + 30;
    nHintY := SurfaceY(Top) + DParent.SurfaceY(DParent.Top) + nLocalY + 30;
    sel := Tag;
    FillChar(Item, SizeOf(Item), #0);
    if (sel in [Low(g_UseItems)..High(g_UseItems)]) then begin
      Item := g_UseItems[sel];
    end else
    if sel in [16..20] then begin
      if g_UseItems[U_HOUSE].S.Name <> '' then begin
        Item := HorseItemToClientItem(@g_UseItems[U_HOUSE].UserItem.HorseItems[sel - 16]);
      end;
    end;
    if Item.s.Name <> '' then begin
      MoveItemState := [mis_State];
      case g_CursorMode of
        cr_Repair: begin
            if boSuperRepair then
              MoveItemState := MoveItemState + [mis_SuperRepair]
            else
              MoveItemState := MoveItemState + [mis_Repair];
          end;
      end;
      DScreen.ShowHint(nHintX, nHintY, ShowItemInfo(Item, MoveItemState, []), clwhite, False, Integer(Sender), True);
    end;
    //end;
  end;
end;

procedure TFrmDlg.DSWWeaponMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  where, sel: Integer;
  Item: TNewClientItem;
begin
  if g_MySelf = nil then Exit;
  sel := (Sender as TDButton).Tag;

  FillChar(Item, SizeOf(Item), #0);
  if (sel in [Low(g_UseItems)..High(g_UseItems)]) then begin
    Item := g_UseItems[sel];
  end else
  if sel in [16..20] then begin
    if g_UseItems[U_HOUSE].S.Name <> '' then begin
      Item := HorseItemToClientItem(@g_UseItems[U_HOUSE].UserItem.HorseItems[sel - 16]);
    end;
  end;

  if (DMenuDlg.Visible) and (g_CursorMode = cr_Repair) then begin
    if Item.S.Name <> '' then begin
      if (g_SellDlgItemSellWait.Item.S.name = '') and ((sm_Arming in Item.s.StdModeEx) or (sm_HorseArm in Item.s.StdModeEx)) and
        (not (CheckItemBindMode(@Item.UserItem, bm_NoRepair))) and
        (Item.UserItem.Dura < Item.UserItem.DuraMax) then begin
        ItemClickSound(Item.S);
        g_SellDlgItemSellWait.Index2 := -(sel + 1);
        g_SellDlgItemSellWait.Item := Item;
        g_SellDlgItemSellWait.ItemType := mtStateItem;
        if (sel in [Low(g_UseItems)..High(g_UseItems)]) then begin
          g_UseItems[sel].S.name := '';
        end else
        if sel in [16..20] then begin
          if g_UseItems[U_HOUSE].S.Name <> '' then begin
            g_UseItems[U_HOUSE].UserItem.HorseItems[sel - 16].wIndex := 0;
          end;
        end;
        frmMain.SendRepairItem(g_nCurMerchant, g_SellDlgItemSellWait.Item.UserItem.MakeIndex, MakeWord(Integer(boSuperRepair), sel));
      end;
    end;
    exit;
  end;
  if g_boItemMoving then begin
    if Button = mbRight then exit;
    if g_MovingItem.ItemType = mtBagItem then begin
      if (g_MovingItem.Item.S.name = '') or (g_WaitingUseItem.Item.S.name <> '') then Exit;
      where := (Sender as TDButton).Tag;
      if (g_MovingItem.ItemType = mtBagItem) and (where in [0..20{MAXUSEITEMS - 1}]) then begin
        ItemClickSound(g_MovingItem.Item.S);
        g_WaitingUseItem := g_MovingItem;
        g_WaitingUseItem.Index2 := where;
        frmMain.SendTakeOnItem(where, g_MovingItem.Item.UserItem.MakeIndex, g_MovingItem.Item.S.name);
        ClearMovingItem();
      end;
    end
    else if g_MovingItem.ItemType = mtStateItem then begin
      where := -(g_MovingItem.Index2 + 1);
      if where in [0..MAXUSEITEMS - 1] then begin
        g_UseItems[where] := g_MovingItem.Item;
      end else
      if where in [16..20] then begin
        g_UseItems[U_HOUSE].UserItem.HorseItems[where - 16] := UserItemToHorseItem(@g_MovingItem.Item.UserItem);
      end;
      ClearMovingItem();
    end;
  end
  else if Button = mbRight then begin
    if (g_WaitingUseItem.Item.S.name <> '') then Exit;
    if Item.S.name <> '' then begin
      g_WaitingUseItem.Index2 := -(sel + 1);
      g_WaitingUseItem.Item := Item;
      g_WaitingUseItem.ItemType := mtBagItem;
      ItemClickSound(g_WaitingUseItem.Item.S);
      frmMain.SendTakeOffItem(sel, g_WaitingUseItem.Item.UserItem.MakeIndex, g_WaitingUseItem.Item.S.name);
      //g_UseItems[sel].S.name := '';
      if (sel in [Low(g_UseItems)..High(g_UseItems)]) then begin
        g_UseItems[sel].S.name := '';
      end else
      if sel in [16..20] then begin
        if g_UseItems[U_HOUSE].S.Name <> '' then begin
          g_UseItems[U_HOUSE].UserItem.HorseItems[sel - 16].wIndex := 0;
        end;
      end;
    end;
  end
  else begin
    if Item.S.name <> '' then begin
      g_boItemMoving := True;
      g_MovingItem.Index2 := -(sel + 1);
      g_MovingItem.Item := Item;
      g_MovingItem.ItemType := mtStateItem;
      //g_UseItems[sel].S.name := '';
      if (sel in [Low(g_UseItems)..High(g_UseItems)]) then begin
        g_UseItems[sel].S.name := '';
      end else
      if sel in [16..20] then begin
        if g_UseItems[U_HOUSE].S.Name <> '' then begin
          g_UseItems[U_HOUSE].UserItem.HorseItems[sel - 16].wIndex := 0;
        end;
      end;
      ItemClickSound(g_MovingItem.Item.S);
    end;
  end;
end;

procedure TFrmDlg.DTopDirectPaint(Sender: TObject;
  dsurface: TDXTexture);
var
  d: TDXTexture;
  ax, ay: integer;
  str: string;
  rc: TRect;
  i: integer;
  FontColor: TColor;
begin
  with Sender as TDWindow do begin
    ax := SurfaceX(Left);
    ay := SurfaceY(Top);
    d := WLib.Images[FaceIndex];
    if d <> nil then
      dsurface.Draw(ax, ay, d.ClientRect, d, True);
    if g_MySelf = nil then
      exit;

    if FrmMain.m_CurrentTick > AppendTick then begin
      AppendTick := FrmMain.m_CurrentTick + 2000;
      boNewEMail := False;
      for I := 0 to g_EMailList.Count - 1 do begin
        if not pTEMailInfo(g_EMailList.Objects[i]).ClientEMail.boRead then begin
          boNewEMail := True;
          break;
        end;
      end;
    end;

    d := WLib.Images[48 + g_MySelf.m_btJob + g_MySelf.m_btSex * 3];
    if d <> nil then
      dsurface.Draw(ax + 38, ay + 4, d.ClientRect, d, True);
    //HP
    d := g_WMain99Images.Images[3];
    if d <> nil then begin
      rc := d.ClientRect;
      rc.Right := _MIN(Round(rc.Right / (g_MySelf.m_Abil.MaxHP / g_MySelf.m_Abil.HP)), rc.Right);
      dsurface.Draw(ax + 252, ay + 14, rc, d, FALSE);
    end;
    //Mp
    d := g_WMain99Images.Images[4];
    if d <> nil then begin
      rc := d.ClientRect;
      rc.Right := _MIN(Round(rc.Right / (g_MySelf.m_Abil.MaxMP / g_MySelf.m_Abil.MP)), rc.Right);
      dsurface.Draw(ax + 86, ay + 14, rc, d, FALSE);
    end;
    //怒气值
    d := g_WMain99Images.Images[5];
    if d <> nil then begin
      rc := d.ClientRect;
      rc.Right := _MIN(Round(rc.Right / (10000 / g_nDander)), rc.Right);
      dsurface.Draw(ax + 468, ay + 14, rc, d, FALSE);
    end;
    //经验
    d := g_WMain99Images.Images[10];
    if d <> nil then begin
      rc := d.ClientRect;
      rc.Right := _MIN(Round(rc.Right / (g_MySelf.m_Abil.MaxExp / g_MySelf.m_Abil.Exp)), rc.Right);
      dsurface.Draw(ax + 99, ay + 2, rc, d, FALSE);
    end;

    with g_DXCanvas do begin
      //SetBkMode(Handle, TRANSPARENT);
      FontColor := clWhite;
      str := IntToStr(g_MySelf.m_Abil.Level);
      TextOut(ax + 56 - TextWidth(str) div 2, ay + 43, str, FontColor);
      TextOut(ax + 728 - TextWidth(g_sMapTitle) div 2, ay + 4, g_sMapTitle, FontColor);

      str := IntToStr(g_MySelf.m_Abil.HP) + '/' + IntToStr(g_MySelf.m_Abil.MaxHP);
      TextOut(ax + 352 - TextWidth(str) div 2, ay + 15, clWhite, str);

      str := IntToStr(g_MySelf.m_Abil.MP) + '/' + IntToStr(g_MySelf.m_Abil.MaxMP);
      TextOut(ax + 161 - TextWidth(str) div 2, ay + 13, clWhite, str);

      str := IntToStr(g_nDander) + '/10000';
      TextOut(ax + 543 - TextWidth(str) div 2, ay + 13, clWhite, str);

      str := Format('%.2f', [g_MySelf.m_Abil.Exp / g_MySelf.m_Abil.MaxExp * 100]) + ' %';
      TextOut(ax + 352 - TextWidth(str) div 2, ay - 1, clWhite, str);
      case g_nAreaStateValue of
        OT_SAFEAREA: begin
            FontColor := clLime;
            str := 'Safe';
          end;
        OT_SAFEPK: begin
            FontColor := clYellow;
            str := 'FreePK';
          end;
        OT_FREEPKAREA: begin
            FontColor := clFuchsia;
            str := 'War';
          end;
      else
        FontColor := clRed;
        str := 'Danger';
      end;
      TextOut(ax + 630, ay + 4, str, FontColor);
      //Release;
    end;
  end;
end;

procedure TFrmDlg.DTopEMailClick(Sender: TObject; X, Y: Integer);
begin
  FrmDlg2.DWinEmail.Visible := not FrmDlg2.DWinEmail.Visible;
end;

procedure TFrmDlg.DTopEMailDirectPaint(Sender: TObject; dsurface: TDXTexture);
var
  d: TDXTexture;
  idx: integer;
begin
if g_nInterface = 1 then begin
  with Sender as TDButton do begin
    if WLib <> nil then begin
      idx := 0;
      if Downed then begin
        inc(idx, 2)
      end
      else if (boNewEMail and ((FrmMain.m_CurrentTick - AppendTick) mod 600 > 300)) then begin
        Inc(idx, 1)
      end;
      d := WLib.Images[FaceIndex + idx];
      if d <> nil then
        dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, True);
    end;
  end;
end
else if g_nInterface = 2 then begin
  with Sender as TDButton do begin
    if WLib <> nil then begin
      idx := 0;
      if Downed then begin
        inc(idx, 1)
      end
      else if (MouseEntry = msIn) or (boNewEMail and ((FrmMain.m_CurrentTick - AppendTick) mod 600 > 300)) then begin
        Inc(idx, 2)
      end;
      d := WLib.Images[FaceIndex + idx];
      if d <> nil then
        dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, True);
    end;
  end;
 end;
end;

procedure TFrmDlg.DTopGMClick(Sender: TObject; X, Y: Integer);
begin
  exit;
  if g_WebInfo.g_GMUrl <> '' then begin
    FrmWEB.wb.UISettings.EnableScrollBars := False;
    FrmDLg2.OpenWeb(g_WebInfo.g_GMUrl + '?Name=' + FrmMain.CharName +
      '&ServerName=' +g_ServerInfo[g_ServerChoice].sName +
      '&Key=' + GetMD5Text(HTTPEncode(FrmMain.CharName + g_ServerInfo[g_ServerChoice].sName + IntToStr(HourOf(g_ServerDateTime)))) +
      '&t=' + IntToStr(FrmMain.m_CurrentTick), 508, 579);
    //FrmDLg2.OpenWeb(g_WebInfo.g_GMUrl, 508, 579);
  end;
  {FrmDLg2.OpenWeb('http://www.mir2k.com/advise/?Name=' + FrmMain.CharName +
    '&ServerName=' + g_sServerMiniName +
    '&Key=' + GetMD5Text(HTTPEncode(FrmMain.CharName+g_sServerMiniName+IntToStr(HourOf(g_ServerDateTime)))) +
    '&t=' + IntToStr(FrmMain.m_CurrentTick), 508, 579);  }
end;

procedure TFrmDlg.DTopGMMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
var
  ShowMsg: string;
begin
  with Sender as TDControl do begin
    X := SurfaceX(Left);
    y := SurfaceY(Top + (y - Top) + 30);
    ShowMsg := '';
    if Sender = DTopGM then begin
      ShowMsg := 'Contact a Gamemaster';
    end
    else if Sender = DTopHelp then begin
      ShowMsg := 'Help<(H)/FCOLOR=$FFFF>';
    end
    else if Sender = DTopEMail then begin
      ShowMsg := 'Mail<(E)/FCOLOR=$FFFF>';
    end
    //else if Sender = DItemBagRef then begin
    //  ShowMsg := 'Refresh Bag';
    //end
    else if Sender = DOpenMinmap then begin
      if g_boMiniMapClose then
        ShowMsg := 'Show Minimap'
      else
        ShowMsg := 'Hide Minimap';
    end
    else if Sender = DTopShop then begin
      ShowMsg := 'GameShop';
    end
    else if Sender = DButtonTop then begin
      ShowMsg := 'Ranking';
    end
    else if Sender = DMiniMapMax then begin
      ShowMsg := 'Big Minimap<(' + GetHookKeyStr(@g_CustomKey[DK_CHANGEMINMAP]) + ',M)/FCOLOR=$FFFF>';
    end
    else if Sender = DDRDealLock then begin
      if not DDRDealLock.Checked then
        ShowMsg := '<Unlocked/FCOLOR=$FF>\'
      else
        ShowMsg := '<Locked/FCOLOR=$FFFF>\';
      ShowMsg := 'Once locked both parties cannot add or remove items\' + ShowMsg;
     // ShowMsg := ShowMsg + 'Deal must be locked before completing\';
      ShowMsg := ShowMsg + '<Deal must be locked before completing!/FCOLOR=$FFFF>';
    end
    else if Sender = DDRDealOK then begin
      ShowMsg := 'Current status of Trade';
      if not DDRDealOK.Checked then
        ShowMsg := ShowMsg + ' <Not finalised/FCOLOR=$FF>\'
      else
        ShowMsg := ShowMsg + ' <Finalised/FCOLOR=$FFFF>\'
    end
    else if Sender = DDealOK then begin
      ShowMsg := '<Both parties must lock the transaction before completing/FCOLOR=$FFFF>';
    end
    else if Sender = DDealLock then begin
      ShowMsg := 'Once locked both parties cannot add or remove items\';
      ShowMsg := ShowMsg + '<Deal must be locked before completing!/FCOLOR=$FFFF>';
    end
    else if Sender = DGrpCheckGroup then begin
      ShowMsg := 'To join a group, you must accept invitiation\';
      ShowMsg := ShowMsg + '<You will be prompted to join group./FCOLOR=$FFFF>';
    end
    else if Sender = DCBGroupItemDef then begin
      ShowMsg := 'Group Members assigned Items.\';
      ShowMsg := ShowMsg + 'Items picked up will be go to finder.';
    end
    else if Sender = DCBGroupItemRam then begin
      ShowMsg := 'When Group Members are in same screen.\';
      ShowMsg := ShowMsg + 'Items found will randomly be assigned to group members.\';
      ShowMsg := ShowMsg + 'Gold will be shared with members equally';
    end
    else if Sender = DMenuReturn then begin
      ShowMsg := 'System prevents players to sell items by mistake.\';
      ShowMsg := ShowMsg + 'System allows players to repurchase items at any time.\';
      ShowMsg := ShowMsg + 'System temporarily saves last 3 items sold untill logout.\';
    end;
    if ShowMsg <> '' then
      DScreen.ShowHint(x, y, ShowMsg, clWhite, False, Integer(Sender));
  end;
end;

procedure TFrmDlg.DTopHelpClick(Sender: TObject; X, Y: Integer);
begin
  if FrmMain.m_CurrentTick > FHelpTick then begin
    FHelpTick := FrmMain.m_CurrentTick + 2000;
    frmMain.SendSay(g_Cmd_MemberFunctionEx);
  end;
end;

procedure TFrmDlg.DTopHelpDirectPaint(Sender: TObject; dsurface: TDXTexture);
var
  d: TDXTexture;
  idx: integer;
begin
  with Sender as TDButton do begin
    if WLib <> nil then begin
      idx := 0;
      if Downed then begin
        inc(idx, 2)
      end
      else if MouseEntry = msIn then begin
        Inc(idx, 1)
      end;
      d := WLib.Images[FaceIndex + idx];
      if d <> nil then
        dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, True);
    end;
  end;
end;

procedure TFrmDlg.DTopMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var
  ShowMsg: string;
begin
  with Sender as TDWindow do begin
    ShowMsg := '';
    if (x >= 38) and (x <= 38 + 34) and (y >= 4) and (y <= 4 + 36) then begin
      ShowMsg := 'Class:' + GetJobName(g_MySelf.m_btJob);
    end
    else if (x >= 38) and (x <= 38 + 34) and (y >= 40) and (y <= 40 + 18) then begin
      ShowMsg := 'Level:' + intToStr(g_MySelf.m_Abil.Level);
    end
    else if (x >= 97) and (x <= 97 + 510) and (y >= 0) and (y <= 0 + 10) then begin
      ShowMsg := 'Current Experience:' + GetGoldStr(g_MySelf.m_Abil.Exp) + '\';
      ShowMsg := ShowMsg + 'Required Experience:' + GetGoldStr(g_MySelf.m_Abil.MaxExp);
    end
    else if (x >= 184) and (x <= 184 + 154) and (y >= 10) and (y <= 10 + 16) then begin
      ShowMsg := 'Current Mana Points';
    end
    else if (x >= 348) and (x <= 348 + 208) and (y >= 10) and (y <= 10 + 21) then begin
      ShowMsg := 'Current Health Points';
    end
    else if (x >=565) and (x <= 565 + 155) and (y >= 10) and (y <= 10 + 21) then begin
      ShowMsg := 'Natural Growth\';
      ShowMsg := 'Current Growth points\';
      //ShowMsg := ShowMsg + ' ．角色建立后，首次登陆开始累积自然成长点数\';
      ShowMsg := ShowMsg + ' Growth points accumalate when players are online or offline.\';
      ShowMsg := ShowMsg + ' Growth accumalates every hour.\';
      //ShowMsg := ShowMsg + ' ．自然成长最多累计10000点，超过后不再累积成长点数\';
      ShowMsg := ShowMsg + ' Growth points can be converted to <Experience/FColor=$00FFFF>\';
    end
    else if (x >= 771) and (x <= 771 + 113) and (y >= 0) and (y <= 0 + 19) then begin
      ShowMsg := 'Current Location';
    end
    else if (x >= 724) and (x <= 724 + 47) and (y >= 0) and (y <= 0 + 19) then begin
      ShowMsg := '[<Safe Zone/FColor=$00FF00>]: Protected from Player Kills\';
      ShowMsg := ShowMsg +
        '[<Fight Zone/FColor=$00FFFF>]: Can freely fight without drop and PK penalty.\';
      ShowMsg := ShowMsg +
        '[<War Zone/FColor=$FF00FF>]: Probability of deaths drops, No PK penalty.\';
      ShowMsg := ShowMsg + '[<Danger Zone/FColor=$0000FF>]: Probability of death drops, PK penalty applies.\';
    end;
    if ShowMsg <> '' then begin
      y := y + 30;
      DScreen.ShowHint(x, y, ShowMsg, clWhite, False, x);
    end;
  end;
end;

procedure TFrmDlg.DTopShopClick(Sender: TObject; X, Y: Integer);
begin
  //FrmDlg2.DShopWin.Visible := True;
  FrmDlg2.ShopIndex := 4;
  FrmDlg2.ShopPage := 0;
  FrmDlg2.ShopSelectIdx := -1;
  FrmDlg2.ShopSelectIndex := -1;
  FrmDlg2.DShopWin.Visible := not FrmDlg2.DShopWin.Visible;
  if FrmDlg2.DShopWin.Visible then
    FrmMain.SendShopList(0, g_ShopLoading[0]);
end;

procedure TFrmDlg.DTopShopDirectPaint(Sender: TObject; dsurface: TDXTexture);
var
  d: TDXTexture;
  idx: integer;
  Rect: TRect;
begin
  with Sender as TDButton do begin
if g_nInterface = 1 then begin
    if WLib <> nil then begin
      if Downed then begin
        d := WLib.Images[FaceIndex];
        if d <> nil then
          dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, True);
     { end else begin
        idx := (FrmMain.m_CurrentTick - AppendTick) div 200 mod 50;
        if idx in [0..3] then begin
          d := g_WMain99Images.Images[2130 + idx];
          if d <> nil then begin
            dsurface.Draw(SurfaceX(Left) - 5, SurfaceY(Top) - 2, d.ClientRect, d, True);
          end;
        end; }
      end;
    end;
end
else if g_nInterface = 2 then begin
  if WLib <> nil then begin
      idx := 0;
      if Downed then begin
        inc(idx, 2)
      end
      else if MouseEntry = msIn then begin
        Inc(idx, 1)
      end;
      d := WLib.Images[FaceIndex + idx];
      if d <> nil then
        dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, True);
    end;
   end;
 end;
end;

procedure TFrmDlg.DTopStatusEXPDirectPaint(Sender: TObject; dsurface: TDXTexture);
var
  d: TDXTexture;
  ax, ay: integer;
  StatusInfo: pTStatusInfo;
  dwColor: LongWord;
begin
  with Sender as TDButton do begin
    FrmDlg.RefStatusInfoForm;
    d := WLib.Images[FaceIndex];
    ax := SurfaceX(Left);
    ay := SurfaceY(Top);
    if d <> nil then begin
      StatusInfo := pTStatusInfo(AppendData);
      if (StatusInfo <> nil) and (StatusInfo.dwTime < 10000) then begin
        Inc(AppendTick);
        if AppendTick > 50 then AppendTick := 0;
        if AppendTick > 25 then dwColor := (50 - AppendTick) * 10 and $FF shl 24 or $00FFFFFF
        else dwColor := (AppendTick * 10) and $FF shl 24 or $00FFFFFF;
        dsurface.Draw(ax, ay, d.ClientRect, d, dwColor, fxBlend);
      end else begin
      AppendTick := 26;
      dsurface.Draw(ax, ay, d.ClientRect, d, $FFFFFFFF, fxBlend);
      end;
    end;
  end;
end;

procedure TFrmDlg.DTopStatusEXPMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
var
  ShowMsg: string;
  StatusInfo: pTStatusInfo;
begin
  with Sender as TDControl do begin
    X := SurfaceX(Left);
    y := SurfaceY(Top);
    StatusInfo := pTStatusInfo(AppendData);
    if StatusInfo = nil then Exit;
    ShowMsg := '';
    case Tag of
      STATUS_EXP: begin
          ShowMsg := 'Increased Experience:<' + Format('%.2f', [StatusInfo.nPower / 100]) + '/FCOLOR=$FFFF> \Remaining Time: <' + IntToStr(StatusInfo.dwTime div 1000) + '/FCOLOR=$FFFF>Seconds';
        end;
      STATUS_POW: begin
          ShowMsg := 'Increased Power: x<' + Format('%.2f', [StatusInfo.nPower / 100]) + '/FCOLOR=$FFFF>\Remaining Time: <' + IntToStr(StatusInfo.dwTime div 1000) + '/FCOLOR=$FFFF> Seconds';
        end;
      STATUS_SC: begin
          if StatusInfo.nPower < 0 then
            ShowMsg := 'Decreased SC: - <' + IntToStr(-StatusInfo.nPower) + '/FCOLOR=$FF> Points\ Remaining Time: <' + IntToStr(StatusInfo.dwTime div 1000) + '/FCOLOR=$FFFF> Seconds'
          else
            ShowMsg := 'Increased SC: + <' + IntToStr(StatusInfo.nPower) + '/FCOLOR=$FFFF> Points\ Remaining Time: <' + IntToStr(StatusInfo.dwTime div 1000) + '/FCOLOR=$FFFF> Seconds';
        end;
      STATUS_AC: begin
          ShowMsg := 'Increased AC: <' + IntToStr(StatusInfo.nPower) + '/FCOLOR=$FFFF> Points\ Remaining Time: <' + IntToStr(StatusInfo.dwTime div 1000) + '/FCOLOR=$FFFF> Seconds';
        end;
      STATUS_DC: begin
          if StatusInfo.nPower < 0 then
            ShowMsg := 'Decreased DC: <' + IntToStr(-StatusInfo.nPower) + '/FCOLOR=$FF> Points\Remaining Time: <' + IntToStr(StatusInfo.dwTime div 1000) + '/FCOLOR=$FFFF> Seconds'
          else
            ShowMsg := 'Increased DC: <' + IntToStr(StatusInfo.nPower) + '/FCOLOR=$FFFF> Points\Remaining Time: <' + IntToStr(StatusInfo.dwTime div 1000) + '/FCOLOR=$FFFF> Seconds';
        end;
      STATUS_HIDEMODE: begin
          ShowMsg := '<Hiding/FCOLOR=$FFFF>\ Remaining Time: <' + IntToStr(StatusInfo.dwTime div 1000) + '/FCOLOR=$FFFF> Seconds';
        end;
      STATUS_STONE: begin
          ShowMsg := '<Paralysed/FCOLOR=$FFFF>\ Remaining Time: <' + IntToStr(StatusInfo.dwTime div 1000) + '/FCOLOR=$FFFF> Seconds';
        end;
      STATUS_MC: begin
          if StatusInfo.nPower < 0 then
            ShowMsg := 'Decreased MC: <' + IntToStr(-StatusInfo.nPower) + '/FCOLOR=$FF> Points\ Remaining Time: <' + IntToStr(StatusInfo.dwTime div 1000) + '/FCOLOR=$FFFF> Seconds'
          else
            ShowMsg := 'Increased MC: <' + IntToStr(StatusInfo.nPower) + '/FCOLOR=$FFFF> Points\ Remaining Time: <' + IntToStr(StatusInfo.dwTime div 1000) + '/FCOLOR=$FFFF> Seconds';
        end;
      STATUS_MP: begin
          ShowMsg := 'Increased Mana: <' + IntToStr(StatusInfo.nPower) + '/FCOLOR=$FFFF> Points\ Remaining Time: <' + IntToStr(StatusInfo.dwTime div 1000) + '/FCOLOR=$FFFF> Seconds';
        end;
      STATUS_MAC: begin
          ShowMsg := 'Increased MAC: <' + IntToStr(StatusInfo.nPower) + '/FCOLOR=$FFFF> Points\ Remaining Time: <' + IntToStr(StatusInfo.dwTime div 1000) + '/FCOLOR=$FFFF> Seconds';
        end;
      STATUS_HP: begin
          ShowMsg := 'Increased HP: <' + IntToStr(StatusInfo.nPower) + '/FCOLOR=$FFFF> Points\ Remaining Time: <' + IntToStr(StatusInfo.dwTime div 1000) + '/FCOLOR=$FFFF> Seconds';
        end;
      STATUS_DAMAGEARMOR: begin
          ShowMsg := '<Red Poisoned/FCOLOR=$FF00>\Vulnerable to <' + IntToStr(StatusInfo.nPower * 10 - 100) + ' %Damage/FCOLOR=$FFFF>\ Durability of items will decrease faster by<' + IntToStr(StatusInfo.nPower * 10 - 100) + '%/FCOLOR=$FFFF>\ Remaining Time: <' + IntToStr(StatusInfo.dwTime div 1000) + '/FCOLOR=$FFFF> Seconds';
        end;
      STATUS_DECHEALTH: begin
          ShowMsg := '<Green Poisoned/FCOLOR=$FF00>\Every <' + Format('%.1f', [HiWord(StatusInfo.nPower) / 1000]) + ' Seconds /FCOLOR=$FFFF> <' + IntToStr(LoWord(StatusInfo.nPower)) + 'Health is reduced/FCOLOR=$FFFF>\ Remaining Time: <' + IntToStr(StatusInfo.dwTime div 1000) + '/FCOLOR=$FFFF> Seconds';
        end;
      STATUS_COBWEB: begin
          ShowMsg := 'Stuck\Remaining Time: <' + IntToStr(StatusInfo.dwTime div 1000) + '/FCOLOR=$FFFF> Seconds';
        end;
      STATUS_SLOWDOWN: begin
        ShowMsg := 'Partially Frozen\Remaining Time: <' + IntToStr(StatusInfo.dwTime div 1000) + '/FCOLOR=$FFFF> Seconds';
      end;
      STATUS_FREEZE: begin
        ShowMsg := 'Completely Frozen\Remaining Time: <' + IntToStr(StatusInfo.dwTime div 1000) + '/FCOLOR=$FFFF> Seconds';
      end;
      STATUS_RAGE: begin
        ShowMsg := 'Increased DC: <' + IntToStr(StatusInfo.nPower) + '/FCOLOR=$FFFF> Points\Remaining Time: <' + IntToStr(StatusInfo.dwTime div 1000) + '/FCOLOR=$FFFF> Seconds';
      end;
      STATUS_MAGICBOOSTER: begin
        ShowMsg := 'Increased MC: <' + IntToStr(StatusInfo.nPower) + '/FCOLOR=$FFFF> Points\Remaining Time: <' + IntToStr(StatusInfo.dwTime div 1000) + '/FCOLOR=$FFFF> Seconds';
      end;
      STATUS_UE: begin
        case g_MySelf.m_btJob of
          0: ShowMsg := 'Increased DC: <' + IntToStr(HiWord(StatusInfo.nPower)) + '-' + IntToStr(LoWord(StatusInfo.nPower)) + '/FCOLOR=$FFFF> Points\Remaining Time: <' + IntToStr(StatusInfo.dwTime div 1000) + '/FCOLOR=$FFFF> Seconds';
          1: ShowMsg := 'Increased MC: <' + IntToStr(HiWord(StatusInfo.nPower)) + '-' + IntToStr(LoWord(StatusInfo.nPower)) + '/FCOLOR=$FFFF> Points\Remaining Time: <' + IntToStr(StatusInfo.dwTime div 1000) + '/FCOLOR=$FFFF> Seconds';
          2: ShowMsg := 'Increased SC: <' + IntToStr(HiWord(StatusInfo.nPower)) + '-' + IntToStr(LoWord(StatusInfo.nPower)) + '/FCOLOR=$FFFF> Points\Remaining Time: <' + IntToStr(StatusInfo.dwTime div 1000) + '/FCOLOR=$FFFF> Seconds';
        end;
      end;
      STATUS_CURSE: begin
        ShowMsg := 'Cursed\Decreased DC,MC,SC: <' + IntToStr(StatusInfo.nPower) + '/FCOLOR=$FF> %\Remaining Time: <' + IntToStr(StatusInfo.dwTime div 1000) + '/FCOLOR=$FFFF> Seconds';
      end;
      STATUS_STUN: begin
        ShowMsg := 'Stunned\Remaining Time: <' + IntToStr(StatusInfo.dwTime div 1000) + '/FCOLOR=$FFFF> Seconds';
      end;
      STATUS_PROFIELD: begin
        ShowMsg := 'Increased AC: <' + IntToStr(StatusInfo.nPower) + '/FCOLOR=$FFFF> Points\Remaining Time: <' + IntToStr(StatusInfo.dwTime div 1000) + '/FCOLOR=$FFFF> Seconds';
      end;
    end;
    if ShowMsg <> '' then
     if g_nInterface = 1 then begin
      case g_nViewMinMapLv of
       0,1:
        begin
         DScreen.ShowHint(x, y + 25, ShowMsg, clWhite, False, Integer(Sender));
        end;
       2:
        begin
         DScreen.ShowHint(x, y + 25, ShowMsg, clWhite, False, Integer(Sender));
        end;
      end;
    end 
   else if g_nInterface = 2 then begin
       case g_nViewMinMapLv of
       0,1:
        begin
         DScreen.ShowHint(x, y + 25, ShowMsg, clWhite, False, Integer(Sender));
        end;
       2:
        begin
         DScreen.ShowHint(x, y + 25, ShowMsg, clWhite, False, Integer(Sender));
        end;
      end;
   end;
  end;
end;

procedure TFrmDlg.DUserKeyGrid1GridMouseMove(Sender: TObject; X, Y, ACol, ARow: Integer; Shift: TShiftState);
var
  idx, nMagID: Integer;
  Item: TNewClientItem;
begin
  with Sender as TDGrid do begin
    idx := ACol + ARow * ColCount + Tag * 12;
    if idx in [Low(g_UserKeySetup)..High(g_UserKeySetup)] then begin
      m_nMouseIdx := idx;
      if g_UserKeySetup[idx].btType = UKTYPE_ITEM then begin
        Item.s := GetStdItem(g_UserKeySetup[idx].wIndex, g_Myself.m_Abil.Level, g_Myself.m_btJob);
        if Item.s.name <> '' then begin
          SafeFillChar(Item.UserItem, SizeOf(Item.UserItem), #0);
          Item.UserItem.wIndex := Item.s.Idx + 1;
          Item.UserItem.Dura := 1;
          if Item.s.StdMode2 = 2 then
            Item.UserItem.Dura := g_UserKeyIndex[idx];

          Item.UserItem.DuraMax := Item.s.DuraMax;
          DScreen.ShowHint(SurfaceX(X), SurfaceY(Y),
            ShowItemInfo(Item, [mis_bottom], []), clwhite, True, idx, True);
        end;
      end
      else if g_UserKeySetup[idx].btType = UKTYPE_MAGIC then begin
        nMagID := g_UserKeySetup[idx].wIndex;
        if nMagID in [Low(g_MyMagicArry)..High(g_MyMagicArry)] then begin
          if g_MyMagicArry[nMagID].boStudy then begin
            DScreen.ShowHint(SurfaceX(X), SurfaceY(Y),
              ShowMagicInfo(@g_MyMagicArry[nMagID]), clwhite, True, idx, True);
          end;
        end;
      end;
    end;
  end;
end;

procedure TFrmDlg.DUserKeyGrid1GridPaint(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState;
  dsurface: TDXTexture);
var
  idx, nMagID, ax, ay: Integer;
  d: TDXTexture;
  NewClientItem: TNewClientItem;
  showstr: string;
  PaintMode: TItemPaintMode;
  boUse: Boolean;
begin
  with Sender as TDGrid do begin
    idx := ACol + ARow * ColCount + Tag * 12;
    if idx in [Low(g_UserKeySetup)..High(g_UserKeySetup)] then begin
      if g_UserKeySetup[idx].btType = UKTYPE_ITEM then begin
        nMagID := GetStditemLook(g_UserKeySetup[idx].wIndex);
        d := GetBagItemImg(nMagID);
        if d <> nil then begin
          PaintMode := [];
          if g_UserKeyIndex[idx] <= 0 then
            PaintMode := [pmBlend];

          NewClientItem.s := GetStdItem(g_UserKeySetup[idx].wIndex, g_Myself.m_Abil.Level, g_Myself.m_btJob);
          RefItemPaint(dsurface, d, //人物背包栏
            SurfaceX(Rect.Left + (ColWidth - d.Width) div 2),
            SurfaceY(Rect.Top + (RowHeight - d.Height) div 2),
            SurfaceX(Rect.Right),
            SurfaceY(Rect.Bottom) - 12,
            @NewClientItem, False, PaintMode);
          with g_DXCanvas do begin
            //SetBkMode(Handle, TRANSPARENT);
            showstr := IntToStr(g_UserKeyIndex[idx]);
            //Font.Color := clWhite;
            TextOut(SurfaceX(Rect.Right - 2) - TextWidth(showstr), SurfaceY(Rect.Bottom) - 12, showstr, clWhite);
            //BoldTextOutEx(dsurface, SurfaceX(Rect.Right) - TextWidth(showstr), SurfaceY(Rect.Bottom) - 12, clwhite, clBlack, showstr);
            //Release;
          end;
        end;

      end
      else if g_UserKeySetup[idx].btType = UKTYPE_MAGIC then begin
        nMagID := g_UserKeySetup[idx].wIndex;
        if nMagID in [Low(g_MyMagicArry)..High(g_MyMagicArry)] then begin
          if g_MyMagicArry[nMagID].boStudy then begin
            d := g_WMagIconImages.Images[g_MyMagicArry[nMagID].Def.Magic.wMagicIcon];
            if d <> nil then begin
 
              boUse := ((FrmMain.m_CurrentTick - g_dwLatestSpellTick) < g_dwMagicDelayTime);
              if g_MyMagicArry[nMagID].boNotUse then begin
                dsurface.Draw(SurfaceX(Rect.Left + (ColWidth - d.Width) div 2),
                  SurfaceY(Rect.Top + (RowHeight - d.Height) div 2), d.ClientRect, d, $80808080, fxBlend);
              end
              else if g_MyMagicArry[nMagID].dwInterval > FrmMain.m_CurrentTick then begin
                dsurface.Draw(SurfaceX(Rect.Left + (ColWidth - d.Width) div 2),
                  SurfaceY(Rect.Top + (RowHeight - d.Height) div 2), d.ClientRect, d, $60808080, fxBlend);
                g_DXCanvas.DrawSquareSchedule(
                  100 - Round(100 / (g_MyMagicArry[nMagID].Def.Magic.nInterval / (g_MyMagicArry[nMagID].dwInterval - FrmMain.m_CurrentTick))),
                  SurfaceX(Rect.Left + (ColWidth - d.Width) div 2),
                  SurfaceY(Rect.Top + (RowHeight - d.Height) div 2),
                  d.ClientRect, d,
                  $FFFFFFFF, fxNone);
              end
              else begin
                dsurface.Draw(SurfaceX(Rect.Left + (ColWidth - d.Width) div 2),
                  SurfaceY(Rect.Top + (RowHeight - d.Height) div 2), d.ClientRect, d, False);

                if g_MyMagicArry[nMagID].boUse and not boUse and not g_boLatestSpell then begin
                  if (g_MyMagicArry[nMagID].btEffIdx < 9) then begin
                    if (FrmMain.m_CurrentTick > g_MyMagicArry[nMagID].dwTime) then begin
                      g_MyMagicArry[nMagID].dwTime := FrmMain.m_CurrentTick + 80;
                      Inc(g_MyMagicArry[nMagID].btEffIdx);
                    end;
                    d := g_WMain99Images.GetCachedImage(FLASHBASE + g_MyMagicArry[nMagID].btEffIdx, ax, ay);
                    if d <> nil then begin
                      dsurface.Draw(SurfaceX(Rect.Left + ax - 5),
                        SurfaceY(Rect.Top + ay - 12), d.ClientRect, d, fxAnti);
                    end;
                  end
                  else
                    g_MyMagicArry[nMagID].boUse := False;
                end;
              end;

              if g_boLatestSpell then begin
                g_DXCanvas.FillSquareSchedule(
                  0,
                  SurfaceX(Rect.Left + 2), SurfaceY(Rect.Top + 2), SurfaceX(Rect.Right - 2), SurfaceY(Rect.Bottom - 2),
                  $800000FF, fxBlend);
              end
              else if boUse then begin
                g_DXCanvas.FillSquareSchedule(
                  Round(100 / (g_dwMagicDelayTime / (FrmMain.m_CurrentTick - g_dwLatestSpellTick))),
                  SurfaceX(Rect.Left + 2), SurfaceY(Rect.Top + 2), SurfaceX(Rect.Right - 2), SurfaceY(Rect.Bottom - 2),
                  $800000FF, fxBlend);
              end; // else
            end;
          end;
        end;
      end;
    end;
  end;
end;

procedure TFrmDlg.DUserKeyGrid1GridRightSelect(Sender: TObject; X, Y, ACol,
  ARow: Integer; Shift: TShiftState);
var
  idx, nIndex,nItemID: Integer;
begin
  with Sender as TDGrid do begin
    idx := ACol + ARow * ColCount + Tag * 12;
    if idx in [Low(g_UserKeySetup)..High(g_UserKeySetup)] then begin
      if UserKeyInfoIsValid(idx, nIndex) then begin
        nItemID := GetBagItemIdx(g_UserKeySetup[idx].wIndex);
        if nItemID <> -1 then begin
          FrmMain.EatItem(nItemID);
        end;
      end;
    end;
  end;
end;

procedure TFrmDlg.DUserKeyGrid1GridSelect(Sender: TObject; X, Y, ACol, ARow: Integer; Shift: TShiftState);
  procedure ClearUserKeyType(btType: Byte; nIdx: Integer);
  var
    i: integer;
  begin
    for i := Low(g_UserKeySetup) to High(g_UserKeySetup) do begin
      if (g_UserKeySetup[i].btType = btType) and (g_UserKeySetup[i].wIndex = nIdx) then begin
        g_UserKeySetup[i].btType := 0;
        g_UserKeySetup[i].wIndex := 0;
      end;
    end;
  end;
var
  idx, nIndex: Integer;
  OldIdx: Integer;
  OldType: Byte;
  boValid: Boolean;
  boSend: Boolean;
  Item: TNewClientItem;
begin
  //if (FrmMain.m_CurrentTick - m_dwDblClick) < 500 then
  //  Exit;
  boSend := False;
  with Sender as TDGrid do begin
    idx := ACol + ARow * ColCount + Tag * 12;
    if idx in [Low(g_UserKeySetup)..High(g_UserKeySetup)] then begin
      if g_boItemMoving then begin
        OldIdx := -1;
        OldType := 0;
        boValid := UserKeyInfoIsValid(idx, nIndex);
        if boValid then begin
          OldType := g_UserKeySetup[idx].btType;
          OldIdx := g_UserKeySetup[idx].wIndex;
        end;
        if g_MovingItem.ItemType = mtStateMagic then begin
          ClearUserKeyType(UKTYPE_MAGIC, LoWord(g_MovingItem.Index2));
          g_UserKeySetup[idx].btType := UKTYPE_MAGIC;
          g_UserKeySetup[idx].wIndex := LoWord(g_MovingItem.Index2);
          g_boItemMoving := False;
          boSend := True;
        end
        else if g_MovingItem.ItemType = mtBagItem then begin
          if (g_MovingItem.Item.s.Name <> '') and IsUserKeyItem(@g_MovingItem.item.s) then begin
            ClearUserKeyType(UKTYPE_ITEM, g_MovingItem.item.s.Idx + 1);
            g_UserKeySetup[idx].btType := UKTYPE_ITEM;
            g_UserKeySetup[idx].wIndex := g_MovingItem.item.s.Idx + 1;
            AdditemBag(g_MovingItem.item, g_MovingItem.Index2);
            RefUserKeyItemInfo(@g_MovingItem.item);
            ClearMovingItem();

            boSend := True;
          end;
        end
        else if g_MovingItem.ItemType = mtBottom then begin
          g_UserKeySetup[idx].btType := LoWord(g_MovingItem.Index2);
          g_UserKeySetup[idx].wIndex := HiWord(g_MovingItem.Index2);
          if g_UserKeySetup[idx].btType = UKTYPE_ITEM then begin
            Item.s := GetStdItem(g_UserKeySetup[idx].wIndex, g_Myself.m_Abil.Level, g_Myself.m_btJob);
            Item.UserItem.wIndex := g_UserKeySetup[idx].wIndex;
            RefUserKeyItemInfo(@Item);
          end;
          g_boItemMoving := False;
          boSend := True;
        end;
        if boValid and (OldType > 0) and (not g_boItemMoving) and
          ((g_UserKeySetup[idx].btType <> OldType) or (g_UserKeySetup[idx].wIndex <> OldIdx)) then begin
          g_boItemMoving := True;
          g_MovingItem.ItemType := mtBottom;
          g_MovingItem.Item.s := GetStdItem(OldIdx, g_Myself.m_Abil.Level, g_Myself.m_btJob);
          g_MovingItem.Item.s.Looks := nIndex;
          g_MovingItem.Index2 := MakeLong(OldType, OldIdx);
          g_MovingItem.Origin := idx;
          boSend := True;
        end;
      end
      else begin
        if UserKeyInfoIsValid(idx, nIndex) then begin
          g_boItemMoving := True;
          g_MovingItem.ItemType := mtBottom;
          g_MovingItem.Item.s := GetStdItem(g_UserKeySetup[idx].wIndex, g_Myself.m_Abil.Level, g_Myself.m_btJob);
          g_MovingItem.Item.s.Looks := nIndex;
          g_MovingItem.Index2 := MakeLong(g_UserKeySetup[Idx].btType, g_UserKeySetup[idx].wIndex);
          g_MovingItem.Origin := idx;
          g_UserKeySetup[idx].btType := 0;
          g_UserKeySetup[idx].wIndex := 0;
          boSend := True;
        end;
      end;
      if boSend then
        FrmMain.SendClientSocket(CM_USERKEYSETUP, 0, 0, 0, 0, EncodeBuffer(@g_UserKeySetup, SizeOf(g_UserKeySetup)));
    end;
  end;
end;

procedure TFrmDlg.DUserKeyGrid2DblClick(Sender: TObject);
var
  idx, nItemID: Integer;
begin
  //m_dwDblClick := FrmMain.m_CurrentTick;
  if g_boItemMoving and (g_MovingItem.Item.S.name <> '') and (g_MovingItem.ItemType = mtBottom) and (sm_Eat in g_MovingItem.Item.S.StdModeEx) then
  begin
    //DScreen.AddSysMsg('[' + GetStditem(g_UserKeySetup[idx].wIndex).Name + ' 已经用完]', clYellow);
    idx := GetBagItemIdx(HiWord(g_MovingItem.Index2));
    if idx <> -1 then begin
      frmMain.EatItem(idx)
    end else begin
      if FrmMain.m_CurrentTick > FrmMain.FShowHintTick2 then begin
        FrmMain.FShowHintTick2 := FrmMain.m_CurrentTick + 2000;
        DScreen.AddSysMsg('[' + g_MovingItem.Item.s.Name + ' has been used..', clYellow);
      end;
    end;
    //g_UserKeySetup[g_MovingItem.Origin].btType := LoWord(g_MovingItem.Index2);
    //g_UserKeySetup[g_MovingItem.Origin].wIndex := HiWord(g_MovingItem.Index2);
    //ClearMovingItem();
//    frmMain.EatItem(-1);
    exit;
  end;

  with Sender as TDGrid do begin
    idx := m_nMouseIdx;
    if idx in [Low(g_UserKeySetup)..High(g_UserKeySetup)] then begin
      if g_UserKeySetup[idx].btType = UKTYPE_ITEM then begin
        nItemID := GetBagItemIdx(g_UserKeySetup[idx].wIndex);
        if nItemID <> -1 then
          FrmMain.EatItem(nItemID)
        else
          DScreen.AddSysMsg('[' + GetStditem(g_UserKeySetup[idx].wIndex, g_Myself.m_Abil.Level, g_Myself.m_btJob).Name + ' Has been depleted]', clYellow);
      end;
    end;
  end;
end;

function TFrmDlg.UserKeyInfoIsValid(nIdx: Byte; var nIndex: Integer): Boolean;
var
  nMagID: Integer;
begin
  Result := False;
  if g_UserKeySetup[nIdx].btType = UKTYPE_ITEM then begin
    nMagID := GetStditemLook(g_UserKeySetup[nIdx].wIndex);
    if nMagID > 0 then begin
      nIndex := nMagID;
      Result := True;
    end;
  end
  else if g_UserKeySetup[nIdx].btType = UKTYPE_MAGIC then begin
    nMagID := g_UserKeySetup[nIdx].wIndex;
    if nMagID in [Low(g_MyMagicArry)..High(g_MyMagicArry)] then begin
      if g_MyMagicArry[nMagID].boStudy then begin
        Result := True;
        nIndex := g_MyMagicArry[nMagID].Def.Magic.wMagicIcon;
      end;
    end;
  end;
end;

procedure TFrmDlg.DUserStateBTInfoDirectPaint(Sender: TObject; dsurface: TDXTexture);
var
  d: TDXTexture;
  nTop: Byte;
begin
  with Sender as TDButton do begin
    if WLib <> nil then begin
      nTop := 0;
      if UserStatePage = tag then begin
        d := WLib.Images[FaceIndex];
      end else begin
        d := WLib.Images[FaceIndex + 1];
        nTop := 2;
      end;

      if d <> nil then
        dsurface.Draw(SurfaceX(Left), SurfaceY(Top) + nTop, d.ClientRect, d, True);
    end;
  end;
end;

procedure TFrmDlg.DUserStateBTItemClick(Sender: TObject; X, Y: Integer);
begin
  with Sender as TDButton do begin
    if UserStatePage <> Tag then begin
      UserStatePage := Tag;
      UserPageChanged;
      PlaySound(s_glass_button_click);
    end;
  end;
end;

procedure TFrmDlg.DUserStateDirectPaint(Sender: TObject; dsurface: TDXTexture);
var
  d: TDXTexture;
  ax, ay: integer;
begin
  if g_MySelf = nil then
    exit;

  with Sender as TDWindow do begin
    ax := SurfaceX(Left);
    ay := SurfaceY(Top);
    d := WLib.Images[FaceIndex];
    if d <> nil then begin
      DrawWindow(DSurface, ax, ay, d);
      d := WLib.Images[1776 + UserStatePage];
      if d <> nil then
        DrawWindow(DSurface, ax + 16, ay + 90, d);
    end;
    with g_DXCanvas do begin
        TextOut(ax + Width div 2 - TextWidth(UserState1.UserName) div 2, ay + 17, $B1D2B7, UserState1.UserName);
    end;
  end;
end;

procedure TFrmDlg.DUserStateItemClick(Sender: TObject; X, Y: Integer);
begin
  if boSelectGuildName then begin
    PlayScene.SetEditChar(UserState1.GuildName);
  end
  else if boSelectGuildRankName then begin
    PlayScene.SetEditChar(UserState1.GuildRankName);
  end;
end;

procedure TFrmDlg.DUserStateItemDirectPaint(Sender: TObject; dsurface: TDXTexture);
const
  nWidth = 100;
  nHeight = 120;
var
  d: TDXTexture;
  ax, ay, bbx, bby, idx: integer;
  Rect: TRect;
  FontColor: TColor;
  AddAbility: TAddAbility;
  I: Integer;
  StdItem: TStdItem;
  str: string;
begin
  with Sender as TDWindow do begin
    ax := SurfaceX(Left) - Left;
    ay := SurfaceY(Top) - Top;
    if Sender = DUserStateItem then begin
      d := g_WMain99Images.Images[236 + Integer((DRESSfeature(UserState1.Feature) mod 2) = 1)];
      if d <> nil then
        dsurface.Draw(ax + 100, ay + 146, d.ClientRect, d, True);

      bbx := left + 37;
      bby := Top + 55;

      if UserState1.UseItems[U_DRESS].S.name <> '' then begin
        idx := UserState1.UseItems[U_DRESS].S.looks;
        if idx >= 0 then begin
          d := GetStateItemImgXY(idx, ax, ay);
          if d <> nil then
            dsurface.Draw(SurfaceX(bbx + ax), SurfaceY(bby + ay), d.ClientRect, d, True);

          if UserState1.UseItems[U_DRESS].S.AniCount = 29 then begin
            d := GetStateItemImgXY(2425, ax, ay);
            if d <> nil then
              DrawBlend(dsurface, SurfaceX(bbx + ax), SurfaceY(bby + ay), d, 1);
          end
          else if UserState1.UseItems[U_DRESS].S.AniCount = 30 then begin
            d := GetStateItemImgXY(2426, ax, ay);
            if d <> nil then
              DrawBlend(dsurface, SurfaceX(bbx + ax), SurfaceY(bby + ay), d, 1);
          end
          else if UserState1.UseItems[U_DRESS].S.AniCount = 33 then begin
            d := GetStateItemImgXY(2541, ax, ay);
            if d <> nil then
              DrawBlend(dsurface, SurfaceX(bbx + ax), SurfaceY(bby + ay), d, 1);
          end
          else if UserState1.UseItems[U_DRESS].S.AniCount = 34 then begin
            d := GetStateItemImgXY(2543, ax, ay);
            if d <> nil then
              DrawBlend(dsurface, SurfaceX(bbx + ax), SurfaceY(bby + ay), d, 1);
          end;
        end;
      end;

      idx := HUMHAIRANFRAME * (HAIRfeature(UserState1.Feature) + 1) - 1;
      if idx > 0 then begin
        d := g_WHairImgImages.GetCachedImage(idx, ax, ay);
        if d <> nil then
          dsurface.Draw(SurfaceX(bbx + ax), SurfaceY(bby + ay), d.ClientRect, d, True);
      end;

      if UserState1.UseItems[U_WEAPON].S.name <> '' then begin
        idx := UserState1.UseItems[U_WEAPON].S.looks;
        if idx >= 0 then begin
          d := GetStateItemImgXY(idx, ax, ay);
          if d <> nil then
            dsurface.Draw(SurfaceX(bbx + ax), SurfaceY(bby + ay), d.ClientRect, d, True);

          if UserState1.UseItems[U_WEAPON].S.AniCount = 21 then begin
            d := g_WMain99Images.GetCachedImage(1438, ax, ay);
            if d <> nil then
              DrawBlend(dsurface, SurfaceX(bbx + ax), SurfaceY(bby + ay), d, 1);
          end
          else if UserState1.UseItems[U_WEAPON].S.AniCount = 23 then begin
            d := GetStateItemImgXY(1890 + Integer((FrmMain.m_CurrentTick - AppendTick) div 200 mod 10), ax, ay);
            if d <> nil then
              DrawBlend(dsurface, SurfaceX(bbx + ax), SurfaceY(bby + ay), d, 1);
          end
          else if UserState1.UseItems[U_WEAPON].S.AniCount = 31 then begin
            d := GetStateItemImgXY(2427, ax, ay);
            if d <> nil then
              DrawBlend(dsurface, SurfaceX(bbx + ax), SurfaceY(bby + ay), d, 1);
          end
          else if UserState1.UseItems[U_WEAPON].S.AniCount = 35 then begin
            d := GetStateItemImgXY(2530 + Integer((FrmMain.m_CurrentTick - AppendTick) div 200 mod 8), ax, ay);
            if d <> nil then
              DrawBlend(dsurface, SurfaceX(bbx + ax), SurfaceY(bby + ay), d, 1);
          end
          else if UserState1.UseItems[U_WEAPON].S.AniCount = 37 then begin
            d := GetStateItemImgXY(2550 + Integer((FrmMain.m_CurrentTick - AppendTick) div 200 mod 10), ax, ay);
            if d <> nil then
              DrawBlend(dsurface, SurfaceX(bbx + ax), SurfaceY(bby + ay), d, 1);
          end
          else if UserState1.UseItems[U_WEAPON].S.AniCount = 39 then begin
            d := GetStateItemImgXY(2560 + Integer((FrmMain.m_CurrentTick - AppendTick) div 200 mod 10), ax, ay);
            if d <> nil then
              DrawBlend(dsurface, SurfaceX(bbx + ax), SurfaceY(bby + ay), d, 1);
          end;
        end;
      end;
      if not UserState1.boHideHelmet then begin
        if UserState1.UseItems[U_HELMET].S.name <> '' then begin
          idx := UserState1.UseItems[U_HELMET].S.looks;
          if idx >= 0 then begin
            d := GetStateItemImgXY(idx, ax, ay);
            if d <> nil then
              dsurface.Draw(SurfaceX(bbx + ax), SurfaceY(bby + ay), d.ClientRect, d, True);
          end;
        end;
      end;
      //      bbx := Left  + 233;
      //      bby := Top  + 3;
            {idx := (FrmMain.m_CurrentTick - AppendTick) div 150 mod 10;
            d := g_WMain99Images.GetCachedImage(534 + (UserState1.btWuXinLevel * 20) + idx, ax, ay);
            if d <> nil then
              DrawBlend(dsurface, SurfaceX(bbx + ax), SurfaceY(bby + ay), d, 1);  }

      with g_DXCanvas do begin
        if (MouseEntry = msin) and (boSelectGuildName) then
          FontColor := clSilver
        else
          FontColor := clWhite;
        TextOut(SurfaceX(Left) + 2, SurfaceY(Top) + 2, UserState1.GuildName, FontColor);
        nUS1GuildNameLen := TextWidth(UserState1.GuildName);
        if (MouseEntry = msin) and (boSelectGuildRankName) then
          FontColor := clSilver
        else
          FontColor := clWhite;
        TextOut(SurfaceX(Left) + 2, SurfaceY(Top) + 16, UserState1.GuildRankName, FontColor);
        nUS1GuildRankNameLen := TextWidth(UserState1.GuildRankName);
      end;
    end
    else if Sender = DUserStateInfo then begin
      if UserHDInfoSurface <> nil then begin
        DUserStateInfoRefPic.Enabled := False;
        DUserStateInforeport.Enabled := True;
        Rect.Left := 0;
        ax := ax + Left + 16;
        aY := aY + Top + 7;
        if UserHDInfoSurface.Width < nWidth then begin
          ax := ax + (nWidth - UserHDInfoSurface.Width) div 2;
          Rect.Right := UserHDInfoSurface.Width;
        end
        else begin
          Rect.Right := nWidth;
        end;
        Rect.Top := 0;
        if UserHDInfoSurface.Height < nHeight then begin
          aY := aY + (nHeight - UserHDInfoSurface.Height) div 2;
          Rect.Bottom := UserHDInfoSurface.Height;
        end
        else begin
          Rect.Bottom := nHeight;
        end;
        dsurface.Draw(aX, aY, Rect, UserHDInfoSurface, False);
      end
      else begin
        DUserStateInforeport.Enabled := False;
        d := g_WMain99Images.Images[252 + Integer(UserState1.RealityInfo.sPhotoID <> '')];
        if d <> nil then
          dsurface.Draw(ax + Left + 16, ay + Top + 7, d.ClientRect, d, True);
        if Length(UserState1.RealityInfo.sPhotoID) = (SizeOf(UserState1.RealityInfo.sPhotoID) - 1) then
          DUserStateInfoRefPic.Enabled := True
        else
          DUserStateInfoRefPic.Enabled := False;
      end;
    end else
    if Sender = DUserStateHorse then begin
      with g_DXCanvas do begin
        if UserState1.UseItems[U_HOUSE].S.name <> '' then begin
          GetHorseLevelAbility(@UserState1.UseItems[U_HOUSE].UserItem, @UserState1.UseItems[U_HOUSE].S, AddAbility);
          for I := Low(UserState1.UseItems[U_HOUSE].UserItem.HorseItems) to High(UserState1.UseItems[U_HOUSE].UserItem.HorseItems) do begin
            if UserState1.UseItems[U_HOUSE].UserItem.HorseItems[I].wIndex > 0 then begin
              StdItem := GetStditem(UserState1.UseItems[U_HOUSE].UserItem.HorseItems[I].wIndex, g_Myself.m_Abil.Level, g_Myself.m_btJob);
              if StdItem.Name <> '' then
                GetHorseAddAbility(@UserState1.UseItems[U_HOUSE].UserItem, @StdItem, I, AddAbility);
            end;
          end;

          d := g_WMain99Images.Images[1775];
          if d <> nil then begin
            Rect := d.ClientRect;
            Rect.Right := _MIN(Round(Rect.Right / (UserState1.UseItems[U_HOUSE].UserItem.dwMaxExp / UserState1.UseItems[U_HOUSE].UserItem.dwExp)), rect.Right);
            dsurface.Draw(ax + 68, ay + 129, Rect, d, True);
          end;

          d := g_WMain99Images.Images[1774];
          if d <> nil then begin
            Rect := d.ClientRect;
            Rect.Right := _MIN(Round(Rect.Right / (AddAbility.HP / UserState1.UseItems[U_HOUSE].UserItem.wHP)), rect.Right);
            dsurface.Draw(ax + 68, ay + 115, Rect, d, True);
          end;

          TextOut(ax + 66, ay + 97, $FFFFFF, IntToStr(UserState1.UseItems[U_HOUSE].UserItem.btLevel));

          if UserState1.UseItems[U_HOUSE].UserItem.btAliveTime > 0 then begin
            TextOut(ax + 132, ay + 97, $C0C0C0, 'Has Died ' + IntToStr(UserState1.UseItems[U_HOUSE].UserItem.btAliveTime) + ' seconds after resurrection.');
          end else begin
            TextOut(ax + 132, ay + 97, $00FF00, 'Normal');
          end;

          str := IntToStr(UserState1.UseItems[U_HOUSE].UserItem.wHP) + '/' + IntToStr(AddAbility.HP);
          TextOut(ax + 153 - TextWidth(str) div 2, ay + 112, $FFFFFF, str);

          str := IntToStr(UserState1.UseItems[U_HOUSE].UserItem.dwExp) + '/' + IntToStr(UserState1.UseItems[U_HOUSE].UserItem.dwMaxExp);
          TextOut(ax + 153 - TextWidth(str) div 2, ay + 126, $FFFFFF, str);

          TextOut(ax + 88, ay + 300, $FFFFFF, IntToStr(AddAbility.AC) + '-' + IntToStr(AddAbility.AC2));
          TextOut(ax + 88, ay + 314, $FFFFFF, IntToStr(AddAbility.MAC) + '-' + IntToStr(AddAbility.MAC2));
          TextOut(ax + 88, ay + 328, $FFFFFF, IntToStr(AddAbility.DC) + '-' + IntToStr(AddAbility.DC2));
          TextOut(ax + 206, ay + 300, $FFFFFF, IntToStr(AddAbility.wHitPoint));
          TextOut(ax + 206, ay + 314, $FFFFFF, IntToStr(AddAbility.wSpeedPoint));

          d := g_WRideImages.GetCachedImage(RIDEFRAME * (UserState1.UseItems[U_HOUSE].S.Shape - 1) + 80 + Integer((FrmMain.m_CurrentTick - AppendTick) div 120 mod 8), bbx, bby);
          if d <> nil then
            dsurface.Draw(aX + bbx + 130, aY + bby + 205, d.ClientRect, d, True);
        end;
      end;
    end;
  end;
end;

procedure TFrmDlg.DUserStateItemMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
  StateAbilIndex := -1;
  if Sender = DUserStateItem then begin
    boSelectGuildName := False;
    boSelectGuildRankName := False;
    if (x >= 74) and (x <= 74 + 48) and (y >= 87) and (y <= 87 + 98) then begin
      DWeaponUS1MouseMove(DWeaponUS1, Shift, X - DUserStateItem.Left, Y - DUserStateItem.Top);
    end
    else if (x >= 123) and (x <= 123 + 48) and (y >= 120) and (y <= 120 + 120) then begin
      DWeaponUS1MouseMove(DDressUS1, Shift, X - DUserStateItem.Left, Y - DUserStateItem.Top);
    end
    else if (x >= 123) and (x <= 123 + 48) and (y >= 87) and (y <= 87 + 32) then begin
      DWeaponUS1MouseMove(DHelmetUS1, Shift, X - DUserStateItem.Left, Y - DUserStateItem.Top);
    end
    else if (x >= 16) and (x <= 16 + nUS1GuildNameLen) and (y >= 90) and (y <= 104) then begin
      boSelectGuildName := True;
    end
    else if (x >= 16) and (x <= 16 + nUS1GuildRankNameLen) and (y >= 105) and (y <= 119) then begin
      boSelectGuildRankName := True;
    end;
  end;
end;

procedure TFrmDlg.DUserStateVisible(Sender: TObject; boVisible: Boolean);
begin
  if not boVisible then begin
    //if FrmDlg.UserHDDIB <> nil then FrmDlg.UserHDDIB.Free;
    //FrmDlg.UserHDDIB := nil;
    if FrmDlg.UserHDInfoSurface <> nil then
      FrmDlg.UserHDInfoSurface.Free;
    FrmDlg.UserHDInfoSurface := nil;
  end;
end;

procedure TFrmDlg.DWeaponUS1DirectPaint(Sender: TObject; dsurface: TDXTexture);
var
  d: TDXTexture;
  pRect: TRect;
begin
  with Sender as TDButton do begin
    if (Tag in [Low(UserState1.UseItems)..High(UserState1.UseItems)]) then begin
      if UserState1.UseItems[Tag].S.name <> '' then begin
        {if (sm_Arming in UserState1.UseItems[Tag].s.StdModeEx) then begin
          if CheckWuXinConsistent(UserState1.btWuXin, UserState1.UseItems[Tag].UserItem.Value.btWuXin) or
            CheckWuXinRestraint(UserState1.btWuXin, UserState1.UseItems[Tag].UserItem.Value.btWuXin) then begin
            d := g_WMain2Images.Images[260 + (FrmMain.m_CurrentTick - AppendTick) div 150 mod 6];
            if d <> nil then begin
              DrawBlend(dsurface, SurfaceX(Left) - 21, SurfaceY(Top) - 23, d, 1);
            end;
          end;
        end;  }
        d := GetBagItemImg(UserState1.UseItems[Tag].S.looks);
        if d <> nil then begin
          pRect.Left := SurfaceX(Left - 1);
          pRect.Top := SurfaceY(Top - 1);
          pRect.Right := SurfaceX(Left + Width + 1);
          pRect.Bottom := SurfaceY(Top + Height + 1);
          RefItemPaint(dsurface, d, //人物背包栏
            SurfaceX(Left + (Width - d.Width) div 2),
            SurfaceY(Top + (Height - d.Height) div 2),
            1,
            1,
            @UserState1.UseItems[Tag], False, [pmShowLevel], @pRect);
        end;
      end;
    end;
  end;
end;

procedure TFrmDlg.DWeaponUS1MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
var
  nLocalX, nLocalY: Integer;
  nHintX, nHintY: Integer;
  sel: Integer;
  //  str: string;
begin
  with Sender as TDControl do begin
    if DParent = nil then
      exit;
    nLocalX := LocalX(X - Left);
    nLocalY := LocalY(Y - Top);
    nHintX := SurfaceX(Left) + DParent.SurfaceX(DParent.Left) + nLocalX + 30;
    nHintY := SurfaceY(Top) + DParent.SurfaceY(DParent.Top) + nLocalY + 30;
    sel := Tag;
    if (sel in [Low(UserState1.UseItems)..High(UserState1.UseItems)]) then begin
      if UserState1.UseItems[sel].s.Name <> '' then begin
        DScreen.ShowHint(nHintX,
          nHintY, ShowItemInfo(UserState1.UseItems[sel], [], [UserState1.btWuXin, Integer((DRESSfeature(UserState1.Feature) mod 2) = 1), Integer(@UserState1.UseItems[0])]), clwhite,
          False, Integer(Sender), True);
      end;

    end;
    //end;
  end;
end;

procedure TFrmDlg.DWndAttackModeListDirectPaint(Sender: TObject; dsurface: TDXTexture);
var
  d: TDXTexture;
  ax, ay: integer;
begin
  with Sender as TDWindow do begin
    ax := SurfaceX(Left);
    ay := SurfaceY(Top);
    d := WLib.Images[FaceIndex];
    if d <> nil then
      DrawWindow(dsurface, ax, ay, d);
  end;
end;

procedure TFrmDlg.DWinSelServerClick(Sender: TObject; X, Y: Integer);
begin

  {if (SelServerIndex <> MoveServerIndex) and (MoveServerIndex <> -1) then begin
    SelServerIndex := MoveServerIndex;
    PlaySound(s_glass_button_click);
  end; }

end;

procedure TFrmDlg.DWinSelServerDirectPaint(Sender: TObject;
  dsurface: TDXTexture);
var
  d: TDXTexture;
  //  ServerInfo: pTServerInfo;
  //  i: integer;
  ax, ay: integer;
begin
  with Sender as TDWindow do begin
    ax := SurfaceX(Left);
    ay := SurfaceY(Top);
    d := WLib.Images[FaceIndex];
    if d <> nil then
      DrawWindow(dsurface, ax, ay, d);

    {for i := 0 to g_ServerList.Count - 1 do begin
      if MoveServerIndex = i then
        d := WLib.Images[20]
      else if SelServerIndex = i then
        d := WLib.Images[19]
      else
        d := WLib.Images[18];
      if d <> nil then begin
        dsurface.Draw(ax + 29 + i mod 4 * 179, ay + 64 + i div 4 * 40, d.ClientRect, d, True);
      end;
    end;     }

    {with g_DXCanvas do begin
      //SetBkMode(Handle, TRANSPARENT);
      for i := 0 to g_ServerList.Count - 1 do begin
        ServerInfo := g_ServerList[i];
        TextOut(ax + 54 + i mod 4 * 179, ay + 71 + i div 4 * 40, clWhite, ServerInfo.ShowName);
      end;
      //Release;
    end; }
  end;
end;

procedure TFrmDlg.DWinSelServerExitClick(Sender: TObject; X, Y: Integer);
begin
  if (Sender = DLoginExit) or (Sender = dbtnSelServerClose) then
    FrmMain.Close;
  if Sender = DLoginOk then
    LoginScene.OkClick;
  //if Sender = DLoginNew then
    //LoginScene.NewClick;
  //if Sender = DLoginChgPw then
    //LoginScene.ChgPwClick;

  if Sender = DNewAccountOk then
    LoginScene.NewAccountOk;
  if (Sender = DNewAccountCancel) or (Sender = DNewAccountClose) then
    LoginScene.NewAccountClose;
  if Sender = DChgpwOk then
    LoginScene.ChgpwOk;
  if Sender = DChgpwCancel then
    LoginScene.ChgpwCancel;
end;

procedure TFrmDlg.DWinSelServerMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
{var
  acol, arow: integer; }
begin
  {  x := x - DWinSelServer.Left;
    y := y - DWinSelServer.Top;
    MoveServerIndex := -1;
    if (x >= 29) and (x <= 731) and (y >= 64) and (y <= 370) then begin
      x := x - 29;
      y := y - 64;
      acol := x div (164 + 15);
      arow := y div (25 + 15);
      if (X - (164 + 15) * (acol) - 164 <= 0) and
        (Y - (25 + 15) * (arow) - 25 <= 0) then begin
        acol := acol + arow * 4;
        if (acol < g_ServerList.Count) and (acol >= 0) then
          MoveServerIndex := acol;
      end;
    end;  }
end;

procedure TFrmDlg.DWinSelServerVisible(Sender: TObject; boVisible: Boolean);
begin
  if boVisible then begin
    FrmMain.FCheckLogin := False;
    FrmMain.Caption := g_sLogoText;
    dbtnSelServer1.Caption := g_ServerInfo[0].sName;
    dbtnSelServer2.Caption := g_ServerInfo[1].sName;
    dbtnSelServer3.Caption := g_ServerInfo[2].sName;
    dbtnSelServer4.Caption := g_ServerInfo[3].sName;
    dbtnSelServer5.Caption := g_ServerInfo[4].sName;
    dbtnSelServer6.Caption := g_ServerInfo[5].sName;
    dbtnSelServer7.Caption := g_ServerInfo[6].sName;
    dbtnSelServer8.Caption := g_ServerInfo[7].sName;

    dbtnSelServer1.Visible := g_ServerInfoCount > 0;
    dbtnSelServer2.Visible := g_ServerInfoCount > 1;
    dbtnSelServer3.Visible := g_ServerInfoCount > 2;
    dbtnSelServer4.Visible := g_ServerInfoCount > 3;
    dbtnSelServer5.Visible := g_ServerInfoCount > 4;
    dbtnSelServer6.Visible := g_ServerInfoCount > 5;
    dbtnSelServer7.Visible := g_ServerInfoCount > 6;
    dbtnSelServer8.Visible := g_ServerInfoCount > 7;
  end;
end;

procedure TFrmDlg.dbtnSelServer1Click(Sender: TObject; X, Y: Integer);
var
  sAddr, sPort, sAddrs, sPorts{$IF Var_Free = 1}, sPassword{$IFEND}: string;
  nPort, K: Integer;
begin
  with Sender as TDButton do begin
    if (Tag in [Low(g_ServerInfo)..High(g_ServerInfo)]) then begin
      HintBack := stSelServer;
      sHintStr := 'Connecting to Server...';
      DBTHintClose.Caption := 'Cancel';
      boHintFocus := False;
{$IF Public_Ver <> Public_Test}
      //g_sServerMiniName := g_ServerInfo[Tag].sName;
      //g_sServerName := g_ServerInfo[Tag].sName;
      g_ServerChoice := Tag;
{$ELSE}
      g_sServerMiniName := 'Local Test';
      g_sServerName := 'Local Test';
{$IFEND}
      FrmMain.Caption := g_sLogoText + ' - ' + g_ServerInfo[g_ServerChoice].sName;
      g_ConnectionStep := cnsLogin;
      {g_LoginAddr := g_ServerInfo[Tag].sAddrs;
      g_LoginPort := g_ServerInfo[Tag].wPort;
      with FrmMain.CSocket do begin
        Active := FALSE;
        Host := g_LoginAddr;
        Port := g_LoginPort;
        Active := True;
      end;          }
      DScreen.ChangeScene(stHint);
      sAddrs := g_ServerInfo[Tag].sAddrs;
      nPort := g_ServerInfo[Tag].nPort;
      K := 0;
      Inc(FrmMain.FLoginConnIndex);
      FrmMain.FCheckLogin := True;
      FrmMain.FCheckCount := 0;
      while True do begin
        if k > 9 then
          break;
        sAddrs := GetValidStr3(sAddrs, sAddr, [',']);
       // nPorts := GetValidStr3(sPorts, sPort, [',']);

        if (sAddr <> '') and (nPort > 0) and (nPort < 65535) then begin
          FrmMain.FLoginConnInfos[K].sAddrs := sAddr;
          FrmMain.FLoginConnInfos[K].wPort := nPort;
          g_ServerInfo[Tag].sAddrs := sAddr;
          g_ServerInfo[Tag].nPort := nPort;
          Inc(K);
          Inc(FrmMain.FCheckCount);
          FrmMain.CreateClientSocket(sAddr, nPort, MakeLong(FrmMain.FLoginConnIndex, K - 1));
        end
        else
          Break;
      end;
    end;
  end;
end;

procedure TFrmDlg.dbtnSelServer1ClickSound(Sender: TObject; Clicksound: TClickSound);
begin
  case Clicksound of
    csNorm: PlaySound(s_norm_button_click);
    csStone: PlaySound(s_glass_button_click);
    csGlass: PlaySound(s_rock_button_click);
  end;
end;

procedure TFrmDlg.dbtnSelServer1DirectPaint(Sender: TObject; dsurface: TDXTexture);
var
  d: TDXTexture;
begin
  with Sender as TDButton do begin
    if WLib <> nil then begin
      if Downed then begin
        d := WLib.Images[FaceIndex + 1];
        if d <> nil then
          dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, True);
        with g_DXCanvas do begin
          TextOut(SurfaceX(Left) + (Width - TextWidth(Caption)) div 2 + 1, SurfaceY(Top) + (Height - TextHeight(Caption)) div 2 + 1, Caption, $88ECF0);
        end;
      end else begin
        d := WLib.Images[FaceIndex];
        if d <> nil then
          dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, True);
        with g_DXCanvas do begin
          TextOut(SurfaceX(Left) + (Width - TextWidth(Caption)) div 2, SurfaceY(Top) + (Height - TextHeight(Caption)) div 2, Caption, $88ECF0);
        end;
      end;

    end;
  end;
end;

procedure TFrmDlg.DWndBuyDirectPaint(Sender: TObject; dsurface: TDXTexture);
var
  d: TDXTexture;
  ax, ay: integer;
  nCount: integer;
begin
  with Sender as TDWindow do begin
    ax := SurfaceX(Left);
    ay := SurfaceY(Top);
    d := WLib.Images[FaceIndex];
    if d <> nil then
      DrawWindow(dsurface, ax, ay, d);

    with g_DXCanvas do begin
      nCount := StrToIntDef(DBuyEdit.Text, 0);
      TextOut(ax + 78 - TextWidth(BuyGoods.ClientItem.s.Name) div 2, ay + 45, clYellow, BuyGoods.ClientItem.s.Name);
      TextOut(ax + 22, ay + 70, clWhite, 'No:');
      TextOut(ax + 22, ay + 95, clWhite, 'Cost:');
      TextOut(ax + 55, ay + 95, clWhite, IntToStr(nCount * BuyGoods.nItemPic) + ' Gold');
    end;
  end;
end;

procedure TFrmDlg.DWndBuyVisible(Sender: TObject; boVisible: Boolean);
begin
  if (not boVisible) and DEditChat.Visible then
    DEditChat.SetFocus;

end;

procedure TFrmDlg.DWndFaceClick(Sender: TObject; X, Y: Integer);
begin
  if (FaceSelectindex > -1) and (FaceSelectindex <= High(g_FaceIndexList)) then begin
    if not DEditChat.Visible then begin
      DBTEditClick(DBTEdit, 0, 0);
    end;
    DEditChat.AddImageToList(IntToStr(FaceSelectindex));
    DWndFace.Visible := False;
  end;
end;

procedure TFrmDlg.DWndFaceDirectPaint(Sender: TObject; dsurface: TDXTexture);
var
  d: TDXTexture;
  i, nx, ny, ax, ay: Integer;
  py: smallint;
  //defRect, dRect: TRect;
begin
  with Sender as TDWindow do begin
  if g_nInterface = 1 then g_DXCanvas.FillRect(SurfaceX(Left), SurfaceX(Top), Width, Height, BGSURFACECOLOR or $64000000)
    else if g_nInterface = 2 then g_DXCanvas.FillRect(SurfaceX(Left) - 50, SurfaceX(Top) + 70, Width, Height, BGSURFACECOLOR or $64000000);

    {DrawAlphaOfColor(dsurface, SurfaceX(Left), SurfaceX(Top), Width, Height, BGSURFACECOLOR, 100);
    DrawAlphaEx(dsurface, SurfaceX(Left), SurfaceX(Top), DScreen.m_HintBGSurface,
      0, 0, Width, Height, 1, 100); }
    for i := Low(g_FaceIndexInfo) to High(g_FaceIndexInfo) do begin
      ax := left + (i) mod FACESHOWCOUNT * 24 + 4;
      ay := Top  + (i) div FACESHOWCOUNT * 24 + 4;
      d := g_WFaceImages.GetCachedImage(g_FaceIndexInfo[i].ImageIndex, nx, ny);
      if d <> nil then begin
        if g_nInterface = 1 then dsurface.Draw(ax, ay, d.ClientRect, d, True)
          else if g_nInterface = 2 then dsurface.Draw(ax - 50, ay + 70, d.ClientRect, d, True);
        py := ny;
        if (FrmMain.m_CurrentTick - g_FaceIndexInfo[i].dwShowTime) > LongWord(nx) then begin
          g_FaceIndexInfo[i].ImageIndex := g_FaceIndexInfo[i].ImageIndex + py;
          g_FaceIndexInfo[i].dwShowTime := FrmMain.m_CurrentTick;
        end;
      end;
      if FaceSelectindex = i then begin
        with g_DXCanvas do begin
          RoundRect(ax - 3, ay - 2, ax + 24, ay + 24, clSilver);
          //SetBkMode(Handle, TRANSPARENT);
          {Brush.Style := bsClear;
          Pen.Color := clSilver;
          Pen.Style := psAlternate;
          RoundRect(ax - 2, ay - 2, ax + 24, ay + 24, 0, 0); }
          //Release;
        end;
      end;
    end;
  end;
end;

procedure TFrmDlg.DWndFaceMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
var
  ShowMsg: string;
begin
  FaceSelectindex := (X - DWndFace.Left) div 24 + (y - DWndFace.Top) div 24 * FACESHOWCOUNT;
  with Sender as TDWindow do begin
    if FaceSelectindex in [Low(g_FaceIndexInfo)..High(g_FaceIndexInfo)] then begin
      ShowMsg := g_FaceTextList1[FaceSelectindex];
      DScreen.ShowHint(x + 10, y + 30, ShowMsg, clWhite, False, FaceSelectindex);
    end;
  end;
end;

procedure TFrmDlg.DWndHintDirectPaint(Sender: TObject;
  dsurface: TDXTexture);
var
  d: TDXTexture;
  ax, ay: integer;
  idx, len: integer;
  str: WideString;
  str1, str2, str3: string;
begin
  with Sender as TDWindow do begin
    ax := SurfaceX(Left);
    ay := SurfaceY(Top);
    if WLib <> nil then begin
      d := WLib.Images[FaceIndex];
      if d <> nil then
        DrawWindow(dsurface, ax, ay, d);
      if sHintStr = '' then
        exit;
      str := sHintStr;
      len := length(str);
      with g_DXCanvas do begin
        //SetBkMode(Handle, TRANSPARENT);
        idx := Integer((FrmMain.m_CurrentTick - AppendTick) div 200 mod LongWord(len)) { + 1};
        str1 := Copy(str, 1, idx);
        str2 := Copy(str, idx + 1, 1);
        str3 := Copy(str, idx + 2, len);
        ay := ay + 33;
        ax := ax + 136 - TextWidth(str) div 2;
        TextOut(ax, ay, clWhite{ $ADE7CE}, str1);
        ax := ax + TextWidth(str1);
        TextOut(ax, ay, $7BFFFF, str2);
        ax := ax + TextWidth(str2);
        TextOut(ax, ay, clWhite{ $ADE7CE}, str3);
        //Release;
      end;
    end;
  end;
end;

procedure TFrmDlg.DWndHintKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = 13) or (Key = 27) then begin
    if boHintFocus then
      DBTHintCloseClick(DBTHintClose, 0, 0);
  end;
end;

procedure TFrmDlg.DWndHintVisible(Sender: TObject; boVisible: Boolean);
begin
  if boVisible then
    DWndHint.SetFocus;
end;

procedure TFrmDlg.DWndSayDirectPaint(Sender: TObject; dsurface: TDXTexture);            //ripman
var
  i, ii: integer;
  sx, sy: integer;
  d: TDXTexture;
  nCount: integer;
  pMessage: pTSayMessage;
  SayImage: pTSayImage;
  nx, ny, ax, ay, nLeft: Integer;
  py: smallint;
  sStr: string;
  ClickName: pTClickName;
  ClickItem: pTClickItem;
begin
  with Sender as TDWindow do begin
    g_DXCanvas.FillRect(SurfaceX(Left), SurfaceX(Top), Width, Height, BGSURFACECOLOR or $50000000);
    //g_DXCanvas.FillRect(SurfaceX(Left), SurfaceX(Top), Width, Height, BGSURFACECOLOR or $50FFFFFF);
    //DrawAlphaOfColor(dsurface, SurfaceX(Left), SurfaceX(Top), Width, Height, BGSURFACECOLOR, 60);
    //DrawAlphaEx(dsurface, SurfaceX(Left), SurfaceX(Top), DScreen.m_HintBGSurface, 0, 0, Width, Height, 1, 60);
    sx := SurfaceX(Left) + 16;
    sy := SurfaceX(Top) + (SAYLISTHEIGHT - 12) div 2;
    nCount := Height div SAYLISTHEIGHT;
    with DScreen do begin
      DSayUpDown.MaxPosition := _MAX(0, m_SayTransferList.count - nCount);
      for i := DSayUpDown.Position to (DSayUpDown.Position + nCount - 1) do begin
        if i > m_SayTransferList.count - 1 then
          break;
        pMessage := m_SayTransferList[i];
        ClickName := nil;
        ClickItem := nil;
        if (pClickName <> nil) and (nClickNameIndex > 0) and (pMessage.ClickList <> nil) and
          (pMessage.ClickList.Count > 0) then begin
          for ii := 0 to pMessage.ClickList.Count - 1 do begin
            if pTClickName(pMessage.ClickList[ii]).Index = nClickNameIndex then begin
              ClickName := pMessage.ClickList[ii];
              break;
            end;
          end;
        end
        else if (pClickItem <> nil) and (nClickItemIndex > 0) and (pMessage.ItemList <> nil) and
          (pMessage.ItemList.Count > 0) then begin
          for ii := 0 to pMessage.ItemList.Count - 1 do begin
            if pTClickItem(pMessage.ItemList[ii]).Index = nClickItemIndex then begin
              ClickItem := pMessage.ItemList[ii];
              break;
            end;
          end;
        end;
        ax := sx;
        ay := sy + (i - DSayUpDown.Position) * SAYLISTHEIGHT;
        if pMessage.SaySurface <> nil then        
          dsurface.Draw(ax, ay, pMessage.SaySurface.ClientRect, pMessage.SaySurface, True);
        if (pMessage.ImageList <> nil) and (pMessage.ImageList.Count > 0) then begin
          for ii := 0 to pMessage.ImageList.Count - 1 do begin
            SayImage := pMessage.ImageList[ii];
            if (SayImage.nIndex <= High(g_FaceIndexInfo)) then begin
              d := g_WFaceImages.GetCachedImage(g_FaceIndexInfo[SayImage.nIndex].ImageIndex, nx, ny);
              if d <> nil then begin
                dsurface.Draw(ax + SayImage.nLeft, ay + (SAYLISTHEIGHT - d.Height) div 2 - 1, d.ClientRect, d, True);
                py := ny;
                if (FrmMain.m_CurrentTick - g_FaceIndexInfo[SayImage.nIndex].dwShowTime) > LongWord(nx) then begin
                  g_FaceIndexInfo[SayImage.nIndex].ImageIndex := g_FaceIndexInfo[SayImage.nIndex].ImageIndex + py;
                  g_FaceIndexInfo[SayImage.nIndex].dwShowTime := FrmMain.m_CurrentTick;
                end;
              end;
            end;
          end;
        end;
        if (i = pClickIndex) then begin
          sStr := '';
          nLeft := 0;
          if pClickName <> nil then begin
            sStr := pClickName.sStr;
            nLeft := pClickName.nLeft;
          end
          else if pClickItem <> nil then begin
            sStr := pClickItem.sStr;
            nLeft := pClickItem.nLeft;
          end;
          if sStr <> '' then begin
            with g_DXCanvas do begin
              //SetBkMode(Handle, TRANSPARENT);
              if SayDlgDown then
                TextOut(ax + nLeft + 1, ay + 3, clWhite, sstr)
              else
                TextOut(ax + nLeft, ay + 2, clWhite, sstr);
              //Release;
            end;
          end;
        end
        else begin
          sStr := '';
          nLeft := 0;
          if ClickName <> nil then begin
            sStr := ClickName.sStr;
            nLeft := ClickName.nLeft;
          end
          else if ClickItem <> nil then begin
            sStr := ClickItem.sStr;
            nLeft := ClickItem.nLeft;
          end;
          if sStr <> '' then begin
            with g_DXCanvas do begin
              //SetBkMode(Handle, TRANSPARENT);
              if SayDlgDown then
                TextOut(ax + nLeft + 1, ay + 3, clWhite, sstr)
              else
                TextOut(ax + nLeft, ay + 2, clWhite, sstr);
              //Release;
            end;
          end;
        end;
      end;
    end;
  end;
end;

procedure TFrmDlg.DWndSayEndDirectPaint(Sender: TObject; dsurface: TDXTexture);
var
  ax, ay: Integer;
begin
  if dwndWhisperName.Visible then begin
    with DEditChat do begin
      ax := SurfaceX(Left + Width);
      ay := SurfaceY(Top);
      with g_DXCanvas do begin
        TextOut(ax - TextWidth('[DWndSayEndDirectPaint]'), ay + 2, $808080,
          '[DWndSayEndDirectPaint]');
      end;
    end;
  end;
end;

procedure TFrmDlg.DWndSayInRealArea(Sender: TObject; X, Y: Integer; var IsRealArea: Boolean);
var
  ii, nX, nY: integer;
  pMessage: pTSayMessage;
  ClickName: pTClickName;
  ClickItem: pTClickItem;
begin
  IsRealArea := False;
  with Sender as TDWindow do begin
    pClickName := nil;
    pClickItem := nil;
    nClickNameIndex := 0;
    nClickItemIndex := 0;
    nX := X - 16;
    nY := Y;
    pClickIndex := DSayUpDown.Position + nY div SAYLISTHEIGHT;
    with DScreen do begin
      if (pClickIndex >= 0) and (pClickIndex < m_SayTransferList.count) then begin
        pMessage := m_SayTransferList[pClickIndex];
        if (pMessage.ClickList <> nil) and (pMessage.ClickList.Count > 0) then begin
          for ii := 0 to pMessage.ClickList.Count - 1 do begin
            ClickName := pMessage.ClickList[ii];
            if (nX >= ClickName.nLeft) and (nX <= ClickName.nRight) then begin
              pClickName := ClickName;
              nClickNameIndex := ClickName.Index;
              IsRealArea := True;
              break;
            end;
          end;
        end;
        if (pClickName = nil) and (pMessage.ItemList <> nil) and (pMessage.ItemList.Count > 0) then begin
          for ii := 0 to pMessage.ItemList.Count - 1 do begin
            ClickItem := pMessage.ItemList[ii];
            if (nX >= ClickItem.nLeft) and (nX <= ClickItem.nRight) then begin
              pClickItem := ClickItem;
              nClickItemIndex := ClickItem.Index;
              IsRealArea := True;
              break;
            end;
          end;
        end;
      end;
    end;
  end;

end;

procedure TFrmDlg.dwndSayModeDirectPaint(Sender: TObject; dsurface: TDXTexture);
begin
  //
end;

procedure TFrmDlg.DWndSayMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  SayDlgDown := True;
end;

procedure TFrmDlg.DWndSayMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  i: integer;
begin
  SayDlgDown := False;
  if mbRight = Button then begin
    if pClickName <> nil then begin
      with Sender as TDControl do begin
        DPopUpSayList.Visible := False;
        DPopUpSayList.Item.Clear;
        DPopUpSayList.Item.AddObject('Name: ' + pClickName.sStr, TObject(-1));
        DPopUpSayList.Item.AddObject('-', nil);
        DPopUpSayList.Item.AddObject('Private Chat', TObject(1));
        if (not InFriendList(pClickName.sStr)) and
          (pClickName.sStr <> g_MySelf.m_UserName) then
          DPopUpSayList.Item.AddObject('Add As Friend', TObject(2))
        else
          DPopUpSayList.Item.AddObject('Add As Friend', nil);

        if (not InBlacklist(pClickName.sStr)) then
          DPopUpSayList.Item.AddObject('Block Chat', TObject(7))
        else
          DPopUpSayList.Item.AddObject('Unblock Chat', TObject(8));

        if InFriendList(pClickName.sStr) then
          DPopUpSayList.Item.AddObject('Send Message', TObject(3))
        else
          DPopUpSayList.Item.AddObject('Send Message', nil);

        DPopUpSayList.Item.AddObject('Invite To Group', TObject(4));
        DPopUpSayList.Item.AddObject('Invite To Guild', TObject(5));
        DPopUpSayList.Item.AddObject('-', nil);
        DPopUpSayList.Item.AddObject('Copy Name', TObject(6));
        DPopUpSayList.RefSize;
        DPopUpSayList.Popup(Sender, SurfaceX(X), SurfaceY(Y), pClickName.sStr);
      end;
    end;
  end
  else begin
    if pClickName <> nil then begin
      PlayScene.SetEditChar(pClickName.sStr);
    end
    else if pClickItem <> nil then begin
      if pClickItem.pc.s.name <> '' then begin
        OpenSayItemShow(pClickItem.pc);
      end
      else if pClickItem.ItemIndex < 0 then begin
        for I := Low(g_ItemArr) to High(g_ItemArr) do begin
          if (g_ItemArr[i].s.Name <> '') and (g_ItemArr[i].UserItem.MakeIndex = (-pClickItem.ItemIndex)) then begin
            OpenSayItemShow(g_ItemArr[i]);
            pClickItem.pc := g_ItemArr[i];
            break;
          end;
        end;
      end
      else begin
        if FrmMain.m_CurrentTick > DWndSay.AppendTick then begin
          DWndSay.AppendTick := FrmMain.m_CurrentTick + 500;
          FrmMain.SendGetSayItem(pClickItem.nIndex, pClickItem.ItemIndex); //去服务器取回装备属性
        end;
      end;
    end;
  end;

end;

procedure TFrmDlg.dwndWhisperNameDirectPaint(Sender: TObject; dsurface: TDXTexture);
var
  ax, ay, nY: Integer;
  I: Integer;
begin
  with Sender as TDWindow do begin
    ax := SurfaceX(Left);
    ay := SurfaceY(Top);
    g_DXCanvas.FillRect(ax, ay, Width, Height, $C8000000);
    g_DXCanvas.RoundRect(ax + 1, ay + 1, ax + Width - 1, ay + Height - 1, $FF737D73);
    with g_DXCanvas do begin
      for I := 0 to g_MyWhisperList.Count - 1 do begin
        if I > 7 then
          Break;
        nY := (ay + Height) - (I * 18) - 15;
        if I = FSayNameIndex then
          g_DXCanvas.FillRect(ax + 2, nY - 3, Width - 4, 17, $A062625A);
        TextOut(ax + 5, nY, '/' + g_MyWhisperList[i], $FFDEDBDE);
      end;
    end;
  end;
end;

procedure TFrmDlg.dwndWhisperNameVisible(Sender: TObject; boVisible: Boolean);
begin
  FSayNameIndex := 0;
end;

procedure TFrmDlg.DWudItemShowDirectPaint(Sender: TObject; dsurface: TDXTexture);
begin
  with DWudItemShow do begin
    DScreen.DrawHintEx(DSurface, Surface, SurfaceX(Left), SurfaceX(Top), Width, Height, HintDrawList);
  end;
end;

procedure TFrmDlg.DWudItemShowMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
  with Sender as TDWindow do begin
    if (Left + Width) > g_FScreenWidth then
      Left := g_FScreenWidth - Width;
    if (Top + Height) > g_FScreenHeight then
      Top := g_FScreenHeight - Height;
    if Left < 0 then
      Left := 0;
    if Top < 0 then
      Top := 0;
  end;
end;

procedure TFrmDlg.DWudItemShowVisible(Sender: TObject; boVisible: Boolean);
var
  i: integer;
begin
  if not boVisible then begin
    //DWudItemShow.SetSurface(nil, nil);    更新
    for i := 0 to HintDrawList.Count - 1 do begin
      if pTNewShowHint(HintDrawList[i]).IndexList <> nil then
        pTNewShowHint(HintDrawList[i]).IndexList.Free;
      Dispose(pTNewShowHint(HintDrawList[i]));
    end;
    HintDrawList.Clear;
  end;
end;

procedure TFrmDlg.FormCreate(Sender: TObject);
begin
  //SelServerIndex := -1;
 // MoveServerIndex := -1;
  FHelpTick := 0;
  btAniIndex := 0;
  m_nDiceCount := 0;
  dwStartTime := FrmMain.m_CurrentTick;
  btJob := Random(3);
  btSex := Random(1);
  m_dwBlinkTime := FrmMain.m_CurrentTick;
  m_boViewBlink := False;
  TempList := TList.Create;
  m_dwDblClick := FrmMain.m_CurrentTick;
  boOpenItemBag := False;
  boOpenStatus := False;
  //m_MsgList := TStringList.Create;
  Font.Name := DEFFONTNAME;
  Font.Size := DEFFONTSIZE;
  //m_DMsgSurface := nil;
  BoGuildChat := False;
  MyHDInfoSurface := nil;
  UserHDInfoSurface := nil;
  NAHelps := TStringList.Create;
  //MyHDDIB := nil;
  //UserHDDIB := nil;
  //boShowDlg := False;
  HintDrawList := TList.Create;
  MDlgPoints := TList.Create;
  //MDlgNewPoints := TList.Create;
  MDlgDraws := TList.Create;
  //MenuList := TList.Create;
  RefGroupList := TStringList.Create;
  AddressList := TStringList.Create;
  LoadAddressList();
  NpcGoodsList := TList.Create;
  NpcReturnItemList := TList.Create;
  NpcGoodItems := nil;
  NpcSubItems := nil;
  MagicList1 := TQuickStringList.Create;
  MagicList2 := TQuickStringList.Create;
  sHintStr := '';
end;

procedure TFrmDlg.FormDestroy(Sender: TObject);
begin
  ClearGoodsList;
  TempList.Free;
  HintDrawList.Free;
  MDlgPoints.Free;
  MDlgDraws.Free;
  RefGroupList.Free;

  MagicList1.Free;
  MagicList2.Free;
  NpcGoodsList.Free;
  NpcReturnItemList.Free;
  NAHelps.Free;
  NpcGoodItems := nil;
  NpcSubItems := nil;
  ClearAddressList();
  AddressList.Free;
  if MyHDInfoSurface <> nil then
    MyHDInfoSurface.Free;
  if UserHDInfoSurface <> nil then
    UserHDInfoSurface.Free;

  MyHDInfoSurface := nil;
  UserHDInfoSurface := nil;
  {if MyHDDIB <> nil then MyHDDIB.Free;
  MyHDDIB := nil;
  if UserHDDIB <> nil then UserHDDIB.Free;
  UserHDDIB := nil;  }
end;

procedure TFrmDlg.Initialize;
var
  d: TDXTexture;
  i, nX, nY: integer;
begin
  g_DWinMan.ClearAll;
  DBackground.Left := 0;
  DBackground.Top := 0;
  DBackground.Width := g_FScreenWidth;
  DBackground.Height := g_FScreenHeight;
  DBackground.Background := True;

  g_DWinMan.AddDControl(DBackground, True);

  if DCreateChr.DParent <> nil then DCreateChr.DParent.DelChild(DCreateChr);
  DCreateChr.DParent := DBackground;
  DBackground.AddChild(DCreateChr);
  if DRenewChr.DParent <> nil then DRenewChr.DParent.DelChild(DRenewChr);
  DRenewChr.DParent := DBackground;
  DBackground.AddChild(DRenewChr);

  //SELLDEFCOLOR := IntToStr(GetRGB(67)); //售价默认颜色 $847CCF  67
  SELLDEFCOLOR := '$FF69C9';
  HINTDEFCOLOR := IntToStr(GetRGB(103)); //提示默认颜色 $65D16A
  NOTDOWNCOLOR := IntToStr(GetRGB(128)); //不可交易颜色 $99C5E2  128/131
  ADDVALUECOLOR := '$FF9900'; //普通属性颜色 $FF7979   156/155
  //ADDVALUECOLOR2 := IntToStr(GetRGB(20)); //特殊属性颜色 $DA65C0  20/156
  ADDVALUECOLOR2 := '$63CEFF';
  ADDVALUECOLOR3 := '$33CCFF';
  ADDVALUECOLOR4 := '$FF9900';
  ITEMNAMECOLOR := IntToStr(GetRGB(149)); //物品名称
  SUITITEMCOLOR := IntToStr(GetRGB(203)); //套装未激活     198
  SUITITEMCOLOR2 := IntToStr(GetRGB(145)); //套装已激活     204

  for I := Low(g_FaceIndexInfo) to High(g_FaceIndexInfo) do begin
    g_FaceIndexInfo[i].ImageIndex := g_FaceIndexList[i];
    g_FaceIndexInfo[i].dwShowTime := FrmMain.m_CurrentTick;
  end;

  nShowDlgCount := 0;
  DMagicIndex := 0;
  FShowItemEffectTick := FrmMain.m_CurrentTick;
  FShowItemEffectIndex := 0;
  //新建帐号窗口
  LoginScene.Initialize;
  //Server Select Window

    //Create Char Window
  d := g_WMain99Images.Images[2287];
  if d <> nil then begin
    DWinSelServer.SetImgIndex(g_WMain99Images, 2287);
    DWinSelServer.Left := (DEFMAXSCREENWIDTH - d.Width) div 2;
    DWinSelServer.Top := (DEFMAXSCREENHEIGHT - d.Height) div 2;
  end;

  dbtnSelServerClose.SetImgIndex(g_WUI3Images, 691);
  dbtnSelServerClose.Left := 244;
  dbtnSelServerClose.Top := 30;

  dbtnSelServer7.SetImgIndex(g_WUI3Images, 2803);
  dbtnSelServer7.Left := 47;
  dbtnSelServer7.Top := 350;
  dbtnSelServer7.OnDirectPaint := dbtnSelServer1DirectPaint;
  dbtnSelServer5.SetImgIndex(g_WUI3Images, 2803);
  dbtnSelServer5.Left := 47;
  dbtnSelServer5.Top := 250;
  dbtnSelServer5.OnDirectPaint := dbtnSelServer1DirectPaint;
  dbtnSelServer3.SetImgIndex(g_WUI3Images, 2803);
  dbtnSelServer3.Left := 47;
  dbtnSelServer3.Top := 150;
  dbtnSelServer3.OnDirectPaint := dbtnSelServer1DirectPaint;
  dbtnSelServer1.SetImgIndex(g_WUI3Images, 2803);
  dbtnSelServer1.Left := 47;
  dbtnSelServer1.Top := 50;
  dbtnSelServer1.OnDirectPaint := dbtnSelServer1DirectPaint;
  dbtnSelServer2.SetImgIndex(g_WUI3Images, 2803);
  dbtnSelServer2.Left := 47;
  dbtnSelServer2.Top := 100;
  dbtnSelServer2.OnDirectPaint := dbtnSelServer1DirectPaint;
  dbtnSelServer4.SetImgIndex(g_WUI3Images, 2803);
  dbtnSelServer4.Left := 47;
  dbtnSelServer4.Top := 200;
  dbtnSelServer4.OnDirectPaint := dbtnSelServer1DirectPaint;
  dbtnSelServer6.SetImgIndex(g_WUI3Images, 2803);
  dbtnSelServer6.Left := 47;
  dbtnSelServer6.Top := 300;
  dbtnSelServer6.OnDirectPaint := dbtnSelServer1DirectPaint;
  dbtnSelServer8.SetImgIndex(g_WUI3Images, 2803);
  dbtnSelServer8.Left := 47;
  dbtnSelServer8.Top := 400;
  dbtnSelServer8.OnDirectPaint := dbtnSelServer1DirectPaint;

  //提示界面
  d := g_WMain99Images.Images[1620];
  if d <> nil then begin
    DWndHint.SetImgIndex(g_WMain99Images, 1620);
    DWndHint.Left := (DEFMAXSCREENWIDTH - d.Width) div 2;
    DWndHint.Top := (DEFMAXSCREENHEIGHT - d.Height) div 2;
  end;

  DBTHintClose.SetImgIndex(g_WMain99Images, 1650);
  DBTHintClose.Left := (DWndHint.Width - DBTHintClose.Width) div 2;
  DBTHintClose.Top := 62;
  DBTHintClose.DFColor := $ADD6EF;

  //登录界面

  d := g_WMain99Images.Images[2238];
  if d <> nil then begin
    DLogin.SetImgIndex(g_WMain99Images, 2238);
    DLogin.Left := (DEFMAXSCREENWIDTH - d.Width) div 2;
    DLogin.Top := (DEFMAXSCREENHEIGHT - d.Height) div 2;
  end;

  DLoginOk.SetImgIndex(g_WMain99Images, 2244);
  DLoginOk.Left := 325;
  DLoginOk.Top := 337;

 // DLoginOk.OnDirectPaint := DMyStateDirectPaint;

  DLoginClose.SetImgIndex(g_WMain99Images, 2250);
  DLoginClose.Left := 500;
  DLoginClose.Top := 395;
  //DLoginClose.Visible := False;

  DLoginHome.SetImgIndex(g_WMain99Images, 18);
  DLoginHome.Left := 370;
  DLoginHome.Top := 189;
  //DLoginHome.Visible := False;


  if g_boSQLReg then begin
    DLoginNew.SetImgIndex(g_WMain99Images, 2256);
    DLoginNew.Left := 155;
    DLoginNew.Top := 395;
    //DLoginNew.OnDirectPaint := DMyStateDirectPaint;
    DLoginChgPw.SetImgIndex(g_WMain99Images, 2262);
    DLoginChgPw.Left := 332;
    DLoginChgPw.Top := 395;
    //DLoginChgPw.OnDirectPaint := DMyStateDirectPaint;
    dbtnLoginLostPw.SetImgIndex(g_WMain99Images, 18);
    dbtnLoginLostPw.Left := 370;
    dbtnLoginLostPw.Top := 283;
    dbtnLoginLostPw.Visible := False;
  end
  else begin
    DLoginNew.SetImgIndex(g_WMain99Images, 2256);
    DLoginNew.Left := 155;
    DLoginNew.Top := 395;
    //DLoginNew.OnDirectPaint := DMyStateDirectPaint;
    DLoginChgPw.SetImgIndex(g_WMain99Images, 2262);
    DLoginChgPw.Left := 332;
    DLoginChgPw.Top := 395;
    //DLoginChgPw.OnDirectPaint := DMyStateDirectPaint;
    dbtnLoginLostPw.Visible := False;
    //DEditID.MaxLength := 10;
    DEditPass.MaxLength := 15;
    DLoginNew.Caption := 'New Account';
  end;

  //DLoginExit.SetImgIndex(g_WMain99Images, 1850);
  //DLoginExit.Left := 252;
  //DLoginExit.Top := 28;
 // DLoginExit.OnDirectPaint := DMyStateDirectPaint;

  //Create account window.
  d := g_WMain99Images.Images[2289];
  if d <> nil then begin
    DNewAccount.SetImgIndex(g_WMain99Images, 2289);
    DNewAccount.Left := 246;
    DNewAccount.Top := 250;
  end;

  DNewAccountOk.SetImgIndex(g_WUI3Images, 20);
  DNewAccountOk.Left := 118;
  DNewAccountOk.Top := 240;
 // DNewAccountOk.OnDirectPaint := DMyStateDirectPaint;
  DNewAccountCancel.SetImgIndex(g_WUI3Images, 20);
  DNewAccountCancel.Left := 235;
  DNewAccountCancel.Top := 240;
  //DNewAccountCancel.OnDirectPaint := DMyStateDirectPaint;
  DNewAccountClose.SetImgIndex(g_WUI3Images, 100);
  DNewAccountClose.Left := 500;
  DNewAccountClose.Top := 33;

  //Change Password Box
  d := g_WMain99Images.Images[2290];
  if d <> nil then begin
    DChgPw.SetImgIndex(g_WMain99Images, 2290);
    DChgPw.Left := 320;
    DChgPw.Top := 250;
  end;
  DChgpwOk.SetImgIndex(g_WUI3Images, 20);
  DChgpwOk.Left := 177;
  DChgpwOk.Top := 175;
  //DChgpwOk.OnDirectPaint := DMyStateDirectPaint;
  DChgpwCancel.SetImgIndex(g_WUI3Images, 20);
  DChgpwCancel.Left := 293;
  DChgpwCancel.Top := 175;
  //DChgpwCancel.OnDirectPaint := DMyStateDirectPaint;

  //消息框窗口
  d := g_WMain99Images.Images[30];
  if d <> nil then begin
    DMsgDlg.SetImgIndex(g_WMain99Images, 30);
    DMsgDlg.Left := (DEFSCREENWIDTH - d.Width) div 2;
    DMsgDlg.Top := (DEFSCREENHEIGHT - d.Height) div 2;
  end;
  DMsgDlgOk.SetImgIndex(g_WMain99Images, 24);
  DMsgDlgCancel.SetImgIndex(g_WMain99Images, 24);

  //选择角色窗口
  DSelectChr.Left := 0;
  DSelectChr.Top := 0;
  DSelectChr.Width := DEFMAXSCREENWIDTH;
  DSelectChr.Height := DEFMAXSCREENHEIGHT;

  DscStart.SetImgIndex(g_WMain99Images, 2292);
  DscStart.Left := (DEFMAXSCREENWIDTH - 1024) div 2 + 437  {385 - 12};
  DscStart.Top := (DEFMAXSCREENHEIGHT - 768) div 2 + 697 {456 - 4};
  //DscStart.OnDirectPaint := DMyStateDirectPaint;
  DscNewChr.SetImgIndex(g_WMain99Images, 2268);
  DscNewChr.Left := (DEFMAXSCREENWIDTH - 1024) div 2 + 53 {348};
  DscNewChr.Top := (DEFMAXSCREENHEIGHT - 768) div 2 + 710 {486};
  //DscNewChr.OnDirectPaint := DMyStateDirectPaint;
  DscEraseChr.SetImgIndex(g_WMain99Images, 2280);
  DscEraseChr.Left := (DEFMAXSCREENWIDTH - 1024) div 2 + 243 {347};
  DscEraseChr.Top := (DEFMAXSCREENHEIGHT - 768) div 2 + 710 {506};
  //DscEraseChr.OnDirectPaint := DMyStateDirectPaint;
  DscCredits.SetImgIndex(g_WMain99Images, 2274);
  DscCredits.Left := (DEFMAXSCREENWIDTH - 1024) div 2 + 643 {362};
  DscCredits.Top := (DEFMAXSCREENHEIGHT - 768) div 2 + 710 {527};
  //DscCredits.OnDirectPaint := DMyStateDirectPaint;
  DscExit.SetImgIndex(g_WMain99Images, 2250);
  DscExit.Left := (DEFMAXSCREENWIDTH - 1024) div 2 + 833 {379};
  DscExit.Top := (DEFMAXSCREENHEIGHT - 768) div 2 + 710 {547};
  //DscExit.OnDirectPaint := DMyStateDirectPaint;

  //DscSelect1.SetImgIndex(g_ChrSel2Images, 1160);
  DscSelect1.Left := (DEFMAXSCREENWIDTH - 1024) div 2 + 470;
  DscSelect1.Top := (DEFMAXSCREENHEIGHT - 768)  div 2 + 270;
  DscSelect1.Width := 100;
  DscSelect1.Height := 400;
  //DscSelect1.OnDirectPaint := DMyStateDirectPaint;

  //DscSelect2.SetImgIndex(g_ChrSel2Images, 1160);
  DscSelect2.Left := (DEFMAXSCREENWIDTH - 1024) div 2 + 300;
  DscSelect2.Top := (DEFMAXSCREENHEIGHT - 768)  div 2 + 360;
  DscSelect2.Width := 100;
  DscSelect2.Height := 400;
  //DscSelect2.OnDirectPaint := DMyStateDirectPaint;

 // DscSelect3.SetImgIndex(g_ChrSel2Images, 1160);
  DscSelect3.Left := (DEFMAXSCREENWIDTH - 1024) div 2 + 650;
  DscSelect3.Top := (DEFMAXSCREENHEIGHT - 768)  div 2 + 360;
  DscSelect3.Width := 100;
  DscSelect3.Height := 400;
  //DscSelect3.Width := 242;

  //Create Char Window
  d := g_WMain99Images.Images[2286];
  if d <> nil then begin
    DCreateChr.SetImgIndex(g_WMain99Images, 2286);
    DCreateChr.Left := (DEFMAXSCREENWIDTH - d.Width) div 2 + 350;
    DCreateChr.Top := (DEFMAXSCREENHEIGHT - d.Height) div 2 - 80;
  end;
  DccWarrior.SetImgIndex(g_WUI3Images, 2813);
  DccWizzard.SetImgIndex(g_WUI3Images, 2756);
  DccMonk.SetImgIndex(g_WUI3Images, 2748);
  DccKiller.SetImgIndex(g_WUI3Images, 2745);
  DccRanger.SetImgIndex(g_WUI3Images, 2820);
  DccMale.SetImgIndex(g_WUI3Images, 2776);
  DccFemale.SetImgIndex(g_WUI3Images, 2779);

  DccJ.Visible := False;
  DccM.Visible := False;
  DccS.Visible := False;
  DccH.Visible := False;
  DccT.Visible := False;

  DccOk.SetImgIndex(g_wUI3Images, 2752);
  DccClose.SetImgIndex(g_WUI3Images, 2752);

  //DccChrImg.Left := 114;
  //DccChrImg.Top := 275;
  DccWarrior.Left := 57;
  DccWarrior.Top := 67;
  DccWizzard.Left := 112;
  DccWizzard.Top := 67;
  DccMonk.Left := 170;
  DccMonk.Top := 67;
  DccKiller.Left := 58;
  DccKiller.Top := 123;
  DccRanger.Left := 113;
  DccRanger.Top := 123;

  DccMale.Left := 85;
  DccMale.Top := 199;
  DccFemale.Left := 140;
  DccFemale.Top := 199;

  DccOk.Left := 46;
  DccOk.Top := 400;
  DccClose.Left := 150;
  DccClose.Top := 400;

  //恢复角色窗口
  d := g_WMain99Images.Images[2288];
  if d <> nil then begin
    DRenewChr.SetImgIndex(g_WMain99Images, 2288);
    DRenewChr.Left := (DEFMAXSCREENWIDTH - d.Width) div 2;
    DRenewChr.Top := (DEFMAXSCREENHEIGHT - d.Height) div 2;
  end;
  DButRenewClose.SetImgIndex(g_WUI3Images, 2752);
  DButRenewClose.Left := 220;
  DButRenewClose.Top := 380;
  DButRenewChr.SetImgIndex(g_WUI3Images, 2752);
  DButRenewChr.Left := 46;
  DButRenewChr.Top := 380;

  //底部状态栏
if g_nInterface = 1 then begin
  if g_FScreenWidth = DEFMAXSCREENWIDTH then
    i := 1614
  else
    i := 1615;

  d := g_WMain99Images.Images[i];
  if d <> nil then begin
    DBottom.SetImgIndex(g_WMain99Images, i);
    DBottom.Left := 0;
    DBottom.Top := g_FScreenHeight - d.Height;
  end;

  if g_FScreenWidth = DEFMAXSCREENWIDTH then
    DUserKeyGrid1.Left := 420//387
  else
    DUserKeyGrid1.Left := 304;
  DUserKeyGrid1.Top := 62;
  DUserKeyGrid1.Width := 252;
  DUserKeyGrid1.Height := 30;
  DUserKeyGrid1.ColWidth := 22;
  DUserKeyGrid1.RowHeight := 30;
  DUserKeyGrid1.ColCount := 6;
  DUserKeyGrid1.ColOffset := 12;

  DUserKeyGrid2.Left := 65;
  DUserKeyGrid2.Top := 7;
  DUserKeyGrid2.Width := 332;
  DUserKeyGrid2.Height := 38;

  d := g_WMain99Images.Images[11];
  if d <> nil then begin
    DBottom2.SetImgIndex(g_WMain99Images, 11);
    DBottom2.Left := 390;
    DBottom2.Top := -d.Height;
  end;

  DBTAttackMode.SetImgIndex(g_WMain99Images, 493);
  DBTAttackMode.Top := 32;
  DBTAttackMode.Left := 510;

  DWndAttackModeList.SetImgIndex(g_WMain99Images, 492);
  DWndAttackModeList.Top := 54;
  DWndAttackModeList.Left := 508;

  DBTAttackModeAll.SetImgIndex(g_WMain99Images, 493);
  DBTAttackModeAll.Top := 3;
  DBTAttackModeAll.Left := 2;
  DBTAttackModePeace.SetImgIndex(g_WMain99Images, 493);
  DBTAttackModePeace.Top := 3 + 1 * 24;
  DBTAttackModePeace.Left := 2;
  DBTAttackModeDear.SetImgIndex(g_WMain99Images, 493);
  DBTAttackModeDear.Top := 3 + 2 * 24;
  DBTAttackModeDear.Left := 2;
  DBTAttackModeMaster.SetImgIndex(g_WMain99Images, 493);
  DBTAttackModeMaster.Top := 3 + 3 * 24;
  DBTAttackModeMaster.Left := 2;
  DBTAttackModeGroup.SetImgIndex(g_WMain99Images, 493);
  DBTAttackModeGroup.Top := 3 + 4 * 24;
  DBTAttackModeGroup.Left := 2;
  DBTAttackModeGuild.SetImgIndex(g_WMain99Images, 493);
  DBTAttackModeGuild.Top := 3 + 5 * 24;
  DBTAttackModeGuild.Left := 2;
  DBTAttackModePK.SetImgIndex(g_WMain99Images, 493);
  DBTAttackModePK.Top := 3 + 6 * 24;
  DBTAttackModePK.Left := 2;


  {
  DBTCheck2.SetImgIndex(g_WMain99Images, 378);
  DBTCheck2.Left := -348;
  DBTCheck2.Top := -348;
  DBTCheck3.SetImgIndex(g_WMain99Images, 378);
  DBTCheck3.Left := -348;
  DBTCheck3.Top := -348;
  DBTCheck4.SetImgIndex(g_WMain99Images, 378);
  DBTCheck4.Left := -348;
  DBTCheck4.Top := -348;
  DBTCheck5.SetImgIndex(g_WMain99Images, 378);
  DBTCheck5.Left := -348;
  DBTCheck5.Top := -348;
  DBTCheck6.SetImgIndex(g_WMain99Images, 378);
  DBTCheck6.Left := -348;
  DBTCheck6.Top := -348;
  DBTCheck7.SetImgIndex(g_WMain99Images, 378);
  DBTCheck7.Left := -348;
  DBTCheck7.Top := -348;
  DBTCheck8.SetImgIndex(g_WMain99Images, 378);
  DBTCheck8.Left := -348;
  DBTCheck8.Top := -348;
  DBTCheck9.SetImgIndex(g_WMain99Images, 378);
  DBTCheck9.Left := -348;
  DBTCheck9.Top := -348;
  DBTCheck10.SetImgIndex(g_WMain99Images, 378);
  DBTCheck10.Left := -348;
  DBTCheck10.Top := -348;  }
               //Milo
  DMyState.SetImgIndex(g_WMain99Images, 1916);
  DMyState.Left := g_FScreenWidth - 176;
  DMyState.Top := 71;
  DMyState.Visible := true;
  DMyState.ClickCount := csStone;
  //DMyState.OnDirectPaint := DMyStateDirectPaint;

  DMyBag.SetImgIndex(g_WMain99Images, 1917);
  DMyBag.Left := g_FScreenWidth - 133;
  DMyBag.Top := 64;
  DMyBag.ClickCount := csStone;
  DMyMagic.SetImgIndex(g_WMain99Images, 1918);
  DMyMagic.Left := g_FScreenWidth - 87;
  DMyMagic.Top := 57;
  DMyMagic.ClickCount := csStone;
  DBotMusic.SetImgIndex(g_WMain99Images, 1919);
  DBotMusic.Left := g_FScreenWidth - 46;
  DBotMusic.Top := 48;
  DBotMusic.Visible := True;



  DBotMiniMap.SetImgIndex(g_WMain99Images, 1922);
  DBotMiniMap.Left := 209;
  DBotMiniMap.Top := 97;
  DBotMiniMap.Visible := True;
  DBotTrade.SetImgIndex(g_WMain99Images, 1924);
  DBotTrade.Left := 209 + 30 * 1;
  DBotTrade.Top := 97;
  DBotTrade.OnDirectPaint := DButRenewChrDirectPaint;
  DBotGuild.SetImgIndex(g_WMain99Images, 1926);
  DBotGuild.Left := 209 + 30 * 2;
  DBotGuild.Top := 97;
  DBotGuild.OnDirectPaint := DButRenewChrDirectPaint;
  DBotGroup.SetImgIndex(g_WMain99Images, 1920);
  DBotGroup.Left := 209 + 30 * 3;
  DBotGroup.Top := 97;
  DBotGroup.OnDirectPaint := DButRenewChrDirectPaint;
  DBotFriend.SetImgIndex(g_WMain99Images, 2140);
  DBotFriend.Left := 209 + 30 * 4;
  DBotFriend.Top := 97;
  DBotFriend.OnDirectPaint := DButRenewChrDirectPaint;
  DBotSort.OnDirectPaint := DButRenewChrDirectPaint;
  DOption.SetImgIndex(g_WMain99Images, 2040);
  DOption.Left := 209 + 30 * 7;
  DOption.Top := 97;
  DOption.OnDirectPaint := DButRenewChrDirectPaint;
  DButtonTop.SetImgIndex(g_WMain99Images, 2142);
  DButtonTop.Left := 209 + 30 * 5;
  DButtonTop.Top := 97;
  if DButtonTop.DParent <> nil then DButtonTop.DParent.DelChild(DButtonTop);
  DButtonTop.DParent := DBottom;
  DButtonTop.OnMouseMove := DMyStateMouseMove;
  DBottom.AddChild(DButtonTop);
  DButtonTop.OnDirectPaint := DButRenewChrDirectPaint;
  DBottom2.Visible := False;

  DBTTakeHorse.SetImgIndex(g_WMain99Images, 1632);
  DBTTakeHorse.Left := 209 + 30 * 6;
  DBTTakeHorse.Top := 97;
  if DBTTakeHorse.DParent <> nil then DBTTakeHorse.DParent.DelChild(DBTTakeHorse);
  DBTTakeHorse.DParent := DBottom;
  DBTTakeHorse.OnMouseMove := DMyStateMouseMove;
  DBottom.AddChild(DBTTakeHorse);
  DBTTakeHorse.OnDirectPaint := DButRenewChrDirectPaint;

  DBotAddAbil.SetImgIndex(g_WMain99Images, 1928);
  DBotAddAbil.Left := 209 + 30 * 8;
  DBotAddAbil.Top := 97;
  DBotAddAbil.Visible := True;

  DTopShop.SetImgIndex(g_WMain99Images, 2220);
  DTopShop.Left := g_FScreenWidth - 52;
  DTopShop.Top := 195;
  if DTopShop.DParent <> nil then DTopShop.DParent.DelChild(DTopShop);
  DTopShop.DParent := DBottom;
  DTopShop.OnMouseMove := DMyStateMouseMove;
  DBottom.AddChild(DTopShop);

  DTopHelp.SetImgIndex(g_WMain99Images, 2042);
  DTopHelp.Left := g_FScreenWidth - 88;
  DTopHelp.Top := 101;
  if DTopHelp.DParent <> nil then DTopHelp.DParent.DelChild(DTopHelp);
  DTopHelp.DParent := DBottom;
  DTopHelp.OnMouseMove := DMyStateMouseMove;
  DBottom.AddChild(DTopHelp);

  DTopEMail.SetImgIndex(g_WMain99Images, 2045);
  DTopEMail.Left := g_FScreenWidth - 52;
  DTopEMail.Top := 94;
  if DTopEMail.DParent <> nil then DTopEMail.DParent.DelChild(DTopEMail);
  DTopEMail.DParent := DBottom;
  DTopEMail.OnMouseMove := DMyStateMouseMove;
  DBottom.AddChild(DTopEMail);


  DBotSort.SetImgIndex(g_WMain99Images, 1931);
  DBotSort.Left := g_FScreenWidth - 123;
  DBotSort.Top := 106;

  DBTFace.SetImgIndex(g_WMain99Images, 1634);
  DBTFace.Left := g_FScreenWidth - 234;
  DBTFace.Top := 228;
  if DBTFace.DParent <> nil then DBTFace.DParent.DelChild(DBTFace);
  DBTFace.DParent := DBottom;
  DBTFace.OnMouseMove := DMyStateMouseMove;
  DBottom.AddChild(DBTFace);
  DBTFace.OnDirectPaint := DButRenewChrDirectPaint;

  if DEditChat.DParent <> nil then DEditChat.DParent.DelChild(DEditChat);
  DEditChat.DParent := DBottom;
  DBottom.AddChild(DEditChat);

  if DSayUpDown.DParent <> nil then DSayUpDown.DParent.DelChild(DSayUpDown);
  DSayUpDown.DParent := DBottom;
  DBottom.AddChild(DSayUpDown);

  DSayUpDown.SetImgIndex(g_WMain99Images, 2202);
  DSayUpDown.Top := 112;
  DSayUpDown.Left := g_FScreenWidth - 203;
  DSayUpDown.Height := 112;

  DSayUpDown.UpButton.SetImgIndex(g_WMain99Images, 2203);
  DSayUpDown.DownButton.SetImgIndex(g_WMain99Images, 2206);
  DSayUpDown.MoveButton.SetImgIndex(g_WMain99Images, 2209);

  DEditChat.Left := 210;
  DEditChat.Top := 229;
  DEditChat.Height := 14;
  DEditChat.Width := g_FScreenWidth - 442;
 // if g_FScreenWidth = DEFSCREENWIDTH then
 //   DEditChat.MaxLength := 70  //Was 96 but messages are 70 characters only
 // else
    DEditChat.MaxLength := 125;
  DEditChat.boTransparent := False;

  DBotWndSay.Left := 209;
  DBotWndSay.Top := 114;
  DBotWndSay.Width := g_FScreenWidth - 414;
  DBotWndSay.Height := 112;
  DBotWndSay.Visible := True;

  DCloseSayHear.SetImgIndex(g_WMain99Images, 2221);
  DCloseSayHear.Left := 184{176};
  DCloseSayHear.Top := 114{122};
  DCloseSayHear.Visible := True;

  DCloseSayWhisper.SetImgIndex(g_WMain99Images, 2223);
  DCloseSayWhisper.Left := 184;
  DCloseSayWhisper.Top := 134;
  DCloseSayWhisper.Visible := True;

  DCloseSayCry.SetImgIndex(g_WMain99Images, 2225);
  DCloseSayCry.Left := 184;
  DCloseSayCry.Top := 154;
  DCloseSayCry.Visible := True;

  DCloseSayGuild.SetImgIndex(g_WMain99Images, 2227);
  DCloseSayGuild.Left := 184;
  DCloseSayGuild.Top := 174;
  DCloseSayGuild.Visible := True;

  DCloseSayGroup.SetImgIndex(g_WMain99Images, 2229);
  DCloseSayGroup.Left := 184;
  DCloseSayGroup.Top := 194;
  DCloseSayGroup.Visible := True;
end
else if g_nInterface = 2 then begin
// Ripman - bottom interface

  d := g_WUI3Images.Images[2948];
  if d <> nil then begin
    DBottom.SetImgIndex(g_WUI3Images, 2948);
    DBottom.Left := 0;
    DBottom.Top := g_FScreenHeight - d.Height;
  end;

  d := g_WUI3Images.Images[2948];
  if d <> nil then begin
    DBottom.SetImgIndex(g_WUI3Images, 2948);
    DBottom.Left := 0;
    DBottom.Top := g_FScreenHeight - d.Height;
  end;

  d := g_WUI3Images.Images[2947];
  if d <> nil then begin
    DBottom3.SetImgIndex(g_WUI3Images, 2947);
    DBottom3.Left := 317;
    DBottom3.Top := g_FScreenHeight - d.Height  - 89;
  end;

  d := g_WUI3Images.Images[2946];
  if d <> nil then begin
    DBottom4.SetImgIndex(g_WUI3Images, 2946);
    DBottom4.Left := 712;
    DBottom4.Top := g_FScreenHeight - d.Height;
  end;

  d := g_WUI3Images.Images[2960];
  if d <> nil then begin
    DTopCharStatus.SetImgIndex(g_WUI3Images, 2960);
    DTopCharStatus.Left := 0;
    DTopCharStatus.Top := 0;
  end;

  d := g_WUI3Images.Images[2995];
  if d <> nil then begin
    DMiniMapFrame.SetImgIndex(g_WUI3Images, 2995);
    DMiniMapFrame.Left := 860;
    DMiniMapFrame.Top := 0;
  end;

  // Top Char Avatar
  d := g_WUI3Images.Images[2864];
  if d <> nil then begin
    DTopCharAvatar.SetImgIndex(g_WUI3Images, 2864);
    DTopCharAvatar.Left := 6;
    DTopCharAvatar.Top := 5;
  end;

  //if DWndSay.DParent <> nil then DWndSay.DParent.DelChild(DWndSay);
  //DWndSay.DParent := DBottom3;
  //DBottom3.AddChild(DWndSay);
  //DWndSay.BringToFront;

 { if g_FScreenWidth = DEFMAXSCREENWIDTH then
    DUserKeyGrid1.Left := 420//387
  else }

  DUserKeyGrid1.Left := 60;
  DUserKeyGrid1.Top := 66;
  DUserKeyGrid1.Width := 252;
  DUserKeyGrid1.Height := 30;
  DUserKeyGrid1.ColWidth := 22;
  DUserKeyGrid1.RowHeight := 30;
  DUserKeyGrid1.ColCount := 6;
  DUserKeyGrid1.ColOffset := 12;

  DUserKeyGrid2.Left := 65;
  DUserKeyGrid2.Top := 7;
  DUserKeyGrid2.Width := 332;
  DUserKeyGrid2.Height := 38;

  DBottom2.Visible := False;
  DBottom2.DParent := DBottom3;
  DBottom3.AddChild(DBottom2);

  d := g_WMain99Images.Images[11];
  if d <> nil then begin
    DBottom2.SetImgIndex(g_WMain99Images, 11);
    DBottom2.Left := 390;
    DBottom2.Top := 0;
  end;

  DBTAttackMode.SetImgIndex(g_WMain99Images, 493);
  DBTAttackMode.Top := 32;
  DBTAttackMode.Left := 510;

  DWndAttackModeList.SetImgIndex(g_WMain99Images, 492);
  DWndAttackModeList.Top := 54;
  DWndAttackModeList.Left := 508;

  DBTAttackModeAll.SetImgIndex(g_WMain99Images, 493);
  DBTAttackModeAll.Top := 3;
  DBTAttackModeAll.Left := 2;
  DBTAttackModePeace.SetImgIndex(g_WMain99Images, 493);
  DBTAttackModePeace.Top := 3 + 1 * 24;
  DBTAttackModePeace.Left := 2;
  DBTAttackModeDear.SetImgIndex(g_WMain99Images, 493);
  DBTAttackModeDear.Top := 3 + 2 * 24;
  DBTAttackModeDear.Left := 2;
  DBTAttackModeMaster.SetImgIndex(g_WMain99Images, 493);
  DBTAttackModeMaster.Top := 3 + 3 * 24;
  DBTAttackModeMaster.Left := 2;
  DBTAttackModeGroup.SetImgIndex(g_WMain99Images, 493);
  DBTAttackModeGroup.Top := 3 + 4 * 24;
  DBTAttackModeGroup.Left := 2;
  DBTAttackModeGuild.SetImgIndex(g_WMain99Images, 493);
  DBTAttackModeGuild.Top := 3 + 5 * 24;
  DBTAttackModeGuild.Left := 2;
  DBTAttackModePK.SetImgIndex(g_WMain99Images, 493);
  DBTAttackModePK.Top := 3 + 6 * 24;
  DBTAttackModePK.Left := 2;


  {
  DBTCheck2.SetImgIndex(g_WMain99Images, 378);
  DBTCheck2.Left := -348;
  DBTCheck2.Top := -348;
  DBTCheck3.SetImgIndex(g_WMain99Images, 378);
  DBTCheck3.Left := -348;
  DBTCheck3.Top := -348;
  DBTCheck4.SetImgIndex(g_WMain99Images, 378);
  DBTCheck4.Left := -348;
  DBTCheck4.Top := -348;
  DBTCheck5.SetImgIndex(g_WMain99Images, 378);
  DBTCheck5.Left := -348;
  DBTCheck5.Top := -348;
  DBTCheck6.SetImgIndex(g_WMain99Images, 378);
  DBTCheck6.Left := -348;
  DBTCheck6.Top := -348;
  DBTCheck7.SetImgIndex(g_WMain99Images, 378);
  DBTCheck7.Left := -348;
  DBTCheck7.Top := -348;
  DBTCheck8.SetImgIndex(g_WMain99Images, 378);
  DBTCheck8.Left := -348;
  DBTCheck8.Top := -348;
  DBTCheck9.SetImgIndex(g_WMain99Images, 378);
  DBTCheck9.Left := -348;
  DBTCheck9.Top := -348;
  DBTCheck10.SetImgIndex(g_WMain99Images, 378);
  DBTCheck10.Left := -348;
  DBTCheck10.Top := -348;  }
               //Milo


    /// Bottom  ///

  DBotGroup.SetImgIndex(g_WUI3Images, 600);
  DBotGroup.Left := 280;
  DBotGroup.Top := 84;
  if DBotGroup.DParent <> nil then DBotGroup.DParent.DelChild(DBotGroup);
  DBotGroup.DParent := DBottom;
  DBottom.AddChild(DBotGroup);
  DBotGroup.OnMouseMove := DMyStateMouseMove;
  DBotGroup.OnDirectPaint := DButtonDirectPaint;

   /// Bottom3  ///
  //
  // Chatbox //

  DChatEnlargeButton.SetImgIndex(g_WUI3Images, 2938);
  DChatEnlargeButton.Top := 1;
  DChatEnlargeButton.Left := 376;
  if DChatEnlargeButton.DParent <> nil then DChatEnlargeButton.DParent.DelChild(DChatEnlargeButton);
  DChatEnlargeButton.DParent := DBottom3;
  DBottom3.AddChild(DChatEnlargeButton);

  //Side scroll bar
  DSayUpDown.SetImgIndex(g_WUI3Images, 920);
  DSayUpDown.Top := 20;
  DSayUpDown.Left := 380;
  DSayUpDown.Height := 87;

  DSayUpDown.UpButton.SetImgIndex(g_WUI3Images, 921);
  DSayUpDown.DownButton.SetImgIndex(g_WUI3Images, 924);
  DSayUpDown.MoveButton.SetImgIndex(g_WUI3Images, 937);
  if DSayUpDown.DParent <> nil then DSayUpDown.DParent.DelChild(DSayUpDown);
  DSayUpDown.DParent := DBottom3;
  DBottom3.AddChild(DSayUpDown);

  //Scroll bar background top and down
  DScrollBgTopMini.SetImgIndex(g_WUI3Images, 2932);
  DScrollBgTopMini.Left := 365;
  DScrollBgTopMini.Top := 19;

  DScrollBgBottomMini.SetImgIndex(g_WUI3Images, 2937);
  DScrollBgBottomMini.Left := 365;
  DScrollBgBottomMini.Top := 80;

  DScrollBgMiddleMini.SetImgIndex(g_WUI3Images, 2934);  //Only when you extend the chat bar
  DScrollBgMiddleMini.Left := 365;
  DScrollBgMiddleMini.Top := 50;

  DChatImgBgLeftTopMini.SetImgIndex(g_WUI3Images, 2930);
  DChatImgBgLeftTopMini.Left := 0;
  DChatImgBgLeftTopMini.Top := 19;
  DChatImgBgLeftTopMini.Visible := True;
  if DChatImgBgLeftTopMini.DParent <> nil then DChatImgBgLeftTopMini.DParent.DelChild(DChatImgBgLeftTopMini);
  DChatImgBgLeftTopMini.DParent := DBottom3;
  DBottom3.AddChild(DChatImgBgLeftTopMini);

  DChatImgBgLeftBottomMini.SetImgIndex(g_WUI3Images, 2935);
  DChatImgBgLeftBottomMini.Left := 0;
  DChatImgBgLeftBottomMini.Top := 80;
  if DChatImgBgLeftBottomMini.DParent <> nil then DChatImgBgLeftBottomMini.DParent.DelChild(DChatImgBgLeftBottomMini);
  DChatImgBgLeftBottomMini.DParent := DBottom3;
  DBottom3.AddChild(DChatImgBgLeftBottomMini);

  DChatImgBgLeftMidleMini.SetImgIndex(g_WUI3Images, 2933);
  DChatImgBgLeftMidleMini.Left := 0;
  DChatImgBgLeftMidleMini.Top := 50;
  if DChatImgBgLeftMidleMini.DParent <> nil then DChatImgBgLeftMidleMini.DParent.DelChild(DChatImgBgLeftMidleMini);
  DChatImgBgLeftMidleMini.DParent := DBottom3;
  DBottom3.AddChild(DChatImgBgLeftMidleMini);

  DChatImgBgTopMini.SetImgIndex(g_WUI3Images, 2931);
  DChatImgBgTopMini.Left := 200;
  DChatImgBgTopMini.Top := 19;
  DChatImgBgTopMini.Width := 350;
  DChatImgBgTopMini.Visible := True;
  if DChatImgBgTopMini.DParent <> nil then DChatImgBgTopMini.DParent.DelChild(DChatImgBgTopMini);
  DChatImgBgTopMini.DParent := DBottom3;
  DBottom3.AddChild(DChatImgBgTopMini);

  DChatImgBgBottomMini.SetImgIndex(g_WUI3Images, 2936);
  DChatImgBgBottomMini.Left := 200;
  DChatImgBgBottomMini.Top := 80;
  DChatImgBgBottomMini.Width := 350;
  DChatImgBgBottomMini.Visible := True;
  if DChatImgBgBottomMini.DParent <> nil then DChatImgBgBottomMini.DParent.DelChild(DChatImgBgBottomMini);
  DChatImgBgBottomMini.DParent := DBottom3;
  DBottom3.AddChild(DChatImgBgBottomMini);

  // Where you write
  DEditChat.Left := 3;
  DEditChat.Top := 89;
  DEditChat.Height := 15;
  DEditChat.Width := 373;
  DEditChat.MaxLength := 125;
  DEditChat.boTransparent := False;
  if DEditChat.DParent <> nil then DEditChat.DParent.DelChild(DEditChat);
  DEditChat.DParent := DBottom3;
  DBottom3.AddChild(DEditChat);

  //Chat box
  DBotWndSay.Left := 3;
  DBotWndSay.Top := 22;
//  DBotWndSay.Width := 330;
  DBotWndSay.Height := 65;
  DBotWndSay.Visible := True;
  if DBotWndSay.DParent <> nil then DBotWndSay.DParent.DelChild(DBotWndSay);
  DBotWndSay.DParent := DBottom3;
  DBottom3.AddChild(DBotWndSay);

  //Small buttons up
  DCloseSayHear.SetImgIndex(g_WMain99Images, 2221);
  DCloseSayHear.Left := 0{176};
  DCloseSayHear.Top := 0{122};
  DCloseSayHear.Visible := True;
  if DCloseSayHear.DParent <> nil then DCloseSayHear.DParent.DelChild(DCloseSayHear);
  DCloseSayHear.DParent := DBottom3;
  DBottom3.AddChild(DCloseSayHear);

  DCloseSayWhisper.SetImgIndex(g_WMain99Images, 2223);
  DCloseSayWhisper.Left := 20;
  DCloseSayWhisper.Top := 0;
  DCloseSayWhisper.Visible := True;
  if DCloseSayWhisper.DParent <> nil then DCloseSayWhisper.DParent.DelChild(DCloseSayWhisper);
  DCloseSayWhisper.DParent := DBottom3;
  DBottom3.AddChild(DCloseSayWhisper);

  DCloseSayCry.SetImgIndex(g_WMain99Images, 2225);
  DCloseSayCry.Left := 40;
  DCloseSayCry.Top := 0;
  DCloseSayCry.Visible := True;
  if DCloseSayCry.DParent <> nil then DCloseSayCry.DParent.DelChild(DCloseSayCry);
  DCloseSayCry.DParent := DBottom3;
  DBottom3.AddChild(DCloseSayCry);

  DCloseSayGuild.SetImgIndex(g_WMain99Images, 2227);
  DCloseSayGuild.Left := 60;
  DCloseSayGuild.Top := 0;
  DCloseSayGuild.Visible := True;
  if DCloseSayGuild.DParent <> nil then DCloseSayGuild.DParent.DelChild(DCloseSayGuild);
  DCloseSayGuild.DParent := DBottom3;
  DBottom3.AddChild(DCloseSayGuild);

  DCloseSayGroup.SetImgIndex(g_WMain99Images, 2229);
  DCloseSayGroup.Left := 80;
  DCloseSayGroup.Top := 0;
  DCloseSayGroup.Visible := True;
  if DCloseSayGroup.DParent <> nil then DCloseSayGroup.DParent.DelChild(DCloseSayGroup);
  DCloseSayGroup.DParent := DBottom3;
  DBottom3.AddChild(DCloseSayGroup);

 /// Bottom 4
  DMyState.SetImgIndex(g_WUI3Images, 3000);
  DMyState.Left := 35;
  DMyState.Top := 30;
  DMyState.Visible := true;
  DMyState.ClickCount := csStone;
  if DMyState.DParent <> nil then DMyState.DParent.DelChild(DMyState);
  DMyState.DParent := DBottom4;
  DBottom4.AddChild(DMyState);
  DMyState.OnDirectPaint := DButtonDirectPaint;

  DMyBag.SetImgIndex(g_WUI3Images, 3004);
  DMyBag.Left := 72;
  DMyBag.Top := 30;
  DMyBag.Visible := true;
  DMyBag.ClickCount := csStone;
  if DMyBag.DParent <> nil then DMyBag.DParent.DelChild(DMyBag);
  DMyBag.DParent := DBottom4;
  DBottom4.AddChild(DMyBag);
  DMyBag.OnDirectPaint := DButtonDirectPaint;

  DMyMagic.SetImgIndex(g_WUI3Images, 3008);
  DMyMagic.Left := 109;
  DMyMagic.Top := 30;
  DMyMagic.Visible := true;
  DMyMagic.ClickCount := csStone;
  if DMyMagic.DParent <> nil then DMyMagic.DParent.DelChild(DMyBag);
  DMyMagic.DParent := DBottom4;
  DBottom4.AddChild(DMyMagic);
  DBotSort.OnMouseMove := DMyStateMouseMove;
  DMyMagic.OnDirectPaint := DButtonDirectPaint;

  DBotSort.SetImgIndex(g_WUI3Images, 3012);    //Quest Button
  DBotSort.Left := 147;
  DBotSort.Top :=29;        //ripman
  if DBotSort.DParent <> nil then DBotSort.DParent.DelChild(DBotSort);
  DBotSort.DParent := DBottom4;
  DBottom4.AddChild(DBotSort);
  DBotSort.OnMouseMove := DMyStateMouseMove;
  DBotSort.OnDirectPaint := DButtonDirectPaint;

  DTopEMail.SetImgIndex(g_WUI3Images, 530);
  DTopEMail.Left := 179;
  DTopEMail.Top := 25;
  if DTopEMail.DParent <> nil then DTopEMail.DParent.DelChild(DTopEMail);
  DTopEMail.DParent := DBottom4;
  DTopEMail.OnMouseMove := DMyStateMouseMove;
  DBottom4.AddChild(DTopEMail);
  //DTopEmail.OnDirectPaint := DButtonDirectPaint;

  DBotGuild.SetImgIndex(g_WUI3Images, 3028);
  DBotGuild.Left := 220;
  DBotGuild.Top := 29;
  if DBotGuild.DParent <> nil then DBotGuild.DParent.DelChild(DBotGuild);
  DBotGuild.DParent := DBottom4;
  DBottom4.AddChild(DBotGuild);
  DBotGuild.OnMouseMove := DMyStateMouseMove;
  //DBotGuild.OnDirectPaint := DButtonDirectPaint;

  DBotTrade.SetImgIndex(g_WUI3Images, 590);
  DBotTrade.Left := 2;
  DBotTrade.Top := 42;
  if DBotTrade.DParent <> nil then DBotTrade.DParent.DelChild(DBotGuild);
  DBotTrade.DParent := DBottom4;
  DBotTrade.OnMouseMove := DMyStateMouseMove;
  DBottom4.AddChild(DBotTrade);
  DBotTrade.OnDirectPaint := DButtonDirectPaint;

  DTopShop.SetImgIndex(g_WUI3Images, 3024);
  DTopShop.Left := 2;
  DTopShop.Top := 0;
  if DTopShop.DParent <> nil then DTopShop.DParent.DelChild(DTopShop);
  DTopShop.DParent := DBottom4;
  DTopShop.OnMouseMove := DMyStateMouseMove;
  DBottom4.AddChild(DTopShop);


  ///  DMiniMapFrame ///

  ////////////////////////////////////////////////////////////////////////////////////////////////////

{  DMiniMap.Left := 38;
  DMiniMap.Top := 22;
  DMiniMap.Width := 124;
  DMiniMap.Height := 120;  }

  if DMiniMap.DParent <> nil then DMiniMap.DParent.DelChild(DMiniMap);
  DMiniMap.DParent := DMiniMapFrame;
  DMiniMapFrame.AddChild(DMiniMap);

  DTopHelp.SetImgIndex(g_WUI3Images, 2990);
  DTopHelp.Left := 3;
  DTopHelp.Top := 28;
  if DTopHelp.DParent <> nil then DTopHelp.DParent.DelChild(DTopHelp);
  DTopHelp.DParent := DMiniMapFrame;
  DMiniMapFrame.AddChild(DTopHelp);
  DTopHelp.OnMouseMove := DMyStateMouseMove;
  DTopHelp.OnDirectPaint := DBotGuildDirectPaint;

  DBotMiniMap.SetImgIndex(g_WUI3Images, 585);
  DBotMiniMap.Left := 3;
  DBotMiniMap.Top := 46;
  DBotMiniMap.Visible := True;
  if DBotMiniMap.DParent <> nil then DBotMiniMap.DParent.DelChild(DBotMiniMap);
  DBotMiniMap.DParent := DMiniMapFrame;
  DMiniMapFrame.AddChild(DBotMiniMap);
  DBotMiniMap.OnMouseMove := DMyStateMouseMove;
  DBotMiniMap.OnDirectPaint := DButtonDirectPaint;

  DButtonTop.SetImgIndex(g_WUI3Images, 615);
  DButtonTop.Left := 3;
  DButtonTop.Top := 64;
  if DButtonTop.DParent <> nil then DButtonTop.DParent.DelChild(DButtonTop);
  DButtonTop.DParent := DMiniMapFrame;
  DMiniMapFrame.AddChild(DButtonTop);
  DButtonTop.OnMouseMove := DMyStateMouseMove;
  DButtonTop.OnDirectPaint := DButtonDirectPaint;

  DBTFace.SetImgIndex(g_WUI3Images, 670);
  DBTFace.Left := 3;
  DBTFace.Top := 83;
  if DBTFace.DParent <> nil then DBTFace.DParent.DelChild(DBTFace);
  DBTFace.DParent := DMiniMapFrame;
  DMiniMapFrame.AddChild(DBTFace);
  DBTFace.OnMouseMove := DMyStateMouseMove;
  DBTFace.OnDirectPaint := DBotGuildDirectPaint;

  DBTTakeHorse.SetImgIndex(g_WUI3Images, 635);
  DBTTakeHorse.Left := 3;
  DBTTakeHorse.Top := 101;
  if DBTTakeHorse.DParent <> nil then DBTTakeHorse.DParent.DelChild(DBTTakeHorse);
  DBTTakeHorse.DParent := DMiniMapFrame;
  DMiniMapFrame.AddChild(DBTTakeHorse);
  DBTTakeHorse.OnMouseMove := DMyStateMouseMove;
  DBTTakeHorse.OnDirectPaint := DButtonDirectPaint;

  DBotFriend.SetImgIndex(g_WUI3Images, 645);
  DBotFriend.Left := 3;
  DBotFriend.Top := 119;
  if DBotFriend.DParent <> nil then DBotFriend.DParent.DelChild(DBotFriend);
  DBotFriend.DParent := DMiniMapFrame;
  DMiniMapFrame.AddChild(DBotFriend);
  DBotFriend.OnMouseMove := DMyStateMouseMove;
  DBotFriend.OnDirectPaint := DButtonDirectPaint;

  DOption.SetImgIndex(g_WUI3Images, 525);
  DOption.Left := 2;
  DOption.Top := 137;
  if DOption.DParent <> nil then DOption.DParent.DelChild(DOption);
  DOption.DParent := DMiniMapFrame;
  DMiniMapFrame.AddChild(DOption);
  DOption.OnMouseMove := DMyStateMouseMove;
  DOption.OnDirectPaint := DButtonDirectPaint;

  DBotMusic.Visible := True;
  if g_boSound then
    DBotMusic.SetImgIndex(g_WUI3Images, 2986)
  else DBotMusic.SetImgIndex(g_WUI3Images, 2982);
  DBotMusic.Left := 142;
  DBotMusic.Top := 145;
  if DBotMusic.DParent <> nil then DBotMusic.DParent.DelChild(DBotMusic);
  DBotMusic.DParent := DMiniMapFrame;
  DMiniMapFrame.AddChild(DBotMusic);
  DBotMusic.OnMouseMove := DMyStateMouseMove;
  DBotMusic.OnDirectPaint := DBotGuildDirectPaint;

  DFrameMaxMin.Visible := True;
  DFrameMaxMin.SetImgIndex(g_WUI3Images, 2970);
  DFrameMaxMin.Left := 142;
  DFrameMaxMin.Top := 2;
  if DFrameMaxMin.DParent <> nil then DFrameMaxMin.DParent.DelChild(DFrameMaxMin);
  DFrameMaxMin.DParent := DMiniMapFrame;
  DMiniMapFrame.AddChild(DFrameMaxMin);
  DFrameMaxMin.OnMouseMove := DMyStateMouseMove;
  DFrameMaxMin.OnDirectPaint := DBotGuildDirectPaint;


  ////////////////////////////////////////////////////////////////////////////////////////////////////

  /// Others ///

  DBotAddAbil.SetImgIndex(g_WMain99Images, 1928);
  DBotAddAbil.Left := 209 + 30 * 8;
  DBotAddAbil.Top := 97;
  DBotAddAbil.Visible := True;

end;

  DBTCheck1.SetImgIndex(g_WMain99Images, 378);
  DBTCheck1.Left := 380;
  DBTCheck1.Top := -(DBottom.Top - 162) - 61;
  DBTCheck2.SetImgIndex(g_WMain99Images, 378);
  DBTCheck2.Left := 380;
  DBTCheck2.Top := -(DBottom.Top - 162) - 61;
  DBTCheck3.SetImgIndex(g_WMain99Images, 378);
  DBTCheck3.Left := 380;
  DBTCheck3.Top := -(DBottom.Top - 162) - 61;
  DBTCheck4.SetImgIndex(g_WMain99Images, 378);
  DBTCheck4.Left := 380;
  DBTCheck4.Top := -(DBottom.Top - 162) - 61;
  DBTCheck5.SetImgIndex(g_WMain99Images, 378);
  DBTCheck5.Left := 380;
  DBTCheck5.Top := -(DBottom.Top - 162) - 61;
  DBTCheck6.SetImgIndex(g_WMain99Images, 378);
  DBTCheck6.Left := 380;
  DBTCheck6.Top := -(DBottom.Top - 162) - 61;
  DBTCheck7.SetImgIndex(g_WMain99Images, 378);
  DBTCheck7.Left := 380;
  DBTCheck7.Top := -(DBottom.Top - 162) - 61;
  DBTCheck8.SetImgIndex(g_WMain99Images, 378);
  DBTCheck8.Left := 380;
  DBTCheck8.Top := -(DBottom.Top - 162) - 61;
  DBTCheck9.SetImgIndex(g_WMain99Images, 378);
  DBTCheck9.Left := 380;
  DBTCheck9.Top := -(DBottom.Top - 162) - 61;
  DBTCheck10.SetImgIndex(g_WMain99Images, 378);
  DBTCheck10.Left := 380;
  DBTCheck10.Top := -(DBottom.Top - 162) - 61;

  dwndWhisperName.Left := 15;
  dwndWhisperName.Top := 391;
  dwndWhisperName.Height := 144;
  dwndWhisperName.Width := 120;

  //顶部状态栏
  d := g_WMain99Images.Images[2];
  if d <> nil then begin
    DTop.SetImgIndex(g_WMain99Images, 2);
    DTop.Left := (g_FScreenWidth - d.Width) div 2;
    DTop.Top := 0;
  end;

  DTopGM.SetImgIndex(g_WMain99Images, 54);
  DTopGM.Left := 8;
  DTopGM.Top := 2;

  DOpenMinmap.SetImgIndex(g_WMain99Images, 61);
  DOpenMinmap.Left := 783;
  DOpenMinmap.Top := 1;

  DTopStatusEXP.SetImgIndex(g_WMain99Images, 1500);
  DTopStatusEXP.AppendData := @g_StatusInfoArr[STATUS_EXP];
  g_StatusInfoArr[STATUS_EXP].Button := DTopStatusEXP; 
  DTopStatusPOW.SetImgIndex(g_WMain99Images, 1501);
  DTopStatusPOW.AppendData := @g_StatusInfoArr[STATUS_POW];
  g_StatusInfoArr[STATUS_POW].Button := DTopStatusPOW;
  DTopStatusSC.SetImgIndex(g_WMain99Images, 1502);
  DTopStatusSC.AppendData := @g_StatusInfoArr[STATUS_SC];
  g_StatusInfoArr[STATUS_SC].Button := DTopStatusSC;
  DTopStatusAC.SetImgIndex(g_WMain99Images, 1503);
  DTopStatusAC.AppendData := @g_StatusInfoArr[STATUS_AC];
  g_StatusInfoArr[STATUS_AC].Button := DTopStatusAC;
  DTopStatusDC.SetImgIndex(g_WMain99Images, 1504);
  DTopStatusDC.AppendData := @g_StatusInfoArr[STATUS_DC];
  g_StatusInfoArr[STATUS_DC].Button := DTopStatusDC;
  DTopStatusHIDEMODE.SetImgIndex(g_WMain99Images, 1505);
  DTopStatusHIDEMODE.AppendData := @g_StatusInfoArr[STATUS_HIDEMODE];
  g_StatusInfoArr[STATUS_HIDEMODE].Button := DTopStatusHIDEMODE;
  DTopStatusSTONE.SetImgIndex(g_WMain99Images, 1506);
  DTopStatusSTONE.AppendData := @g_StatusInfoArr[STATUS_STONE];
  g_StatusInfoArr[STATUS_STONE].Button := DTopStatusSTONE;
  DTopStatusMC.SetImgIndex(g_WMain99Images, 1507);
  DTopStatusMC.AppendData := @g_StatusInfoArr[STATUS_MC];
  g_StatusInfoArr[STATUS_MC].Button := DTopStatusMC;
  DTopStatusMP.SetImgIndex(g_WMain99Images, 1508);
  DTopStatusMP.AppendData := @g_StatusInfoArr[STATUS_MP];
  g_StatusInfoArr[STATUS_MP].Button := DTopStatusMP;
  DTopStatusMAC.SetImgIndex(g_WMain99Images, 1509);
  DTopStatusMAC.AppendData := @g_StatusInfoArr[STATUS_MAC];
  g_StatusInfoArr[STATUS_MAC].Button := DTopStatusMAC;
  DTopStatusHP.SetImgIndex(g_WMain99Images, 1510);
  DTopStatusHP.AppendData := @g_StatusInfoArr[STATUS_HP];
  g_StatusInfoArr[STATUS_HP].Button := DTopStatusHP;
  DTopStatusDAMAGEARMOR.SetImgIndex(g_WMain99Images, 1511);
  DTopStatusDAMAGEARMOR.AppendData := @g_StatusInfoArr[STATUS_DAMAGEARMOR];
  g_StatusInfoArr[STATUS_DAMAGEARMOR].Button := DTopStatusDAMAGEARMOR;
  DTopStatusDECHEALTH.SetImgIndex(g_WMain99Images, 1512);
  DTopStatusDECHEALTH.AppendData := @g_StatusInfoArr[STATUS_DECHEALTH];
  g_StatusInfoArr[STATUS_DECHEALTH].Button := DTopStatusDECHEALTH;
  DTopStatusCOBWEB.SetImgIndex(g_WMain99Images, 1513);
  DTopStatusCOBWEB.AppendData := @g_StatusInfoArr[STATUS_COBWEB];
  g_StatusInfoArr[STATUS_COBWEB].Button := DTopStatusCOBWEB;
  DTopStatusSLOWDOWN.SetImgIndex(g_WMain99Images, 1514);
  DTopStatusSLOWDOWN.AppendData := @g_StatusInfoArr[STATUS_SLOWDOWN];
  g_StatusInfoArr[STATUS_SLOWDOWN].Button := DTopStatusSLOWDOWN;
  DTopStatusFreeze.SetImgIndex(g_WMain99Images, 1515);
  DTopStatusFreeze.AppendData := @g_StatusInfoArr[STATUS_Freeze];
  g_StatusInfoArr[STATUS_Freeze].Button := DTopStatusFreeze;
  DTopStatusStun.SetImgIndex(g_WMain99Images, 1516);
  DTopStatusStun.AppendData := @g_StatusInfoArr[STATUS_Stun];
  g_StatusInfoArr[STATUS_Stun].Button := DTopStatusStun;
  DTopStatusRage.SetImgIndex(g_WMain99Images, 1517);
  DTopStatusRage.AppendData := @g_StatusInfoArr[STATUS_RAGE];
  g_StatusInfoArr[STATUS_RAGE].Button := DTopStatusRage;
  DTopStatusMagicBooster.SetImgIndex(g_WMain99Images, 1518);
  DTopStatusMagicBooster.AppendData := @g_StatusInfoArr[STATUS_MAGICBOOSTER];
  g_StatusInfoArr[STATUS_MAGICBOOSTER].Button := DTopStatusMagicBooster;
  DTopStatusUE.SetImgIndex(g_WMain99Images, 1519);
  DTopStatusUE.AppendData := @g_StatusInfoArr[STATUS_UE];
  g_StatusInfoArr[STATUS_UE].Button := DTopStatusUE;
  DTopStatusCurse.SetImgIndex(g_WMain99Images, 1520 + 2);
  DTopStatusCurse.AppendData := @g_StatusInfoArr[STATUS_CURSE];
  g_StatusInfoArr[STATUS_CURSE].Button := DTopStatusCurse;
  DTopStatusProField.SetImgIndex(g_WMain99Images, 1520 + 3);
  DTopStatusProField.AppendData := @g_StatusInfoArr[STATUS_PROFIELD];
  g_StatusInfoArr[STATUS_PROFIELD].Button := DTopStatusProField;

  d := g_WMain99Images.Images[60];          //ripman minimap
  if d <> nil then begin
    DMiniMapDlg.SetImgIndex(g_WMain99Images, 60);
    DMiniMapDlg.Left := 654;
    DMiniMapDlg.Top := 21;
  end;
  DMinMap128.Left := 10;
  DMinMap128.Top := 3;
  DMinMap128.Width := 128;
  DMinMap128.Height := 128;

  DMiniMapMax.SetImgIndex(g_WMain99Images, 139);
  DMiniMapMax.Left := 105;
  DMiniMapMax.Top := 106;

  d := g_WMain99Images.Images[142];
  if d <> nil then begin
    DMaxMiniMap.SetImgIndex(g_WMain99Images, 142);
    DMaxMiniMap.Left := (g_FScreenWidth - d.Width) div 2;
    DMaxMiniMap.Top := (g_FScreenHeight - d.Height) div 2;
  end;

  DMaxMinimapClose.SetImgIndex(g_WMain99Images, 143);
  DMaxMinimapClose.Left := 776;
  DMaxMinimapClose.Top := 1;

  DMaxMap792.Left := 4;
  DMaxMap792.Top := 37;
  DMaxMap792.Width := 792;
  DMaxMap792.Height := 536;

  //物品包裹栏
  DItemBag.SetImgIndex(g_WMain99Images, 1623);
  DItemBag.Left := 0;
  DItemBag.Top := 0;

  DItemBagShop.SetImgIndex(g_WUI3Images, 52);
  DItemBagShop.Top := 280;
  DItemBagShop.Left := 200;
  DItemBagShop.OnDirectPaint := DBTHintCloseDirectPaint;
  DItemBagShop.DFColor := $FFFFFF;
  DItemBagShop.Caption := 'Stall';

  //DItemBagRef.SetImgIndex(g_WMain99Images, 1624);
  //DItemBagRef.Top := 271;
  //DItemBagRef.Left := 270;
  //DItemBagRef.Visible := False;

  DItemAppendBag1.SetImgIndex(g_WMain99Images, 369);
  DItemAppendBag1.Top := 29;
  DItemAppendBag1.Visible := False;
  DItemAppendBag2.SetImgIndex(g_WMain99Images, 369);
  DItemAppendBag2.Top := 118;
  DItemAppendBag2.Visible := False;
  DItemAppendBag3.SetImgIndex(g_WMain99Images, 369);
  DItemAppendBag3.Top := 207;
  DItemAppendBag3.Visible := False;

  DItemGrid1.Top := 10;
  DItemGrid1.Left := 10;
  DItemGrid1.Height := 69;
  DItemGrid1.Visible := False;
  DItemGrid2.Top := 10;
  DItemGrid2.Left := 10;
  DItemGrid2.Height := 69;
  DItemGrid2.Visible := False;
  DItemGrid3.Top := 10;
  DItemGrid3.Left := 10;
  DItemGrid3.Height := 69;
  DItemGrid3.Visible := False;

  DItemGrid.Left := 25;
  DItemGrid.Top := 45;
  DItemGrid.Width := 285;
  DItemGrid.Height := 220;
  DItemGrid.ColCount := 8;
  DItemGrid.ColWidth := 33;//33
  DItemGrid.ColOffset := 4;  //3
  DItemGrid.RowCount := 6;
  DItemGrid.RowHeight := 30;//30
  DItemGrid.RowOffset := 7;  //2

  DGold.Left := 20;
  DGold.Top := 280;
  DGold.Width := 25;
  DGold.Height := 25;

  DItemAddBag1.Left := 24;
  DItemAddBag1.Top := 368;
  DItemAddBag1.Width := 34;
  DItemAddBag1.Height := 34;
  DItemAddBag2.Left := 80;
  DItemAddBag2.Top := 368;
  DItemAddBag2.Width := 34;
  DItemAddBag2.Height := 34;
  DItemAddBag3.Left := 136;
  DItemAddBag3.Top := 368;
  DItemAddBag3.Width := 34;
  DItemAddBag3.Height := 34;
  DItemAddBag1.Visible := False;
  DItemAddBag2.Visible := False;
  DItemAddBag3.Visible := False;

  DCloseBag.SetImgIndex(g_WMain99Images, 1850);
  DCloseBag.Left := 310;
  DCloseBag.Top := 13;

  DOpenCompoundItem.SetImgIndex(g_WUI3Images, 3016);
  DOpenCompoundItem.Left := g_FScreenWidth - 1016;
  DOpenCompoundItem.Top := 171;
  if DOpenCompoundItem.DParent <> nil then DOpenCompoundItem.DParent.DelChild(DOpenCompoundItem);
  DOpenCompoundItem.DParent := DBottom;
  DOpenCompoundItem.OnMouseMove := DMyStateMouseMove;
  DBottom.AddChild(DOpenCompoundItem);

  //Chat Window
  DWndSay.Left := 0;
  DWndSay.Height := 2 + SAYLISTHEIGHT * 7;
  if g_nInterface = 1 then
    DWndSay.Top := g_FScreenHeight - DWndSay.Height - DBottom.Height - 39
  else if g_nInterface = 2 then
    DWndSay.Top := g_FScreenHeight - DWndSay.Height - DBottom.Height - 10;

  // look for fix the chat width ripman
  if g_nInterface = 1 then
    g_nDefaultSayWidth := 386
  else if g_nInterface = 2 then
    g_nDefaultSayWidth := 245;

  DWndSay.Width := g_nDefaultSayWidth + g_FScreenWidth - DEFSCREENWIDTH + 16;

  DBtnSayAll.SetImgIndex(g_WMain99Images, 594);
  DBtnSayAll.Left := 16;
  DBtnSayAll.Top := DWndSay.Height + 1;
  DBtnSayAll.AppendData := Pointer(Integer(us_All));
  DBtnSayHear.SetImgIndex(g_WMain99Images, 596);
  DBtnSayHear.Left := DBtnSayAll.Left + DBtnSayAll.Width;
  DBtnSayHear.Top := DWndSay.Height + 1;
  DBtnSayHear.AppendData := Pointer(Integer(us_Hear));
  DBtnSayWhisper.SetImgIndex(g_WMain99Images, 598);
  DBtnSayWhisper.Left := DBtnSayHear.Left + DBtnSayHear.Width;
  DBtnSayWhisper.Top := DWndSay.Height + 1;
  DBtnSayWhisper.AppendData := Pointer(Integer(us_Whisper));
  DBtnSayCry.SetImgIndex(g_WMain99Images, 600);
  DBtnSayCry.Left := DBtnSayWhisper.Left + DBtnSayWhisper.Width;
  DBtnSayCry.Top := DWndSay.Height + 1;
  DBtnSayCry.AppendData := Pointer(Integer(us_Cry));
  DBtnSayGroup.SetImgIndex(g_WMain99Images, 602);
  DBtnSayGroup.Left := DBtnSayCry.Left + DBtnSayCry.Width;
  DBtnSayGroup.Top := DWndSay.Height + 1;
  DBtnSayGroup.AppendData := Pointer(Integer(us_Group));
  DBtnSayGuild.SetImgIndex(g_WMain99Images, 604);
  DBtnSayGuild.Left := DBtnSayGroup.Left + DBtnSayGroup.Width;
  DBtnSayGuild.Top := DWndSay.Height + 1;
  DBtnSayGuild.AppendData := Pointer(Integer(us_Guild));
  DBtnSaySys.SetImgIndex(g_WMain99Images, 606);
  DBtnSaySys.Left := DBtnSayGuild.Left + DBtnSayGuild.Width;
  DBtnSaySys.Top := DWndSay.Height + 1;
  DBtnSaySys.AppendData := Pointer(Integer(us_Sys));
  DBtnSayCustom.SetImgIndex(g_WMain99Images, 608);
  DBtnSayCustom.Left := DBtnSaySys.Left + DBtnSaySys.Width;
  DBtnSayCustom.Top := DWndSay.Height + 1;
  DBtnSayCustom.AppendData := Pointer(Integer(us_Custom));

  dchkSayLock.SetImgIndex(g_WMain99Images, 151);
  dchkSayLock.Left := DBtnSaySys.Left + DBtnSaySys.Width;
  dchkSayLock.Top := DWndSay.Height + 2;

  DBTSayLock.SetImgIndex(g_WMain99Images, 582);
  DBTSayLock.Left := -1;
  DBTSayLock.Top := DWndSay.Height + 19;

  dwndSayMode.Left := DBTSayLock.Left;
  dwndSayMode.Top := 415;
  dwndSayMode.Height := 10;
  dwndSayMode.Width := 10;

  dbtnSayModeWorld.SetImgIndex(g_WMain99Images, 656);
  dbtnSayModeWorld.Left := 0;
  dbtnSayModeWorld.Top := 0;
  dbtnSayModeGuild.SetImgIndex(g_WMain99Images, 654);
  dbtnSayModeGuild.Left := 0;
  dbtnSayModeGuild.Top := dbtnSayModeWorld.Top + dbtnSayModeWorld.Height;
  dbtnSayModeGroup.SetImgIndex(g_WMain99Images, 652);
  dbtnSayModeGroup.Left := 0;
  dbtnSayModeGroup.Top := dbtnSayModeGuild.Top + dbtnSayModeGuild.Height;
  dbtnSayModeCry.SetImgIndex(g_WMain99Images, 650);
  dbtnSayModeCry.Left := 0;
  dbtnSayModeCry.Top := dbtnSayModeGroup.Top + dbtnSayModeGroup.Height;
  dbtnSayModeWhisper.SetImgIndex(g_WMain99Images, 658);
  dbtnSayModeWhisper.Left := 0;
  dbtnSayModeWhisper.Top := dbtnSayModeCry.Top + dbtnSayModeCry.Height;
  dbtnSayModeHear.SetImgIndex(g_WMain99Images, 648);
  dbtnSayModeHear.Left := 0;
  dbtnSayModeHear.Top := dbtnSayModeWhisper.Top + dbtnSayModeWhisper.Height;

  DBTEdit.SetImgIndex(g_WMain99Images, 102);
  DBTEdit.Left := DBTSayLock.Width - 1;
  DBTEdit.Top := DBTSayLock.Top;

  DBTSayMove.SetImgIndex(g_WMain99Images, 117);
  DBTSayMove.Left := 0;
  DBTSayMove.Top := 0;

  DBTOption.SetImgIndex(g_WMain99Images, 127);
  DBTOption.Top := DBTEdit.Top;
  DBTOption.Left := DBTFace.Left + DBTFace.Width - 1;

  //DPopUpSayList.SetImgIndex(g_WMain99Images, 276);
                        
  dwndWhisperName.Left := DEditChat.SurfaceX(DEditChat.Left);
  dwndWhisperName.Height := 144;
  dwndWhisperName.Top := DEditChat.SurfaceY(DEditChat.Top) - dwndWhisperName.Height;
  dwndWhisperName.Width := 120;

  //表情窗口
  DWndFace.Width := FACESHOWCOUNT * 24 + 8;
  DWndFace.Left := g_FScreenWidth - DWndFace.Width - 205;
  DWndFace.Height := 8 + ((High(g_FaceIndexList) + 1) div FACESHOWCOUNT + 1) * 24;
  DWndFace.Top := DBTFace.SurfaceY(DBTFace.Top) - DWndFace.Height;
  //显示装备窗口

  DBTItemShowClose.SetImgIndex(g_WMain99Images, 294);
  DBTItemShowClose.Top := 4;
  DBTItemShowClose.Left := 0;

  //人物状态窗口
  d := g_WMain99Images.Images[2298]; //惑怕  370
  if d <> nil then begin
    DStateWin.SetImgIndex(g_WMain99Images, 2298);
    DStateWin.Left := g_FScreenWidth - d.Width;
    DStateWin.Top := 0;
  end;
  DCloseState.SetImgIndex(g_WMain99Images, 1850);
  DCloseState.Top := 24;
  DCloseState.Left := 259;

  DStateWinItem.Left := 47;
  DStateWinItem.Top := 47;
  DStateWinItem.Width := 242;
  DStateWinItem.Height := 327;

  DStateWinInfo.Left := 16;
  DStateWinInfo.Top := 90;
  DStateWinInfo.Width := 242;
  DStateWinInfo.Height := 327;

  DStateWinAbil.Left := 16;
  DStateWinAbil.Top := 90;
  DStateWinAbil.Width := 242;
  DStateWinAbil.Height := 327;

  DStateWinMagic.Left := 34;
  DStateWinMagic.Top := 73;
  DStateWinMagic.Width := 242;
  DStateWinMagic.Height := 327;

  DStateWinHorse.Left := 16;
  DStateWinHorse.Top := 90;
  DStateWinHorse.Width := 242;
  DStateWinHorse.Height := 327;

  DStateWinState.Left := 16;
  DStateWinState.Top := 90;
  DStateWinState.Width := 242;
  DStateWinState.Height := 327;

  DStateBTItem.SetImgIndex(g_WMain99Images, 2305);
  DStateBTItem.Top := 61;
  DStateBTItem.Left := 0;
  DStateBTState.SetImgIndex(g_WMain99Images, 2307);
  DStateBTState.Top := 111;
  DStateBTState.Left := 0;
  DStateBTState.Visible := True;
  DStateBTAbil.SetImgIndex(g_WMain99Images, 2309);
  DStateBTAbil.Top := 161;
  DStateBTAbil.Left := 0;
  DStateBTMagic.SetImgIndex(g_WMain99Images, 2311);
  DStateBTMagic.Top := 211;
  DStateBTMagic.Left := 0;
  DStateBTHorse.SetImgIndex(g_WMain99Images, 2313);
  DStateBTHorse.Top := 261;
  DStateBTHorse.Left := 0;
  DStateBTInfo.SetImgIndex(g_WMain99Images, 2315);
  DStateBTInfo.Top := 311;
  DStateBTInfo.Left := 0;


  //CharState Window Item Locations
  DSWWeapon.Left := 1;
  DSWWeapon.Top := 38;
  DSWWeapon.Width := 34;
  DSWWeapon.Height := 30;
  DSWDress.Left := 1;
  DSWDress.Top := 87;
  DSWDress.Width := 34;
  DSWDress.Height := 30;
  DSWArmRingR.Left := 1;
  DSWArmRingR.Top := 134;
  DSWArmRingR.Width := 34;
  DSWArmRingR.Height := 30;
  DSWRingR.Left := 1;
  DSWRingR.Top := 181;
  DSWRingR.Width := 34;
  DSWRingR.Height := 30;
  DSWBelt.Left := 71;
  DSWBelt.Top := 230;
  DSWBelt.Width := 34;
  DSWBelt.Height := 30;
  DSWHelmet.Left := 192;
  DSWHelmet.Top := 42;
  DSWHelmet.Width := 34;
  DSWHelmet.Height := 30;
  DSWNecklace.Left := 192;
  DSWNecklace.Top := 86;
  DSWNecklace.Width := 34;
  DSWNecklace.Height := 30;
  DSWLight.Left := 143;
  DSWLight.Top := 282;
  DSWLight.Width := 34;
  DSWLight.Height := 30;
  DSWArmRingL.Left := 191;
  DSWArmRingL.Top := 134;
  DSWArmRingL.Width := 34;
  DSWArmRingL.Height := 30;
  DSWRingL.Left := 192;
  DSWRingL.Top := 181;
  DSWRingL.Width := 34;
  DSWRingL.Height := 30;
  DSWBoots.Left := 121;
  DSWBoots.Top := 228;
  DSWBoots.Width := 34;
  DSWBoots.Height := 30;
  DSWBujuk.Left := 52;
  DSWBujuk.Top := 282;
  DSWBujuk.Width := 34;
  DSWBujuk.Height := 30;
  DSWHouse.Left := 96;
  DSWHouse.Top := 282;
  DSWHouse.Width := 34;
  DSWHouse.Height := 30;
  DSWCharm.Left := 168;
  DSWCharm.Top := 228;
  DSWCharm.Width := 34;
  DSWCharm.Height := 30;
  DSWCowry.Left := 26;
  DSWCowry.Top := 229;
  DSWCowry.Width := 34;
  DSWCowry.Height := 30;


  //人物属性
  DStateAbilOk.SetImgIndex(g_WMain99Images, 1685);
  DStateAbilOk.Top := 137;
  DStateAbilOk.Left := 137;
  DStateAbilOK.OnDirectPaint := DButRenewChrDirectPaint;

  DStateAbilExit.SetImgIndex(g_WMain99Images, 1683);
  DStateAbilExit.Top := 137;
  DStateAbilExit.Left := 184;
  DStateAbilExit.OnDirectPaint := DButRenewChrDirectPaint;

  DStateAbilAdd1.SetImgIndex(g_WMain99Images, 402);
  DStateAbilAdd1.Top := 157;
  DStateAbilAdd1.Left := 94;
  DStateAbilAdd2.SetImgIndex(g_WMain99Images, 402);
  DStateAbilAdd2.Top := 157 + 1 * 16;
  DStateAbilAdd2.Left := 94;
  DStateAbilAdd3.SetImgIndex(g_WMain99Images, 402);
  DStateAbilAdd3.Top := 157 + 2 * 16;
  DStateAbilAdd3.Left := 94;
  DStateAbilAdd4.SetImgIndex(g_WMain99Images, 402);
  DStateAbilAdd4.Top := 157 + 3 * 16;
  DStateAbilAdd4.Left := 94;
  DStateAbilAdd5.SetImgIndex(g_WMain99Images, 402);
  DStateAbilAdd5.Top := 157 + 4 * 16;
  DStateAbilAdd5.Left := 94;
  DStateAbilAdd6.SetImgIndex(g_WMain99Images, 402);
  DStateAbilAdd6.Top := 157 + 5 * 16;
  DStateAbilAdd6.Left := 94;

  DStateAbilDel1.SetImgIndex(g_WMain99Images, 408);
  DStateAbilDel1.Top := 157;
  DStateAbilDel1.Left := 108;
  DStateAbilDel2.SetImgIndex(g_WMain99Images, 408);
  DStateAbilDel2.Top := 157 + 1 * 16;
  DStateAbilDel2.Left := 108;
  DStateAbilDel3.SetImgIndex(g_WMain99Images, 408);
  DStateAbilDel3.Top := 157 + 2 * 16;
  DStateAbilDel3.Left := 108;
  DStateAbilDel4.SetImgIndex(g_WMain99Images, 408);
  DStateAbilDel4.Top := 157 + 3 * 16;
  DStateAbilDel4.Left := 108;
  DStateAbilDel5.SetImgIndex(g_WMain99Images, 408);
  DStateAbilDel5.Top := 157 + 4 * 16;
  DStateAbilDel5.Left := 108;
  DStateAbilDel6.SetImgIndex(g_WMain99Images, 408);
  DStateAbilDel6.Top := 157 + 5 * 16;
  DStateAbilDel6.Left := 108;

  //Magic Window
  DStateGrid.Top := 40;
  DStateGrid.Left := 21;
  DStateGrid.Width := 31;
  DStateGrid.Height := 230;
  DStateGrid.ColWidth := 31;
  DStateGrid.Coloffset := 0;
  DStateGrid.ColCount := 1;
  DStateGrid.RowHeight := 32;
  DStateGrid.RowCount := 5;
  DStateGrid.Rowoffset := 16;

  DMagicFront.SetImgIndex(g_WMain99Images, 2196);
  DMagicFront.Top := 102;
  DMagicFront.Left := 227;
  DMagicNext.SetImgIndex(g_WMain99Images, 2199);
  DMagicNext.Top := 154;
  DMagicNext.Left := 227;
  DMagicCBOSetup.SetImgIndex(g_WMain99Images, 1805);
  DMagicCBOSetup.Top := 8;
  DMagicCBOSetup.Left := 169;
  DMagicCBOSetup.OnDirectPaint := DButRenewChrDirectPaint;

  DMagicBase.SetImgIndex(g_WMain99Images, 2317);
  DMagicBase.Top := 10;
  DMagicBase.Left := 18;
  DMagicBase.Width := 66;
  DMagicCbo.SetImgIndex(g_WMain99Images, 2317);
  DMagicCbo.Top := 10;
  DMagicCbo.Left := 89;
  DMagicCbo.Width := 64;
  DMagicSub.SetImgIndex(g_WMain99Images, 1765);
  DMagicSub.Top := 44 - 37;
  DMagicSub.Left := 185 - 8;
  DMagicSub.Visible := False;

  DMakeMagicAdd1.SetImgIndex(g_WMain99Images, 640);
  DMakeMagicAdd1.Top := 77; //128,
  DMakeMagicAdd1.Left := 46; // 163
  DMakeMagicAdd3.SetImgIndex(g_WMain99Images, 640);
  DMakeMagicAdd3.Top := 77 + 51; //128,
  DMakeMagicAdd3.Left := 46; // 163
  DMakeMagicAdd5.SetImgIndex(g_WMain99Images, 640);
  DMakeMagicAdd5.Top := 77 + 51 * 2; //128,
  DMakeMagicAdd5.Left := 46; // 163
  DMakeMagicAdd7.SetImgIndex(g_WMain99Images, 640);
  DMakeMagicAdd7.Top := 77 + 51 * 3; //128,
  DMakeMagicAdd7.Left := 46; // 163
  DMakeMagicAdd9.SetImgIndex(g_WMain99Images, 640);
  DMakeMagicAdd9.Top := 77 + 51 * 4; //128,
  DMakeMagicAdd9.Left := 46; // 163

  DMakeMagicAdd2.SetImgIndex(g_WMain99Images, 640);
  DMakeMagicAdd2.Top := 77; //128,
  DMakeMagicAdd2.Left := 163; // 163
  DMakeMagicAdd4.SetImgIndex(g_WMain99Images, 640);
  DMakeMagicAdd4.Top := 77 + 51; //128,
  DMakeMagicAdd4.Left := 163; // 163
  DMakeMagicAdd6.SetImgIndex(g_WMain99Images, 640);
  DMakeMagicAdd6.Top := 77 + 51 * 2; //128,
  DMakeMagicAdd6.Left := 163; // 163
  DMakeMagicAdd8.SetImgIndex(g_WMain99Images, 640);
  DMakeMagicAdd8.Top := 77 + 51 * 3; //128,
  DMakeMagicAdd8.Left := 163; // 163
  DMakeMagicAdd10.SetImgIndex(g_WMain99Images, 640);
  DMakeMagicAdd10.Top := 77 + 51 * 4; //128,
  DMakeMagicAdd10.Left := 163; // 163

  //连击设置
  d := g_WMain99Images.Images[1771]; //惑怕  370
  if d <> nil then begin
    DStateWinMagicCbo.SetImgIndex(g_WMain99Images, 1771);
    DStateWinMagicCbo.Left := DStateWinMagicCbo.LocalX(DStateWin.Left);
    DStateWinMagicCbo.Top := DStateWinMagicCbo.LocalY(DStateWin.Top + DStateWin.Height);
    {DStateWinMagicCbo.Left := (DStateWinMagic.Width - d.Width) div 2;
    DStateWinMagicCbo.Top := 0;}
    //
  end;

  DStateWinMagicCboClose.SetImgIndex(g_WMain99Images, 1850);
  DStateWinMagicCboClose.Top := 15;
  DStateWinMagicCboClose.Left := 292;

  DStateWinMagicCboICO.Top := 46;
  DStateWinMagicCboICO.Left := 33;
  DStateWinMagicCboICO.Width := 31;
  DStateWinMagicCboICO.Height := 32;

  DStateWinMagicCboGrid.Top := 46;
  DStateWinMagicCboGrid.Left := 102;
  DStateWinMagicCboGrid.Width := 166;
  DStateWinMagicCboGrid.Height := 32;
  DStateWinMagicCboGrid.ColWidth := 31;
  DStateWinMagicCboGrid.ColOffset := 14;

  DStateWinMagicCboOK.SetImgIndex(g_WMain99Images, 1685);
  DStateWinMagicCboOK.Top := 114;
  DStateWinMagicCboOK.Left := 176;
  DStateWinMagicCboOK.OnDirectPaint := DButRenewChrDirectPaint;
  DStateWinMagicCboExit.SetImgIndex(g_WMain99Images, 1683);
  DStateWinMagicCboExit.Top := 114;
  DStateWinMagicCboExit.Left := 233;
  DStateWinMagicCboExit.OnDirectPaint := DButRenewChrDirectPaint;

  //个人信息

  DStateInfoName.Top := -1;
  DStateInfoName.Left := 172;
  DStateInfoName.Width := 63;
  DStateInfoName.Height := 16;
  DStateInfoAge.Top := 20;
  DStateInfoAge.Left := 172;
  DStateInfoAge.Width := 63;
  DStateInfoAge.Height := 16;

  DStateInfoSex.SetImgIndex(g_WMain99Images, 2153);
  DStateInfoSex.Top := 41;
  DStateInfoSex.Left := 172;
  DStateInfoSex.Width := 81;
  DStateInfoSex.Height := 16;
  DStateInfoSex.UpDown.SetImgIndex(g_WMain99Images, 120);
  DStateInfoSex.UpDown.Offset := 1;
  DStateInfoSex.UpDown.Normal := True;
  DStateInfoSex.UpDown.UpButton.SetImgIndex(g_WMain99Images, 2147);
  DStateInfoSex.UpDown.DownButton.SetImgIndex(g_WMain99Images, 2150);
  DStateInfoSex.UpDown.MoveButton.SetImgIndex(g_WMain99Images, 2144);

  DStateInfoProvince.SetImgIndex(g_WMain99Images, 2153);
  DStateInfoProvince.ImageWidth := DStateInfoProvince.Width;
  DStateInfoProvince.Top := 62;
  DStateInfoProvince.Left := 172;
  DStateInfoProvince.Width := 81;
  DStateInfoProvince.Height := 16;
  DStateInfoProvince.UpDown.SetImgIndex(g_WMain99Images, 120);
  DStateInfoProvince.UpDown.Offset := 1;
  DStateInfoProvince.UpDown.Normal := True;
  DStateInfoProvince.UpDown.UpButton.SetImgIndex(g_WMain99Images, 2147);
  DStateInfoProvince.UpDown.DownButton.SetImgIndex(g_WMain99Images, 2150);
  DStateInfoProvince.UpDown.MoveButton.SetImgIndex(g_WMain99Images, 2144);

  //Disabled
  DStateInfoCity.Visible := False;
  DStateInfoCity.SetImgIndex(g_WMain99Images, 2153);
  DStateInfoCity.ImageWidth := DStateInfoCity.Width;
  DStateInfoCity.Top := 91 - ntop;
  DStateInfoCity.Left := 156 + nleft;
  DStateInfoCity.Width := 96;
  DStateInfoCity.Height := 16;
  DStateInfoCity.UpDown.SetImgIndex(g_WMain99Images, 120);
  DStateInfoCity.UpDown.Offset := 1;
  DStateInfoCity.UpDown.Normal := True;
  DStateInfoCity.UpDown.UpButton.SetImgIndex(g_WMain99Images, 2147);
  DStateInfoCity.UpDown.DownButton.SetImgIndex(g_WMain99Images, 2150);
  DStateInfoCity.UpDown.MoveButton.SetImgIndex(g_WMain99Images, 2144);
  //Disabled
  DStateInfoArea.Visible := False;
  DStateInfoArea.SetImgIndex(g_WMain99Images, 2153);
  DStateInfoArea.ImageWidth := DStateInfoArea.Width;
  DStateInfoArea.Top := 112 - ntop;
  DStateInfoArea.Left := 156 + nleft;
  DStateInfoArea.Width := 96;
  DStateInfoArea.Height := 16;
  DStateInfoArea.UpDown.SetImgIndex(g_WMain99Images, 120);
  DStateInfoArea.UpDown.Offset := 1;
  DStateInfoArea.UpDown.Normal := True;
  DStateInfoArea.UpDown.UpButton.SetImgIndex(g_WMain99Images, 2147);
  DStateInfoArea.UpDown.DownButton.SetImgIndex(g_WMain99Images, 2150);
  DStateInfoArea.UpDown.MoveButton.SetImgIndex(g_WMain99Images, 2144);

  DStateInfoAM.SetImgIndex(g_WMain99Images, 151);
  DStateInfoAM.Left := 140;
  DStateInfoAM.Top := 106;
  DStateInfoNight.SetImgIndex(g_WMain99Images, 151);
  DStateInfoNight.Left := 140;
  DStateInfoNight.Top := 126;
  DStateInfoPM.SetImgIndex(g_WMain99Images, 151);
  DStateInfoPM.Left := 200;
  DStateInfoPM.Top := 106;
  DStateInfoMidNight.SetImgIndex(g_WMain99Images, 151);
  DStateInfoMidNight.Left := 200;
  DStateInfoMidNight.Top := 126;
  
  DStateInfoFriend.SetImgIndex(g_WMain99Images, 151);
  DStateInfoFriend.Left := 42;
  DStateInfoFriend.Top := 229;

  DStateInfoRefPic.SetImgIndex(g_WMain99Images, 2322);
  DStateInfoRefPic.Left := 34;
  DStateInfoRefPic.Top := 127;
  DStateInfoRefPic.DFColor := $FFFFFF;
  DStateInfoRefPic.Caption := 'Ref';
  DStateInfoRefPic.OnDirectPaint := DStateInfoRefPicDirectPaint;
  DStateInfoUpLoadPic.SetImgIndex(g_WMain99Images, 2322);
  DStateInfoUpLoadPic.Left := 87;
  DStateInfoUpLoadPic.Top := 127;
  DStateInfoUpLoadPic.DFColor := $FFFFFF;
  DStateInfoUpLoadPic.Caption := 'Upload';
  DStateInfoUpLoadPic.OnDirectPaint := DStateInfoRefPicDirectPaint;

  DStateInfoSave.SetImgIndex(g_WMain99Images, 2322);
  DStateInfoSave.Left := 146;
  DStateInfoSave.Top := 229;
  DStateInfoSave.DFColor := $FFFFFF;
  DStateInfoSave.Caption := 'Save';
  DStateInfoSave.OnDirectPaint := DBTHintCloseDirectPaint;
  DStateInfoExit.SetImgIndex(g_WMain99Images, 2322);
  DStateInfoExit.Left := 200;
  DStateInfoExit.Top := 229;
  DStateInfoExit.DFColor := $FFFFFF;
  DStateInfoExit.Caption := 'Exit';
  DStateInfoExit.OnDirectPaint := DBTHintCloseDirectPaint;


  DStateInfoMemo.Left := 37;
  DStateInfoMemo.Top := 172;
  DStateInfoMemo.Width := 228;
  DStateInfoMemo.Height := 58;

  //Horse Items
  DHorseRein.Left := 35;
  DHorseRein.Top := 165;
  DHorseRein.Width := 34;
  DHorseRein.Height := 30;
  DHorseBell.Left := 81;
  DHorseBell.Top := 165;
  DHorseBell.Width := 34;
  DHorseBell.Height := 30;
  DHorseSaddle.Left := 126;
  DHorseSaddle.Top := 165;
  DHorseSaddle.Width := 34;
  DHorseSaddle.Height := 30;
  DHorseDecoration.Left := 170;
  DHorseDecoration.Top := 165;
  DHorseDecoration.Width := 34;
  DHorseDecoration.Height := 30;
  DHorseNail.Left := 215;
  DHorseNail.Top := 165;
  DHorseNail.Width := 34;
  DHorseNail.Height := 30;

  //人物状态窗口(查看别人信息)
  d := g_WMain99Images.Images[1770]; //惑怕  370
  if d <> nil then begin
    DUserState.SetImgIndex(g_WMain99Images, 1770);
    DUserState.Left := 357;
    DUserState.Top := 53;
  end;

  DCloseUserState.SetImgIndex(g_WMain99Images, 1850);
  DCloseUserState.Top := 34;
  DCloseUserState.Left := 259;

  DUserStateItem.Left := 16;
  DUserStateItem.Top := 90;
  DUserStateItem.Width := 259;
  DUserStateItem.Height := 255;
  DUserStateInfo.Left := 16;
  DUserStateInfo.Top := 90;
  DUserStateInfo.Width := 259;
  DUserStateInfo.Height := 255;
  DUserStateHorse.Left := 16;
  DUserStateHorse.Top := 90;
  DUserStateHorse.Width := 259;
  DUserStateHorse.Height := 255;

  DUserStateBTItem.SetImgIndex(g_WMain99Images, 1782);
  DUserStateBTItem.Top := 63;
  DUserStateBTItem.Left := 16;

  DUserStateBTHorse.SetImgIndex(g_WMain99Images, 1790);
  DUserStateBTHorse.Top := 63;
  DUserStateBTHorse.Left := 58;
  DUserStateBTInfo.SetImgIndex(g_WMain99Images, 1792);
  DUserStateBTInfo.Top := 63;
  DUserStateBTInfo.Left := 102;


  DUSHorseRein.Left := 22;
  DUSHorseRein.Top := 170;
  DUSHorseRein.Width := 34;
  DUSHorseRein.Height := 30;
  DUSHorseBell.Left := 67;
  DUSHorseBell.Top := 170;
  DUSHorseBell.Width := 34;
  DUSHorseBell.Height := 30;
  DUSHorseSaddle.Left := 112;
  DUSHorseSaddle.Top := 170;
  DUSHorseSaddle.Width := 34;
  DUSHorseSaddle.Height := 30;
  DUSHorseDecoration.Left := 157;
  DUSHorseDecoration.Top := 170;
  DUSHorseDecoration.Width := 34;
  DUSHorseDecoration.Height := 30;
  DUSHorseNail.Left := 202;
  DUSHorseNail.Top := 170;
  DUSHorseNail.Width := 34;
  DUSHorseNail.Height := 30;

  //人物装备
  nx := 5;
  ny := 64;
  DWeaponUS1.Left := nx;
  DWeaponUS1.Top := ny;
  DWeaponUS1.Width := 34;
  DWeaponUS1.Height := 30;
  DDressUS1.Left := nx;
  DDressUS1.Top := ny + 1 * 39;
  DDressUS1.Width := 34;
  DDressUS1.Height := 30;
  DArmRingRUS1.Left := nx;
  DArmRingRUS1.Top := ny + 2 * 39;
  DArmRingRUS1.Width := 34;
  DArmRingRUS1.Height := 30;
  DRingRUS1.Left := nx;
  DRingRUS1.Top := ny + 3 * 39;
  DRingRUS1.Width := 34;
  DRingRUS1.Height := 30;
  DBeltUS1.Left := nx;
  DBeltUS1.Top := ny + 4 * 39;
  DBeltUS1.Width := 34;
  DBeltUS1.Height := 30;

  //nx := 372;
  //ny := 125;
  nx := 220;
  ny := 25;
  DHelmetUS1.Left := nx;
  DHelmetUS1.Top := ny;
  DHelmetUS1.Width := 34;
  DHelmetUS1.Height := 30;
  DNecklaceUS1.Left := nx;
  DNecklaceUS1.Top := ny + 1 * 39;
  DNecklaceUS1.Width := 34;
  DNecklaceUS1.Height := 30;
  DLightUS1.Left := nx;
  DLightUS1.Top := ny + 2 * 39;
  DLightUS1.Width := 34;
  DLightUS1.Height := 30;
  DArmRingLUS1.Left := nx;
  DArmRingLUS1.Top := ny + 3 * 39;
  DArmRingLUS1.Width := 34;
  DArmRingLUS1.Height := 30;
  DRingLUS1.Left := nx;
  DRingLUS1.Top := ny + 4 * 39;
  DRingLUS1.Width := 34;
  DRingLUS1.Height := 30;
  DBootsUS1.Left := nx;
  DBootsUS1.Top := ny + 5 * 39;
  DBootsUS1.Width := 34;
  DBootsUS1.Height := 30;

  //nx := 200;
  //ny := 300;
  nx := 48;
  ny := 220;
  DBujukUS1.Left := nx;
  DBujukUS1.Top := ny;
  DBujukUS1.Width := 34;
  DBujukUS1.Height := 30;
  DHouseUS1.Left := nx + 1 * 43;
  DHouseUS1.Top := ny;
  DHouseUS1.Width := 34;
  DHouseUS1.Height := 30;
  DCharmUS1.Left := nx + 2 * 43;
  DCharmUS1.Top := ny;
  DCharmUS1.Width := 34;
  DCharmUS1.Height := 30;
  DCowryUS1.Left := nx + 3 * 43;
  DCowryUS1.Top := ny;
  DCowryUS1.Width := 34;
  DCowryUS1.Height := 30;

  //个人信息
 { nx := 17;
  ny := 7;
  DUserStateInfoName.Top := -1 - ny;
  DUserStateInfoName.Left := 156 + nx;   }
  DUserStateInfoName.Top := 7;
  DUserStateInfoName.Left := 156;
  DUserStateInfoName.Width := 63;
  DUserStateInfoName.Height := 16;
  DUserStateInfoAge.Top := 20 - ny;
  DUserStateInfoAge.Left := 156 + nx;
  DUserStateInfoAge.Width := 63;
  DUserStateInfoAge.Height := 16;


  DUserStateInfoSex.Top := 41 - ny;
  DUserStateInfoSex.Left := 156 + nx;
  DUserStateInfoSex.Width := 63;
  DUserStateInfoSex.Height := 16;



  DUserStateInfoProvince.Top := 70 - ny;
  DUserStateInfoProvince.Left := 156 + nx;
  DUserStateInfoProvince.Width := 96;
  DUserStateInfoProvince.Height := 16;

  DUserStateInfoCity.Top := 91 - ny;
  DUserStateInfoCity.Left := 156 + nx;
  DUserStateInfoCity.Width := 96;
  DUserStateInfoCity.Height := 16;

  DUserStateInfoArea.Top := 112 - ny;
  DUserStateInfoArea.Left := 156 + nx;
  DUserStateInfoArea.Width := 96;
  DUserStateInfoArea.Height := 16;


  DUserStateInfoAM.SetImgIndex(g_WMain99Images, 151);
  DUserStateInfoAM.Left := 175 - 20;
  DUserStateInfoAM.Top := 202 - 69;
  DUserStateInfoPM.SetImgIndex(g_WMain99Images, 151);
  DUserStateInfoPM.Left := 222 - 20;
  DUserStateInfoPM.Top := 202 - 69;
  DUserStateInfoNight.SetImgIndex(g_WMain99Images, 151);
  DUserStateInfoNight.Left := 175 - 20;
  DUserStateInfoNight.Top := 222 - 70;
  DUserStateInfoMidNight.SetImgIndex(g_WMain99Images, 151);
  DUserStateInfoMidNight.Left := 222 - 20;
  DUserStateInfoMidNight.Top := 222 - 70;
  
  DUserStateInfoFriend.SetImgIndex(g_WMain99Images, 151);
  DUserStateInfoFriend.Left := 14;
  DUserStateInfoFriend.Top := 235;

  DUserStateInfoRefPic.SetImgIndex(g_WMain99Images, 1794);
  DUserStateInfoRefPic.Left := 34;
  DUserStateInfoRefPic.Top := 132;
  DUserStateInfoRefPic.OnDirectPaint := DStateInfoRefPicDirectPaint;
  DUserStateInforeport.SetImgIndex(g_WMain99Images, 1800);
  DUserStateInforeport.Left := 34;
  DUserStateInforeport.Top := 150;
  DUserStateInforeport.OnDirectPaint := DStateInfoRefPicDirectPaint;

  DUserStateInfoMemo.Left := 16;
  DUserStateInfoMemo.Top := 172;
  DUserStateInfoMemo.Width := 228;
  DUserStateInfoMemo.Height := 58;

  {d := g_WMain99Images.Images[238]; //惑怕  370
  if d <> nil then begin
    DUserState1.SetImgIndex(g_WMain99Images, 238);
    DUserState1.Left := 50;
    DUserState1.Top := 74;
  end;

  DCloseUS1.SetImgIndex(g_WMain99Images, 133);
  DCloseUS1.Top := 8;
  DCloseUS1.Left := DUserState1.Width - DCloseUS1.Width - 4;

  nx := 17;
  ny := 160;
  DWeaponUS1.Left := nx;
  DWeaponUS1.Top := ny;
  DWeaponUS1.Width := 36;
  DWeaponUS1.Height := 32;
  DDressUS1.Left := nx;
  DDressUS1.Top := ny + 1 * 35;
  DDressUS1.Width := 36;
  DDressUS1.Height := 32;
  DArmRingRUS1.Left := nx;
  DArmRingRUS1.Top := ny + 2 * 35;
  DArmRingRUS1.Width := 36;
  DArmRingRUS1.Height := 32;
  DRingRUS1.Left := nx;
  DRingRUS1.Top := ny + 3 * 35;
  DRingRUS1.Width := 36;
  DRingRUS1.Height := 32;
  DBeltUS1.Left := nx;
  DBeltUS1.Top := ny + 4 * 35;
  DBeltUS1.Width := 36;
  DBeltUS1.Height := 32;

  nx := 232;
  ny := 125;
  DHelmetUS1.Left := nx;
  DHelmetUS1.Top := ny;
  DHelmetUS1.Width := 36;
  DHelmetUS1.Height := 32;
  DNecklaceUS1.Left := nx;
  DNecklaceUS1.Top := ny + 1 * 35;
  DNecklaceUS1.Width := 36;
  DNecklaceUS1.Height := 32;
  DLightUS1.Left := nx;
  DLightUS1.Top := ny + 2 * 35;
  DLightUS1.Width := 36;
  DLightUS1.Height := 32;
  DArmRingLUS1.Left := nx;
  DArmRingLUS1.Top := ny + 3 * 35;
  DArmRingLUS1.Width := 36;
  DArmRingLUS1.Height := 32;
  DRingLUS1.Left := nx;
  DRingLUS1.Top := ny + 4 * 35;
  DRingLUS1.Width := 36;
  DRingLUS1.Height := 32;
  DBootsUS1.Left := nx;
  DBootsUS1.Top := ny + 5 * 35;
  DBootsUS1.Width := 36;
  DBootsUS1.Height := 32;

  nx := 60;
  ny := 300;
  DBujukUS1.Left := nx;
  DBujukUS1.Top := ny;
  DBujukUS1.Width := 36;
  DBujukUS1.Height := 32;
  DHouseUS1.Left := nx + 1 * 43;
  DHouseUS1.Top := ny;
  DHouseUS1.Width := 36;
  DHouseUS1.Height := 32;
  DCharmUS1.Left := nx + 2 * 43;
  DCharmUS1.Top := ny;
  DCharmUS1.Width := 36;
  DCharmUS1.Height := 32;
  DCowryUS1.Left := nx + 3 * 43;
  DCowryUS1.Top := ny;
  DCowryUS1.Width := 36;
  DCowryUS1.Height := 32;    }

  //商人对话框
  d := g_WMain99Images.Images[1933];
  if d <> nil then begin
    DMerchantDlg.SetImgIndex(g_WMain99Images, 1933);
    DMerchantDlg.Left := 0;
    DMerchantDlg.Top := 0;
  end;

  DMerchantDlgClose.SetImgIndex(g_WMain99Images, 1850);
  DMerchantDlgClose.Left := 392;
  DMerchantDlgClose.Top := 0;

  DMDlgUpDonw.SetImgIndex(g_WMain99Images, 120);
  DMDlgUpDonw.Top := 23;
  DMDlgUpDonw.Left := 382;
  DMDlgUpDonw.Height := 158;
  DMDlgUpDonw.Offset := 1;
  DMDlgUpDonw.Normal := True;

  DMDlgUpDonw.UpButton.SetImgIndex(g_WMain99Images, 2147);
  DMDlgUpDonw.DownButton.SetImgIndex(g_WMain99Images, 2150);
  DMDlgUpDonw.MoveButton.SetImgIndex(g_WMain99Images, 2144); //114

  //new shop window
  nShopSelectionIdx := -1;
  LastSubListRequest := FrmMain.m_CurrentTick;
  d := g_WMain99Images.Images[1657];
  if d <> nil then begin
    DMenuDlg.SetImgIndex(g_WMain99Images, 1657);
    DMenuDlg.Left := 32;
    DMenuDlg.Top := 24;
  end;
  DMenuClose.SetImgIndex(g_WMain99Images, 1850);
  DMenuClose.Left := 272;
  DMenuClose.Top := 13;

  DMenuGrid.Top := 67;
  DMenuGrid.Left := 18;
  DMenuGrid.Width := 248;
  DMenuGrid.Height := 235;
  DMenuGrid.ColWidth := 248;
  DMenuGrid.Coloffset := 1;
  DMenuGrid.ColCount := 1;
  DMenuGrid.RowHeight := 47;
  DMenuGrid.Rowoffset := 1;
  DMenuGrid.RowCount := 5;
  //DMenuGrid.Visible := false;

  DMenuUpDonw.SetImgIndex(g_WMain99Images, 120);
  DMenuUpDonw.Top := 67;
  DMenuUpDonw.Left := 267;
  DMenuUpDonw.Height := 234;
  DMenuUpDonw.Offset := 1;
  DMenuUpDonw.Normal := True;

  DMenuUpDonw.UpButton.SetImgIndex(g_WMain99Images, 2147);
  DMenuUpDonw.DownButton.SetImgIndex(g_WMain99Images, 2150);
  DMenuUpDonw.MoveButton.SetImgIndex(g_WMain99Images, 2144);

//  DMenuShop.SetImgIndex(g_WMain99Images, 1735);
  DMenuShop.SetImgIndex(g_WMain99Images, 1650);
  DMenuShop.Left := 68;
  DMenuShop.Top := 45;
  DMenuReturn.SetImgIndex(g_WMain99Images, 1650);
  DMenuReturn.Left := 148;
  DMenuReturn.Top := 45;

  DMenuBuy.SetImgIndex(g_WMain99Images, 1652);
  DMenuBuy.Left := 18;
  DMenuBuy.Top := 329;
  DMenuBuy.OnDirectPaint := DBTHintCloseDirectPaint;
  DMenuBuy.DFColor := $ADD6EF;
  DMenuSell.SetImgIndex(g_WMain99Images, 1652);
  DMenuSell.Left := 212;
  DMenuSell.Top := 329;
  DMenuSell.OnDirectPaint := DBTHintCloseDirectPaint;
  DMenuSell.DFColor := $ADD6EF;

  DMenuRepair.SetImgIndex(g_WMain99Images, 1652);
  DMenuRepair.Left := 79;
  DMenuRepair.Top := 224;
  DMenuRepair.OnDirectPaint := DBTHintCloseDirectPaint;
  DMenuRepair.DFColor := $ADD6EF;
  DMenuRepairAll.SetImgIndex(g_WMain99Images, 1652);
  DMenuRepairAll.Left := 79;
  DMenuRepairAll.Top := 252;
  DMenuRepairAll.OnDirectPaint := DBTHintCloseDirectPaint;
  DMenuRepairAll.DFColor := $ADD6EF;

  DMenuSuperRepair.SetImgIndex(g_WMain99Images, 1652);
  DMenuSuperRepair.Left := 142;
  DMenuSuperRepair.Top := 224;
  DMenuSuperRepair.OnDirectPaint := DBTHintCloseDirectPaint;
  DMenuSuperRepair.DFColor := $ADD6EF;
  DMenuSuperRepairAll.SetImgIndex(g_WMain99Images, 1652);
  DMenuSuperRepairAll.Left := 142;
  DMenuSuperRepairAll.Top := 252;
  DMenuSuperRepairAll.OnDirectPaint := DBTHintCloseDirectPaint;
  DMenuSuperRepairAll.DFColor := $ADD6EF;

  //sub goods list window
  nSubShopSelectionIdx := -1;
  nSubShopSelAniIndex := 0;
  SubshopAniTick := FrmMain.m_CurrentTick;
  DSubShop.SetImgIndex(g_WMain99Images, 1736);
  DSubShop.Left := DMenuDlg.Left + DMenuDlg.Width;
  DSubShop.Top := DMenuDlg.Top + DMenuDlg.Height - DSubShop.Height;

  DSubShopClose.SetImgIndex(g_WMain99Images, 1850);
  DSubShopClose.Left := 190;
  DSubShopClose.Top := 2;

  DSubShopGrid.Top := 50;
  DSubShopGrid.Left := 27;
  DSubShopGrid.Width := 141;
  DSubShopGrid.Height := 158;
  DSubShopGrid.ColWidth := 33;
  DSubShopGrid.Coloffset := 3;
  DSubShopGrid.ColCount := 4;
  DSubShopGrid.RowHeight := 30;
  DSubShopGrid.Rowoffset := 2;
  DSubShopGrid.RowCount := 5;

  DSubShopUpDown.SetImgIndex(g_WMain99Images, 120);
  DSubShopUpDown.Top := 44;
  DSubShopUpDown.Left := 175;
  DSubShopUpDown.Height := 170;
  DSubShopUpDown.Offset := 1;
  DSubShopUpDown.Normal := True;

  DSubShopUpDown.UpButton.SetImgIndex(g_WMain99Images, 2147);
  DSubShopUpDown.DownButton.SetImgIndex(g_WMain99Images, 2150);
  DSubShopUpDown.MoveButton.SetImgIndex(g_WMain99Images, 2144);

  DSubShopBuy.SetImgIndex(g_WMain99Images, 1652);
  DSubShopBuy.Left := 143;
  DSubShopBuy.Top := 220;


  //sell window
  DSaleDlg.SetImgIndex(g_WUI3Images, 272);
  DSaleDlg.Top := DMenuDlg.Height + DMenuDlg.Top;
  DSaleDlg.Left := DMenuDlg.Left + DMenuDlg.Width - DSaleDlg.Width;

  DSaleDlgClose.SetImgIndex(g_WMain2Images, 148);
  DSaleDlgClose.Top := 0;
  DSaleDlgClose.Left := 129;

  DSaleDlgSell.SetImgIndex(g_WUI3Images, 274);
  DSaleDlgSell.Left := 88;
  DSaleDlgSell.Top := 153;

  DSaleDlgSpot.Left := 25;
  DSaleDlgSpot.Top := 65;
  DSaleDlgSpot.Width := 81;
  DSaleDlgSpot.Height := 81;

  DSaleDlgLock.SetImgIndex(g_WUI3Images, 10);
  DSaleDlgLock.Top := 174;
  DSaleDlgLock.Left := 41;
  DSaleDlgLock.OnDirectPaint := DBTHintCloseDirectPaint;

  //shop
  d := g_WMain99Images.Images[1737];
  if d <> nil then begin
    DWndBuy.SetImgIndex(g_WMain99Images, 1737);
    DWndBuy.Left := 308;
    DWndBuy.Top := 101;
  end;

  DBuyOK.SetImgIndex(g_WMain99Images, 1652);
  DBuyOK.Left := 18;
  DBuyOK.Top := 117;
  DBuyOK.OnDirectPaint := DBTHintCloseDirectPaint;
  DBuyOK.DFColor := $ADD6EF;
  DBuyClose.SetImgIndex(g_WMain99Images, 1652);
  DBuyClose.Left := 77;
  DBuyClose.Top := 117;
  DBuyClose.OnDirectPaint := DBTHintCloseDirectPaint;
  DBuyClose.DFColor := $ADD6EF;
  DBuyAdd.SetImgIndex(g_WMain99Images, 405);
  DBuyAdd.Left := 103;
  DBuyAdd.Top := 68;
  DBuyDel.SetImgIndex(g_WMain99Images, 411);
  DBuyDel.Left := 120;
  DBuyDel.Top := 68;

  DBuyEdit.Left := 52;
  DBuyEdit.Top := 68;
  DBuyEdit.Width := 52;
  DBuyEdit.Height := 16;

  //trade
  d := g_WMain99Images.Images[1714];
  if d <> nil then begin
    DDealDlg.SetImgIndex(g_WMain99Images, 1714);
    DDealDlg.Left := (g_FScreenWidth - d.Width) div 2;
    DDealDlg.Top := 60;
  end;
  DDealClose.SetImgIndex(g_WMain99Images, 1850);
  DDealClose.Left := 259;
  DDealClose.Top := 3;

  DDGold.Left := 26;
  DDGold.Top := 248;
  DDGold.Width := 116;
  DDGold.Height := 19;

  DDGrid.Left := 28;
  DDGrid.Top := 174;
  DDGrid.Width := 213;
  DDGrid.Height := 62;
  DDGrid.ColWidth := 34;
  DDGrid.RowHeight := 30;
  DDGrid.ColOffset := 3;
  DDGrid.RowOffset := 2;

  DDealOk.SetImgIndex(g_WMain99Images, 1652);
  DDealOk.Left := 160;
  DDealOk.Top := 281;
  DDealOk.OnDirectPaint := DBTHintCloseDirectPaint;
  DDealOk.DFColor := $ADD6EF;
  DDealLock.SetImgIndex(g_WMain99Images, 1652);
  DDealLock.Left := 57;
  DDealLock.Top := 281;
  DDealLock.OnDirectPaint := DBTHintCloseDirectPaint;
  DDealLock.DFColor := $ADD6EF;

  DDRGrid.Left := 23;
  DDRGrid.Top := 71 + 4;
  DDRGrid.Width := 209;
  DDRGrid.Height := 69;

  DDRGrid.Left := 28;
  DDRGrid.Top := 54;
  DDRGrid.Width := 213;
  DDRGrid.Height := 62;
  DDRGrid.ColWidth := 34;
  DDRGrid.RowHeight := 30;
  DDRGrid.ColOffset := 3;
  DDRGrid.RowOffset := 2;

  DDRDealOk.SetImgIndex(g_WMain99Images, 151);
  DDRDealOk.Left := 183;
  DDRDealOk.Top := 134;
  DDRDealLock.SetImgIndex(g_WMain99Images, 151);
  DDRDealLock.Left := 223;
  DDRDealLock.Top := 134;

  //队伍窗口
  d := g_WMain99Images.Images[1656];
  if d <> nil then begin
    DGroupDlg.SetImgIndex(g_WMain99Images, 1656);
    DGroupDlg.Left := (g_FScreenWidth - d.Width) div 2;
    DGroupDlg.Top := g_FScreenHeight - d.Height - 199;
  end;

  DGrpDlgClose.SetImgIndex(g_WMain99Images, 1850);
  DGrpDlgClose.Left := 263;
  DGrpDlgClose.Top := 13;

  DGrpAllowGroup.SetImgIndex(g_WMain99Images, 151);
  DGrpAllowGroup.Left := 25;
  DGrpAllowGroup.Top := 53;
  DGrpCheckGroup.SetImgIndex(g_WMain99Images, 151);
  DGrpCheckGroup.Left := 25;
  DGrpCheckGroup.Top := 74;

  DCBGroupItemDef.SetImgIndex(g_WMain99Images, 153);
  DCBGroupItemDef.Left := 167;
  DCBGroupItemDef.Top := 74;
  DCBGroupItemRam.SetImgIndex(g_WMain99Images, 153);
  DCBGroupItemRam.Left := 167;
  DCBGroupItemRam.Top := 53;

  DGrpCreate.SetImgIndex(g_WMain99Images, 2324);
  DGrpCreate.Left := 16;
  DGrpCreate.Top := 360;
  DGrpCreate.DFColor := $ADD6EF;
  DGrpCreate.OnDirectPaint := DBTHintCloseDirectPaint;
  DGrpAddMem.SetImgIndex(g_WMain99Images, 2324);
  DGrpAddMem.Left := 16;
  DGrpAddMem.Top := 197;
  DGrpAddMem.DFColor := $ADD6EF;
  DGrpAddMem.OnDirectPaint := DBTHintCloseDirectPaint;
  DGrpDelMem.SetImgIndex(g_WMain99Images, 2352);
  DGrpDelMem.Left := 166;
  DGrpDelMem.Top := 197;
  DGrpDelMem.DFColor := $ADD6EF;
  DGrpDelMem.OnDirectPaint := DBTHintCloseDirectPaint;
  DGroupExit.SetImgIndex(g_WMain99Images, 2324);
  DGroupExit.Left := 232;
  DGroupExit.Top := 197;
  DGroupExit.DFColor := $ADD6EF;
  DGroupExit.OnDirectPaint := DBTHintCloseDirectPaint;

  DGroupUpDown.SetImgIndex(g_WMain99Images, 120);
  DGroupUpDown.Top := 239;
  DGroupUpDown.Left := 260;
  DGroupUpDown.Height := 116;
  DGroupUpDown.Offset := 1;
  DGroupUpDown.Normal := True;

  DGroupUpDown.UpButton.SetImgIndex(g_WMain99Images, 2147);
  DGroupUpDown.DownButton.SetImgIndex(g_WMain99Images, 2150);
  DGroupUpDown.MoveButton.SetImgIndex(g_WMain99Images, 2144);

  DGrpMemberList.Left := 20;
  DGrpMemberList.Top := 105;
  DGrpMemberList.Width := 238;
  DGrpMemberList.Height := 65;

  DGrpUserList.Left := 20;
  DGrpUserList.Top := 242;
  DGrpUserList.Width := 222;
  DGrpUserList.Height := 114;

  //弹出框
  DPopUpEdits.SetImgIndex(g_WMain99Images, 276);
  DPopUpSayList.SetImgIndex(g_WMain99Images, 276);
  DPopUpPlay.SetImgIndex(g_WMain99Images, 276);
end;

procedure TFrmDlg.InitializeEx();
{var
  i: integer;   }
begin
  DEditChat.CreateSurface(nil);
  DMinMap128.CreateSurface(nil);
  DMerchantDlg.CreateSurface(nil, False);

  DMiniMap.Left := 0;
  DMiniMap.Top := 0;
  DMiniMap.Width := 192;
  DMiniMap.Height := 160;
  DMiniMap.CreateSurface(nil);

  DMerchantDlg.Surface.Size := Point(DEFMDLGMAXWIDTH, MDLGMAXHEIGHT);
  DMerchantDlg.Surface.PatternSize := Point(DEFMDLGMAXWIDTH, MDLGMAXHEIGHT);
  DMerchantDlg.Surface.Active := True;

  DWudItemShow.Width := 400;
  DWudItemShow.Height := 600;
  DWudItemShow.CreateSurface(nil);
  {
    DMinMap128.SetSurface(DDraw, nil);
    DBottom.SetSurface(DDraw, nil);    MDLGMAXWIDTH = 242;
    MDLGMAXHEIGHT = 1024;
    DBottom2.SetSurface(DDraw, nil);
    DEditChat.SetSurface(DDraw, nil);
    DMerchantDlg.SetSurface(DDraw, nil);
    DGuildDlg.SetSurface(DDraw, nil);
    DStateWin.SetSurface(DDraw, nil);
    DUserState.SetSurface(DDraw, nil);
    DEditChat.RefEditSurfce();
    with DBottom.Surface.Canvas do begin
      SetBkMode(Handle, TRANSPARENT);
      for i := 49 to 57 do
        BoldTextOutEx(DBottom.Surface, 18 + (i - 49) * 42, 9, clWhite, $8, Char(i));
      BoldTextOutEx(DBottom.Surface, 18 + 9 * 42, 9, clWhite, $8, '0');
      BoldTextOutEx(DBottom.Surface, 18 + 10 * 42, 9, clWhite, $8, '-');
      BoldTextOutEx(DBottom.Surface, 18 + 11 * 42, 9, clWhite, $8, '=');
      Release;
    end;
    with DBottom2.Surface.Canvas do begin
      SetBkMode(Handle, TRANSPARENT);
      for i := 1 to 8 do
        BoldTextOutEx(DBottom2.Surface, 27 + i * 42, 9, clWhite, $8, 'F' + IntToStr(i));
      Release;
    end;   }
end;

procedure TFrmDlg.LoadAddressList;
var
  i, ii: integer;
  sStr, sTemp: string;
  StringList, StringList2, StringList3: TStringList;
begin
  StringList := nil;
  AddressList.AddObject(' ', nil);
  try
    for i := 0 to DStateInfoCity.Item.Count - 1 do begin
      sStr := DStateInfoCity.Item[i];
      if sStr <> '' then begin
        sStr := ArrestStringEx(sStr, '"', '"', sTemp);
        if (sTemp <> '') and (Length(sTemp) >= 5) then begin
          if StringList = nil then begin
            StringList := TStringList.Create;
          end;
          StringList3 := TStringList.Create;
          StringList3.Add(' ');
          while True do begin
            if sStr = '' then
              break;
            sStr := ArrestStringEx(sStr, '"', '"', sTemp);
            if sTemp = '' then
              break;
            {if length(stemp) > 10 then begin
              CopyStrToClipboard(stemp);
              showmessage(stemp);
            end; }
            StringList3.Add(sTemp);
          end;
          StringList.AddObject(' ', TObject(StringList3));
        end
        else if (sTemp <> '') and (Length(sTemp) < 5) then begin
          StringList2 := TStringList.Create;
          StringList2.AddObject(' ', nil);
          while True do begin
            if (sStr = '') then
              break;
            sStr := ArrestStringEx(sStr, '"', '"', sTemp);
            if sTemp = '' then
              break;
            {if length(stemp) > 10 then begin
              CopyStrToClipboard(stemp);
              showmessage(stemp);
            end;    }
            if (StringList <> nil) and (StringList.Count > 0) then begin
              StringList2.AddObject(sTemp, StringList.Objects[0]);
              StringList.Delete(0);
            end
            else
              StringList2.AddObject(sTemp, nil);
          end;
          if (StringList <> nil) then begin
            if StringList.Count > 0 then begin
              for ii := 0 to StringList.Count - 1 do begin
                TStringList(StringList.Objects[ii]).Free;
              end;
            end;
            StringList.Free;
            StringList := nil;
          end;
          AddressList.AddObject(' ', TObject(StringList2));
        end;
      end;
    end;
    DStateInfoCity.Item.Clear;
    DStateInfoArea.Item.Clear;
  except

  end;
end;

procedure TFrmDlg.ClearAddressList;
var
  I, II: Integer;
  String1: TStringList;
begin
  for i := 0 to AddressList.Count - 1 do begin
    if AddressList.Objects[i] <> nil then begin
      String1 := TStringList(AddressList.Objects[i]);
      for ii := 0 to String1.Count - 1 do begin
        if String1.Objects[ii] <> nil then begin
          TStringList(String1.Objects[ii]).Free;
        end;
      end;
      String1.Free;
    end;
  end;
end;

procedure TFrmDlg.OpenDealDlg;
begin
  DItemBag.Left := 0;
  DItemBag.Top := 0;

  DItemBag.Visible := True;
  DDealDlg.Visible := True;
  g_boDealEnd := False;
  g_boDealLock := False;
  DDRDealLock.Checked := False;
  DDRDealOk.Checked := False;
  DDealOk.Enabled := False;
  DDealLock.Enabled := True;

  g_nDealGold := 0;
  g_nDealRemoteGold := 0;

  SafeFillChar(g_DealItems, sizeof(g_DealItems), #0);
  SafeFillChar(g_DealRemoteItems, sizeof(g_DealRemoteItems), #0);

  ArrangeItembag;
  DScreen.AddSysMsg('You and [<CO$FFFF>' + g_sDealWho + '<CE>] have begun trade transaction', clYellow);
end;

procedure TFrmDlg.CloseDealDlg;
begin
  DDealDlg.Visible := FALSE;
  ArrangeItembag;
end;

procedure TFrmDlg.OpenItemBag;
begin
  DItemBag.Visible := not DItemBag.Visible;
  if DItemBag.Visible then
    ArrangeItembag;
  boOpenItemBag := DItemBag.Visible;
end;

procedure TFrmDlg.OpenMyStatus;
begin
  DStateWin.Visible := not DStateWin.Visible;
  PageChanged;
  boOpenStatus := DStateWin.Visible;
end;

procedure TFrmDlg.DPopUpPlayPopIndex(Sender, DControl: TDControl; ItemIndex: Integer; UserName: string);
var
  Idx: integer;
  Actor: TActor;
begin
  with DControl do begin
    Actor := PlayScene.FindActor(UserName);
    if (Actor <> nil) and (Actor.m_btRace = 0) and (not Actor.m_boDeath) then begin
      case Integer(TDPopUpMemu(Sender).Item.Objects[ItemIndex]) of
        1: ;
        2: FrmMain.SendClientMessage(CM_QUERYUSERSTATE, Actor.m_nRecogId, Actor.m_nCurrX, Actor.m_nCurrY, 0);
        3: PlayScene.SetEditChar(UserName);
        4: FrmMain.SendClientMessage(CM_FRIEND_CHENGE, 0, 0, 0, 0, UserName);
        5: begin
            if g_MyBlacklist.IndexOf(UserName) = -1 then begin
              g_MyBlacklist.Add(UserName)
            end;
          end;
        6: begin
            Idx := g_MyBlacklist.IndexOf(UserName);
            if Idx <> -1 then
              g_MyBlacklist.Delete(idx);
          end;
        7: FrmDlg2.OpenNewMail(UserName);
        8: CreateGroup(UserName);
        9: frmMain.SendGuildAddMem(UserName);
        10: CopyStrToClipboard(UserName);
        11: CopyStrToClipboard(Actor.m_sGuildName);
        12: CopyStrToClipboard(Actor.m_sGuildRankName);
        13: ;
      end;
    end;
  end;
end;

procedure TFrmDlg.OpenPlayPopupMemu(AC: TObject; nX, nY: Integer);
var
  Actor: TActor;
begin
  Actor := TActor(AC);
  with DPopUpPlay do begin
    Visible := False;
    m_boClose := True;
    Item.Clear;
    Item.AddObject('Name: ' + Actor.m_UserName, TObject(-1));
    Item.AddObject('-', nil);
    //Item.AddObject('Report plug-in', TObject(1));
    Item.AddObject('View Character', TObject(2));
    Item.AddObject('Private Chat', TObject(3));
    //Item.AddObject('Dialogues', TObject(13));
    if (not InFriendList(Actor.m_UserName)) and
      (Actor.m_UserName <> g_MySelf.m_UserName) then
      Item.AddObject('Add As Friend', TObject(4))
    else
      Item.AddObject('Add As Friend', nil);

    if (not InBlacklist(Actor.m_UserName)) then
      Item.AddObject('Block Chat', TObject(5))
    else
      Item.AddObject('Unblock Chat', TObject(6));

    if InFriendList(Actor.m_UserName) then
      Item.AddObject('Send Message', TObject(7))
    else
      Item.AddObject('Send Message', nil);
    Item.AddObject('Invite To Group', TObject(8));
    Item.AddObject('Invite To Guild', TObject(9));
    Item.AddObject('-', nil);
    Item.AddObject('Copy Name', TObject(10));
    if Actor.m_sGuildName <> '' then
      Item.AddObject('Copy Guild Name', TObject(11))
    else
      Item.AddObject('Copy Guild Name', nil);

    if Actor.m_sGuildRankName <> '' then
      Item.AddObject('Copy Guild Rank', TObject(12))
    else
      Item.AddObject('Copy Guild Rank', nil);

    RefSize;
    Popup(DBackground, nX, nY, Actor.m_UserName);
  end;
end;

procedure TFrmDlg.OpenSayItemShow(mitem: TNewClientItem);
var
  Point: TPoint;
begin
  with DWudItemShow do begin
    Visible := False;
    Point := DScreen.ShowHint(0, 0, ShowItemInfo(mitem, [], []), clwhite, False, mitem.UserItem.MakeIndex, True,
      Surface, HintDrawList);
    DScreen.ClearHint(True);
    Width := Point.X;
    Height := Point.Y;
    Left := (g_FScreenWidth - Width) div 2;
    Top := (g_FScreenHeight - Height) div 2;
    DBTItemShowClose.Left := Width - 14;
    Visible := True;
  end;
end;

procedure TFrmDlg.OpenUserState(UserState: PTClientStateInfo);
var
  str: string;
  TempStr: string;
  StrList: TStringList;
begin
  UserState1 := UserState^;
  DUserStateInfoName.Text := UserState1.RealityInfo.sUserName;
  if UserState1.RealityInfo.btOld > 0 then
    DUserStateInfoAge.Text := IntToStr(UserState1.RealityInfo.btOld)
  else
    DUserStateInfoAge.Text := '';
  if UserState1.RealityInfo.btSex = 1 then
    DUserStateInfoSex.Text := 'Male'
  else
    DUserStateInfoSex.Text := 'Female';

  DUserStateInfoProvince.Text := '';
  DUserStateInfoCity.Text := '';
  DUserStateInfoArea.Text := '';
  if (UserState1.RealityInfo.btProvince > 0) and
    (UserState1.RealityInfo.btProvince < DStateInfoProvince.Item.Count) and
    (UserState1.RealityInfo.btProvince < AddressList.Count) then begin
    if AddressList.Objects[UserState1.RealityInfo.btProvince] <> nil then begin
      DUserStateInfoProvince.Text := DStateInfoProvince.Item[UserState1.RealityInfo.btProvince];
      StrList := TStringList(AddressList.Objects[UserState1.RealityInfo.btProvince]);
      if (UserState1.RealityInfo.btCity > 0) and (UserState1.RealityInfo.btCity < StrList.Count) then begin
        DUserStateInfoCity.Text := StrList[UserState1.RealityInfo.btCity];
        StrList := TStringList(StrList.Objects[UserState1.RealityInfo.btCity]);
        if (StrList <> nil) and
          (UserState1.RealityInfo.btArea > 0) and (UserState1.RealityInfo.btArea < StrList.Count) then begin
          DUserStateInfoArea.Text := StrList[UserState1.RealityInfo.btArea];
        end;
      end;
    end;
  end;
  DUserStateInfoAM.Checked := CheckByteStatus(UserState1.RealityInfo.btOnlineTime, 0);
  DUserStateInfoPM.Checked := CheckByteStatus(UserState1.RealityInfo.btOnlineTime, 1);
  DUserStateInfoNight.Checked := CheckByteStatus(UserState1.RealityInfo.btOnlineTime, 2);
  DUserStateInfoMidNight.Checked := CheckByteStatus(UserState1.RealityInfo.btOnlineTime, 3);
  DUserStateInfoFriend.Checked := UserState1.RealityInfo.boFriendSee;
  DUserStateInfoMemo.Lines.Clear;
  DUserStateInfoRefPic.Enabled := UserState1.RealityInfo.sPhotoID <> '';
  TempStr := UserState1.RealityInfo.sIdiograph;
  DUserStateInfoMemo.ReadOnly := False;
  while True do begin
    if TempStr = '' then
      break;
    TempStr := GetValidStr3(TempStr, str, [#13]);
    DUserStateInfoMemo.Lines.Add(str);
  end;
  DUserStateInfoMemo.ReadOnly := True;
  UserStatePage := 0;
  UserPageChanged;
  DUserState.Visible := True;
end;

procedure TFrmDlg.PageChanged;
begin
  DStateWinItem.Visible := StatePage = 0;
  DStateWinAbil.Visible := StatePage = 1;
  DStateWinMagic.Visible := StatePage = 2;
  DStateWinInfo.Visible := StatePage = 3;
  DStateWinHorse.Visible := StatePage = 4;
  DStateWinState.Visible := StatePage = 5;
end;

procedure TFrmDlg.UserPageChanged;
begin
  DUserStateItem.Visible := UserStatePage = 0;
  DUserStateInfo.Visible := UserStatePage = 3;
  DUserStateHorse.Visible := UserStatePage = 4;
end;

procedure TFrmDlg.RefAddBagWindow;
var
  i: integer;
  nStateCount: Integer;
  nHeight: Integer;

  procedure RefAddBagWin(nCount: Integer; DWindow: TDWindow; Grid: TDGrid);
  begin
    case nCount of
      6: begin
          DWindow.SetImgIndex(g_WMain99Images, 369);
          DWindow.Left := -DWindow.Width;
          DWindow.Top := nHeight;
          Grid.Width := 104;
          Grid.Height := 69;
          Grid.ColCount := 3;
          Grid.RowCount := 2;
          Inc(nHeight, 89);
        end;
      12: begin
          DWindow.SetImgIndex(g_WMain99Images, 370);
          DWindow.Left := -DWindow.Width + 1;
          DWindow.Top := nHeight;
          Grid.Width := 139;
          Grid.Height := 104;
          Grid.ColCount := 4;
          Grid.RowCount := 3;
          Inc(nHeight, 124);
        end;
      20: begin
          DWindow.SetImgIndex(g_WMain99Images, 371);
          DWindow.Left := -DWindow.Width;
          DWindow.Top := nHeight;
          Grid.Width := 174;
          Grid.Height := 139;
          Grid.ColCount := 5;
          Grid.RowCount := 4;
          Inc(nHeight, 159);
        end
    else
      DWindow.Visible := False;
    end;
  end;
begin
  SafeFillChar(g_AddBagInfo, SizeOf(g_AddBagInfo), #0);
  g_AddBagInfo[0].nStateCount := 0;
  g_AddBagInfo[0].nItemCount := 44;
  nStateCount := 45;
  nHeight := 29;
  for I := Low(g_AddBagItems) to High(g_AddBagItems) do begin
    case i of
      0: begin
          if g_AddBagItems[i].s.Name <> '' then begin
            g_AddBagInfo[i + 1].nItemCount := GetAppendBagCount(g_AddBagItems[i].s.Shape);
            g_AddBagInfo[i + 1].nStateCount := nStateCount;
            Inc(nStateCount, g_AddBagInfo[i + 1].nItemCount);
            RefAddBagWin(g_AddBagInfo[i + 1].nItemCount, DItemAppendBag1, DItemGrid1);
            DItemAppendBag1.Visible := True;
          end
          else begin
            DItemAppendBag1.Visible := False;
          end;
        end;
      1: begin
          if g_AddBagItems[i].s.Name <> '' then begin
            g_AddBagInfo[i + 1].nItemCount := GetAppendBagCount(g_AddBagItems[i].s.Shape);
            g_AddBagInfo[i + 1].nStateCount := nStateCount;
            Inc(nStateCount, g_AddBagInfo[i + 1].nItemCount);
            RefAddBagWin(g_AddBagInfo[i + 1].nItemCount, DItemAppendBag2, DItemGrid2);
            DItemAppendBag2.Visible := True;
          end
          else begin
            DItemAppendBag2.Visible := False;
          end;
        end;
      2: begin
          if g_AddBagItems[i].s.Name <> '' then begin
            g_AddBagInfo[i + 1].nItemCount := GetAppendBagCount(g_AddBagItems[i].s.Shape);
            g_AddBagInfo[i + 1].nStateCount := nStateCount;
            Inc(nStateCount, g_AddBagInfo[i + 1].nItemCount);
            RefAddBagWin(g_AddBagInfo[i + 1].nItemCount, DItemAppendBag3, DItemGrid3);
            DItemAppendBag3.Visible := True;
          end
          else begin
            DItemAppendBag3.Visible := False;
          end;
        end;
    end;
  end;
end;

procedure TFrmDlg.RefCheckButtonXY;
var
  i: Integer;
begin
  //g_FScreenWidth
  i := g_QuestMsgList.Count * 32;
  if g_QuestMsgList.Count > 0 then
    Inc(i, 2 * (g_QuestMsgList.Count - 1));
  DBTCheck1.Left := (g_FScreenWidth - i) div 2 - DBottom.Left - 9;
  DBTCheck2.Left := DBTCheck1.Left + 32 + 2;
  DBTCheck3.Left := DBTCheck2.Left + 32 + 2;
  DBTCheck4.Left := DBTCheck3.Left + 32 + 2;
  DBTCheck5.Left := DBTCheck4.Left + 32 + 2;
  DBTCheck6.Left := DBTCheck5.Left + 32 + 2;
  DBTCheck7.Left := DBTCheck6.Left + 32 + 2;
  DBTCheck8.Left := DBTCheck7.Left + 32 + 2;
  DBTCheck9.Left := DBTCheck8.Left + 32 + 2;
  DBTCheck10.Left := DBTCheck9.Left + 32 + 2;
end;

procedure TFrmDlg.ClearGoodsList;
var
  i: integer;
begin
  for I := 0 to NpcGoodsList.Count - 1 do begin
    Dispose(PTClientGoods(NpcGoodsList[i]));
  end;
  NpcGoodsList.Clear;
  NpcGoodItems := nil;
  NpcSubItems := nil;
end;

procedure TFrmDlg.ClearReturnItemList();
var
  i: integer;
begin
  for I := 0 to NpcReturnItemList.Count - 1 do begin
    Dispose(PTNewClientItem(NpcReturnItemList[i]));
  end;
  NpcReturnItemList.Clear;
end;

procedure TFrmDlg.RefGoodItems;
var
  i: integer;
  btIdx: Byte;
begin
  nShopSelectionIdx := -1;
  DMenuUpDonw.MaxPosition := 0;
  if NpcGoodsList.Count > 0 then
  begin
    btIdx := 0;
    for I := 0 to NpcGoodsList.Count - 1 do begin
      if PTClientGoods(NpcGoodsList[i]).btIdx > btIdx then
        btIdx := PTClientGoods(NpcGoodsList[i]).btIdx;
    end;
    SetLength(NpcGoodItems, btIdx + 1);
    SafeFillChar(NpcGoodItems[0], SizeOf(TClientGoods) * (btIdx + 1), #0);
    for I := 0 to NpcGoodsList.Count - 1 do begin
      NpcGoodItems[PTClientGoods(NpcGoodsList[i]).btIdx] := PTClientGoods(NpcGoodsList[i])^;
    end;
    DMenuUpDonw.MaxPosition := High(NpcGoodItems) - DMenuGrid.RowCount + 1 {div DMenuGrid.RowCount};
  end
  else
    SetLength(NpcGoodItems, 0);
end;

procedure TFrmDlg.RefItemPaint(dsurface, d: TDXTexture; X, Y, ax, ay: Integer; NewClientItem: pTNewClientItem;
  boCount: Boolean; PaintMode: TItemPaintMode; pRect: PRect);
var
  showstr: string;
  dd: TDXTexture;
  idx: integer;
  btEffect: Byte;
begin
  if NewClientItem.s.Effect > 30 then begin
    idx := (FrmMain.m_CurrentTick - g_dwDefTime) div 100 mod 20;
    dd := g_WItemEffectImages.Images[(NewClientItem.s.Effect - 31) * 20 + idx];
    if dd <> nil then
      d := dd;
  end;
  if d <> nil then begin

    if pmBlend in PaintMode then begin
      DrawBlend(dsurface, x, y, d, 0);
    end
    else if pmGrayScale in PaintMode then begin
      DrawEffect(dsurface, x, y, d, ceGrayScale, False)
        //DrawBlend(dsurface, x, y, d, 0)
    end
    else
      dsurface.Draw(x, y, d.ClientRect, d, True);
  end;
  if (pmShowLevel in PaintMode) and (pRect <> nil) then begin
    btEffect := NewClientItem.UserItem.EffectValue.btEffect;
    if (btEffect = 0) and (NewClientItem.s.Effect in [21..29]) then
      btEffect := NewClientItem.s.Effect-20;
    //if btEffect > 0 then
    //begin
    if (btEffect in [1..9]) then begin
      if btEffect in [1..4] then begin
        case btEffect of
          1: begin
              idx := (FrmMain.m_CurrentTick - g_dwDefTime) div 150 mod 6;
              idx := 260 + idx;
            end;
          2: begin
              idx := (FrmMain.m_CurrentTick - g_dwDefTime) div 150 mod 10;
              idx := 230 + idx;
            end;
          3: begin
              idx := (FrmMain.m_CurrentTick - g_dwDefTime) div 150 mod 10;
              idx := 240 + idx;
            end;
          4: begin
              idx := (FrmMain.m_CurrentTick - g_dwDefTime) div 150 mod 8;
              idx := 250 + idx;
            end;
          else
            idx := 0;
        end;
        if idx > 0 then begin
          dd := g_WMain2Images.Images[idx];
          if dd <> nil then
            dsurface.Draw(pRect^.Left - 22, pRect^.Top - 22, dd.ClientRect, dd, True, fxAnti);
        end;
      end else begin
        idx := (FrmMain.m_CurrentTick - g_dwDefTime) div 150 mod 10;
        if btEffect = 9 then begin
          idx := 970 + idx;
        end
        else if btEffect = 8 then begin
          idx := 960 + idx;
        end
        else if btEffect = 7 then begin
          idx := 980 + idx;
        end
        else if btEffect = 6 then begin
          idx := 1000 + idx;
        end
        else if btEffect = 5 then begin
          idx := 990 + idx;
        end
        else
          idx := 0;
        if idx > 0 then begin
          dd := g_WMain99Images.Images[idx];
          if dd <> nil then
            dsurface.StretchDraw(pRect^, dd.ClientRect, dd, True);
        end;
      end;
    end else begin
      //DScreen.AddSysMsg(format('%s: %d', [NewClientItem.s.Name, NewClientItem.UserItem.Value.StrengthenInfo.btStrengthenCount]), clWhite);
      //DebugOutStr(format('%s: %d %d', [NewClientItem.s.Name, NewClientItem.UserItem.EffectValue.btEffect, NewClientItem.s.Effect]));
      idx := (FrmMain.m_CurrentTick - g_dwDefTime) div 150 mod 10;
      if NewClientItem.UserItem.Value.StrengthenInfo.btStrengthenCount >= 15 then begin
        idx := 970 + idx;
      end
      else if NewClientItem.UserItem.Value.StrengthenInfo.btStrengthenCount >= 12 then begin
        idx := 960 + idx;
      end
      else if NewClientItem.UserItem.Value.StrengthenInfo.btStrengthenCount >= 9 then begin
        idx := 980 + idx;
      end
      else if NewClientItem.UserItem.Value.StrengthenInfo.btStrengthenCount >= 6 then begin
        idx := 1000 + idx;
      end
      else if NewClientItem.UserItem.Value.StrengthenInfo.btStrengthenCount >= 3 then begin
        idx := 990 + idx;
      end
      else
        idx := 0;
      if idx > 0 then begin
        dd := g_WMain99Images.Images[idx];
        if dd <> nil then
          dsurface.StretchDraw(pRect^, dd.ClientRect, dd, True);
      end;
    end;
    //end;
  end;
  if boCount and (sm_Superposition in NewClientItem.s.StdModeEx) and (NewClientItem.s.DuraMax > 1) then begin
    if NewClientItem.UserItem.Dura > 1 then
      with g_DXCanvas do begin
        //SetBkMode(Handle, TRANSPARENT);
        showstr := IntToStr(NewClientItem.UserItem.Dura);
        TextOut(ax - TextWidth(showstr), ay, clwhite, showstr);
        //Release;
      end;
  end;
end;

procedure TFrmDlg.RefJobMagic(btJob: Byte);
begin

end;

procedure TFrmDlg.RefNakedWindow;
begin
  NakedCount := g_nNakedCount;
  NakedBackCount := g_nNakedBackCount;
  SafeFillChar(NakedAbil, SizeOf(NakedAbil), #0);
  DStateAbilOk.Visible := False;
  DStateAbilExit.Visible := False;
  DStateAbilOk.Enabled := False;
  DStateAbilExit.Enabled := False;
  if NakedBackCount > 0 then begin
    DStateAbilAdd1.Enabled := False;
    DStateAbilAdd2.Enabled := False;
    DStateAbilAdd3.Enabled := False;
    DStateAbilAdd4.Enabled := False;
    DStateAbilAdd5.Enabled := False;
    DStateAbilAdd6.Enabled := False;
    DStateAbilDel1.Enabled := (g_ClientNakedInfo.NakedAbil.nAc > 0);
    DStateAbilDel2.Enabled := (g_ClientNakedInfo.NakedAbil.nMAc > 0);
    DStateAbilDel3.Enabled := (g_ClientNakedInfo.NakedAbil.nDc > 0);
    DStateAbilDel4.Enabled := (g_ClientNakedInfo.NakedAbil.nMc > 0);
    DStateAbilDel5.Enabled := (g_ClientNakedInfo.NakedAbil.nSc > 0);
    DStateAbilDel6.Enabled := (g_ClientNakedInfo.NakedAbil.nHP > 0);
  end
  else begin
    DStateAbilAdd1.Enabled := g_nNakedCount > 0;
    DStateAbilAdd2.Enabled := g_nNakedCount > 0;
    DStateAbilAdd3.Enabled := g_nNakedCount > 0;
    DStateAbilAdd4.Enabled := g_nNakedCount > 0;
    DStateAbilAdd5.Enabled := g_nNakedCount > 0;
    DStateAbilAdd6.Enabled := g_nNakedCount > 0;
    DStateAbilDel1.Enabled := False;
    DStateAbilDel2.Enabled := False;
    DStateAbilDel3.Enabled := False;
    DStateAbilDel4.Enabled := False;
    DStateAbilDel5.Enabled := False;
    DStateAbilDel6.Enabled := False;
  end;
end;

procedure TFrmDlg.RefPhotoSurface(FileName: string; var HDInfoSurface: TDXImageTexture);
var
  Jpeg: TJPEGImage;
  Bmp: TBitmap;
  ReadBuffer, WriteBuffer: PChar;
  Access: TDXAccessInfo;
  y: Integer;
begin
  Jpeg := TJpegImage.Create;
  Bmp := TBitmap.Create;
  try
    Jpeg.LoadFromFile(FileName);
    Bmp.Assign(Jpeg);
    Bmp.PixelFormat := pf32bit;
    if HDInfoSurface <> nil then
      HDInfoSurface.Free;
    HDInfoSurface := TDXImageTexture.Create(g_DXCanvas);
    HDInfoSurface.Size := Point(BMP.Width, BMP.Height);
    HDInfoSurface.PatternSize := Point(BMP.Width, BMP.Height);
    HDInfoSurface.Format := D3DFMT_A8R8G8B8;
    HDInfoSurface.Active := True;
    if HDInfoSurface.Active then begin
      if HDInfoSurface.Lock(lfWriteOnly, Access) then begin
        try
          for Y := 0 to Bmp.Height - 1 do begin
            ReadBuffer := Bmp.ScanLine[y];
            WriteBuffer := Pointer(Integer(Access.Bits) + Y * Access.Pitch);
            Move(ReadBuffer^, WriteBuffer^, Bmp.Width * 4);
          end;
        finally
          HDInfoSurface.Unlock;
        end;
      end;
    end;
  finally
    Jpeg.Free;
    Bmp.Free;
  end;
end;

procedure TFrmDlg.RefRealityInfo();
var
  str: string;
  TempStr: string;
begin
  TempRealityInfo := g_UserRealityInfo;
  DStateInfoName.Text := g_UserRealityInfo.sUserName;
  if g_UserRealityInfo.btOld > 0 then
    DStateInfoAge.Text := IntToStr(g_UserRealityInfo.btOld)
  else
    DStateInfoAge.Text := '';
  DStateInfoSex.ItemIndex := g_UserRealityInfo.btSex;
  DStateInfoProvince.ItemIndex := g_UserRealityInfo.btProvince;
  DStateInfoNameChange(DStateInfoProvince);
  DStateInfoCity.ItemIndex := g_UserRealityInfo.btCity;
  DStateInfoNameChange(DStateInfoCity);
  DStateInfoArea.ItemIndex := g_UserRealityInfo.btArea;
  DStateInfoNameChange(DStateInfoArea);
  DStateInfoAM.Checked := CheckByteStatus(g_UserRealityInfo.btOnlineTime, 0);
  DStateInfoPM.Checked := CheckByteStatus(g_UserRealityInfo.btOnlineTime, 1);
  DStateInfoNight.Checked := CheckByteStatus(g_UserRealityInfo.btOnlineTime, 2);
  DStateInfoMidNight.Checked := CheckByteStatus(g_UserRealityInfo.btOnlineTime, 3);
  DStateInfoFriend.Checked := g_UserRealityInfo.boFriendSee;
  DStateInfoMemo.Lines.Clear;
  DStateInfoRefPic.Enabled := g_UserRealityInfo.sPhotoID <> '';
  TempStr := TempRealityInfo.sIdiograph;
  while True do begin
    if TempStr = '' then
      break;
    TempStr := GetValidStr3(TempStr, str, [#13]);
    DStateInfoMemo.Lines.Add(str);
  end;
  DStateInfoSave.Visible := False;
  DStateInfoExit.Visible := False;
  DStateInfoSave.Enabled := False;
  DStateInfoExit.Enabled := False;
end;

procedure TFrmDlg.RefStatusInfoForm;
var
  I: Integer;
  StatusInfo: pTStatusInfo;
begin
  for I := 0 to g_StatusInfoList.Count - 1 do begin
    StatusInfo := @g_StatusInfoArr[Integer(g_StatusInfoList[I])];
    with StatusInfo.Button as TDButton do begin
      if g_nInterface = 1 then begin
        if I > 13 then begin
          Top := 89;
          case g_nViewMinMapLv of
            0: Left := g_FScreenWidth - 55 - ((I - 14) * 25);
            1: Left := g_FScreenWidth - 155 - ((I - 14) * 25);
            2: Left := g_FScreenWidth - 225 - ((I - 14) * 25);
          end;
        end else
        if I > 6 then begin
          Top := 53;
          case g_nViewMinMapLv of
            0: Left := g_FScreenWidth - 55 - ((I - 7) * 25);
            1: Left := g_FScreenWidth - 155 - ((I - 7) * 25);
            2: Left := g_FScreenWidth - 225 - ((I - 7) * 25);
          end;
        end else begin
          Top := 17;
          case g_nViewMinMapLv of
            0: Left := g_FScreenWidth - 55 - ((I) * 25);
            1: Left := g_FScreenWidth - 155 - ((I) * 25);
            2: Left := g_FScreenWidth - 225 - ((I) * 25);
          end;
        end;
      end else
      if g_nInterface = 2 then begin
        if I > 12 then begin
          Top := 89;
          case g_nViewMinMapLv of
            0, 1: Left := g_FScreenWidth - 195 - ((I - 14) * 25);
            2: Left := g_FScreenWidth - 275 - ((I - 14) * 25);
          end;
        end else
        if I > 6 then begin
          case g_nViewMinMapLv of
            0,1: begin
              Left := g_FScreenWidth - 195 - ((I - 7) * 25);
              Top := 53;
            end;
            2: begin
              Left := g_FScreenWidth - 275 - ((I - 7) * 25);
              Top := 53;
            end;
          end;
        end else begin
          case g_nViewMinMapLv of
            0,1: begin
              Left := g_FScreenWidth - 195 - ((I) * 25);
              Top := 17;
            end;
            2: begin
              Left := g_FScreenWidth - 275 - ((I) * 25);
              Top := 17;
            end;
          end;
        end;
      end;
    end;
  end;
end;

procedure TFrmDlg.SetGroupWnd;
var
  boGroup: Boolean;
  GroupMember: pTGroupMember;
begin
  if g_MySelf = nil then
    exit;
  DCBGroupItemRam.Checked := g_GroupItemMode;
  DCBGroupItemDef.Checked := not g_GroupItemMode;
  if g_GroupMembers.Count <= 0 then begin
    DCBGroupItemRam.Enabled := True;
    DCBGroupItemDef.Enabled := True;
    DGrpDelMem.Visible := False;
    DGroupExit.Visible := False;
    DGrpCreate.Visible := False;
    DGrpAddMem.Visible := True;
    FrmDlg2.DWndGroup.Visible := False;
  end
  else begin
    DCBGroupItemRam.Enabled := False;
    DCBGroupItemDef.Enabled := False;
    GroupMember := g_GroupMembers.Items[0];
    boGroup := (GroupMember.ClientGroup.UserID = g_MySelf.m_nRecogId);
    DGrpCreate.Visible := False;
    DGrpAddMem.Visible := boGroup;
    DGrpDelMem.Visible := boGroup;
    DGroupExit.Visible := True;

    FrmDlg2.DWndGroup.Visible := False;
    FrmDlg2.DWndGroupMember.Visible := False;
    FrmDlg2.DGroupMember1.Visible := g_GroupMembers.Count > 1;
    FrmDlg2.DGroupMember2.Visible := g_GroupMembers.Count > 2;
    FrmDlg2.DGroupMember3.Visible := g_GroupMembers.Count > 3;
    FrmDlg2.DGroupMember4.Visible := g_GroupMembers.Count > 4;
    FrmDlg2.DGroupMember5.Visible := g_GroupMembers.Count > 5;
    FrmDlg2.DGroupMember6.Visible := g_GroupMembers.Count > 6;
    FrmDlg2.DGroupMember7.Visible := g_GroupMembers.Count > 7;
  end;
end;

procedure TFrmDlg.SetChatSize(flag: Byte);
var
  d: TDXTexture;
  ax, ay: integer;
  sStr: string;
begin
  case flag of
    0:
      begin
        DChatEnlargeButton.SetImgIndex(g_WUI3Images, 2938);
      end;
    1:
      begin
        DChatEnlargeButton.SetImgIndex(g_WUI3Images, 2942);
      end;
  end;
end;

procedure TFrmDlg.SetMiniMapSize(flag: Byte);  //ripman
var
  d: TDXTexture;
  ax, ay: integer;
  sStr: string;
begin
  g_nMiniMapOldX := -1;
if g_nInterface = 1 then begin
  case flag of
    0: begin
      DMiniMap.Visible := False;
      if frmdlg2.DWndGroup.Left = g_FScreenWidth - frmdlg2.dWndGroup.Width - 30 then
        frmdlg2.DWndGroup.Top := 46;
    end;
    1:
      begin
        DMiniMap.Visible := True;
        DMiniMap.Left := g_FScreenWidth - 128;
        DMiniMap.Top := 0;
        DMiniMap.Width := 128;
        DMiniMap.Height := 128;
        if frmdlg2.DWndGroup.Left = g_FScreenWidth - frmdlg2.dWndGroup.Width - 30 then
          frmdlg2.DWndGroup.Top := 130;
      end;
    2:
      begin
        DMiniMap.Visible := True;
        DMiniMap.Left := g_FScreenWidth - 192;
        DMiniMap.Top := 0;
        DMiniMap.Width := 192;
        DMiniMap.Height := 160;
        if frmdlg2.DWndGroup.Left = g_FScreenWidth - frmdlg2.dWndGroup.Width - 30 then
          frmdlg2.DWndGroup.Top := 167;
      end;
    3:
      begin
        {g_nMiniMaxShow := True;
        DMiniMap.Left := 0;
        DMiniMap.Top := 0;
        DMiniMap.Width := 800;
        DMiniMap.Height := 600;   }
      end;
  end;
end
else if g_nInterface = 2 then begin
  case flag of
    0:
      begin
        DMiniMap.Visible := False;

        DMiniMapFrame.SetImgIndex(g_WUI3Images, 2995);
        DMiniMapFrame.Left := 860;
        DMiniMapFrame.Top := 0;

        DTopHelp.Visible := False;
        DBotMiniMap.Visible := False;
        DButtonTop.Visible := False;
        DBTFace.Visible := False;
        DBTTakeHorse.Visible := False;
        DBotFriend.Visible := False;

        DOption.Visible := True;
        DOption.Left := 2;
        DOption.Top := 17;

        DBotMusic.Visible := True;
        DBotMusic.Left := 142;
        DBotMusic.Top := 24;

        DFrameMaxMin.Visible := True;
        DFrameMaxMin.SetImgIndex(g_WUI3Images, 2970);
        DFrameMaxMin.Left := 144;
        DFrameMaxMin.Top := 2;

      end;

    1:
      begin
        DMiniMapFrame.SetImgIndex(g_WUI3Images, 2994);
        DMiniMapFrame.Left := 860;
        DMiniMapFrame.Top := 0;

        DMiniMap.Visible := True;
        DMiniMap.Left := 37;
        DMiniMap.Top := 22;
        DMiniMap.Width := 124;
        DMiniMap.Height := 120;

        DTopHelp.Visible := True;
        DTopHelp.Left := 3;
        DTopHelp.Top := 28;
        DBotMiniMap.Visible := True;
        DBotMiniMap.Left := 3;
        DBotMiniMap.Top := 46;
        DButtonTop.Visible := True;
        DButtonTop.Left := 3;
        DButtonTop.Top := 64;
        DBTFace.Visible := True;
        DBTFace.Left := 3;
        DBTFace.Top := 83;
        DBTTakeHorse.Visible := True;
        DBTTakeHorse.Left := 3;
        DBTTakeHorse.Top := 101;
        DBotFriend.Visible := True;
        DBotFriend.Left := 3;
        DBotFriend.Top := 119;
        DOption.Visible := True;
        DOption.Left := 2;
        DOption.Top := 137;
        DBotMusic.Visible := True;
        DBotMusic.Left := 142;
        DBotMusic.Top := 145;
        DFrameMaxMin.Visible := True;
        DFrameMaxMin.SetImgIndex(g_WUI3Images, 2970);
        DFrameMaxMin.Left := 144;
        DFrameMaxMin.Top := 2;
      end;
    2:
      begin
        DMiniMapFrame.SetImgIndex(g_WUI3Images, 2996);
        DMiniMapFrame.Left := 780;
        DMiniMapFrame.Top := 0;

        DMiniMap.Visible := True;
        DMiniMap.Left := 45;
        DMiniMap.Top := 27;
        DMiniMap.Width := 192;
        DMiniMap.Height := 190;

        DTopHelp.Visible := True;
        DTopHelp.Left := 3+2;
        DTopHelp.Top := 28;
        DBotMiniMap.Visible := True;
        DBotMiniMap.Left := 3+2;
        DBotMiniMap.Top := 46;
        DButtonTop.Visible := True;
        DButtonTop.Left := 3+2;
        DButtonTop.Top := 64;
        DBTFace.Visible := True;
        DBTFace.Left := 3+2;
        DBTFace.Top := 83;
        DBTTakeHorse.Visible := True;
        DBTTakeHorse.Left := 3+2;
        DBTTakeHorse.Top := 101;
        DBotFriend.Visible := True;
        DBotFriend.Left := 3+2;
        DBotFriend.Top := 119;
        DOption.Visible := True;
        DOption.Left := 5;
        DOption.Top := 138+80;
        DBotMusic.Visible := True;
        DBotMusic.Left := 142+80;
        DBotMusic.Top := 145+80;
        DFrameMaxMin.Visible := True;
        DFrameMaxMin.SetImgIndex(g_WUI3Images, 2974);
        DFrameMaxMin.Left := 144+80;
        DFrameMaxMin.Top := 2;
      end;
    3:
      begin
        {g_nMiniMaxShow := True;
        DMiniMap.Left := 0;
        DMiniMap.Top := 0;
        DMiniMap.Width := 800;
        DMiniMap.Height := 600;   }
      end;
  end;
 end;
end;

procedure TFrmDlg.ShowMDlg(nResID, nWidth, nHeight: Integer; mname, msgstr: string);
var
  i: Integer;
  d: TDXTexture;
begin
  if (nResID >= 0) and (nWidth > 0) and (nHeight > 0) then
  begin
    d := g_WMain99Images.Images[nResID];
    if d <> nil then begin
      DMerchantDlgClose.Left := d.Width - 17;
      DMDlgUpDonw.Left := d.Width - 39;
    end;
    DMerchantDlg.SetImgIndex(g_WMain99Images, nResID);
    g_MerchantMaxWidth := nWidth;
    g_MerchantMaxHeight := nHeight;
    DMerchantDlg.Surface.Size := Point(nWidth, MDLGMAXHEIGHT);
    DMerchantDlg.Surface.PatternSize := Point(nWidth, MDLGMAXHEIGHT);
  end
  else
  begin
    DMerchantDlg.SetImgIndex(g_WMain99Images, 1933);
    DMerchantDlgClose.Left := 392;
    DMDlgUpDonw.Left := 384;
    DMerchantDlg.Surface.Size := Point(DEFMDLGMAXWIDTH, MDLGMAXHEIGHT);
    DMerchantDlg.Surface.PatternSize := Point(DEFMDLGMAXWIDTH, MDLGMAXHEIGHT);
    g_MerchantMaxWidth := DefMerchantMaxWidth;
    g_MerchantMaxHeight := DefMerchantMaxHeight;
  end;
  MerchantName := mname;
  MDlgRefTime := 0;
  MDlgMove.rstr := '';
  MDlgSelect.rstr := '';
  //MDlgNewMoveRect.Top := -10000;
  //MDlgNewSelectRect.Top := -10000;
  MDlgStr := FormatShowText(msgstr, nil);
  DMDlgUpDonw.MaxPosition := 0;
  DMDlgUpDonw.Visible := False;
  DItemBag.Left := 475;
  DItemBag.Top := 0;
  DMDlgUpDonw.Height := 158;

  DItemBag.Left := g_FScreenWidth - DItemBag.Width;
  DItemBag.Top := 0;
  //MerchantMaxHeight := 306;
  for i := 0 to MDlgPoints.count - 1 do
    Dispose(pTClickPoint(MDlgPoints[i]));
  for i := 0 to MDlgDraws.count - 1 do begin
    if pTNewShowHint(MDlgDraws[i]).IndexList <> nil then
      pTNewShowHint(MDlgDraws[i]).IndexList.Free;
    Dispose(pTNewShowHint(MDlgDraws[i]));
  end;

  MDlgPoints.Clear;
  //MDlgNewPoints.Clear;
  MDlgDraws.Clear;
  LastestClickTime := FrmMain.m_CurrentTick;
  DMerchantDlg.Surface.Clear;
  MerchantHeight := DlgShowText(DMerchantDlg.Surface, 0, 0, MDlgPoints, MDlgDraws, MDlgStr, MDLGMAXHEIGHT);
  if MerchantHeight > g_MerchantMaxHeight then begin
    DMDlgUpDonw.MaxPosition := MerchantHeight - g_MerchantMaxHeight;
    DMDlgUpDonw.Visible := True;
  end;
  MDlgRefTime := FrmMain.m_CurrentTick + 300;
  DMerchantDlg.Visible := True;
  MDlgVisible := True;
//  DMenuDlg.Visible := False;
  CloseSellWindow();
  DSubShop.Visible := False;
  DWndBuy.Visible := False;
  DMenuDlg.Visible := False;
  FrmDlg3.DWndArmStrengthen.Visible := False;
  FrmDlg3.DWndMakeItem.Visible := False;
  FrmDlg2.DStorageDlg.Visible := False;
  FrmDlg3.DWndItemUnseal.Visible := False;
  FrmDlg4.DWndItemRemove.Visible := False;
  LastestClickTime := FrmMain.m_CurrentTick + 200;
end;

procedure TFrmDlg.CloseMDlg;
var
  i: Integer;
begin
  MDlgVisible := False;
  MDlgStr := '';
  g_nCurMerRate := 100;
  DMerchantDlg.Visible := FALSE;
  for i := 0 to MDlgPoints.count - 1 do
    Dispose(pTClickPoint(MDlgPoints[i]));

  for i := 0 to MDlgDraws.count - 1 do begin
    if pTNewShowHint(MDlgDraws[i]).IndexList <> nil then
      pTNewShowHint(MDlgDraws[i]).IndexList.Free;
    Dispose(pTNewShowHint(MDlgDraws[i]));
  end;
  MDlgPoints.Clear;
  MDlgDraws.Clear;
  //皋春芒档 摧澜
  DItemBag.Left := 0;
  DItemBag.Top := 0;

  //DMenuDlg.Visible := FALSE;
  CloseSellWindow();
  DSubShop.Visible := False;
  DWndBuy.Visible := False;
  FrmDlg3.DWndArmStrengthen.Visible := False;
  FrmDlg3.DWndMakeItem.Visible := False;
  FrmDlg2.DStorageDlg.Visible := False;
  FrmDlg3.DWndItemUnseal.Visible := False;
  FrmDlg4.DWndItemRemove.Visible := False;
  DMenuDlg.Visible := False;
  if DitemBag.Visible and not boOpenItemBag then
    OpenItemBag;
  if DStateWin.Visible and not boOpenStatus then
    OpenMyStatus;
end;

procedure TFrmDlg.CreateGroup(sChrName: string);
begin
  g_dwChangeGroupModeTick := FrmMain.m_CurrentTick + 2000;
  if g_GroupMembers.count = 0 then
    frmMain.SendCreateGroup(Integer(g_GroupItemMode), sChrName)
  else
    frmMain.SendAddGroupMember(sChrName);
end;

procedure TFrmDlg.CloseSellWindow;
begin
  DSaleDlg.Visible := false;
  if SellItem.item.s.name <> '' then begin//return the old sell item back to inventory
    additembag(sellitem.Item, sellitem.Index2);
  end;
  sellItem.item.s.name := '';
end;

procedure TFrmDlg.RemoveFromSublist(MakeIndex: Integer);
var
  i: integer;
  boFound: boolean;
begin
  if Length(NpcSubItems) = 0 then exit;

  boFound := false;
  for i := 0 to Length(NpcSubItems) - 1 do begin
    if boFound then begin
      if i > 0 then
        NpcSubItems[i-1] := NpcSubItems[i];
    end;
    if NpcSubItems[i].UserItem.MakeIndex = MakeIndex then
      boFound := true;
  end;
  SetLength(NpcSubItems,Length(NpcSubItems)-1);
  DSubShopUpDown.MaxPosition := (High(NpcSubItems) - DSubShopGrid.RowCount + 1) div DSubShopGrid.ColCount;
  if Length(NpcSubItems) = 0 then DSubShop.visible := false;
end;

procedure TFrmDlg.DOpenCompoundItemClick(Sender: TObject; X, Y: Integer);
begin
  FrmDlg4.DWndCompound.Visible := not FrmDlg4.DWndCompound.Visible;
end;

procedure TFrmDlg.DOpenCompoundItemDirectPaint(Sender: TObject;
  dsurface: TDXTexture);
var
  i: Integer;
  d: TDXTexture;
begin
  with Sender as TDButton do
  begin
    {if FrmMain.m_CurrentTick() >= FCompoundItemBtnTick + 150 then
    begin
      FCompoundItemBtnTick := FrmMain.m_CurrentTick();
      Inc(FCompoundItemBtnIndex);
      if FCompoundItemBtnIndex >= 6 then
        FCompoundItemBtnIndex := 0;
    end;       }
    if Downed then
      i := 2
    else if MouseEntry = msIn then
      i := 1
    else
      i := FCompoundItemBtnIndex;
    if WLib <> nil then begin
      d := WLib.Images[FaceIndex + i];
      if d <> nil then
        dsurface.Draw(SurfaceX(Left), SurfaceY(Top), d.ClientRect, d, True);
    end;
  end;
end;

end.



