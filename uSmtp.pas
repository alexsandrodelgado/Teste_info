unit uSmtp;

interface

uses
  idsmtp, idmessage, SysUtils, Classes, Controls, ExtCtrls, Chart, Series,
  StrUtils, StdCtrls, Windows, IdSSLOpenSSL, Dialogs;

type
  TRecebido = class(TObject)
    Host       : String;
    Password   : String;
    Body       : String;
    FromAdress : String;
    FromName   : String;
    UserName   : String;
    ToAdress   : String;
    ToCcList   : String;
    ToCCO      : String;
    Subject    : String;
    ReplaTo    : String;
    Attachment : TStringList;
    SSL        : Boolean;
  end;

type
  TSMTP = class(TIdSMTP)
  private
    Menssagem: TIdMessage;
    Text: TIdText;
    fRecebido: TRecebido;
    FForced: Boolean;
    FErro  : String;
    HandlerSSL: TIdSSLIOHandlerSocket;
  public
    SMTP: TIdSMTP;
    constructor Create ( AOwner : TComponent ); override;
    destructor Destroy; override;
    Function Connect: Boolean;Virtual;
    procedure Disconnect;Virtual;
    function Send: Boolean;Virtual;
    function GetErro : String;
    function Conectado(): String;
  published
    property Recebido: TRecebido read FRecebido write FRecebido;
    property Forced  : Boolean   read GetForced   write FForced;
    property MsgErro : String read GetErro;
  end;

implementation

{ TSMTP }

constructor TSMTP.Create(AOwner: TComponent);
begin
  inherited;
  SMTP := TIdSMTP.Create(Self);
  fRecebido := TRecebido.Create;
  HandlerSSL := TIdSSLIOHandlerSocket.Create(self);

end;

destructor TSMTP.Destroy;
begin
  FreeAndNil(fRecebido);
  FreeAndNil(HandlerSSL);
  FreeAndNil(SMTP);

  inherited;
end;

function TSMTP.Connect: Boolean;
var
  bErro: Boolean;
begin
  try
    SMTP.Host               := Recebido.Host;
    SMTP.Username           := Recebido.UserName;
    SMTP.Password           := Recebido.Password;
    SMTP.ReadTimeout        := 0;
    SMTP.Port               := Port;
    SMTP.AuthenticationType := atLogin;

    //TENTA COM A VERSÃO 3
    if (Recebido.SSL) then begin
      HandlerSSL.SSLOptions.Method := sslvSSLv3;
      SMTP.IOHandler := HandlerSSL;
    end;

    FErro := Conectado();

    //CASO OCORRA ERRO TENTA COM A VERSÃO 23
    if (FErro <> '') and (Recebido.SSL) then begin
      HandlerSSL.SSLOptions.Method := sslvSSLv23;
      FErro := Conectado();
    end;

    //CASO OCORRA ERRO TENTA COM A VERSÃO 2
    if (FErro <> '') and (Recebido.SSL) then begin
      HandlerSSL.SSLOptions.Method := sslvSSLv2;
      FErro := Conectado();
    end;

    if (FErro <> '') then begin
      showmessage('Falha na conexão.');
    end;

    try
      Result := SMTP.Authenticate;
    except
      try
        SMTP.Username := Copy(SMTP.Username,1,pos('@',SMTP.Username)-1);
        Result := SMTP.Authenticate;
      except
        on e: Exception do begin
          if Length(FErro) = 0 then begin
            FErro := e.Message;
            showmessage('Falha na autenticação do email.');
          end;
        end;
      end;
    end;
  Except
  end;
end;

procedure TSMTP.Disconnect;
begin
  SMTP.Disconnect;
end;

Function TSMTP.Send: Boolean;
var
  i: integer;
  vBodyHTML: String;
begin
  Result := False;
  try
    Menssagem := TIdMessage.Create(self);
    Menssagem.MessageParts.Clear;
    Menssagem.ContentType:='text/html';

    Text             := TIdText.Create(Menssagem.MessageParts);
    Text.Body.Text   := '';
    Text.ContentType := 'text/plain';

    Text             := TIdText.Create(Menssagem.MessageParts);
    Text.Body.Text   := '<HTML><BODY>' + Recebido.Body + '</BODY></HTML>';
    Text.ContentType := 'text/html';

    Menssagem.From.Address              := Recebido.FromAdress;
    Menssagem.From.Name                 := Recebido.FromName;
    Menssagem.Recipients.EMailAddresses := Recebido.ToAdress;
    Menssagem.CCList.EMailAddresses     := Recebido.ToCcList;
    Menssagem.BccList.EMailAddresses    := Recebido.ToCCO;
    Menssagem.Subject                   := Recebido.Subject;
    Menssagem.ReplyTo.EMailAddresses    := Recebido.ReplaTo;

    i := 0;
    for i := 0 to Recebido.Attachment.Count-1 do begin
      TIdAttachment.Create(Menssagem.MessageParts,Recebido.Attachment[i])
    end;

    try
      SMTP.Send(Menssagem);
      Result := True;
    except
      on e: Exception do begin
        FErro := e.Message;
      end;
    end;
  finally
    FreeAndNil(Menssagem);
  end;
end;

function TSMTP.GetErro: String;
begin
  Result :=  self.FErro;
end;

function TSMTP.Conectado: String;
begin
  try
    Result := '';
    SMTP.Connect(3000);
  except
    on e: Exception do begin
      Result := e.Message;
    end;
  end;
end;

end.
