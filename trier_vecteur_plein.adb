package body Trier_Vecteur_Plein is
    function Trier (V : in out Vecteurs_Pleins_Float_Inst.T_Matrice) return Vecteurs_Pleins_Int_Inst.T_Matrice is
        Indices : Vecteurs_Pleins_Inst.T_Matrice;
        X : Long_Float;
        J : Integer;
        begin
            Vecteurs_Pleins_Inst.Initialiser (Indices);
            for I in 1..Vecteurs_Pleins_Int_Inst.Lignes_Matrice (V) loop
                X := Vecteurs_Pleins_Float_Inst.Element (V, I, 1);
                J := I;
                while J > 1 and then Vecteurs_Pleins_Float_Inst.Element (V, (J - 1),1) > X loop
                    Vecteurs_Pleins_Float_Inst.Modifier(V, J,1, Vecteurs_Pleins_Float_Inst.Element(Indices, J - 1, 1));
                    J := J - 1;
                end loop;
                Vecteurs_Pleins_Float_Inst.Modifier(V, J, 1,X);
                Vecteurs_Pleins_Int_Inst.Modifier(Indices, J, 1,I);
            end loop;
            return Indices;
    end Trier;


end Trier_Vecteur_Plein;