package body PageRank_Pleine is
    procedure Calculer_S(H : in out Matrices_Pleines_Inst.T_Matrice) is
    Est_Nul : Boolean;
    begin
        for I in 1..Matrices_Pleines_Inst.Lignes_Matrice(H) loop
            Est_Nul:=true;
            for J in 1..Matrices_Pleines_Inst.Colonnes_Matrice(H) loop
                Est_Nul := Est_Nul and then (Matrices_Pleines_Inst.Element(H,I,J)<0.000001);
            end loop;
            if Est_Nul then
                for J in 1..Matrices_Pleines_Inst.Colonnes_Matrice(H) loop
                    Matrices_Pleines_Inst.Modifier(H, I, J, 1.0 / Long_Float(Matrices_Pleines_Inst.Lignes_Matrice(H)));
                end loop;
            end if;
        end loop;

    end Calculer_S;

    procedure Calculer_G(S : in out Matrices_Pleines_Inst.T_Matrice; alpha : Long_Float) is
    begin
        for I in 1..Matrices_Pleines_Inst.Lignes_Matrice(S) loop
            for J in 1..Matrices_Pleines_Inst.Colonnes_Matrice(S) loop
                Matrices_Pleines_Inst.Modifier(S, I, J, Alpha *Matrices_Pleines_Inst.Element(S,I,J) + (1.0-Alpha)/Long_Float(Matrices_Pleines_Inst.Lignes_Matrice(S)));
            end loop;
        end loop;
    end Calculer_G;

procedure Calculer_Pi_Transpose(Poids : in out Vecteurs_Pleins_Inst.T_Matrice) is
begin
    for J in 1..Vecteurs_Pleins_Inst.Lignes_Matrice(Poids) loop
        Vecteurs_Pleins_Inst.Modifier(Poids, J, 1, 1.0 / Long_Float(Vecteurs_Pleins_Inst.Lignes_Matrice(Poids)));

    end loop;
end Calculer_Pi_Transpose;

procedure Prochaine_Iteration (Poids : in out Vecteurs_Pleins_Inst.T_Matrice; G : in Matrices_Pleines_Inst.T_Matrice) is
    Tmp : Long_Float;
begin
    for J in 1..Matrices_Pleines_Inst.Lignes_Matrice(G) loop
        Tmp :=0.0;
        for I in 1..Matrices_Pleines_Inst.Lignes_Matrice(G) loop
            Tmp := Tmp + Vecteurs_Pleins_Inst.Element(Poids,i,1) * Matrices_Pleines_Inst.Element(G,I,J);
        end loop;
        Vecteurs_Pleins_Inst.Modifier(Poids,J,1, Tmp);
    end loop;
end Prochaine_Iteration;

procedure Iterer (Poids : in out Vecteurs_Pleins_Inst.T_Matrice; G : in Matrices_Pleines_Inst.T_Matrice; K : Integer) is
begin
    for I in 1..K+1  loop
        Prochaine_Iteration(Poids, G);
    end loop;
end Iterer;

end PageRank_Pleine;