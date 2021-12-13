unit uCadPessoa;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, Mask, Grids, DBGrids, DB, DBClient,
  DBCtrls, StrUtils, IdBaseComponent, IdComponent, IdTCPConnection,
  IdTCPClient, IdHTTP,
  IdSMTP, IdSSLOpenSSL, IdMessage;


type
  TfrmCadpessoa = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    btnSalvar: TBitBtn;
    btnExcluir: TBitBtn;
    BitBtn1: TBitBtn;
    DSCadastro: TDataSource;
    CDSCadastro: TClientDataSet;
    DBGrid1: TDBGrid;
    Label2: TLabel;
    Label3: TLabel;
    edtcpf: TMaskEdit;
    edttelefone: TMaskEdit;
    edtemail: TLabeledEdit;
    edtnome: TLabeledEdit;
    edtcep: TMaskEdit;
    Label1: TLabel;
    edtlogradouro: TLabeledEdit;
    edtcomplemento: TLabeledEdit;
    edtnumero: TLabeledEdit;
    edtbairro: TLabeledEdit;
    edtuf: TLabeledEdit;
    edtcidade: TLabeledEdit;
    edtpais: TLabeledEdit;
    CDSCadastrocpf: TStringField;
    CDSCadastronome: TStringField;
    CDSCadastroemail: TStringField;
    CDSCadastrocep: TStringField;
    CDSCadastrologradouro: TStringField;
    CDSCadastronumero: TStringField;
    CDSCadastrocomplemento: TStringField;
    CDSCadastrobairro: TStringField;
    CDSCadastrouf: TStringField;
    CDSCadastrocidade: TStringField;
    CDSCadastropais: TStringField;
    IdHTTP1: TIdHTTP;
    CDSCadastrotelefone: TStringField;
    procedure btnSalvarClick(Sender: TObject);
    procedure edtcpfExit(Sender: TObject);
    procedure edtemailExit(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure edttelefoneExit(Sender: TObject);
    procedure edttelefoneClick(Sender: TObject);
    procedure edtcepExit(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    Fssl: boolean;
    Fporta: string;
    FSmtp:  string;
    Femail: string;
    Fsenha: string;
      
    procedure FieldsClear();
    procedure FieldsLoad();
    procedure GeraXML();
    function RemoveAcento(aText : string) : string;
    function FieldsValidate():Boolean;
    function EmailValidate(email: string): Boolean;

    property smtp:  string read FSmtp  write FSmtp;
    property email: string read Femail write Femail;
    property senha: string read Fsenha write Fsenha;
    property porta: string read Fporta write Fporta;
    property ssl: boolean read Fssl write Fssl;
  end;

var
  frmCadpessoa: TfrmCadpessoa;

  implementation


uses uLkJSON, uSmtp, uEmail;


{$R *.dfm}

procedure TfrmCadpessoa.btnSalvarClick(Sender: TObject);
begin
  if(FieldsValidate)then
  begin
    CDSCadastro.Close;
    CDSCadastro.Open;
    if CDSCadastro.Locate('cpf', edtcpf.Text, [loCaseInsensitive, loPartialKey]) then
    begin
      CDSCadastro.Edit;
    end else
    begin
      CDSCadastro.Append;
    end;
    CDSCadastro.fieldbyname('cpf').AsString         := edtcpf.Text;
    CDSCadastro.fieldbyname('nome').AsString        := edtnome.Text;
    CDSCadastro.fieldbyname('telefone').AsString    := edttelefone.Text;
    CDSCadastro.fieldbyname('email').AsString       := edtemail.Text;
    CDSCadastro.fieldbyname('cep').AsString         := edtcep.Text;
    CDSCadastro.fieldbyname('logradouro').AsString  := edtlogradouro.Text;
    CDSCadastro.fieldbyname('numero').AsString      := edtnumero.Text;
    CDSCadastro.fieldbyname('complemento').AsString := edtcomplemento.Text;
    CDSCadastro.fieldbyname('bairro').AsString      := edtbairro.Text;
    CDSCadastro.fieldbyname('uf').AsString          := edtuf.Text;
    CDSCadastro.fieldbyname('cidade').AsString      := edtcidade.Text;
    CDSCadastro.fieldbyname('pais').AsString        := edtpais.Text;
    CDSCadastro.Post;

    FieldsClear();
  end;
end;

procedure TfrmCadpessoa.FieldsClear;
begin
  edtcpf.Clear;
  edtnome.clear;
  edttelefone.clear;
  edtemail.clear;
  edtcep.clear;
  edtlogradouro.clear;
  edtcomplemento.Clear;
  edtnumero.clear;
  edtbairro.clear;
  edtuf.clear;
  edtcidade.clear;
  edtpais.clear;
  edtcpf.EditMask := '';
end;

function TfrmCadpessoa.FieldsValidate():boolean;
begin
  Result := True;
  if (edtcpf.text = '') or (Length(edtcpf.Text) < 11) then
  begin
    showmessage('Verificar campo CPF.');
    edtcpf.Focused;
    Result := False;
  end;
  if (Trim(edtnome.Text) = '') then
  begin
    showmessage('Verificar campo Nome.');
    edtnome.Focused;
    Result := False;
  end;
  if not(emailvalidate(edtemail.text))then
  begin
    showmessage('Verificar campo Email.');
    edtemail.Focused;
    Result := False;
  end;
end;
procedure TfrmCadpessoa.edtcpfExit(Sender: TObject);
begin
  if (edtcpf.text = '') or (Length(edtcpf.Text) < 11) then
  begin
    showmessage('Verificar campo CPF.');
    edtcpf.Focused;
    exit;
  end else
  begin
    edtcpf.EditMask := '999.999.999-99;1;_';
  end;
end;

function TfrmCadpessoa.Emailvalidate(email: string): Boolean;
begin
  if (Trim(email) <> '')then
  begin
    email := Trim(UpperCase(email));
    if Pos('@', email) > 1 then begin
      Delete(email, 1, pos('@', email));
      Result := (Length(email) > 0) and (Pos('.', email) > 2) and (Pos(' ', email) = 0);
    end else begin
      Result := False;
    end;
  end;  
end;

procedure TfrmCadpessoa.edtemailExit(Sender: TObject);
begin
  if not(emailvalidate(edtemail.text))then
  begin
    showmessage('Verificar campo Email.');
    edtemail.Focused;
    exit;
  end;
end;

procedure TfrmCadpessoa.FieldsLoad;
begin
  edtcpf.Text         := CDSCadastro.fieldbyname('cpf').AsString;
  edtnome.Text        := CDSCadastro.fieldbyname('nome').AsString;
  edttelefone.Text    := CDSCadastro.fieldbyname('telefone').AsString;
  edtemail.Text       := CDSCadastro.fieldbyname('email').AsString;
  edtcep.Text         := CDSCadastro.fieldbyname('cep').AsString;
  edtlogradouro.Text  := CDSCadastro.fieldbyname('logradouro').AsString;
  edtnumero.Text      := CDSCadastro.fieldbyname('numero').AsString;
  edtcomplemento.Text := CDSCadastro.fieldbyname('complemento').AsString;
  edtbairro.Text      := CDSCadastro.fieldbyname('bairro').AsString;
  edtuf.Text          := CDSCadastro.fieldbyname('uf').AsString;
  edtcidade.Text      := CDSCadastro.fieldbyname('cidade').AsString;
  edtpais.Text        := CDSCadastro.fieldbyname('pais').AsString;
end;

procedure TfrmCadpessoa.DBGrid1DblClick(Sender: TObject);
begin
  FieldsLoad;
end;

procedure TfrmCadpessoa.btnExcluirClick(Sender: TObject);
begin
  if cdscadastro.recordcount > 0 then
    CDSCadastro.Delete;
end;

procedure TfrmCadpessoa.edttelefoneExit(Sender: TObject);
begin
  edttelefone.EditMask := '';
  if (Trim(edttelefone.Text) <> '')then
  begin
    if (Length(edttelefone.text) = 10) then
    begin
      edttelefone.EditMask := '(99)9999-9999;1;_';
    end else
    begin
      edttelefone.EditMask := '(99)99999-9999;1;_';
    end;
  end;  
end;

procedure TfrmCadpessoa.edttelefoneClick(Sender: TObject);
begin
  edttelefone.EditMask := '(99)99999-9999;1;_';
end;

procedure TfrmCadpessoa.edtcepExit(Sender: TObject);
var
  sCep : Widestring;
  jd: TlkJSONobject;
begin
  sCep := IdHTTP1.Get('http://viacep.com.br/ws/'+edtcep.text+'/json/');
  jd := TlkJSON.ParseText(sCep) as TlkJSONobject;

  edtlogradouro.Text := VarToStr(jd.Field['logradouro'].value);
  edtbairro.Text     := VarToStr(jd.Field['bairro'].value);
  edtuf.Text         := VarToStr(jd.Field['uf'].value);
  edtcidade.Text     := VarToStr(jd.Field['localidade'].value);

  edtcep.EditMask := '99999-999;1;';
end;

procedure TfrmCadpessoa.BitBtn1Click(Sender: TObject);
var
  SMTP         : TSMTP;
  stAttach     : TStringList;
  sDir         : string;
begin
  Try
    sDir := GetCurrentDir+'\';
    GeraXML;
    SMTP              := TSMTP.Create(Application);

    if (email = '') then
    begin
      frmemail.ShowModal;
      SMTP.Recebido.SSL        := Fssl;
      SMTP.Port                := StrToIntDef(Fporta,587);
      SMTP.Recebido.Host       := FSmtp;
      SMTP.Recebido.FromAdress := Femail;
      SMTP.Recebido.UserName   := Femail; 
      SMTP.Recebido.Password   := FSenha;
    end;

    if SMTP.Connect then begin
      SMTP.Recebido.Body     := '<HTML><BODY>' + 'Dados Cadastrais' + '</BODY></HTML>';
      SMTP.Recebido.FromName := CDSCadastro.fieldbyname('nome').AsString;
      SMTP.Recebido.ToAdress := CDSCadastro.fieldbyname('email').AsString;

      stAttach := TStringList.Create;
      stAttach.Add(sDir+CDSCadastro.fieldbyname('cpf').AsString);
      SMTP.Recebido.Attachment      := TStringList.create;
      SMTP.Recebido.Attachment.Text := stAttach.Text;

      SMTP.Send;
    end;
  finally
    SMTP.Disconnect;
    FreeAndNil(SMTP);
  end;
end;

procedure TfrmCadpessoa.GeraXML;
var
  xXml : WideString;
  arq: TStringList;
  sDir :string;
begin
  Try
    sDir := GetCurrentDir+'\';
    arq  := TStringList.Create();

    xXml := '';
    xXml := '<Dados>'+ #13#10;
    xXml := xXml + '  <cpf>'+CDSCadastro.fieldbyname('cpf').AsString+'</cpf>' + #13#10;
    xXml := xXml + '  <nome>'+RemoveAcento(CDSCadastro.fieldbyname('nome').AsString)+'</nome>' + #13#10;
    xXml := xXml + '  <email>'+CDSCadastro.fieldbyname('email').AsString+'</email>' + #13#10;
    xXml := xXml + '  <telefone>'+CDSCadastro.fieldbyname('telefone').AsString+'</telefone>' + #13#10;
    xXml := xXml + '  <cep>'+CDSCadastro.fieldbyname('cep').AsString+'</cep>' + #13#10;
    xXml := xXml + '  <logradouro>'+RemoveAcento(CDSCadastro.fieldbyname('logradouro').AsString)+'</logradouro>' + #13#10;
    xXml := xXml + '  <numero>'+CDSCadastro.fieldbyname('numero').AsString+'</numero>' + #13#10;
    xXml := xXml + '  <bairro>'+RemoveAcento(CDSCadastro.fieldbyname('bairro').AsString)+'</bairro>' + #13#10;
    xXml := xXml + '  <complemento>'+RemoveAcento(CDSCadastro.fieldbyname('complemento').AsString)+'</complemento>' + #13#10;
    xXml := xXml + '  <uf>'+CDSCadastro.fieldbyname('uf').AsString+'</uf>' + #13#10;
    xXml := xXml + '  <cidade>'+RemoveAcento(CDSCadastro.fieldbyname('cidade').AsString)+'</cidade>' + #13#10;
    xXml := xXml + '  <pais>'+RemoveAcento(CDSCadastro.fieldbyname('pais').AsString)+'</pais>'+ #13#10;
    xXml := xXml + '</Dados>';
    arq.Add(xXml);
    arq.SaveToFile(sDir+CDSCadastro.fieldbyname('cpf').AsString+'.xml');
  finally
    FreeAndNil(arq);
  end;

end;

function TfrmCadpessoa.RemoveAcento(aText: string): string;
const
  ComAcento = '‡‚ÍÙ˚„ı·ÈÌÛ˙Á¸Ò˝¿¬ ‘€√’¡…Õ”⁄«‹—›';
  SemAcento = 'aaeouaoaeioucunyAAEOUAOAEIOUCUNY';
var
  x: Cardinal;
begin;
  for x := 1 to Length(aText) do
  begin
    if (Pos(aText[x], ComAcento) <> 0) then
      aText[x] := SemAcento[ Pos(aText[x], ComAcento) ];
  end; 
  Result := aText;
end;

end.
