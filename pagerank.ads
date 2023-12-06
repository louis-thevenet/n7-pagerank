--with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;



package PageRank is




    procedure Algorithme_PageRank(Alpha : in Long_Float;
                                    K : in Integer;
                                    Epsilon : in Long_Float;
                                    Pleine : in Boolean;
                                    Prefixe : in String;
                                    Fichier_Nom : in String);

--  private
--      type T_Tab_Poids is array (1..Capacite) of Long_Float;
--      type T_Tab_Indices is array (1..Capacite) of Integer;

--      type T_Resultat is record
--          Poids : T_Tab_Poids;
--          Indices : T_Tab_Indices;
--      end record;



end PageRank;