%%% -------------------------------------------------------------------
%%% Author  : Andrew Berman
%%% Description :
%%%
%%% Created : Aug 4, 2011
%%% -------------------------------------------------------------------
-module(pooly_member_sup).

-behaviour(supervisor).
%% --------------------------------------------------------------------
%% External exports
%% --------------------------------------------------------------------
-export([
		 start_link/1
		]).

%% --------------------------------------------------------------------
%% Internal exports
%% --------------------------------------------------------------------
-export([
	 init/1
        ]).

start_link(Name) ->
    NameStr = case is_atom(Name) of
                  true -> atom_to_list(Name);
                  false -> Name
              end,
    
 	supervisor:start_link({local, list_to_atom(NameStr ++ "_sup")}, ?MODULE, []).

init([]) ->
	Restart = {simple_one_for_one, 1, 1},
	Child = {pooly_member, {pooly_member, start_link, []},
				   temporary, brutal_kill, worker, [pooly_member]},	
	{ok, {Restart, [Child]}}.