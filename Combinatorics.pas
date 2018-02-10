unit Unit3;

interface

uses
 System.Math, System.SysUtils, Combinatorio, System.Classes;

type

 ICombinatorio = interface
  function getSoluzioni(): UInt64;
  function getFormula(): string;
 end;

 TCombinazioni = class(TInterfacedObject, ICombinatorio)
  private
   n, k: integer;
   ripetizione: boolean;
   function fattoriale(const x: integer): UInt64;
  public
   constructor Create(const n, k: integer; const ripetizione: boolean);
   function getSoluzioni(): UInt64;
   function getFormula(): string;
 end;

 TDisposizioni = class(TInterfacedObject, ICombinatorio)
  private
   n, k: integer;
   ripetizione: boolean;
   function fattoriale(const x: integer): UInt64;
  public
   constructor Create(const n, k: integer; const ripetizione: boolean);
   function getSoluzioni(): UInt64;
   function getFormula(): string;
 end;

 TPermutazioni = class(TInterfacedObject, ICombinatorio)
  private
   n: integer;
   k: string;
   ripetizione: boolean;
   function fattoriale(const x: integer): UInt64;
  public
   constructor Create(const n: integer; const k: string; ripetizione: boolean);
   function getSoluzioni(): UInt64;
   function getFormula(): string;
 end;

implementation

{ TCombinazioni }

constructor TCombinazioni.Create(const n, k: integer; const ripetizione: boolean);
begin

 inherited Create;

 //controllo di avere un buon input
 if ((n < 1) or (k < 1) ) then
  begin
   raise Exception.Create('"n" e "k" devono essere > 0');
  end;

 if ( (n < k) and (ripetizione = false) ) then
  begin
   raise Exception.Create('n deve essere maggiore di k');
  end;

 //imposto le condizioni del costruttore
 Self.n := n;
 Self.k := k;
 Self.ripetizione := ripetizione;

end;

function TCombinazioni.fattoriale(const x: integer): UInt64;
begin

 Result:= 1;
 if x > 0 then
  begin
   Result:= fattoriale(x-1)*x;
  end;

end;

function TCombinazioni.getFormula: string;
begin

 if (ripetizione) then
  Result := '(n+k-1)! / (k! * (n-1)!)'
 else
  Result := 'n! / (k! * (n-k)!)';

end;

function TCombinazioni.getSoluzioni: UInt64;
begin

 if ((n >= 31) and not(ripetizione)) or (((n >= 21) or (k >= 21)) and ripetizione) then
 begin
  raise Exception.Create('Valori troppo grandi!');
 end;

 if (ripetizione) then
  Result := fattoriale(n+k-1) div (fattoriale(k) * fattoriale(n-1))
 else
  Result := fattoriale(n) div (fattoriale(k) * fattoriale(n-k));

end;

{ TDisposizioni }

constructor TDisposizioni.Create(const n, k: integer;
  const ripetizione: boolean);
begin

 inherited Create;

 //controllo di avere un buon input
 if ((n < 1) or (k < 1) ) then
  begin
   raise Exception.Create('"n" e "k" devono essere > 0');
  end;

 if ( (n < k) and (ripetizione = false) ) then
  begin
   raise Exception.Create('n deve essere maggiore di k');
  end;

 //imposto le condizioni del costruttore
 Self.n := n;
 Self.k := k;
 Self.ripetizione := ripetizione;

end;

function TDisposizioni.fattoriale(const x: integer): UInt64;
begin

 Result:= 1;
 if x > 0 then
  begin
   Result:= fattoriale(x-1)*x;
  end;

end;

function TDisposizioni.getFormula: string;
begin

 if (ripetizione) then
  Result := 'n^k'
 else
  Result := 'n! / (n-k)!';

end;

function TDisposizioni.getSoluzioni: UInt64;
begin

 //risultati troppo grandi che non vanno bene
 if ((n >= 16) and (k >= 16)) then
  begin
   raise Exception.Create('Valori troppo grandi!');
  end;

 if (ripetizione) then
  Result := round(power(n,k))
 else
  Result := fattoriale(n) div fattoriale(n-k);

end;

{ TPermutazioni }

constructor TPermutazioni.Create(const n: integer; const k: string; ripetizione: boolean);
var a: integer;
begin

 inherited Create;

 //controllo di avere un buon input
 if ( (n > 15) or (k.Length > 10) ) then
  begin
   raise Exception.Create('Valori troppo grandi!');
  end;

 //imposto le condizioni del costruttore
 Self.n := n;
 Self.k := k;
 Self.ripetizione := ripetizione;

end;

function TPermutazioni.fattoriale(const x: integer): UInt64;
begin

 Result:= 1;
 if x > 0 then
  begin
   Result:= fattoriale(x-1)*x;
  end;

end;

function TPermutazioni.getFormula: string;
begin

 if (ripetizione) then
  begin
   Result := 'n! / (x1!*x2!*x3!...*xk!)';
  end
 else
  begin
   Result := 'n!';
  end;

end;

function TPermutazioni.getSoluzioni: UInt64;
var diviso: UInt64;
    nums: TStrings;
    i: integer;
begin

 if (ripetizione) then
  begin

   nums := TStringList.Create;
   nums.CommaText := k;
   diviso := 1;

   for i := 0 to (nums.Count-1) do
    begin
     diviso := diviso * fattoriale(StrToInt(nums[i]));
    end;

   Result := fattoriale(n) div diviso;
  end
 else
  begin
   Result := fattoriale(n);
  end;

end;

end.
