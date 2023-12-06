package body PageRank_Pleine is
    procedure Calculer_S(H : in out Matrices_Pleines_Inst.T_Matrice) is
    Est_Nul : Boolean;
    begin
        for I in 1..Matrices_Pleines_Inst.Taille_Matrice(H) loop
            Est_Nul:=true;
            for J in 1..Matrices_Pleines_Inst.Taille_Matrice(H) loop
                Est_Nul := Est_Nul and then (Matrices_Pleines_Inst.Element(H,I,J)<0.0001);
            end loop;
            if Est_Nul then
                for J in 1..Matrices_Pleines_Inst.Taille_Matrice(H) loop
                    Matrices_Pleines_Inst.Modifier(H, I, J, 1.0 / Long_Float(Matrices_Pleines_Inst.Taille_Matrice(H)));
                end loop;
            end if;
        end loop;

    end Calculer_S;

    procedure Calculer_G(S : in out Matrices_Pleines_Inst.T_Matrice; alpha : Long_Float) is
    begin
        for I in 1..Matrices_Pleines_Inst.Taille_Matrice(S) loop
            for J in 1..Matrices_Pleines_Inst.Taille_Matrice(S) loop
                Matrices_Pleines_Inst.Modifier(S, I, J, Alpha *Matrices_Pleines_Inst.Element(S,I,J) + (1.0-Alpha)/Long_Float(Matrices_Pleines_Inst.Taille_Matrice(S)));
            end loop;
        end loop;
    end Calculer_G;

end PageRank_Pleine;