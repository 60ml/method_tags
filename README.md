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

このように記述した場合、メソッド `foo` と `baz` にはタグが適用されます。

タグ付けされたメソッド名には、インスタンスから `tagged_methods` という private メソッドでアクセスできます。

フィルタの `if` オプションが長いので、Rails 用に `tagged_action` という
クラスメソッドも用意しました。これを使えば上記のフィルタは

```ruby
before_filter :filter_foo, if: tagged_action(:tag_foo)
```

と記述できます。


ライセンス
-----------
MIT ライセンスです。
