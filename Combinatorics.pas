unit Combinatorics;

interface

uses
 System.Math, System.SysUtils, Combinatorio, System.Classes;

type

 ICombinatorics = interface
  function GetSolution(): UInt64;
  function GetFormula(): string;
 end;

 TCombinations = class(TInterfacedObject, ICombinatorics)
  private
   n, k: integer;
   repetition: boolean;
   function Factorial(const x: integer): UInt64;
  public
   constructor Create(const n, k: integer; const repetition: boolean);
   function GetSolution(): UInt64;
   function GetFormula(): string;
 end;

 TDispositions = class(TInterfacedObject, ICombinatorics)
  private
   n, k: integer;
   repetition: boolean;
   function Factorial(const x: integer): UInt64;
  public
   constructor Create(const n, k: integer; const repetition: boolean);
   function GetSolution(): UInt64;
   function GetFormula(): string;
 end;

 TPermutations = class(TInterfacedObject, ICombinatorics)
  private
   n: integer;
   k: array of integer;
   repetition: boolean;
   function Factorial(const x: integer): UInt64;
  public
   constructor Create(const n: integer; const k: array of integer; repetition: boolean);
   function GetSolution(): UInt64;
   function GetFormula(): string;
 end;

implementation

{ TCombinazioni }

constructor TCombinations.Create(const n, k: integer; const repetition: boolean);
begin

 inherited Create;

 //controllo di avere un buon input
 if ((n < 1) or (k < 1) ) then
  begin
   raise Exception.Create('"n" e "k" devono essere > 0');
  end;

 if ( (n < k) and (repetition = false) ) then
  begin
   raise Exception.Create('n deve essere maggiore di k');
  end;

 //imposto le condizioni del costruttore
 Self.n := n;
 Self.k := k;
 Self.repetition := repetition;

end;

function TCombinations.Factorial(const x: integer): UInt64;
begin

 Result:= 1;
 if x > 0 then
  begin
   Result:= Factorial(x-1)*x;
  end;

end;

function TCombinations.GetFormula: string;
begin

 if (repetition) then
  Result := '(n+k-1)! / (k! * (n-1)!)'
 else
  Result := 'n! / (k! * (n-k)!)';

end;

function TCombinations.GetSolution: UInt64;
begin

 if ((n >= 31) and not(repetition)) or (((n >= 21) or (k >= 21)) and repetition) then
 begin
  raise Exception.Create('Valori troppo grandi!');
 end;

 if (repetition) then
  Result := Factorial(n+k-1) div (Factorial(k) * Factorial(n-1))
 else
  Result := Factorial(n) div (Factorial(k) * Factorial(n-k));

end;

{ TDisposizioni }

constructor TDispositions.Create(const n, k: integer;
  const repetition: boolean);
begin

 inherited Create;

 //controllo di avere un buon input
 if ((n < 1) or (k < 1) ) then
  begin
   raise Exception.Create('"n" e "k" devono essere > 0');
  end;

 if ( (n < k) and (repetition = false) ) then
  begin
   raise Exception.Create('n deve essere maggiore di k');
  end;

 //imposto le condizioni del costruttore
 Self.n := n;
 Self.k := k;
 Self.repetition := repetition;

end;

function TDispositions.Factorial(const x: integer): UInt64;
begin

 Result:= 1;
 if x > 0 then
  begin
   Result:= Factorial(x-1)*x;
  end;

end;

function TDispositions.GetFormula: string;
begin

 if (repetition) then
  Result := 'n^k'
 else
  Result := 'n! / (n-k)!';

end;

function TDispositions.GetSolution: UInt64;
begin

 //risultati troppo grandi che non vanno bene
 if ((n >= 16) and (k >= 16)) then
  begin
   raise Exception.Create('Valori troppo grandi!');
  end;

 if (repetition) then
  Result := round(power(n,k))
 else
  Result := Factorial(n) div Factorial(n-k);

end;

{ TPermutazioni }

constructor TPermutations.Create(const n: integer; const k: array of integer; repetition: boolean);
var a: integer;
begin

 inherited Create;

 //controllo di avere un buon input
 if ( (n > 15) or (Length(k) > 10) ) then
  begin
   raise Exception.Create('Valori troppo grandi!');
  end;

 if Length(k) = 0 then
   raise Exception.Create('The array k must have at least one value!');

 //imposto le condizioni del costruttore
 Self.n := n;

 SetLength(Self.k, Length(k));
 for a := Low(k) to High(k) do
   Self.k[a] := k[a];

 Self.repetition := repetition;

end;

function TPermutations.Factorial(const x: integer): UInt64;
begin

 Result:= 1;
 if x > 0 then
  begin
   Result:= Factorial(x-1)*x;
  end;

end;

function TPermutations.GetFormula: string;
begin

 if (repetition) then
  begin
   Result := 'n! / (x1!*x2!*x3!...*xk!)';
  end
 else
  begin
   Result := 'n!';
  end;

end;

function TPermutations.GetSolution: UInt64;
var diviso: UInt64;
    i: integer;
begin

 if (repetition) then
  begin
   diviso := 1;

   for i := Low(k) to High(k) do
    begin
     diviso := diviso * Factorial(k[i]);
    end;

   Result := Factorial(n) div diviso;
  end
 else
  begin
   Result := Factorial(n);
  end;

end;

end.
