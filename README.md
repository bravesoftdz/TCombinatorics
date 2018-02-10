# TCombinatorics

Combinatorics is a library written in Delphi that's compatible with VCL and FMX. The usage is trivial: include the source file to your project, add `Combinatorics` in the `uses` clauses and use the code as follows.

``` delphi
procedure TForm1.Button1Click(Sender: TObject);
var TestComb: ICombinatorics;
    aValue: UInt64; //unsigned integer
begin 
 TestComb := TDispositions.Create(8, 5, true);
 aValue := TestComb.Getsolution;
end;
```

Everything is reference counted because we're creating an object with an interface type so no try finally needed. There are 3 kind of classes: `TDispositions`, `TCombinations` and `TPermutations`. The constructor takes 3 parameters:

 1. <b>n</b>: The number of items that you have
 2. <b>k</b>: The number of groups in which you can arrange the n items
 3. <b>repetition</b>: True if there can be repetitions (duplicates) in the n items that you have. False if the aren't duplicates.

The class `TPermutations` is a bit different because the parameter `k` is not an integer but it's an (open) array of integers. That's because you have to put the number of repeated items and so the constructor will look like this:

``` delphi
 TestComb := TPermutations.Create(8, [1,2], true);
```
