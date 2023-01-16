#include "shapes.inc"
#include "colors.inc"
#include "textures.inc"
#include "woods.inc"
#include "glass.inc"
#include "metals.inc"
#include "functions.inc" 
#include "stones1.inc"
#include "skies.inc"

#declare Pi = 3.1415926535897932384626;
#declare ciel=1;
#declare sca=3;

// axes
#declare Font="cyrvetic.ttf"
#declare O3=<0,0,0>;
#declare I=<1,0,0>;
#declare J=<0,1,0>;
#declare K=<0,0,1>;
#declare rCyl=0.025;
#declare rCone=0.075;

camera {
        location <4, 9, 5>
        look_at <4, 0, 1>
        sky <0, 0, 1> // pour avoir le Z en haut
        right <-image_width/image_height,0,0> // pour un repere direct
} // Fin camera

// Initialisation des lumieres
light_source {<9, 12, 7> color White}
light_source {<-3, 12, 7> color White}
light_source {<0, 0, -3> color White}

background {White}

global_settings {
        max_trace_level 60//32*3
        ambient_light 1.00
        assumed_gamma 2.0
} // Fin global_settings

#if (ciel)
    sky_sphere {S_Cloud5 rotate <90,0.051, 1>}
#end

#macro flecheDiffuseNom(G,H,Coul,alph,rCyl,rCon,diffu,text1,sca,rot,trans)
   #local H1 = G + alph* (H-G);
   union {
      union {
         cylinder {
            G, H1, rCyl
         }
         cone {
            H1, rCon
            H , 0
         }
      }
      text {
         ttf "timrom.ttf"  text1
	 0.1, 0  
         scale sca 
         rotate rot
         translate trans   
      } 
      pigment {color Coul}
      finish {diffuse diffu}
   }// fin union
#end // fin macro fleche

//sca,rot,trans
flecheDiffuseNom(O3,I,Red,0.75,rCyl,rCone,1,"X",0.35,<90,0,0>,<0.5,0,0.125>)
flecheDiffuseNom(O3,J,Green,0.75,rCyl,rCone,1,"Y",0.35,<90,0,-45>,<0.0,0.75,0.1250>)
flecheDiffuseNom(O3,K,Blue,0.75,rCyl,rCone,1,"Z",0.35,<90,0,180>,<-0.20,0.0,0.750>)

plane {
   -z 150
   pigment{
      brick rgbt<1.0,1.,1.0,0.250>, rgbt<0.750,.5,0.0,0.850>  
      mortar 5 brick_size 125   
   } // Fin pigment	
   rotate <0,0,45>
} // Fin plane

#declare hMat = 0.6;
#declare hPied = 0.6;
#declare hSom = 0.2;
#declare kMat = 0.2;
#declare xLit = 7;
#declare yLit = 3;

#declare BordMatelas = merge {
        #local P1 = <0, 0, hMat-kMat>;
        #local P2 = <1, 0, hMat-kMat>;
        #local P3 = <1, -kMat, 0>;
        cylinder {
                P1 P2 kMat
        } // Fin cylinder
        box {
                P1 P3
        } // Fin box
} // Fin merge

#declare CoinMatelas = merge {
        #local C1 = <0, 0, 0>;
        #local C2 = <0, 0, hMat-kMat>;
        cylinder {
                C1 C2 kMat
        } // Fin cylinder
        sphere {
                C2 kMat
        } // Fin sphere
} // Fin merge

#declare Matelas = merge {
        #local M1 = <kMat, kMat, 0>;
        #local M2 = <xLit-kMat, kMat, 0>;
        #local M3 = <xLit-kMat, yLit-kMat, 0>;
        #local M4 = <kMat, yLit-kMat, 0>;
        box {
                M1 <M3.x, M3.y, hMat>
        } // Fin box
        merge {
                merge { // Bords
                        merge {
                                object {
                                        BordMatelas
                                        scale <M2.x-M1.x, 1, 1>
                                        translate M1
                                } // Fin object
                                object {
                                        BordMatelas
                                        scale <M3.y-M2.y, 1, 1>
                                        rotate <0, 0, 90>
                                        translate M2
                                } // Fin object
                        } // Fin merge
                        merge {
                                object {
                                        BordMatelas
                                        scale <M4.x-M3.x, 1, 1>
                                        rotate <0, 0, 180>
                                        translate M4
                                } // Fin object
                                object {
                                        BordMatelas
                                        scale <M4.y-M1.y, 1, 1>
                                        rotate <0, 0, 270>
                                        translate M4
                                } // Fin object
                        } // Fin merge
                } // Fin merge
                merge { // Coins
                        merge { // Coins 1 & 2
                                object {
                                        CoinMatelas
                                        translate M1
                                } // Fin object
                                object {
                                        CoinMatelas
                                        translate M2
                                } // Fin object
                        } // Fin merge
                        merge { // Coins 3 & 4
                                object {
                                        CoinMatelas
                                        translate M3
                                } // Fin object
                                object {
                                        CoinMatelas
                                        translate M4
                                } // Fin object
                        } // Fin merge
                } // Fin merge
        } // Fin merge
        pigment {color Red}
} // Fin merge  

#declare PiedLit = merge {
        #local G = <0, 0.4, 0>;
        lathe {
                bezier_spline 4
                <0, 0>
                <0.2, 0.1>
                <0.2, 0.2>
                <0.2, G.y>
        } // Fin lathe
        cylinder {
                G <G.x, G.y+0.2, 0> 0.2
        } // Fin cylinder
        rotate <90, 0, 0>
} // Fin merge

#declare Lit = merge {
        merge {
                object {
                        Matelas
                        translate <0, 0, hSom>
                } // Fin object
                box {
                        <0, 0, 0> <xLit, yLit, hSom>
                        pigment {color Brown}
                } // Fin box
                translate <0, 0, hPied>
        } // Fin merge
        merge {
                #local i = 0.5;
                merge {
                        object {
                                PiedLit
                                translate <i, i, 0>
                        } // Fin object
                        object {
                                PiedLit
                                translate <xLit-i, i, 0>
                        } // Fin object
                } // Fin merge
                merge {
                        object {
                                PiedLit
                                translate <xLit-i, yLit-i, 0>
                        } // Fin object
                        object {
                                PiedLit
                                translate <i, yLit-i, 0>
                        } // Fin object
                } // Fin merge
                pigment {color Brown}
        } // Fin merge
} // Fin merge

Lit

#macro Saut1 (time)
        #local X = pi * time;
        (sin(X))
#end 
#macro Saut2 (time)
        #if (time > 1)
                #local X = pi * (time - 1) - 1;
                #else
                        #local X = pi * time - 1;
        #end
        (1.6*sin(X+1))
#end  
#macro Saut3 (time)
        #if (time > 1)
                #local X = pi * (time - 1) - 2;
                #else
                        #local X = pi * time - 2;
        #end
        (0.8*sin(X+2))
#end        

#declare Singe = sphere {
        <0, 0, 0> 0.5
} // Fin Singe

object {
        Singe
        translate <1, 1, 1.9+Saut1(clock)>
} // Fin object
object {
        Singe
        translate <3, 1, 1.9+Saut2(clock+0.3)>
} // Fin object  
object {
        Singe
        translate <5, 2, 1.9+Saut3(clock+0.6)>
} // Fin object