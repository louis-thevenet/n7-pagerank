package body Matrice_Pleine is
    procedure Initialiser_Matrice(M : T_Matrice) is
    begin
        M.Taille := Capacite;
        for I in 1..Capacite+1 loop
            for J in 1..Capacite+1 loop
                M.Adj(I,J) := 0;
            end loop;
        end loop;
    end Initialiser_Matrice;

end Matrice_Pleine;
