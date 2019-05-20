 find_less_ans_row(Columns,C_Index,C_Number,C_Ans_Bag),
 find_less_ans_row(Rows,R_Index,R_Number,R_Ans_Bag),
(
 C_Number > R_Number->
    update_puzzle(Rows,R_Index,R_Ans_Bag,Bag_puzzle),
    maplist(puzzle_solution,Bag_puzzle);
 C_Number < R_Number->
    update_puzzle(Columns,C_Index,C_Ans_Bag,Bag_puzzle),
	maplist(puzzle_solution,Bag_puzzle);
    check_sol(Columns),
    check_sol(Rows)
 ).

update_puzzle(Rows,R_Index,R_Ans_Bag,[F|R]):-
 New_index is R_Index +1,
 bagof(New_puzzle,update_row(Rows,-1,New_index,[],New_puzzle,F),Bag_puzzle).