unit Unit1;

{$mode Delphi}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Buttons,
  ExtCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)

    BitBtn1: TBitBtn;
    BitBtn10: TBitBtn;
    BitBtn11: TBitBtn;
    BitBtn12: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    BitBtn6: TBitBtn;
    BitBtn7: TBitBtn;
    BitBtn8: TBitBtn;
    BitBtn9: TBitBtn;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Timer1: TTimer;
    type TAnArray = array[0..11] of string;
    procedure Inicio(Sender: TObject);
    procedure Clique(Sender: TObject);
    procedure LimparTodasImagens();
    procedure LimparImagens();
    procedure VerificaRecorde();
    function Randomizar(animais: TAnArray): TAnArray;
    function Gerador(): TAnArray;
    procedure Timer1Timer(Sender: TObject);
    procedure VerificaVitoria(Sender: TObject);

  private

  end;

var
  Form1: TForm1;
  CartaVirada1: TBitBtn;
  CartaVirada2: TBitBtn;
  Viradas: integer;
  Counter: integer = 0;

implementation

{$R *.lfm}

{ TForm1 }
procedure TForm1.LimparImagens();
begin
  CartaVirada1.Glyph.Clear;
  CartaVirada2.Glyph.Clear;
end;

procedure TForm1.Clique(Sender: TObject);
var
  Current: TBitBtn;
begin
  Current := Sender as TBitBtn;

  if Current.Hint = 'OK' then
    Exit;

  if Current.Caption = '' then
    Current.Glyph.LoadFromFile('imagens/' + Current.Hint + ' (Personalizado).bmp');

  Viradas := Viradas + 1;

  if (Viradas mod 2 = 1) then
  begin
    CartaVirada1 := Current;
    Timer1.Enabled := True;
    Exit;
  end;

  if (Viradas mod 2 = 0) then
  begin
    CartaVirada2 := Current;
    if (CartaVirada1.Name = CartaVirada2.Name) then
      LimparImagens()
    else
    if (CartaVirada2.Hint = CartaVirada1.Hint) then
    begin
      CartaVirada1.Hint := 'OK';
      CartaVirada2.Hint := 'OK';
    end;

  end;
  if (CartaVirada2.Hint <> CartaVirada1.Hint) then
  begin
    ShowMessage('Tente Novamente');
    LimparImagens();
  end;

  CartaVirada1 := nil;
  CartaVirada2 := nil;

end;

function TForm1.Randomizar(animais: TAnArray): TAnArray;
var
  i: integer;
  cont: integer;
  letrasRandom: TAnArray = ('.', '.', '.', '.', '.', '.', '.', '.', '.', '.', '.', '.');
begin

  cont := 0;

  for i := 0 to 11 do
  begin
    cont := Random(12);
    letrasRandom[i] := animais[cont];
    while animais[cont] = '.' do
    begin
      cont := Random(12);
      letrasRandom[i] := animais[cont];
    end;
    animais[cont] := '.';
  end;

  Result := letrasRandom;

end;

function TForm1.Gerador(): TAnArray;
var
  i: integer;
  animais: TAnArray = ('PORCO', 'PAPAGAIO', 'VACA', 'CACHORRO',
    'GATO', 'ABELHA', 'PORCO', 'PAPAGAIO', 'VACA', 'CACHORRO', 'GATO', 'ABELHA');
  letrasRandom: TAnArray = ('.', '.', '.', '.', '.', '.', '.', '.', '.', '.', '.', '.');
  Resultado: TAnArray = ('.', '.', '.', '.', '.', '.', '.', '.', '.', '.', '.', '.');
begin
  letrasRandom := Randomizar(animais);
  for i := 0 to 11 do
    Resultado[i] := letrasRandom[i];
  Result := Resultado;

end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  Counter := Counter + 1;
  Label2.Caption := IntToStr(Counter) + ' segundos';
end;

procedure TForm1.Inicio(Sender: TObject);
var
  Result: TAnArray;
begin
  Label2.Caption := IntToStr(Counter);
  Result := Gerador();
  BitBtn1.hint := Result[0];
  BitBtn2.hint := Result[1];
  BitBtn3.hint := Result[2];
  BitBtn4.hint := Result[3];
  BitBtn5.hint := Result[4];
  BitBtn6.hint := Result[5];
  BitBtn7.hint := Result[6];
  BitBtn8.hint := Result[7];
  BitBtn9.hint := Result[8];
  BitBtn10.hint := Result[9];
  BitBtn11.hint := Result[10];
  BitBtn12.hint := Result[11];
end;

procedure TForm1.LimparTodasImagens();
begin
  BitBtn1.Glyph.Clear;
  BitBtn2.Glyph.Clear;
  BitBtn3.Glyph.Clear;
  BitBtn4.Glyph.Clear;
  BitBtn5.Glyph.Clear;
  BitBtn6.Glyph.Clear;
  BitBtn7.Glyph.Clear;
  BitBtn8.Glyph.Clear;
  BitBtn9.Glyph.Clear;
  BitBtn10.Glyph.Clear;
  BitBtn11.Glyph.Clear;
  BitBtn12.Glyph.Clear;
end;

procedure TForm1.VerificaRecorde();
begin
  if (StrToInt(Label4.Caption) = 0) then
    Label4.Caption := IntToStr(999999);
  if (Counter < StrToInt(Label4.Caption)) then
    Label4.Caption := IntToStr(Counter);
  Counter := 0;
end;

procedure TForm1.VerificaVitoria(Sender: TObject);
begin
  if (BitBtn1.hint = 'OK') and (BitBtn2.hint = 'OK') and (BitBtn3.hint = 'OK') and
    (BitBtn4.hint = 'OK') and (BitBtn5.hint = 'OK') and (BitBtn6.hint = 'OK') and
    (BitBtn7.hint = 'OK') and (BitBtn8.hint = 'OK') and (BitBtn9.hint = 'OK') and
    (BitBtn10.hint = 'OK') and (BitBtn11.hint = 'OK') and (BitBtn12.hint = 'OK') then
  begin
    Timer1.Enabled := False;
    ShowMessage('Parabens! Você Venceu!');
    LimparTodasImagens();
    VerificaRecorde();
    Inicio(Form1);
  end;

end;

end.
