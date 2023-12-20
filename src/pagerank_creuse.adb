with PageRank_Result;

package body PageRank_Creuse is
    procedure Calculer_S(H : in out T_Matrice; Taille : Integer) is
    Est_nul : Boolean;
    begin
        for I in 1..Taille loop
            Est_nul := true;
            for J in 1..Taille loop
                Est_Nul := Est_Nul and then (Element(H,I,J) < 0.00001);
            end loop;
            if Est_nul then
                for J in 1..Taille loop
                    Modifier(H,I,J,1.0/Long_Float(Taille));
                end loop;
            end if;
        end loop;
    end Calculer_S;

    procedure Calculer_G(S : in out T_Matrice; alpha : Long_Float; Taille : Integer) is
        --  function Traitement(V : Long_Float) return Long_Float is
        --  begin
        --      return alpha * V + (1.0 - alpha) / Long_Float(Taille);
        --  end Traitement;

        --  procedure Pour_Chaque_Element is new Pour_Chaque(Taitement);
    begin
    null;
        --Pour_Chaque_Element(S);
    end Calculer_G;

    procedure Calculer_Pi_Transpose (Resultat : in out PageRank_Result_Inst.T_Resultat; Taille : Integer) is
    begin
        for J in 1..Resultat.Taille loop
            Resultat.Poids(J) := 1.0 / Long_Float(Resultat.Taille);
        end loop;
    end Calculer_Pi_Transpose;


function Prochaine_Iteration (Poids : PageRank_Result_Inst.T_Tab_Poids; G : in T_Matrice; Taille : Integer) return PageRank_Result_Inst.T_Tab_Poids is
Tmp : Long_Float;
Resultat : PageRank_Result_Inst.T_Tab_Poids;
begin
    for J in 1..Taille loop
        Tmp := 0.0;
        for I in 1..Taille loop
            Tmp := Tmp + Element(G, I, J) * Poids(I);
        end loop;
        Resultat(J) := Tmp;
    end loop;
    return Resultat;
end Prochaine_Iteration;


procedure Iterer (Poids : in out PageRank_Result_Inst.T_Tab_Poids; G : in T_Matrice; K : Integer; Epsilon : Long_Float; Taille : Integer) is
I : Integer := 0;
old : PageRank_Result_Inst.T_Tab_Poids := Poids;
begin
    while I < K and then PageRank_Result_Inst.Norme_Au_Carre(PageRank_Result_Inst.Combi_Lineaire(1.0, Poids, -1.0, Old))>=Epsilon*Epsilon loop
        Poids := Prochaine_Iteration(Poids, G, Poids'Length);
        I := I + 1;
    end loop;
end Iterer;

end PageRank_Creuse;