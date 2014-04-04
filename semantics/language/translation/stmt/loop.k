module C-STMT-LOOP
     imports C-SYNTAX
     imports C-DYNAMIC-SYNTAX
     imports COMPAT-SYNTAX
     
     rule ForClauseExpression(K:K) => Computation(K) [structural]

     rule [for]:
          For(BlockNum:Int, Pre:K, Control:K, Post:K, S:K)
          => pushBlock 
          ~> setCurrentBlock(BlockNum)
          ~> Pre
          ~> Computation(Control)
          ~> S ~> Computation(Post)
          ~> popBlock
          [structural] 
          
     syntax K ::= setCurrentBlock(Int)
     rule <k> setCurrentBlock(BlockNum:Int) => .K ...</k>
          <curr-block> _ => BlockNum </curr-block>
          [structural]

     rule [while]:
          While(B:K, S:K)
          => Computation(B)
          ~> S
          [structural] 
     
     rule [do-while-mark]:
          DoWhile(B:K, S:K)
          => S
          ~> Computation(B)
          [structural] 

     rule [continue]:
          Continue => .
          [structural]
          
endmodule