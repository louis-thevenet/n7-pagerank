package body PageRank_Pleine is

    procedure Calculer_S(H : in out Matrices_Pleines_Inst.T_Matrice) is
        Est_Nul : Boolean;
    begin
        for I in 1 .. Matrices_Pleines_Inst.Lignes_Matrice(H) loop
            Est_Nul := True;
            for J in 1 .. Matrices_Pleines_Inst.Colonnes_Matrice(H) loop
                Est_Nul := Est_Nul and then (Matrices_Pleines_Inst.Element(H, I, J) < 0.000001);
            end loop;
            if Est_Nul then
                for J in 1 .. Matrices_Pleines_Inst.Colonnes_Matrice(H) loop
                    Matrices_Pleines_Inst.Modifier(H, I, J, 1.0 / Long_Float(Matrices_Pleines_Inst.Lignes_Matrice(H)));
                end loop;
            end if;
        end loop;
    end Calculer_S;

    procedure Calculer_G(S : in out Matrices_Pleines_Inst.T_Matrice; alpha : Long_Float) is
    begin
        for I in 1 .. Matrices_Pleines_Inst.Lignes_Matrice(S) loop
            for J in 1 .. Matrices_Pleines_Inst.Colonnes_Matrice(S) loop
                Matrices_Pleines_Inst.Modifier(S, I, J, Alpha * Matrices_Pleines_Inst.Element(S, I, J) + (1.0 - Alpha) / Long_Float(Matrices_Pleines_Inst.Lignes_Matrice(S)));
            end loop;
        end loop;
    end Calculer_G;

    procedure Calculer_Pi_Transpose(Resultat : in out PageRank_Result_Inst.T_Resultat) is
    begin
        for J in 1 .. Resultat.Taille loop
            Resultat.Poids(J) := 1.0 / Long_Float(Resultat.Taille);
        end loop;
    end Calculer_Pi_Transpose;

    function Prochaine_Iteration(Poids : PageRank_Result_Inst.T_Tab_Poids; G : in Matrices_Pleines_Inst.T_Matrice) return PageRank_Result_Inst.T_Tab_Poids is
        Tmp : Long_Float;
        Resultat : PageRank_Result_Inst.T_Tab_Poids;
    begin
        for J in 1 .. Matrices_Pleines_Inst.Lignes_Matrice(G) loop
            Tmp := 0.0;
            for I in 1 .. Matrices_Pleines_Inst.Lignes_Matrice(G) loop
                Tmp := Tmp + Poids(I) * Matrices_Pleines_Inst.Element(G, I, J);
            end loop;
            Resultat(J) := Tmp;
        end loop;
        return Resultat;
    end Prochaine_Iteration;

    procedure Iterer(Poids : in out PageRank_Result_Inst.T_Tab_Poids; G : in Matrices_Pleines_Inst.T_Matrice; K : Integer; Epsilon : Long_Float) is
        I : Integer;
        Old : PageRank_Result_Inst.T_Tab_Poids;
        Norme : Long_Float :=0.0;
    begin
        I := 0;
        Old := Poids;
        while I <= K + 1 loop
            Old := Poids;
            Poids := Prochaine_Iteration(Poids, G);
            for J in 1..Poids'Length loop
                Norme := Norme+(Poids(J)-Old(J))*(Poids(J)-Old(J));
            end loop;
            if Norme <= Epsilon*Epsilon then
                exit;
            else
                null;
            end if;

            I := I + 1;
        end loop;
    end Iterer;

end PageRank_Pleine;