method_tags
==============

Rails のコントローラの冒頭に `before_filter` などのフィルタを記述するとき

```ruby
before_filter :foo_filter, only: [:foo_aa,
                                  :foo_ba,
                                  :foo_ca,
                                  ...
                                  :foo_zz,
                                 ]
```

ひとつのコントローラにアクションが多いと、フィルタの条件に並ぶアクションも
増えてしまうこともあるかもしれません。

こうしたことは、`module` を使うことでもある程度防ぐことはできますが、
フィルタを適用したいメソッド群に名前がつけられれば、それを指定するだけで
よくなるのではないでしょうか？

`method_tags` はメソッドを記述する際、その前に `_tag_` と書いてタグ名を書けば
メソッドにタグをつけてくれます。

```ruby
 class FooController < ...
   include MethodTags

   before_filter :filter_foo, if: -> { action_name.to_sym.in? tagged_methods(:tag_foo) }

   _tag_ :tag_foo
   def foo
     ...
   end

   def baa
     ...
   end

   _tag_ :tag_foo
   def baz
     ...
   end

   ...
 end
```

ライセンス
-----------
MIT ライセンスです。
