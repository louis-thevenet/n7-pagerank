generic
    Capacite : Integer;
    type T_Element is private;

private
    type T_Tab is array (1..Capacite) of T_Element;


    type T_Matrice_Adj is array(1..Capacite) of T_Tab;



end PageRank;