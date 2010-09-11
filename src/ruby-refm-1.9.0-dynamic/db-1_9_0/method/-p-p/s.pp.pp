visibility=public
kind=defined
names=pp

--- pp(obj, out = $>, width = 79)    -> object
obj を out に幅 width で pretty print します。
out を返します。

@param obj 表示したいオブジェクトを指定します。

@param out 出力先を指定します。<< メソッドが定義されている必要があります。

@param width 出力先の幅を指定します。

  str = PP.pp([[:a, :b], [:a, [[:a, [:a, [:a, :b]]], [:a, :b],]]], '', 20)
  puts str
  #=>
  [[:a, :b],
   [:a,
    [[:a,
      [:a, [:a, :b]]],
     [:a, :b]]]]

