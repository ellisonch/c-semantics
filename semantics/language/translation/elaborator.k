module C-ELABORATOR-SYNTAX
     imports C-SYNTAX

     syntax KItem ::= elaborate(K)
     syntax KItem ::= elaborate(K, K)

     syntax KItem ::= elaborateDone(K)
     syntax KItem ::= elaborateDone(K, K)

     // Elaboration for initializers -- copies up the environment.
     syntax KItem ::= elaborateInit(K)
     syntax KItem ::= elaborateInitDone(K)

     syntax KItem ::= typeof(K) [strict]

     syntax KItem ::= runInit(K)
endmodule

module C-ELABORATOR
     imports C-ELABORATOR-SYNTAX

     imports C-DYNAMIC-SYNTAX

     syntax KItem ::= elabFrame(K, K, Bag)
                    | elabInitFrame(K, K, Bag)

     rule (.K => K) ~> compoundExp(K:K)
     rule R:KResult ~> compoundExp(K:K)
          => te(compoundExp(K), type(R))

     rule <k> elaborate(K:K) ~> Cont:K => K </k>
          <elab> OldElab:K => .K </elab>
          <local> L:Bag </local>
          <elab-stack>
               .List => ListItem(elabFrame(Cont, OldElab, L))
          ...</elab-stack>
     rule <k> .K => elaborateDone(K) ~> Cont </k>
          <elab> K:K => OldElab </elab>
          <local> _ => L </local>
          <elab-stack>
               ListItem(elabFrame(Cont:K, OldElab:K, L:Bag)) => .List
          ...</elab-stack>

     rule <k> elaborateInit(K:K) ~> Cont:K => allowInit(K) </k>
          <elab> OldElab:K => .K </elab>
          (<init-calc> I:Bag </init-calc>
               => <init-calc>... .Bag ...</init-calc>)
          <elab-stack>
               .List => ListItem(elabInitFrame(Cont, OldElab, I))
          ...</elab-stack>
     rule <k> .K => elaborateInitDone(K) ~> Cont </k>
          <elab> K:K => OldElab </elab>
          <init-calc> _ => I </init-calc>
          <elab-stack>
               ListItem(elabInitFrame(Cont:K, OldElab:K, I:Bag)) => .List
          ...</elab-stack>

     rule (.K => elaborateInit(K)) ~> runInit(K:K)
     rule elaborateInitDone(_) ~> runInit(_) => .K

     rule elaborate(K1:K, K2:K) => elaborate(K1) ~> elaborate(K2)
     rule elaborateDone(K1:K) ~> elaborate(K2:K)
          => elaborate(K2) ~> elaborateDone(K1)
     rule elaborateDone(K2:K) ~> elaborateDone(K1:K)
          => elaborateDone(K1:K, K2:K)

     rule typeof(V:KResult) => type(V)

endmodule