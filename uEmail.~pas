unit uEmail;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons;

type
  Tfrmemail = class(TForm)
    edtsmtp: TLabeledEdit;
    edtemail: TLabeledEdit;
    edtsenha: TLabeledEdit;
    edtporta: TLabeledEdit;
    chkssl: TCheckBox;
    btnOk: TBitBtn;
    procedure btnOkClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmemail: Tfrmemail;

implementation

uses uCadPessoa;


{$R *.dfm}

procedure Tfrmemail.btnOkClick(Sender: TObject);
begin
  frmCadpessoa.FSmtp  := edtsmtp.Text;
  frmCadpessoa.Femail := edtemail.Text;
  frmCadpessoa.Fsenha := edtsenha.Text;
  frmCadpessoa.Fporta := edtporta.Text;
  frmCadpessoa.Fssl   := chkssl.Checked;
end;

end.
