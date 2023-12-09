with Matrices_Pleines;

generic
   with package Vecteurs_Pleins_Float_Inst is new Matrices_Pleines (<>);
   with package Vecteurs_Pleins_Int_Inst is new Matrices_Pleines (<>);


package Trier_Vecteur_Plein is
    -- Tri en place d'un vecteur de réels par ordre croissant et renvoi du vectur des permutations des indices
    function Trier (V : in out Vecteurs_Pleins_Float_Inst.T_Matrice) return Vecteurs_Pleins_Int_Inst.T_Matrice;

end Trier_Vecteur_Plein;