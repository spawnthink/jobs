-module(jobs_lib).

-export([timestamp/0,
         timestamp_to_datetime/1]).


timestamp() ->
    %% Invented epoc is {1258,0,0}, or 2009-11-12, 4:26:40
    {MS,S,US} = erlang:now(),
    (MS-1258)*1000000000 + S*1000 + US div 1000.

timestamp_to_datetime(TS) ->
    %% Our internal timestamps are relative to Now = {1258,0,0}
    %% It doesn't really matter much how we construct a now()-like tuple,
    %% as long as the weighted sum of the three numbers is correct.
    S = TS div 1000,
    MS = TS rem 1000,
    %% return {Datetime, Milliseconds}
    {calendar:now_to_datetime({1258,S,0}), MS}.