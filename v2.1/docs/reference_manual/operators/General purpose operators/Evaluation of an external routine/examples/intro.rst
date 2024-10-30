Assuming that SQL3 is an SQL statement which produces DS_r starting from DS_1: ::

    DS_r := eval( SQL3( DS_1 ) language “PL/SQL”
            returns dataset { identifier<geo_area> ref_area,
                                identifier<date> time_,
                                measure<number> obs_value,
                                attribute<string> obs_status } );

Assuming that f is an externally defined Java method: ::

    DS_r := DS_1 [calc Me := eval ( f (Me ) language “Java” returns integer) ];

