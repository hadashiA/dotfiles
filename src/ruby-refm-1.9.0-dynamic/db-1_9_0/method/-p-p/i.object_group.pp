visibility=public
kind=defined
names=object_group

--- object_group(obj) { ... }    -> ()

以下と等価な働きをするもので簡便のために用意されています。
  group(1, '#<' + obj.class.name, '>') { ... }

