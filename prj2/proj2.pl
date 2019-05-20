%  Author   : Tengsheng Ho
%  Origin   : Sat May  11 01:53 2019
%  Purpose  : Source code for proj2
%  Copyright: (c) 2019 Tengsheng Ho.  All rights reserved.
%
%  puzzle_solution will take puzzle as a argument which is defined in the
%  project document. This program will solve the puzzle according to 
%  hints and conditions that decribed in the document.

:- use_module(library(clpfd)).



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% First bound all the solution list to a single digit and all the squares on
% the diagonal. Second, Transpose rows to columns so that we can find the 
% solution for each case.  

puzzle_solution(Rows):-
 bound_single_digit(Rows),
 bound_diagonal(Rows),
 transpose(Rows,Columns),
 check_sol(Rows),
 check_sol(Columns).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% bound_single_digit will ignore the first row and call bound_single_digit1(R) 
% to handle the rest of the lists.
% bound_single_digit1 will ignore the first element and make all elements bound 
% to a single digit number. 
% Also it will make sure all elements in a list are different.

bound_single_digit([_|R]):-
bound_single_digit1(R). 

bound_single_digit1([]).
bound_single_digit1([[_|S]|R]):- 
 S ins 1..9,
 all_distinct(S),
 bound_single_digit1(R).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% bound_diagonal ignores the first list. and call chech_each_list with the rest 
% of lists and 1 for index as arguments.
% There are two base cases for chech_each_list, and it will iterate for 
% every two lists in lists to get the square element and unify them.

bound_diagonal([_|R]):-
  chech_each_list(R,1). 

chech_each_list([],_).
chech_each_list([_|[]],_).
chech_each_list([F,F2|R],Index):-
 nth0(Index,F,X),
 nth0(New_index,F2,NextX),
 X = NextX,
 New_index is Index+1,
 chech_each_list([F2|R],New_index).
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Ignore the first list and call c(R) to do the rest.
% There is one base case for check_sol1 and it will iterate through the list 
% and call check_list_sol to find the solution to each row or column.
% sum_list has a accumulation 0 as argument and product_list has 1 for that.

check_sol([_F|R]):- 
 check_sol1(R).
 
check_sol1([]).
check_sol1([F|R]):- 
 check_list_sol(F), 
 check_sol1(R).
 
check_list_sol([F|R]):-
 sum_list(R,0,F);
 product_list(R,1,F).
 
sum_list([],Sum,Sum).
sum_list([X|R],Acc,Ans):-
 member(X,[1,2,3,4,5,6,7,8,9]),
 all_distinct([X|R]),
 NewAcc #= X + Acc,
 sum_list(R,NewAcc,Ans).
 
product_list([],Product,Product).
product_list([X|R],Acc,Ans):-
 member(X,[1,2,3,4,5,6,7,8,9]),
 all_distinct([X|R]),
 NewAcc #= X * Acc,
 product_list(R,NewAcc,Ans).
 